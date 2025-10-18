{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module User where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

import Country

data User = User {id :: Int, name :: String, location :: Country} deriving (Show, Generic, FromJSON, ToJSON)