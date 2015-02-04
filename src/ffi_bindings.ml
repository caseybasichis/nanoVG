module Bindings(F : Cstubs.FOREIGN) =
struct
  let foreign = F.foreign

  open Nanovg_types

  include Nanovg_generated.Make(struct type 'a fn = 'a F.fn let foreign = F.foreign end)
end
