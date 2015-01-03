(*
open Glfw3
open GLFW

let graph_history_count = 100

type graphrender_style =
  | GRAPH_RENDER_FPS
  | GRAPH_RENDER_MS
  | GRAPH_RENDER_PERCENT

type perf_graph = {
	style : graphrender_style;
  name : string;
  values : float array;
  head : int;
}

let default_perf_graph = {
  style = GRAPH_RENDER_FPS;
  name = "";
  values = [||];
  head = 0;
}

let initGraph fps style name =
  { default_perf_graph with
    style = style;
    name = name;
  }
*)

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
