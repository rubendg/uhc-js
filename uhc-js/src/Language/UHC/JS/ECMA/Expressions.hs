module Language.UHC.JS.ECMA.Expressions where

import Language.UHC.JS.ECMA.String
import Language.UHC.JS.Types
import Language.UHC.JS.Primitives

typeof :: a -> String
typeof = fromJS . _typeof

foreign import js "typeof(%*)"
  _typeof :: a -> JSString
