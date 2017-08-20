module Data.GameResults exposing (GameResults, encoder)

import Json.Encode
import Json.Decode exposing (Decoder)
import Util exposing ((=>))


type alias GameResults =
    { score : Int
    , total : Int
    }


encoder : GameResults -> String
encoder { score, total } =
    (Json.Encode.encode 4
        (Json.Encode.object
            [ "score" => Json.Encode.int score
            , "total" => Json.Encode.int total
            ]
        )
    )


decoder : Decoder GameResults
decoder =
    Json.Decode.map2 GameResults
        (Json.Decode.field "score" Json.Decode.int)
        (Json.Decode.field "total" Json.Decode.int)
