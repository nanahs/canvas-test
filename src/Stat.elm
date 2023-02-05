module Stat exposing (Stat, currentExp, currentLevel, init, levelStartingExp, remainingExp, skill, train)

import Data.Skill exposing (Skill)


type Stat
    = Stat Internals


type alias Internals =
    { skill : Skill
    , currentExp : Int
    }


init : Skill -> Stat
init skill_ =
    Stat
        { skill = skill_
        , currentExp = levelStartingExp 1
        }


skill : Stat -> Skill
skill (Stat stat) =
    stat.skill


currentExp : Stat -> Int
currentExp (Stat stat) =
    stat.currentExp


currentLevel : Stat -> Int
currentLevel (Stat stat) =
    (stat.currentExp + 1)
        |> toFloat
        |> logBase 2
        |> truncate


remainingExp : Stat -> Int
remainingExp (Stat stat) =
    let
        nextExp =
            levelStartingExp (currentLevel (Stat stat) + 1)
    in
    nextExp - stat.currentExp



-- levelStartingExp 1 : 1
-- levelStartingExp 2 : 3
-- levelStartingExp 3 : 7
-- levelStartingExp 4 : 15
-- levelStartingExp 5 : 31


levelStartingExp : Int -> Int
levelStartingExp level =
    (2 ^ level) - 1



-- ACTIONS


train : Stat -> Stat
train (Stat stat) =
    Stat { stat | currentExp = stat.currentExp + 1 }
