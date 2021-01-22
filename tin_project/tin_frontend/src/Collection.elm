module Collection exposing (..)

import Html exposing (..)
type alias CollectionData = { name :String
                            , userId : Int
                            }
type alias Model = {}
type Msg
    = GetAllCollections
    | GetCollectionByName
    | GetCollectionById
    | DeleteCollection Int
    | AddCollection CollectionData
    | UpdateCollection (Int, CollectionData)
    | GetBooksFromCollection Int
    | AddBookToCollection (Int,Int)

view : Model -> Html Msg
view _ =
    text "Hi its collection page"

init : () -> (Model, Cmd Msg)
init _ =
    ({}, Cmd.none)
