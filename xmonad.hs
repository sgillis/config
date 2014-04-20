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
        , workspaces = ["1:web", "2:dev", "3", "4", "5", "6", "7", "8", "9"]
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = \_ -> ""  -- Don't show title
                        , ppLayout = \_ -> ""  -- Don't show layout information
                        , ppHiddenNoWindows = id  -- Show hidden empty workspaces
                        }
        } `additionalKeys`
        [ ((mod4Mask, xK_x), spawn "dmenu_run")
        ]
