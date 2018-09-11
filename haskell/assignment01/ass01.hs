-- Name: Sifan Xu
-- UCID: 10146334
--
-- Generate and output a Mondrian-style image as an SVG tag within an HTML 
-- document.
import System.IO
import Control.Monad (replicateM)
import System.Random (randomRIO, StdGen, randomR, mkStdGen)

-- The width and height of the image being generated.
width :: Int
width = 1024

height :: Int
height = 768

-- Generate and return a list of 20000 random floating point numbers between 
-- 0 and 1.  (Increase the 20000 if you ever run out of random values).
randomList :: Int -> [Float]
randomList seed = take 20000 (rl_helper (mkStdGen seed))

rl_helper :: StdGen -> [Float]
rl_helper g = fst vg : rl_helper (snd vg)
  where vg = randomR (0.0, 1.0 :: Float) g

-- Compute an integer between low and high from a (presumably random) floating
-- point number between 0 and 1.
randomInt :: Int -> Int -> Float -> Int
randomInt low high x = round ((fromIntegral (high - low) * x) + fromIntegral low)

-- Generate the tag for a rectangle with random color.  Replace the 
-- implementation of this function so that it generates all of the tags
-- needed for a piece of random Mondrian art.
-- 
-- Parameters:
--   x, y: The upper left corner of the region
--   w, h: The width and height of the region
--   r:s:t:rs: A list of random floating point values between 0 and 1
--
-- Returns:
--   [Float]: The remaining, unused random values
--   String: The SVG tags that draw the image
mondrian :: Int -> Int -> Int -> Int -> [Float] -> ([Float], String)
mondrian x y w h (r:s:t:rs)
  | w > hWidth && y > hHeight                   = (lr_rand, ul_tags ++ ur_tags ++ ll_tags ++ lr_tags)
  | w > hWidth                                  = (hr_rand, hl_tags ++ hr_tags)
  | h > hHeight                                 = (vd_rand, vu_tags ++ vd_tags)
  | mondrianSplit r w && mondrianSplit r h      = (lr_rand, ul_tags ++ ur_tags ++ ll_tags ++ lr_tags)
  | mondrianSplit r w                           = (hr_rand, hl_tags ++ hr_tags)
  | mondrianSplit r h                           = (vd_rand, vu_tags ++ vd_tags)
  | otherwise                                   = mondrianFill x y w h rs
  
  where
    hWidth = width `div` 5
    hHeight = height `div` 5
    wSplit = round(((r*(0.34))+0.33)*fromIntegral w)
    hSplit = round(((s*(0.34))+0.33)*fromIntegral h)
    
    -- split into 4 regions
    (ul_rand, ul_tags) = (mondrian x y wSplit hSplit rs)
    (ur_rand, ur_tags) = (mondrian (x+wSplit) y (w-wSplit) hSplit ul_rand)
    (ll_rand, ll_tags) = (mondrian x (y+hSplit) wSplit (h-hSplit) rs)
    (lr_rand, lr_tags) = (mondrian (x+wSplit) (y+hSplit) (w-wSplit) (h-hSplit) ul_rand)
    
    -- split into 2 regions, horizontally
    (hl_rand, hl_tags) = (mondrian x y wSplit h rs)
    (hr_rand, hr_tags) = (mondrian (x+wSplit) y (w-wSplit) h hl_rand)
    
    -- split into 2 regions, vertically
    (vu_rand, vu_tags) = (mondrian x y w hSplit rs)
    (vd_rand, vd_tags) = (mondrian x (y+hSplit) w (h-hSplit) vu_rand)

-- Decides whether or not to split the region
--
-- Parameters:
--   r: a random floating point number between 0.0 and 1.0
--   w: the length of the region
--
-- Returns:
--   Bool: True or False
mondrianSplit :: Float -> Int -> Bool
mondrianSplit r w
  | (r*((1.5*fromIntegral(w))-50))+50 < fromIntegral w = True
  | otherwise                                            = False

-- Draws a rectangle
--
-- Parameters:
--   x, y: The upper left corner of the rectangle
--   w, h: The width and height of the rectangle
--   r:s:t:rs: A list of random floating point values between 0 and 1
--
-- Returns:
--   [Float]: The remaining, unused random values
--   String: The SVG tags that draw the image
mondrianFill :: Int -> Int -> Int -> Int -> [Float] -> ([Float], String)
mondrianFill x y w h (r:s:t:rs) =
  (rs, "<rect x=" ++ (show x) ++ 
       " y=" ++ (show y) ++ 
       " width=" ++ (show w) ++ 
       " height=" ++ (show h) ++ 
       " fill=\"rgb(" ++ (mondrianColor x y (r/3) (s/3) (t/3)) ++ ")\" />\n" ++
       "<rect x=" ++ (show (x+round(v*3)+2)) ++ 
       " y=" ++ (show (y+round(v*3)+2)) ++ 
       " width=" ++ (show (w-round(v*6)-4)) ++ 
       " height=" ++ (show (h-round(v*6)-4)) ++ 
       " fill=\"rgb(" ++ (mondrianColor x y r s t) ++ ")\" />\n")

  where
     v = (r)/2

-- Selects the color of the rectangle, influenced by position
-- Parameters:
--   x, y: The upper left corner of the rectangle
--   r, s, t: random floating point values between 0 and 1
--
-- Returns:
--   String: The RGB values of the color
mondrianColor :: Int -> Int -> Float -> Float -> Float -> String
mondrianColor x y r s t = (show (round((r+s)/2) + xd)) ++ "," ++
                          (show (round((s+t)/2) + yd)) ++ "," ++
                          (show (round((t+r)/2) + cd))
  where
    xd = round(((fromIntegral x)/(fromIntegral width))*255) `div` (round((r*2)+0.5))
    yd = round(((fromIntegral y)/(fromIntegral height))*255) `div` (round((s*2)+0.5))
    cd = ((xd+yd) `div` 2) `div` (round((t*2)+0.5))

-- The main program which generates and outputs mondrian.html.
main :: IO ()
main = do
  --  Right now, the program will generate a different sequence of random
  --  numbers each time it is run.  If you want the same sequence each time
  --  use "let seed = 0" instead of "seed <- randomRIO (0, 100000 :: Int)"

  --let seed = 0
  seed <- randomRIO (0, 100000 :: Int)
  let randomValues = randomList seed

  let prefix = "<html><head></head><body>\n" ++
               "<svg width=\"" ++ (show width) ++ 
               "\" height=\"" ++ (show height) ++ "\">"
      image = snd (mondrian 0 0 width height randomValues)
      suffix = "</svg>\n</html>"

  writeFile "mondrian.html" (prefix ++ image ++ suffix)
