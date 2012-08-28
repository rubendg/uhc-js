module Language.UHC.JS.Backbone.Utility where

import Language.UHC.JS.Primitives
import Language.UHC.JS.Types

data BackbonePtr
type Backbone = JSPtr BackbonePtr

foreign import js "Backbone.noConflict()"
  noConflict :: Backbone
