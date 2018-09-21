import Web.Scotty
import Network.HTTP.Simple
import Control.Applicative
import Control.Monad.IO.Class (liftIO)
import qualified Data.Text.Lazy as TL
import qualified Data.ByteString.Lazy.Char8 as L8

main :: IO ()
main = scotty 8080 app

app :: ScottyM ()
app = get "/:inp" $ do
    inpStr <- param "inp"
    result <- liftIO $ factorial $ read inpStr
    text $ TL.pack $ show result
    
factorial :: Int -> IO Int
factorial 0 = base'
factorial 1 = base'
factorial n = (* n) <$> factorial' (n - 1)

base' :: IO Int
base' = httpGetInt "http://base-factorial.apps.internal:8080/"

factorial' :: Int -> IO Int
factorial' n = httpGetInt $ "http://factorial.apps.internal:8080/" ++ show n

httpGetInt :: String -> IO Int
httpGetInt url = do
    response <- httpLBS $ parseRequest_ $ "GET " ++ url
    return $ read $ L8.unpack $ getResponseBody response

