{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Gles;

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
  { OpenGL ES core versions }
  GL_VERSION_ES_CM_1_0 = 1;
  {$EXTERNALSYM GL_VERSION_ES_CM_1_0}
  GL_VERSION_ES_CL_1_0 = 1;
  {$EXTERNALSYM GL_VERSION_ES_CL_1_0}
  GL_VERSION_ES_CM_1_1 = 1;
  {$EXTERNALSYM GL_VERSION_ES_CM_1_1}
  GL_VERSION_ES_CL_1_1 = 1;
  {$EXTERNALSYM GL_VERSION_ES_CL_1_1}

  { ClearBufferMask  }
  GL_DEPTH_BUFFER_BIT = $00000100;
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT}
  GL_STENCIL_BUFFER_BIT = $00000400;
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT}
  GL_COLOR_BUFFER_BIT = $00004000;
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT}

  { Boolean  }
  GL_FALSE = 0;
  {$EXTERNALSYM GL_FALSE}
  GL_TRUE = 1;
  {$EXTERNALSYM GL_TRUE}

  { BeginMode  }
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
  
  { AlphaFunction  }
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
  
  { BlendingFactorDest  }
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
  
  { BlendingFactorSrc  }
  {      GL_ZERO  }
  {      GL_ONE  }
  GL_DST_COLOR = $0306;
  {$EXTERNALSYM GL_DST_COLOR}
  GL_ONE_MINUS_DST_COLOR = $0307;
  {$EXTERNALSYM GL_ONE_MINUS_DST_COLOR}
  GL_SRC_ALPHA_SATURATE = $0308;
  {$EXTERNALSYM GL_SRC_ALPHA_SATURATE}
  {      GL_SRC_ALPHA  }
  {      GL_ONE_MINUS_SRC_ALPHA  }
  {      GL_DST_ALPHA  }
  {      GL_ONE_MINUS_DST_ALPHA  }

  { ClipPlaneName  }
  GL_CLIP_PLANE0 = $3000;
  {$EXTERNALSYM GL_CLIP_PLANE0}
  GL_CLIP_PLANE1 = $3001;
  {$EXTERNALSYM GL_CLIP_PLANE1}
  GL_CLIP_PLANE2 = $3002;
  {$EXTERNALSYM GL_CLIP_PLANE2}
  GL_CLIP_PLANE3 = $3003;
  {$EXTERNALSYM GL_CLIP_PLANE3}
  GL_CLIP_PLANE4 = $3004;
  {$EXTERNALSYM GL_CLIP_PLANE4}
  GL_CLIP_PLANE5 = $3005;
  {$EXTERNALSYM GL_CLIP_PLANE5}
  
  { ColorMaterialFace  }
  {      GL_FRONT_AND_BACK  }
  
  { ColorMaterialParameter  }
  {      GL_AMBIENT_AND_DIFFUSE  }

  { ColorPointerType  }
  {      GL_UNSIGNED_BYTE  }
  {      GL_FLOAT  }
  {      GL_FIXED  }

  { CullFaceMode  }
  GL_FRONT = $0404;
  {$EXTERNALSYM GL_FRONT}
  GL_BACK = $0405;
  {$EXTERNALSYM GL_BACK}
  GL_FRONT_AND_BACK = $0408;
  {$EXTERNALSYM GL_FRONT_AND_BACK}
  
  { DepthFunction  }
  {      GL_NEVER  }
  {      GL_LESS  }
  {      GL_EQUAL  }
  {      GL_LEQUAL  }
  {      GL_GREATER  }
  {      GL_NOTEQUAL  }
  {      GL_GEQUAL  }
  {      GL_ALWAYS  }

  { EnableCap  }
  GL_FOG = $0B60;
  {$EXTERNALSYM GL_FOG}
  GL_LIGHTING = $0B50;
  {$EXTERNALSYM GL_LIGHTING}
  GL_TEXTURE_2D = $0DE1;
  {$EXTERNALSYM GL_TEXTURE_2D}
  GL_CULL_FACE = $0B44;
  {$EXTERNALSYM GL_CULL_FACE}
  GL_ALPHA_TEST = $0BC0;
  {$EXTERNALSYM GL_ALPHA_TEST}
  GL_BLEND = $0BE2;
  {$EXTERNALSYM GL_BLEND}
  GL_COLOR_LOGIC_OP = $0BF2;
  {$EXTERNALSYM GL_COLOR_LOGIC_OP}
  GL_DITHER = $0BD0;
  {$EXTERNALSYM GL_DITHER}
  GL_STENCIL_TEST = $0B90;
  {$EXTERNALSYM GL_STENCIL_TEST}
  GL_DEPTH_TEST = $0B71;
  {$EXTERNALSYM GL_DEPTH_TEST}
  {      GL_LIGHT0  }
  {      GL_LIGHT1  }
  {      GL_LIGHT2  }
  {      GL_LIGHT3  }
  {      GL_LIGHT4  }
  {      GL_LIGHT5  }
  {      GL_LIGHT6  }
  {      GL_LIGHT7  }
  GL_POINT_SMOOTH = $0B10;
  {$EXTERNALSYM GL_POINT_SMOOTH}
  GL_LINE_SMOOTH = $0B20;
  {$EXTERNALSYM GL_LINE_SMOOTH}
  GL_SCISSOR_TEST = $0C11;
  {$EXTERNALSYM GL_SCISSOR_TEST}
  GL_COLOR_MATERIAL = $0B57;
  {$EXTERNALSYM GL_COLOR_MATERIAL}
  GL_NORMALIZE = $0BA1;
  {$EXTERNALSYM GL_NORMALIZE}
  GL_RESCALE_NORMAL = $803A;
  {$EXTERNALSYM GL_RESCALE_NORMAL}
  GL_POLYGON_OFFSET_FILL = $8037;
  {$EXTERNALSYM GL_POLYGON_OFFSET_FILL}
  GL_VERTEX_ARRAY = $8074;
  {$EXTERNALSYM GL_VERTEX_ARRAY}
  GL_NORMAL_ARRAY = $8075;
  {$EXTERNALSYM GL_NORMAL_ARRAY}
  GL_COLOR_ARRAY = $8076;
  {$EXTERNALSYM GL_COLOR_ARRAY}
  GL_TEXTURE_COORD_ARRAY = $8078;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY}
  GL_MULTISAMPLE = $809D;
  {$EXTERNALSYM GL_MULTISAMPLE}
  GL_SAMPLE_ALPHA_TO_COVERAGE = $809E;
  {$EXTERNALSYM GL_SAMPLE_ALPHA_TO_COVERAGE}
  GL_SAMPLE_ALPHA_TO_ONE = $809F;
  {$EXTERNALSYM GL_SAMPLE_ALPHA_TO_ONE}
  GL_SAMPLE_COVERAGE = $80A0;
  {$EXTERNALSYM GL_SAMPLE_COVERAGE}

  { ErrorCode  }
  GL_NO_ERROR = 0;
  {$EXTERNALSYM GL_NO_ERROR}
  GL_INVALID_ENUM = $0500;
  {$EXTERNALSYM GL_INVALID_ENUM}
  GL_INVALID_VALUE = $0501;
  {$EXTERNALSYM GL_INVALID_VALUE}
  GL_INVALID_OPERATION = $0502;
  {$EXTERNALSYM GL_INVALID_OPERATION}
  GL_STACK_OVERFLOW = $0503;
  {$EXTERNALSYM GL_STACK_OVERFLOW}
  GL_STACK_UNDERFLOW = $0504;
  {$EXTERNALSYM GL_STACK_UNDERFLOW}
  GL_OUT_OF_MEMORY = $0505;
  {$EXTERNALSYM GL_OUT_OF_MEMORY}

  { FogMode  }
  {      GL_LINEAR  }
  GL_EXP = $0800;
  {$EXTERNALSYM GL_EXP}
  GL_EXP2 = $0801;
  {$EXTERNALSYM GL_EXP2}

  { FogParameter  }
  GL_FOG_DENSITY = $0B62;
  {$EXTERNALSYM GL_FOG_DENSITY}
  GL_FOG_START = $0B63;
  {$EXTERNALSYM GL_FOG_START}
  GL_FOG_END = $0B64;
  {$EXTERNALSYM GL_FOG_END}
  GL_FOG_MODE = $0B65;
  {$EXTERNALSYM GL_FOG_MODE}
  GL_FOG_COLOR = $0B66;
  {$EXTERNALSYM GL_FOG_COLOR}

  { FrontFaceDirection  }
  GL_CW = $0900;
  {$EXTERNALSYM GL_CW}
  GL_CCW = $0901;
  {$EXTERNALSYM GL_CCW}

  { GetPName  }
  GL_CURRENT_COLOR = $0B00;
  {$EXTERNALSYM GL_CURRENT_COLOR}
  GL_CURRENT_NORMAL = $0B02;
  {$EXTERNALSYM GL_CURRENT_NORMAL}
  GL_CURRENT_TEXTURE_COORDS = $0B03;
  {$EXTERNALSYM GL_CURRENT_TEXTURE_COORDS}
  GL_POINT_SIZE = $0B11;
  {$EXTERNALSYM GL_POINT_SIZE}
  GL_POINT_SIZE_MIN = $8126;
  {$EXTERNALSYM GL_POINT_SIZE_MIN}
  GL_POINT_SIZE_MAX = $8127;
  {$EXTERNALSYM GL_POINT_SIZE_MAX}
  GL_POINT_FADE_THRESHOLD_SIZE = $8128;
  {$EXTERNALSYM GL_POINT_FADE_THRESHOLD_SIZE}
  GL_POINT_DISTANCE_ATTENUATION = $8129;
  {$EXTERNALSYM GL_POINT_DISTANCE_ATTENUATION}
  GL_SMOOTH_POINT_SIZE_RANGE = $0B12;
  {$EXTERNALSYM GL_SMOOTH_POINT_SIZE_RANGE}
  GL_LINE_WIDTH = $0B21;
  {$EXTERNALSYM GL_LINE_WIDTH}
  GL_SMOOTH_LINE_WIDTH_RANGE = $0B22;
  {$EXTERNALSYM GL_SMOOTH_LINE_WIDTH_RANGE}
  GL_ALIASED_POINT_SIZE_RANGE = $846D;
  {$EXTERNALSYM GL_ALIASED_POINT_SIZE_RANGE}
  GL_ALIASED_LINE_WIDTH_RANGE = $846E;
  {$EXTERNALSYM GL_ALIASED_LINE_WIDTH_RANGE}
  GL_CULL_FACE_MODE = $0B45;
  {$EXTERNALSYM GL_CULL_FACE_MODE}
  GL_FRONT_FACE = $0B46;
  {$EXTERNALSYM GL_FRONT_FACE}
  GL_SHADE_MODEL = $0B54;
  {$EXTERNALSYM GL_SHADE_MODEL}
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
  GL_STENCIL_VALUE_MASK = $0B93;
  {$EXTERNALSYM GL_STENCIL_VALUE_MASK}
  GL_STENCIL_FAIL = $0B94;
  {$EXTERNALSYM GL_STENCIL_FAIL}
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95;
  {$EXTERNALSYM GL_STENCIL_PASS_DEPTH_FAIL}
  GL_STENCIL_PASS_DEPTH_PASS = $0B96;
  {$EXTERNALSYM GL_STENCIL_PASS_DEPTH_PASS}
  GL_STENCIL_REF = $0B97;
  {$EXTERNALSYM GL_STENCIL_REF}
  GL_STENCIL_WRITEMASK = $0B98;
  {$EXTERNALSYM GL_STENCIL_WRITEMASK}
  GL_MATRIX_MODE = $0BA0;
  {$EXTERNALSYM GL_MATRIX_MODE}
  GL_VIEWPORT = $0BA2;
  {$EXTERNALSYM GL_VIEWPORT}
  GL_MODELVIEW_STACK_DEPTH = $0BA3;
  {$EXTERNALSYM GL_MODELVIEW_STACK_DEPTH}
  GL_PROJECTION_STACK_DEPTH = $0BA4;
  {$EXTERNALSYM GL_PROJECTION_STACK_DEPTH}
  GL_TEXTURE_STACK_DEPTH = $0BA5;
  {$EXTERNALSYM GL_TEXTURE_STACK_DEPTH}
  GL_MODELVIEW_MATRIX = $0BA6;
  {$EXTERNALSYM GL_MODELVIEW_MATRIX}
  GL_PROJECTION_MATRIX = $0BA7;
  {$EXTERNALSYM GL_PROJECTION_MATRIX}
  GL_TEXTURE_MATRIX = $0BA8;
  {$EXTERNALSYM GL_TEXTURE_MATRIX}
  GL_ALPHA_TEST_FUNC = $0BC1;
  {$EXTERNALSYM GL_ALPHA_TEST_FUNC}
  GL_ALPHA_TEST_REF = $0BC2;
  {$EXTERNALSYM GL_ALPHA_TEST_REF}
  GL_BLEND_DST = $0BE0;
  {$EXTERNALSYM GL_BLEND_DST}
  GL_BLEND_SRC = $0BE1;
  {$EXTERNALSYM GL_BLEND_SRC}
  GL_LOGIC_OP_MODE = $0BF0;
  {$EXTERNALSYM GL_LOGIC_OP_MODE}
  GL_SCISSOR_BOX = $0C10;
  {$EXTERNALSYM GL_SCISSOR_BOX}
  GL_COLOR_CLEAR_VALUE = $0C22;
  {$EXTERNALSYM GL_COLOR_CLEAR_VALUE}
  GL_COLOR_WRITEMASK = $0C23;
  {$EXTERNALSYM GL_COLOR_WRITEMASK}
  GL_UNPACK_ALIGNMENT = $0CF5;
  {$EXTERNALSYM GL_UNPACK_ALIGNMENT}
  GL_PACK_ALIGNMENT = $0D05;
  {$EXTERNALSYM GL_PACK_ALIGNMENT}
  GL_MAX_LIGHTS = $0D31;
  {$EXTERNALSYM GL_MAX_LIGHTS}
  GL_MAX_CLIP_PLANES = $0D32;
  {$EXTERNALSYM GL_MAX_CLIP_PLANES}
  GL_MAX_TEXTURE_SIZE = $0D33;
  {$EXTERNALSYM GL_MAX_TEXTURE_SIZE}
  GL_MAX_MODELVIEW_STACK_DEPTH = $0D36;
  {$EXTERNALSYM GL_MAX_MODELVIEW_STACK_DEPTH}
  GL_MAX_PROJECTION_STACK_DEPTH = $0D38;
  {$EXTERNALSYM GL_MAX_PROJECTION_STACK_DEPTH}
  GL_MAX_TEXTURE_STACK_DEPTH = $0D39;
  {$EXTERNALSYM GL_MAX_TEXTURE_STACK_DEPTH}
  GL_MAX_VIEWPORT_DIMS = $0D3A;
  {$EXTERNALSYM GL_MAX_VIEWPORT_DIMS}
  GL_MAX_TEXTURE_UNITS = $84E2;
  {$EXTERNALSYM GL_MAX_TEXTURE_UNITS}
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
  GL_POLYGON_OFFSET_FACTOR = $8038;
  {$EXTERNALSYM GL_POLYGON_OFFSET_FACTOR}
  GL_TEXTURE_BINDING_2D = $8069;
  {$EXTERNALSYM GL_TEXTURE_BINDING_2D}
  GL_VERTEX_ARRAY_SIZE = $807A;
  {$EXTERNALSYM GL_VERTEX_ARRAY_SIZE}
  GL_VERTEX_ARRAY_TYPE = $807B;
  {$EXTERNALSYM GL_VERTEX_ARRAY_TYPE}
  GL_VERTEX_ARRAY_STRIDE = $807C;
  {$EXTERNALSYM GL_VERTEX_ARRAY_STRIDE}
  GL_NORMAL_ARRAY_TYPE = $807E;
  {$EXTERNALSYM GL_NORMAL_ARRAY_TYPE}
  GL_NORMAL_ARRAY_STRIDE = $807F;
  {$EXTERNALSYM GL_NORMAL_ARRAY_STRIDE}
  GL_COLOR_ARRAY_SIZE = $8081;
  {$EXTERNALSYM GL_COLOR_ARRAY_SIZE}
  GL_COLOR_ARRAY_TYPE = $8082;
  {$EXTERNALSYM GL_COLOR_ARRAY_TYPE}
  GL_COLOR_ARRAY_STRIDE = $8083;
  {$EXTERNALSYM GL_COLOR_ARRAY_STRIDE}
  GL_TEXTURE_COORD_ARRAY_SIZE = $8088;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_SIZE}
  GL_TEXTURE_COORD_ARRAY_TYPE = $8089;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_TYPE}
  GL_TEXTURE_COORD_ARRAY_STRIDE = $808A;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_STRIDE}
  GL_VERTEX_ARRAY_POINTER = $808E;
  {$EXTERNALSYM GL_VERTEX_ARRAY_POINTER}
  GL_NORMAL_ARRAY_POINTER = $808F;
  {$EXTERNALSYM GL_NORMAL_ARRAY_POINTER}
  GL_COLOR_ARRAY_POINTER = $8090;
  {$EXTERNALSYM GL_COLOR_ARRAY_POINTER}
  GL_TEXTURE_COORD_ARRAY_POINTER = $8092;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_POINTER}
  GL_SAMPLE_BUFFERS = $80A8;
  {$EXTERNALSYM GL_SAMPLE_BUFFERS}
  GL_SAMPLES = $80A9;
  {$EXTERNALSYM GL_SAMPLES}
  GL_SAMPLE_COVERAGE_VALUE = $80AA;
  {$EXTERNALSYM GL_SAMPLE_COVERAGE_VALUE}
  GL_SAMPLE_COVERAGE_INVERT = $80AB;
  {$EXTERNALSYM GL_SAMPLE_COVERAGE_INVERT}
  
  { GetTextureParameter  }
  {      GL_TEXTURE_MAG_FILTER  }
  {      GL_TEXTURE_MIN_FILTER  }
  {      GL_TEXTURE_WRAP_S  }
  {      GL_TEXTURE_WRAP_T  }

  GL_NUM_COMPRESSED_TEXTURE_FORMATS = $86A2;
  {$EXTERNALSYM GL_NUM_COMPRESSED_TEXTURE_FORMATS}
  GL_COMPRESSED_TEXTURE_FORMATS = $86A3;
  {$EXTERNALSYM GL_COMPRESSED_TEXTURE_FORMATS}
  
  { HintMode  }
  GL_DONT_CARE = $1100;
  {$EXTERNALSYM GL_DONT_CARE}
  GL_FASTEST = $1101;
  {$EXTERNALSYM GL_FASTEST}
  GL_NICEST = $1102;
  {$EXTERNALSYM GL_NICEST}
  
  { HintTarget  }
  GL_PERSPECTIVE_CORRECTION_HINT = $0C50;
  {$EXTERNALSYM GL_PERSPECTIVE_CORRECTION_HINT}
  GL_POINT_SMOOTH_HINT = $0C51;
  {$EXTERNALSYM GL_POINT_SMOOTH_HINT}
  GL_LINE_SMOOTH_HINT = $0C52;
  {$EXTERNALSYM GL_LINE_SMOOTH_HINT}
  GL_FOG_HINT = $0C54;
  {$EXTERNALSYM GL_FOG_HINT}
  GL_GENERATE_MIPMAP_HINT = $8192;
  {$EXTERNALSYM GL_GENERATE_MIPMAP_HINT}
  
  { LightModelParameter  }
  GL_LIGHT_MODEL_AMBIENT = $0B53;
  {$EXTERNALSYM GL_LIGHT_MODEL_AMBIENT}
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;
  {$EXTERNALSYM GL_LIGHT_MODEL_TWO_SIDE}
  
  { LightParameter  }
  GL_AMBIENT = $1200;
  {$EXTERNALSYM GL_AMBIENT}
  GL_DIFFUSE = $1201;
  {$EXTERNALSYM GL_DIFFUSE}
  GL_SPECULAR = $1202;
  {$EXTERNALSYM GL_SPECULAR}
  GL_POSITION = $1203;
  {$EXTERNALSYM GL_POSITION}
  GL_SPOT_DIRECTION = $1204;
  {$EXTERNALSYM GL_SPOT_DIRECTION}
  GL_SPOT_EXPONENT = $1205;
  {$EXTERNALSYM GL_SPOT_EXPONENT}
  GL_SPOT_CUTOFF = $1206;
  {$EXTERNALSYM GL_SPOT_CUTOFF}
  GL_CONSTANT_ATTENUATION = $1207;
  {$EXTERNALSYM GL_CONSTANT_ATTENUATION}
  GL_LINEAR_ATTENUATION = $1208;
  {$EXTERNALSYM GL_LINEAR_ATTENUATION}
  GL_QUADRATIC_ATTENUATION = $1209;
  {$EXTERNALSYM GL_QUADRATIC_ATTENUATION}
  
  { DataType  }
  GL_BYTE = $1400;
  {$EXTERNALSYM GL_BYTE}
  GL_UNSIGNED_BYTE = $1401;
  {$EXTERNALSYM GL_UNSIGNED_BYTE}
  GL_SHORT = $1402;
  {$EXTERNALSYM GL_SHORT}
  GL_UNSIGNED_SHORT = $1403;
  {$EXTERNALSYM GL_UNSIGNED_SHORT}
  GL_FLOAT = $1406;
  {$EXTERNALSYM GL_FLOAT}
  GL_FIXED = $140C;
  {$EXTERNALSYM GL_FIXED}
  
  { LogicOp  }
  GL_CLEAR = $1500;
  {$EXTERNALSYM GL_CLEAR}
  GL_AND = $1501;
  {$EXTERNALSYM GL_AND}
  GL_AND_REVERSE = $1502;
  {$EXTERNALSYM GL_AND_REVERSE}
  GL_COPY = $1503;
  {$EXTERNALSYM GL_COPY}
  GL_AND_INVERTED = $1504;
  {$EXTERNALSYM GL_AND_INVERTED}
  GL_NOOP = $1505;
  {$EXTERNALSYM GL_NOOP}
  GL_XOR = $1506;
  {$EXTERNALSYM GL_XOR}
  GL_OR = $1507;
  {$EXTERNALSYM GL_OR}
  GL_NOR = $1508;
  {$EXTERNALSYM GL_NOR}
  GL_EQUIV = $1509;
  {$EXTERNALSYM GL_EQUIV}
  GL_INVERT = $150A;
  {$EXTERNALSYM GL_INVERT}
  GL_OR_REVERSE = $150B;
  {$EXTERNALSYM GL_OR_REVERSE}
  GL_COPY_INVERTED = $150C;
  {$EXTERNALSYM GL_COPY_INVERTED}
  GL_OR_INVERTED = $150D;
  {$EXTERNALSYM GL_OR_INVERTED}
  GL_NAND = $150E;
  {$EXTERNALSYM GL_NAND}
  GL_SET = $150F;
  {$EXTERNALSYM GL_SET}
  
  { MaterialFace  }
  {      GL_FRONT_AND_BACK  }

  { MaterialParameter  }
  GL_EMISSION = $1600;
  {$EXTERNALSYM GL_EMISSION}
  GL_SHININESS = $1601;
  {$EXTERNALSYM GL_SHININESS}
  GL_AMBIENT_AND_DIFFUSE = $1602;
  {$EXTERNALSYM GL_AMBIENT_AND_DIFFUSE}
  {      GL_AMBIENT  }
  {      GL_DIFFUSE  }
  {      GL_SPECULAR  }

  { MatrixMode  }
  GL_MODELVIEW = $1700;
  {$EXTERNALSYM GL_MODELVIEW}
  GL_PROJECTION = $1701;
  {$EXTERNALSYM GL_PROJECTION}
  GL_TEXTURE = $1702;
  {$EXTERNALSYM GL_TEXTURE}
  
  { NormalPointerType  }
  {      GL_BYTE  }
  {      GL_SHORT  }
  {      GL_FLOAT  }
  {      GL_FIXED  }

  { PixelFormat  }
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

  { PixelType  }
  {      GL_UNSIGNED_BYTE  }
  GL_UNSIGNED_SHORT_4_4_4_4 = $8033;
  {$EXTERNALSYM GL_UNSIGNED_SHORT_4_4_4_4}
  GL_UNSIGNED_SHORT_5_5_5_1 = $8034;
  {$EXTERNALSYM GL_UNSIGNED_SHORT_5_5_5_1}
  GL_UNSIGNED_SHORT_5_6_5 = $8363;
  {$EXTERNALSYM GL_UNSIGNED_SHORT_5_6_5}
  
  { ShadingModel  }
  GL_FLAT = $1D00;
  {$EXTERNALSYM GL_FLAT}
  GL_SMOOTH = $1D01;
  {$EXTERNALSYM GL_SMOOTH}
  { StencilFunction  }
  {      GL_NEVER  }
  {      GL_LESS  }
  {      GL_EQUAL  }
  {      GL_LEQUAL  }
  {      GL_GREATER  }
  {      GL_NOTEQUAL  }
  {      GL_GEQUAL  }
  {      GL_ALWAYS  }

  { StencilOp  }
  {      GL_ZERO  }
  GL_KEEP = $1E00;
  {$EXTERNALSYM GL_KEEP}
  GL_REPLACE = $1E01;
  {$EXTERNALSYM GL_REPLACE}
  GL_INCR = $1E02;
  {$EXTERNALSYM GL_INCR}
  GL_DECR = $1E03;
  {$EXTERNALSYM GL_DECR}
  {      GL_INVERT  }

  { StringName  }
  GL_VENDOR = $1F00;
  {$EXTERNALSYM GL_VENDOR}
  GL_RENDERER = $1F01;
  {$EXTERNALSYM GL_RENDERER}
  GL_VERSION = $1F02;
  {$EXTERNALSYM GL_VERSION}
  GL_EXTENSIONS = $1F03;
  {$EXTERNALSYM GL_EXTENSIONS}
  
  { TexCoordPointerType  }
  {      GL_SHORT  }
  {      GL_FLOAT  }
  {      GL_FIXED  }
  {      GL_BYTE  }

  { TextureEnvMode  }
  GL_MODULATE = $2100;
  {$EXTERNALSYM GL_MODULATE}
  GL_DECAL = $2101;
  {$EXTERNALSYM GL_DECAL}
  {      GL_BLEND  }
  GL_ADD = $0104;
  {$EXTERNALSYM GL_ADD}
  {      GL_REPLACE  }

  { TextureEnvParameter  }
  GL_TEXTURE_ENV_MODE = $2200;
  {$EXTERNALSYM GL_TEXTURE_ENV_MODE}
  GL_TEXTURE_ENV_COLOR = $2201;
  {$EXTERNALSYM GL_TEXTURE_ENV_COLOR}
  
  { TextureEnvTarget  }
  GL_TEXTURE_ENV = $2300;
  {$EXTERNALSYM GL_TEXTURE_ENV}
  
  { TextureMagFilter  }
  GL_NEAREST = $2600;
  {$EXTERNALSYM GL_NEAREST}
  GL_LINEAR = $2601;
  {$EXTERNALSYM GL_LINEAR}
  
  { TextureMinFilter  }
  {      GL_NEAREST  }
  {      GL_LINEAR  }
  GL_NEAREST_MIPMAP_NEAREST = $2700;
  {$EXTERNALSYM GL_NEAREST_MIPMAP_NEAREST}
  GL_LINEAR_MIPMAP_NEAREST = $2701;
  {$EXTERNALSYM GL_LINEAR_MIPMAP_NEAREST}
  GL_NEAREST_MIPMAP_LINEAR = $2702;
  {$EXTERNALSYM GL_NEAREST_MIPMAP_LINEAR}
  GL_LINEAR_MIPMAP_LINEAR = $2703;
  {$EXTERNALSYM GL_LINEAR_MIPMAP_LINEAR}
  
  { TextureParameterName  }
  GL_TEXTURE_MAG_FILTER = $2800;
  {$EXTERNALSYM GL_TEXTURE_MAG_FILTER}
  GL_TEXTURE_MIN_FILTER = $2801;
  {$EXTERNALSYM GL_TEXTURE_MIN_FILTER}
  GL_TEXTURE_WRAP_S = $2802;
  {$EXTERNALSYM GL_TEXTURE_WRAP_S}
  GL_TEXTURE_WRAP_T = $2803;
  {$EXTERNALSYM GL_TEXTURE_WRAP_T}
  GL_GENERATE_MIPMAP = $8191;
  {$EXTERNALSYM GL_GENERATE_MIPMAP}
  
  { TextureTarget  }
  {      GL_TEXTURE_2D  }

  { TextureUnit  }
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
  GL_CLIENT_ACTIVE_TEXTURE = $84E1;
  {$EXTERNALSYM GL_CLIENT_ACTIVE_TEXTURE}
  
  { TextureWrapMode  }
  GL_REPEAT = $2901;
  {$EXTERNALSYM GL_REPEAT}
  GL_CLAMP_TO_EDGE = $812F;
  {$EXTERNALSYM GL_CLAMP_TO_EDGE}
  
  { VertexPointerType  }
  {      GL_SHORT  }
  {      GL_FLOAT  }
  {      GL_FIXED  }
  {      GL_BYTE  }

  { LightName  }
  GL_LIGHT0 = $4000;
  {$EXTERNALSYM GL_LIGHT0}
  GL_LIGHT1 = $4001;
  {$EXTERNALSYM GL_LIGHT1}
  GL_LIGHT2 = $4002;
  {$EXTERNALSYM GL_LIGHT2}
  GL_LIGHT3 = $4003;
  {$EXTERNALSYM GL_LIGHT3}
  GL_LIGHT4 = $4004;
  {$EXTERNALSYM GL_LIGHT4}
  GL_LIGHT5 = $4005;
  {$EXTERNALSYM GL_LIGHT5}
  GL_LIGHT6 = $4006;
  {$EXTERNALSYM GL_LIGHT6}
  GL_LIGHT7 = $4007;
  {$EXTERNALSYM GL_LIGHT7}
  
  { Buffer Objects  }
  GL_ARRAY_BUFFER = $8892;
  {$EXTERNALSYM GL_ARRAY_BUFFER}
  GL_ELEMENT_ARRAY_BUFFER = $8893;
  {$EXTERNALSYM GL_ELEMENT_ARRAY_BUFFER}
  
  GL_ARRAY_BUFFER_BINDING = $8894;
  {$EXTERNALSYM GL_ARRAY_BUFFER_BINDING}
  GL_ELEMENT_ARRAY_BUFFER_BINDING = $8895;
  {$EXTERNALSYM GL_ELEMENT_ARRAY_BUFFER_BINDING}
  GL_VERTEX_ARRAY_BUFFER_BINDING = $8896;
  {$EXTERNALSYM GL_VERTEX_ARRAY_BUFFER_BINDING}
  GL_NORMAL_ARRAY_BUFFER_BINDING = $8897;
  {$EXTERNALSYM GL_NORMAL_ARRAY_BUFFER_BINDING}
  GL_COLOR_ARRAY_BUFFER_BINDING = $8898;
  {$EXTERNALSYM GL_COLOR_ARRAY_BUFFER_BINDING}
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING = $889A;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING}
  
  GL_STATIC_DRAW = $88E4;
  {$EXTERNALSYM GL_STATIC_DRAW}
  GL_DYNAMIC_DRAW = $88E8;
  {$EXTERNALSYM GL_DYNAMIC_DRAW}
  
  GL_BUFFER_SIZE = $8764;
  {$EXTERNALSYM GL_BUFFER_SIZE}
  GL_BUFFER_USAGE = $8765;
  {$EXTERNALSYM GL_BUFFER_USAGE}
  
  { Texture combine + dot3  }
  GL_SUBTRACT = $84E7;
  {$EXTERNALSYM GL_SUBTRACT}
  GL_COMBINE = $8570;
  {$EXTERNALSYM GL_COMBINE}
  GL_COMBINE_RGB = $8571;
  {$EXTERNALSYM GL_COMBINE_RGB}
  GL_COMBINE_ALPHA = $8572;
  {$EXTERNALSYM GL_COMBINE_ALPHA}
  GL_RGB_SCALE = $8573;
  {$EXTERNALSYM GL_RGB_SCALE}
  GL_ADD_SIGNED = $8574;
  {$EXTERNALSYM GL_ADD_SIGNED}
  GL_INTERPOLATE = $8575;
  {$EXTERNALSYM GL_INTERPOLATE}
  GL_CONSTANT = $8576;
  {$EXTERNALSYM GL_CONSTANT}
  GL_PRIMARY_COLOR = $8577;
  {$EXTERNALSYM GL_PRIMARY_COLOR}
  GL_PREVIOUS = $8578;
  {$EXTERNALSYM GL_PREVIOUS}
  GL_OPERAND0_RGB = $8590;
  {$EXTERNALSYM GL_OPERAND0_RGB}
  GL_OPERAND1_RGB = $8591;
  {$EXTERNALSYM GL_OPERAND1_RGB}
  GL_OPERAND2_RGB = $8592;
  {$EXTERNALSYM GL_OPERAND2_RGB}
  GL_OPERAND0_ALPHA = $8598;
  {$EXTERNALSYM GL_OPERAND0_ALPHA}
  GL_OPERAND1_ALPHA = $8599;
  {$EXTERNALSYM GL_OPERAND1_ALPHA}
  GL_OPERAND2_ALPHA = $859A;
  {$EXTERNALSYM GL_OPERAND2_ALPHA}
  
  GL_ALPHA_SCALE = $0D1C;
  {$EXTERNALSYM GL_ALPHA_SCALE}
  
  GL_SRC0_RGB = $8580;
  {$EXTERNALSYM GL_SRC0_RGB}
  GL_SRC1_RGB = $8581;
  {$EXTERNALSYM GL_SRC1_RGB}
  GL_SRC2_RGB = $8582;
  {$EXTERNALSYM GL_SRC2_RGB}
  GL_SRC0_ALPHA = $8588;
  {$EXTERNALSYM GL_SRC0_ALPHA}
  GL_SRC1_ALPHA = $8589;
  {$EXTERNALSYM GL_SRC1_ALPHA}
  GL_SRC2_ALPHA = $858A;
  {$EXTERNALSYM GL_SRC2_ALPHA}
  GL_DOT3_RGB = $86AE;
  {$EXTERNALSYM GL_DOT3_RGB}
  GL_DOT3_RGBA = $86AF;
  {$EXTERNALSYM GL_DOT3_RGBA}
{ ------------------------------------------------------------------------
  required OES extension tokens
  ------------------------------------------------------------------------ }

  { OES_read_format  }
  GL_IMPLEMENTATION_COLOR_READ_TYPE_OES = $8B9A;
  {$EXTERNALSYM GL_IMPLEMENTATION_COLOR_READ_TYPE_OES}
  GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES = $8B9B;
  {$EXTERNALSYM GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES}

  { GL_OES_compressed_paletted_texture  }
  GL_PALETTE4_RGB8_OES = $8B90;
  {$EXTERNALSYM GL_PALETTE4_RGB8_OES}
  GL_PALETTE4_RGBA8_OES = $8B91;
  {$EXTERNALSYM GL_PALETTE4_RGBA8_OES}
  GL_PALETTE4_R5_G6_B5_OES = $8B92;
  {$EXTERNALSYM GL_PALETTE4_R5_G6_B5_OES}
  GL_PALETTE4_RGBA4_OES = $8B93;
  {$EXTERNALSYM GL_PALETTE4_RGBA4_OES}
  GL_PALETTE4_RGB5_A1_OES = $8B94;
  {$EXTERNALSYM GL_PALETTE4_RGB5_A1_OES}
  GL_PALETTE8_RGB8_OES = $8B95;
  {$EXTERNALSYM GL_PALETTE8_RGB8_OES}
  GL_PALETTE8_RGBA8_OES = $8B96;
  {$EXTERNALSYM GL_PALETTE8_RGBA8_OES}
  GL_PALETTE8_R5_G6_B5_OES = $8B97;
  {$EXTERNALSYM GL_PALETTE8_R5_G6_B5_OES}
  GL_PALETTE8_RGBA4_OES = $8B98;
  {$EXTERNALSYM GL_PALETTE8_RGBA4_OES}
  GL_PALETTE8_RGB5_A1_OES = $8B99;
  {$EXTERNALSYM GL_PALETTE8_RGB5_A1_OES}

  { OES_point_size_array  }

  GL_POINT_SIZE_ARRAY_OES = $8B9C;
  {$EXTERNALSYM GL_POINT_SIZE_ARRAY_OES}
  GL_POINT_SIZE_ARRAY_TYPE_OES = $898A;
  {$EXTERNALSYM GL_POINT_SIZE_ARRAY_TYPE_OES}
  GL_POINT_SIZE_ARRAY_STRIDE_OES = $898B;
  {$EXTERNALSYM GL_POINT_SIZE_ARRAY_STRIDE_OES}
  GL_POINT_SIZE_ARRAY_POINTER_OES = $898C;
  {$EXTERNALSYM GL_POINT_SIZE_ARRAY_POINTER_OES}
  GL_POINT_SIZE_ARRAY_BUFFER_BINDING_OES = $8B9F;
  {$EXTERNALSYM GL_POINT_SIZE_ARRAY_BUFFER_BINDING_OES}

  { GL_OES_point_sprite  }
  GL_POINT_SPRITE_OES = $8861;
  {$EXTERNALSYM GL_POINT_SPRITE_OES}
  GL_COORD_REPLACE_OES = $8862;
  {$EXTERNALSYM GL_COORD_REPLACE_OES}

  {*********************************************************** }

  { Available only in Common profile  }

procedure glAlphaFunc(func: GLenum; ref: GLclampf); cdecl;
 external AndroidGlesLib name 'glAlphaFunc';
{$EXTERNALSYM glAlphaFunc}

procedure glClearColor(red, green, blue, alpha: GLclampf); cdecl;
 external AndroidGlesLib name 'glClearColor';
{$EXTERNALSYM glClearColor}

procedure glClearDepthf(depth: GLclampf); cdecl;
 external AndroidGlesLib name 'glClearDepthf';
{$EXTERNALSYM glClearDepthf}

procedure glClipPlanef(plane: GLenum; equation: PGLfloat); cdecl;
 external AndroidGlesLib name 'glClipPlanef';
{$EXTERNALSYM glClipPlanef}

procedure glColor4f(red, green, blue, alpha: GLfloat); cdecl;
 external AndroidGlesLib name 'glColor4f';
{$EXTERNALSYM glColor4f}

procedure glDepthRangef(zNear, zFar: GLclampf); cdecl;
 external AndroidGlesLib name 'glDepthRangef';
{$EXTERNALSYM glDepthRangef}

procedure glFogf(pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glFogf';
{$EXTERNALSYM glFogf}

procedure glFogfv(pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glFogfv';
{$EXTERNALSYM glFogfv}

procedure glFrustumf(left, right, bottom, top, zNear, zFar: GLfloat); cdecl;
 external AndroidGlesLib name 'glFrustumf';
{$EXTERNALSYM glFrustumf}

procedure glGetClipPlanef(pname: GLenum; eqn: GLfloat); cdecl;
 external AndroidGlesLib name 'glGetClipPlanef';
{$EXTERNALSYM glGetClipPlanef}

procedure glGetFloatv(pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glGetFloatv';
{$EXTERNALSYM glGetFloatv}

procedure glGetLightfv(light, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glGetLightfv';
{$EXTERNALSYM glGetLightfv}

procedure glGetMaterialfv(face, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glGetMaterialfv';
{$EXTERNALSYM glGetMaterialfv}

procedure glGetTexEnvfv(env, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glGetTexEnvfv';
{$EXTERNALSYM glGetTexEnvfv}

procedure glGetTexParameterfv(target, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glGetTexParameterfv';
{$EXTERNALSYM glGetTexParameterfv}

procedure glLightModelf(pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glLightModelf';
{$EXTERNALSYM glLightModelf}

procedure glLightModelfv(pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glLightModelfv';
{$EXTERNALSYM glLightModelfv}

procedure glLightf(light, pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glLightf';
{$EXTERNALSYM glLightf}

procedure glLightfv(light, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glLightfv';
{$EXTERNALSYM glLightfv}

procedure glLineWidth(width: GLfloat); cdecl;
 external AndroidGlesLib name 'glLineWidth';
{$EXTERNALSYM glLineWidth}

procedure glLoadMatrixf(m: PGLfloat); cdecl;
 external AndroidGlesLib name 'glLoadMatrixf';
{$EXTERNALSYM glLoadMatrixf}

procedure glMaterialf(face, pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glMaterialf';
{$EXTERNALSYM glMaterialf}

procedure glMaterialfv(face, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glMaterialfv';
{$EXTERNALSYM glMaterialfv}

procedure glMultMatrixf(m: PGLfloat); cdecl;
 external AndroidGlesLib name 'glMultMatrixf';
{$EXTERNALSYM glMultMatrixf}

procedure glMultiTexCoord4f(target: GLenum; s, t, r, q: GLfloat); cdecl;
 external AndroidGlesLib name 'glMultiTexCoord4f';
{$EXTERNALSYM glMultiTexCoord4f}

procedure glNormal3f(nx, ny, nz: GLfloat); cdecl;
 external AndroidGlesLib name 'glNormal3f';
{$EXTERNALSYM glNormal3f}

procedure glOrthof(left, right, bottom, top, zNear, zFar: GLfloat); cdecl;
 external AndroidGlesLib name 'glOrthof';
{$EXTERNALSYM glOrthof}

procedure glPointParameterf(pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glPointParameterf';
{$EXTERNALSYM glPointParameterf}

procedure glPointParameterfv(pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glPointParameterfv';
{$EXTERNALSYM glPointParameterfv}

procedure glPointSize(size: GLfloat); cdecl;
 external AndroidGlesLib name 'glPointSize';
{$EXTERNALSYM glPointSize}

procedure glPolygonOffset(factor, units: GLfloat); cdecl;
 external AndroidGlesLib name 'glPolygonOffset';
{$EXTERNALSYM glPolygonOffset}

procedure glRotatef(angle, x, y, z: GLfloat); cdecl;
 external AndroidGlesLib name 'glRotatef';
{$EXTERNALSYM glRotatef}

procedure glScalef(x, y, z: GLfloat); cdecl;
 external AndroidGlesLib name 'glScalef';
{$EXTERNALSYM glScalef}

procedure glTexEnvf(target, pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glTexEnvf';
{$EXTERNALSYM glTexEnvf}

procedure glTexEnvfv(target, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glTexEnvfv';
{$EXTERNALSYM glTexEnvfv}

procedure glTexParameterf(target, pname: GLenum; param: GLfloat); cdecl;
 external AndroidGlesLib name 'glTexParameterf';
{$EXTERNALSYM glTexParameterf}

procedure glTexParameterfv(target, pname: GLenum; params: PGLfloat); cdecl;
 external AndroidGlesLib name 'glTexParameterfv';
{$EXTERNALSYM glTexParameterfv}

procedure glTranslatef(x, y, z: GLfloat); cdecl;
 external AndroidGlesLib name 'glTranslatef';
{$EXTERNALSYM glTranslatef}


{ Available in both Common and Common-Lite profiles  }
procedure glActiveTexture(texture: GLenum); cdecl;
 external AndroidGlesLib name 'glActiveTexture';
{$EXTERNALSYM glActiveTexture}

procedure glAlphaFuncx(func: GLenum; ref: GLclampx); cdecl;
 external AndroidGlesLib name 'glAlphaFuncx';
{$EXTERNALSYM glAlphaFuncx}

procedure glBindBuffer(target: GLenum; buffer: GLuint); cdecl;
 external AndroidGlesLib name 'glBindBuffer';
{$EXTERNALSYM glBindBuffer}

procedure glBindTexture(target: GLenum; texture: GLuint); cdecl;
 external AndroidGlesLib name 'glBindTexture';
{$EXTERNALSYM glBindTexture}

procedure glBlendFunc(sfactor, dfactor: GLenum); cdecl;
 external AndroidGlesLib name 'glBlendFunc';
{$EXTERNALSYM glBlendFunc}

procedure glBufferData(target: GLenum; size: GLsizeiptr; data: PGLvoid; usage: GLenum); cdecl;
 external AndroidGlesLib name 'glBufferData';
{$EXTERNALSYM glBufferData}

procedure glBufferSubData(target: GLenum; offset: GLintptr; size: GLsizeiptr; data: PGLvoid); cdecl;
 external AndroidGlesLib name 'glBufferSubData';
{$EXTERNALSYM glBufferSubData}

procedure glClear(mask: GLbitfield); cdecl;
 external AndroidGlesLib name 'glClear';
{$EXTERNALSYM glClear}

procedure glClearColorx(red, green, blue, alpha: GLclampx); cdecl;
 external AndroidGlesLib name 'glClearColorx';
{$EXTERNALSYM glClearColorx}

procedure glClearDepthx(depth: GLclampx); cdecl;
 external AndroidGlesLib name 'glClearDepthx';
{$EXTERNALSYM glClearDepthx}

procedure glClearStencil(s: GLint); cdecl;
 external AndroidGlesLib name 'glClearStencil';
{$EXTERNALSYM glClearStencil}

procedure glClientActiveTexture(texture: GLenum); cdecl;
 external AndroidGlesLib name 'glClientActiveTexture';
{$EXTERNALSYM glClientActiveTexture}

procedure glClipPlanex(plane: GLenum; equation: PGLfixed); cdecl;
 external AndroidGlesLib name 'glClipPlanex';
{$EXTERNALSYM glClipPlanex}

procedure glColor4ub(red, green, blue, alpha: GLubyte); cdecl;
 external AndroidGlesLib name 'glColor4ub';
{$EXTERNALSYM glColor4ub}

procedure glColor4x(red, green, blue, alpha: GLfixed); cdecl;
 external AndroidGlesLib name 'glColor4x';
{$EXTERNALSYM glColor4x}

procedure glColorMask(red, green, blue, alpha: GLboolean); cdecl;
 external AndroidGlesLib name 'glColorMask';
{$EXTERNALSYM glColorMask}

procedure glColorPointer(size: GLint; type_: GLenum; stride: GLsizei; pointer: PGLvoid); cdecl;
 external AndroidGlesLib name 'glColorPointer';
{$EXTERNALSYM glColorPointer}

procedure glCompressedTexImage2D(target: GLenum; level: GLint; internalformat: GLenum; width, height: GLsizei; border: GLint; imageSize: GLsizei; data: PGLvoid); cdecl;
 external AndroidGlesLib name 'glCompressedTexImage2D';
{$EXTERNALSYM glCompressedTexImage2D}

procedure glCompressedTexSubImage2D(target: GLenum;level, xoffset, yoffset: GLint; width, height: GLsizei; format: GLenum;imageSize: GLsizei; data: PGLvoid); cdecl;
 external AndroidGlesLib name 'glCompressedTexSubImage2D';
{$EXTERNALSYM glCompressedTexSubImage2D}

procedure glCopyTexImage2D(target: GLenum; level: GLint; internalformat: GLenum; x, y: GLint; width, height: GLsizei; border: GLint); cdecl;
 external AndroidGlesLib name 'glCopyTexImage2D';
{$EXTERNALSYM glCopyTexImage2D}

procedure glCopyTexSubImage2D(target: GLenum; level, xoffset, yoffset, x, y: GLint; width, height: GLsizei); cdecl;
 external AndroidGlesLib name 'glCopyTexSubImage2D';
{$EXTERNALSYM glCopyTexSubImage2D}

procedure glCullFace(mode: GLenum); cdecl;
 external AndroidGlesLib name 'glCullFace';
{$EXTERNALSYM glCullFace}

procedure glDeleteBuffers(n: GLsizei; buffers: PGLuint); cdecl;
 external AndroidGlesLib name 'glDeleteBuffers';
{$EXTERNALSYM glDeleteBuffers}

procedure glDeleteTextures(n: GLsizei; textures: PGLuint); cdecl;
 external AndroidGlesLib name 'glDeleteTextures';
{$EXTERNALSYM glDeleteTextures}

procedure glDepthFunc(func: GLenum); cdecl;
 external AndroidGlesLib name 'glDepthFunc';
{$EXTERNALSYM glDepthFunc}

procedure glDepthMask(flag: GLboolean); cdecl;
 external AndroidGlesLib name 'glDepthMask';
{$EXTERNALSYM glDepthMask}

procedure glDepthRangex(zNear, zFar: GLclampx); cdecl;
 external AndroidGlesLib name 'glDepthRangex';
{$EXTERNALSYM glDepthRangex}

procedure glDisable(cap: GLenum); cdecl;
 external AndroidGlesLib name 'glDisable';
{$EXTERNALSYM glDisable}

procedure glDisableClientState(array_: GLenum); cdecl;
 external AndroidGlesLib name 'glDisableClientState';
{$EXTERNALSYM glDisableClientState}

procedure glDrawArrays(mode: GLenum; first: GLint; count: GLsizei); cdecl;
 external AndroidGlesLib name 'glDrawArrays';
{$EXTERNALSYM glDrawArrays}

procedure glDrawElements(mode: GLenum; count: GLsizei; type_: GLenum; indices: PGLvoid); cdecl;
 external AndroidGlesLib name 'glDrawElements';
{$EXTERNALSYM glDrawElements}

procedure glEnable(cap: GLenum); cdecl;
 external AndroidGlesLib name 'glEnable';
{$EXTERNALSYM glEnable}

procedure glEnableClientState(array_: GLenum); cdecl;
 external AndroidGlesLib name 'glEnableClientState';
{$EXTERNALSYM glEnableClientState}

procedure glFinish; cdecl;
 external AndroidGlesLib name 'glFinish';
{$EXTERNALSYM glFinish}

procedure glFlush; cdecl;
 external AndroidGlesLib name 'glFlush';
{$EXTERNALSYM glFlush}

procedure glFogx(pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glFogx';
{$EXTERNALSYM glFogx}

procedure glFogxv(pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glFogxv';
{$EXTERNALSYM glFogxv}

procedure glFrontFace(mode: GLenum); cdecl;
 external AndroidGlesLib name 'glFrontFace';
{$EXTERNALSYM glFrontFace}

procedure glFrustumx(left, right, bottom, top, zNear, zFar: GLfixed); cdecl;
 external AndroidGlesLib name 'glFrustumx';
{$EXTERNALSYM glFrustumx}

procedure glGetBooleanv(pname: GLenum; params: PGLboolean); cdecl;
 external AndroidGlesLib name 'glGetBooleanv';
{$EXTERNALSYM glGetBooleanv}

procedure glGetBufferParameteriv(target, pname: GLenum; params: PGLint); cdecl;
 external AndroidGlesLib name 'glGetBufferParameteriv';
{$EXTERNALSYM glGetBufferParameteriv}

procedure glGetClipPlanex(pname: GLenum; eqn: GLfixed); cdecl;
 external AndroidGlesLib name 'glGetClipPlanex';
{$EXTERNALSYM glGetClipPlanex}

procedure glGenBuffers(n: GLsizei; buffers: PGLuint); cdecl;
 external AndroidGlesLib name 'glGenBuffers';
{$EXTERNALSYM glGenBuffers}

procedure glGenTextures(n: GLsizei; textures: PGLuint); cdecl;
 external AndroidGlesLib name 'glGenTextures';
{$EXTERNALSYM glGenTextures}

function glGetError: GLenum; cdecl;
 external AndroidGlesLib name 'glGetError';
{$EXTERNALSYM glGetError}

procedure glGetFixedv(pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glGetFixedv';
{$EXTERNALSYM glGetFixedv}

procedure glGetIntegerv(pname: GLenum; params: PGLint); cdecl;
 external AndroidGlesLib name 'glGetIntegerv';
{$EXTERNALSYM glGetIntegerv}

procedure glGetLightxv(light, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glGetLightxv';
{$EXTERNALSYM glGetLightxv}

procedure glGetMaterialxv(face, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glGetMaterialxv';
{$EXTERNALSYM glGetMaterialxv}

procedure glGetPointerv(pname: GLenum; params: PPointer); cdecl;
 external AndroidGlesLib name 'glGetPointerv';
{$EXTERNALSYM glGetPointerv}

function glGetString(name_: GLenum): PGLubyte; cdecl;
 external AndroidGlesLib name 'glGetString';
{$EXTERNALSYM glGetString}

procedure glGetTexEnviv(env, pname: GLenum; params: PGLint); cdecl;
 external AndroidGlesLib name 'glGetTexEnviv';
{$EXTERNALSYM glGetTexEnviv}

procedure glGetTexEnvxv(env, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glGetTexEnvxv';
{$EXTERNALSYM glGetTexEnvxv}

procedure glGetTexParameteriv(target, pname: GLenum; params: PGLint); cdecl;
 external AndroidGlesLib name 'glGetTexParameteriv';
{$EXTERNALSYM glGetTexParameteriv}

procedure glGetTexParameterxv(target, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glGetTexParameterxv';
{$EXTERNALSYM glGetTexParameterxv}

procedure glHint(target, mode: GLenum); cdecl;
 external AndroidGlesLib name 'glHint';
{$EXTERNALSYM glHint}

function glIsBuffer(buffer: GLuint): GLboolean; cdecl;
 external AndroidGlesLib name 'glIsBuffer';
{$EXTERNALSYM glIsBuffer}

function glIsEnabled(cap: GLenum): GLboolean; cdecl;
 external AndroidGlesLib name 'glIsEnabled';
{$EXTERNALSYM glIsEnabled}

function glIsTexture(texture: GLuint): GLboolean; cdecl;
 external AndroidGlesLib name 'glIsTexture';
{$EXTERNALSYM glIsTexture}

procedure glLightModelx(pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glLightModelx';
{$EXTERNALSYM glLightModelx}

procedure glLightModelxv(pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glLightModelxv';
{$EXTERNALSYM glLightModelxv}

procedure glLightx(light, pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glLightx';
{$EXTERNALSYM glLightx}

procedure glLightxv(light, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glLightxv';
{$EXTERNALSYM glLightxv}

procedure glLineWidthx(width: GLfixed); cdecl;
 external AndroidGlesLib name 'glLineWidthx';
{$EXTERNALSYM glLineWidthx}

procedure glLoadIdentity; cdecl;
 external AndroidGlesLib name 'glLoadIdentity';
{$EXTERNALSYM glLoadIdentity}

procedure glLoadMatrixx(m: PGLfixed); cdecl;
 external AndroidGlesLib name 'glLoadMatrixx';
{$EXTERNALSYM glLoadMatrixx}

procedure glLogicOp(opcode: GLenum); cdecl;
 external AndroidGlesLib name 'glLogicOp';
{$EXTERNALSYM glLogicOp}

procedure glMaterialx(face, pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glMaterialx';
{$EXTERNALSYM glMaterialx}

procedure glMaterialxv(face, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glMaterialxv';
{$EXTERNALSYM glMaterialxv}

procedure glMatrixMode(mode: GLenum); cdecl;
 external AndroidGlesLib name 'glMatrixMode';
{$EXTERNALSYM glMatrixMode}

procedure glMultMatrixx(m: PGLfixed); cdecl;
 external AndroidGlesLib name 'glMultMatrixx';
{$EXTERNALSYM glMultMatrixx}

procedure glMultiTexCoord4x(target: GLenum; s, t, r, q: GLfixed); cdecl;
 external AndroidGlesLib name 'glMultiTexCoord4x';
{$EXTERNALSYM glMultiTexCoord4x}

procedure glNormal3x(nx, ny, nz: GLfixed); cdecl;
 external AndroidGlesLib name 'glNormal3x';
{$EXTERNALSYM glNormal3x}

procedure glNormalPointer(type_: GLenum; stride: GLsizei; pointer: PGLvoid); cdecl;
 external AndroidGlesLib name 'glNormalPointer';
{$EXTERNALSYM glNormalPointer}

procedure glOrthox(left, right, bottom, top, zNear, zFar: GLfixed); cdecl;
 external AndroidGlesLib name 'glOrthox';
{$EXTERNALSYM glOrthox}

procedure glPixelStorei(pname: GLenum; param: GLint); cdecl;
 external AndroidGlesLib name 'glPixelStorei';
{$EXTERNALSYM glPixelStorei}

procedure glPointParameterx(pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glPointParameterx';
{$EXTERNALSYM glPointParameterx}

procedure glPointParameterxv(pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glPointParameterxv';
{$EXTERNALSYM glPointParameterxv}

procedure glPointSizex(size: GLfixed); cdecl;
 external AndroidGlesLib name 'glPointSizex';
{$EXTERNALSYM glPointSizex}

procedure glPolygonOffsetx(factor, units: GLfixed); cdecl;
 external AndroidGlesLib name 'glPolygonOffsetx';
{$EXTERNALSYM glPolygonOffsetx}

procedure glPopMatrix; cdecl;
 external AndroidGlesLib name 'glPopMatrix';
{$EXTERNALSYM glPopMatrix}

procedure glPushMatrix; cdecl;
 external AndroidGlesLib name 'glPushMatrix';
{$EXTERNALSYM glPushMatrix}

procedure glReadPixels(x, y: GLint; width, height: GLsizei; format, type_: GLenum; pixels: PGLvoid); cdecl;
 external AndroidGlesLib name 'glReadPixels';
{$EXTERNALSYM glReadPixels}

procedure glRotatex(angle, x, y, z: GLfixed); cdecl;
 external AndroidGlesLib name 'glRotatex';
{$EXTERNALSYM glRotatex}

procedure glSampleCoverage(value: GLclampf; invert: GLboolean); cdecl;
 external AndroidGlesLib name 'glSampleCoverage';
{$EXTERNALSYM glSampleCoverage}

procedure glSampleCoveragex(value: GLclampx; invert: GLboolean); cdecl;
 external AndroidGlesLib name 'glSampleCoveragex';
{$EXTERNALSYM glSampleCoveragex}

procedure glScalex(x, y, z: GLfixed); cdecl;
 external AndroidGlesLib name 'glScalex';
{$EXTERNALSYM glScalex}

procedure glScissor(x, y: GLint; width, height: GLsizei); cdecl;
 external AndroidGlesLib name 'glScissor';
{$EXTERNALSYM glScissor}

procedure glShadeModel(mode: GLenum); cdecl;
 external AndroidGlesLib name 'glShadeModel';
{$EXTERNALSYM glShadeModel}

procedure glStencilFunc(func: GLenum; ref: GLint; mask: GLuint); cdecl;
 external AndroidGlesLib name 'glStencilFunc';
{$EXTERNALSYM glStencilFunc}

procedure glStencilMask(mask: GLuint); cdecl;
 external AndroidGlesLib name 'glStencilMask';
{$EXTERNALSYM glStencilMask}

procedure glStencilOp(fail, zfail, zpass: GLenum); cdecl;
 external AndroidGlesLib name 'glStencilOp';
{$EXTERNALSYM glStencilOp}

procedure glTexCoordPointer(size: GLint; type_: GLenum; stride: GLsizei; pointer: PGLvoid); cdecl;
 external AndroidGlesLib name 'glTexCoordPointer';
{$EXTERNALSYM glTexCoordPointer}

procedure glTexEnvi(target, pname: GLenum; param: GLint); cdecl;
 external AndroidGlesLib name 'glTexEnvi';
{$EXTERNALSYM glTexEnvi}

procedure glTexEnvx(target, pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glTexEnvx';
{$EXTERNALSYM glTexEnvx}

procedure glTexEnviv(target, pname: GLenum; params: PGLint); cdecl;
 external AndroidGlesLib name 'glTexEnviv';
{$EXTERNALSYM glTexEnviv}

procedure glTexEnvxv(target, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glTexEnvxv';
{$EXTERNALSYM glTexEnvxv}

procedure glTexImage2D(target: GLenum; level, internalformat: GLint; width, height: GLsizei; border: GLint; format, type_: GLenum; pixels: PGLvoid); cdecl;
 external AndroidGlesLib name 'glTexImage2D';
{$EXTERNALSYM glTexImage2D}

procedure glTexParameteri(target, pname: GLenum; param: GLint); cdecl;
 external AndroidGlesLib name 'glTexParameteri';
{$EXTERNALSYM glTexParameteri}

procedure glTexParameterx(target, pname: GLenum; param: GLfixed); cdecl;
 external AndroidGlesLib name 'glTexParameterx';
{$EXTERNALSYM glTexParameterx}

procedure glTexParameteriv(target, pname: GLenum; params: PGLint); cdecl;
 external AndroidGlesLib name 'glTexParameteriv';
{$EXTERNALSYM glTexParameteriv}

procedure glTexParameterxv(target, pname: GLenum; params: PGLfixed); cdecl;
 external AndroidGlesLib name 'glTexParameterxv';
{$EXTERNALSYM glTexParameterxv}

procedure glTexSubImage2D(target: GLenum; level, xoffset, yoffset: GLint; width, height: GLsizei; format, type_: GLenum; pixels: PGLvoid); cdecl;
 external AndroidGlesLib name 'glTexSubImage2D';
{$EXTERNALSYM glTexSubImage2D}

procedure glTranslatex(x, y, z: GLfixed); cdecl;
 external AndroidGlesLib name 'glTranslatex';
{$EXTERNALSYM glTranslatex}

procedure glVertexPointer(size: GLint; type_: GLenum; stride: GLsizei; pointer: PGLvoid); cdecl;
 external AndroidGlesLib name 'glVertexPointer';
{$EXTERNALSYM glVertexPointer}

procedure glViewport(x, y: GLint; width, height: GLsizei); cdecl;
 external AndroidGlesLib name 'glViewport';
{$EXTERNALSYM glViewport}


{ ------------------------------------------------------------------------
  Required OES extension functions
  ------------------------------------------------------------------------ }

{ GL_OES_read_format  }

const
  GL_OES_read_format = 1;
  {$EXTERNALSYM GL_OES_read_format}

  { GL_OES_compressed_paletted_texture  }
  GL_OES_compressed_paletted_texture = 1;
  {$EXTERNALSYM GL_OES_compressed_paletted_texture}

  { GL_OES_point_size_array  }
  GL_OES_point_size_array = 1;
  {$EXTERNALSYM GL_OES_point_size_array}

procedure glPointSizePointerOES(type_: GLenum; stride: GLsizei; pointer: PGLvoid); cdecl;
 external AndroidGlesLib name 'glPointSizePointerOES';
{$EXTERNALSYM glPointSizePointerOES}


{ GL_OES_point_sprite  }

const
  GL_OES_point_sprite = 1;
  {$EXTERNALSYM GL_OES_point_sprite}


implementation

end.
