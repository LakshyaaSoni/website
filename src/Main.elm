module Main exposing (..)

import Data.Conference exposing (Conference)
import Data.Model exposing (Model)
import Element exposing (text)
import Html exposing (Html)
import Layout
import Navigation exposing (Location)
import PageTitle
import Pages
import Routes exposing (Route(..), parseLocation)
import Update exposing (Msg(..), update)


type alias Flags =
    { avatarUrl : String
    , conferences : List Conference
    }


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        route =
            parseLocation location
    in
    ( { avatarUrl = flags.avatarUrl
      , conferences = flags.conferences
      , route = route
      }
    , PageTitle.update route
    )


view : Model -> Html Msg
view model =
    case model.route of
        Just Home ->
            Pages.viewHome model.avatarUrl

        Just Talks ->
            Pages.viewTalks model.conferences

        Just Books ->
            Pages.viewBooks

        Nothing ->
            Layout.view
                (text "404 Not Found")


main : Program Flags Model Msg
main =
    Navigation.programWithFlags NewUrl
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
