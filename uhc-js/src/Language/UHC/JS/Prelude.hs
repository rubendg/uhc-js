module Language.UHC.JS.Prelude (
    module Language.UHC.JS.Types
  , module Language.UHC.JS.Primitives
  , module Language.UHC.JS.ECMA.String

  , wrapIO
  , wrapJSPtraIO)
 where

import Language.UHC.JS.Types
import Language.UHC.JS.Primitives   
import Language.UHC.JS.ECMA.String  

foreign import js "wrapper"
  wrapIO :: IO () -> IO (JSFunPtr (IO ()))
  
foreign import js "wrapper"
  wrapJSPtraIO :: (JSPtr a -> IO ()) -> IO (JSFunPtr(JSPtr a -> IO ()))  