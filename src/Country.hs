{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Country where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

data Country = Belgium | France | USA | Canada deriving (Show, Generic, FromJSON, ToJSON)
