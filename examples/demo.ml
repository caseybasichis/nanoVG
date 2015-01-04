open Ctypes
open PosixTypes
open Foreign

type demoData
let demoData : demoData structure typ = structure "DemoData"
let fontNormal = field demoData "fontNormal" int
let fontBold = field demoData "fontBold" int
let fontIcons = field demoData "fontIcons" int
let images = field demoData "images" (array 12 int)
let () = seal demoData

let loadDemoData__stub =
  foreign "loadDemoData" (ptr Nvg.context @-> ptr demoData @-> returning int)
let loadDemoData vg data =
  let res = loadDemoData__stub vg data in
  if res = 0 then true else false

let freeDemoData =
  foreign "freeDemoData" (ptr Nvg.context @-> ptr demoData @-> returning void)

let renderDemo =
  foreign "renderDemo"
    (ptr Nvg.context @-> float @-> float @-> float @-> float @-> float @-> int @-> ptr demoData @-> returning void)

let saveScreenShot__stub =
  foreign "saveScreenShot"
    (int @-> int @-> int @-> string @-> returning void)

let saveScreenShot a b c d =
  saveScreenShot__stub a b (Glfw3.int_of_bool c) d
