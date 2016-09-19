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
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Loggers
import System.IO
import XMonad.Hooks.SetWMName

-- batteryCmd :: Logger
-- batteryCmd = logCmd $ "/usr/bin/acpi | "
--              ++ "sed -r"
--              ++" 's/.*?: (.*)/\\1/;"
--              ++" s/[dD]ischarging, [0-9]+%, ([0-9]+:[0-9]+:[0-9]+) .*/\\1-/;"
--              ++" s/[cC]harging, [0-9]+%, ([0-9]+:[0-9]+:[0-9]+) .*/\\1+/;"
--              ++" s/[cC]harged, /Charged/'"
-- 
-- xmobarConfig :: PP
-- xmobarConfig = xmobarPP {ppSep = " | "
--                         , ppOrder = \(ws:lay:t:bat:_) -> [ws,lay,bat,t]
--                         , ppExtras = [batteryCmd]
--                         }


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/rprakash/.xmobarrc"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig
        , startupHook = setWMName "LG3D"
        , logHook = dynamicLogWithPP xmobarPP
            {
                ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , terminal = "xterm"
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
        ]
