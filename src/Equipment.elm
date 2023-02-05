module Equipment exposing (Equipment, make)

import Data.Skill as Skill exposing (Skill)
import Dict exposing (Dict)


type Equipment
    = Equipment Internals


type alias Internals =
    { name : String
    , skillModifiers : Dict Skill Int
    }


make : String -> Dict Skill Int -> Equipment
make name modifiers =
    Equipment
        { name = name
        , skillModifiers = modifiers
        }
