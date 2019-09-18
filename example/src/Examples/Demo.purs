module Examples.Demo where

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
  = OnValueInput

type State =
  {
  }

type Slot = ()

style :: forall r i. String -> HP.IProp ("style" :: String | r) i
style = HP.attr (HH.AttrName "style")

inputRef = H.RefLabel "input" :: H.RefLabel

render :: forall m. MonadAff m => State -> H.ComponentHTML Action Slot m
render state =
  HH.div
  []
  [ HH.input
    [ HP.ref inputRef
    , HP.placeholder "An elastic input"
    , HE.onValueInput $ Just <<< const OnValueInput
    ]
  ]

initialState :: State
initialState =
  {
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
  OnValueInput -> do
    H.getHTMLElementRef inputRef >>= traverse_ \el ->
      H.liftEffect $ NDOM.fitInputWidth el
