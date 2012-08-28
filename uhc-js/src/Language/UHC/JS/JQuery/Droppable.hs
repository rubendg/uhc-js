module Language.UHC.JS.JQuery.Droppable where

import Language.UHC.JS.Prelude
import Language.UHC.JS.ECMA.Bool

import Language.UHC.JS.Primitives
import Language.UHC.JS.Types
import Language.UHC.JS.JQuery.JQuery

data Droppable = Droppable { hoverClass :: JSString,
                             drop       :: JUIEventHandler}

data JSDroppablePtr
type JSDroppable = JSPtr JSDroppablePtr

droppable :: JQuery -> Droppable -> IO ()
droppable jq drop =
  do jsdrop <- mkJSDroppable drop
     _droppable jq jsdrop
      
foreign import js "{}"
  mkJSDroppable :: Droppable -> IO JSDroppable

foreign import js "%1.droppable(%2)"
  _droppable :: JQuery -> JSDroppable -> IO ()