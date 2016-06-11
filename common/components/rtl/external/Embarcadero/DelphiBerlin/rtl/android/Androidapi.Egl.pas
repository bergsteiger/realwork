{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Egl;

interface

uses Posix.SysTypes, Androidapi.EglPlatform;

{$I Androidapi.inc}

type
  EGLBoolean = UInt32;
  {$EXTERNALSYM EGLBoolean}
  EGLenum = UInt32;
  {$EXTERNALSYM EGLenum}
                                                                
  EGLint = Integer;
  {$EXTERNALSYM EGLint}
  PEGLint = ^EGLint; 

  EGLConfig  = Pointer;
  {$EXTERNALSYM EGLConfig}
  EGLContext = Pointer;
  {$EXTERNALSYM EGLContext}
  EGLDisplay = Pointer;
  {$EXTERNALSYM EGLDisplay}
  EGLSurface = Pointer;
  {$EXTERNALSYM EGLSurface}
  EGLClientBuffer = Pointer;
  {$EXTERNALSYM EGLClientBuffer}

  PEGLConfig = ^EGLConfig;

const
  { EGL Versioning }
  EGL_VERSION_1_0 = 1;
  {$EXTERNALSYM EGL_VERSION_1_0}
  EGL_VERSION_1_1 = 1;
  {$EXTERNALSYM EGL_VERSION_1_1}
  EGL_VERSION_1_2 = 1;
  {$EXTERNALSYM EGL_VERSION_1_2}
  EGL_VERSION_1_3 = 1;
  {$EXTERNALSYM EGL_VERSION_1_3}
  EGL_VERSION_1_4 = 1;
  {$EXTERNALSYM EGL_VERSION_1_4}
  
  { EGL Enumerants. Bitmasks and other exceptional cases aside, most
    enums are assigned unique values starting at 0x3000.
  }

  { EGL aliases }
  EGL_FALSE = 0;
  {$EXTERNALSYM EGL_FALSE}
  EGL_TRUE = 1;
  {$EXTERNALSYM EGL_TRUE}
  
  { Errors / GetError return values }
  EGL_SUCCESS = $3000;
  {$EXTERNALSYM EGL_SUCCESS}
  EGL_NOT_INITIALIZED = $3001;
  {$EXTERNALSYM EGL_NOT_INITIALIZED}
  EGL_BAD_ACCESS = $3002;
  {$EXTERNALSYM EGL_BAD_ACCESS}
  EGL_BAD_ALLOC = $3003;
  {$EXTERNALSYM EGL_BAD_ALLOC}
  EGL_BAD_ATTRIBUTE = $3004;
  {$EXTERNALSYM EGL_BAD_ATTRIBUTE}
  EGL_BAD_CONFIG = $3005;
  {$EXTERNALSYM EGL_BAD_CONFIG}
  EGL_BAD_CONTEXT = $3006;
  {$EXTERNALSYM EGL_BAD_CONTEXT}
  EGL_BAD_CURRENT_SURFACE = $3007;
  {$EXTERNALSYM EGL_BAD_CURRENT_SURFACE}
  EGL_BAD_DISPLAY = $3008;
  {$EXTERNALSYM EGL_BAD_DISPLAY}
  EGL_BAD_MATCH = $3009;
  {$EXTERNALSYM EGL_BAD_MATCH}
  EGL_BAD_NATIVE_PIXMAP = $300A;
  {$EXTERNALSYM EGL_BAD_NATIVE_PIXMAP}
  EGL_BAD_NATIVE_WINDOW = $300B;
  {$EXTERNALSYM EGL_BAD_NATIVE_WINDOW}
  EGL_BAD_PARAMETER = $300C;
  {$EXTERNALSYM EGL_BAD_PARAMETER}
  EGL_BAD_SURFACE = $300D;
  {$EXTERNALSYM EGL_BAD_SURFACE}
  EGL_CONTEXT_LOST = $300E;       // EGL 1.1 - IMG_power_management
  {$EXTERNALSYM EGL_CONTEXT_LOST}
  
  
  { Reserved 0x300F-0x301F for additional errors}

  { Config attributes }
  EGL_BUFFER_SIZE = $3020;
  {$EXTERNALSYM EGL_BUFFER_SIZE}
  EGL_ALPHA_SIZE = $3021;
  {$EXTERNALSYM EGL_ALPHA_SIZE}
  EGL_BLUE_SIZE = $3022;
  {$EXTERNALSYM EGL_BLUE_SIZE}
  EGL_GREEN_SIZE = $3023;
  {$EXTERNALSYM EGL_GREEN_SIZE}
  EGL_RED_SIZE = $3024;
  {$EXTERNALSYM EGL_RED_SIZE}
  EGL_DEPTH_SIZE = $3025;
  {$EXTERNALSYM EGL_DEPTH_SIZE}
  EGL_STENCIL_SIZE = $3026;
  {$EXTERNALSYM EGL_STENCIL_SIZE}
  EGL_CONFIG_CAVEAT = $3027;
  {$EXTERNALSYM EGL_CONFIG_CAVEAT}
  EGL_CONFIG_ID = $3028;
  {$EXTERNALSYM EGL_CONFIG_ID}
  EGL_LEVEL = $3029;
  {$EXTERNALSYM EGL_LEVEL}
  EGL_MAX_PBUFFER_HEIGHT = $302A;
  {$EXTERNALSYM EGL_MAX_PBUFFER_HEIGHT}
  EGL_MAX_PBUFFER_PIXELS = $302B;
  {$EXTERNALSYM EGL_MAX_PBUFFER_PIXELS}
  EGL_MAX_PBUFFER_WIDTH = $302C;
  {$EXTERNALSYM EGL_MAX_PBUFFER_WIDTH}
  EGL_NATIVE_RENDERABLE = $302D;
  {$EXTERNALSYM EGL_NATIVE_RENDERABLE}
  EGL_NATIVE_VISUAL_ID = $302E;
  {$EXTERNALSYM EGL_NATIVE_VISUAL_ID}
  EGL_NATIVE_VISUAL_TYPE = $302F;
  {$EXTERNALSYM EGL_NATIVE_VISUAL_TYPE}
  EGL_SAMPLES = $3031;
  {$EXTERNALSYM EGL_SAMPLES}
  EGL_SAMPLE_BUFFERS = $3032;
  {$EXTERNALSYM EGL_SAMPLE_BUFFERS}
  EGL_SURFACE_TYPE = $3033;
  {$EXTERNALSYM EGL_SURFACE_TYPE}
  EGL_TRANSPARENT_TYPE = $3034;
  {$EXTERNALSYM EGL_TRANSPARENT_TYPE}
  EGL_TRANSPARENT_BLUE_VALUE = $3035;
  {$EXTERNALSYM EGL_TRANSPARENT_BLUE_VALUE}
  EGL_TRANSPARENT_GREEN_VALUE = $3036;
  {$EXTERNALSYM EGL_TRANSPARENT_GREEN_VALUE}
  EGL_TRANSPARENT_RED_VALUE = $3037;
  {$EXTERNALSYM EGL_TRANSPARENT_RED_VALUE}
  EGL_NONE = $3038;
  {$EXTERNALSYM EGL_NONE}  { Attrib list terminator  }
  EGL_BIND_TO_TEXTURE_RGB = $3039;
  {$EXTERNALSYM EGL_BIND_TO_TEXTURE_RGB}
  EGL_BIND_TO_TEXTURE_RGBA = $303A;
  {$EXTERNALSYM EGL_BIND_TO_TEXTURE_RGBA}
  EGL_MIN_SWAP_INTERVAL = $303B;
  {$EXTERNALSYM EGL_MIN_SWAP_INTERVAL}
  EGL_MAX_SWAP_INTERVAL = $303C;
  {$EXTERNALSYM EGL_MAX_SWAP_INTERVAL}
  EGL_LUMINANCE_SIZE = $303D;
  {$EXTERNALSYM EGL_LUMINANCE_SIZE}
  EGL_ALPHA_MASK_SIZE = $303E;
  {$EXTERNALSYM EGL_ALPHA_MASK_SIZE}
  EGL_COLOR_BUFFER_TYPE = $303F;
  {$EXTERNALSYM EGL_COLOR_BUFFER_TYPE}
  EGL_RENDERABLE_TYPE = $3040;
  {$EXTERNALSYM EGL_RENDERABLE_TYPE}
  EGL_MATCH_NATIVE_PIXMAP = $3041;
  {$EXTERNALSYM EGL_MATCH_NATIVE_PIXMAP}  { Pseudo-attribute (not queryable)  }
  EGL_CONFORMANT = $3042;
  {$EXTERNALSYM EGL_CONFORMANT}

  { Reserved 0x3041-0x304F for additional config attributes  }

  { Config attribute values  }

  EGL_SLOW_CONFIG = $3050;
  {$EXTERNALSYM EGL_SLOW_CONFIG}  
  EGL_NON_CONFORMANT_CONFIG = $3051;
  {$EXTERNALSYM EGL_NON_CONFORMANT_CONFIG}  
  EGL_TRANSPARENT_RGB = $3052;
  {$EXTERNALSYM EGL_TRANSPARENT_RGB}  
  EGL_RGB_BUFFER = $308E;
  {$EXTERNALSYM EGL_RGB_BUFFER}  
  EGL_LUMINANCE_BUFFER = $308F;
  {$EXTERNALSYM EGL_LUMINANCE_BUFFER}  
  
  { More config attribute values, for EGL_TEXTURE_FORMAT  }
  EGL_NO_TEXTURE = $305C;
  {$EXTERNALSYM EGL_NO_TEXTURE}
  EGL_TEXTURE_RGB = $305D;
  {$EXTERNALSYM EGL_TEXTURE_RGB}
  EGL_TEXTURE_RGBA = $305E;
  {$EXTERNALSYM EGL_TEXTURE_RGBA}
  EGL_TEXTURE_2D = $305F;
  {$EXTERNALSYM EGL_TEXTURE_2D}

  { Config attribute mask bits  }
  
  { EGL_SURFACE_TYPE values }
  EGL_PBUFFER_BIT = $0001;
  {$EXTERNALSYM EGL_PBUFFER_BIT}
  EGL_PIXMAP_BIT = $0002;
  {$EXTERNALSYM EGL_PIXMAP_BIT}
  EGL_WINDOW_BIT = $0004;
  {$EXTERNALSYM EGL_WINDOW_BIT}
  EGL_VG_COLORSPACE_LINEAR_BIT = $0020;
  {$EXTERNALSYM EGL_VG_COLORSPACE_LINEAR_BIT}
  EGL_VG_ALPHA_FORMAT_PRE_BIT = $0040;
  {$EXTERNALSYM EGL_VG_ALPHA_FORMAT_PRE_BIT}
  EGL_MULTISAMPLE_RESOLVE_BOX_BIT = $0200;
  {$EXTERNALSYM EGL_MULTISAMPLE_RESOLVE_BOX_BIT}
  EGL_SWAP_BEHAVIOR_PRESERVED_BIT = $0400;
  {$EXTERNALSYM EGL_SWAP_BEHAVIOR_PRESERVED_BIT}
  
  { EGL_RENDERABLE_TYPE values }
  EGL_OPENGL_ES_BIT = $0001;
  {$EXTERNALSYM EGL_OPENGL_ES_BIT}
  EGL_OPENVG_BIT = $0002;
  {$EXTERNALSYM EGL_OPENVG_BIT}
  EGL_OPENGL_ES2_BIT = $0004;
  {$EXTERNALSYM EGL_OPENGL_ES2_BIT}
  EGL_OPENGL_BIT = $0008;
  {$EXTERNALSYM EGL_OPENGL_BIT}
  
  { QueryString targets  }
  EGL_VENDOR = $3053;
  {$EXTERNALSYM EGL_VENDOR}
  EGL_VERSION = $3054;
  {$EXTERNALSYM EGL_VERSION}
  EGL_EXTENSIONS = $3055;
  {$EXTERNALSYM EGL_EXTENSIONS}
  EGL_CLIENT_APIS = $308D;
  {$EXTERNALSYM EGL_CLIENT_APIS}
  
  { QuerySurface / SurfaceAttrib / CreatePbufferSurface targets  }
  EGL_HEIGHT = $3056;
  {$EXTERNALSYM EGL_HEIGHT}
  EGL_WIDTH = $3057;
  {$EXTERNALSYM EGL_WIDTH}
  EGL_LARGEST_PBUFFER = $3058;
  {$EXTERNALSYM EGL_LARGEST_PBUFFER}
  EGL_TEXTURE_FORMAT = $3080;
  {$EXTERNALSYM EGL_TEXTURE_FORMAT}
  EGL_TEXTURE_TARGET = $3081;
  {$EXTERNALSYM EGL_TEXTURE_TARGET}
  EGL_MIPMAP_TEXTURE = $3082;
  {$EXTERNALSYM EGL_MIPMAP_TEXTURE}
  EGL_MIPMAP_LEVEL = $3083;
  {$EXTERNALSYM EGL_MIPMAP_LEVEL}
  EGL_RENDER_BUFFER = $3086;
  {$EXTERNALSYM EGL_RENDER_BUFFER}
  EGL_VG_COLORSPACE = $3087;
  {$EXTERNALSYM EGL_VG_COLORSPACE}
  EGL_VG_ALPHA_FORMAT = $3088;
  {$EXTERNALSYM EGL_VG_ALPHA_FORMAT}
  EGL_HORIZONTAL_RESOLUTION = $3090;
  {$EXTERNALSYM EGL_HORIZONTAL_RESOLUTION}
  EGL_VERTICAL_RESOLUTION = $3091;
  {$EXTERNALSYM EGL_VERTICAL_RESOLUTION}
  EGL_PIXEL_ASPECT_RATIO = $3092;
  {$EXTERNALSYM EGL_PIXEL_ASPECT_RATIO}
  EGL_SWAP_BEHAVIOR = $3093;
  {$EXTERNALSYM EGL_SWAP_BEHAVIOR}
  EGL_MULTISAMPLE_RESOLVE = $3099;
  {$EXTERNALSYM EGL_MULTISAMPLE_RESOLVE}
  
  { EGL_RENDER_BUFFER values / BindTexImage / ReleaseTexImage buffer targets  }
  EGL_BACK_BUFFER = $3084;
  {$EXTERNALSYM EGL_BACK_BUFFER}
  EGL_SINGLE_BUFFER = $3085;
  {$EXTERNALSYM EGL_SINGLE_BUFFER}

  { OpenVG color spaces  }
  EGL_VG_COLORSPACE_sRGB = $3089;  { EGL_VG_COLORSPACE value  }
  {$EXTERNALSYM EGL_VG_COLORSPACE_sRGB}
  EGL_VG_COLORSPACE_LINEAR = $308A;  { EGL_VG_COLORSPACE value  }
  {$EXTERNALSYM EGL_VG_COLORSPACE_LINEAR}
  
  { OpenVG alpha formats  }
  EGL_VG_ALPHA_FORMAT_NONPRE = $308B;  { EGL_ALPHA_FORMAT value  }
  {$EXTERNALSYM EGL_VG_ALPHA_FORMAT_NONPRE}
  EGL_VG_ALPHA_FORMAT_PRE = $308C;  { EGL_ALPHA_FORMAT value  }
  {$EXTERNALSYM EGL_VG_ALPHA_FORMAT_PRE}
  
  { Constant scale factor by which fractional display resolutions &
    aspect ratio are scaled when queried as integer values.
  }
  EGL_DISPLAY_SCALING = 10000;
  {$EXTERNALSYM EGL_DISPLAY_SCALING}
  
  { Unknown display resolution/aspect ratio  }
  EGL_UNKNOWN = -1;
  {$EXTERNALSYM EGL_UNKNOWN}
  
  { Back buffer swap behaviors  }
  EGL_BUFFER_PRESERVED = $3094;  { EGL_SWAP_BEHAVIOR value  }
  {$EXTERNALSYM EGL_BUFFER_PRESERVED}
  EGL_BUFFER_DESTROYED = $3095;  { EGL_SWAP_BEHAVIOR value  }
  {$EXTERNALSYM EGL_BUFFER_DESTROYED}
  
  { CreatePbufferFromClientBuffer buffer types  }
  EGL_OPENVG_IMAGE = $3096;
  {$EXTERNALSYM EGL_OPENVG_IMAGE}
  
  { QueryContext targets  }
  EGL_CONTEXT_CLIENT_TYPE = $3097;
  {$EXTERNALSYM EGL_CONTEXT_CLIENT_TYPE}
  
  { CreateContext attributes  }
  EGL_CONTEXT_CLIENT_VERSION = $3098;
  {$EXTERNALSYM EGL_CONTEXT_CLIENT_VERSION}
  
  { Multisample resolution behaviors  }
  EGL_MULTISAMPLE_RESOLVE_DEFAULT = $309A;  { EGL_MULTISAMPLE_RESOLVE value  }
  {$EXTERNALSYM EGL_MULTISAMPLE_RESOLVE_DEFAULT}
  EGL_MULTISAMPLE_RESOLVE_BOX = $309B;  { EGL_MULTISAMPLE_RESOLVE value  }
  {$EXTERNALSYM EGL_MULTISAMPLE_RESOLVE_BOX}
  
  { BindAPI/QueryAPI targets  }
  EGL_OPENGL_ES_API = $30A0;
  {$EXTERNALSYM EGL_OPENGL_ES_API}
  EGL_OPENVG_API = $30A1;
  {$EXTERNALSYM EGL_OPENVG_API}
  EGL_OPENGL_API = $30A2;
  {$EXTERNALSYM EGL_OPENGL_API}

  { GetCurrentSurface targets  }
  EGL_DRAW = $3059;
  {$EXTERNALSYM EGL_DRAW}
  EGL_READ = $305A;
  {$EXTERNALSYM EGL_READ}

  { WaitNative engines  }
  EGL_CORE_NATIVE_ENGINE = $305B;
  {$EXTERNALSYM EGL_CORE_NATIVE_ENGINE}

  { EGL 1.2 tokens renamed for consistency in EGL 1.3  }
  EGL_COLORSPACE = EGL_VG_COLORSPACE;
  {$EXTERNALSYM EGL_COLORSPACE}
  EGL_ALPHA_FORMAT = EGL_VG_ALPHA_FORMAT;
  {$EXTERNALSYM EGL_ALPHA_FORMAT}
  EGL_COLORSPACE_sRGB = EGL_VG_COLORSPACE_sRGB;
  {$EXTERNALSYM EGL_COLORSPACE_sRGB}
  EGL_COLORSPACE_LINEAR = EGL_VG_COLORSPACE_LINEAR;
  {$EXTERNALSYM EGL_COLORSPACE_LINEAR}
  EGL_ALPHA_FORMAT_NONPRE = EGL_VG_ALPHA_FORMAT_NONPRE;
  {$EXTERNALSYM EGL_ALPHA_FORMAT_NONPRE}
  EGL_ALPHA_FORMAT_PRE = EGL_VG_ALPHA_FORMAT_PRE;
  {$EXTERNALSYM EGL_ALPHA_FORMAT_PRE}

  { EGL extensions must request enum blocks from the Khronos
    API Registrar, who maintains the enumerant registry. Submit
    a bug in Khronos Bugzilla against task "Registry".
  }
  
type
  { This is a generic function pointer type, whose name indicates it must
    be cast to the proper type *and calling convention* before use.
  }
  __eglMustCastToProperFunctionPointerType = procedure; cdecl;
  {$EXTERNALSYM __eglMustCastToProperFunctionPointerType}
  
{ EGL Functions }

function eglGetError: EGLint; cdecl;
  external AndroidEglLib name 'eglGetError';
{$EXTERNALSYM eglGetError}

function eglGetDisplay(DisplayId: EGLNativeDisplayType): EGLDisplay; cdecl;
  external AndroidEglLib name 'eglGetDisplay';
{$EXTERNALSYM eglGetDisplay}

function eglInitialize(Display: EGLDisplay; Major, Minor: PEGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglInitialize';
{$EXTERNALSYM eglInitialize}

function eglTerminate(Display: EGLDisplay): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglTerminate';
{$EXTERNALSYM eglTerminate}

function eglQueryString(Display: EGLDisplay; Name: EGLint): MarshaledAString; cdecl;
  external AndroidEglLib name 'eglQueryString';
{$EXTERNALSYM eglQueryString}


function eglGetConfigs(Display: EGLDisplay; Configs: PEGLConfig; ConfigSize: EGLint; ConfigCount: PEGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglGetConfigs';
{$EXTERNALSYM eglGetConfigs}

function eglChooseConfig(Display: EGLDisplay; AttributeList: PEGLint; Configs: PEGLConfig; ConfigSize: EGLint; ConfigCount: PEGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglChooseConfig';
{$EXTERNALSYM eglChooseConfig}

function eglGetConfigAttrib(Display: EGLDisplay; Config: EGLConfig; Attribute: EGLint; Value: PEGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglGetConfigAttrib';
{$EXTERNALSYM eglGetConfigAttrib}

function eglCreateWindowSurface(Display: EGLDisplay; Config: EGLConfig; win: EGLNativeWindowType; AttributeList: PEGLint): EGLSurface; cdecl;
  external AndroidEglLib name 'eglCreateWindowSurface';
{$EXTERNALSYM eglCreateWindowSurface}

function eglCreatePbufferSurface(Display: EGLDisplay; Config: EGLConfig; AttributeList: PEGLint): EGLSurface; cdecl;
  external AndroidEglLib name 'eglCreatePbufferSurface';
{$EXTERNALSYM eglCreatePbufferSurface}

function eglCreatePixmapSurface(Display: EGLDisplay; Config: EGLConfig; pixmap: EGLNativePixmapType; AttributeList: PEGLint): EGLSurface; cdecl;
  external AndroidEglLib name 'eglCreatePixmapSurface';
{$EXTERNALSYM eglCreatePixmapSurface}

function eglDestroySurface(Display: EGLDisplay; Surface: EGLSurface): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglDestroySurface';
{$EXTERNALSYM eglDestroySurface}

function eglQuerySurface(Display: EGLDisplay; Surface: EGLSurface; Attribute: EGLint; Value: PEGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglQuerySurface';
{$EXTERNALSYM eglQuerySurface}

function eglBindAPI(api: EGLenum): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglBindAPI';
{$EXTERNALSYM eglBindAPI}

function eglQueryAPI: EGLenum; cdecl;
  external AndroidEglLib name 'eglQueryAPI';
{$EXTERNALSYM eglQueryAPI}

function eglWaitClient: EGLBoolean; cdecl;
  external AndroidEglLib name 'eglWaitClient';
{$EXTERNALSYM eglWaitClient}

function eglReleaseThread: EGLBoolean; cdecl;
  external AndroidEglLib name 'eglReleaseThread';
{$EXTERNALSYM eglReleaseThread}

function eglCreatePbufferFromClientBuffer(Display: EGLDisplay; BufferType: EGLenum; Buffer: EGLClientBuffer; Config: EGLConfig; AttributeList: PEGLint): EGLSurface; cdecl;
  external AndroidEglLib name 'eglCreatePbufferFromClientBuffer';
{$EXTERNALSYM eglCreatePbufferFromClientBuffer}

function eglSurfaceAttrib(Display: EGLDisplay; Surface: EGLSurface; Attribute, Value: EGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglSurfaceAttrib';
{$EXTERNALSYM eglSurfaceAttrib}

function eglBindTexImage(Display: EGLDisplay; Surface: EGLSurface; Buffer: EGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglBindTexImage';
{$EXTERNALSYM eglBindTexImage}

function eglReleaseTexImage(Display: EGLDisplay; Surface: EGLSurface; Buffer: EGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglReleaseTexImage';
{$EXTERNALSYM eglReleaseTexImage}


function eglSwapInterval(Display: EGLDisplay; interval: EGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglSwapInterval';
{$EXTERNALSYM eglSwapInterval}


function eglCreateContext(Display: EGLDisplay; Config: EGLConfig; ShareContext: EGLContext; AttributeList: PEGLint): EGLContext; cdecl;
  external AndroidEglLib name 'eglCreateContext';
{$EXTERNALSYM eglCreateContext}

function eglDestroyContext(Display: EGLDisplay; Context: EGLContext): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglDestroyContext';
{$EXTERNALSYM eglDestroyContext}

function eglMakeCurrent(Display: EGLDisplay; SurfaceToDraw, SurfaceToRead: EGLSurface; Context: EGLContext): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglMakeCurrent';
{$EXTERNALSYM eglMakeCurrent}

function eglGetCurrentContext: EGLContext; cdecl;
  external AndroidEglLib name 'eglGetCurrentContext';
{$EXTERNALSYM eglGetCurrentContext}

function eglGetCurrentSurface(readdraw: EGLint): EGLSurface; cdecl;
  external AndroidEglLib name 'eglGetCurrentSurface';
{$EXTERNALSYM eglGetCurrentSurface}

function eglGetCurrentDisplay: EGLDisplay; cdecl;
  external AndroidEglLib name 'eglGetCurrentDisplay';
{$EXTERNALSYM eglGetCurrentDisplay}

function eglQueryContext(Display: EGLDisplay; Context: EGLContext; Attribute: EGLint; Value: PEGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglQueryContext';
{$EXTERNALSYM eglQueryContext}

function eglWaitGL: EGLBoolean; cdecl;
  external AndroidEglLib name 'eglWaitGL';
{$EXTERNALSYM eglWaitGL}

function eglWaitNative(engine: EGLint): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglWaitNative';
{$EXTERNALSYM eglWaitNative}

function eglSwapBuffers(Display: EGLDisplay; Surface: EGLSurface): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglSwapBuffers';
{$EXTERNALSYM eglSwapBuffers}

function eglCopyBuffers(Display: EGLDisplay; Surface: EGLSurface; Target: EGLNativePixmapType): EGLBoolean; cdecl;
  external AndroidEglLib name 'eglCopyBuffers';
{$EXTERNALSYM eglCopyBuffers}

function eglGetProcAddress(ProcedureName: MarshaledAString): __eglMustCastToProperFunctionPointerType; cdecl;
  external AndroidEglLib name 'eglGetProcAddress';
{$EXTERNALSYM eglGetProcAddress}

const
  { Out-of-band handle values }
  EGL_DEFAULT_DISPLAY = EGLNativeDisplayType(0);
  {$EXTERNALSYM EGL_DEFAULT_DISPLAY}
  EGL_NO_CONTEXT = EGLContext(0);
  {$EXTERNALSYM EGL_NO_CONTEXT}
  EGL_NO_DISPLAY = EGLDisplay(0);
  {$EXTERNALSYM EGL_NO_DISPLAY}
  EGL_NO_SURFACE = EGLSurface(0);
  {$EXTERNALSYM EGL_NO_SURFACE}
  { Out-of-band attribute value }
                                                             
  EGL_DONT_CARE = -1;
  {$EXTERNALSYM EGL_DONT_CARE}



implementation

end.
