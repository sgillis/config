import XMonad
import XMonad.Util.EZConfig(additionalKeys)

main = xmonad myConfig

myConfig = defaultConfig
    { modMask = mod4Mask
    } `additionalKeys`
    [ ((mod4Mask, xK_x), spawn "dmenu_run")
    ]
