{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module UserCreate where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

import Country

data UserCreate = UserCreate {name :: String, location :: Country} deriving (Show, Generic, FromJSON, ToJSON)
