module Language.UHC.JS.Backbone.Sync where

import Language.UHC.JS.Backbone.Model
import Language.UHC.JS.Primitives
import Language.UHC.JS.ECMA.String
import Language.UHC.JS.Types

sync :: String -> BBModel a -> IO ()
sync s = _sync (toJS s)

foreign import js "Backbone.sync(%*)"
  _sync :: JSString -> BBModel a -> IO ()

sync' :: String -> BBModel a -> AnonObj -> IO ()
sync' s = _sync' (toJS s)

foreign import js "Backbone.sync(%*)"
  _sync' :: JSString -> BBModel a -> AnonObj -> IO ()

-- TODO: emulateHTTP
-- TODO: emulateJSON
