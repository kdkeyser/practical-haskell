{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Concurrent (threadDelay)
import Data.IORef (atomicModifyIORef', newIORef)
import User qualified
import UserCreate qualified
import Web.Scotty
import Data.Text.Lazy (pack)

main :: IO ()
main = do
  userIdCounter <- newIORef 0
  let nextIdCounter = atomicModifyIORef' userIdCounter (\i -> (i + 1, i))

  scotty 3000 $ do

    -- Endpoint to create a new user, accepting JSON data
    -- Responds with the created user in JSON format 
    post "/user" $ do
      userCreate :: UserCreate.UserCreate <- jsonData
      nextId <- liftIO nextIdCounter
      let user = User.User {User.id = nextId, User.name = UserCreate.name userCreate, User.location = UserCreate.location userCreate}
      json user

    -- Endpoint that responds as quickly as possible
    get "/fast" $ do
      html "<h1>We responded ASAP</h1>"

    -- Endpoint that simulates a slow response with a configurable response time
    get "/slow/:delay" $ do
      delay :: Int <- pathParam "delay"
      liftIO $ threadDelay (delay * 1000) -- Convert to microseconds
      html $ mconcat ["<h1>This response was delayed by ", pack (show delay), " ms</h1>"]