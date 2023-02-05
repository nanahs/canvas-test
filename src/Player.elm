module Player exposing (Player, init, name, stats, trainSkill)

import Data.Skill as Skill exposing (Skill)
import Stat exposing (Stat)


type Player
    = Player Internals


type alias Internals =
    { name : String
    , stats : List Stat

    -- , equipment : List Equipment
    }


init : Player
init =
    Player
        { name = "Hero"
        , stats =
            [ Stat.init Skill.Hp
            , Stat.init Skill.Str
            , Stat.init Skill.Dex
            , Stat.init Skill.Magic
            , Stat.init Skill.Archery
            ]
        }


name : Player -> String
name (Player player) =
    player.name


stats : Player -> List Stat
stats (Player player) =
    player.stats



-- ACTIONS


trainSkill : Player -> Skill -> Player
trainSkill (Player player) skill =
    Player
        { player
            | stats =
                player.stats
                    |> List.map
                        (\stat ->
                            if Stat.skill stat == skill then
                                Stat.train stat

                            else
                                stat
                        )
        }
