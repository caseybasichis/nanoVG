open Ctypes
open PosixTypes
open Foreign

let graph_history_count = 100

type graphrenderStyle =
  | GRAPH_RENDER_FPS
  | GRAPH_RENDER_MS
  | GRAPH_RENDER_PERCENT

let int_of_graphrenderStyle = function
  | GRAPH_RENDER_FPS -> 0
  | GRAPH_RENDER_MS -> 1
  | GRAPH_RENDER_PERCENT -> 2

type perfGraph
let perfGraph : perfGraph structure typ = structure "perfGraph"
let style = field perfGraph "style" int
let name = field perfGraph "name" (array 32 char)
let values = field perfGraph "values" (array graph_history_count float)
let head = field perfGraph "head" int
let () = seal perfGraph

let initGraph__stub =
  foreign "initGraph" (ptr perfGraph @-> int @-> string @-> returning void)

let initGraph fps style name =
  initGraph__stub fps (int_of_graphrenderStyle style) name

let updateGraph =
  foreign "updateGraph" (ptr perfGraph @-> float @-> returning void)
    
let renderGraph =
  foreign "renderGraph" (ptr Nvg.context @-> float @-> float @-> ptr perfGraph @-> returning void);
