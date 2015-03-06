#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re, StringIO

nanovg_h = """void nvgBeginFrame(NVGcontext* ctx, int windowWidth, int windowHeight, float devicePixelRatio);
void nvgCancelFrame(NVGcontext* ctx);
void nvgEndFrame(NVGcontext* ctx);
NVGcolor nvgRGB(unsigned char r, unsigned char g, unsigned char b);
NVGcolor nvgRGBf(float r, float g, float b);
NVGcolor nvgRGBA(unsigned char r, unsigned char g, unsigned char b, unsigned char a);
NVGcolor nvgRGBAf(float r, float g, float b, float a);
NVGcolor nvgLerpRGBA(NVGcolor c0, NVGcolor c1, float u);
NVGcolor nvgTransRGBA(NVGcolor c0, unsigned char a);
NVGcolor nvgTransRGBAf(NVGcolor c0, float a);
NVGcolor nvgHSL(float h, float s, float l);
NVGcolor nvgHSLA(float h, float s, float l, unsigned char a);
void nvgSave(NVGcontext* ctx);
void nvgRestore(NVGcontext* ctx);
void nvgReset(NVGcontext* ctx);
void nvgStrokeColor(NVGcontext* ctx, NVGcolor color);
void nvgStrokePaint(NVGcontext* ctx, NVGpaint paint);
void nvgFillColor(NVGcontext* ctx, NVGcolor color);
void nvgFillPaint(NVGcontext* ctx, NVGpaint paint);
void nvgMiterLimit(NVGcontext* ctx, float limit);
void nvgStrokeWidth(NVGcontext* ctx, float size);
void nvgLineCap(NVGcontext* ctx, int cap);
void nvgLineJoin(NVGcontext* ctx, int join);
void nvgGlobalAlpha(NVGcontext* ctx, float alpha);
void nvgResetTransform(NVGcontext* ctx);
void nvgTransform(NVGcontext* ctx, float a, float b, float c, float d, float e, float f);
void nvgTranslate(NVGcontext* ctx, float x, float y);
void nvgRotate(NVGcontext* ctx, float angle);
void nvgSkewX(NVGcontext* ctx, float angle);
void nvgSkewY(NVGcontext* ctx, float angle);
void nvgScale(NVGcontext* ctx, float x, float y);
void nvgCurrentTransform(NVGcontext* ctx, float* xform);
void nvgTransformIdentity(float* dst);
void nvgTransformTranslate(float* dst, float tx, float ty);
void nvgTransformScale(float* dst, float sx, float sy);
void nvgTransformRotate(float* dst, float a);
void nvgTransformSkewX(float* dst, float a);
void nvgTransformSkewY(float* dst, float a);
void nvgTransformMultiply(float* dst, const float* src);
void nvgTransformPremultiply(float* dst, const float* src);
int nvgTransformInverse(float* dst, const float* src);
void nvgTransformPoint(float* dstx, float* dsty, const float* xform, float srcx, float srcy);
float nvgDegToRad(float deg);
float nvgRadToDeg(float rad);
int nvgCreateImage(NVGcontext* ctx, const char* filename, int imageFlags);
int nvgCreateImageMem(NVGcontext* ctx, int imageFlags, unsigned char* data, int ndata);
int nvgCreateImageRGBA(NVGcontext* ctx, int w, int h, int imageFlags, const unsigned char* data);
void nvgUpdateImage(NVGcontext* ctx, int image, const unsigned char* data);
void nvgImageSize(NVGcontext* ctx, int image, int* w, int* h);
void nvgDeleteImage(NVGcontext* ctx, int image);
NVGpaint nvgLinearGradient(NVGcontext* ctx, float sx, float sy, float ex, float ey, NVGcolor icol, NVGcolor ocol);
NVGpaint nvgBoxGradient(NVGcontext* ctx, float x, float y, float w, float h, float r, float f, NVGcolor icol, NVGcolor ocol);
NVGpaint nvgRadialGradient(NVGcontext* ctx, float cx, float cy, float inr, float outr, NVGcolor icol, NVGcolor ocol);
NVGpaint nvgImagePattern(NVGcontext* ctx, float ox, float oy, float ex, float ey, float angle, int image, float alpha);
void nvgScissor(NVGcontext* ctx, float x, float y, float w, float h);
void nvgIntersectScissor(NVGcontext* ctx, float x, float y, float w, float h);
void nvgResetScissor(NVGcontext* ctx);
void nvgBeginPath(NVGcontext* ctx);
void nvgMoveTo(NVGcontext* ctx, float x, float y);
void nvgLineTo(NVGcontext* ctx, float x, float y);
void nvgBezierTo(NVGcontext* ctx, float c1x, float c1y, float c2x, float c2y, float x, float y);
void nvgQuadTo(NVGcontext* ctx, float cx, float cy, float x, float y);
void nvgArcTo(NVGcontext* ctx, float x1, float y1, float x2, float y2, float radius);
void nvgClosePath(NVGcontext* ctx);
void nvgPathWinding(NVGcontext* ctx, int dir);
void nvgArc(NVGcontext* ctx, float cx, float cy, float r, float a0, float a1, int dir);
void nvgRect(NVGcontext* ctx, float x, float y, float w, float h);
void nvgRoundedRect(NVGcontext* ctx, float x, float y, float w, float h, float r);
void nvgEllipse(NVGcontext* ctx, float cx, float cy, float rx, float ry);
void nvgCircle(NVGcontext* ctx, float cx, float cy, float r);
void nvgFill(NVGcontext* ctx);
void nvgStroke(NVGcontext* ctx);
int nvgCreateFont(NVGcontext* ctx, const char* name, const char* filename);
int nvgCreateFontMem(NVGcontext* ctx, const char* name, unsigned char* data, int ndata, int freeData);
int nvgFindFont(NVGcontext* ctx, const char* name);
void nvgFontSize(NVGcontext* ctx, float size);
void nvgFontBlur(NVGcontext* ctx, float blur);
void nvgTextLetterSpacing(NVGcontext* ctx, float spacing);
void nvgTextLineHeight(NVGcontext* ctx, float lineHeight);
void nvgTextAlign(NVGcontext* ctx, int align);
void nvgFontFaceId(NVGcontext* ctx, int font);
void nvgFontFace(NVGcontext* ctx, const char* font);
float nvgText(NVGcontext* ctx, float x, float y, const char* string, const char* end);
void nvgTextBox(NVGcontext* ctx, float x, float y, float breakRowWidth, const char* string, const char* end);
float nvgTextBounds(NVGcontext* ctx, float x, float y, const char* string, const char* end, float* bounds);
void nvgTextBoxBounds(NVGcontext* ctx, float x, float y, float breakRowWidth, const char* string, const char* end, float* bounds);
int nvgTextGlyphPositions(NVGcontext* ctx, float x, float y, const char* string, const char* end, NVGglyphPosition* positions, int maxPositions);
void nvgTextMetrics(NVGcontext* ctx, float* ascender, float* descender, float* lineh);
int nvgTextBreakLines(NVGcontext* ctx, const char* string, const char* end, float breakRowWidth, NVGtextRow* rows, int maxRows);
NVGcontext* nvgCreateInternal(NVGparams* params);
void nvgDeleteInternal(NVGcontext* ctx);
NVGparams* nvgInternalParams(NVGcontext* ctx);
void nvgDebugDumpPathCache(NVGcontext* ctx);"""

nanovg_gl_h = """NVGcontext* nvgCreateGLES2(int flags);
void nvgDeleteGLES2(NVGcontext* ctx);
int nvglCreateImageFromHandle(NVGcontext* ctx, GLuint textureId, int w, int h, int flags);
GLuint nvglImageHandle(NVGcontext* ctx, int image);"""

KNOWN_TYPES = set([
    'int', 'float', 'void', 'color', 'paint', 'ptr float', 'const char',
    'ptr uchar', 'const unsigned char', 'ptr int', 'ptr glyphPosition',
    'ptr textRow', 'ptr params', 'uint', 'ptr_opt context'
])

def translate_parameter(type_):
    if type_.endswith('*'):
        type_ = 'ptr ' + translate_parameter(type_[:-1])

    if type_ == 'ptr const char':
        ctypes_type = 'string'
    elif type_ == 'unsigned char':
        ctypes_type = 'uchar'
    elif type_ == 'ptr const unsigned char':
        ctypes_type = 'ptr uchar'
    elif type_ == 'ptr context':
        ctypes_type = 'ptr context'
    elif type_ == 'NVGcontext':
        ctypes_type = 'context'
    elif type_ == 'NVGcolor':
        ctypes_type = 'color'
    elif type_ == 'NVGpaint':
        ctypes_type = 'paint'
    elif type_ == 'NVGglyphPosition':
        ctypes_type = 'glyphPosition'
    elif type_ == 'NVGtextRow':
        ctypes_type = 'textRow'
    elif type_ == 'NVGparams':
        ctypes_type = 'params'
    elif type_ == 'const float':
        ctypes_type = 'float'
    elif type_ == 'GLuint':
        ctypes_type = 'uint'
    elif type_ in KNOWN_TYPES:
        ctypes_type = type_
    else:
        raise RuntimeError(u'Unknown type: %s' % type_)
        ctypes_type = type_
    return ctypes_type

def return_optional_pointer(name, return_):
    if name == 'nvgCreateGLES2':
        return 'ptr_opt context'
    else:
        return return_

def print_function_bind(output_file, name, parameters, return_):
    bind_name = None
    if name.startswith('nvg'):
        bind_name = name[3].lower() + name[4:]
    else:
        bind_name = name
    parameters = [ translate_parameter(p[0]) for p in parameters ]

    return_ = translate_parameter(return_)
    return_ = return_optional_pointer(name, return_)
    if return_.find(' ') != -1:
        return_ = 'returning (%s)' % translate_parameter(return_)
    else:
        return_ = 'returning %s' % translate_parameter(return_)
    parameters.append(return_)

    output_file.write('  let %s = foreign "%s"\n' % (bind_name, name))
    output_file.write('      Ctypes.(%s)' % (' @-> '.join(parameters)))
    output_file.write('\n\n')

in_memory_file = StringIO.StringIO()
in_memory_file.write("""module Make(F : Cstubs.FOREIGN) =
struct
  let foreign = F.foreign

  open Nanovg_types\n\n""")

for c_content in [nanovg_h, nanovg_gl_h]:
    lines = c_content.split('\n')
    for l in lines:
        l = l.strip()
        res = re.match(r'([^ ]+) (.*)', l)
        return_type = res.group(1)
        rest = res.group(2)

        res = re.match(r'([^(]+)\((.*)\);$', rest)
        funtion_name = res.group(1).strip()
        parameters = res.group(2).strip()

        parameters = [ p.strip() for p in parameters.split(',') ]
        parameters_1 = parameters
        parameters = []
        for p in parameters_1:
            tokens = [ t for t in p.split() if t != '' ]
            par_name = tokens[-1]
            par_type = ' '.join(tokens[:-1])
            parameters.append((par_type, par_name))
        print_function_bind(in_memory_file, funtion_name, parameters, return_type)
in_memory_file.write('end')

in_memory_file_content = in_memory_file.getvalue()
output_file_name = 'src/nanovg_generated.ml'
try:
    real_file = open(output_file_name, 'r')
    real_file_content = real_file.read()
    real_file.close()
    if in_memory_file_content != real_file_content:
        print 'Writing file ', output_file_name
        real_file = open(output_file_name, 'w')
        real_file.write(in_memory_file_content)
        real_file.close()
except IOError:
    print 'Writing file ', output_file_name
    real_file = open(output_file_name, 'w')
    real_file.write(in_memory_file_content)
    real_file.close()
