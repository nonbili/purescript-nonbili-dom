module Example.Demo where

import Prelude

import Data.Const (Const)
import Data.Foldable (traverse_)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Nonbili.DOM as NDOM

type Query = Const Void

data Action
  = OnValueInput String
  | OnValueInputTextarea
  | OnClickCopy

type State =
  { value :: String
  }

type Slot = ()

style :: forall r i. String -> HP.IProp ("style" :: String | r) i
style = HP.attr (HH.AttrName "style")

inputRef = H.RefLabel "input" :: H.RefLabel

textareaRef = H.RefLabel "textarea" :: H.RefLabel

render :: forall m. MonadAff m => State -> H.ComponentHTML Action Slot m
render state =
  HH.div
  []
  [ HH.h3_
    [ HH.text "Input width will grow as you keep typing"]
  , HH.div_
    [ HH.input
      [ HP.ref inputRef
      , HP.placeholder "An elastic input"
      , HE.onValueInput $ Just <<< OnValueInput
      ]
    , HH.button
      [ HP.title "Copy to clipboard"
      , HE.onClick $ Just <<< const OnClickCopy
      ]
      [ HH.text "Copy"]
    ]
  , HH.h3_
    [ HH.text "Textarea height will grow as you keep entering new line"]
  , HH.div_
    [ HH.textarea
      [ HP.ref textareaRef
      , HP.placeholder "An elastic textarea"
      , HE.onValueInput $ Just <<< const OnValueInputTextarea
      ]
    ]
  ]

initialState :: State
initialState =
  { value: ""
  }

component :: forall m. MonadAff m => H.Component HH.HTML Query Unit Void m
component = H.mkComponent
  { initialState: const initialState
  , render
  , eval: H.mkEval $ H.defaultEval
      { handleAction = handleAction }
  }

handleAction
  :: forall m
   . MonadAff m
  => Action
  -> H.HalogenM State Action Slot Void m Unit
handleAction = case _ of
  OnValueInput value -> do
    H.modify_ $ _ { value = value }
    H.getHTMLElementRef inputRef >>= traverse_ \el ->
      H.liftEffect $ NDOM.fitInputWidth el 100.0

  OnValueInputTextarea -> do
    H.getHTMLElementRef textareaRef >>= traverse_ \el ->
      H.liftEffect $ NDOM.fitTextareaHeight el 60.0

  OnClickCopy -> do
    state <- H.get
    H.liftEffect $ NDOM.copyToClipboard state.value
