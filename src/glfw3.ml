open Ctypes
open PosixTypes
open Foreign


module GLFW =
struct
  let press =  1
  let key_space =  32
  let key_p =      80
  let key_s =      83
  let key_escape = 256

  type monitor
  let monitor : monitor structure typ = structure "GLFWmonitor"

  type window
  let window : window structure typ = structure "GLFWwindow"

  let errorfun = int @-> string @-> returning void
  let keyfun = ptr window @-> int @-> int @-> int @-> int @-> returning void
                                              
  let client_api = 0x00022001
  let context_version_major = 0x00022002
  let context_version_minor = 0x00022003
  let opengl_es_api = 0x00030002
end

let bool_of_int i =
  match i with
  | 0 -> false
  | _ -> true

let int_of_bool b =
  match b with
  | true -> 1
  | false -> 0

let glfwSetWindowShouldClose_stub =
  foreign "glfwSetWindowShouldClose" (ptr GLFW.window @-> int @-> returning void)

let glfwSetWindowShouldClose window value =
  glfwSetWindowShouldClose_stub window (int_of_bool value)

let glfwInit_stub = foreign "glfwInit" (void @-> returning int)

let glfwInit () = glfwInit_stub () |> bool_of_int
                    
let glfwSetErrorCallback =
  foreign "glfwSetErrorCallback" (funptr GLFW.errorfun @-> returning (funptr GLFW.errorfun))

let glfwWindowHint = foreign "glfwWindowHint" (int @-> int @-> returning void)
    
let glfwCreateWindow =
  foreign "glfwCreateWindow"
    (int @-> int @-> string @-> ptr GLFW.monitor @-> ptr GLFW.window @-> returning (ptr_opt GLFW.window))

let glfwTerminate = foreign "glfwTerminate" (void @-> returning void)
    
let glfwSetKeyCallback =
  foreign "glfwSetKeyCallback" (ptr GLFW.window @-> funptr GLFW.keyfun @-> returning (funptr GLFW.keyfun))
    
let glfwMakeContextCurrent =
  foreign "glfwMakeContextCurrent" (ptr GLFW.window @-> returning void)
