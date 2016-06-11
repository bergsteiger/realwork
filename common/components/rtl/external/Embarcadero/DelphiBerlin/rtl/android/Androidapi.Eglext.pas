{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Eglext;

interface

uses Posix.SysTypes,
     Androidapi.Egl,
     Androidapi.KhrPlatform,
     Androidapi.EglPlatform;

{$I Androidapi.inc}

const
{ Header file version number
  Current version at http://www.khronos.org/registry/egl/
  $Revision: 11249 $ on $Date: 2010-05-05 09:54:28 -0700 (Wed, 05 May 2010) $
}
  EGL_EGLEXT_VERSION = 5;
  {$EXTERNALSYM EGL_EGLEXT_VERSION}
  
  EGL_KHR_config_attribs = 1;
  {$EXTERNALSYM EGL_KHR_config_attribs}
  EGL_CONFORMANT_KHR = $3042;  { EGLConfig attribute } 
  {$EXTERNALSYM EGL_CONFORMANT_KHR}
  EGL_VG_COLORSPACE_LINEAR_BIT_KHR = $0020; {  EGL_SURFACE_TYPE bitfield } 
  {$EXTERNALSYM EGL_VG_COLORSPACE_LINEAR_BIT_KHR}
  EGL_VG_ALPHA_FORMAT_PRE_BIT_KHR = $0040; {  EGL_SURFACE_TYPE bitfield } 
  {$EXTERNALSYM EGL_VG_ALPHA_FORMAT_PRE_BIT_KHR}

  EGL_KHR_lock_surface = 1;
  {$EXTERNALSYM EGL_KHR_lock_surface}
  EGL_READ_SURFACE_BIT_KHR = $0001; {  EGL_LOCK_USAGE_HINT_KHR bitfield } 
  {$EXTERNALSYM EGL_READ_SURFACE_BIT_KHR}
  EGL_WRITE_SURFACE_BIT_KHR = $0002; {  EGL_LOCK_USAGE_HINT_KHR bitfield } 
  {$EXTERNALSYM EGL_WRITE_SURFACE_BIT_KHR}
  EGL_LOCK_SURFACE_BIT_KHR = $0080; {  EGL_SURFACE_TYPE bitfield } 
  {$EXTERNALSYM EGL_LOCK_SURFACE_BIT_KHR}
  EGL_OPTIMAL_FORMAT_BIT_KHR = $0100; {  EGL_SURFACE_TYPE bitfield } 
  {$EXTERNALSYM EGL_OPTIMAL_FORMAT_BIT_KHR}
  EGL_MATCH_FORMAT_KHR = $3043; {  EGLConfig attribute } 
  {$EXTERNALSYM EGL_MATCH_FORMAT_KHR}
  EGL_FORMAT_RGB_565_EXACT_KHR = $30C0; {  EGL_MATCH_FORMAT_KHR value } 
  {$EXTERNALSYM EGL_FORMAT_RGB_565_EXACT_KHR}
  EGL_FORMAT_RGB_565_KHR = $30C1; {  EGL_MATCH_FORMAT_KHR value } 
  {$EXTERNALSYM EGL_FORMAT_RGB_565_KHR}
  EGL_FORMAT_RGBA_8888_EXACT_KHR = $30C2; {  EGL_MATCH_FORMAT_KHR value } 
  {$EXTERNALSYM EGL_FORMAT_RGBA_8888_EXACT_KHR}
  EGL_FORMAT_RGBA_8888_KHR = $30C3; {  EGL_MATCH_FORMAT_KHR value } 
  {$EXTERNALSYM EGL_FORMAT_RGBA_8888_KHR}
  EGL_MAP_PRESERVE_PIXELS_KHR = $30C4; {  eglLockSurfaceKHR attribute } 
  {$EXTERNALSYM EGL_MAP_PRESERVE_PIXELS_KHR}
  EGL_LOCK_USAGE_HINT_KHR = $30C5; {  eglLockSurfaceKHR attribute } 
  {$EXTERNALSYM EGL_LOCK_USAGE_HINT_KHR}
  EGL_BITMAP_POINTER_KHR = $30C6; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_POINTER_KHR}
  EGL_BITMAP_PITCH_KHR = $30C7; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_PITCH_KHR}
  EGL_BITMAP_ORIGIN_KHR = $30C8; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_ORIGIN_KHR}
  EGL_BITMAP_PIXEL_RED_OFFSET_KHR = $30C9; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_PIXEL_RED_OFFSET_KHR}
  EGL_BITMAP_PIXEL_GREEN_OFFSET_KHR = $30CA; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_PIXEL_GREEN_OFFSET_KHR}
  EGL_BITMAP_PIXEL_BLUE_OFFSET_KHR = $30CB; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_PIXEL_BLUE_OFFSET_KHR}
  EGL_BITMAP_PIXEL_ALPHA_OFFSET_KHR = $30CC; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_PIXEL_ALPHA_OFFSET_KHR}
  EGL_BITMAP_PIXEL_LUMINANCE_OFFSET_KHR = $30CD; {  eglQuerySurface attribute } 
  {$EXTERNALSYM EGL_BITMAP_PIXEL_LUMINANCE_OFFSET_KHR}
  EGL_LOWER_LEFT_KHR = $30CE; {  EGL_BITMAP_ORIGIN_KHR value } 
  {$EXTERNALSYM EGL_LOWER_LEFT_KHR}
  EGL_UPPER_LEFT_KHR = $30CF; {  EGL_BITMAP_ORIGIN_KHR value } 
  {$EXTERNALSYM EGL_UPPER_LEFT_KHR}
  
function eglLockSurfaceKHR (display: EGLDisplay; surface: EGLSurface; attrib_list: PEGLint): EGLBoolean; cdecl;
 external AndroidEglLib name 'eglLockSurfaceKHR';
{$EXTERNALSYM eglLockSurfaceKHR}

function eglUnlockSurfaceKHR (Display: EGLDisplay; surface: EGLSurface): EGLBoolean; cdecl;
 external AndroidEglLib name 'eglUnlockSurfaceKHR';
{$EXTERNALSYM eglUnlockSurfaceKHR}

type
  PFNEGLLOCKSURFACEKHRPROC   = function(display: EGLDisplay; surface: EGLSurface; attrib_list: PEGLint): EGLBoolean; cdecl;
  PFNEGLUNLOCKSURFACEKHRPROC = function(display: EGLDisplay; surface: EGLSurface): EGLBoolean; cdecl;

const
  EGL_KHR_image = 1;
  {$EXTERNALSYM EGL_KHR_image}
  EGL_NATIVE_PIXMAP_KHR = $30B0; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_NATIVE_PIXMAP_KHR}

type
  EGLImageKHR = Pointer;

const
  EGL_NO_IMAGE_KHR = EGLImageKHR(0);


function eglCreateImageKHR (dpy: EGLDisplay; ctx: EGLContext; target: EGLenum; buffer: EGLClientBuffer; attrib_list: PEGLint): EGLImageKHR; cdecl;
 external AndroidEglLib name 'eglCreateImageKHR';
{$EXTERNALSYM eglCreateImageKHR}
function eglDestroyImageKHR (dpy: EGLDisplay; image: EGLImageKHR): EGLBoolean; cdecl;
 external AndroidEglLib name 'eglDestroyImageKHR';
{$EXTERNALSYM eglDestroyImageKHR}

type
  PFNEGLCREATEIMAGEKHRPROC  = function(dpy: EGLDisplay; ctx: EGLContext; target: EGLenum; buffer: EGLClientBuffer; attrib_list: PEGLint): EGLImageKHR; cdecl;
  PFNEGLDESTROYIMAGEKHRPROC = function(dpy: EGLDisplay; image: EGLImageKHR): EGLBoolean; cdecl;


const
  EGL_KHR_vg_parent_image = 1;
  {$EXTERNALSYM EGL_KHR_vg_parent_image}
  EGL_VG_PARENT_IMAGE_KHR = $30BA; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_VG_PARENT_IMAGE_KHR}

  EGL_KHR_gl_texture_2D_image = 1; 
  {$EXTERNALSYM EGL_KHR_gl_texture_2D_image}
  EGL_GL_TEXTURE_2D_KHR = $30B1; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_2D_KHR}
  EGL_GL_TEXTURE_LEVEL_KHR = $30BC; {  eglCreateImageKHR attribute } 
  {$EXTERNALSYM EGL_GL_TEXTURE_LEVEL_KHR}

  EGL_KHR_gl_texture_cubemap_image = 1;
  {$EXTERNALSYM EGL_KHR_gl_texture_cubemap_image}
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_X_KHR = $30B3; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_X_KHR}
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_X_KHR = $30B4; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_X_KHR}
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Y_KHR = $30B5; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Y_KHR}
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_KHR = $30B6; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_KHR}
  EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Z_KHR = $30B7; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_CUBE_MAP_POSITIVE_Z_KHR}
  EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_KHR = $30B8; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_KHR}

  EGL_KHR_gl_texture_3D_image = 1; 
  {$EXTERNALSYM EGL_KHR_gl_texture_3D_image}
  EGL_GL_TEXTURE_3D_KHR = $30B2; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_TEXTURE_3D_KHR}
  EGL_GL_TEXTURE_ZOFFSET_KHR = $30BD; {  eglCreateImageKHR attribute } 
  {$EXTERNALSYM EGL_GL_TEXTURE_ZOFFSET_KHR}

  EGL_KHR_gl_renderbuffer_image = 1;
  {$EXTERNALSYM EGL_KHR_gl_renderbuffer_image}
  EGL_GL_RENDERBUFFER_KHR = $30B9; {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_GL_RENDERBUFFER_KHR}

  EGL_KHR_reusable_sync = 1;
  {$EXTERNALSYM EGL_KHR_reusable_sync}

type
  EGLSyncKHR = Pointer;
  EGLTimeKHR = khronos_utime_nanoseconds_t;

const
  EGL_SYNC_STATUS_KHR = $30F1;  
  {$EXTERNALSYM EGL_SYNC_STATUS_KHR}
  EGL_SIGNALED_KHR = $30F2;  
  {$EXTERNALSYM EGL_SIGNALED_KHR}
  EGL_UNSIGNALED_KHR = $30F3;  
  {$EXTERNALSYM EGL_UNSIGNALED_KHR}
  EGL_TIMEOUT_EXPIRED_KHR = $30F5;  
  {$EXTERNALSYM EGL_TIMEOUT_EXPIRED_KHR}
  EGL_CONDITION_SATISFIED_KHR = $30F6;  
  {$EXTERNALSYM EGL_CONDITION_SATISFIED_KHR}
  EGL_SYNC_TYPE_KHR = $30F7;  
  {$EXTERNALSYM EGL_SYNC_TYPE_KHR}
  EGL_SYNC_REUSABLE_KHR = $30FA;  
  {$EXTERNALSYM EGL_SYNC_REUSABLE_KHR}
  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR = $0001; {  eglClientWaitSyncKHR <flags> bitfield } 
  {$EXTERNALSYM EGL_SYNC_FLUSH_COMMANDS_BIT_KHR}
  EGL_FOREVER_KHR = $FFFFFFFFFFFFFFFF;
  {$EXTERNALSYM EGL_FOREVER_KHR}
  EGL_NO_SYNC_KHR	= EGLSyncKHR(0);
  {$EXTERNALSYM EGL_NO_SYNC_KHR}

{ This functions are removed because they are not present in the AndroidEglLib

function eglCreateSyncKHR(dpy: EGLDisplay; _type: EGLenum; attrib_list: EGLint): EGLSyncKHR; cdecl;
function eglDestroySyncKHR(dpy: EGLDisplay; sync: EGLSyncKHR): EGLBoolean; cdecl;
function eglClientWaitSyncKHR(dpy: EGLDisplay; sync: EGLSyncKHR; flags: EGLint; timeout: EGLTimeKHR): EGLint; cdecl;
function eglSignalSyncKHR(dpy: EGLDisplay; sync: EGLSyncKHR; mode: EGLenum): EGLBoolean; cdecl;
function eglGetSyncAttribKHR(dpy: EGLDisplay; sync: EGLSyncKHR; attribute: EGLint; value: PEGLint): EGLBoolean; cdecl;


type
  PFNEGLCREATESYNCKHRPROC     = function(dpy: EGLDisplay; _type: EGLenum; attrib_list: PEGLint): EGLSyncKHR; cdecl;
  PFNEGLDESTROYSYNCKHRPROC    =  function(dpy: EGLDisplay; sync: EGLSyncKHR): EGLBoolean; cdecl;
  PFNEGLCLIENTWAITSYNCKHRPROC = function(dpy: EGLDisplay; sync: EGLSyncKHR; flags: EGLint; timeout: EGLTimeKHR): EGLint; cdecl;
  PFNEGLSIGNALSYNCKHRPROC     = function(dpy: EGLDisplay; sync: EGLSyncKHR; mode: EGLenum): EGLBoolean; cdecl;
  PFNEGLGETSYNCATTRIBKHRPROC  = function(dpy: EGLDisplay; sync: EGLSyncKHR; attribute: EGLint; value: PEGLint): EGLBoolean; cdecl;

}


type
  EGLSyncNV = Pointer;
  EGLTimeNV = UInt64;

const
  EGL_KHR_image_base = 1;
  {$EXTERNALSYM EGL_KHR_image_base}
{  Most interfaces defined by EGL_KHR_image_pixmap above }
  EGL_IMAGE_PRESERVED_KHR = $30D2; {  eglCreateImageKHR attribute } 
  {$EXTERNALSYM EGL_IMAGE_PRESERVED_KHR}

  EGL_KHR_image_pixmap = 1;
  {$EXTERNALSYM EGL_KHR_image_pixmap}
{  Interfaces defined by EGL_KHR_image above }

  EGL_IMG_context_priority = 1;
  {$EXTERNALSYM EGL_IMG_context_priority}
  EGL_CONTEXT_PRIORITY_LEVEL_IMG = $3100;  
  {$EXTERNALSYM EGL_CONTEXT_PRIORITY_LEVEL_IMG}
  EGL_CONTEXT_PRIORITY_HIGH_IMG = $3101;  
  {$EXTERNALSYM EGL_CONTEXT_PRIORITY_HIGH_IMG}
  EGL_CONTEXT_PRIORITY_MEDIUM_IMG = $3102;  
  {$EXTERNALSYM EGL_CONTEXT_PRIORITY_MEDIUM_IMG}
  EGL_CONTEXT_PRIORITY_LOW_IMG = $3103;  
  {$EXTERNALSYM EGL_CONTEXT_PRIORITY_LOW_IMG}

  EGL_NV_coverage_sample = 1;
  {$EXTERNALSYM EGL_NV_coverage_sample}
  EGL_COVERAGE_BUFFERS_NV = $30E0;  
  {$EXTERNALSYM EGL_COVERAGE_BUFFERS_NV}
  EGL_COVERAGE_SAMPLES_NV = $30E1;  
  {$EXTERNALSYM EGL_COVERAGE_SAMPLES_NV}

  EGL_NV_depth_nonlinear = 1;
  {$EXTERNALSYM EGL_NV_depth_nonlinear}
  EGL_DEPTH_ENCODING_NV = $30E2;  
  {$EXTERNALSYM EGL_DEPTH_ENCODING_NV}
  EGL_DEPTH_ENCODING_NONE_NV = 0;
  {$EXTERNALSYM EGL_DEPTH_ENCODING_NONE_NV}
  EGL_DEPTH_ENCODING_NONLINEAR_NV = $30E3;  
  {$EXTERNALSYM EGL_DEPTH_ENCODING_NONLINEAR_NV}

  EGL_NV_sync = 1;
  {$EXTERNALSYM EGL_NV_sync}
  EGL_SYNC_PRIOR_COMMANDS_COMPLETE_NV = $30E6;  
  {$EXTERNALSYM EGL_SYNC_PRIOR_COMMANDS_COMPLETE_NV}
  EGL_SYNC_STATUS_NV = $30E7;  
  {$EXTERNALSYM EGL_SYNC_STATUS_NV}
  EGL_SIGNALED_NV = $30E8;  
  {$EXTERNALSYM EGL_SIGNALED_NV}
  EGL_UNSIGNALED_NV = $30E9;  
  {$EXTERNALSYM EGL_UNSIGNALED_NV}
  EGL_SYNC_FLUSH_COMMANDS_BIT_NV = $0001;  
  {$EXTERNALSYM EGL_SYNC_FLUSH_COMMANDS_BIT_NV}
   EGL_FOREVER_NV = $FFFFFFFFFFFFFFFF;  
  {$EXTERNALSYM EGL_FOREVER_NV}
  EGL_ALREADY_SIGNALED_NV = $30EA;  
  {$EXTERNALSYM EGL_ALREADY_SIGNALED_NV}
  EGL_TIMEOUT_EXPIRED_NV = $30EB;  
  {$EXTERNALSYM EGL_TIMEOUT_EXPIRED_NV}
  EGL_CONDITION_SATISFIED_NV = $30EC;  
  {$EXTERNALSYM EGL_CONDITION_SATISFIED_NV}
  EGL_SYNC_TYPE_NV = $30ED;  
  {$EXTERNALSYM EGL_SYNC_TYPE_NV}
  EGL_SYNC_CONDITION_NV = $30EE;  
  {$EXTERNALSYM EGL_SYNC_CONDITION_NV}
  EGL_SYNC_FENCE_NV = $30EF;
  {$EXTERNALSYM EGL_SYNC_FENCE_NV}
  EGL_NO_SYNC_NV = EGLSyncNV(0);
  {$EXTERNALSYM EGL_NO_SYNC_NV}

{ This functions are removed because they are not present in the AndroidEglLib

function eglCreateFenceSyncNV (dpy: EGLDisplay; condition: EGLenum; attrib_list: PEGLint): EGLSyncNV; cdecl;
function eglDestroySyncNV (sync: EGLSyncNV): EGLBoolean; cdecl;
function eglFenceNV (sync: EGLSyncNV): EGLBoolean; cdecl;
function eglClientWaitSyncNV (sync: EGLSyncNV; flags: EGLint; timeout: EGLTimeNV): EGLint; cdecl;
function eglSignalSyncNV (sync: EGLSyncNV; mode: EGLenum): EGLBoolean; cdecl;
function eglGetSyncAttribNV (sync: EGLSyncNV; attribute: EGLint; value: PEGLint): EGLBoolean; cdecl;

type
  PFNEGLCREATEFENCESYNCNVPROC = function(dpy: EGLDisplay; condition: EGLenum; attrib_list: PEGLint):EGLSyncNV; cdecl;
  PFNEGLDESTROYSYNCNVPROC     = function(sync: EGLSyncNV): EGLBoolean; cdecl;
  PFNEGLFENCENVPROC           = function(sync: EGLSyncNV): EGLBoolean; cdecl;
  PFNEGLCLIENTWAITSYNCNVPROC  = function(sync: EGLSyncNV; flags: EGLint; timeout: EGLTimeNV): EGLint; cdecl;
  PFNEGLSIGNALSYNCNVPROC      = function(sync: EGLSyncNV; mode: EGLenum): EGLBoolean; cdecl;
  PFNEGLGETSYNCATTRIBNVPROC   = function(sync: EGLSyncNV; attribute: EGLint; value: PEGLint): EGLBoolean; cdecl;
}

const
  EGL_KHR_fence_sync = 1;
  {$EXTERNALSYM EGL_KHR_fence_sync}
{  Reuses most tokens and entry points from EGL_KHR_reusable_sync }
  EGL_SYNC_PRIOR_COMMANDS_COMPLETE_KHR = $30F0;  
  {$EXTERNALSYM EGL_SYNC_PRIOR_COMMANDS_COMPLETE_KHR}
  EGL_SYNC_CONDITION_KHR = $30F8;  
  {$EXTERNALSYM EGL_SYNC_CONDITION_KHR}
  EGL_SYNC_FENCE_KHR = $30F9;  
  {$EXTERNALSYM EGL_SYNC_FENCE_KHR}

  EGL_ANDROID_image_native_buffer = 1;
  {$EXTERNALSYM EGL_ANDROID_image_native_buffer}
 
type 
  ANativeWindowBuffer = record end;

const
  EGL_NATIVE_BUFFER_ANDROID = $3140;   {  eglCreateImageKHR target } 
  {$EXTERNALSYM EGL_NATIVE_BUFFER_ANDROID}
  EGL_ANDROID_swap_rectangle = 1;
  {$EXTERNALSYM EGL_ANDROID_swap_rectangle}

type
  PFNEGLSETSWAPRECTANGLEANDROIDPROC = function(dpy: EGLDisplay; draw: EGLSurface; left: EGLint; top: EGLint; width: EGLint; height: EGLint): EGLBoolean; cdecl;

const
  EGL_ANDROID_recordable = 1;
  {$EXTERNALSYM EGL_ANDROID_recordable}
  EGL_RECORDABLE_ANDROID = $3142;   {  EGLConfig attribute }
  {$EXTERNALSYM EGL_RECORDABLE_ANDROID}

  { EGL_NV_system_time }
  EGL_NV_system_time = 1;
  {$EXTERNALSYM EGL_NV_system_time}

type
  EGLint64NV = khronos_int64_t;
  {$EXTERNALSYM EGLint64NV}
  EGLuint64NV = khronos_uint64_t;
  {$EXTERNALSYM EGLuint64NV}

{ This functions are removed because they are not present in the AndroidEglLib

function eglGetSystemTimeFrequencyNV: EGLuint64NV; cdecl;
function eglGetSystemTimeNV: EGLuint64NV; cdecl;
function eglSetSwapRectangleANDROID (dpy: EGLDisplay; draw: EGLSurface; left: EGLint; top: EGLint; width: EGLint; height: EGLint): EGLBoolean; cdecl;

type
  PFNEGLGETSYSTEMTIMEFREQUENCYNVPROC = function: EGLuint64NV;
  PFNEGLGETSYSTEMTIMENVPROC =  function: EGLuint64NV;
}


implementation

end.
