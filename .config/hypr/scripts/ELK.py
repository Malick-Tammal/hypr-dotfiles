#!/usr/bin/env python3

"""

        HACK: ELK-BLEDOM LED Strip Controller

    INFO: Usage:

./ELK.py on                             # Turn LED strip on
./ELK.py off                            # Turn LED strip off
./ELK.py color #ffffff                # Set color (white)
./ELK.py brightness 80                  # Set brightness (0 - 100)
./ELK.py daemon start                   # Start background daemon (persistent BLE connection)
./ELK.py daemon stop                    # Stop daemon and disconnect
./ELK.py daemon status                  # Check if daemon is running

"""

import argparse
import asyncio
import json
import os
import signal
import socket
import sys

from bleak import BleakClient, BleakScanner

#  INFO: Config ──────────────────────────────────────────────────────────────
DEFAULT_MAC = "BE:27:F9:00:97:65"
MAC_ADDRESS = os.environ.get("LED_MAC", DEFAULT_MAC)
CHAR_UUID = "0000fff3-0000-1000-8000-00805f9b34fb"
SOCKET_PATH = f"/tmp/led_daemon_{MAC_ADDRESS.replace(':', '')}.sock"
PID_PATH = f"/tmp/led_daemon_{MAC_ADDRESS.replace(':', '')}.pid"
RECONNECT_DELAY = 3
SCAN_TIMEOUT = 10.0

#  TIP: Gamma correction
GAMMA = 2.2
GAMMA_TABLE = [int(pow(i / 255.0, GAMMA) * 255 + 0.5) for i in range(256)]


def gamma_correct(value):
    return GAMMA_TABLE[value]


def cmd_power_on():
    return bytes([0x7E, 0x00, 0x04, 0x01, 0x00, 0x00, 0x00, 0x00, 0xEF])


def cmd_power_off():
    return bytes([0x7E, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF])


def cmd_color(r, g, b):
    # Apply gamma correction then swap R/G for this strip's channel order
    r, g, b = gamma_correct(r), gamma_correct(g), gamma_correct(b)
    return bytes([0x7E, 0x00, 0x05, 0x03, g, r, b, 0x00, 0xEF])


def cmd_brightness(level):
    level = max(0, min(100, level))
    return bytes([0x7E, 0x00, 0x01, level, 0x00, 0x00, 0x00, 0x00, 0xEF])


def parse_hex_color(hex_str):
    hex_str = hex_str.lstrip("#")
    if len(hex_str) != 6:
        print(
            f"Error: invalid hex color '{hex_str}' - must be 6 hex digits (e.g. ff00aa)"
        )
        sys.exit(1)
    try:
        r = int(hex_str[0:2], 16)
        g = int(hex_str[2:4], 16)
        b = int(hex_str[4:6], 16)
        return r, g, b
    except ValueError:
        print(f"Error: invalid hex color '{hex_str}' - contains non-hex characters")
        sys.exit(1)


def build_command(args):
    if args.command == "on":
        return cmd_power_on(), "Turning LED on..."
    elif args.command == "off":
        return cmd_power_off(), "Turning LED off..."
    elif args.command == "color":
        r, g, b = parse_hex_color(args.hex)
        return cmd_color(r, g, b), f"Setting color to RGB({r}, {g}, {b})..."
    elif args.command == "brightness":
        if not 0 <= args.level <= 100:
            print("Error: brightness must be between 0 and 100")
            sys.exit(1)
        return cmd_brightness(args.level), f"Setting brightness to {args.level}%..."
    return None, None


async def send_direct(data):
    print(f"Scanning for {MAC_ADDRESS}...")
    device = await BleakScanner.find_device_by_address(
        MAC_ADDRESS, timeout=SCAN_TIMEOUT
    )
    if device is None:
        print(f"Error: device {MAC_ADDRESS} not found. Is it powered on and in range?")
        sys.exit(1)
    async with BleakClient(device) as client:
        if not client.is_connected:
            print(f"Error: failed to connect to {MAC_ADDRESS}")
            sys.exit(1)
        await client.write_gatt_char(CHAR_UUID, data, response=False)


class LedDaemon:
    def __init__(self):
        self.client = None
        self.device = None
        self.running = False

    async def connect(self):
        print(f"[daemon] Scanning for {MAC_ADDRESS}...")
        self.device = await BleakScanner.find_device_by_address(
            MAC_ADDRESS, timeout=SCAN_TIMEOUT
        )
        if self.device is None:
            print(f"[daemon] Device {MAC_ADDRESS} not found")
            return False
        self.client = BleakClient(
            self.device, disconnected_callback=self._on_disconnect
        )
        await self.client.connect()
        if self.client.is_connected:
            print(f"[daemon] Connected to {MAC_ADDRESS}")
            return True
        return False

    def _on_disconnect(self, client):
        print(f"[daemon] Disconnected from {MAC_ADDRESS}")
        if self.running:
            asyncio.get_event_loop().call_soon_threadsafe(
                asyncio.ensure_future, self._reconnect()
            )

    async def _reconnect(self):
        while self.running:
            print(f"[daemon] Reconnecting in {RECONNECT_DELAY}s...")
            await asyncio.sleep(RECONNECT_DELAY)
            try:
                if await self.connect():
                    return
            except Exception as e:
                print(f"[daemon] Reconnect failed: {e}")

    async def write(self, data):
        if self.client is None or not self.client.is_connected:
            return False, "Not connected to LED strip"
        try:
            await self.client.write_gatt_char(CHAR_UUID, data, response=False)
            return True, "OK"
        except Exception as e:
            return False, str(e)

    async def stop(self):
        self.running = False
        if self.client and self.client.is_connected:
            await self.client.disconnect()
        self.client = None
        print("[daemon] Stopped")

    async def handle_client(self, reader, writer):
        try:
            raw = await asyncio.wait_for(reader.read(1024), timeout=5.0)
            if not raw:
                writer.close()
                return
            msg = json.loads(raw.decode())
            action = msg.get("action")

            if action == "send":
                data = bytes(msg["data"])
                ok, reply = await self.write(data)
                resp = {"ok": ok, "msg": reply}
            elif action == "stop":
                resp = {"ok": True, "msg": "Stopping daemon"}
                writer.write(json.dumps(resp).encode())
                await writer.drain()
                writer.close()
                await self.stop()
                return
            elif action == "status":
                connected = self.client is not None and self.client.is_connected
                resp = {"ok": True, "msg": "connected" if connected else "disconnected"}
            else:
                resp = {"ok": False, "msg": f"Unknown action: {action}"}

            writer.write(json.dumps(resp).encode())
            await writer.drain()
        except Exception as e:
            try:
                writer.write(json.dumps({"ok": False, "msg": str(e)}).encode())
                await writer.drain()
            except Exception:
                pass
        finally:
            try:
                writer.close()
            except Exception:
                pass

    async def run(self):
        self.running = True

        if os.path.exists(SOCKET_PATH):
            os.unlink(SOCKET_PATH)

        try:
            if not await self.connect():
                print("[daemon] Initial connection failed, will keep retrying...")
                asyncio.ensure_future(self._reconnect())
        except Exception as e:
            print(f"[daemon] Initial connection error: {e}, will keep retrying...")
            asyncio.ensure_future(self._reconnect())

        server = await asyncio.start_unix_server(self.handle_client, path=SOCKET_PATH)
        os.chmod(SOCKET_PATH, 0o600)
        print(f"[daemon] Listening on {SOCKET_PATH}")

        with open(PID_PATH, "w") as f:
            f.write(str(os.getpid()))

        loop = asyncio.get_event_loop()
        for sig in (signal.SIGTERM, signal.SIGINT):
            loop.add_signal_handler(
                sig, lambda: asyncio.ensure_future(self._signal_stop(server))
            )

        async with server:
            await server.serve_forever()

    async def _signal_stop(self, server):
        server.close()
        await self.stop()
        _cleanup_files()


def _cleanup_files():
    for path in (SOCKET_PATH, PID_PATH):
        if os.path.exists(path):
            os.unlink(path)


def daemon_is_running():
    if not os.path.exists(SOCKET_PATH):
        return False
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.settimeout(1)
        s.connect(SOCKET_PATH)
        s.sendall(json.dumps({"action": "status"}).encode())
        resp = json.loads(s.recv(1024).decode())
        s.close()
        return resp.get("ok", False)
    except Exception:
        return False


def send_to_daemon(action, data=None):
    msg = {"action": action}
    if data is not None:
        msg["data"] = list(data)
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.settimeout(5)
        s.connect(SOCKET_PATH)
        s.sendall(json.dumps(msg).encode())
        resp = json.loads(s.recv(1024).decode())
        s.close()
        return resp
    except ConnectionRefusedError:
        _cleanup_files()
        return None
    except Exception:
        return None


def daemon_start():
    if daemon_is_running():
        print("Daemon is already running.")
        return

    pid = os.fork()
    if pid > 0:
        import time

        time.sleep(1)
        if daemon_is_running():
            print(f"Daemon started (pid {pid})")
        else:
            print(f"Daemon forked (pid {pid}), connecting in background...")
        return

    os.setsid()
    devnull = os.open(os.devnull, os.O_RDWR)
    os.dup2(devnull, 0)

    log_path = f"/tmp/led_daemon.log"
    log_fd = os.open(log_path, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    os.dup2(log_fd, 1)
    os.dup2(log_fd, 2)

    daemon = LedDaemon()
    try:
        asyncio.run(daemon.run())
    except Exception as e:
        print(f"[daemon] Fatal: {e}", file=sys.stderr)
    finally:
        _cleanup_files()
    os._exit(0)


def daemon_stop():
    if not daemon_is_running():
        print("Daemon is not running.")
        _cleanup_files()
        return
    resp = send_to_daemon("stop")
    if resp and resp.get("ok"):
        print("Daemon stopped.")
        import time

        time.sleep(0.5)
        _cleanup_files()
    else:
        print("Failed to stop daemon, killing...")
        if os.path.exists(PID_PATH):
            with open(PID_PATH) as f:
                pid = int(f.read().strip())
            try:
                os.kill(pid, signal.SIGTERM)
            except ProcessLookupError:
                pass
        _cleanup_files()
        print("Daemon killed.")


def daemon_status():
    if not daemon_is_running():
        print("Daemon is not running.")
        return
    resp = send_to_daemon("status")
    if resp and resp.get("ok"):
        pid = "?"
        if os.path.exists(PID_PATH):
            with open(PID_PATH) as f:
                pid = f.read().strip()
        print(f"Daemon is running (pid {pid}), BLE: {resp['msg']}")
    else:
        print("Daemon is running but not responding properly.")


def main():
    parser = argparse.ArgumentParser(
        description="ELK-BLEDOM LED strip Bluetooth controller",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "examples:\n"
            "  %(prog)s on                Turn the LED strip on\n"
            "  %(prog)s off               Turn the LED strip off\n"
            "  %(prog)s color #ff0000     Set color to red\n"
            "  %(prog)s color 00ff00      Set color to green\n"
            "  %(prog)s brightness 50     Set brightness to 50%%\n"
            "  %(prog)s daemon start      Start persistent background daemon\n"
            "  %(prog)s daemon stop       Stop the daemon\n"
            "  %(prog)s daemon status     Check daemon & BLE connection status\n"
        ),
    )
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("on", help="Turn the LED strip on")
    sub.add_parser("off", help="Turn the LED strip off")

    color_parser = sub.add_parser("color", help="Set LED color using hex code")
    color_parser.add_argument("hex", help="Hex color code (e.g. #ffffff or ff0000)")

    bright_parser = sub.add_parser("brightness", help="Set LED brightness")
    bright_parser.add_argument("level", type=int, help="Brightness level 0-100")

    daemon_parser = sub.add_parser("daemon", help="Manage background daemon")
    daemon_sub = daemon_parser.add_subparsers(dest="daemon_action", required=True)
    daemon_sub.add_parser("start", help="Start the daemon")
    daemon_sub.add_parser("stop", help="Stop the daemon")
    daemon_sub.add_parser("status", help="Check daemon status")

    args = parser.parse_args()

    if args.command == "daemon":
        if args.daemon_action == "start":
            daemon_start()
        elif args.daemon_action == "stop":
            daemon_stop()
        elif args.daemon_action == "status":
            daemon_status()
        return

    data, msg = build_command(args)
    if data is None:
        return

    print(msg)

    if daemon_is_running():
        resp = send_to_daemon("send", data)
        if resp and resp.get("ok"):
            print("Done.")
        else:
            err = resp.get("msg", "unknown error") if resp else "daemon not responding"
            print(f"Daemon error: {err}, falling back to direct connection...")
            asyncio.run(send_direct(data))
            print("Done.")
    else:
        asyncio.run(send_direct(data))
        print("Done. (tip: run './led.py daemon start' for instant commands)")


if __name__ == "__main__":
    main()
