module SpecHelpers where

import Control.Monad
import Data.Pool
import Database.PostgreSQL.Entity.DBT
import Database.PostgreSQL.Simple (Connection, close)
import Database.PostgreSQL.Simple.Migration
import Flora.Model.User
import Flora.UserFixtures

migrate :: Connection -> IO ()
migrate conn = do
  void $ runMigrations conn defaultOptions [MigrationInitialization, MigrationDirectory "./migrations"]
  pool <- createPool (pure conn) close 1 10 1
  withPool pool $ do
    insertUser hackageUser
    -- void $ importCabal (hackageUser ^. #userId) (Namespace "haskell") (PackageName "ghc-prim") "./test/fixtures/Cabal/"
    -- void $ importCabal (hackageUser ^. #userId) (Namespace "haskell") (PackageName "ghc-bignum") "./test/fixtures/Cabal/"
    -- void $ importCabal (hackageUser ^. #userId) (Namespace "haskell") (PackageName "base") "./test/fixtures/Cabal/"
    -- void $ importCabal (hackageUser ^. #userId) (Namespace "haskell") (PackageName "binary") "./test/fixtures/Cabal/"
