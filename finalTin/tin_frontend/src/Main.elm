module Main exposing (..)
import Book exposing (..)
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (..)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser,s,string)
import Html.Attributes exposing (classList, href)
import User exposing (..)
import Collection exposing (..)


type alias Model = { currentPage : Page
                   , key : Nav.Key
                   }
type Msg = GotBookMsg Book.Msg
         | ClickedLink Browser.UrlRequest
         | ChangedUrl Url
         | GotCollectionMsg Collection.Msg
         | GotUserMsg User.Msg


type Page
    = UserPage User.Model
    | CollectionPage Collection.Model
    | BookPage Book.Model
    | NotFound

type Route
    = UserRoute
    | CollectionRoute
    | BookRoute


view : Model -> Document Msg
view model =
        { title = "good reads"
        , body =  [
        div []
            [ viewHeader (UserPage User.initialModel)
            , case model.currentPage of
                UserPage userModel ->
                    User.view userModel
                    |> Html.map GotUserMsg
                BookPage bookModel ->
                    Book.view  bookModel
                    |> Html.map GotBookMsg
                CollectionPage collectionModel ->
                    Collection.view collectionModel
                    |> Html.map GotCollectionMsg
                NotFound ->
                    text "Page not found, check if the route is correct"
            ]
           ]
        }


viewHeader : Page -> Html Msg
viewHeader page =
    let
        logo =
            h1 [] [ text "GoodReads v2"]

        links =
            ul []
            [ navLink UserRoute { url = "/", caption = "User"}
            , navLink CollectionRoute { url = "/collections", caption = "Collection"}
            , navLink BookRoute { url = "/books", caption = "Book"}
            ]

        navLink : Route -> { url : String, caption: String } -> Html Msg
        navLink targetPage { url, caption} =
            li [ classList [ ("active", isActive { route = targetPage, page = page }) ]]
                [ a [ href url ] [ text caption ] ]

    in
    nav [] [ logo, links ]

isActive : { route : Route, page : Page} -> Bool
isActive { route ,page } =
   case (route , page) of
       (UserRoute, UserPage _) -> True
       (UserRoute, _) -> False
       (BookRoute, BookPage _) -> True
       (BookRoute, _) -> False
       (CollectionRoute, CollectionPage _) -> True
       (CollectionRoute, _) -> False

main : Program () Model Msg
main =
    Browser.application
    { init = \url -> init
    -- think why there is extra url parameter
    , onUrlRequest = ClickedLink
    , onUrlChange = ChangedUrl
    , subscriptions = \_ -> Sub.none
    , update = update
    , view = view
    }


update : Msg -> Model -> (Model,Cmd Msg)
update msg model =
    case msg of
        GotBookMsg bookMsg ->
            case model.currentPage of
                BookPage bookModel ->
                    toBooks model  (Book.update bookMsg bookModel)
                _ ->
                    (model, Cmd.none)
        GotUserMsg userMsg ->
            case model.currentPage of
                UserPage userModel ->
                    toUsers model (User.update userMsg userModel)
                _ ->
                    (model, Cmd.none)
        GotCollectionMsg collectionMsg ->
                     case model.currentPage of
                         CollectionPage collectionModel ->
                             toCollections model (Collection.update collectionMsg collectionModel)
                         _ ->
                             (model, Cmd.none)
        ClickedLink urlRequest ->
                     Debug.log "Hello clicked link"(
                     case urlRequest of
                         Browser.External href ->
                             (model, Nav.load href)
                         Browser.Internal url ->
                             ( model, Nav.pushUrl model.key (Url.toString url) )
                     )
        ChangedUrl url ->
            Debug.log "Hello changed url "(
            updateUrl url model
           )





toBooks : Model -> (Book.Model,Cmd Book.Msg) -> (Model, Cmd Msg)
toBooks model (bookModel, bookMsg) =
    ( { model | currentPage = BookPage bookModel }
    , Cmd.map GotBookMsg bookMsg)

toCollections : Model -> (Collection.Model, Cmd Collection.Msg) -> (Model, Cmd Msg)
toCollections model (collectionModel,collectionMsg) =
   ( { model | currentPage = CollectionPage collectionModel }
   , Cmd.map GotCollectionMsg collectionMsg
   )
toUsers : Model -> (User.Model, Cmd User.Msg) -> (Model, Cmd Msg)
toUsers model (userModel,userMsg) =
   ( { model | currentPage = UserPage userModel }
   , Cmd.map GotUserMsg userMsg
   )


parser: Parser (Route -> a)  a
parser =
    Parser.oneOf
    [ Parser.map UserRoute Parser.top
    , Parser.map BookRoute (Parser.s "books")
    , Parser.map CollectionRoute (Parser.s "collections")
    ]


init :  Url -> Nav.Key -> (Model ,Cmd Msg)
init  url key =
    updateUrl url { currentPage = BookPage Book.initialModel, key = key}

updateUrl : Url -> Model -> (Model ,Cmd Msg)
updateUrl url model =
    case Parser.parse parser url of
        Just BookRoute ->
            Book.init ()
            |> toBooks model

        Just CollectionRoute ->
                Collection.init ()
                |> toCollections model

        Just UserRoute ->
            User.init ()
            |> toUsers model
        Nothing ->
            Debug.log "Not found page clicked "(
            ( { model | currentPage = NotFound }, Cmd.none)
            )

