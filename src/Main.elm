module Main exposing (Msg(..), main)

import Browser
import Data.Skill as Skill exposing (Skill)
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Player exposing (Player)
import Stat exposing (Stat)


type alias Model =
    { player : Player
    }


init : ( Model, Cmd Msg )
init =
    ( { player = Player.init
      }
    , Cmd.none
    )


type Msg
    = TrainSkill Skill


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TrainSkill skill ->
            ( { model
                | player =
                    Player.trainSkill model.player skill
              }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    let
        playerStats =
            model.player
                |> Player.stats
    in
    Html.div [ Attributes.class "flex flex-col items-center" ]
        [ Html.h1 [ Attributes.class "text-4xl font-bold text-blue-500" ] [ Html.text "Skill Grinder" ]
        , viewTraining playerStats
        ]


viewTraining : List Stat -> Html Msg
viewTraining stats =
    Html.div [ Attributes.class "flex flex-col w-96" ] <|
        List.map viewStat stats


viewStat : Stat -> Html Msg
viewStat stat =
    let
        skill =
            Stat.skill stat
    in
    Html.div [ Attributes.class "flex space-x-2 justify-between" ]
        [ Html.div [ Attributes.class "font-bold" ] [ Html.text <| Skill.toString skill ++ ":" ]
        , Html.div [ Attributes.class "flex flex-col" ]
            [ Html.div [] [ Html.text "Level: ", Html.span [] [ Html.text (String.fromInt (Stat.currentLevel stat)) ] ]
            , Html.div [] [ Html.text "Current EXP: ", Html.span [] [ Html.text (String.fromInt (Stat.currentExp stat)) ] ]
            , Html.div [] [ Html.text "Remaining EXP: ", Html.span [] [ Html.text (String.fromInt (Stat.remainingExp stat)) ] ]
            ]
        , viewTrainSkill skill
        ]


viewTrainSkill : Skill -> Html Msg
viewTrainSkill skill =
    Html.button
        [ Events.onClick (TrainSkill skill)
        , Attributes.class "py-2 px-4 bg-slate-300 rounded-md"
        ]
        [ Html.text (Skill.toString skill) ]


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> init
        , update = update
        , view =
            \model ->
                { title = "Skill Grinder"
                , body = [ view model ]
                }
        , subscriptions = \_ -> Sub.none
        }
