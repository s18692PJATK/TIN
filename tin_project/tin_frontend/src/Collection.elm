module Collection exposing (..)

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