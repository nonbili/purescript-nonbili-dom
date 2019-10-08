module Nonbili.DOM
  ( copyToClipboard
  , fitInputWidth
  , fitTextareaHeight
  , innerHTML
  , setInnerHTML
  , innerText
  , setInnerText
  ) where

import Prelude

import Effect (Effect)
import Web.DOM.Element (Element)
import Web.DOM.Element as Element
import Web.HTML.HTMLElement (HTMLElement)
import Web.HTML.HTMLElement as HTMLElement

-- | Copy a string to clipbard.
foreign import copyToClipboard :: String -> Effect Unit

-- | Get rendered text content of an element.
foreign import innerText :: HTMLElement -> Effect String

-- | Set rendered text content of an element.
foreign import setInnerText :: HTMLElement -> String -> Effect Unit

-- | Get inner HTML of an element.
foreign import innerHTML :: Element -> Effect String

-- | Set inner HTML of an element.
foreign import setInnerHTML :: Element -> String -> Effect Unit

foreign import setStyleWidth :: HTMLElement -> Number -> Effect Unit

foreign import setStyleHeight :: HTMLElement -> Number -> Effect Unit

-- | Fit <input> width to its content width without showing scrollbar.
fitInputWidth :: HTMLElement -> Number -> Effect Unit
fitInputWidth el minWidth = do
  setStyleWidth el 0.0
  borderAndPaddingWidth <- HTMLElement.offsetWidth el
  scrollWidth <- Element.scrollWidth $ HTMLElement.toElement el
  setStyleWidth el $ max (borderAndPaddingWidth + scrollWidth) minWidth

-- | Fit <textarea> height to content height without showing scrollbar.
fitTextareaHeight :: HTMLElement -> Number -> Effect Unit
fitTextareaHeight el minHeight = do
  setStyleHeight el 0.0
  borderAndPaddingHeight <- HTMLElement.offsetHeight el
  scrollHeight <- Element.scrollHeight $ HTMLElement.toElement el
  setStyleHeight el $ max (borderAndPaddingHeight + scrollHeight) minHeight
