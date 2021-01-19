module Main exposing (..)
import Book exposing (..)
import Browser
import Html exposing (..)
import User exposing (..)
import Collection exposing (..)


type alias Model = {}
type Msg = A

init : Model
init = {}


type Page
    = UserPage User.Model
    | CollectionPage Collection.Model
    | BookPage Book.Model

pageToString : Page -> String
pageToString page =
    case page of
        UserPage _ -> "Users"

        CollectionPage _ -> "Collections"

        BookPage _ -> "Books"

view : Model -> Html Msg
view msg = viewHeader (UserPage {})


viewHeader : Page -> Html Msg
viewHeader page =
    let
        logo =
            h1 [] [ text ("Book app, currently on " ++ (pageToString page))]

        links =
            ul []
                [ li [] [ a[] [ text "Users"]]
                , li [] [ a[] [ text "Collections" ]]
                , li [] [a [] [ text "Books"]]
                ]
    in
        div [] [ logo, links]

main : Program () Model Msg
main =
    Browser.sandbox
    { init = init
--    , onUrlRequest = Debug.todo "todo"
  --  , onUrlChange = Debug.todo "todo"
 --   , subscriptions = \_ -> Sub.none
    , update = update
    , view = view
    }


update : Msg -> Model -> Model
update msg model = model
