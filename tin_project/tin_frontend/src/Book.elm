module Book exposing (..)
type alias BookData = { name : String }

type alias Model = {}
type Msg
    = GetAllBooks
    | GetBookById Int
    | GetBookByName String
    | AddBook BookData
    | UpdateBook (Int, BookData)
    | DeleteBook Int




