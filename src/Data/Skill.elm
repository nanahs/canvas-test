module Data.Skill exposing (Skill(..), toString)


type Skill
    = Hp
    | Str
    | Dex
    | Magic
    | Archery


toString : Skill -> String
toString skill =
    case skill of
        Hp ->
            "Hp"

        Str ->
            "Str"

        Dex ->
            "Dex"

        Magic ->
            "Magic"

        Archery ->
            "Archery"
