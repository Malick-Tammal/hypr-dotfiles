-----------------------------------------------------------
--  HACK: Keyboard key codes
-----------------------------------------------------------

local M = {}

-----------------------------------------------------------
--  INFO: MODIFIERS & SPECIAL KEYS
-----------------------------------------------------------
M.CAPSLOCK = "code:66"
M.NUMLOCK = "code:77"
M.SCROLLLOCK = "code:78"

-----------------------------------------------------------
--  INFO: FUNCTION KEYS
-----------------------------------------------------------
M.F1 = "code:67"
M.F2 = "code:68"
M.F3 = "code:69"
M.F4 = "code:70"
M.F5 = "code:71"
M.F6 = "code:72"
M.F7 = "code:73"
M.F8 = "code:74"
M.F9 = "code:75"
M.F10 = "code:76"
M.F11 = "code:95"
M.F12 = "code:96"

-----------------------------------------------------------
--  INFO: ALPHABET (A-Z)
-----------------------------------------------------------
M.A = "code:38"
M.B = "code:56"
M.C = "code:54"
M.D = "code:40"
M.E = "code:26"
M.F = "code:41"
M.G = "code:42"
M.H = "code:43"
M.I = "code:31"
M.J = "code:44"
M.K = "code:45"
M.L = "code:46"
M.M = "code:58"
M.N = "code:57"
M.O = "code:32"
M.P = "code:33"
M.Q = "code:24"
M.R = "code:27"
M.S = "code:39"
M.T = "code:28"
M.U = "code:30"
M.V = "code:55"
M.W = "code:25"
M.X = "code:53"
M.Y = "code:29"
M.Z = "code:52"

-----------------------------------------------------------
--  INFO: NUMBERS (Top)
-----------------------------------------------------------
M.NUM_1 = "code:10"
M.NUM_2 = "code:11"
M.NUM_3 = "code:12"
M.NUM_4 = "code:13"
M.NUM_5 = "code:14"
M.NUM_6 = "code:15"
M.NUM_7 = "code:16"
M.NUM_8 = "code:17"
M.NUM_9 = "code:18"
M.NUM_0 = "code:19"

-----------------------------------------------------------
--  INFO: NAVIGATION & EDITING
-----------------------------------------------------------
M.ENTER = "code:36"
M.SPACE = "code:65"
M.ESCAPE = "code:9"
M.BACKSPACE = "code:22"
M.TAB = "code:23"
M.INSERT = "code:118"
M.DELETE = "code:119"
M.RETURN = "code:36"
M.HOME = "code:110"
M.END = "code:115"
M.PAGE_UP = "code:112"
M.PAGE_DOWN = "code:117"
M.GRAVE = "code:49"

-----------------------------------------------------------
--  INFO: ARROW KEYS
-----------------------------------------------------------
M.UP = "code:111"
M.DOWN = "code:116"
M.LEFT = "code:113"
M.RIGHT = "code:114"

-----------------------------------------------------------
--  INFO: PUNCTUATION & SYMBOLS
-----------------------------------------------------------
M.MINUS = "code:20" -- -
M.EQUAL = "code:21" -- =
M.BRACKET_L = "code:34" -- [
M.BRACKET_R = "code:35" -- ]
M.SEMICOLON = "code:47" -- ;
M.QUOTE = "code:48" -- '
M.BACKQUOTE = "code:49" -- `
M.BACKSLASH = "code:51" -- \
M.COMMA = "code:59" -- ,
M.PERIOD = "code:60" -- .
M.SLASH = "code:61" -- /

-----------------------------------------------------------
--  INFO: NUMERIC KEYPAD (Numpad)
-----------------------------------------------------------
M.KP_0 = "code:90"
M.KP_1 = "code:87"
M.KP_2 = "code:88"
M.KP_3 = "code:89"
M.KP_4 = "code:83"
M.KP_5 = "code:84"
M.KP_6 = "code:85"
M.KP_7 = "code:79"
M.KP_8 = "code:80"
M.KP_9 = "code:81"
M.KP_DIVIDE = "code:106" -- /
M.KP_MULTIPLY = "code:63" -- *
M.KP_SUBTRACT = "code:82" -- -
M.KP_ADD = "code:86" -- +
M.KP_DECIMAL = "code:91" -- .
M.KP_ENTER = "code:104"

-----------------------------------------------------------
--  INFO: MULTIMEDIA & AUDIO
-----------------------------------------------------------
M.PRINTSCREEN = "code:107"
M.MIC_MUTE = "code:256"
M.MUTE = "code:121"
M.VOL_DOWN = "code:122"
M.VOL_UP = "code:123"
M.PLAY_PAUSE = "code:172"
M.STOP = "code:174"
M.PREVIOUS = "code:173"
M.NEXT = "code:171"
M.BRIGHT_DOWN = "code:232"
M.BRIGHT_UP = "code:233"

return M
