module Book exposing (..)
import Html exposing (..)
import Html exposing(..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Http exposing (Error(..))
import Json.Decode as Decode exposing(Decoder,int,list,string)
import Json.Encode as Encode exposing (..)
import Json.Decode.Pipeline as Pipeline exposing (required)
type alias BookData = { name : String
                       , id : Int
                       , date : String
                       }
type alias FullBookData = { name : String
                          , id : Int
                          , date : String
                          , authors : List AuthorData
                          }

type alias AuthorData = { name :String
                        , surname : String
                        }
type alias AddBookData = { name : String }

type alias Model = { allBooks : (List BookData)
                   , pickedBook : Maybe FullBookData
                   , setName : Maybe String
                   , setId : Maybe Int
                   , setDeleteId : Maybe Int
                   , setDetailsId : Maybe Int
                   }

root : String
root = "http://localhost:3000/books/"
type Msg
    = SetField Field
    | GotServerResponse ServerResponse
    | GotSubmit Submit


type Field
    = Name String
    | DeleteId Int
    | Id Int
    | DetailsId Int


type ServerResponse
    = GotBooks (Result Http.Error (List BookData))
    | GotBook (Result Http.Error FullBookData)
    | PostResponse (Result Http.Error ())
    | PutResponse (Result Http.Error ())
    | DeleteResponse (Result Http.Error ())

type Submit
    = SubmitPut
    | SubmitPost
    | SubmitGet
    | SubmitDelete

initialModel : Model
initialModel = { allBooks = []
               , pickedBook = Nothing
               , setName = Nothing
               , setId = Nothing
               , setDeleteId = Nothing
               , setDetailsId = Nothing
               }

bookRecord : BookData -> Html Msg
bookRecord book =
    li [] [ text ("Id: " ++ String.fromInt book.id ++ ", Name:" ++ book.name ++ ", Date: " ++ book.date)]


addForm : Model -> Html Msg
addForm model =
   Html.form
       [ onSubmit (GotSubmit SubmitPost)
       ]
       [ label []
           [ text "Enter name"
           , input
               [ type_ "text"
               , pattern "[A-Za-z]{3,}"
               , placeholder "Name"
               , onInput (\x ->  (SetField (Name x)))
               ]
               []
       , button
           []
           [ text "Add" ]
       ]
    ]
updateForm : Model -> Html Msg
updateForm model =
   Html.form
       [ onSubmit (GotSubmit SubmitPut)
       ]
       [ label []
           [ text "Enter name"
           , input
               [ type_ "text"
               , placeholder "Name"
               , pattern "[A-Za-z]{3,}"
               , onInput (\x ->  (SetField (Name x)))
               ]
               []
           ]
       , label []
            [ text "Enter id"
            , input
                [ type_ "number"
                , placeholder "0"
               , Html.Attributes.min "1"
                , onInput (\x -> SetField (Id (Maybe.withDefault 0 (String.toInt x))))
                ]
                []
            ]
       , button
           []
           [ text "Update" ]
       ]

deleteForm : Model -> Html Msg
deleteForm model =
   Html.form
       [ onSubmit (GotSubmit SubmitDelete)
       ]
       [ label []
           [ text "Id to delete"
           , input
               [ type_ "number"
               , Html.Attributes.min "1"
                , onInput (\x -> SetField (DeleteId (Maybe.withDefault 0 (String.toInt x))))
               ]
               []
       , button
           []
           [ text "Delete" ]
       ]
    ]

getBookDetailsForm : Html Msg
getBookDetailsForm =
   Html.form
       [ onSubmit (GotSubmit SubmitGet)
       ]
       [ label []
           [ text "Id"
           , input
               [ type_ "number"
               , Html.Attributes.min "1"
               , onInput (\x -> SetField (DetailsId (Maybe.withDefault 0 (String.toInt x))))
               ]
               []
       , button
           []
           [ text "Get info" ]
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
        , expect = Http.expectWhatever (\x ->  (GotServerResponse (PostResponse x)))
        , timeout = Just 0.1
        , tracker = Nothing
        }

putRequest : Model -> Cmd Msg
putRequest model =
    Http.request
        { method = "PUT"
        , headers = []
        , url = root
        , body = Http.jsonBody (Encode.object
            [ ("name", Encode.string (Maybe.withDefault "" model.setName))
            , ("id" , Encode.int  (Maybe.withDefault 0 model.setId))
            ])
        , expect = Http.expectWhatever (\x ->  (GotServerResponse (PutResponse x)))
        , timeout = Just 0.1
        , tracker = Nothing
        }
deleteRequest : Model -> Cmd Msg
deleteRequest model =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = root
        , body = Http.jsonBody (Encode.object
            [ ("id" , Encode.int  (Maybe.withDefault 0 model.setDeleteId)) ])
        , expect = Http.expectWhatever (\x ->  (GotServerResponse (DeleteResponse x)))
        , timeout = Just 0.1
        , tracker = Nothing
        }

getRequest : Int -> Cmd Msg
getRequest id =
     Http.request
            { method = "GET"
            , headers = []
            , url = root ++ String.fromInt id
            , body = Http.emptyBody
            , expect = Http.expectJson (\x ->  (GotServerResponse ((GotBook x)))) fullBookDecoder
            , timeout = Just 0.1
            , tracker = Nothing
            }

showDetails : Model -> Html Msg
showDetails model =
    case model.pickedBook of
        Nothing ->
            text "No details were requested"
        Just fullBook ->
            div []
            [ text ("Id: " ++ String.fromInt fullBook.id ++ ", Name: " ++ fullBook.name ++ ", Date: " ++ fullBook.date)
            , ul []
                (List.map showAuthor fullBook.authors)
             ]

showAuthor: AuthorData -> Html Msg
showAuthor data =
    li [] [ text ("name :" ++ data.name ++ " Surname: " ++ data.surname)]

view : Model -> Html Msg
view model =
        div []
            ( [ addBookView model
              , updateBookView model
              , deleteBookView model
              , showBookView
              , showDetails model
              ]
            ++  List.map bookRecord model.allBooks
            )

addBookView : Model -> Html Msg
addBookView model =
    div []
        [ text "Add book", addForm model]

updateBookView : Model -> Html Msg
updateBookView model =
    div []
        [text "Update Book ",updateForm model]

deleteBookView : Model -> Html Msg
deleteBookView model =
    div []
        [ text "Delete book", deleteForm model]

showBookView : Html Msg
showBookView =
    div []
        [ text "Get Book details" ,getBookDetailsForm]



init : () -> (Model, Cmd Msg)
init _ =
    ( initialModel
    , Http.get { url = root
               , expect =  Http.expectJson (\x ->  (GotServerResponse (GotBooks x))) booksDecoder
               }
   )

booksDecoder : Decoder (List BookData)
booksDecoder =
         Decode.succeed bookFromJson
            |> Pipeline.required "name" Decode.string
            |> Pipeline.required "id" Decode.int
            |> Pipeline.required "addition_date" Decode.string
            |> Decode.list
bookDecoder : Decoder BookData
bookDecoder =
         Decode.succeed bookFromJson
            |> Pipeline.required "name" Decode.string
            |> Pipeline.required "id" Decode.int
            |> Pipeline.required "bookDate" Decode.string


getFullBook : (List AuthorData) -> String -> String -> Int -> FullBookData
getFullBook authors name date id =
    { name = name
    , date = date
    , id = id
    , authors = authors
    }

fullBookDecoder : Decoder FullBookData
fullBookDecoder =
    Decode.succeed getFullBook
    |> Pipeline.requiredAt ["authors"] listOfAuthorsDecoder
    |> Pipeline.required "name" Decode.string
    |> Pipeline.required "bookDate" Decode.string
    |> Pipeline.required "id" Decode.int

listOfAuthorsDecoder : Decoder (List AuthorData)
listOfAuthorsDecoder =
   Decode.succeed authorFromJson
    |> Pipeline.required "authorName" Decode.string
    |> Pipeline.required "authorSurname" Decode.string
    |> Decode.list


authorFromJson :  String -> String-> AuthorData
authorFromJson name surname =
    { name = name
    , surname = surname
    }


bookFromJson : String -> Int-> String -> BookData
bookFromJson name id date =
    { name = name
    , id = id
    , date = date
    }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
        case msg of
            GotSubmit s ->
                updateSubmit s model
            SetField field ->
                updateField field model
            GotServerResponse response->
               updateServerResponse response model

updateSubmit : Submit -> Model  -> (Model, Cmd Msg)
updateSubmit submit model =
    case submit of
        SubmitPost ->
            (model, (postRequest model))
        SubmitPut ->
             (model, (putRequest model))
        SubmitDelete ->
             (model, (deleteRequest model))
        SubmitGet ->
            (model, (getRequest (Maybe.withDefault 0 model.setDetailsId)))

updateServerResponse : ServerResponse -> Model -> (Model, Cmd Msg)
updateServerResponse response model =
    case response of
        GotBook (Ok fullBook) ->
            ({ model | pickedBook = Just fullBook }, Cmd.none)
        GotBooks (Ok books) ->
            ( { model | allBooks = books }, Cmd.none)
        PostResponse (Ok _) ->
            (model, Cmd.none)
        PutResponse (Ok _) ->
            (model, Cmd.none)
        DeleteResponse (Ok _) ->
            (model, Cmd.none)
        _ ->
            (model, Cmd.none)

validateName : String -> Maybe String
validateName name =
    if (String.length name) <= 3 then Nothing else Just name
updateField : Field -> Model -> (Model, Cmd Msg)
updateField field model =
    case field of
        Name name ->
            ( { model | setName =  validateName name },Cmd.none )
        DeleteId id ->
            ( { model | setDeleteId = Just id }, Cmd.none)
        Id id ->
            ( { model | setId = Just id }, Cmd.none )
        DetailsId id ->
            ( { model | setDetailsId = Just id }, Cmd.none)
