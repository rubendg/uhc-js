module Language.UHC.JS.Marshal where

import Language.UHC.JS.Primitives
import Language.UHC.JS.Types
import Data.Maybe
import Control.Monad

class ToJS a b where
   toJS :: a -> b

class FromJS b a where
   fromJS :: b -> Maybe a

-- JSNull

instance ToJS a a where
  toJS = id

instance FromJS JSNull (Maybe a) where
   fromJS _ = Nothing

instance ToJS () JSUndefined where
   toJS _ = _undefined

instance FromJS JSUndefined () where
   fromJS _ = Just ()

-- JSBool

instance ToJS Bool JSBool where
   toJS = boolToJSBool

instance FromJS JSBool Bool where
   fromJS v = 
      if _primIsBool v 
         then if _primEq _true v 
               then Just True
               else Just False
         else Nothing


boolToJSBool :: Bool -> JSBool
boolToJSBool True  = _true
boolToJSBool False = _false

-- JSString

fromJS_ = fromJust. fromJS

instance Show JSString where
  show = fromJS_

instance ToJS String JSString where
   toJS = stringToJSString

instance FromJS JSString String where
   fromJS v = 
      if _primIsString v
         then Just (jsStringToString v)
         else Nothing

instance (Show a) => ToJS a JSString where
  toJS v = toJS (show v) :: JSString

jsStringToString :: JSString -> String
jsStringToString = packedStringToString . unsafeCoerce

foreign import prim "primStringToPackedString"
  stringToJSString :: String -> JSString

str :: String -> JSString
str = toJS

bl :: Bool -> JSBool
bl = toJS

liftFromJS :: (Monad m, FromJS b a) => m b -> m (Maybe a)
liftFromJS = liftM fromJS

liftFromJS_ :: (Monad m, FromJS b a) => m b -> m a
liftFromJS_ m = do
  x <- liftM fromJS m
  maybe (error "no string") return x

liftToJS :: (Monad m, ToJS a b) => m a -> m b
liftToJS = liftM toJS

mkIdxRes :: Int -> Maybe Int
mkIdxRes (-1)  = Nothing
mkIdxRes n     = Just n
