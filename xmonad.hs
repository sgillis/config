import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar $HOME/.config/xmobar/xmobarrc"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = \_ -> ""  -- Don't show title
                        , ppLayout = \_ -> ""  -- Don't show layout information
                        , ppHiddenNoWindows = id  -- Show hidden empty workspaces
                        }
        , handleEventHook = docksEventHook  -- Load status bar immediately, do not wait for next focus change
        } `additionalKeys`
        [ ((mod4Mask, xK_x), spawn "dmenu_run")
        , ((mod4Mask, xK_z), sendMessage ToggleStruts)  -- Toggle status bar
        ]
