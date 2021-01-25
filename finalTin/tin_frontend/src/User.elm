module User exposing (..)

import Html exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline
type alias UserData = { name :String
                            , id : Int
                            , surname : String
                            , accountCreationDate : String
                            , email : String
                            }

type alias Model  = { users: List UserData}
initialModel = { users = []}
root = "http://localhost:3000/users"
init : () -> (Model, Cmd Msg)

init _ =
    ( initialModel
    , Http.get { url = root
               , expect =  Http.expectJson GotAllUsers userDecoder
               }
   )



userDecoder : Decoder (List UserData)
userDecoder =
          Decode.succeed userFromJson
             |> Pipeline.required "id" Decode.int
             |> Pipeline.required "name" Decode.string
             |> Pipeline.required "surname" Decode.string
             |> Pipeline.required "email" Decode.string
             |> Pipeline.required "account_creation_date" Decode.string
             |> Decode.list

userFromJson : Int -> String -> String -> String -> String ->  UserData
userFromJson id name surname email date =
    { id = id
    , name = name
    , surname = surname
    , email = email
    , accountCreationDate = date
    }
type Msg
    = GotAllUsers (Result Http.Error (List UserData))
view : Model -> Html Msg
view model =
    div []
    [ ul []
        (List.map userRecord model.users)
    ]

userRecord : UserData -> Html Msg
userRecord user =
    li [] [ text ("Name: " ++ user.name ++ ", Surname: " ++ user.surname ++ ", email: " ++ user.email)]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
       GotAllUsers (Ok users) ->
           ({ model | users = users }, Cmd.none)
       GotAllUsers (Err error) ->
           (model,Cmd.none)
