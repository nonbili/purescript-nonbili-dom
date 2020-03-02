# purescript-nonbili-dom

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/nonbili/purescript-nonbili-dom)](https://github.com/nonbili/purescript-nonbili-dom/releases)
[![purescript-nonbili-dom on Pursuit](https://pursuit.purescript.org/packages/purescript-nonbili-dom/badge)](https://pursuit.purescript.org/packages/purescript-nonbili-dom)
[![CircleCI](https://circleci.com/gh/nonbili/purescript-nonbili-dom.svg?style=svg)](https://circleci.com/gh/nonbili/purescript-nonbili-dom)

Some helpful DOM functions.

```purescript
-- | Copy a string to clipbard.
copyToClipboard :: String -> Effect Unit

-- | Fit <input> width to its content width without showing scrollbar.
fitInputWidth :: HTMLElement.HTMLElement -> Number -> Effect Unit

-- | Fit <textarea> height to content height without showing scrollbar.
fitTextareaHeight :: HTMLElement.HTMLElement -> Number -> Effect Unit

-- | Get inner HTML of an element.
innerHTML :: Element -> Effect String

-- | Set inner HTML of an element.
setInnerHTML :: Element -> String -> Effect Unit

-- | Get rendered text content of an element.
innerText :: HTMLElement -> Effect String

-- | Set rendered text content of an element.
setInnerText :: HTMLElement -> String -> Effect Unit
```
