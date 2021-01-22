module Book exposing (..)
import Html exposing (..)
import Html exposing(..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http
import Json.Decode as Decode exposing(Decoder,int,list,string)
import Json.Encode as Encode exposing (..)
import Json.Decode.Pipeline as Pipeline exposing (required)
type alias BookData = { name : String, id : Int}
type alias AddBookData = { name : String }

type alias Model = { allBooks : (List BookData)
                   , pickedBook : Maybe BookData
                   , setName : Maybe String
                   }

root : String
root = "localhost:3000/books/"
type Msg
    = GetAllBooks
    | GetBookById Int
    | GetBookByName String
    | AddBook BookData
    | UpdateBook (Int, BookData)
    | DeleteBook Int
    | GotBooks (Result Http.Error (List BookData))
    | GotBook (Result Http.Error  BookData)
    | SetName String
    | SubmitForm
    | GotPostResponse (Result Http.Error String)

type FormField
    = BookName

initialModel : Model
initialModel = { allBooks = [ { name = "twojStary", id = 1}, { name = "twojaStara", id = 2 }]
               , pickedBook = Nothing
               , setName = Nothing
               }

bookRecord : BookData -> Html Msg
bookRecord book =
    li [] [ text ("Id : " ++ String.fromInt book.id ++ ", Name :" ++ book.name)]


viewForm : Model -> Html Msg
viewForm model =
   Html.form
       [ onSubmit SubmitForm
       ]
       [ label []
           [ text "Enter name"
           , input
               [ type_ "text"
               , placeholder "Name"
               , onInput SetName
               , value (Maybe.withDefault "" model.setName)
               ]
               []
       , button
           []
           [ text "Submit" ]
       ]
    ]

postRequest : Model -> Cmd Msg
postRequest model =
    Http.request
        { method = "POST"
        , headers = []
        , url = root
        , body = Http.jsonBody (Encode.object
            [ ("name", Encode.string (Maybe.withDefault "" model.setName))])
        , expect = Http.expectString GotPostResponse
        , timeout = Just 1
        , tracker = Nothing
        }


view : Model -> Html Msg
view model =
        div []
        ([ viewForm model ] ++  [ br [][]] ++ (List.map bookRecord model.allBooks))

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

init : () -> (Model, Cmd Msg)
init _ =
    ( initialModel
    , Http.get { url = root
               , expect =  Http.expectJson GotBooks modelDecoder
               }
   )

modelDecoder : Decoder (List BookData)
modelDecoder =
         Decode.succeed bookFromJson
            |> Pipeline.required "name" Decode.string
            |> Pipeline.required "id" Decode.int
            |> Decode.list


bookFromJson : String -> Int-> BookData
bookFromJson name id=
    { name = name
    , id = id
    }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
        case msg of
            SubmitForm ->
                (model, (postRequest model))

            GotPostResponse (Err error) ->
                Debug.log "Error" (model, Cmd.none)
            GotPostResponse (Ok a) ->
                Debug.log "Ok" (model, Cmd.none)
            _ ->
                (model, Cmd.none)

