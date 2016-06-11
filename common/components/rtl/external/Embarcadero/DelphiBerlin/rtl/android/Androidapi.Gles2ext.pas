{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Gles2ext;

interface

uses Posix.SysTypes,
     Androidapi.KhrPlatform,
     Androidapi.Gles2;

{$I Androidapi.inc}

const
{  GL_OES_compressed_ETC1_RGB8_texture }
  GL_ETC1_RGB8_OES = $8D64; 
  {$EXTERNALSYM GL_ETC1_RGB8_OES}

{  GL_OES_compressed_paletted_texture }
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

{  GL_OES_depth24 }
  GL_DEPTH_COMPONENT24_OES = $81A6; 
  {$EXTERNALSYM GL_DEPTH_COMPONENT24_OES}

{  GL_OES_depth32 }
  GL_DEPTH_COMPONENT32_OES = $81A7; 
  {$EXTERNALSYM GL_DEPTH_COMPONENT32_OES}

{  GL_OES_depth_texture }
{  No new tokens introduced by this extension. }

type
{  GL_OES_EGL_image }
  GLeglImageOES = Pointer;
  {$EXTERNALSYM GL_UNSIGNED_INT}

const
{  GL_OES_element_index_uint }
  GL_UNSIGNED_INT = $1405; 
  {$EXTERNALSYM GL_UNSIGNED_INT}

{  GL_OES_get_program_binary }
  GL_PROGRAM_BINARY_LENGTH_OES = $8741; 
  {$EXTERNALSYM GL_PROGRAM_BINARY_LENGTH_OES}
  GL_NUM_PROGRAM_BINARY_FORMATS_OES = $87FE; 
  {$EXTERNALSYM GL_NUM_PROGRAM_BINARY_FORMATS_OES}
  GL_PROGRAM_BINARY_FORMATS_OES = $87FF; 
  {$EXTERNALSYM GL_PROGRAM_BINARY_FORMATS_OES}

{  GL_OES_mapbuffer }
  GL_WRITE_ONLY_OES = $88B9; 
  {$EXTERNALSYM GL_WRITE_ONLY_OES}
  GL_BUFFER_ACCESS_OES = $88BB; 
  {$EXTERNALSYM GL_BUFFER_ACCESS_OES}
  GL_BUFFER_MAPPED_OES = $88BC; 
  {$EXTERNALSYM GL_BUFFER_MAPPED_OES}
  GL_BUFFER_MAP_POINTER_OES = $88BD; 
  {$EXTERNALSYM GL_BUFFER_MAP_POINTER_OES}

{  GL_OES_packed_depth_stencil }
  GL_DEPTH_STENCIL_OES = $84F9; 
  {$EXTERNALSYM GL_DEPTH_STENCIL_OES}
  GL_UNSIGNED_INT_24_8_OES = $84FA; 
  {$EXTERNALSYM GL_UNSIGNED_INT_24_8_OES}
  GL_DEPTH24_STENCIL8_OES = $88F0; 
  {$EXTERNALSYM GL_DEPTH24_STENCIL8_OES}

{  GL_OES_rgb8_rgba8 }
  GL_RGB8_OES = $8051; 
  {$EXTERNALSYM GL_RGB8_OES}
  GL_RGBA8_OES = $8058; 
  {$EXTERNALSYM GL_RGBA8_OES}

{  GL_OES_standard_derivatives }
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_OES = $8B8B; 
  {$EXTERNALSYM GL_FRAGMENT_SHADER_DERIVATIVE_HINT_OES}

{  GL_OES_stencil1 }
  GL_STENCIL_INDEX1_OES = $8D46; 
  {$EXTERNALSYM GL_STENCIL_INDEX1_OES}

{  GL_OES_stencil4 }
  GL_STENCIL_INDEX4_OES = $8D47; 
  {$EXTERNALSYM GL_STENCIL_INDEX4_OES}

{  GL_OES_texture_3D }
  GL_TEXTURE_WRAP_R_OES = $8072; 
  {$EXTERNALSYM GL_TEXTURE_WRAP_R_OES}
  GL_TEXTURE_3D_OES = $806F; 
  {$EXTERNALSYM GL_TEXTURE_3D_OES}
  GL_TEXTURE_BINDING_3D_OES = $806A; 
  {$EXTERNALSYM GL_TEXTURE_BINDING_3D_OES}
  GL_MAX_3D_TEXTURE_SIZE_OES = $8073; 
  {$EXTERNALSYM GL_MAX_3D_TEXTURE_SIZE_OES}
  GL_SAMPLER_3D_OES = $8B5F; 
  {$EXTERNALSYM GL_SAMPLER_3D_OES}
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_OES = $8CD4; 
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_OES}

{  GL_OES_texture_float }
{  No new tokens introduced by this extension. }

{  GL_OES_texture_float_linear }
{  No new tokens introduced by this extension. }

{  GL_OES_texture_half_float }
  GL_HALF_FLOAT_OES = $8D61; 
  {$EXTERNALSYM GL_HALF_FLOAT_OES}

{  GL_OES_texture_half_float_linear }
{  No new tokens introduced by this extension. }

{  GL_OES_texture_npot }
{  No new tokens introduced by this extension. }

{  GL_OES_vertex_array_object }
  GL_VERTEX_ARRAY_BINDING_OES = $85B5; 
  {$EXTERNALSYM GL_VERTEX_ARRAY_BINDING_OES}

{  GL_OES_vertex_half_float }
{  GL_HALF_FLOAT_OES defined in GL_OES_texture_half_float already. }

{  GL_OES_vertex_type_10_10_10_2 }
  GL_UNSIGNED_INT_10_10_10_2_OES = $8DF6; 
  {$EXTERNALSYM GL_UNSIGNED_INT_10_10_10_2_OES}
  GL_INT_10_10_10_2_OES = $8DF7; 
  {$EXTERNALSYM GL_INT_10_10_10_2_OES}

{  GL_OES_EGL_image_external }
  GL_TEXTURE_EXTERNAL_OES = $8D65; 
  {$EXTERNALSYM GL_TEXTURE_EXTERNAL_OES}
  GL_SAMPLER_EXTERNAL_OES = $8D66; 
  {$EXTERNALSYM GL_SAMPLER_EXTERNAL_OES}
  GL_TEXTURE_BINDING_EXTERNAL_OES = $8D67; 
  {$EXTERNALSYM GL_TEXTURE_BINDING_EXTERNAL_OES}
  GL_REQUIRED_TEXTURE_IMAGE_UNITS_OES = $8D68; 
  {$EXTERNALSYM GL_REQUIRED_TEXTURE_IMAGE_UNITS_OES}

{ ------------------------------------------------------------------------
   AMD extension tokens
  ------------------------------------------------------------------------
}

{  GL_AMD_compressed_3DC_texture }
  GL_3DC_X_AMD = $87F9; 
  {$EXTERNALSYM GL_3DC_X_AMD}
  GL_3DC_XY_AMD = $87FA; 
  {$EXTERNALSYM GL_3DC_XY_AMD}

{  GL_AMD_compressed_ATC_texture }
  GL_ATC_RGB_AMD = $8C92; 
  {$EXTERNALSYM GL_ATC_RGB_AMD}
  GL_ATC_RGBA_EXPLICIT_ALPHA_AMD = $8C93; 
  {$EXTERNALSYM GL_ATC_RGBA_EXPLICIT_ALPHA_AMD}
  GL_ATC_RGBA_INTERPOLATED_ALPHA_AMD = $87EE; 
  {$EXTERNALSYM GL_ATC_RGBA_INTERPOLATED_ALPHA_AMD}

{  GL_AMD_performance_monitor }
  GL_COUNTER_TYPE_AMD = $8BC0; 
  {$EXTERNALSYM GL_COUNTER_TYPE_AMD}
  GL_COUNTER_RANGE_AMD = $8BC1; 
  {$EXTERNALSYM GL_COUNTER_RANGE_AMD}
  GL_UNSIGNED_INT64_AMD = $8BC2; 
  {$EXTERNALSYM GL_UNSIGNED_INT64_AMD}
  GL_PERCENTAGE_AMD = $8BC3; 
  {$EXTERNALSYM GL_PERCENTAGE_AMD}
  GL_PERFMON_RESULT_AVAILABLE_AMD = $8BC4; 
  {$EXTERNALSYM GL_PERFMON_RESULT_AVAILABLE_AMD}
  GL_PERFMON_RESULT_SIZE_AMD = $8BC5; 
  {$EXTERNALSYM GL_PERFMON_RESULT_SIZE_AMD}
  GL_PERFMON_RESULT_AMD = $8BC6; 
  {$EXTERNALSYM GL_PERFMON_RESULT_AMD}

{  GL_AMD_program_binary_Z400 }
  GL_Z400_BINARY_AMD = $8740; 
  {$EXTERNALSYM GL_Z400_BINARY_AMD}

{ ------------------------------------------------------------------------
   EXT extension tokens
  ------------------------------------------------------------------------
}

{  GL_EXT_blend_minmax }
  GL_MIN_EXT = $8007; 
  {$EXTERNALSYM GL_MIN_EXT}
  GL_MAX_EXT = $8008; 
  {$EXTERNALSYM GL_MAX_EXT}

{  GL_EXT_discard_framebuffer }
  GL_COLOR_EXT = $1800; 
  {$EXTERNALSYM GL_COLOR_EXT}
  GL_DEPTH_EXT = $1801; 
  {$EXTERNALSYM GL_DEPTH_EXT}
  GL_STENCIL_EXT = $1802; 
  {$EXTERNALSYM GL_STENCIL_EXT}

{  GL_EXT_multi_draw_arrays }
{  No new tokens introduced by this extension. }

{  GL_EXT_read_format_bgra }
  GL_BGRA_EXT = $80E1; 
  {$EXTERNALSYM GL_BGRA_EXT}
  GL_UNSIGNED_SHORT_4_4_4_4_REV_EXT = $8365; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT_4_4_4_4_REV_EXT}
  GL_UNSIGNED_SHORT_1_5_5_5_REV_EXT = $8366; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT_1_5_5_5_REV_EXT}

{  GL_EXT_texture_filter_anisotropic }
  GL_TEXTURE_MAX_ANISOTROPY_EXT = $84FE; 
  {$EXTERNALSYM GL_TEXTURE_MAX_ANISOTROPY_EXT}
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT = $84FF; 
  {$EXTERNALSYM GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT}

{  GL_EXT_texture_format_BGRA8888 }
//  GL_BGRA_EXT = $80E1; 
//  {$EXTERNALSYM GL_BGRA_EXT}

{  GL_EXT_texture_type_2_10_10_10_REV }
  GL_UNSIGNED_INT_2_10_10_10_REV_EXT = $8368; 
  {$EXTERNALSYM GL_UNSIGNED_INT_2_10_10_10_REV_EXT}

{  GL_EXT_texture_compression_dxt1 }
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT = $83F0; 
  {$EXTERNALSYM GL_COMPRESSED_RGB_S3TC_DXT1_EXT}
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT = $83F1; 
  {$EXTERNALSYM GL_COMPRESSED_RGBA_S3TC_DXT1_EXT}

{ ------------------------------------------------------------------------
   IMG extension tokens
  ------------------------------------------------------------------------
}

{  GL_IMG_program_binary }
  GL_SGX_PROGRAM_BINARY_IMG = $9130; 
  {$EXTERNALSYM GL_SGX_PROGRAM_BINARY_IMG}

{  GL_IMG_read_format }
  GL_BGRA_IMG = $80E1; 
  {$EXTERNALSYM GL_BGRA_IMG}
  GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG = $8365; 
  {$EXTERNALSYM GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG}

{  GL_IMG_shader_binary }
  GL_SGX_BINARY_IMG = $8C0A; 
  {$EXTERNALSYM GL_SGX_BINARY_IMG}

{  GL_IMG_texture_compression_pvrtc }
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG = $8C00; 
  {$EXTERNALSYM GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG}
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG = $8C01; 
  {$EXTERNALSYM GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG}
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG = $8C02; 
  {$EXTERNALSYM GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG}
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG = $8C03; 
  {$EXTERNALSYM GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG}

{  GL_IMG_multisampled_render_to_texture }
  GL_RENDERBUFFER_SAMPLES_IMG = $9133; 
  {$EXTERNALSYM GL_RENDERBUFFER_SAMPLES_IMG}
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_IMG = $9134; 
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_IMG}
  GL_MAX_SAMPLES_IMG = $9135; 
  {$EXTERNALSYM GL_MAX_SAMPLES_IMG}
  GL_TEXTURE_SAMPLES_IMG = $9136; 
  {$EXTERNALSYM GL_TEXTURE_SAMPLES_IMG}

{ ------------------------------------------------------------------------
   NV extension tokens
  ------------------------------------------------------------------------
}

{  GL_NV_fence }
  GL_ALL_COMPLETED_NV = $84F2; 
  {$EXTERNALSYM GL_ALL_COMPLETED_NV}
  GL_FENCE_STATUS_NV = $84F3; 
  {$EXTERNALSYM GL_FENCE_STATUS_NV}
  GL_FENCE_CONDITION_NV = $84F4; 
  {$EXTERNALSYM GL_FENCE_CONDITION_NV}

{  GL_NV_coverage_sample }
  GL_COVERAGE_COMPONENT_NV = $8ED0; 
  {$EXTERNALSYM GL_COVERAGE_COMPONENT_NV}
  GL_COVERAGE_COMPONENT4_NV = $8ED1; 
  {$EXTERNALSYM GL_COVERAGE_COMPONENT4_NV}
  GL_COVERAGE_ATTACHMENT_NV = $8ED2; 
  {$EXTERNALSYM GL_COVERAGE_ATTACHMENT_NV}
  GL_COVERAGE_BUFFERS_NV = $8ED3; 
  {$EXTERNALSYM GL_COVERAGE_BUFFERS_NV}
  GL_COVERAGE_SAMPLES_NV = $8ED4; 
  {$EXTERNALSYM GL_COVERAGE_SAMPLES_NV}
  GL_COVERAGE_ALL_FRAGMENTS_NV = $8ED5; 
  {$EXTERNALSYM GL_COVERAGE_ALL_FRAGMENTS_NV}
  GL_COVERAGE_EDGE_FRAGMENTS_NV = $8ED6; 
  {$EXTERNALSYM GL_COVERAGE_EDGE_FRAGMENTS_NV}
  GL_COVERAGE_AUTOMATIC_NV = $8ED7; 
  {$EXTERNALSYM GL_COVERAGE_AUTOMATIC_NV}
  GL_COVERAGE_BUFFER_BIT_NV = $8000; 
  {$EXTERNALSYM GL_COVERAGE_BUFFER_BIT_NV}

{  GL_NV_depth_nonlinear }
  GL_DEPTH_COMPONENT16_NONLINEAR_NV = $8E2C; 
  {$EXTERNALSYM GL_DEPTH_COMPONENT16_NONLINEAR_NV}

{ ------------------------------------------------------------------------
   QCOM extension tokens
  ------------------------------------------------------------------------
}

{  GL_QCOM_driver_control }
{  No new tokens introduced by this extension. }

{  GL_QCOM_extended_get }
  GL_TEXTURE_WIDTH_QCOM = $8BD2; 
  {$EXTERNALSYM GL_TEXTURE_WIDTH_QCOM}
  GL_TEXTURE_HEIGHT_QCOM = $8BD3; 
  {$EXTERNALSYM GL_TEXTURE_HEIGHT_QCOM}
  GL_TEXTURE_DEPTH_QCOM = $8BD4; 
  {$EXTERNALSYM GL_TEXTURE_DEPTH_QCOM}
  GL_TEXTURE_INTERNAL_FORMAT_QCOM = $8BD5; 
  {$EXTERNALSYM GL_TEXTURE_INTERNAL_FORMAT_QCOM}
  GL_TEXTURE_FORMAT_QCOM = $8BD6; 
  {$EXTERNALSYM GL_TEXTURE_FORMAT_QCOM}
  GL_TEXTURE_TYPE_QCOM = $8BD7; 
  {$EXTERNALSYM GL_TEXTURE_TYPE_QCOM}
  GL_TEXTURE_IMAGE_VALID_QCOM = $8BD8; 
  {$EXTERNALSYM GL_TEXTURE_IMAGE_VALID_QCOM}
  GL_TEXTURE_NUM_LEVELS_QCOM = $8BD9; 
  {$EXTERNALSYM GL_TEXTURE_NUM_LEVELS_QCOM}
  GL_TEXTURE_TARGET_QCOM = $8BDA; 
  {$EXTERNALSYM GL_TEXTURE_TARGET_QCOM}
  GL_TEXTURE_OBJECT_VALID_QCOM = $8BDB; 
  {$EXTERNALSYM GL_TEXTURE_OBJECT_VALID_QCOM}
  GL_STATE_RESTORE = $8BDC; 
  {$EXTERNALSYM GL_STATE_RESTORE}

{  GL_QCOM_extended_get2 }
{  No new tokens introduced by this extension. }

{  GL_QCOM_perfmon_global_mode }
  GL_PERFMON_GLOBAL_MODE_QCOM = $8FA0; 
  {$EXTERNALSYM GL_PERFMON_GLOBAL_MODE_QCOM}

{  GL_QCOM_writeonly_rendering }
  GL_WRITEONLY_RENDERING_QCOM = $8823; 
  {$EXTERNALSYM GL_WRITEONLY_RENDERING_QCOM}

{  GL_QCOM_tiled_rendering }
  GL_COLOR_BUFFER_BIT0_QCOM = $00000001; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT0_QCOM}
  GL_COLOR_BUFFER_BIT1_QCOM = $00000002; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT1_QCOM}
  GL_COLOR_BUFFER_BIT2_QCOM = $00000004; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT2_QCOM}
  GL_COLOR_BUFFER_BIT3_QCOM = $00000008; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT3_QCOM}
  GL_COLOR_BUFFER_BIT4_QCOM = $00000010; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT4_QCOM}
  GL_COLOR_BUFFER_BIT5_QCOM = $00000020; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT5_QCOM}
  GL_COLOR_BUFFER_BIT6_QCOM = $00000040; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT6_QCOM}
  GL_COLOR_BUFFER_BIT7_QCOM = $00000080; 
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT7_QCOM}
  GL_DEPTH_BUFFER_BIT0_QCOM = $00000100; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT0_QCOM}
  GL_DEPTH_BUFFER_BIT1_QCOM = $00000200; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT1_QCOM}
  GL_DEPTH_BUFFER_BIT2_QCOM = $00000400; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT2_QCOM}
  GL_DEPTH_BUFFER_BIT3_QCOM = $00000800; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT3_QCOM}
  GL_DEPTH_BUFFER_BIT4_QCOM = $00001000; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT4_QCOM}
  GL_DEPTH_BUFFER_BIT5_QCOM = $00002000; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT5_QCOM}
  GL_DEPTH_BUFFER_BIT6_QCOM = $00004000; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT6_QCOM}
  GL_DEPTH_BUFFER_BIT7_QCOM = $00008000; 
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT7_QCOM}
  GL_STENCIL_BUFFER_BIT0_QCOM = $00010000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT0_QCOM}
  GL_STENCIL_BUFFER_BIT1_QCOM = $00020000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT1_QCOM}
  GL_STENCIL_BUFFER_BIT2_QCOM = $00040000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT2_QCOM}
  GL_STENCIL_BUFFER_BIT3_QCOM = $00080000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT3_QCOM}
  GL_STENCIL_BUFFER_BIT4_QCOM = $00100000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT4_QCOM}
  GL_STENCIL_BUFFER_BIT5_QCOM = $00200000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT5_QCOM}
  GL_STENCIL_BUFFER_BIT6_QCOM = $00400000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT6_QCOM}
  GL_STENCIL_BUFFER_BIT7_QCOM = $00800000; 
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT7_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT0_QCOM = $01000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT0_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT1_QCOM = $02000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT1_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT2_QCOM = $04000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT2_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT3_QCOM = $08000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT3_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT4_QCOM = $10000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT4_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT5_QCOM = $20000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT5_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT6_QCOM = $40000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT6_QCOM}
  GL_MULTISAMPLE_BUFFER_BIT7_QCOM = $80000000; 
  {$EXTERNALSYM GL_MULTISAMPLE_BUFFER_BIT7_QCOM}

{ ------------------------------------------------------------------------
   End of extension tokens; start of corresponding extension functions
  ------------------------------------------------------------------------
}

{ ------------------------------------------------------------------------
   OES extension functions
  ------------------------------------------------------------------------
}

{  GL_OES_compressed_ETC1_RGB8_texture }
  GL_OES_compressed_ETC1_RGB8_texture = 1; 
  {$EXTERNALSYM GL_OES_compressed_ETC1_RGB8_texture}

{  GL_OES_compressed_paletted_texture }
  GL_OES_compressed_paletted_texture = 1; 
  {$EXTERNALSYM GL_OES_compressed_paletted_texture}

{  GL_OES_depth24 }
  GL_OES_depth24 = 1; 
  {$EXTERNALSYM GL_OES_depth24}

{  GL_OES_depth32 }
  GL_OES_depth32 = 1; 
  {$EXTERNALSYM GL_OES_depth32}

{  GL_OES_depth_texture }
  GL_OES_depth_texture = 1; 
  {$EXTERNALSYM GL_OES_depth_texture}

{  GL_OES_EGL_image }
  GL_OES_EGL_image = 1; 
  {$EXTERNALSYM GL_OES_EGL_image}

procedure glEGLImageTargetTexture2DOES(target: GLenum; image: GLeglImageOES); cdecl;
 external AndroidGles2Lib name 'glEGLImageTargetTexture2DOES';
{$EXTERNALSYM glEGLImageTargetTexture2DOES}

procedure glEGLImageTargetRenderbufferStorageOES(target: GLenum; image: GLeglImageOES); cdecl;
 external AndroidGles2Lib name 'glEGLImageTargetRenderbufferStorageOES';
{$EXTERNALSYM glEGLImageTargetRenderbufferStorageOES}

type
  PFNGLEGLIMAGETARGETTEXTURE2DOESPROC = procedure(target: GLenum; image: GLeglImageOES);
  {$EXTERNALSYM PFNGLEGLIMAGETARGETTEXTURE2DOESPROC}
  PFNGLEGLIMAGETARGETRENDERBUFFERSTORAGEOESPROC = procedure(target: GLenum; image: GLeglImageOES);
  {$EXTERNALSYM PFNGLEGLIMAGETARGETRENDERBUFFERSTORAGEOESPROC}

  const
{  GL_OES_element_index_uint }
  GL_OES_element_index_uint = 1; 
  {$EXTERNALSYM GL_OES_element_index_uint}

{  GL_OES_fbo_render_mipmap }
  GL_OES_fbo_render_mipmap = 1; 
  {$EXTERNALSYM GL_OES_fbo_render_mipmap}

{  GL_OES_fragment_precision_high }
  GL_OES_fragment_precision_high = 1; 
  {$EXTERNALSYM GL_OES_fragment_precision_high}

{  GL_OES_get_program_binary }
  GL_OES_get_program_binary = 1; 
  {$EXTERNALSYM GL_OES_get_program_binary}

procedure glGetProgramBinaryOES(_program: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glGetProgramBinaryOES';
{$EXTERNALSYM glGetProgramBinaryOES}

procedure glProgramBinaryOES(_program: GLuint; binaryFormat: GLenum; const binary: PGLvoid; length: GLint); cdecl;
 external AndroidGles2Lib name 'glProgramBinaryOES';
{$EXTERNALSYM glProgramBinaryOES}

type
  PFNGLGETPROGRAMBINARYOESPROC = procedure(_program: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid);
  {$EXTERNALSYM PFNGLGETPROGRAMBINARYOESPROC}
  PFNGLPROGRAMBINARYOESPROC = procedure(_program: GLuint; binaryFormat: GLenum; const binary: PGLvoid; length: GLint);
  {$EXTERNALSYM PFNGLPROGRAMBINARYOESPROC}

const
{  GL_OES_mapbuffer }
  GL_OES_mapbuffer = 1; 
  {$EXTERNALSYM GL_OES_mapbuffer}

function glMapBufferOES (target: GLenum; access: GLenum): Pointer; cdecl;
 external AndroidEglLib name 'glMapBufferOES';
{$EXTERNALSYM glMapBufferOES}

function glUnmapBufferOES(target: GLenum): GLboolean; cdecl;
 external AndroidEglLib name 'glUnmapBufferOES';
{$EXTERNALSYM glUnmapBufferOES}

procedure glGetBufferPointervOES(target: GLenum; pname: GLenum; params: PPGLvoid); cdecl;
 external AndroidGles2Lib name 'glGetBufferPointervOES';
{$EXTERNALSYM glGetBufferPointervOES}

type
  PFNGLMAPBUFFEROESPROC = function(target: GLenum; access: GLenum): Pointer;
 {$EXTERNALSYM PFNGLMAPBUFFEROESPROC}
  PFNGLUNMAPBUFFEROESPROC = function(target: GLenum): GLboolean;
 {$EXTERNALSYM PFNGLUNMAPBUFFEROESPROC}
  PFNGLGETBUFFERPOINTERVOESPROC = procedure(target: GLenum; pname: GLenum; params: PPGLvoid);
  {$EXTERNALSYM PFNGLGETBUFFERPOINTERVOESPROC}

  const
{  GL_OES_packed_depth_stencil }
  GL_OES_packed_depth_stencil = 1; 
  {$EXTERNALSYM GL_OES_packed_depth_stencil}

{  GL_OES_rgb8_rgba8 }
  GL_OES_rgb8_rgba8 = 1; 
  {$EXTERNALSYM GL_OES_rgb8_rgba8}

{  GL_OES_standard_derivatives }
  GL_OES_standard_derivatives = 1; 
  {$EXTERNALSYM GL_OES_standard_derivatives}

{  GL_OES_stencil1 }
  GL_OES_stencil1 = 1; 
  {$EXTERNALSYM GL_OES_stencil1}

{  GL_OES_stencil4 }
  GL_OES_stencil4 = 1; 
  {$EXTERNALSYM GL_OES_stencil4}

{  GL_OES_texture_3D }
  GL_OES_texture_3D = 1; 
  {$EXTERNALSYM GL_OES_texture_3D}

procedure glTexImage3DOES(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glTexImage3DOES';
{$EXTERNALSYM glTexImage3DOES}

procedure glTexSubImage3DOES(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glTexSubImage3DOES';
{$EXTERNALSYM glTexSubImage3DOES}

procedure glCopyTexSubImage3DOES(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei); cdecl;
 external AndroidGles2Lib name 'glCopyTexSubImage3DOES';
{$EXTERNALSYM glCopyTexSubImage3DOES}

procedure glCompressedTexImage3DOES(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const data: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glCompressedTexImage3DOES';
{$EXTERNALSYM glCompressedTexImage3DOES}

procedure glCompressedTexSubImage3DOES(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const data: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glCompressedTexSubImage3DOES';
{$EXTERNALSYM glCompressedTexSubImage3DOES}

procedure glFramebufferTexture3DOES(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); cdecl;
 external AndroidGles2Lib name 'glFramebufferTexture3DOES';
{$EXTERNALSYM glFramebufferTexture3DOES}

type
  PFNGLTEXIMAGE3DOESPROC = procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; _type: GLenum; const pixels: PGLvoid);
  {$EXTERNALSYM PFNGLTEXIMAGE3DOESPROC}
  PFNGLTEXSUBIMAGE3DOESPROC = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; const pixels: PGLvoid);
  {$EXTERNALSYM PFNGLTEXSUBIMAGE3DOESPROC}
  PFNGLCOPYTEXSUBIMAGE3DOESPROC = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  {$EXTERNALSYM PFNGLCOPYTEXSUBIMAGE3DOESPROC}
  PFNGLCOMPRESSEDTEXIMAGE3DOESPROC = procedure(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; const data: PGLvoid);
  {$EXTERNALSYM PFNGLCOMPRESSEDTEXIMAGE3DOESPROC}
  PFNGLCOMPRESSEDTEXSUBIMAGE3DOESPROC = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; const data: PGLvoid);
  {$EXTERNALSYM PFNGLCOMPRESSEDTEXSUBIMAGE3DOESPROC}
  PFNGLFRAMEBUFFERTEXTURE3DOES = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  {$EXTERNALSYM PFNGLFRAMEBUFFERTEXTURE3DOES}

const
{  GL_OES_texture_float }
  GL_OES_texture_float = 1; 
  {$EXTERNALSYM GL_OES_texture_float}

{  GL_OES_texture_float_linear }
  GL_OES_texture_float_linear = 1; 
  {$EXTERNALSYM GL_OES_texture_float_linear}

{  GL_OES_texture_half_float }
  GL_OES_texture_half_float = 1; 
  {$EXTERNALSYM GL_OES_texture_half_float}

{  GL_OES_texture_half_float_linear }
  GL_OES_texture_half_float_linear = 1; 
  {$EXTERNALSYM GL_OES_texture_half_float_linear}

{  GL_OES_texture_npot }
  GL_OES_texture_npot = 1; 
  {$EXTERNALSYM GL_OES_texture_npot}

{  GL_OES_vertex_array_object }
  GL_OES_vertex_array_object = 1; 
  {$EXTERNALSYM GL_OES_vertex_array_object}
{
procedure glBindVertexArrayOES(_array: GLuint); cdecl;
 external AndroidGles2Lib name 'glBindVertexArrayOES';
{$EXTERNALSYM glBindVertexArrayOES}

{procedure glDeleteVertexArraysOES(n: GLsizei; const arrays: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteVertexArraysOES';
{$EXTERNALSYM glDeleteVertexArraysOES}

{procedure glGenVertexArraysOES(n: GLsizei; arrays: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenVertexArraysOES';
{$EXTERNALSYM glGenVertexArraysOES}

{function glIsVertexArrayOES(_array: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glIsVertexArrayOES';
{$EXTERNALSYM glIsVertexArrayOES}

{type
  {PFNGLBINDVERTEXARRAYOESPROC = procedure(_array: GLuint);
  {$EXTERNALSYM PFNGLBINDVERTEXARRAYOESPROC}
  {PFNGLDELETEVERTEXARRAYSOESPROC = procedure(n: GLsizei; const arrays: PGLuint);
  {$EXTERNALSYM PFNGLDELETEVERTEXARRAYSOESPROC}
  {PFNGLGENVERTEXARRAYSOESPROC = procedure(n: GLsizei; arrays: PGLuint);
  {$EXTERNALSYM PFNGLGENVERTEXARRAYSOESPROC}
  {PFNGLISVERTEXARRAYOESPROC = function(_array: GLuint): GLboolean;
 {$EXTERNALSYM PFNGLISVERTEXARRAYOESPROC}

 const
{  GL_OES_vertex_half_float }
  GL_OES_vertex_half_float = 1; 
  {$EXTERNALSYM GL_OES_vertex_half_float}

{  GL_OES_vertex_type_10_10_10_2 }
  GL_OES_vertex_type_10_10_10_2 = 1; 
  {$EXTERNALSYM GL_OES_vertex_type_10_10_10_2}

{  GL_OES_EGL_image_external }
  GL_OES_EGL_image_external = 1; 
  {$EXTERNALSYM GL_OES_EGL_image_external}

{ ------------------------------------------------------------------------
   AMD extension functions
  ------------------------------------------------------------------------
}

{  GL_AMD_compressed_3DC_texture }
  GL_AMD_compressed_3DC_texture = 1; 
  {$EXTERNALSYM GL_AMD_compressed_3DC_texture}

{  GL_AMD_compressed_ATC_texture }
  GL_AMD_compressed_ATC_texture = 1; 
  {$EXTERNALSYM GL_AMD_compressed_ATC_texture}

{  AMD_performance_monitor }
  GL_AMD_performance_monitor = 1; 
  {$EXTERNALSYM GL_AMD_performance_monitor}

procedure glGetPerfMonitorGroupsAMD(numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGetPerfMonitorGroupsAMD';
{$EXTERNALSYM glGetPerfMonitorGroupsAMD}

procedure glGetPerfMonitorCountersAMD(group: GLuint; numCounters: PGLint; maxActiveCounters: PGLint; counterSize: GLsizei; counters: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGetPerfMonitorCountersAMD';
{$EXTERNALSYM glGetPerfMonitorCountersAMD}

procedure glGetPerfMonitorGroupStringAMD(group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetPerfMonitorGroupStringAMD';
{$EXTERNALSYM glGetPerfMonitorGroupStringAMD}

procedure glGetPerfMonitorCounterStringAMD(group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetPerfMonitorCounterStringAMD';
{$EXTERNALSYM glGetPerfMonitorCounterStringAMD}

procedure glGetPerfMonitorCounterInfoAMD(group: GLuint; counter: GLuint; pname: GLenum; data: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glGetPerfMonitorCounterInfoAMD';
{$EXTERNALSYM glGetPerfMonitorCounterInfoAMD}

procedure glGenPerfMonitorsAMD(n: GLsizei; monitors: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenPerfMonitorsAMD';
{$EXTERNALSYM glGenPerfMonitorsAMD}

procedure glDeletePerfMonitorsAMD(n: GLsizei; monitors: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeletePerfMonitorsAMD';
{$EXTERNALSYM glDeletePerfMonitorsAMD}

procedure glSelectPerfMonitorCountersAMD(monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; countersList: PGLuint); cdecl;
 external AndroidGles2Lib name 'glSelectPerfMonitorCountersAMD';
{$EXTERNALSYM glSelectPerfMonitorCountersAMD}

procedure glBeginPerfMonitorAMD(monitor: GLuint); cdecl;
 external AndroidGles2Lib name 'glBeginPerfMonitorAMD';
{$EXTERNALSYM glBeginPerfMonitorAMD}

procedure glEndPerfMonitorAMD(monitor: GLuint); cdecl;
 external AndroidGles2Lib name 'glEndPerfMonitorAMD';
{$EXTERNALSYM glEndPerfMonitorAMD}

procedure glGetPerfMonitorCounterDataAMD(monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetPerfMonitorCounterDataAMD';
{$EXTERNALSYM glGetPerfMonitorCounterDataAMD}

type
  PFNGLGETPERFMONITORGROUPSAMDPROC = procedure(numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint);
  {$EXTERNALSYM PFNGLGETPERFMONITORGROUPSAMDPROC}
  PFNGLGETPERFMONITORCOUNTERSAMDPROC = procedure(group: GLuint; numCounters: PGLint; maxActiveCounters: PGLint; counterSize: GLsizei; counters: PGLuint);
  {$EXTERNALSYM PFNGLGETPERFMONITORCOUNTERSAMDPROC}
  PFNGLGETPERFMONITORGROUPSTRINGAMDPROC = procedure(group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar);
  {$EXTERNALSYM PFNGLGETPERFMONITORGROUPSTRINGAMDPROC}
  PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC = procedure(group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar);
  {$EXTERNALSYM PFNGLGETPERFMONITORCOUNTERSTRINGAMDPROC}
  PFNGLGETPERFMONITORCOUNTERINFOAMDPROC = procedure(group: GLuint; counter: GLuint; pname: GLenum; data: PGLvoid);
  {$EXTERNALSYM PFNGLGETPERFMONITORCOUNTERINFOAMDPROC}
  PFNGLGENPERFMONITORSAMDPROC = procedure(n: GLsizei; monitors: PGLuint);
  {$EXTERNALSYM PFNGLGENPERFMONITORSAMDPROC}
  PFNGLDELETEPERFMONITORSAMDPROC = procedure(n: GLsizei; monitors: PGLuint);
  {$EXTERNALSYM PFNGLDELETEPERFMONITORSAMDPROC}
  PFNGLSELECTPERFMONITORCOUNTERSAMDPROC = procedure(monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; countersList: PGLuint);
  {$EXTERNALSYM PFNGLSELECTPERFMONITORCOUNTERSAMDPROC}
  PFNGLBEGINPERFMONITORAMDPROC = procedure(monitor: GLuint);
  {$EXTERNALSYM PFNGLBEGINPERFMONITORAMDPROC}
  PFNGLENDPERFMONITORAMDPROC = procedure(monitor: GLuint);
  {$EXTERNALSYM PFNGLENDPERFMONITORAMDPROC}
  PFNGLGETPERFMONITORCOUNTERDATAAMDPROC = procedure(monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint);
  {$EXTERNALSYM PFNGLGETPERFMONITORCOUNTERDATAAMDPROC}

  const
{  GL_AMD_program_binary_Z400 }
  GL_AMD_program_binary_Z400 = 1; 
  {$EXTERNALSYM GL_AMD_program_binary_Z400}

{ ------------------------------------------------------------------------
   EXT extension functions
  ------------------------------------------------------------------------
}

{  GL_EXT_blend_minmax }
  GL_EXT_blend_minmax = 1; 
  {$EXTERNALSYM GL_EXT_blend_minmax}

{  GL_EXT_discard_framebuffer }
  GL_EXT_discard_framebuffer = 1; 
  {$EXTERNALSYM GL_EXT_discard_framebuffer}

{ glDiscardFramebufferEXT(target: GLenum; numAttachments: GLsizei; const attachments: PGLenum); cdecl;
 external AndroidGles2Lib name 'glDiscardFramebufferEXT';
{$EXTERNALSYM glDiscardFramebufferEXT}

{type
  {PFNGLDISCARDFRAMEBUFFEREXTPROC = procedure(target: GLenum; numAttachments: GLsizei; const attachments: PGLenum);
  {$EXTERNALSYM PFNGLDISCARDFRAMEBUFFEREXTPROC}

const
  GL_EXT_multi_draw_arrays = 1; 
  {$EXTERNALSYM GL_EXT_multi_draw_arrays}

{procedure glMultiDrawArraysEXT(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei); cdecl;
 external AndroidGles2Lib name 'glMultiDrawArraysEXT';
{$EXTERNALSYM glMultiDrawArraysEXT}

{procedure glMultiDrawElementsEXT(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: PPGLVoid; primcount: GLsizei); cdecl;
 external AndroidGles2Lib name 'glMultiDrawElementsEXT';
{$EXTERNALSYM glMultiDrawElementsEXT}

{type
  {PFNGLMULTIDRAWARRAYSEXTPROC = procedure(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei);
  {$EXTERNALSYM PFNGLMULTIDRAWARRAYSEXTPROC}
  {PFNGLMULTIDRAWELEMENTSEXTPROC = procedure(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: PPGLVoid; primcount: GLsizei);
  {$EXTERNALSYM PFNGLMULTIDRAWELEMENTSEXTPROC}

  const
{  GL_EXT_read_format_bgra }
  GL_EXT_read_format_bgra = 1; 
  {$EXTERNALSYM GL_EXT_read_format_bgra}

{  GL_EXT_texture_filter_anisotropic }
  GL_EXT_texture_filter_anisotropic = 1; 
  {$EXTERNALSYM GL_EXT_texture_filter_anisotropic}

{  GL_EXT_texture_format_BGRA8888 }
  GL_EXT_texture_format_BGRA8888 = 1; 
  {$EXTERNALSYM GL_EXT_texture_format_BGRA8888}

{  GL_EXT_texture_type_2_10_10_10_REV }
  GL_EXT_texture_type_2_10_10_10_REV = 1; 
  {$EXTERNALSYM GL_EXT_texture_type_2_10_10_10_REV}

{  GL_EXT_texture_compression_dxt1 }
  GL_EXT_texture_compression_dxt1 = 1; 
  {$EXTERNALSYM GL_EXT_texture_compression_dxt1}

{ ------------------------------------------------------------------------
   IMG extension functions
  ------------------------------------------------------------------------
}

{  GL_IMG_program_binary }
  GL_IMG_program_binary = 1; 
  {$EXTERNALSYM GL_IMG_program_binary}

{  GL_IMG_read_format }
  GL_IMG_read_format = 1; 
  {$EXTERNALSYM GL_IMG_read_format}

{  GL_IMG_shader_binary }
  GL_IMG_shader_binary = 1; 
  {$EXTERNALSYM GL_IMG_shader_binary}

{  GL_IMG_texture_compression_pvrtc }
  GL_IMG_texture_compression_pvrtc = 1; 
  {$EXTERNALSYM GL_IMG_texture_compression_pvrtc}

{  GL_IMG_multisampled_render_to_texture }
  GL_IMG_multisampled_render_to_texture = 1; 
  {$EXTERNALSYM GL_IMG_multisampled_render_to_texture}

{procedure glRenderbufferStorageMultisampleIMG(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); cdecl;
 external AndroidGles2Lib name 'glRenderbufferStorageMultisampleIMG';
{$EXTERNALSYM glRenderbufferStorageMultisampleIMG}

{procedure glFramebufferTexture2DMultisampleIMG(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; samples: GLsizei); cdecl;
 external AndroidGles2Lib name 'glFramebufferTexture2DMultisampleIMG';
{$EXTERNALSYM glFramebufferTexture2DMultisampleIMG}

{type
  {PFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMG = procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  {$EXTERNALSYM PFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMG}
  {PFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMG = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; samples: GLsizei);
  {$EXTERNALSYM PFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMG}

{ ------------------------------------------------------------------------
   NV extension functions
  ------------------------------------------------------------------------
}
const
{  GL_NV_fence }
  GL_NV_fence = 1; 
  {$EXTERNALSYM GL_NV_fence}

procedure glDeleteFencesNV(n: GLsizei; const fences: PGLuint); cdecl;
 external AndroidGles2Lib name 'glDeleteFencesNV';
{$EXTERNALSYM glDeleteFencesNV}

procedure glGenFencesNV(n: GLsizei; fences: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGenFencesNV';
{$EXTERNALSYM glGenFencesNV}

function glIsFenceNV(fence: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glIsFenceNV';
{$EXTERNALSYM glIsFenceNV}

function glTestFenceNV(fence: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glTestFenceNV';
{$EXTERNALSYM glTestFenceNV}

procedure glGetFenceivNV(fence: GLuint; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glGetFenceivNV';
{$EXTERNALSYM glGetFenceivNV}

procedure glFinishFenceNV(fence: GLuint); cdecl;
 external AndroidGles2Lib name 'glFinishFenceNV';
{$EXTERNALSYM glFinishFenceNV}

procedure glSetFenceNV(fence: GLuint; condition: GLenum); cdecl;
 external AndroidGles2Lib name 'glSetFenceNV';
{$EXTERNALSYM glSetFenceNV}

type
  PFNGLDELETEFENCESNVPROC = procedure(n: GLsizei; const fences: PGLuint);
  {$EXTERNALSYM PFNGLDELETEFENCESNVPROC}
  PFNGLGENFENCESNVPROC = procedure(n: GLsizei; fences: PGLuint);
  {$EXTERNALSYM PFNGLGENFENCESNVPROC}
  PFNGLISFENCENVPROC = function(fence: GLuint): GLboolean;
 {$EXTERNALSYM PFNGLISFENCENVPROC}
  PFNGLTESTFENCENVPROC = function(fence: GLuint): GLboolean;
 {$EXTERNALSYM PFNGLTESTFENCENVPROC}
  PFNGLGETFENCEIVNVPROC = procedure(fence: GLuint; pname: GLenum; params: PGLint);
  {$EXTERNALSYM PFNGLGETFENCEIVNVPROC}
  PFNGLFINISHFENCENVPROC = procedure(fence: GLuint);
  {$EXTERNALSYM PFNGLFINISHFENCENVPROC}
  PFNGLSETFENCENVPROC = procedure(fence: GLuint; condition: GLenum);
  {$EXTERNALSYM PFNGLSETFENCENVPROC}

const
{  GL_NV_coverage_sample }
  GL_NV_coverage_sample = 1; 
  {$EXTERNALSYM GL_NV_coverage_sample}

{procedure glCoverageMaskNV(mask: GLboolean); cdecl;
 external AndroidGles2Lib name 'glCoverageMaskNV';
{$EXTERNALSYM glCoverageMaskNV}

{procedure glCoverageOperationNV(operation: GLenum); cdecl;
 external AndroidGles2Lib name 'glCoverageOperationNV';
{$EXTERNALSYM glCoverageOperationNV}

{type
  {PFNGLCOVERAGEMASKNVPROC = procedure(mask: GLboolean);
  {$EXTERNALSYM PFNGLCOVERAGEMASKNVPROC}
  {PFNGLCOVERAGEOPERATIONNVPROC = procedure(operation: GLenum);
  {$EXTERNALSYM PFNGLCOVERAGEOPERATIONNVPROC}

const
{  GL_NV_depth_nonlinear }
  GL_NV_depth_nonlinear = 1; 
  {$EXTERNALSYM GL_NV_depth_nonlinear}

{ ------------------------------------------------------------------------
   QCOM extension functions
  ------------------------------------------------------------------------
}

{  GL_QCOM_driver_control }
  GL_QCOM_driver_control = 1; 
  {$EXTERNALSYM GL_QCOM_driver_control}

procedure glGetDriverControlsQCOM(num: PGLint; size: GLsizei; driverControls: PGLuint); cdecl;
 external AndroidGles2Lib name 'glGetDriverControlsQCOM';
{$EXTERNALSYM glGetDriverControlsQCOM}

procedure glGetDriverControlStringQCOM(driverControl: GLuint; bufSize: GLsizei; length: PGLsizei; driverControlString: PGLchar); cdecl;
 external AndroidGles2Lib name 'glGetDriverControlStringQCOM';
{$EXTERNALSYM glGetDriverControlStringQCOM}

procedure glEnableDriverControlQCOM(driverControl: GLuint); cdecl;
 external AndroidGles2Lib name 'glEnableDriverControlQCOM';
{$EXTERNALSYM glEnableDriverControlQCOM}

procedure glDisableDriverControlQCOM(driverControl: GLuint); cdecl;
 external AndroidGles2Lib name 'glDisableDriverControlQCOM';
{$EXTERNALSYM glDisableDriverControlQCOM}

type
  PFNGLGETDRIVERCONTROLSQCOMPROC = procedure(num: PGLint; size: GLsizei; driverControls: PGLuint);
  {$EXTERNALSYM PFNGLGETDRIVERCONTROLSQCOMPROC}
  PFNGLGETDRIVERCONTROLSTRINGQCOMPROC = procedure(driverControl: GLuint; bufSize: GLsizei; length: PGLsizei; driverControlString: PGLchar);
  {$EXTERNALSYM PFNGLGETDRIVERCONTROLSTRINGQCOMPROC}
  PFNGLENABLEDRIVERCONTROLQCOMPROC = procedure(driverControl: GLuint);
  {$EXTERNALSYM PFNGLENABLEDRIVERCONTROLQCOMPROC}
  PFNGLDISABLEDRIVERCONTROLQCOMPROC = procedure(driverControl: GLuint);
  {$EXTERNALSYM PFNGLDISABLEDRIVERCONTROLQCOMPROC}

const
{  GL_QCOM_extended_get }
  GL_QCOM_extended_get = 1; 
  {$EXTERNALSYM GL_QCOM_extended_get}

{procedure glExtGetTexturesQCOM(textures: PGLuint; maxTextures: GLint; numTextures: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetTexturesQCOM';
{$EXTERNALSYM glExtGetTexturesQCOM}

{procedure glExtGetBuffersQCOM(buffers: PGLuint; maxBuffers: GLint; numBuffers: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetBuffersQCOM';
{$EXTERNALSYM glExtGetBuffersQCOM}

{procedure glExtGetRenderbuffersQCOM(renderbuffers: PGLuint; maxRenderbuffers: GLint; numRenderbuffers: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetRenderbuffersQCOM';
{$EXTERNALSYM glExtGetRenderbuffersQCOM}

{procedure glExtGetFramebuffersQCOM(framebuffers: PGLuint; maxFramebuffers: GLint; numFramebuffers: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetFramebuffersQCOM';
{$EXTERNALSYM glExtGetFramebuffersQCOM}

{procedure glExtGetTexLevelParameterivQCOM(texture: GLuint; face: GLenum; level: GLint; pname: GLenum; params: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetTexLevelParameterivQCOM';
{$EXTERNALSYM glExtGetTexLevelParameterivQCOM}

{procedure glExtTexObjectStateOverrideiQCOM(target: GLenum; pname: GLenum; param: GLint); cdecl;
 external AndroidGles2Lib name 'glExtTexObjectStateOverrideiQCOM';
{$EXTERNALSYM glExtTexObjectStateOverrideiQCOM}

{procedure glExtGetTexSubImageQCOM(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; texels: PGLvoid); cdecl;
 external AndroidGles2Lib name 'glExtGetTexSubImageQCOM';
{$EXTERNALSYM glExtGetTexSubImageQCOM}

{procedure glExtGetBufferPointervQCOM(target: GLenum; params: PPGLvoid); cdecl;
 external AndroidGles2Lib name 'glExtGetBufferPointervQCOM';
{$EXTERNALSYM glExtGetBufferPointervQCOM}

{type
  {PFNGLEXTGETTEXTURESQCOMPROC = procedure(textures: PGLuint; maxTextures: GLint; numTextures: PGLint);
  {$EXTERNALSYM PFNGLEXTGETTEXTURESQCOMPROC}
  {PFNGLEXTGETBUFFERSQCOMPROC = procedure(buffers: PGLuint; maxBuffers: GLint; numBuffers: PGLint);
  {$EXTERNALSYM PFNGLEXTGETBUFFERSQCOMPROC}
  {PFNGLEXTGETRENDERBUFFERSQCOMPROC = procedure(renderbuffers: PGLuint; maxRenderbuffers: GLint; numRenderbuffers: PGLint);
  {$EXTERNALSYM PFNGLEXTGETRENDERBUFFERSQCOMPROC}
  {PFNGLEXTGETFRAMEBUFFERSQCOMPROC = procedure(framebuffers: PGLuint; maxFramebuffers: GLint; numFramebuffers: PGLint);
  {$EXTERNALSYM PFNGLEXTGETFRAMEBUFFERSQCOMPROC}
  {PFNGLEXTGETTEXLEVELPARAMETERIVQCOMPROC = procedure(texture: GLuint; face: GLenum; level: GLint; pname: GLenum; params: PGLint);
  {$EXTERNALSYM PFNGLEXTGETTEXLEVELPARAMETERIVQCOMPROC}
  {PFNGLEXTTEXOBJECTSTATEOVERRIDEIQCOMPROC = procedure(target: GLenum; pname: GLenum; param: GLint);
  {$EXTERNALSYM PFNGLEXTTEXOBJECTSTATEOVERRIDEIQCOMPROC}
  {PFNGLEXTGETTEXSUBIMAGEQCOMPROC = procedure(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; texels: PGLvoid);
  {$EXTERNALSYM PFNGLEXTGETTEXSUBIMAGEQCOMPROC}
  {PFNGLEXTGETBUFFERPOINTERVQCOMPROC = procedure(target: GLenum; params: PPGLvoid);
  {$EXTERNALSYM PFNGLEXTGETBUFFERPOINTERVQCOMPROC}

const
{  GL_QCOM_extended_get2 }
  GL_QCOM_extended_get2 = 1; 
  {$EXTERNALSYM GL_QCOM_extended_get2}

{procedure glExtGetShadersQCOM(shaders: PGLuint; maxShaders: GLint; numShaders: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetShadersQCOM';
{$EXTERNALSYM glExtGetShadersQCOM}

{procedure glExtGetProgramsQCOM(programs: PGLuint; maxPrograms: GLint; numPrograms: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetProgramsQCOM';
{$EXTERNALSYM glExtGetProgramsQCOM}

{function glExtIsProgramBinaryQCOM (_program: GLuint): GLboolean; cdecl;
 external AndroidGles2Lib name 'glExtIsProgramBinaryQCOM';
{$EXTERNALSYM glExtIsProgramBinaryQCOM}


{procedure glExtGetProgramBinarySourceQCOM(_program: GLuint; shadertype: GLenum; source: PGLchar; length: PGLint); cdecl;
 external AndroidGles2Lib name 'glExtGetProgramBinarySourceQCOM';
{$EXTERNALSYM glExtGetProgramBinarySourceQCOM}

{type
  {PFNGLEXTGETSHADERSQCOMPROC = procedure(shaders: PGLuint; maxShaders: GLint; numShaders: PGLint);
  {$EXTERNALSYM PFNGLEXTGETSHADERSQCOMPROC}
  {PFNGLEXTGETPROGRAMSQCOMPROC = procedure(programs: PGLuint; maxPrograms: GLint; numPrograms: PGLint);
  {$EXTERNALSYM PFNGLEXTGETPROGRAMSQCOMPROC}
  {PFNGLEXTISPROGRAMBINARYQCOMPROC = function(_program: GLuint): GLboolean;
 {$EXTERNALSYM PFNGLEXTISPROGRAMBINARYQCOMPROC}
  {PFNGLEXTGETPROGRAMBINARYSOURCEQCOMPROC = procedure(_program: GLuint; shadertype: GLenum; source: PGLchar; length: PGLint);
  {$EXTERNALSYM PFNGLEXTGETPROGRAMBINARYSOURCEQCOMPROC}

const
{  GL_QCOM_perfmon_global_mode }
  GL_QCOM_perfmon_global_mode = 1; 
  {$EXTERNALSYM GL_QCOM_perfmon_global_mode}

{  GL_QCOM_writeonly_rendering }
  GL_QCOM_writeonly_rendering = 1; 
  {$EXTERNALSYM GL_QCOM_writeonly_rendering}

{  GL_QCOM_tiled_rendering }
  GL_QCOM_tiled_rendering = 1; 
  {$EXTERNALSYM GL_QCOM_tiled_rendering}

{procedure glStartTilingQCOM(x: GLuint; y: GLuint; width: GLuint; height: GLuint; preserveMask: GLbitfield); cdecl;
 external AndroidGles2Lib name 'glStartTilingQCOM';
{$EXTERNALSYM glStartTilingQCOM}

{procedure glEndTilingQCOM(preserveMask: GLbitfield); cdecl;
 external AndroidGles2Lib name 'glEndTilingQCOM';
{$EXTERNALSYM glEndTilingQCOM}

{type
  {PFNGLSTARTTILINGQCOMPROC = procedure(x: GLuint; y: GLuint; width: GLuint; height: GLuint; preserveMask: GLbitfield);
  {$EXTERNALSYM PFNGLSTARTTILINGQCOMPROC}
  {PFNGLENDTILINGQCOMPROC = procedure(preserveMask: GLbitfield);
  {$EXTERNALSYM PFNGLENDTILINGQCOMPROC}

implementation

end.
