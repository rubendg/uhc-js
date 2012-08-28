-- | Binding for the jquery-ajaxq library by Oleg Podolsky.
--   It can be found at: http://code.google.com/p/jquery-ajaxq/
module Language.UHC.JS.JQuery.AjaxQueue (ajaxQ) where

import Language.UHC.JS.Primitives
import Language.UHC.JS.Types

import Language.UHC.JS.ECMA.String
import Language.UHC.JS.JQuery.Ajax

import Language.UHC.JS.Assorted (alert, _alert)
  
-- | Partial application of the backend for use with the AjaxQueue library  
ajaxQ  :: (JS r, JS v)  => String -> AjaxOptions a -> v -> AjaxCallback r -> AjaxCallback r -> IO ()
ajaxQ queuename = ajaxBackend (_ajaxQ $ toJS queuename)
  
foreign import js "$.ajaxq(%*)"
  _ajaxQ :: JSString -> JSPtr a -> IO ()