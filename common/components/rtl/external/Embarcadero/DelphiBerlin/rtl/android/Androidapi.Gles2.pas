{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Gles2;

interface

uses Posix.SysTypes,
     Androidapi.KhrPlatform;

{$I Androidapi.inc}

type
  GLchar = ShortInt;
  {$EXTERNALSYM GLchar}
  GLenum = UInt32;
  {$EXTERNALSYM GLenum}
  GLboolean = Byte;
  {$EXTERNALSYM GLboolean}
  GLbitfield = UInt32;
  {$EXTERNALSYM GLbitfield}
  GLbyte = khronos_int8_t;
  {$EXTERNALSYM GLbyte}
  GLshort = SmallInt;
  {$EXTERNALSYM GLshort}
  GLint = Integer;
  {$EXTERNALSYM GLint}
  GLsizei = Integer;
  {$EXTERNALSYM GLsizei}
  GLubyte = khronos_uint8_t;
  {$EXTERNALSYM GLubyte}
  GLushort = UInt16;
  {$EXTERNALSYM GLushort}
  GLuint = UInt32;
  {$EXTERNALSYM GLuint}
  GLfloat = khronos_float_t;
  {$EXTERNALSYM GLfloat}
  GLclampf = khronos_float_t;
  {$EXTERNALSYM GLclampf}
  GLfixed = khronos_int32_t;
  {$EXTERNALSYM GLfixed}
  GLclampx = khronos_int32_t;
  {$EXTERNALSYM GLclampx}

  GLintptr = khronos_intptr_t;
  {$EXTERNALSYM GLintptr}
  GLsizeiptr = khronos_ssize_t;
  {$EXTERNALSYM GLsizeiptr}

  PGLchar = MarshaledAString;
  PPGLchar = ^PGLchar;
  PGLenum = ^GLenum;
  PGLsizei = ^GLsizei;
  PGLfloat = ^GLfloat;
  PGLshort = ^GLshort;
  PGLvoid = Pointer;
  PPGLvoid = ^PGLvoid;
  PGLubyte = ^GLubyte;
  PGLint = ^GLint;
  PGLboolean = ^GLboolean;
  PGLuint = ^GLuint;
  PGLfixed = ^GLfixed;

const
{  OpenGL ES core versions }
  GL_ES_VERSION_2_0 = 1; 
  {$EXTERNALSYM GL_ES_VERSION_2_0}

{  ClearBufferMask }
  GL_DEPTH_BUFFER_BIT = $00000100; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT}
  GL_STENCIL_BUFFER_BIT = $00000400; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT}
  GL_COLOR_BUFFER_BIT = $00004000; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT}

{  Boolean }
  GL_FALSE = 0; 
  {$EXTERNALSYM GL_FALSE}
  GL_TRUE = 1; 
  {$EXTERNALSYM GL_TRUE}

{  BeginMode }
  GL_POINTS = $0000; 
  {$EXTERNALSYM GL_POINTS}
  GL_LINES = $0001; 
  {$EXTERNALSYM GL_LINES}
  GL_LINE_LOOP = $0002; 
  {$EXTERNALSYM GL_LINE_LOOP}
  GL_LINE_STRIP = $0003; 
  {$EXTERNALSYM GL_LINE_STRIP}
  GL_TRIANGLES = $0004; 
  {$EXTERNALSYM GL_TRIANGLES}
  GL_TRIANGLE_STRIP = $0005; 
  {$EXTERNALSYM GL_TRIANGLE_STRIP}
  GL_TRIANGLE_FAN = $0006; 
  {$EXTERNALSYM GL_TRIANGLE_FAN}

{  AlphaFunction (not supported in ES20) }
{       GL_NEVER }
{       GL_LESS }
{       GL_EQUAL }
{       GL_LEQUAL }
{       GL_GREATER }
{       GL_NOTEQUAL }
{       GL_GEQUAL }
{       GL_ALWAYS }

{  BlendingFactorDest }
  GL_ZERO = 0; 
  {$EXTERNALSYM GL_ZERO}
  GL_ONE = 1; 
  {$EXTERNALSYM GL_ONE}
  GL_SRC_COLOR = $0300; 
  {$EXTERNALSYM GL_SRC_COLOR}
  GL_ONE_MINUS_SRC_COLOR = $0301; 
  {$EXTERNALSYM GL_ONE_MINUS_SRC_COLOR}
  GL_SRC_ALPHA = $0302; 
  {$EXTERNALSYM GL_SRC_ALPHA}
  GL_ONE_MINUS_SRC_ALPHA = $0303; 
  {$EXTERNALSYM GL_ONE_MINUS_SRC_ALPHA}
  GL_DST_ALPHA = $0304; 
  {$EXTERNALSYM GL_DST_ALPHA}
  GL_ONE_MINUS_DST_ALPHA = $0305; 
  {$EXTERNALSYM GL_ONE_MINUS_DST_ALPHA}

{  BlendingFactorSrc }
{       GL_ZERO }
{       GL_ONE }
  GL_DST_COLOR = $0306; 
  {$EXTERNALSYM GL_DST_COLOR}
  GL_ONE_MINUS_DST_COLOR = $0307; 
  {$EXTERNALSYM GL_ONE_MINUS_DST_COLOR}
  GL_SRC_ALPHA_SATURATE = $0308; 
  {$EXTERNALSYM GL_SRC_ALPHA_SATURATE}
{       GL_SRC_ALPHA }
{       GL_ONE_MINUS_SRC_ALPHA }
{       GL_DST_ALPHA }
{       GL_ONE_MINUS_DST_ALPHA }

{  BlendEquationSeparate }
  GL_FUNC_ADD = $8006; 
  {$EXTERNALSYM GL_FUNC_ADD}
  GL_BLEND_EQUATION = $8009; 
  {$EXTERNALSYM GL_BLEND_EQUATION}
  GL_BLEND_EQUATION_RGB = $8009; 
  {$EXTERNALSYM GL_BLEND_EQUATION_RGB}
  GL_BLEND_EQUATION_ALPHA = $883D; 
  {$EXTERNALSYM GL_BLEND_EQUATION_ALPHA}

{  BlendSubtract }
  GL_FUNC_SUBTRACT = $800A; 
  {$EXTERNALSYM GL_FUNC_SUBTRACT}
  GL_FUNC_REVERSE_SUBTRACT = $800B; 
  {$EXTERNALSYM GL_FUNC_REVERSE_SUBTRACT}

{  Separate Blend Functions }
  GL_BLEND_DST_RGB = $80C8; 
  {$EXTERNALSYM GL_BLEND_DST_RGB}
  GL_BLEND_SRC_RGB = $80C9; 
  {$EXTERNALSYM GL_BLEND_SRC_RGB}
  GL_BLEND_DST_ALPHA = $80CA; 
  {$EXTERNALSYM GL_BLEND_DST_ALPHA}
  GL_BLEND_SRC_ALPHA = $80CB; 
  {$EXTERNALSYM GL_BLEND_SRC_ALPHA}
  GL_CONSTANT_COLOR = $8001; 
  {$EXTERNALSYM GL_CONSTANT_COLOR}
  GL_ONE_MINUS_CONSTANT_COLOR = $8002; 
  {$EXTERNALSYM GL_ONE_MINUS_CONSTANT_COLOR}
  GL_CONSTANT_ALPHA = $8003; 
  {$EXTERNALSYM GL_CONSTANT_ALPHA}
  GL_ONE_MINUS_CONSTANT_ALPHA = $8004; 
  {$EXTERNALSYM GL_ONE_MINUS_CONSTANT_ALPHA}
  GL_BLEND_COLOR = $8005; 
  {$EXTERNALSYM GL_BLEND_COLOR}

{  Buffer Objects }
  GL_ARRAY_BUFFER = $8892; 
  {$EXTERNALSYM GL_ARRAY_BUFFER}
  GL_ELEMENT_ARRAY_BUFFER = $8893; 
  {$EXTERNALSYM GL_ELEMENT_ARRAY_BUFFER}
  GL_ARRAY_BUFFER_BINDING = $8894; 
  {$EXTERNALSYM GL_ARRAY_BUFFER_BINDING}
  GL_ELEMENT_ARRAY_BUFFER_BINDING = $8895; 
  {$EXTERNALSYM GL_ELEMENT_ARRAY_BUFFER_BINDING}

  GL_STREAM_DRAW = $88E0; 
  {$EXTERNALSYM GL_STREAM_DRAW}
  GL_STATIC_DRAW = $88E4; 
  {$EXTERNALSYM GL_STATIC_DRAW}
  GL_DYNAMIC_DRAW = $88E8; 
  {$EXTERNALSYM GL_DYNAMIC_DRAW}

  GL_BUFFER_SIZE = $8764; 
  {$EXTERNALSYM GL_BUFFER_SIZE}
  GL_BUFFER_USAGE = $8765; 
  {$EXTERNALSYM GL_BUFFER_USAGE}

  GL_CURRENT_VERTEX_ATTRIB = $8626; 
  {$EXTERNALSYM GL_CURRENT_VERTEX_ATTRIB}

{  CullFaceMode }
  GL_FRONT = $0404; 
  {$EXTERNALSYM GL_FRONT}
  GL_BACK = $0405; 
  {$EXTERNALSYM GL_BACK}
  GL_FRONT_AND_BACK = $0408; 
  {$EXTERNALSYM GL_FRONT_AND_BACK}

{  DepthFunction }
{       GL_NEVER }
{       GL_LESS }
{       GL_EQUAL }
{       GL_LEQUAL }
{       GL_GREATER }
{       GL_NOTEQUAL }
{       GL_GEQUAL }
{       GL_ALWAYS }

{  EnableCap }
  GL_TEXTURE_2D = $0DE1; 
  {$EXTERNALSYM GL_TEXTURE_2D}
  GL_CULL_FACE = $0B44; 
  {$EXTERNALSYM GL_CULL_FACE}
  GL_BLEND = $0BE2; 
  {$EXTERNALSYM GL_BLEND}
  GL_DITHER = $0BD0; 
  {$EXTERNALSYM GL_DITHER}
  GL_STENCIL_TEST = $0B90; 
  {$EXTERNALSYM GL_STENCIL_TEST}
  GL_DEPTH_TEST = $0B71; 
  {$EXTERNALSYM GL_DEPTH_TEST}
  GL_SCISSOR_TEST = $0C11; 
  {$EXTERNALSYM GL_SCISSOR_TEST}
  GL_POLYGON_OFFSET_FILL = $8037; 
  {$EXTERNALSYM GL_POLYGON_OFFSET_FILL}
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E; 
  {$EXTERNALSYM GL_SAMPLE_ALPHA_TO_COVERAGE}
  GL_SAMPLE_COVERAGE = $80A0; 
  {$EXTERNALSYM GL_SAMPLE_COVERAGE}

{  ErrorCode }
  GL_NO_ERROR = 0; 
  {$EXTERNALSYM GL_NO_ERROR}
  GL_INVALID_ENUM = $0500; 
  {$EXTERNALSYM GL_INVALID_ENUM}
  GL_INVALID_VALUE = $0501; 
  {$EXTERNALSYM GL_INVALID_VALUE}
  GL_INVALID_OPERATION = $0502; 
  {$EXTERNALSYM GL_INVALID_OPERATION}
  GL_OUT_OF_MEMORY = $0505; 
  {$EXTERNALSYM GL_OUT_OF_MEMORY}

{  FrontFaceDirection }
  GL_CW = $0900; 
  {$EXTERNALSYM GL_CW}
  GL_CCW = $0901; 
  {$EXTERNALSYM GL_CCW}

{  GetPName }
  GL_LINE_WIDTH = $0B21; 
  {$EXTERNALSYM GL_LINE_WIDTH}
  GL_ALIASED_POINT_SIZE_RANGE = $846D; 
  {$EXTERNALSYM GL_ALIASED_POINT_SIZE_RANGE}
  GL_ALIASED_LINE_WIDTH_RANGE = $846E; 
  {$EXTERNALSYM GL_ALIASED_LINE_WIDTH_RANGE}
  GL_CULL_FACE_MODE = $0B45; 
  {$EXTERNALSYM GL_CULL_FACE_MODE}
  GL_FRONT_FACE = $0B46; 
  {$EXTERNALSYM GL_FRONT_FACE}
  GL_DEPTH_RANGE = $0B70; 
  {$EXTERNALSYM GL_DEPTH_RANGE}
  GL_DEPTH_WRITEMASK = $0B72; 
  {$EXTERNALSYM GL_DEPTH_WRITEMASK}
  GL_DEPTH_CLEAR_VALUE = $0B73; 
  {$EXTERNALSYM GL_DEPTH_CLEAR_VALUE}
  GL_DEPTH_FUNC = $0B74; 
  {$EXTERNALSYM GL_DEPTH_FUNC}
  GL_STENCIL_CLEAR_VALUE = $0B91; 
  {$EXTERNALSYM GL_STENCIL_CLEAR_VALUE}
  GL_STENCIL_FUNC = $0B92; 
  {$EXTERNALSYM GL_STENCIL_FUNC}
  GL_STENCIL_FAIL = $0B94; 
  {$EXTERNALSYM GL_STENCIL_FAIL}
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95; 
  {$EXTERNALSYM GL_STENCIL_PASS_DEPTH_FAIL}
  GL_STENCIL_PASS_DEPTH_PASS = $0B96; 
  {$EXTERNALSYM GL_STENCIL_PASS_DEPTH_PASS}
  GL_STENCIL_REF = $0B97; 
  {$EXTERNALSYM GL_STENCIL_REF}
  GL_STENCIL_VALUE_MASK = $0B93; 
  {$EXTERNALSYM GL_STENCIL_VALUE_MASK}
  GL_STENCIL_WRITEMASK = $0B98; 
  {$EXTERNALSYM GL_STENCIL_WRITEMASK}
  GL_STENCIL_BACK_FUNC = $8800; 
  {$EXTERNALSYM GL_STENCIL_BACK_FUNC}
  GL_STENCIL_BACK_FAIL = $8801; 
  {$EXTERNALSYM GL_STENCIL_BACK_FAIL}
  GL_STENCIL_BACK_PASS_DEPTH_FAIL = $8802; 
  {$EXTERNALSYM GL_STENCIL_BACK_PASS_DEPTH_FAIL}
  GL_STENCIL_BACK_PASS_DEPTH_PASS = $8803; 
  {$EXTERNALSYM GL_STENCIL_BACK_PASS_DEPTH_PASS}
  GL_STENCIL_BACK_REF = $8CA3; 
  {$EXTERNALSYM GL_STENCIL_BACK_REF}
  GL_STENCIL_BACK_VALUE_MASK = $8CA4; 
  {$EXTERNALSYM GL_STENCIL_BACK_VALUE_MASK}
  GL_STENCIL_BACK_WRITEMASK = $8CA5; 
  {$EXTERNALSYM GL_STENCIL_BACK_WRITEMASK}
  GL_VIEWPORT = $0BA2; 
  {$EXTERNALSYM GL_VIEWPORT}
  GL_SCISSOR_BOX = $0C10; 
  {$EXTERNALSYM GL_SCISSOR_BOX}
{       GL_SCISSOR_TEST }
  GL_COLOR_CLEAR_VALUE = $0C22; 
  {$EXTERNALSYM GL_COLOR_CLEAR_VALUE}
  GL_COLOR_WRITEMASK = $0C23; 
  {$EXTERNALSYM GL_COLOR_WRITEMASK}
  GL_UNPACK_ALIGNMENT = $0CF5; 
  {$EXTERNALSYM GL_UNPACK_ALIGNMENT}
  GL_PACK_ALIGNMENT = $0D05; 
  {$EXTERNALSYM GL_PACK_ALIGNMENT}
  GL_MAX_TEXTURE_SIZE = $0D33; 
  {$EXTERNALSYM GL_MAX_TEXTURE_SIZE}
  GL_MAX_VIEWPORT_DIMS = $0D3A; 
  {$EXTERNALSYM GL_MAX_VIEWPORT_DIMS}
  GL_SUBPIXEL_BITS = $0D50; 
  {$EXTERNALSYM GL_SUBPIXEL_BITS}
  GL_RED_BITS = $0D52; 
  {$EXTERNALSYM GL_RED_BITS}
  GL_GREEN_BITS = $0D53; 
  {$EXTERNALSYM GL_GREEN_BITS}
  GL_BLUE_BITS = $0D54; 
  {$EXTERNALSYM GL_BLUE_BITS}
  GL_ALPHA_BITS = $0D55; 
  {$EXTERNALSYM GL_ALPHA_BITS}
  GL_DEPTH_BITS = $0D56; 
  {$EXTERNALSYM GL_DEPTH_BITS}
  GL_STENCIL_BITS = $0D57; 
  {$EXTERNALSYM GL_STENCIL_BITS}
  GL_POLYGON_OFFSET_UNITS = $2A00; 
  {$EXTERNALSYM GL_POLYGON_OFFSET_UNITS}
{       GL_POLYGON_OFFSET_FILL }
  GL_POLYGON_OFFSET_FACTOR = $8038; 
  {$EXTERNALSYM GL_POLYGON_OFFSET_FACTOR}
  GL_TEXTURE_BINDING_2D = $8069; 
  {$EXTERNALSYM GL_TEXTURE_BINDING_2D}
  GL_SAMPLE_BUFFERS = $80A8; 
  {$EXTERNALSYM GL_SAMPLE_BUFFERS}
  GL_SAMPLES = $80A9; 
  {$EXTERNALSYM GL_SAMPLES}
  GL_SAMPLE_COVERAGE_VALUE = $80AA; 
  {$EXTERNALSYM GL_SAMPLE_COVERAGE_VALUE}
  GL_SAMPLE_COVERAGE_INVERT = $80AB; 
  {$EXTERNALSYM GL_SAMPLE_COVERAGE_INVERT}

{  GetTextureParameter }
{       GL_TEXTURE_MAG_FILTER }
{       GL_TEXTURE_MIN_FILTER }
{       GL_TEXTURE_WRAP_S }
{       GL_TEXTURE_WRAP_T }

  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2; 
  {$EXTERNALSYM GL_NUM_COMPRESSED_TEXTURE_FORMATS}
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3; 
  {$EXTERNALSYM GL_COMPRESSED_TEXTURE_FORMATS}

{  HintMode }
  GL_DONT_CARE = $1100; 
  {$EXTERNALSYM GL_DONT_CARE}
  GL_FASTEST = $1101; 
  {$EXTERNALSYM GL_FASTEST}
  GL_NICEST = $1102; 
  {$EXTERNALSYM GL_NICEST}

{  HintTarget }
  GL_GENERATE_MIPMAP_HINT = $8192; 
  {$EXTERNALSYM GL_GENERATE_MIPMAP_HINT}

{  DataType }
  GL_BYTE = $1400; 
  {$EXTERNALSYM GL_BYTE}
  GL_UNSIGNED_BYTE = $1401; 
  {$EXTERNALSYM GL_UNSIGNED_BYTE}
  GL_SHORT = $1402; 
  {$EXTERNALSYM GL_SHORT}
  GL_UNSIGNED_SHORT = $1403; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT}
  GL_INT = $1404; 
  {$EXTERNALSYM GL_INT}
  GL_UNSIGNED_INT = $1405; 
  {$EXTERNALSYM GL_UNSIGNED_INT}
  GL_FLOAT = $1406; 
  {$EXTERNALSYM GL_FLOAT}
  GL_FIXED = $140C; 
  {$EXTERNALSYM GL_FIXED}

{  PixelFormat }
  GL_DEPTH_COMPONENT = $1902; 
  {$EXTERNALSYM GL_DEPTH_COMPONENT}
  GL_ALPHA = $1906; 
  {$EXTERNALSYM GL_ALPHA}
  GL_RGB = $1907; 
  {$EXTERNALSYM GL_RGB}
  GL_RGBA = $1908; 
  {$EXTERNALSYM GL_RGBA}
  GL_LUMINANCE = $1909; 
  {$EXTERNALSYM GL_LUMINANCE}
  GL_LUMINANCE_ALPHA = $190A; 
  {$EXTERNALSYM GL_LUMINANCE_ALPHA}

{  PixelType }
{       GL_UNSIGNED_BYTE }
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT_4_4_4_4}
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT_5_5_5_1}
  GL_UNSIGNED_SHORT_5_6_5 = $8363; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT_5_6_5}

{  Shaders }
  GL_FRAGMENT_SHADER = $8B30; 
  {$EXTERNALSYM GL_FRAGMENT_SHADER}
  GL_VERTEX_SHADER = $8B31; 
  {$EXTERNALSYM GL_VERTEX_SHADER}
  GL_MAX_VERTEX_ATTRIBS = $8869; 
  {$EXTERNALSYM GL_MAX_VERTEX_ATTRIBS}
  GL_MAX_VERTEX_UNIFORM_VECTORS = $8DFB; 
  {$EXTERNALSYM GL_MAX_VERTEX_UNIFORM_VECTORS}
  GL_MAX_VARYING_VECTORS = $8DFC; 
  {$EXTERNALSYM GL_MAX_VARYING_VECTORS}
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS = $8B4D; 
  {$EXTERNALSYM GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS}
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS = $8B4C; 
  {$EXTERNALSYM GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS}
  GL_MAX_TEXTURE_IMAGE_UNITS = $8872; 
  {$EXTERNALSYM GL_MAX_TEXTURE_IMAGE_UNITS}
  GL_MAX_FRAGMENT_UNIFORM_VECTORS = $8DFD; 
  {$EXTERNALSYM GL_MAX_FRAGMENT_UNIFORM_VECTORS}
  GL_SHADER_TYPE = $8B4F; 
  {$EXTERNALSYM GL_SHADER_TYPE}
  GL_DELETE_STATUS = $8B80; 
  {$EXTERNALSYM GL_DELETE_STATUS}
  GL_LINK_STATUS = $8B82; 
  {$EXTERNALSYM GL_LINK_STATUS}
  GL_VALIDATE_STATUS = $8B83; 
  {$EXTERNALSYM GL_VALIDATE_STATUS}
  GL_ATTACHED_SHADERS = $8B85; 
  {$EXTERNALSYM GL_ATTACHED_SHADERS}
  GL_ACTIVE_UNIFORMS = $8B86; 
  {$EXTERNALSYM GL_ACTIVE_UNIFORMS}
  GL_ACTIVE_UNIFORM_MAX_LENGTH = $8B87; 
  {$EXTERNALSYM GL_ACTIVE_UNIFORM_MAX_LENGTH}
  GL_ACTIVE_ATTRIBUTES = $8B89; 
  {$EXTERNALSYM GL_ACTIVE_ATTRIBUTES}
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH = $8B8A; 
  {$EXTERNALSYM GL_ACTIVE_ATTRIBUTE_MAX_LENGTH}
  GL_SHADING_LANGUAGE_VERSION = $8B8C; 
  {$EXTERNALSYM GL_SHADING_LANGUAGE_VERSION}
  GL_CURRENT_PROGRAM = $8B8D; 
  {$EXTERNALSYM GL_CURRENT_PROGRAM}

{  StencilFunction }
  GL_NEVER = $0200; 
  {$EXTERNALSYM GL_NEVER}
  GL_LESS = $0201; 
  {$EXTERNALSYM GL_LESS}
  GL_EQUAL = $0202; 
  {$EXTERNALSYM GL_EQUAL}
  GL_LEQUAL = $0203; 
  {$EXTERNALSYM GL_LEQUAL}
  GL_GREATER = $0204; 
  {$EXTERNALSYM GL_GREATER}
  GL_NOTEQUAL = $0205; 
  {$EXTERNALSYM GL_NOTEQUAL}
  GL_GEQUAL = $0206; 
  {$EXTERNALSYM GL_GEQUAL}
  GL_ALWAYS = $0207; 
  {$EXTERNALSYM GL_ALWAYS}

{  StencilOp }
{       GL_ZERO }
  GL_KEEP = $1E00; 
  {$EXTERNALSYM GL_KEEP}
  GL_REPLACE = $1E01; 
  {$EXTERNALSYM GL_REPLACE}
  GL_INCR = $1E02; 
  {$EXTERNALSYM GL_INCR}
  GL_DECR = $1E03; 
  {$EXTERNALSYM GL_DECR}
  GL_INVERT = $150A; 
  {$EXTERNALSYM GL_INVERT}
  GL_INCR_WRAP = $8507; 
  {$EXTERNALSYM GL_INCR_WRAP}
  GL_DECR_WRAP = $8508; 
  {$EXTERNALSYM GL_DECR_WRAP}

{  StringName }
  GL_VENDOR = $1F00; 
  {$EXTERNALSYM GL_VENDOR}
  GL_RENDERER = $1F01; 
  {$EXTERNALSYM GL_RENDERER}
  GL_VERSION = $1F02; 
  {$EXTERNALSYM GL_VERSION}
  GL_EXTENSIONS = $1F03; 
  {$EXTERNALSYM GL_EXTENSIONS}

{  TextureMagFilter }
  GL_NEAREST = $2600; 
  {$EXTERNALSYM GL_NEAREST}
  GL_LINEAR = $2601; 
  {$EXTERNALSYM GL_LINEAR}

{  TextureMinFilter }
{       GL_NEAREST }
{       GL_LINEAR }
  GL_NEAREST_MIPMAP_NEAREST = $2700; 
  {$EXTERNALSYM GL_NEAREST_MIPMAP_NEAREST}
  GL_LINEAR_MIPMAP_NEAREST = $2701; 
  {$EXTERNALSYM GL_LINEAR_MIPMAP_NEAREST}
  GL_NEAREST_MIPMAP_LINEAR = $2702; 
  {$EXTERNALSYM GL_NEAREST_MIPMAP_LINEAR}
  GL_LINEAR_MIPMAP_LINEAR = $2703; 
  {$EXTERNALSYM GL_LINEAR_MIPMAP_LINEAR}

{  TextureParameterName }
  GL_TEXTURE_MAG_FILTER = $2800; 
  {$EXTERNALSYM GL_TEXTURE_MAG_FILTER}
  GL_TEXTURE_MIN_FILTER = $2801; 
  {$EXTERNALSYM GL_TEXTURE_MIN_FILTER}
  GL_TEXTURE_WRAP_S = $2802; 
  {$EXTERNALSYM GL_TEXTURE_WRAP_S}
  GL_TEXTURE_WRAP_T = $2803; 
  {$EXTERNALSYM GL_TEXTURE_WRAP_T}

{  TextureTarget }
{       GL_TEXTURE_2D }
  GL_TEXTURE = $1702; 
  {$EXTERNALSYM GL_TEXTURE}

  GL_TEXTURE_CUBE_MAP = $8513; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP}
  GL_TEXTURE_BINDING_CUBE_MAP = $8514; 
  {$EXTERNALSYM GL_TEXTURE_BINDING_CUBE_MAP}
  GL_TEXTURE_CUBE_MAP_POSITIVE_X = $8515; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_POSITIVE_X}
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X = $8516; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_NEGATIVE_X}
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y = $8517; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_POSITIVE_Y}
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y = $8518; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_NEGATIVE_Y}
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z = $8519; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_POSITIVE_Z}
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z = $851A; 
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_NEGATIVE_Z}
  GL_MAX_CUBE_MAP_TEXTURE_SIZE = $851C; 
  {$EXTERNALSYM GL_MAX_CUBE_MAP_TEXTURE_SIZE}

{  TextureUnit }
  GL_TEXTURE0 = $84C0; 
  {$EXTERNALSYM GL_TEXTURE0}
  GL_TEXTURE1 = $84C1; 
  {$EXTERNALSYM GL_TEXTURE1}
  GL_TEXTURE2 = $84C2; 
  {$EXTERNALSYM GL_TEXTURE2}
  GL_TEXTURE3 = $84C3; 
  {$EXTERNALSYM GL_TEXTURE3}
  GL_TEXTURE4 = $84C4; 
  {$EXTERNALSYM GL_TEXTURE4}
  GL_TEXTURE5 = $84C5; 
  {$EXTERNALSYM GL_TEXTURE5}
  GL_TEXTURE6 = $84C6; 
  {$EXTERNALSYM GL_TEXTURE6}
  GL_TEXTURE7 = $84C7; 
  {$EXTERNALSYM GL_TEXTURE7}
  GL_TEXTURE8 = $84C8; 
  {$EXTERNALSYM GL_TEXTURE8}
  GL_TEXTURE9 = $84C9; 
  {$EXTERNALSYM GL_TEXTURE9}
  GL_TEXTURE10 = $84CA; 
  {$EXTERNALSYM GL_TEXTURE10}
  GL_TEXTURE11 = $84CB; 
  {$EXTERNALSYM GL_TEXTURE11}
  GL_TEXTURE12 = $84CC; 
  {$EXTERNALSYM GL_TEXTURE12}
  GL_TEXTURE13 = $84CD; 
  {$EXTERNALSYM GL_TEXTURE13}
  GL_TEXTURE14 = $84CE; 
  {$EXTERNALSYM GL_TEXTURE14}
  GL_TEXTURE15 = $84CF; 
  {$EXTERNALSYM GL_TEXTURE15}
  GL_TEXTURE16 = $84D0; 
  {$EXTERNALSYM GL_TEXTURE16}
  GL_TEXTURE17 = $84D1; 
  {$EXTERNALSYM GL_TEXTURE17}
  GL_TEXTURE18 = $84D2; 
  {$EXTERNALSYM GL_TEXTURE18}
  GL_TEXTURE19 = $84D3; 
  {$EXTERNALSYM GL_TEXTURE19}
  GL_TEXTURE20 = $84D4; 
  {$EXTERNALSYM GL_TEXTURE20}
  GL_TEXTURE21 = $84D5; 
  {$EXTERNALSYM GL_TEXTURE21}
  GL_TEXTURE22 = $84D6; 
  {$EXTERNALSYM GL_TEXTURE22}
  GL_TEXTURE23 = $84D7; 
  {$EXTERNALSYM GL_TEXTURE23}
  GL_TEXTURE24 = $84D8; 
  {$EXTERNALSYM GL_TEXTURE24}
  GL_TEXTURE25 = $84D9; 
  {$EXTERNALSYM GL_TEXTURE25}
  GL_TEXTURE26 = $84DA; 
  {$EXTERNALSYM GL_TEXTURE26}
  GL_TEXTURE27 = $84DB; 
  {$EXTERNALSYM GL_TEXTURE27}
  GL_TEXTURE28 = $84DC; 
  {$EXTERNALSYM GL_TEXTURE28}
  GL_TEXTURE29 = $84DD; 
  {$EXTERNALSYM GL_TEXTURE29}
  GL_TEXTURE30 = $84DE; 
  {$EXTERNALSYM GL_TEXTURE30}
  GL_TEXTURE31 = $84DF; 
  {$EXTERNALSYM GL_TEXTURE31}
  GL_ACTIVE_TEXTURE = $84E0; 
  {$EXTERNALSYM GL_ACTIVE_TEXTURE}

{  TextureWrapMode }
  GL_REPEAT = $2901; 
  {$EXTERNALSYM GL_REPEAT}
  GL_CLAMP_TO_EDGE = $812F; 
  {$EXTERNALSYM GL_CLAMP_TO_EDGE}
  GL_MIRRORED_REPEAT = $8370; 
  {$EXTERNALSYM GL_MIRRORED_REPEAT}

{  Uniform Types }
  GL_FLOAT_VEC2 = $8B50; 
  {$EXTERNALSYM GL_FLOAT_VEC2}
  GL_FLOAT_VEC3 = $8B51; 
  {$EXTERNALSYM GL_FLOAT_VEC3}
  GL_FLOAT_VEC4 = $8B52; 
  {$EXTERNALSYM GL_FLOAT_VEC4}
  GL_INT_VEC2 = $8B53; 
  {$EXTERNALSYM GL_INT_VEC2}
  GL_INT_VEC3 = $8B54; 
  {$EXTERNALSYM GL_INT_VEC3}
  GL_INT_VEC4 = $8B55; 
  {$EXTERNALSYM GL_INT_VEC4}
  GL_BOOL = $8B56; 
  {$EXTERNALSYM GL_BOOL}
  GL_BOOL_VEC2 = $8B57; 
  {$EXTERNALSYM GL_BOOL_VEC2}
  GL_BOOL_VEC3 = $8B58; 
  {$EXTERNALSYM GL_BOOL_VEC3}
  GL_BOOL_VEC4 = $8B59; 
  {$EXTERNALSYM GL_BOOL_VEC4}
  GL_FLOAT_MAT2 = $8B5A; 
  {$EXTERNALSYM GL_FLOAT_MAT2}
  GL_FLOAT_MAT3 = $8B5B; 
  {$EXTERNALSYM GL_FLOAT_MAT3}
  GL_FLOAT_MAT4 = $8B5C; 
  {$EXTERNALSYM GL_FLOAT_MAT4}
  GL_SAMPLER_2D = $8B5E; 
  {$EXTERNALSYM GL_SAMPLER_2D}
  GL_SAMPLER_CUBE = $8B60; 
  {$EXTERNALSYM GL_SAMPLER_CUBE}

{  Vertex Arrays }
  GL_VERTEX_ATTRIB_ARRAY_ENABLED = $8622; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_ENABLED}
  GL_VERTEX_ATTRIB_ARRAY_SIZE = $8623; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_SIZE}
  GL_VERTEX_ATTRIB_ARRAY_STRIDE = $8624; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_STRIDE}
  GL_VERTEX_ATTRIB_ARRAY_TYPE = $8625; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_TYPE}
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED = $886A; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_NORMALIZED}
  GL_VERTEX_ATTRIB_ARRAY_POINTER = $8645; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_POINTER}
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = $889F; 
  {$EXTERNALSYM GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING}

{  Read Format }
  GL_IMPLEMENTATION_COLOR_READ_TYPE = $8B9A; 
  {$EXTERNALSYM GL_IMPLEMENTATION_COLOR_READ_TYPE}
  GL_IMPLEMENTATION_COLOR_READ_FORMAT = $8B9B; 
  {$EXTERNALSYM GL_IMPLEMENTATION_COLOR_READ_FORMAT}

{  Shader Source }
  GL_COMPILE_STATUS = $8B81; 
  {$EXTERNALSYM GL_COMPILE_STATUS}
  GL_INFO_LOG_LENGTH = $8B84; 
  {$EXTERNALSYM GL_INFO_LOG_LENGTH}
  GL_SHADER_SOURCE_LENGTH = $8B88; 
  {$EXTERNALSYM GL_SHADER_SOURCE_LENGTH}
  GL_SHADER_COMPILER = $8DFA; 
  {$EXTERNALSYM GL_SHADER_COMPILER}

{  Shader Binary }
  GL_SHADER_BINARY_FORMATS = $8DF8; 
  {$EXTERNALSYM GL_SHADER_BINARY_FORMATS}
  GL_NUM_SHADER_BINARY_FORMATS = $8DF9; 
  {$EXTERNALSYM GL_NUM_SHADER_BINARY_FORMATS}

{  Shader Precision-Specified Types }
  GL_LOW_FLOAT = $8DF0; 
  {$EXTERNALSYM GL_LOW_FLOAT}
  GL_MEDIUM_FLOAT = $8DF1; 
  {$EXTERNALSYM GL_MEDIUM_FLOAT}
  GL_HIGH_FLOAT = $8DF2; 
  {$EXTERNALSYM GL_HIGH_FLOAT}
  GL_LOW_INT = $8DF3; 
  {$EXTERNALSYM GL_LOW_INT}
  GL_MEDIUM_INT = $8DF4; 
  {$EXTERNALSYM GL_MEDIUM_INT}
  GL_HIGH_INT = $8DF5; 
  {$EXTERNALSYM GL_HIGH_INT}

{  Framebuffer Object. }
  GL_FRAMEBUFFER = $8D40; 
  {$EXTERNALSYM GL_FRAMEBUFFER}
  GL_RENDERBUFFER = $8D41; 
  {$EXTERNALSYM GL_RENDERBUFFER}

  GL_RGBA4 = $8056; 
  {$EXTERNALSYM GL_RGBA4}
  GL_RGB5_A1 = $8057; 
  {$EXTERNALSYM GL_RGB5_A1}
  GL_RGB565 = $8D62; 
  {$EXTERNALSYM GL_RGB565}
  GL_DEPTH_COMPONENT16 = $81A5; 
  {$EXTERNALSYM GL_DEPTH_COMPONENT16}
  GL_STENCIL_INDEX = $1901; 
  {$EXTERNALSYM GL_STENCIL_INDEX}
  GL_STENCIL_INDEX8 = $8D48; 
  {$EXTERNALSYM GL_STENCIL_INDEX8}

  GL_RENDERBUFFER_WIDTH = $8D42; 
  {$EXTERNALSYM GL_RENDERBUFFER_WIDTH}
  GL_RENDERBUFFER_HEIGHT = $8D43; 
  {$EXTERNALSYM GL_RENDERBUFFER_HEIGHT}
  GL_RENDERBUFFER_INTERNAL_FORMAT = $8D44; 
  {$EXTERNALSYM GL_RENDERBUFFER_INTERNAL_FORMAT}
  GL_RENDERBUFFER_RED_SIZE = $8D50; 
  {$EXTERNALSYM GL_RENDERBUFFER_RED_SIZE}
  GL_RENDERBUFFER_GREEN_SIZE = $8D51; 
  {$EXTERNALSYM GL_RENDERBUFFER_GREEN_SIZE}
  GL_RENDERBUFFER_BLUE_SIZE = $8D52; 
  {$EXTERNALSYM GL_RENDERBUFFER_BLUE_SIZE}
  GL_RENDERBUFFER_ALPHA_SIZE = $8D53; 
  {$EXTERNALSYM GL_RENDERBUFFER_ALPHA_SIZE}
  GL_RENDERBUFFER_DEPTH_SIZE = $8D54; 
  {$EXTERNALSYM GL_RENDERBUFFER_DEPTH_SIZE}
  GL_RENDERBUFFER_STENCIL_SIZE = $8D55; 
  {$EXTERNALSYM GL_RENDERBUFFER_STENCIL_SIZE}

  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = $8CD0; 
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE}
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = $8CD1; 
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME}
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = $8CD2; 
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL}
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = $8CD3; 
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE}

  GL_COLOR_ATTACHMENT0 = $8CE0; 
  {$EXTERNALSYM GL_COLOR_ATTACHMENT0}
  GL_DEPTH_ATTACHMENT = $8D00; 
  {$EXTERNALSYM GL_DEPTH_ATTACHMENT}
  GL_STENCIL_ATTACHMENT = $8D20; 
  {$EXTERNALSYM GL_STENCIL_ATTACHMENT}

  GL_NONE = 0; 
  {$EXTERNALSYM GL_NONE}

  GL_FRAMEBUFFER_COMPLETE = $8CD5; 
  {$EXTERNALSYM GL_FRAMEBUFFER_COMPLETE}
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = $8CD6; 
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT}
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = $8CD7; 
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT}
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS = $8CD9; 
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS}
  GL_FRAMEBUFFER_UNSUPPORTED = $8CDD; 
  {$EXTERNALSYM GL_FRAMEBUFFER_UNSUPPORTED}

  GL_FRAMEBUFFER_BINDING = $8CA6; 
  {$EXTERNALSYM GL_FRAMEBUFFER_BINDING}
  GL_RENDERBUFFER_BINDING = $8CA7; 
  {$EXTERNALSYM GL_RENDERBUFFER_BINDING}
  GL_MAX_RENDERBUFFER_SIZE = $84E8; 
  {$EXTERNALSYM GL_MAX_RENDERBUFFER_SIZE}

  GL_INVALID_FRAMEBUFFER_OPERATION = $0506; 
  {$EXTERNALSYM GL_INVALID_FRAMEBUFFER_OPERATION}

{ ------------------------------------------------------------------------
   GL core functions.
  ------------------------------------------------------------------------
}

procedure glActiveTexture(texture: GLenum); cdecl;
 external AndroidGles2Lib name 'glActiveTexture';
{$EXTERNALSYM glActiveTexture}

procedure glAttachShader(_program: GLuint; shader: GLuint); cdecl;
 external AndroidGles2Lib name 'glAttachShader';
{$EXTERNALSYM glAttachShader}

procedure glBindAttribLocation(_program: GLuint; index: GLuint; const name: PGLchar); cdecl;
 external AndroidGles2Lib name 'glBindAttribLocation';
{$EXTERNALSYM glBindAttribLocation}

procedure glBindBuffer(target: GLenum; buffer: GLuint); cdecl;
 external AndroidGles2Lib name 'glBindBuffer';
{$EXTERNALSYM glBindBuffer}

procedure glBindFramebuffer(target: GLenum; framebuffer: GLuint); cdecl;
 external AndroidGles2Lib name 'glBindFramebuffer';
{$EXTERNALSYM glBindFramebuffer}

procedure glBindRenderbuffer(target: GLenum; renderbuffer: GLuint); cdecl;
 external AndroidGles2Lib name 'glBindRenderbuffer';
{$EXTERNALSYM glBindRenderbuffer}

procedure glBindTexture(target: GLenum; texture: GLuint); cdecl;
 external AndroidGles2Lib name 'glBindTexture';
{$EXTERNALSYM glBindTexture}

procedure glBlendColor(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf); cdecl;
 external AndroidGles2Lib name 'glBlendColor';
{$EXTERNALSYM glBlendColor}

procedure glBlendEquation( mode: GLenum ); cdecl;
 external AndroidGles2Lib name 'glBlendEquation';
{$EXTERNALSYM glBlendEquation}

procedure glBlendEquationSeparate(modeRGB: GLenum; modeAlpha: GLenum); cdecl;
 external AndroidGles2Lib name 'glBlendEquationSeparate';
{$EXTERNALSYM glBlendEquationSeparate}

procedure glBlendFunc(sfactor: GLenum; dfactor: GLenum); cdecl;
 external AndroidGles2Lib name 'glBlendFunc';
{$EXTERNALSYM glBlendFunc}

procedure glBlendFuncSeparate(srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); cdecl;
 external AndroidGles2Lib name 'glBlendFuncSeparate';
{$EXTERNALSYM glBlendFuncSeparate}

procedure glBufferData(target: GLenum; size: GLsizeiptr; const data: PGLvoid; usage: GLenum); cdecl;
 external AndroidGles2Lib name 'glBufferData';
{$EXTERNALSYM glBufferData}

procedure glBufferSubData(target: GLenum; offset: GLintptr; size: GLsizeiptr; const data: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glBufferSubData';
{$EXTERNALSYM glBufferSubData}

function glCheckFramebufferStatus(target: GLenum): GLenum; cdecl;
 external AndroidGles2Lib name 'glCheckFramebufferStatus';
{$EXTERNALSYM glCheckFramebufferStatus}

procedure glClear(mask: GLbitfield); cdecl;
 external AndroidGles2Lib name 'glClear';
{$EXTERNALSYM glClear}

procedure glClearColor(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf); cdecl;
 external AndroidGles2Lib name 'glClearColor';
{$EXTERNALSYM glClearColor}

procedure glClearDepthf(depth: GLclampf); cdecl;
 external AndroidGles2Lib name 'glClearDepthf';
{$EXTERNALSYM glClearDepthf}

procedure glClearStencil(s: GLint); cdecl;
 external AndroidGles2Lib name 'glClearStencil';
{$EXTERNALSYM glClearStencil}

procedure glColorMask(red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean); cdecl;
 external AndroidGles2Lib name 'glColorMask';
{$EXTERNALSYM glColorMask}

procedure glCompileShader(shader: GLuint); cdecl;
 external AndroidGles2Lib name 'glCompileShader';
{$EXTERNALSYM glCompileShader}

procedure glCompressedTexImage2D(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; const data: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glCompressedTexImage2D';
{$EXTERNALSYM glCompressedTexImage2D}

procedure glCompressedTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; const data: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glCompressedTexSubImage2D';
{$EXTERNALSYM glCompressedTexSubImage2D}

procedure glCopyTexImage2D(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint); cdecl;
 external AndroidGles2Lib name 'glCopyTexImage2D';
{$EXTERNALSYM glCopyTexImage2D}

procedure glCopyTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); cdecl;
 external AndroidGles2Lib name 'glCopyTexSubImage2D';
{$EXTERNALSYM glCopyTexSubImage2D}

function glCreateProgram: GLuint; cdecl;
 external AndroidGles2Lib name 'glCreateProgram';
{$EXTERNALSYM glCreateProgram}

function glCreateShader(_type: GLenum): GLuint; cdecl;
 external AndroidGles2Lib name 'glCreateShader';
{$EXTERNALSYM glCreateShader}

procedure glCullFace(mode: GLenum); cdecl;
 external AndroidGles2Lib name 'glCullFace';
{$EXTERNALSYM glCullFace}

procedure glDeleteBuffers(n: GLsizei; const buffers: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteBuffers';
{$EXTERNALSYM glDeleteBuffers}

procedure glDeleteFramebuffers(n: GLsizei; const framebuffers: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteFramebuffers';
{$EXTERNALSYM glDeleteFramebuffers}

procedure glDeleteProgram(_program: GLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteProgram';
{$EXTERNALSYM glDeleteProgram}

procedure glDeleteRenderbuffers(n: GLsizei; const renderbuffers: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteRenderbuffers';
{$EXTERNALSYM glDeleteRenderbuffers}

procedure glDeleteShader(shader: GLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteShader';
{$EXTERNALSYM glDeleteShader}

procedure glDeleteTextures(n: GLsizei; const textures: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteTextures';
{$EXTERNALSYM glDeleteTextures}

procedure glDepthFunc(func: GLenum); cdecl;
 external AndroidGles2Lib name 'glDepthFunc';
{$EXTERNALSYM glDepthFunc}

procedure glDepthMask(flag: GLboolean); cdecl;
 external AndroidGles2Lib name 'glDepthMask';
{$EXTERNALSYM glDepthMask}

procedure glDepthRangef(zNear: GLclampf; zFar: GLclampf); cdecl;
 external AndroidGles2Lib name 'glDepthRangef';
{$EXTERNALSYM glDepthRangef}

procedure glDetachShader(_program: GLuint; shader: GLuint); cdecl;
 external AndroidGles2Lib name 'glDetachShader';
{$EXTERNALSYM glDetachShader}

procedure glDisable(cap: GLenum); cdecl;
 external AndroidGles2Lib name 'glDisable';
{$EXTERNALSYM glDisable}

procedure glDisableVertexAttribArray(index: GLuint); cdecl;
 external AndroidGles2Lib name 'glDisableVertexAttribArray';
{$EXTERNALSYM glDisableVertexAttribArray}

procedure glDrawArrays(mode: GLenum; first: GLint; count: GLsizei); cdecl;
 external AndroidGles2Lib name 'glDrawArrays';
{$EXTERNALSYM glDrawArrays}

procedure glDrawElements(mode: GLenum; count: GLsizei; _type: GLenum; const indices: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glDrawElements';
{$EXTERNALSYM glDrawElements}

procedure glEnable(cap: GLenum); cdecl;
 external AndroidGles2Lib name 'glEnable';
{$EXTERNALSYM glEnable}

procedure glEnableVertexAttribArray(index: GLuint); cdecl;
 external AndroidGles2Lib name 'glEnableVertexAttribArray';
{$EXTERNALSYM glEnableVertexAttribArray}

procedure glFinish(); cdecl;
 external AndroidGles2Lib name 'glFinish';
{$EXTERNALSYM glFinish}

procedure glFlush(); cdecl;
 external AndroidGles2Lib name 'glFlush';
{$EXTERNALSYM glFlush}

procedure glFramebufferRenderbuffer(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); cdecl;
 external AndroidGles2Lib name 'glFramebufferRenderbuffer';
{$EXTERNALSYM glFramebufferRenderbuffer}

procedure glFramebufferTexture2D(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); cdecl;
 external AndroidGles2Lib name 'glFramebufferTexture2D';
{$EXTERNALSYM glFramebufferTexture2D}

procedure glFrontFace(mode: GLenum); cdecl;
 external AndroidGles2Lib name 'glFrontFace';
{$EXTERNALSYM glFrontFace}

procedure glGenBuffers(n: GLsizei; buffers: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenBuffers';
{$EXTERNALSYM glGenBuffers}

procedure glGenerateMipmap(target: GLenum); cdecl;
 external AndroidGles2Lib name 'glGenerateMipmap';
{$EXTERNALSYM glGenerateMipmap}

procedure glGenFramebuffers(n: GLsizei; framebuffers: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenFramebuffers';
{$EXTERNALSYM glGenFramebuffers}

procedure glGenRenderbuffers(n: GLsizei; renderbuffers: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenRenderbuffers';
{$EXTERNALSYM glGenRenderbuffers}

procedure glGenTextures(n: GLsizei; textures: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenTextures';
{$EXTERNALSYM glGenTextures}

procedure glGetActiveAttrib(_program: GLuint; index: GLuint; bufsize: GLsizei; length: PGLsizei; size: PGLint; _type: PGLenum; name: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetActiveAttrib';
{$EXTERNALSYM glGetActiveAttrib}

procedure glGetActiveUniform(_program: GLuint; index: GLuint; bufsize: GLsizei; length: PGLsizei; size: PGLint; _type: PGLenum; name: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetActiveUniform';
{$EXTERNALSYM glGetActiveUniform}

procedure glGetAttachedShaders(_program: GLuint; maxcount: GLsizei; count: PGLsizei; shaders: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGetAttachedShaders';
{$EXTERNALSYM glGetAttachedShaders}

function glGetAttribLocation(_program: GLuint; const name: PGLchar): GLint; cdecl;
 external AndroidGles2Lib name 'glGetAttribLocation';
{$EXTERNALSYM glGetAttribLocation}

procedure glGetBooleanv(pname: GLenum; params: PGLboolean); cdecl;
 external AndroidGles2Lib name 'glGetBooleanv';
{$EXTERNALSYM glGetBooleanv}

procedure glGetBufferParameteriv(target: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetBufferParameteriv';
{$EXTERNALSYM glGetBufferParameteriv}

function glGetError(): GLenum; cdecl;
 external AndroidGles2Lib name 'glGetError';
{$EXTERNALSYM glGetError}

procedure glGetFloatv(pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glGetFloatv';
{$EXTERNALSYM glGetFloatv}

procedure glGetFramebufferAttachmentParameteriv(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetFramebufferAttachmentParameteriv';
{$EXTERNALSYM glGetFramebufferAttachmentParameteriv}

procedure glGetIntegerv(pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetIntegerv';
{$EXTERNALSYM glGetIntegerv}

procedure glGetProgramiv(_program: GLuint; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetProgramiv';
{$EXTERNALSYM glGetProgramiv}

procedure glGetProgramInfoLog(_program: GLuint; bufsize: GLsizei; length: PGLsizei; infolog: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetProgramInfoLog';
{$EXTERNALSYM glGetProgramInfoLog}

procedure glGetRenderbufferParameteriv(target: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetRenderbufferParameteriv';
{$EXTERNALSYM glGetRenderbufferParameteriv}

procedure glGetShaderiv(shader: GLuint; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetShaderiv';
{$EXTERNALSYM glGetShaderiv}

procedure glGetShaderInfoLog(shader: GLuint; bufsize: GLsizei; length: PGLsizei; infolog: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetShaderInfoLog';
{$EXTERNALSYM glGetShaderInfoLog}

procedure glGetShaderPrecisionFormat(shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetShaderPrecisionFormat';
{$EXTERNALSYM glGetShaderPrecisionFormat}

procedure glGetShaderSource(shader: GLuint; bufsize: GLsizei; length: PGLsizei; source: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetShaderSource';
{$EXTERNALSYM glGetShaderSource}

function glGetString(name: GLenum): PGLubyte; cdecl;
 external AndroidGles2Lib name 'glGetString';
{$EXTERNALSYM glGetString}

procedure glGetTexParameterfv(target: GLenum; pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glGetTexParameterfv';
{$EXTERNALSYM glGetTexParameterfv}

procedure glGetTexParameteriv(target: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetTexParameteriv';
{$EXTERNALSYM glGetTexParameteriv}

procedure glGetUniformfv(_program: GLuint; location: GLint; params: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glGetUniformfv';
{$EXTERNALSYM glGetUniformfv}

procedure glGetUniformiv(_program: GLuint; location: GLint; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetUniformiv';
{$EXTERNALSYM glGetUniformiv}

function glGetUniformLocation(_program: GLuint; const name: PGLchar): GLint; cdecl;
 external AndroidGles2Lib name 'glGetUniformLocation';
{$EXTERNALSYM glGetUniformLocation}

procedure glGetVertexAttribfv(index: GLuint; pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glGetVertexAttribfv';
{$EXTERNALSYM glGetVertexAttribfv}

procedure glGetVertexAttribiv(index: GLuint; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetVertexAttribiv';
{$EXTERNALSYM glGetVertexAttribiv}

procedure glGetVertexAttribPointerv(index: GLuint; pname: GLenum; pointer: PPGLvoid); cdecl;
 external AndroidGles2Lib name 'glGetVertexAttribPointerv';
{$EXTERNALSYM glGetVertexAttribPointerv}

procedure glHint(target: GLenum; mode: GLenum); cdecl;
 external AndroidGles2Lib name 'glHint';
{$EXTERNALSYM glHint}

function glIsBuffer(buffer: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsBuffer';
{$EXTERNALSYM glIsBuffer}

function glIsEnabled(cap: GLenum): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsEnabled';
{$EXTERNALSYM glIsEnabled}

function glIsFramebuffer(framebuffer: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsFramebuffer';
{$EXTERNALSYM glIsFramebuffer}

function glIsProgram(_program: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsProgram';
{$EXTERNALSYM glIsProgram}

function glIsRenderbuffer(renderbuffer: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsRenderbuffer';
{$EXTERNALSYM glIsRenderbuffer}

function glIsShader(shader: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsShader';
{$EXTERNALSYM glIsShader}

function glIsTexture(texture: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glIsTexture';
{$EXTERNALSYM glIsTexture}

procedure glLineWidth(width: GLfloat); cdecl;
 external AndroidGles2Lib name 'glLineWidth';
{$EXTERNALSYM glLineWidth}

procedure glLinkProgram(_program: GLuint); cdecl;
 external AndroidGles2Lib name 'glLinkProgram';
{$EXTERNALSYM glLinkProgram}

procedure glPixelStorei(pname: GLenum; param: GLint); cdecl;
 external AndroidGles2Lib name 'glPixelStorei';
{$EXTERNALSYM glPixelStorei}

procedure glPolygonOffset(factor: GLfloat; units: GLfloat); cdecl;
 external AndroidGles2Lib name 'glPolygonOffset';
{$EXTERNALSYM glPolygonOffset}

procedure glReadPixels(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; pixels: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glReadPixels';
{$EXTERNALSYM glReadPixels}

procedure glReleaseShaderCompiler(); cdecl;
 external AndroidGles2Lib name 'glReleaseShaderCompiler';
{$EXTERNALSYM glReleaseShaderCompiler}

procedure glRenderbufferStorage(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); cdecl;
 external AndroidGles2Lib name 'glRenderbufferStorage';
{$EXTERNALSYM glRenderbufferStorage}

procedure glSampleCoverage(value: GLclampf; invert: GLboolean); cdecl;
 external AndroidGles2Lib name 'glSampleCoverage';
{$EXTERNALSYM glSampleCoverage}

procedure glScissor(x: GLint; y: GLint; width: GLsizei; height: GLsizei); cdecl;
 external AndroidGles2Lib name 'glScissor';
{$EXTERNALSYM glScissor}

procedure glShaderBinary(n: GLsizei; const shaders: PGLuint; binaryformat: GLenum; const binary: PGLvoid; length: GLsizei); cdecl;
 external AndroidGles2Lib name 'glShaderBinary';
{$EXTERNALSYM glShaderBinary}

procedure glShaderSource(shader: GLuint; count: GLsizei; const _string: PPGLchar; const length: PGLint); cdecl;
 external AndroidGles2Lib name 'glShaderSource';
{$EXTERNALSYM glShaderSource}

procedure glStencilFunc(func: GLenum; ref: GLint; mask: GLuint); cdecl;
 external AndroidGles2Lib name 'glStencilFunc';
{$EXTERNALSYM glStencilFunc}

procedure glStencilFuncSeparate(face: GLenum; func: GLenum; ref: GLint; mask: GLuint); cdecl;
 external AndroidGles2Lib name 'glStencilFuncSeparate';
{$EXTERNALSYM glStencilFuncSeparate}

procedure glStencilMask(mask: GLuint); cdecl;
 external AndroidGles2Lib name 'glStencilMask';
{$EXTERNALSYM glStencilMask}

procedure glStencilMaskSeparate(face: GLenum; mask: GLuint); cdecl;
 external AndroidGles2Lib name 'glStencilMaskSeparate';
{$EXTERNALSYM glStencilMaskSeparate}

procedure glStencilOp(fail: GLenum; zfail: GLenum; zpass: GLenum); cdecl;
 external AndroidGles2Lib name 'glStencilOp';
{$EXTERNALSYM glStencilOp}

procedure glStencilOpSeparate(face: GLenum; fail: GLenum; zfail: GLenum; zpass: GLenum); cdecl;
 external AndroidGles2Lib name 'glStencilOpSeparate';
{$EXTERNALSYM glStencilOpSeparate}

procedure glTexImage2D(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glTexImage2D';
{$EXTERNALSYM glTexImage2D}

procedure glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat); cdecl;
 external AndroidGles2Lib name 'glTexParameterf';
{$EXTERNALSYM glTexParameterf}

procedure glTexParameterfv(target: GLenum; pname: GLenum; const params: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glTexParameterfv';
{$EXTERNALSYM glTexParameterfv}

procedure glTexParameteri(target: GLenum; pname: GLenum; param: GLint); cdecl;
 external AndroidGles2Lib name 'glTexParameteri';
{$EXTERNALSYM glTexParameteri}

procedure glTexParameteriv(target: GLenum; pname: GLenum; const params: PGLint); cdecl;
 external AndroidGles2Lib name 'glTexParameteriv';
{$EXTERNALSYM glTexParameteriv}

procedure glTexSubImage2D(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glTexSubImage2D';
{$EXTERNALSYM glTexSubImage2D}

procedure glUniform1f(location: GLint; x: GLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform1f';
{$EXTERNALSYM glUniform1f}

procedure glUniform1fv(location: GLint; count: GLsizei; const v: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform1fv';
{$EXTERNALSYM glUniform1fv}

procedure glUniform1i(location: GLint; x: GLint); cdecl;
 external AndroidGles2Lib name 'glUniform1i';
{$EXTERNALSYM glUniform1i}

procedure glUniform1iv(location: GLint; count: GLsizei; const v: PGLint); cdecl;
 external AndroidGles2Lib name 'glUniform1iv';
{$EXTERNALSYM glUniform1iv}

procedure glUniform2f(location: GLint; x: GLfloat; y: GLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform2f';
{$EXTERNALSYM glUniform2f}

procedure glUniform2fv(location: GLint; count: GLsizei; const v: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform2fv';
{$EXTERNALSYM glUniform2fv}

procedure glUniform2i(location: GLint; x: GLint; y: GLint); cdecl;
 external AndroidGles2Lib name 'glUniform2i';
{$EXTERNALSYM glUniform2i}

procedure glUniform2iv(location: GLint; count: GLsizei; const v: PGLint); cdecl;
 external AndroidGles2Lib name 'glUniform2iv';
{$EXTERNALSYM glUniform2iv}

procedure glUniform3f(location: GLint; x: GLfloat; y: GLfloat; z: GLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform3f';
{$EXTERNALSYM glUniform3f}

procedure glUniform3fv(location: GLint; count: GLsizei; const v: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform3fv';
{$EXTERNALSYM glUniform3fv}

procedure glUniform3i(location: GLint; x: GLint; y: GLint; z: GLint); cdecl;
 external AndroidGles2Lib name 'glUniform3i';
{$EXTERNALSYM glUniform3i}

procedure glUniform3iv(location: GLint; count: GLsizei; const v: PGLint); cdecl;
 external AndroidGles2Lib name 'glUniform3iv';
{$EXTERNALSYM glUniform3iv}

procedure glUniform4f(location: GLint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform4f';
{$EXTERNALSYM glUniform4f}

procedure glUniform4fv(location: GLint; count: GLsizei; const v: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniform4fv';
{$EXTERNALSYM glUniform4fv}

procedure glUniform4i(location: GLint; x: GLint; y: GLint; z: GLint; w: GLint); cdecl;
 external AndroidGles2Lib name 'glUniform4i';
{$EXTERNALSYM glUniform4i}

procedure glUniform4iv(location: GLint; count: GLsizei; const v: PGLint); cdecl;
 external AndroidGles2Lib name 'glUniform4iv';
{$EXTERNALSYM glUniform4iv}

procedure glUniformMatrix2fv(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniformMatrix2fv';
{$EXTERNALSYM glUniformMatrix2fv}

procedure glUniformMatrix3fv(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniformMatrix3fv';
{$EXTERNALSYM glUniformMatrix3fv}

procedure glUniformMatrix4fv(location: GLint; count: GLsizei; transpose: GLboolean; const value: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glUniformMatrix4fv';
{$EXTERNALSYM glUniformMatrix4fv}

procedure glUseProgram(_program: GLuint); cdecl;
 external AndroidGles2Lib name 'glUseProgram';
{$EXTERNALSYM glUseProgram}

procedure glValidateProgram(_program: GLuint); cdecl;
 external AndroidGles2Lib name 'glValidateProgram';
{$EXTERNALSYM glValidateProgram}

procedure glVertexAttrib1f(indx: GLuint; x: GLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib1f';
{$EXTERNALSYM glVertexAttrib1f}

procedure glVertexAttrib1fv(indx: GLuint; const values: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib1fv';
{$EXTERNALSYM glVertexAttrib1fv}

procedure glVertexAttrib2f(indx: GLuint; x: GLfloat; y: GLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib2f';
{$EXTERNALSYM glVertexAttrib2f}

procedure glVertexAttrib2fv(indx: GLuint; const values: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib2fv';
{$EXTERNALSYM glVertexAttrib2fv}

procedure glVertexAttrib3f(indx: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib3f';
{$EXTERNALSYM glVertexAttrib3f}

procedure glVertexAttrib3fv(indx: GLuint; const values: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib3fv';
{$EXTERNALSYM glVertexAttrib3fv}

procedure glVertexAttrib4f(indx: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib4f';
{$EXTERNALSYM glVertexAttrib4f}

procedure glVertexAttrib4fv(indx: GLuint; const values: PGLfloat); cdecl;
 external AndroidGles2Lib name 'glVertexAttrib4fv';
{$EXTERNALSYM glVertexAttrib4fv}

procedure glVertexAttribPointer(indx: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; const ptr: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glVertexAttribPointer';
{$EXTERNALSYM glVertexAttribPointer}

procedure glViewport(x: GLint; y: GLint; width: GLsizei; height: GLsizei); cdecl;
 external AndroidGles2Lib name 'glViewport';
{$EXTERNALSYM glViewport}

implementation

end.
