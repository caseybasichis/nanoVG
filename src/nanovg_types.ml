open Ctypes
open PosixTypes
open Foreign

type context
let context : context Ctypes.structure Ctypes.typ = Ctypes.structure "NVGcontext"

type color
let color : color Ctypes.structure Ctypes.typ = Ctypes.structure "NVGcolor"
let r = field color "r" float
let g = field color "g" float
let b = field color "b" float
let a = field color "a" float
let () = seal color

type paint
let paint : paint Ctypes.structure Ctypes.typ = Ctypes.structure "NVGpaint"
let xform = field paint "xform" (array 6 float)
let extent = field paint "extent" (array 2 float)
let radius = field paint "radius" float
let feather = field paint "feather" float
let innerColor = field paint "innerColor" color
let outerColor = field paint "outerColor" color
let image = field paint "image" int
let () = seal paint

type glyphPosition
let glyphPosition : glyphPosition Ctypes.structure Ctypes.typ = Ctypes.structure "NVGglyphPosition"
let str = field glyphPosition "str" string
let x = field glyphPosition "x" float
let minx = field glyphPosition "minx" float
let maxx = field glyphPosition "maxx" float
let () = seal glyphPosition

type textRow
let textRow: textRow Ctypes.structure Ctypes.typ = Ctypes.structure "NVGtextRow"
let start = field textRow "start" string
let end_ = field textRow "end" string
let next = field textRow "next" string
let width = field textRow "width" float
let minx = field textRow "minx" float
let maxx = field textRow "maxx" float
let () = seal textRow

(*
struct NVGparams {
	void* userPtr;
	int edgeAntiAlias;
	int (*renderCreate)(void* uptr);
	int (*renderCreateTexture)(void* uptr, int type, int w, int h, int imageFlags, const unsigned char* data);
	int (*renderDeleteTexture)(void* uptr, int image);
	int (*renderUpdateTexture)(void* uptr, int image, int x, int y, int w, int h, const unsigned char* data);
	int (*renderGetTextureSize)(void* uptr, int image, int* w, int* h);
	void (*renderViewport)(void* uptr, int width, int height);
	void (*renderCancel)(void* uptr);
	void (*renderFlush)(void* uptr);
	void (*renderFill)(void* uptr, NVGpaint* paint, NVGscissor* scissor, float fringe, const float* bounds, const NVGpath* paths, int npaths);
	void (*renderStroke)(void* uptr, NVGpaint* paint, NVGscissor* scissor, float fringe, float strokeWidth, const NVGpath* paths, int npaths);
	void (*renderTriangles)(void* uptr, NVGpaint* paint, NVGscissor* scissor, const NVGvertex* verts, int nverts);
	void (*renderDelete)(void* uptr);
};
*)*)*)*)*)*)*)*)*)*)*)*)*)

type params
let params : params Ctypes.structure Ctypes.typ = Ctypes.structure "NVGparams"
let userPtr = field params "userPtr" (ptr void)
let () = seal params
