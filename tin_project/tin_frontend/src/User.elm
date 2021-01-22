module User exposing (..)

import Html exposing (Html, text)
type alias Model = {}

type alias UserData = { name :String
                      , surname : String
                      , email : String
                      }
type Msg
    = GetAllUsers
    | GetUserByName String
    | GetUserById Int
    | DeleteUser Int
    | AddUser UserData
    | UpdateUser (Int ,UserData)


view : Model -> Html Msg
view _ =
    text "Hi"


init : () -> (Model, Cmd Msg)
init _ =
    ({}, Cmd.none)