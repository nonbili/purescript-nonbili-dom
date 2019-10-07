module Main (main) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(Tuple))
import Effect (Effect)
import Effect.Aff.Class (class MonadAff)
import Example.Demo as ExpDemo
import Foreign.Object as Object
import Halogen.Aff as HA
import Halogen.Storybook (Stories, runStorybook, proxy)

stories :: forall m. MonadAff m => Stories m
stories = Object.fromFoldable
  [ Tuple "Demo" $ proxy ExpDemo.component
  ]

main :: Effect Unit
main = do
  HA.runHalogenAff do
    body <- HA.awaitBody
    runStorybook
      { stories: stories
      , logo: Nothing
      } body
