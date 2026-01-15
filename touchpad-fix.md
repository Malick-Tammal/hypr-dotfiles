## 💻 Hardware Specifics (Dell Latitude 5400)

**Touchpad Fix:**
To prevent the touchpad from lagging/grabbing due to aggressive power saving, add the following kernel parameter to GRUB:

1. Edit `/etc/default/grub`:
   Add `i2c_designware_core.dynamic_suspend=0` to `GRUB_CMDLINE_LINUX_DEFAULT`.

2. Update GRUB:
   `sudo grub-mkconfig -o /boot/grub/grub.cfg`
