module Collection exposing (..)

import Html exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline
type alias CollectionData = { name :String
                            , date : String
                            , id : Int
                            }

type alias Model  = { collections : List CollectionData}
initialModel = { collections = []}
root = "http://localhost:3000/collections"
init : () -> (Model, Cmd Msg)

init _ =
    ( initialModel
    , Http.get { url = root
               , expect =  Http.expectJson GotAllCollections collectionDecoder
               }
   )



collectionDecoder : Decoder (List CollectionData)
collectionDecoder =
          Decode.succeed collectionFromJson
             |> Pipeline.required "id" Decode.int
             |> Pipeline.required "name" Decode.string
             |> Pipeline.required "creation_date" Decode.string
             |> Decode.list

collectionFromJson : Int -> String -> String ->  CollectionData
collectionFromJson id name date  =
    { id = id
    , name = name
    , date = date
    }
type Msg
    = GotAllCollections (Result Http.Error (List CollectionData))
view : Model -> Html Msg
view model =
    div []
    [ ul []
     (List.map collectionRecord model.collections)
    ]


collectionRecord : CollectionData -> Html Msg
collectionRecord c =
    li [] [ text ("Id : " ++ String.fromInt c.id ++ ", name: " ++ c.name ++ ", date" ++ c.date)]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
       GotAllCollections (Ok collections) ->
           ({ model | collections = collections }, Cmd.none)
       GotAllCollections (Err error) ->
           (model,Cmd.none)

