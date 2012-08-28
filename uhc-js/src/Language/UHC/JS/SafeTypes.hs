module Language.UHC.JS.SafeTypes where

import Language.UHC.JS.ECMA.String (JSString)

foreign import js "typeof(%1)"
  typeof :: a -> JSString

-- | Would like fun dep here
class FromJS a b => FromJSPlus a b where
  jsType :: a -> b -> String
  check :: a -> b -> Bool
  check a b = jsType a b == fromJS (typeof a)
  fromJSP :: a -> Maybe b
  fromJSP a = let (v::b) = fromJS a
               in if check a v then
                    Just v
                  else
                    Nothing