--
-- Name:
-- ID:
--

--
-- CPSC 449 Spring 2018 Assignment 2 Starter Code
--
import qualified Data.ByteString.Lazy as BS
import Data.Word
import Data.Bits
import Data.Char
import Codec.Compression.Zlib as Z
import Numeric (showHex)

data Color = RGB Int Int Int deriving (Eq, Show)
--
-- Define your algebraic types for Part 1 here.
--
-- *** MAKE SURE THAT YOUR TYPES DERIVE THE DEFAULT IMPLEMENTATION OF SHOW ***
--

--
-- Insert your code for parts 2 through 6 here.
--







--
--  These functions can be passed as the final parameter to merge.
--

--
--  Merge two colors by computing their average.  This makes it look like the
--  two images being merged are 'ghosted' on top of each other.
--
average :: Color -> Color -> Color
average (RGB r1 g1 b1) (RGB r2 g2 b2) = (RGB r_avg g_avg b_avg)
  where
    r_avg = (r1 + r2) `div` 2
    g_avg = (g1 + g2) `div` 2
    b_avg = (b1 + b2) `div` 2

--
--  Merge two colors by retaining the brighter color.  This allows us to take
--  an image with black regions in it and replace them with a texture from
--  another image.
--
brightest :: Color -> Color -> Color
brightest (RGB r1 g1 b1) (RGB r2 g2 b2)
  | brightness1 > brightness2 = (RGB r1 g1 b1)
  | otherwise = (RGB r2 g2 b2)
  where
    brightness1 = r1 + g1 + b1
    brightness2 = r2 + g2 + b2

--
--  Merge two colors by retaining the darker color.  This allows us to 
--  overlay dark text / pixels on top of an existing image.
--
darkest :: Color -> Color -> Color
darkest (RGB r1 g1 b1) (RGB r2 g2 b2)
  | brightness1 < brightness2 = (RGB r1 g1 b1)
  | otherwise = (RGB r2 g2 b2)
  where
    brightness1 = r1 + g1 + b1
    brightness2 = r2 + g2 + b2

--
-- Load a pair of PNG files, convert them into quad tree images, compute a
-- merged image, optimize it and write all four images to an .html file.
--
main :: IO ()
main = do
  -- Change the names inside double quotes to load different files
  input_1 <- BS.readFile "blocks_1.png"
  input_2 <- BS.readFile "blocks_2.png"
 
  -- image_n is the list representation of the image stored in the .png file
  let image_1 = decodeImage input_1
  let image_2 = decodeImage input_2

  -- Convert the list representation of each image into a tree representation
  -- Part 2 -- let qtree_image_1 = createTree image_1
  -- Part 2 -- let qtree_image_2 = createTree image_2
  --
  -- Part 2 -- writeFile "tree.txt" ((show qtree_image_1) ++ "\n\n" ++ (show qtree_image_2))
  -- The previous line writes the trees to tree.txt.  This forces Haskell
  -- to evaluate the calls to createTree and can be helpful when debugging.
  -- You might want to delete / comment out that line when working with 
  -- larger files so you don't have to wait for the entire tree structure
  -- to be written out. 

  -- Compute the number of nodes in each of the loaded images
  -- Part 3 -- let (interior_1, leaf_1) = countNodes qtree_image_1
  -- Part 3 -- let (interior_2, leaf_2) = countNodes qtree_image_2

  -- Merge the images
  --
  -- You can replace the call to average at the end of this line with
  -- a different function like brightest or darkest, or with any other
  -- function that combines two colors that you write yourself.
  --
  -- Part 5 -- let merged = merge qtree_image_1 qtree_image_2 average
  -- Part 5 -- let (interior_m, leaf_m) = countNodes merged

  -- Optimize the merged images
  -- Part 6 -- let optimized = optimizeImage merged
  -- Part 6 -- let (interior_o, leaf_o) = countNodes optimized
 
  writeFile "quadtree.html" ("<p>Merge Image 1:<p>\n" ++
  -- Part 4 --               (toHTML qtree_image_1) ++ 
  -- Part 3 --               "<p>Interior Nodes: " ++ show interior_1 ++
  -- Part 3 --               "<br>Leaf Nodes: " ++ show leaf_1 ++ 
                             "<br><br><br><br>" ++

                             "<p>Merge Image 2:<p>\n" ++ 
  -- Part 4 --               (toHTML qtree_image_2) ++ 
  -- Part 3 --               "<p>Interior Nodes: " ++ show interior_2 ++
  -- Part 3 --               "<br>Leaf Nodes: " ++ show leaf_2 ++ 
                             "<br><br><br><br>" ++

                             "<p>Merge Result:<p>\n" ++ 
  -- Part 5 --               (toHTML merged) ++ "<p>"  ++
  -- Part 5 --               "<p>Interior Nodes: " ++ show interior_m ++
  -- Part 5 --               "<br>Leaf Nodes: " ++ show leaf_m ++ 
                             "<br><br><br><br>" ++

                             "<p>Optimized Result:<p>\n" ++ 
  -- Part 6 --               (toHTML optimized) ++ "<p>"  ++
  -- Part 6 --               "<p>Interior Nodes: " ++ show interior_o ++
  -- Part 6 --               "<br>Leaf Nodes: " ++ show leaf_o ++ 
                             "<br><br><br><br>"
                            )

-------------------------------------------------------------------------------
--
--  DO NOT MODIFY THE CODE BELOW THIS POINT IN THE FILE.  
--
-------------------------------------------------------------------------------
--
-- The following functions are a simple PNG file loader.  Note that these
-- functions will not load all PNG files.  They makes some assumptions about
-- the structure of the file that are not required by the PNG standard,
-- don't support transparency, and only support a limited number of bit
-- depths.  Hopefully they will generate an error message if you try and load 
-- an unsupported file.  Hopefully...
--

--
-- Convert 4 8-bit words to a 32 bit (or larger) integer
--
make32Int :: Word8 -> Word8 -> Word8 -> Word8 -> Int 
make32Int a b c d = ((((fromIntegral a) * 256) + 
                       (fromIntegral b) * 256) + 
                       (fromIntegral c) * 256) + 
                       (fromIntegral d)

--
-- Get a list of all of the PNG blocks out of a list of bytes
--
getBlocks :: [Word8] -> [(String, [Word8])]
getBlocks [] = []
getBlocks (a:b:c:d:e:f:g:h:xs) = (name, take (size+12) (a:b:c:d:e:f:g:h:xs)) : getBlocks (drop (size + 4) xs)
  where
    size = make32Int a b c d
    name = (chr (fromIntegral e)) : (chr (fromIntegral f)) :
           (chr (fromIntegral g)) : (chr (fromIntegral h)) : []

--
-- Extract the information out of the IHDR block
--
getIHDRInfo :: [(String, [Word8])] -> (Int, Int, Int, Int)
getIHDRInfo [] = error "No IHDR block found"
getIHDRInfo (("IHDR", (_:_:_:_:_:_:_:_:w1:w2:w3:w4:h1:h2:h3:h4:bd:ct:_)) : _) = (make32Int w1 w2 w3 w4, make32Int h1 h2 h3 h4, fromIntegral bd, fromIntegral ct)
getIHDRInfo (x : xs) = getIHDRInfo xs

--
-- Extract and decompress the data in the IDAT block(s).  
--
getImageData :: [(String, [Word8])] -> [Word8]
getImageData blocks 
  | idat_blocks == [] = error "No IDAT block found"
  | otherwise = decompressed_data
  where 
    idat_blocks = filter (\(x, _) -> x == "IDAT") blocks
    idat_datas = map (\(x, (_:_:_:_:_:_:_:_:xs)) -> take (length xs - 4) xs) idat_blocks
    merged_data = foldl1 (++) idat_datas
    decompressed_data = BS.unpack (Z.decompress (BS.pack merged_data))

--
-- Convert a list of bytes to a list of Color
--
makeColors :: [Word8] -> [Color]
makeColors [] = []
makeColors (r : g : b : vals) = RGB (fromIntegral r) (fromIntegral g) (fromIntegral b) : makeColors vals

--
-- Convert a list of bytes that have been decompressed from a PNG file into
-- a two dimensional list representation of the image
--
imageBytesToImageList :: [Word8] -> Int -> [[Color]]
imageBytesToImageList [] _ = []
imageBytesToImageList (_:xs) w = makeColors (take (w * 3) xs) : imageBytesToImageList (drop (w * 3) xs) w

--
-- Determine how many IDAT blocks are in the PNG file
--
numIDAT :: [(String, [Word8])] -> Int
numIDAT vals = length (filter (\(name, dat) -> name == "IDAT") vals)

--
-- Determine if there is a cHRM block in the PNG file
--
hasCHRM :: [(String, [Word8])] -> Bool
hasCHRM vals = (length (filter (\(name, dat) -> name == "cHRM") vals)) /= 0

--
-- Convert the entire contents of a PNG file (as a ByteString) into 
-- a two dimensional list representation of the image
--
decodeImage :: BS.ByteString -> [[Color]]
decodeImage bytes
  | hasCHRM blocks = error "Image contains a CHRM chunk which this loader is unable to handle"
  | header == [137,80,78,71,13,10,26,10] &&
    colorType == 2 &&
    bitDepth == 8 = imageBytesToImageList imageBytes w
  | otherwise = error ("Invalid header\ncolorType: " ++ (show colorType) ++ "\nbitDepth: " ++ (show bitDepth) ++ "\n")
  where
    header = take 8 $ BS.unpack bytes
    (w, h, bitDepth, colorType) = getIHDRInfo blocks
    imageBytes = getImageData blocks
    blocks = getBlocks (drop 8 $ BS.unpack bytes)

--
--  Get all of the blocks (chunks) from a ByteString
--
getImageBlocks :: BS.ByteString -> [(String, [Word8])]
getImageBlocks bytes = getBlocks (drop 8 $ BS.unpack bytes)

-------------------------------------------------------------------------------
--
--  END OF PNG LOADER CODE
--
-------------------------------------------------------------------------------
