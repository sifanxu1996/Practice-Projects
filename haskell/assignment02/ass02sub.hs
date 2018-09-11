--
-- Name: Sifan Xu
-- ID: 10146334
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

data QuadTree = Nil |
                Leaf Color |
                Node QuadTree QuadTree QuadTree QuadTree deriving Show

data QuadTreeImage = Qimage Int QuadTree deriving Show

--
-- Insert your code for parts 2 through 6 here.
--

--
-- part 2
--

-- takes a nested list corresponding to pixel color and returns
-- a QuadTreeImage
createTree :: [[Color]] -> QuadTreeImage
createTree xs
  | powerOf2 (length xs) == False  = error "image size must be a power of 2"
  | otherwise                      = Qimage (length xs) (treeHelper xs)

-- takes a nested list corresponding to pixel color and returns
-- a QuadTree
treeHelper :: [[Color]] -> QuadTree
treeHelper xs
  | homogenousColor xs    = Leaf ul_pixel
  | n == 2               = Node (Leaf ul_pixel) (Leaf ur_pixel) (Leaf lr_pixel) (Leaf ll_pixel)
  | otherwise            = Node (treeHelper ul_colors) (treeHelper ur_colors) (treeHelper lr_colors) (treeHelper ll_colors)

  where
    n = length xs
    ul_pixel = head (xs !! 0)
    ur_pixel = head (xs !! 1)
    lr_pixel = last (xs !! 1)
    ll_pixel = last (xs !! 0)
    ul_colors = colorHelper (take (n `div` 2) xs) 0
    ur_colors = colorHelper (take (n `div` 2) xs) 1
    lr_colors = colorHelper (drop (n `div` 2) xs) 1
    ll_colors = colorHelper (drop (n `div` 2) xs) 0

-- takes a nested list corresponding to pixel color and returns
-- True if colors are homogenous, False if not
homogenousColor :: [[Color]] -> Bool
homogenousColor xs
  | length xs == 2 = (ul_pixel == ur_pixel && ul_pixel == lr_pixel && ul_pixel == ll_pixel)
  | otherwise      = (ul_colors == ur_colors && ul_colors == lr_colors && ul_colors == ll_colors) && homogenousColor ul_colors

  where
    n = length xs
    ul_pixel = head (xs !! 0)
    ur_pixel = head (xs !! 1)
    lr_pixel = last (xs !! 1)
    ll_pixel = last (xs !! 0)
    ul_colors = colorHelper (take (n `div` 2) xs) 0
    ur_colors = colorHelper (take (n `div` 2) xs) 1
    lr_colors = colorHelper (drop (n `div` 2) xs) 1
    ll_colors = colorHelper (drop (n `div` 2) xs) 0

-- takes a nested list corresponding to pixel color and an Integer returns
-- the left section of the pixels if the Integer is 0,
-- the right section of the pixels if the Integer is anything else
colorHelper :: [[Color]] -> Int -> [[Color]]
colorHelper [] _ = []
colorHelper (x:xs) n
  | n == 0    = (take ((length x) `div` 2) x) : (colorHelper xs n)
  | otherwise = (drop ((length x) `div` 2) x) : (colorHelper xs n)

-- takes an Integer and checks if it is a power of 2
powerOf2 :: Int -> Bool
powerOf2 1 = True
powerOf2 x
  | x `rem` 2 == 0 = powerOf2 (x `div` 2)
  | otherwise      = False

--
-- part 3
--

-- takes a QuadTreeImage and returns a tuple containing the number of
-- (internal nodes, leaf nodes) in the image
countNodes :: QuadTreeImage -> (Int, Int)
countNodes (Qimage n qt) = countHelper qt

-- takes a QuadTree and returns a tuple containing the number of
-- (internal nodes, leaf nodes) in the image
countHelper :: QuadTree -> (Int, Int)
countHelper (Leaf _) = (0, 1)
countHelper (Node a b c d) = addTuples (1, 0) (addTuples (countHelper a)
                          (addTuples (countHelper b) (addTuples (countHelper c)
                          (countHelper d))))

-- adds two tuples together and returns the result
addTuples :: (Int, Int) -> (Int, Int) -> (Int, Int)
addTuples (a, b) (c, d) = (a+c, b+d)

--
-- part 4
--

-- takes a QuadTreeImage and returns a String containing SVG tags needed to
-- generate a HTML image
toHTML :: QuadTreeImage -> String
toHTML (Qimage n qt) = "<html><head></head><body>\n" ++
                       "<svg width=\"" ++ (show n) ++
                       "\" height=\"" ++ (show n) ++ "\">" ++
                       (toHTMLHelper 0 0 n qt) ++
                       "</svg>\n</html>"

-- Parameters:
--   x, y: The upper left corner of the QuadTree
--   n: the size of the QuadTree
--   QuadTree: the tree to be drawn
--
-- Returns:
--   String: the tree to be drawn in HTML
toHTMLHelper :: Int -> Int -> Int -> QuadTree -> String
toHTMLHelper x y n (Leaf col)     = fillRect x y n (col)
toHTMLHelper x y n (Node a b c d) = ul_rect ++ ur_rect ++ lr_rect ++ ll_rect
  where
    ul_rect   = toHTMLHelper x y (hw) a
    ur_rect   = toHTMLHelper (x + hw) y (hw) b
    lr_rect   = toHTMLHelper (x + hw) (y + hw) (hw) c
    ll_rect   = toHTMLHelper x (y + hw) (hw) d
    hw        = (n `div` 2)

-- Parameters:
--   x, y: The upper left corner of the rectangle
--   n: the size of the rectangle
--   Color: the color of the rectangle
--
-- Returns:
--   String: the rectangle to be drawn in HTML
fillRect :: Int -> Int -> Int -> Color -> String
fillRect x y n (RGB a b c)
  = "<rect x= " ++ show x ++
          " y=" ++ show y ++
      " width=" ++ show n ++
     " height=" ++ show n ++
 " fill=\"rgb(" ++ show a ++ "," ++ show b ++ "," ++ show c ++ ")\"/>\n"

--
-- part 5
--

-- takes two QuadTreeImage of the same size, a function that takes two colors
-- and returns a QuadTreeImage whose color is a function of both colors
merge :: QuadTreeImage -> QuadTreeImage -> (Color -> Color -> Color) -> QuadTreeImage
merge (Qimage a qt1) (Qimage b qt2) f
 | a /= b = error "images are different sizes"
 | otherwise = Qimage a (mergeTree qt1 qt2 f)

 -- takes two QuadTree of the same size, a function that takes two colors
 -- and returns a QuadTree whose color is a function of both colors
mergeTree :: QuadTree -> QuadTree -> (Color -> Color -> Color) -> QuadTree
mergeTree (Leaf c1) (Leaf c2) f = Leaf (f c1 c2)
mergeTree (Node a1 a2 a3 a4) (Node b1 b2 b3 b4) f = (Node (mergeTree a1 b1 f) (mergeTree a2 b2 f) (mergeTree a3 b3 f) (mergeTree a4 b4 f))
mergeTree (Leaf color) (Node a1 a2 a3 a4) f = (Node (mergeTree (Leaf color) a1 f) (mergeTree (Leaf color) a2 f) (mergeTree (Leaf color) a3 f) (mergeTree (Leaf color) a4 f))
mergeTree (Node a1 a2 a3 a4) (Leaf color) f = (Node (mergeTree (Leaf color) a1 f) (mergeTree (Leaf color) a2 f) (mergeTree (Leaf color) a3 f) (mergeTree (Leaf color) a4 f))

--
-- part 6
--

-- takes a QuadTreeImage and returns an optimized QuadTreeImage
optimizeImage :: QuadTreeImage -> QuadTreeImage
optimizeImage (Qimage n qt) = (Qimage n (traverseAndOptimizeTree qt))

-- takes a QuadTree and traverses to its leaf node, applying post-order
-- optimization and returning the resulting QuadTree
traverseAndOptimizeTree :: QuadTree -> QuadTree
traverseAndOptimizeTree (Leaf a) = (Leaf a)
traverseAndOptimizeTree (Node (Leaf a) (Leaf b) (Leaf c) (Leaf d)) = optimizeTree (Node (Leaf a) (Leaf b) (Leaf c) (Leaf d))
traverseAndOptimizeTree (Node a b c d) = postorder_traversal
  where
    postorder_traversal = optimizeTree (Node (traverseAndOptimizeTree a) (traverseAndOptimizeTree b) (traverseAndOptimizeTree c) (traverseAndOptimizeTree d))

-- takes a QuadTree node and optimizes it if possible and returns the result
optimizeTree :: QuadTree -> QuadTree
optimizeTree (Leaf a) = (Leaf a)
optimizeTree (Node (Leaf a) (Leaf b) (Leaf c) (Leaf d))
  | a == b && a == c && a == d = (Leaf a)
  | otherwise = (Node (Leaf a) (Leaf b) (Leaf c) (Leaf d))
optimizeTree (Node a b c d) = (Node a b c d)

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
  input_1 <- BS.readFile "Test_512x512.png"
  input_2 <- BS.readFile "Mondrian_512x512.png"

  -- image_n is the list representation of the image stored in the .png file
  let image_1 = decodeImage input_1
  let image_2 = decodeImage input_2

  -- Convert the list representation of each image into a tree representation
  let qtree_image_1 = createTree image_1
  let qtree_image_2 = createTree image_2
  --
  writeFile "tree.txt" ((show qtree_image_1) ++ "\n\n" ++ (show qtree_image_2))
  -- The previous line writes the trees to tree.txt.  This forces Haskell
  -- to evaluate the calls to createTree and can be helpful when debugging.
  -- You might want to delete / comment out that line when working with
  -- larger files so you don't have to wait for the entire tree structure
  -- to be written out.

  -- Compute the number of nodes in each of the loaded images
  let (interior_1, leaf_1) = countNodes qtree_image_1
  let (interior_2, leaf_2) = countNodes qtree_image_2

  -- Merge the images
  --
  -- You can replace the call to average at the end of this line with
  -- a different function like brightest or darkest, or with any other
  -- function that combines two colors that you write yourself.
  --
  let merged = merge qtree_image_1 qtree_image_2 average
  let (interior_m, leaf_m) = countNodes merged

  -- Optimize the merged images
  let optimized = optimizeImage merged
  let (interior_o, leaf_o) = countNodes optimized

  writeFile "quadtree.html" ("<p>Merge Image 1:<p>\n" ++
                 (toHTML qtree_image_1) ++
                 "<p>Interior Nodes: " ++ show interior_1 ++
                 "<br>Leaf Nodes: " ++ show leaf_1 ++
                 "<br><br><br><br>" ++

                 "<p>Merge Image 2:<p>\n" ++
                 (toHTML qtree_image_2) ++
                 "<p>Interior Nodes: " ++ show interior_2 ++
                 "<br>Leaf Nodes: " ++ show leaf_2 ++
                 "<br><br><br><br>" ++

                 "<p>Merge Result:<p>\n" ++
                 (toHTML merged) ++ "<p>"  ++
                 "<p>Interior Nodes: " ++ show interior_m ++
                 "<br>Leaf Nodes: " ++ show leaf_m ++
                 "<br><br><br><br>" ++

                 "<p>Optimized Result:<p>\n" ++
                 (toHTML optimized) ++ "<p>"  ++
                 "<p>Interior Nodes: " ++ show interior_o ++
                 "<br>Leaf Nodes: " ++ show leaf_o ++
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
