open Ctypes
open PosixTypes
open Foreign

let graph_history_count = 100

type graph_render_style =
  | GRAPH_RENDER_FPS
  | GRAPH_RENDER_MS
  | GRAPH_RENDER_PERCENT

let int_of_graph_render_style = function
  | GRAPH_RENDER_FPS -> 0
  | GRAPH_RENDER_MS -> 1
  | GRAPH_RENDER_PERCENT -> 2

type perf_graph
let perf_graph : perf_graph structure typ = structure "perfGraph"
let style = field perf_graph "style" int
let name = field perf_graph "name" (array 32 char)
let values = field perf_graph "values" (array graph_history_count float)
let head = field perf_graph "head" int
let () = seal perf_graph

let init_graph =
  foreign "initGraph" (ptr perf_graph @-> int @-> string @-> returning void)

let init_graph fps style name =
  init_graph fps (int_of_graph_render_style style) name

let update_graph =
  foreign "updateGraph" (ptr perf_graph @-> float @-> returning void)

let render_graph =
  foreign "renderGraph" (ptr Nanovg.context @-> float @-> float @-> ptr perf_graph @-> returning void);
