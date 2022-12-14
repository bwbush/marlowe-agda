
module Marlowe.Language.State where


open import Agda.Builtin.Int using (Int)
open import Data.Bool using (Bool; _∧_)
open import Marlowe.Language.Contract using (AccountId; ChoiceId; Token; ValueId; _eqAccountId_; _eqChoiceId_; _eqToken_; _eqValueId_)
open import Primitives using (Map; emptyMap; Pair; PosixTime; pair)


Accounts : Set
Accounts = Map (Pair AccountId Token) Int


_eqAccountIdToken_ : Pair AccountId Token → Pair AccountId Token → Bool
_eqAccountIdToken_ (pair account token) (pair account' token') = account eqAccountId account' ∧ token eqToken token'


record State : Set where
  constructor mkState
  field
    accounts : Accounts
    choices : Map ChoiceId Int
    boundValues : Map ValueId Int
    minTime : PosixTime


emptyState : PosixTime → State
emptyState =
  mkState
    (emptyMap _eqAccountIdToken_)
    (emptyMap _eqChoiceId_)
    (emptyMap _eqValueId_)


TimeInterval : Set
TimeInterval = Pair PosixTime PosixTime


record Environment : Set where
  constructor mkEnvironment
  field
    timeInterval : TimeInterval
