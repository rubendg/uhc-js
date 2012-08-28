module Language.UHC.JS.JSON2.JSON2 where

-- | Wrapper for json2.js, as found at http://documentcloud.github.com/backbone

import Language.UHC.JS.ECMA.Array
import Language.UHC.JS.ECMA.String
import Language.UHC.JS.Primitives
import Language.UHC.JS.Types


data JSONPtr
type JSON = JSPtr JSONPtr

stringify :: JSPtr a -> IO String
stringify = fromJSM . _stringify

foreign import js "JSON.stringify(%*)"
  _stringify :: JSPtr a -> IO JSString

stringify' :: JSArray a -> IO String
stringify' = fromJSM . _stringify'

foreign import js "JSON.stringify(%*)"
  _stringify' :: JSArray a -> IO JSString

-- TODO: All permutations for stringify

parse :: String -> IO (JSPtr a)
parse = _parse . toJS

parse' :: String -> IO () -> IO (JSPtr a)
parse' s c = _parse' (toJS s) c

foreign import js "JSON.parse(%*)"
  _parse :: JSString -> IO (JSPtr a)

foreign import js "JSON.parse(%*)"
  _parse' :: JSString -> IO () -> IO (JSPtr a)
