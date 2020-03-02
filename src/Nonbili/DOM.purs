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

import Control.Apply (lift2)
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
fitInputWidth hel minWidth = do
  setStyleWidth hel 0.0
  borderWidth <- lift2 (-) (HTMLElement.offsetWidth hel) (Element.clientWidth el)
  scrollWidth <- Element.scrollWidth el
  setStyleWidth hel $ max (borderWidth + scrollWidth) minWidth
  where
  el = HTMLElement.toElement hel

-- | Fit <textarea> height to content height without showing scrollbar.
fitTextareaHeight :: HTMLElement -> Number -> Effect Unit
fitTextareaHeight hel minHeight = do
  setStyleHeight hel 0.0
  borderHeight <- lift2 (-)
    (HTMLElement.offsetHeight hel) (Element.clientHeight el)
  scrollHeight <- Element.scrollHeight $ HTMLElement.toElement hel
  setStyleHeight hel $ max (borderHeight + scrollHeight) minHeight
  where
  el = HTMLElement.toElement hel
