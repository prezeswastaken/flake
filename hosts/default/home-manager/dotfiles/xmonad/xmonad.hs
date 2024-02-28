import qualified Data.Map                      as M
import           Data.Monoid
import           System.Exit
import           System.IO
import           XMonad
import           XMonad
import           XMonad.Actions.CycleWS
import           XMonad.Actions.WorkspaceNames
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Layout.MultiColumns
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Reflect          ( reflectHoriz )
import           XMonad.Layout.Spacing
import           XMonad.Layout.Spiral
import qualified XMonad.StackSet               as W
import           XMonad.Util.Loggers
import           XMonad.Util.Run

main = do
  xmobarProc <- spawnPipe "xmobar"
  xmonad $ docks $ myConfig $ xmobarProc

myConfig xmobarProc = def { modMask            = myModMask
                          , borderWidth        = myBorderWidth
                          , normalBorderColor  = myNormalBorderColor
                          , focusedBorderColor = myFocusedBorderColor
                          , layoutHook         = myLayout
                          , focusFollowsMouse  = myFocusFollowsMouse
                          , startupHook        = myStartupHook
                          , manageHook         = myManageHooks
                          , logHook            = myLogHook xmobarProc

    -- keybindings
                          , keys               = myKeys
                          }

------------------------------------------------------------------------
-- Simple stuff
--
myTerminalLaunchCommand = "kitty --directory ~"
myModMask = mod4Mask -- Win key or Super_L
myBorderWidth = 10
myNormalBorderColor = "#1D1E30"
myFocusedBorderColor = "#8bd5ca"
myFocusFollowsMouse = False

------------------------------------------------------------------------
-- Layout config
--
myLayout = lessBorders
  Screen
  (avoidStruts
    ( smartBorders
    $ reflectHoriz
    $ spacingRaw True
                 (Border 0 0 0 0)
                 True
                 (Border margin margin margin margin)
                 True
    $ (tiled ||| Full -- ||| multiCol [1] 1 0.01 (-0.5)
                     )
    )
  )
 where
    -- Set margin for windows if there is more than one on screen
  margin  = 30
  -- default tiling algorithm partitions the screen into two panes
  tiled   = Tall nmaster delta ratio

  -- The default number of windows in the master pane
  nmaster = 1

  -- Default proportion of screen occupied by master pane
  ratio   = 1 / 2

  -- Percent of screen to increment by when resizing panes
  delta   = 3 / 100

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig { XMonad.modMask = modm }) =
  M.fromList
    $

    -- launch a terminal
       [ ((modm, xK_Return), spawn myTerminalLaunchCommand)

    -- launch dmenu
       , ((modm, xK_p), spawn "/usr/bin/env rofi -show run")

    -- close focused window
       , ((modm, xK_w)     , kill)

    -- Restart xmonad
       , ( (modm .|. shiftMask, xK_r)
         , spawn "xmonad --recompile; xmonad --restart"
         )

     -- Rotate through the available layout algorithms
       , ((modm, xK_e), sendMessage NextLayout)

    -- Move focus to the next window
       , ((modm, xK_h), windows W.focusDown)

    -- Move focus to the previous window
       , ((modm, xK_l), windows W.focusUp)

    --  Reset the layouts on the current workspace to default
       , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

    -- Quit xmonad
       , ((modm .|. shiftMask, xK_p), io (exitWith ExitSuccess))

    -- Jump to last used workspace
       , ((modm, xK_space), toggleWS)

    -- Launch rofi
       , ((modm, xK_d), spawn "~/.config/rofi/launchers/type-1/launcher.sh")

    -- Make a screenshot
       , ((modm .|. shiftMask, xK_s), spawn "gscreenshot")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
       , ((modm, xK_f), sendMessage ToggleStruts)

    -- Rename workspace with keybinding
       , ((modm .|. shiftMask, xK_g), renameWorkspace def)
       ]
    ++

-- Keybindings for workspaces
       [ ((m .|. modm, k), windows $ f i)
       | (i, k) <- zip (XMonad.workspaces conf) workspaceKeys
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
       [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
       | (key, sc) <- zip [xK_k, xK_j] [0 ..]
       , (f  , m ) <- [(W.view, 0), (W.shift, shiftMask)]
       ]

workspaceKeys =
  [xK_y, xK_u, xK_i, xK_o, xK_n, xK_m, xK_comma, 0x2e, xK_t, xK_g]

------------------------------------------------------------------------
-- Startup hook
--
myStartupHook = do
  spawn "feh --bg-fill ~/Pictures/walls/1.jpg"
  spawn "xrandr -s 1920x1080"
  spawn "picom"
  spawn "xset r rate 150 30"
  --spawn
   -- "sleep 1 && trayer --monitor primary --SetDockType true --SetPartialStrut true --padding 20 --align right --edge top --width 5 --distancefrom top --distance 15 --widthtype request --alpha 0 -l"
  --spawn "nm-applet"
  spawn
    "exec dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &"
  --spawn "xscreensaver --no-splash"

------------------------------------------------------------------------
-- Manage hooks
--
myManageHooks =
  composeAll
-- Allows focusing other monitors without killing the fullscreen
             --[isFullscreen --> (doF W.focusDown <+> doFullFloat)]
             [isFullscreen --> doFullFloat]

------------------------------------------------------------------------
-- Log hook
--
myLogHook h =
  workspaceNamesPP xmobarPP { ppLayout        = const ""
  -- , ppSort = getSortByXineramaRule  -- Sort left/right screens on the left, non-empty workspaces after those
                            , ppHidden        = wrap "<fc=#b8c0e0>" "</fc>"
                            , ppTitleSanitize = const ""  -- Also about window's title
                            , ppVisible       = wrap "<fc=#6e738d>" "</fc>"  -- Non-focused (but still visible) screen
                            , ppCurrent       = wrap "<fc=#8aadf4>" "</fc>"-- Non-focused (but still visible) screen
                            , ppOutput        = hPutStrLn h
                            }
    >>= dynamicLogWithPP

