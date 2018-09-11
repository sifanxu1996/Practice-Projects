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
    hWidth = width `div` 2
    hHeight = height `div` 2
    wSplit = round(((r*(0.34))+0.33)*fromIntegral w)
    hSplit = round(((s*(0.34))+0.33)*fromIntegral h)
    
    -- ([Float], String) for splitting into 4 regions
    (ul_rand, ul_tags) = (mondrian x y wSplit hSplit rs)
    (ur_rand, ur_tags) = (mondrian (x+wSplit) y (w-wSplit) hSplit ul_rand)
    (ll_rand, ll_tags) = (mondrian x (y+hSplit) wSplit (h-hSplit) ur_rand)
    (lr_rand, lr_tags) = (mondrian (x+wSplit) (y+hSplit) (w-wSplit) (h-hSplit) ll_rand)
    
    -- ([Float], String) for splitting into 2 regions, horizontal split
    (hl_rand, hl_tags) = (mondrian x y wSplit h rs)
    (hr_rand, hr_tags) = (mondrian (x+wSplit) y (w-wSplit) h hl_rand)

    -- ([Float], String) for splitting into 2 regions, vertical split
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
  | (r*((1.5*fromIntegral(w))-120))+120 < fromIntegral w = True
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
       " fill=\"rgb(0,0,0)\" />\n" ++
       "<rect x=" ++ (show (x+2)) ++ 
       " y=" ++ (show (y+2)) ++ 
       " width=" ++ (show (w-4)) ++ 
       " height=" ++ (show (h-4)) ++ 
       " fill=\"rgb(" ++ (mondrianColor r s t) ++ ")\" />\n")

-- Selects the color of the rectangle
-- Parameters:
--   r, s, t: random floating point values between 0 and 1
--
-- Returns:
--   String: The RGB values of the color
mondrianColor :: Float -> Float -> Float -> String
mondrianColor r s t
  | r < 0.0833 = ("255,0,0")
  | s < 0.1667 = ("135,206,235")
  | t < 0.2500 = ("255,255,0")
  | otherwise  = ("255,255,255")

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
