import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.DynamicLog

main = xmonad =<< dzen myConfig

myConfig = defaultConfig
    { modMask = mod4Mask
    } `additionalKeys`
    [ ((mod4Mask, xK_x), spawn "dmenu_run")
    ]
