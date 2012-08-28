module Language.UHC.JS.Assorted where

import Language.UHC.JS.ECMA.String
import Language.UHC.JS.Types
import Language.UHC.JS.Primitives

alert :: String -> IO ()
alert = _alert . toJS

foreign import js "alert(%*)"
  _alert :: JSString -> IO ()
