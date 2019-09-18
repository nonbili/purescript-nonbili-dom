module Nonbili.DOM
  ( copyToClipboard
  , fitInputWidth
  ) where

import Prelude

import Data.Int as Int
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Web.HTML.HTMLElement as HTMLElement
import Web.DOM.Element as Element

-- | Copy a string to clipbard.
foreign import copyToClipboard :: String -> Effect Unit

foreign import setStyleWidth :: HTMLElement.HTMLElement -> Int -> Effect Unit

-- | Make an <input> elastic, changing width according to content width.
fitInputWidth :: HTMLElement.HTMLElement -> Effect Unit
fitInputWidth el = do
  setStyleWidth el 0
  clientWidth <- Element.clientWidth ele
  offsetWidth <- HTMLElement.offsetWidth el
  let pd = offsetWidth - clientWidth
  width <- (fromMaybe 0 <<< Int.fromNumber <<< \x -> x + pd) <$>
    Element.scrollWidth ele
  setStyleWidth el $ max width 100
  where
  ele = HTMLElement.toElement el
