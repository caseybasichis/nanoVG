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
