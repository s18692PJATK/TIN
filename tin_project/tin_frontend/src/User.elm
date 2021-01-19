module User exposing (..)

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


