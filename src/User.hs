{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module User where

import Country
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

data User = User {id :: Int, name :: String, location :: Country} deriving (Show, Generic, FromJSON, ToJSON)