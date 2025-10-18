{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Concurrent (threadDelay)
import Data.IORef (atomicModifyIORef', newIORef)
import User qualified
import UserCreate qualified
import Web.Scotty

main :: IO ()
main = do
  userIdCounter <- newIORef 0
  let nextIdCounter = atomicModifyIORef' userIdCounter (\i -> (i + 1, i))

  scotty 3000 $ do
    get "/user/:id" $ do
      userId <- pathParam "id"
      html $ mconcat ["<h1>Received ID: ", userId, "</h1>"]

    post "/user" $ do
      userCreate :: UserCreate.UserCreate <- jsonData
      nextId <- liftIO nextIdCounter
      let user = User.User {User.id = nextId, User.name = UserCreate.name userCreate, User.location = UserCreate.location userCreate}
      json user

    get "/slow" $ do
      liftIO $ threadDelay 200000 -- 200 ms
      html "<h1>This response was delayed by 200 ms</h1>"