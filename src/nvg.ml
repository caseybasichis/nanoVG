module Bindings = Ffi_bindings.Bindings(Ffi_generated)

module Nvg =
struct
  exception Memory_error

  (* TODO: how to bind constants? *)
  let antialias       = 1 lsl 0
  let stencil_strokes = 1 lsl 1
  let debug           = 1 lsl 2

  include Nanovg_types

  (* Signatures that need to be manually refined *)
  let createGLES3 flags =
    match Bindings.createGLES3 flags with
    | Some x -> x
    | None -> raise Memory_error

  (* Signatures trivially generated from C sources *)
  let beginFrame = Bindings.beginFrame
  let cancelFrame = Bindings.cancelFrame
  let endFrame = Bindings.endFrame
  let rGB = Bindings.rGB
  let rGBf = Bindings.rGBf
  let rGBA = Bindings.rGBA
  let rGBAf = Bindings.rGBAf
  let lerpRGBA = Bindings.lerpRGBA
  let transRGBA = Bindings.transRGBA
  let transRGBAf = Bindings.transRGBAf
  let hSL = Bindings.hSL
  let hSLA = Bindings.hSLA
  let save = Bindings.save
  let restore = Bindings.restore
  let reset = Bindings.reset
  let strokeColor = Bindings.strokeColor
  let strokePaint = Bindings.strokePaint
  let fillColor = Bindings.fillColor
  let fillPaint = Bindings.fillPaint
  let miterLimit = Bindings.miterLimit
  let strokeWidth = Bindings.strokeWidth
  let lineCap = Bindings.lineCap
  let lineJoin = Bindings.lineJoin
  let globalAlpha = Bindings.globalAlpha
  let resetTransform = Bindings.resetTransform
  let transform = Bindings.transform
  let translate = Bindings.translate
  let rotate = Bindings.rotate
  let skewX = Bindings.skewX
  let skewY = Bindings.skewY
  let scale = Bindings.scale
  let currentTransform = Bindings.currentTransform
  let transformIdentity = Bindings.transformIdentity
  let transformTranslate = Bindings.transformTranslate
  let transformScale = Bindings.transformScale
  let transformRotate = Bindings.transformRotate
  let transformSkewX = Bindings.transformSkewX
  let transformSkewY = Bindings.transformSkewY
  let transformMultiply = Bindings.transformMultiply
  let transformPremultiply = Bindings.transformPremultiply
  let transformInverse = Bindings.transformInverse
  let transformPoint = Bindings.transformPoint
  let degToRad = Bindings.degToRad
  let radToDeg = Bindings.radToDeg
  let createImage = Bindings.createImage
  let createImageMem = Bindings.createImageMem
  let createImageRGBA = Bindings.createImageRGBA
  let updateImage = Bindings.updateImage
  let imageSize = Bindings.imageSize
  let deleteImage = Bindings.deleteImage
  let linearGradient = Bindings.linearGradient
  let boxGradient = Bindings.boxGradient
  let radialGradient = Bindings.radialGradient
  let imagePattern = Bindings.imagePattern
  let scissor = Bindings.scissor
  let intersectScissor = Bindings.intersectScissor
  let resetScissor = Bindings.resetScissor
  let beginPath = Bindings.beginPath
  let moveTo = Bindings.moveTo
  let lineTo = Bindings.lineTo
  let bezierTo = Bindings.bezierTo
  let quadTo = Bindings.quadTo
  let arcTo = Bindings.arcTo
  let closePath = Bindings.closePath
  let pathWinding = Bindings.pathWinding
  let arc = Bindings.arc
  let rect = Bindings.rect
  let roundedRect = Bindings.roundedRect
  let ellipse = Bindings.ellipse
  let circle = Bindings.circle
  let fill = Bindings.fill
  let stroke = Bindings.stroke
  let createFont = Bindings.createFont
  let createFontMem = Bindings.createFontMem
  let findFont = Bindings.findFont
  let fontSize = Bindings.fontSize
  let fontBlur = Bindings.fontBlur
  let textLetterSpacing = Bindings.textLetterSpacing
  let textLineHeight = Bindings.textLineHeight
  let textAlign = Bindings.textAlign
  let fontFaceId = Bindings.fontFaceId
  let fontFace = Bindings.fontFace
  let text = Bindings.text
  let textBox = Bindings.textBox
  let textBounds = Bindings.textBounds
  let textBoxBounds = Bindings.textBoxBounds
  let textGlyphPositions = Bindings.textGlyphPositions
  let textMetrics = Bindings.textMetrics
  let textBreakLines = Bindings.textBreakLines
  let createInternal = Bindings.createInternal
  let deleteInternal = Bindings.deleteInternal
  let internalParams = Bindings.internalParams
  let debugDumpPathCache = Bindings.debugDumpPathCache
  let deleteGLES3 = Bindings.deleteGLES3
  let lCreateImageFromHandle = Bindings.lCreateImageFromHandle
  let lImageHandle = Bindings.lImageHandle
end

include Nvg
