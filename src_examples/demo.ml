open Ctypes
open PosixTypes
open Foreign

type demo_data
let demo_data : demo_data structure typ = structure "DemoData"
let fontNormal = field demo_data "fontNormal" int
let fontBold = field demo_data "fontBold" int
let fontIcons = field demo_data "fontIcons" int
let images = field demo_data "images" (array 12 int)
let () = seal demo_data

let load_demo_data =
  foreign "loadDemoData" (ptr Nanovg.context @-> ptr demo_data @-> returning int)

let load_demo_data vg data =
  let res = load_demo_data vg data in
  if res = 0 then true else false

let free_demo_data =
  foreign "freeDemoData" (ptr Nanovg.context @-> ptr demo_data @-> returning void)

let render_demo =
  foreign "renderDemo"
    (ptr Nanovg.context @-> float @-> float @-> float @-> float @-> float @-> int @-> ptr demo_data @-> returning void)

let save_screen_shot =
  foreign "saveScreenShot"
    (int @-> int @-> int @-> string @-> returning void)

let save_screen_shot a b c d =
  save_screen_shot a b (Glfw3.int_of_bool c) d
