{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module UserCreate where

import Country
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

data UserCreate = UserCreate {name :: String, location :: Country} deriving (Show, Generic, FromJSON, ToJSON)
