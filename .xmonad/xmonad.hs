import Control.Monad (unless)
import Control.Applicative
import qualified Data.Map.Strict as M
import Data.List (sort,nub,intercalate)
import Data.Monoid ((<>))
import System.Directory (setCurrentDirectory, getHomeDirectory)
import System.FilePath ((</>))
import XMonad
import XMonad.StackSet as W
import XMonad.Actions.Navigation2D
import XMonad.Actions.ShowText
import XMonad.Actions.Submap
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.LayoutCombinators ((|||),JumpToLayout(..))
import XMonad.Prompt
import XMonad.Prompt.Directory (directoryPrompt)
import XMonad.Util.Loggers
import XMonad.Util.NamedWindows (getName)
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Loggers
import System.IO
import XMonad.Hooks.SetWMName
import Data.Map    (fromList)
import Data.Monoid (mappend)
import System.Process

-- xmobarConfig :: PP
-- xmobarConfig = xmobarPP {ppSep = " | "
--                         , ppOrder = \(ws:lay:t:bat:_) -> [ws,lay,bat,t]
--                         , ppExtras = [batteryCmd]
--                         }

--alert :: (Show a) => a -> X ()
--alert = dzenConfig (timeout 1 >=> onCurr ( center 100 14 ))

--alert :: (Show a) => a -> X ()
--alert = dzenConfig centered . show 
--centered =
--        onCurr (center 150 66)
--    >=> Dzen.font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*"
--    >=> addArgs ["-fg", "#073642"]
--    >=> addArgs ["-bg", "#93a1a1"] 


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/rohith/.xmobarrc"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig
        , startupHook = setWMName "LG3D"
        , logHook = dynamicLogWithPP xmobarPP
            {
                ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "grey" "" . shorten 50
            }
        , terminal = "gnome-terminal --hide-menubar"
        -- , modMaskI = mod4Mask    -- Rebind Mod to the Windows Key
        } `additionalKeys`
        [ ((mod1Mask, xK_l), windowGo R False)
         , ((mod1Mask, xK_h), windowGo L False)
         , ((mod1Mask, xK_j), windowGo D False)
         , ((mod1Mask, xK_k), windowGo U False)
         , ((mod1Mask .|. shiftMask, xK_l), windowSwap R False)
         , ((mod1Mask .|. shiftMask, xK_h), windowSwap L False)
         , ((mod1Mask .|. shiftMask, xK_j), windowSwap D False)
         , ((mod1Mask .|. shiftMask, xK_k), windowSwap U False)
         , ((mod1Mask, xK_p), spawn "dmenu_run")
         , ((mod4Mask, xK_l), spawn "slock")
         --take a screenshot of entire display 
         , ((mod1Mask , xK_Print ), spawn "scrot screen_%Y-%m-%d-%H-%M-%S.png -d 1")
         --take a screenshot of focused window 
         , ((mod1Mask .|. controlMask, xK_Print ), spawn "scrot window_%Y-%m-%d-%H-%M-%S.png -d 1-u")
         --make surface pro volume keys work
         , ((0, 0x1008ff11), do
                                spawn "amixer -c 1 sset Master 5- -M -q" >>= return)
         , ((0, 0x1008ff13), do
                                spawn "amixer -c 1 sset Master 5+ -M -q"
                                spawn "volnoti-show" >>= return)
         , ((0, 0x1008ff12), spawn "amixer -c 1 sset Speaker toggle -q" >>= return)

         , ((mod1Mask, xK_F1), spawn "xbacklight -dec 5")
         , ((mod1Mask, xK_F2), spawn "xbacklight -inc 5")
        ]
