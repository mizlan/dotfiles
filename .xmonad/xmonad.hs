import XMonad

myTerminal = "kitty"
myModMask = mod4Mask
myNormalBorderColor = "#e3e3e3"
myFocusedBorderColor = "#ff00ff"
myFocusFollowsMouse = False
myBorderWidth = 3

main = xmonad defaultConfig
       { terminal = myTerminal
       , modMask = myModMask
       , normalBorderColor = myNormalBorderColor
       , focusedBorderColor = myFocusedBorderColor
       , focusFollowsMouse = myFocusFollowsMouse
       , borderWidth = myBorderWidth
       }
