{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Glesext;

interface

uses Posix.SysTypes,
     Androidapi.KhrPlatform,
     Androidapi.Gles;

{$I Androidapi.inc}


const
{ ------------------------------------------------------------------------
   OES extension tokens
  ------------------------------------------------------------------------ }

{  GL_OES_blend_equation_separate }
{  BLEND_EQUATION_RGB_OES same as BLEND_EQUATION_OES }
  GL_BLEND_EQUATION_RGB_OES = $8009;
  {$EXTERNALSYM GL_BLEND_EQUATION_RGB_OES}
  GL_BLEND_EQUATION_ALPHA_OES = $883D;
  {$EXTERNALSYM GL_BLEND_EQUATION_ALPHA_OES}

{  GL_OES_blend_func_separate }
  GL_BLEND_DST_RGB_OES = $80C8;
  {$EXTERNALSYM GL_BLEND_DST_RGB_OES}
  GL_BLEND_SRC_RGB_OES = $80C9;
  {$EXTERNALSYM GL_BLEND_SRC_RGB_OES}
  GL_BLEND_DST_ALPHA_OES = $80CA;
  {$EXTERNALSYM GL_BLEND_DST_ALPHA_OES}
  GL_BLEND_SRC_ALPHA_OES = $80CB;
  {$EXTERNALSYM GL_BLEND_SRC_ALPHA_OES}

{  GL_OES_blend_subtract }
  GL_BLEND_EQUATION_OES = $8009;
  {$EXTERNALSYM GL_BLEND_EQUATION_OES}
  GL_FUNC_ADD_OES = $8006;
  {$EXTERNALSYM GL_FUNC_ADD_OES}
  GL_FUNC_SUBTRACT_OES = $800A;
  {$EXTERNALSYM GL_FUNC_SUBTRACT_OES}
  GL_FUNC_REVERSE_SUBTRACT_OES = $800B;
  {$EXTERNALSYM GL_FUNC_REVERSE_SUBTRACT_OES}

{  GL_OES_compressed_ETC1_RGB8_texture }
  GL_ETC1_RGB8_OES = $8D64;
  {$EXTERNALSYM GL_ETC1_RGB8_OES}

{  GL_OES_depth24 }
  GL_DEPTH_COMPONENT24_OES = $81A6;
  {$EXTERNALSYM GL_DEPTH_COMPONENT24_OES}

{  GL_OES_depth32 }
  GL_DEPTH_COMPONENT32_OES = $81A7;
  {$EXTERNALSYM GL_DEPTH_COMPONENT32_OES}

{  GL_OES_draw_texture }
  GL_TEXTURE_CROP_RECT_OES = $8B9D;
  {$EXTERNALSYM GL_TEXTURE_CROP_RECT_OES}

type
{  GL_OES_EGL_image }
  GLeglImageOES = Pointer;

const
{  GL_OES_element_index_uint }
  GL_UNSIGNED_INT = $1405;
  {$EXTERNALSYM GL_UNSIGNED_INT}

{  GL_OES_fixed_point }
  GL_FIXED_OES = $140C;
  {$EXTERNALSYM GL_FIXED_OES}

{  GL_OES_framebuffer_object }
  GL_NONE_OES = 0;
  {$EXTERNALSYM GL_NONE_OES}
  GL_FRAMEBUFFER_OES = $8D40;
  {$EXTERNALSYM GL_FRAMEBUFFER_OES}
  GL_RENDERBUFFER_OES = $8D41;
  {$EXTERNALSYM GL_RENDERBUFFER_OES}
  GL_RGBA4_OES = $8056;
  {$EXTERNALSYM GL_RGBA4_OES}
  GL_RGB5_A1_OES = $8057;
  {$EXTERNALSYM GL_RGB5_A1_OES}
  GL_RGB565_OES = $8D62;
  {$EXTERNALSYM GL_RGB565_OES}
  GL_DEPTH_COMPONENT16_OES = $81A5;
  {$EXTERNALSYM GL_DEPTH_COMPONENT16_OES}
  GL_RENDERBUFFER_WIDTH_OES = $8D42;
  {$EXTERNALSYM GL_RENDERBUFFER_WIDTH_OES}
  GL_RENDERBUFFER_HEIGHT_OES = $8D43;
  {$EXTERNALSYM GL_RENDERBUFFER_HEIGHT_OES}
  GL_RENDERBUFFER_INTERNAL_FORMAT_OES = $8D44;
  {$EXTERNALSYM GL_RENDERBUFFER_INTERNAL_FORMAT_OES}
  GL_RENDERBUFFER_RED_SIZE_OES = $8D50;
  {$EXTERNALSYM GL_RENDERBUFFER_RED_SIZE_OES}
  GL_RENDERBUFFER_GREEN_SIZE_OES = $8D51;
  {$EXTERNALSYM GL_RENDERBUFFER_GREEN_SIZE_OES}
  GL_RENDERBUFFER_BLUE_SIZE_OES = $8D52;
  {$EXTERNALSYM GL_RENDERBUFFER_BLUE_SIZE_OES}
  GL_RENDERBUFFER_ALPHA_SIZE_OES = $8D53;
  {$EXTERNALSYM GL_RENDERBUFFER_ALPHA_SIZE_OES}
  GL_RENDERBUFFER_DEPTH_SIZE_OES = $8D54;
  {$EXTERNALSYM GL_RENDERBUFFER_DEPTH_SIZE_OES}
  GL_RENDERBUFFER_STENCIL_SIZE_OES = $8D55;
  {$EXTERNALSYM GL_RENDERBUFFER_STENCIL_SIZE_OES}
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_OES = $8CD0;
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_OES}
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_OES = $8CD1;
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_OES}
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_OES = $8CD2;
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_OES}
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_OES = $8CD3;
  {$EXTERNALSYM GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_OES}
  GL_COLOR_ATTACHMENT0_OES = $8CE0;
  {$EXTERNALSYM GL_COLOR_ATTACHMENT0_OES}
  GL_DEPTH_ATTACHMENT_OES = $8D00;
  {$EXTERNALSYM GL_DEPTH_ATTACHMENT_OES}
  GL_STENCIL_ATTACHMENT_OES = $8D20;
  {$EXTERNALSYM GL_STENCIL_ATTACHMENT_OES}
  GL_FRAMEBUFFER_COMPLETE_OES = $8CD5;
  {$EXTERNALSYM GL_FRAMEBUFFER_COMPLETE_OES}
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_OES = $8CD6;
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_OES}
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_OES = $8CD7;
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_OES}
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_OES = $8CD9;
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_OES}
  GL_FRAMEBUFFER_INCOMPLETE_FORMATS_OES = $8CDA;
  {$EXTERNALSYM GL_FRAMEBUFFER_INCOMPLETE_FORMATS_OES}
  GL_FRAMEBUFFER_UNSUPPORTED_OES = $8CDD;
  {$EXTERNALSYM GL_FRAMEBUFFER_UNSUPPORTED_OES}
  GL_FRAMEBUFFER_BINDING_OES = $8CA6;
  {$EXTERNALSYM GL_FRAMEBUFFER_BINDING_OES}
  GL_RENDERBUFFER_BINDING_OES = $8CA7;
  {$EXTERNALSYM GL_RENDERBUFFER_BINDING_OES}
  GL_MAX_RENDERBUFFER_SIZE_OES = $84E8;
  {$EXTERNALSYM GL_MAX_RENDERBUFFER_SIZE_OES}
  GL_INVALID_FRAMEBUFFER_OPERATION_OES = $0506;
  {$EXTERNALSYM GL_INVALID_FRAMEBUFFER_OPERATION_OES}

{  GL_OES_mapbuffer }
  GL_WRITE_ONLY_OES = $88B9;
  {$EXTERNALSYM GL_WRITE_ONLY_OES}
  GL_BUFFER_ACCESS_OES = $88BB;
  {$EXTERNALSYM GL_BUFFER_ACCESS_OES}
  GL_BUFFER_MAPPED_OES = $88BC;
  {$EXTERNALSYM GL_BUFFER_MAPPED_OES}
  GL_BUFFER_MAP_POINTER_OES = $88BD;
  {$EXTERNALSYM GL_BUFFER_MAP_POINTER_OES}

{  GL_OES_matrix_get }
  GL_MODELVIEW_MATRIX_FLOAT_AS_INT_BITS_OES = $898D;
  {$EXTERNALSYM GL_MODELVIEW_MATRIX_FLOAT_AS_INT_BITS_OES}
  GL_PROJECTION_MATRIX_FLOAT_AS_INT_BITS_OES = $898E;
  {$EXTERNALSYM GL_PROJECTION_MATRIX_FLOAT_AS_INT_BITS_OES}
  GL_TEXTURE_MATRIX_FLOAT_AS_INT_BITS_OES = $898F;
  {$EXTERNALSYM GL_TEXTURE_MATRIX_FLOAT_AS_INT_BITS_OES}

{  GL_OES_matrix_palette }
  GL_MAX_VERTEX_UNITS_OES = $86A4;
  {$EXTERNALSYM GL_MAX_VERTEX_UNITS_OES}
  GL_MAX_PALETTE_MATRICES_OES = $8842;
  {$EXTERNALSYM GL_MAX_PALETTE_MATRICES_OES}
  GL_MATRIX_PALETTE_OES = $8840;
  {$EXTERNALSYM GL_MATRIX_PALETTE_OES}
  GL_MATRIX_INDEX_ARRAY_OES = $8844;
  {$EXTERNALSYM GL_MATRIX_INDEX_ARRAY_OES}
  GL_WEIGHT_ARRAY_OES = $86AD;
  {$EXTERNALSYM GL_WEIGHT_ARRAY_OES}
  GL_CURRENT_PALETTE_MATRIX_OES = $8843;
  {$EXTERNALSYM GL_CURRENT_PALETTE_MATRIX_OES}
  GL_MATRIX_INDEX_ARRAY_SIZE_OES = $8846;
  {$EXTERNALSYM GL_MATRIX_INDEX_ARRAY_SIZE_OES}
  GL_MATRIX_INDEX_ARRAY_TYPE_OES = $8847;
  {$EXTERNALSYM GL_MATRIX_INDEX_ARRAY_TYPE_OES}
  GL_MATRIX_INDEX_ARRAY_STRIDE_OES = $8848;
  {$EXTERNALSYM GL_MATRIX_INDEX_ARRAY_STRIDE_OES}
  GL_MATRIX_INDEX_ARRAY_POINTER_OES = $8849;
  {$EXTERNALSYM GL_MATRIX_INDEX_ARRAY_POINTER_OES}
  GL_MATRIX_INDEX_ARRAY_BUFFER_BINDING_OES = $8B9E;
  {$EXTERNALSYM GL_MATRIX_INDEX_ARRAY_BUFFER_BINDING_OES}
  GL_WEIGHT_ARRAY_SIZE_OES = $86AB;
  {$EXTERNALSYM GL_WEIGHT_ARRAY_SIZE_OES}
  GL_WEIGHT_ARRAY_TYPE_OES = $86A9;
  {$EXTERNALSYM GL_WEIGHT_ARRAY_TYPE_OES}
  GL_WEIGHT_ARRAY_STRIDE_OES = $86AA;
  {$EXTERNALSYM GL_WEIGHT_ARRAY_STRIDE_OES}
  GL_WEIGHT_ARRAY_POINTER_OES = $86AC;
  {$EXTERNALSYM GL_WEIGHT_ARRAY_POINTER_OES}
  GL_WEIGHT_ARRAY_BUFFER_BINDING_OES = $889E;
  {$EXTERNALSYM GL_WEIGHT_ARRAY_BUFFER_BINDING_OES}

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

{  GL_OES_stencil1 }
  GL_STENCIL_INDEX1_OES = $8D46;
  {$EXTERNALSYM GL_STENCIL_INDEX1_OES}

{  GL_OES_stencil4 }
  GL_STENCIL_INDEX4_OES = $8D47;
  {$EXTERNALSYM GL_STENCIL_INDEX4_OES}

{  GL_OES_stencil8 }
  GL_STENCIL_INDEX8_OES = $8D48;
  {$EXTERNALSYM GL_STENCIL_INDEX8_OES}

{  GL_OES_stencil_wrap }
  GL_INCR_WRAP_OES = $8507;
  {$EXTERNALSYM GL_INCR_WRAP_OES}
  GL_DECR_WRAP_OES = $8508;
  {$EXTERNALSYM GL_DECR_WRAP_OES}

{  GL_OES_texture_cube_map }
  GL_NORMAL_MAP_OES = $8511;
  {$EXTERNALSYM GL_NORMAL_MAP_OES}
  GL_REFLECTION_MAP_OES = $8512;
  {$EXTERNALSYM GL_REFLECTION_MAP_OES}
  GL_TEXTURE_CUBE_MAP_OES = $8513;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_OES}
  GL_TEXTURE_BINDING_CUBE_MAP_OES = $8514;
  {$EXTERNALSYM GL_TEXTURE_BINDING_CUBE_MAP_OES}
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_OES = $8515;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_POSITIVE_X_OES}
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_OES = $8516;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_NEGATIVE_X_OES}
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_OES = $8517;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_POSITIVE_Y_OES}
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_OES = $8518;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_OES}
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_OES = $8519;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_POSITIVE_Z_OES}
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_OES = $851A;
  {$EXTERNALSYM GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_OES}
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_OES = $851C;
  {$EXTERNALSYM GL_MAX_CUBE_MAP_TEXTURE_SIZE_OES}
  GL_TEXTURE_GEN_MODE_OES = $2500;
  {$EXTERNALSYM GL_TEXTURE_GEN_MODE_OES}
  GL_TEXTURE_GEN_STR_OES = $8D60;
  {$EXTERNALSYM GL_TEXTURE_GEN_STR_OES}

{  GL_OES_texture_mirrored_repeat }
  GL_MIRRORED_REPEAT_OES = $8370;
  {$EXTERNALSYM GL_MIRRORED_REPEAT_OES}

{  GL_OES_vertex_array_object }
  GL_VERTEX_ARRAY_BINDING_OES = $85B5;
  {$EXTERNALSYM GL_VERTEX_ARRAY_BINDING_OES}

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
  ------------------------------------------------------------------------ }

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

{ ------------------------------------------------------------------------
   APPLE extension tokens
  ------------------------------------------------------------------------ }

{  GL_APPLE_texture_2D_limited_npot }
{  No new tokens introduced by this extension. }

{ ------------------------------------------------------------------------
   EXT extension tokens
  ------------------------------------------------------------------------ }

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

{  GL_EXT_texture_lod_bias }
  GL_MAX_TEXTURE_LOD_BIAS_EXT = $84FD;
  {$EXTERNALSYM GL_MAX_TEXTURE_LOD_BIAS_EXT}
  GL_TEXTURE_FILTER_CONTROL_EXT = $8500;
  {$EXTERNALSYM GL_TEXTURE_FILTER_CONTROL_EXT}
  GL_TEXTURE_LOD_BIAS_EXT = $8501;
  {$EXTERNALSYM GL_TEXTURE_LOD_BIAS_EXT}

{ ------------------------------------------------------------------------
   IMG extension tokens
  ------------------------------------------------------------------------ }

{  GL_IMG_read_format }
  GL_BGRA_IMG = $80E1;
  {$EXTERNALSYM GL_BGRA_IMG}
  GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG = $8365;
  {$EXTERNALSYM GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG}

{  GL_IMG_texture_compression_pvrtc }
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG = $8C00;
  {$EXTERNALSYM GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG}
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG = $8C01;
  {$EXTERNALSYM GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG}
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG = $8C02;
  {$EXTERNALSYM GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG}
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG = $8C03;
  {$EXTERNALSYM GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG}

{  GL_IMG_texture_env_enhanced_fixed_function }
  GL_MODULATE_COLOR_IMG = $8C04;
  {$EXTERNALSYM GL_MODULATE_COLOR_IMG}
  GL_RECIP_ADD_SIGNED_ALPHA_IMG = $8C05;
  {$EXTERNALSYM GL_RECIP_ADD_SIGNED_ALPHA_IMG}
  GL_TEXTURE_ALPHA_MODULATE_IMG = $8C06;
  {$EXTERNALSYM GL_TEXTURE_ALPHA_MODULATE_IMG}
  GL_FACTOR_ALPHA_MODULATE_IMG = $8C07;
  {$EXTERNALSYM GL_FACTOR_ALPHA_MODULATE_IMG}
  GL_FRAGMENT_ALPHA_MODULATE_IMG = $8C08;
  {$EXTERNALSYM GL_FRAGMENT_ALPHA_MODULATE_IMG}
  GL_ADD_BLEND_IMG = $8C09;
  {$EXTERNALSYM GL_ADD_BLEND_IMG}
  GL_DOT3_RGBA_IMG = $86AF;
  {$EXTERNALSYM GL_DOT3_RGBA_IMG}

{  GL_IMG_user_clip_plane }
  GL_CLIP_PLANE0_IMG = $3000;
  {$EXTERNALSYM GL_CLIP_PLANE0_IMG}
  GL_CLIP_PLANE1_IMG = $3001;
  {$EXTERNALSYM GL_CLIP_PLANE1_IMG}
  GL_CLIP_PLANE2_IMG = $3002;
  {$EXTERNALSYM GL_CLIP_PLANE2_IMG}
  GL_CLIP_PLANE3_IMG = $3003;
  {$EXTERNALSYM GL_CLIP_PLANE3_IMG}
  GL_CLIP_PLANE4_IMG = $3004;
  {$EXTERNALSYM GL_CLIP_PLANE4_IMG}
  GL_CLIP_PLANE5_IMG = $3005;
  {$EXTERNALSYM GL_CLIP_PLANE5_IMG}
  GL_MAX_CLIP_PLANES_IMG = $0D32;
  {$EXTERNALSYM GL_MAX_CLIP_PLANES_IMG}

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
  ------------------------------------------------------------------------ }

{  GL_NV_fence }
  GL_ALL_COMPLETED_NV = $84F2;
  {$EXTERNALSYM GL_ALL_COMPLETED_NV}
  GL_FENCE_STATUS_NV = $84F3;
  {$EXTERNALSYM GL_FENCE_STATUS_NV}
  GL_FENCE_CONDITION_NV = $84F4;
  {$EXTERNALSYM GL_FENCE_CONDITION_NV}

{ ------------------------------------------------------------------------
   QCOM extension tokens
  ------------------------------------------------------------------------ }

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
   End of extension tokens, start of corresponding extension functions
  ------------------------------------------------------------------------ }

{ ------------------------------------------------------------------------
   OES extension functions
  ------------------------------------------------------------------------ }
  
{  GL_OES_blend_equation_separate }
const
  GL_OES_blend_equation_separate = 1;
  {$EXTERNALSYM GL_OES_blend_equation_separate}

procedure glBlendEquationSeparateOES(modeRGB: GLenum; modeAlpha: GLenum); cdecl;
 external AndroidEglLib name 'glBlendEquationSeparateOES';
{$EXTERNALSYM glBlendEquationSeparateOES}

type
  PFNGLBLENDEQUATIONSEPARATEOESPROC = procedure(modeRGB: GLenum; modeAlpha: GLenum);
  {$EXTERNALSYM PFNGLBLENDEQUATIONSEPARATEOESPROC}

  
{  GL_OES_blend_func_separate }
const
  GL_OES_blend_func_separate = 1;
  {$EXTERNALSYM GL_OES_blend_func_separate}

procedure glBlendFuncSeparateOES(srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); cdecl;
 external AndroidEglLib name 'glBlendFuncSeparateOES';
{$EXTERNALSYM glBlendFuncSeparateOES}

type
  PFNGLBLENDFUNCSEPARATEOESPROC = procedure(srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);
  {$EXTERNALSYM PFNGLBLENDFUNCSEPARATEOESPROC}
  

{  GL_OES_blend_subtract }
const
  GL_OES_blend_subtract = 1;
  {$EXTERNALSYM GL_OES_blend_subtract}

procedure glBlendEquationOES(mode: GLenum); cdecl;
 external AndroidEglLib name 'glBlendEquationOES';
{$EXTERNALSYM glBlendEquationOES}

type
  PFNGLBLENDEQUATIONOESPROC = procedure(mode: GLenum);
  {$EXTERNALSYM PFNGLBLENDEQUATIONOESPROC}


{  GL_OES_byte_coordinates }
const
  GL_OES_byte_coordinates = 1;
  {$EXTERNALSYM GL_OES_byte_coordinates}

{  GL_OES_compressed_ETC1_RGB8_texture }
  GL_OES_compressed_ETC1_RGB8_texture = 1;
  {$EXTERNALSYM GL_OES_compressed_ETC1_RGB8_texture}

{  GL_OES_depth24 }
  GL_OES_depth24 = 1;
  {$EXTERNALSYM GL_OES_depth24}

{  GL_OES_depth32 }
  GL_OES_depth32 = 1;
  {$EXTERNALSYM GL_OES_depth32}

{  GL_OES_draw_texture }
  GL_OES_draw_texture = 1;
  {$EXTERNALSYM GL_OES_draw_texture}

procedure glDrawTexsOES(x: GLshort; y: GLshort; z: GLshort; width: GLshort; height: GLshort); cdecl;
 external AndroidEglLib name 'glDrawTexsOES';
{$EXTERNALSYM glDrawTexsOES}

procedure glDrawTexiOES(x: GLint; y: GLint; z: GLint; width: GLint; height: GLint); cdecl;
 external AndroidEglLib name 'glDrawTexiOES';
{$EXTERNALSYM glDrawTexiOES}

procedure glDrawTexxOES(x: GLfixed; y: GLfixed; z: GLfixed; width: GLfixed; height: GLfixed); cdecl;
 external AndroidEglLib name 'glDrawTexxOES';
{$EXTERNALSYM glDrawTexxOES}

procedure glDrawTexsvOES(const coords: PGLshort); cdecl;
 external AndroidEglLib name 'glDrawTexsvOES';
{$EXTERNALSYM glDrawTexsvOES}

procedure glDrawTexivOES(const coords: PGLint); cdecl;
 external AndroidEglLib name 'glDrawTexivOES';
{$EXTERNALSYM glDrawTexivOES}

procedure glDrawTexxvOES(const coords: PGLfixed); cdecl;
 external AndroidEglLib name 'glDrawTexxvOES';
{$EXTERNALSYM glDrawTexxvOES}

procedure glDrawTexfOES(x: GLfloat; y: GLfloat; z: GLfloat; width: GLfloat; height: GLfloat); cdecl;
 external AndroidEglLib name 'glDrawTexfOES';
{$EXTERNALSYM glDrawTexfOES}

procedure glDrawTexfvOES(const coords: PGLfloat); cdecl;
 external AndroidEglLib name 'glDrawTexfvOES';
{$EXTERNALSYM glDrawTexfvOES}

type
  PFNGLDRAWTEXSOESPROC = procedure(x: GLshort; y: GLshort; z: GLshort; width: GLshort; height: GLshort);
  {$EXTERNALSYM PFNGLDRAWTEXSOESPROC}
  PFNGLDRAWTEXIOESPROC = procedure(x: GLint; y: GLint; z: GLint; width: GLint; height: GLint);
  {$EXTERNALSYM PFNGLDRAWTEXIOESPROC}
  PFNGLDRAWTEXXOESPROC = procedure(x: GLfixed; y: GLfixed; z: GLfixed; width: GLfixed; height: GLfixed);
  {$EXTERNALSYM PFNGLDRAWTEXXOESPROC}
  PFNGLDRAWTEXSVOESPROC = procedure(const coords: PGLshort);
  {$EXTERNALSYM PFNGLDRAWTEXSVOESPROC}
  PFNGLDRAWTEXIVOESPROC = procedure(const coords: PGLint);
  {$EXTERNALSYM PFNGLDRAWTEXIVOESPROC}
  PFNGLDRAWTEXXVOESPROC = procedure(const coords: PGLfixed);
  {$EXTERNALSYM PFNGLDRAWTEXXVOESPROC}
  PFNGLDRAWTEXFOESPROC = procedure(x: GLfloat; y: GLfloat; z: GLfloat; width: GLfloat; height: GLfloat);
  {$EXTERNALSYM PFNGLDRAWTEXFOESPROC}
  PFNGLDRAWTEXFVOESPROC = procedure(const coords: PGLfloat);
  {$EXTERNALSYM PFNGLDRAWTEXFVOESPROC}


{  GL_OES_EGL_image }
const
  GL_OES_EGL_image = 1;
  {$EXTERNALSYM GL_OES_EGL_image}

procedure glEGLImageTargetTexture2DOES(target: GLenum; image: GLeglImageOES); cdecl;
 external AndroidEglLib name 'glEGLImageTargetTexture2DOES';
{$EXTERNALSYM glEGLImageTargetTexture2DOES}

procedure glEGLImageTargetRenderbufferStorageOES(target: GLenum; image: GLeglImageOES); cdecl;
 external AndroidEglLib name 'glEGLImageTargetRenderbufferStorageOES';
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

{  GL_OES_extended_matrix_palette }
  GL_OES_extended_matrix_palette = 1;
  {$EXTERNALSYM GL_OES_extended_matrix_palette}

{  GL_OES_fbo_render_mipmap }
  GL_OES_fbo_render_mipmap = 1;
  {$EXTERNALSYM GL_OES_fbo_render_mipmap}

{  GL_OES_fixed_point }
  GL_OES_fixed_point = 1;
  {$EXTERNALSYM GL_OES_fixed_point}

procedure glAlphaFuncxOES(func: GLenum; ref: GLclampx); cdecl;
 external AndroidEglLib name 'glAlphaFuncxOES';
{$EXTERNALSYM glAlphaFuncxOES}

procedure glClearColorxOES(red: GLclampx; green: GLclampx; blue: GLclampx; alpha: GLclampx); cdecl;
 external AndroidEglLib name 'glClearColorxOES';
{$EXTERNALSYM glClearColorxOES}

procedure glClearDepthxOES(depth: GLclampx); cdecl;
 external AndroidEglLib name 'glClearDepthxOES';
{$EXTERNALSYM glClearDepthxOES}

procedure glClipPlanexOES(plane: GLenum; const equation: PGLfixed); cdecl;
 external AndroidEglLib name 'glClipPlanexOES';
{$EXTERNALSYM glClipPlanexOES}

procedure glColor4xOES(red: GLfixed; green: GLfixed; blue: GLfixed; alpha: GLfixed); cdecl;
 external AndroidEglLib name 'glColor4xOES';
{$EXTERNALSYM glColor4xOES}

procedure glDepthRangexOES(zNear: GLclampx; zFar: GLclampx); cdecl;
 external AndroidEglLib name 'glDepthRangexOES';
{$EXTERNALSYM glDepthRangexOES}

procedure glFogxOES(pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glFogxOES';
{$EXTERNALSYM glFogxOES}

procedure glFogxvOES(pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glFogxvOES';
{$EXTERNALSYM glFogxvOES}

procedure glFrustumxOES(left: GLfixed; right: GLfixed; bottom: GLfixed; top: GLfixed; zNear: GLfixed; zFar: GLfixed); cdecl;
 external AndroidEglLib name 'glFrustumxOES';
{$EXTERNALSYM glFrustumxOES}

procedure glGetClipPlanexOES(pname: GLenum; eqn: PGLfixed{array [0..3]}); cdecl;
 external AndroidEglLib name 'glGetClipPlanexOES';
{$EXTERNALSYM glGetClipPlanexOES}

procedure glGetFixedvOES(pname: GLenum; params: PGLfixed); cdecl;
 external AndroidEglLib name 'glGetFixedvOES';
{$EXTERNALSYM glGetFixedvOES}

procedure glGetLightxvOES(light: GLenum; pname: GLenum; params: PGLfixed); cdecl;
 external AndroidEglLib name 'glGetLightxvOES';
{$EXTERNALSYM glGetLightxvOES}

procedure glGetMaterialxvOES(face: GLenum; pname: GLenum; params: PGLfixed); cdecl;
 external AndroidEglLib name 'glGetMaterialxvOES';
{$EXTERNALSYM glGetMaterialxvOES}

procedure glGetTexEnvxvOES(env: GLenum; pname: GLenum; params: PGLfixed); cdecl;
 external AndroidEglLib name 'glGetTexEnvxvOES';
{$EXTERNALSYM glGetTexEnvxvOES}

procedure glGetTexParameterxvOES(target: GLenum; pname: GLenum; params: PGLfixed); cdecl;
 external AndroidEglLib name 'glGetTexParameterxvOES';
{$EXTERNALSYM glGetTexParameterxvOES}

procedure glLightModelxOES(pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glLightModelxOES';
{$EXTERNALSYM glLightModelxOES}

procedure glLightModelxvOES(pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glLightModelxvOES';
{$EXTERNALSYM glLightModelxvOES}

procedure glLightxOES(light: GLenum; pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glLightxOES';
{$EXTERNALSYM glLightxOES}

procedure glLightxvOES(light: GLenum; pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glLightxvOES';
{$EXTERNALSYM glLightxvOES}

procedure glLineWidthxOES(width: GLfixed); cdecl;
 external AndroidEglLib name 'glLineWidthxOES';
{$EXTERNALSYM glLineWidthxOES}

procedure glLoadMatrixxOES(const m: PGLfixed); cdecl;
 external AndroidEglLib name 'glLoadMatrixxOES';
{$EXTERNALSYM glLoadMatrixxOES}

procedure glMaterialxOES(face: GLenum; pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glMaterialxOES';
{$EXTERNALSYM glMaterialxOES}

procedure glMaterialxvOES(face: GLenum; pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glMaterialxvOES';
{$EXTERNALSYM glMaterialxvOES}

procedure glMultMatrixxOES(const m: PGLfixed); cdecl;
 external AndroidEglLib name 'glMultMatrixxOES';
{$EXTERNALSYM glMultMatrixxOES}

procedure glMultiTexCoord4xOES(target: GLenum; s: GLfixed; t: GLfixed; r: GLfixed; q: GLfixed); cdecl;
 external AndroidEglLib name 'glMultiTexCoord4xOES';
{$EXTERNALSYM glMultiTexCoord4xOES}

procedure glNormal3xOES(nx: GLfixed; ny: GLfixed; nz: GLfixed); cdecl;
 external AndroidEglLib name 'glNormal3xOES';
{$EXTERNALSYM glNormal3xOES}

procedure glOrthoxOES(left: GLfixed; right: GLfixed; bottom: GLfixed; top: GLfixed; zNear: GLfixed; zFar: GLfixed); cdecl;
 external AndroidEglLib name 'glOrthoxOES';
{$EXTERNALSYM glOrthoxOES}

procedure glPointParameterxOES(pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glPointParameterxOES';
{$EXTERNALSYM glPointParameterxOES}

procedure glPointParameterxvOES(pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glPointParameterxvOES';
{$EXTERNALSYM glPointParameterxvOES}

procedure glPointSizexOES(size: GLfixed); cdecl;
 external AndroidEglLib name 'glPointSizexOES';
{$EXTERNALSYM glPointSizexOES}

procedure glPolygonOffsetxOES(factor: GLfixed; units: GLfixed); cdecl;
 external AndroidEglLib name 'glPolygonOffsetxOES';
{$EXTERNALSYM glPolygonOffsetxOES}

procedure glRotatexOES(angle: GLfixed; x: GLfixed; y: GLfixed; z: GLfixed); cdecl;
 external AndroidEglLib name 'glRotatexOES';
{$EXTERNALSYM glRotatexOES}

procedure glSampleCoveragexOES(value: GLclampx; invert: GLboolean); cdecl;
 external AndroidEglLib name 'glSampleCoveragexOES';
{$EXTERNALSYM glSampleCoveragexOES}

procedure glScalexOES(x: GLfixed; y: GLfixed; z: GLfixed); cdecl;
 external AndroidEglLib name 'glScalexOES';
{$EXTERNALSYM glScalexOES}

procedure glTexEnvxOES(target: GLenum; pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glTexEnvxOES';
{$EXTERNALSYM glTexEnvxOES}

procedure glTexEnvxvOES(target: GLenum; pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glTexEnvxvOES';
{$EXTERNALSYM glTexEnvxvOES}

procedure glTexParameterxOES(target: GLenum; pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glTexParameterxOES';
{$EXTERNALSYM glTexParameterxOES}

procedure glTexParameterxvOES(target: GLenum; pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glTexParameterxvOES';
{$EXTERNALSYM glTexParameterxvOES}

procedure glTranslatexOES(x: GLfixed; y: GLfixed; z: GLfixed); cdecl;
 external AndroidEglLib name 'glTranslatexOES';
{$EXTERNALSYM glTranslatexOES}

type
  PFNGLALPHAFUNCXOESPROC = procedure(func: GLenum; ref: GLclampx);
  {$EXTERNALSYM PFNGLALPHAFUNCXOESPROC}
  PFNGLCLEARCOLORXOESPROC = procedure(red: GLclampx; green: GLclampx; blue: GLclampx; alpha: GLclampx);
  {$EXTERNALSYM PFNGLCLEARCOLORXOESPROC}
  PFNGLCLEARDEPTHXOESPROC = procedure(depth: GLclampx);
  {$EXTERNALSYM PFNGLCLEARDEPTHXOESPROC}
  PFNGLCLIPPLANEXOESPROC = procedure(plane: GLenum; const equation: PGLfixed);
  {$EXTERNALSYM PFNGLCLIPPLANEXOESPROC}
  PFNGLCOLOR4XOESPROC = procedure(red: GLfixed; green: GLfixed; blue: GLfixed; alpha: GLfixed);
  {$EXTERNALSYM PFNGLCOLOR4XOESPROC}
  PFNGLDEPTHRANGEXOESPROC = procedure(zNear: GLclampx; zFar: GLclampx);
  {$EXTERNALSYM PFNGLDEPTHRANGEXOESPROC}
  PFNGLFOGXOESPROC = procedure(pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLFOGXOESPROC}
  PFNGLFOGXVOESPROC = procedure(pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLFOGXVOESPROC}
  PFNGLFRUSTUMXOESPROC = procedure(left: GLfixed; right: GLfixed; bottom: GLfixed; top: GLfixed; zNear: GLfixed; zFar: GLfixed);
  {$EXTERNALSYM PFNGLFRUSTUMXOESPROC}
  PFNGLGETCLIPPLANEXOESPROC = procedure(pname: GLenum; eqn: PGLfixed{array [0..3]});
  {$EXTERNALSYM PFNGLGETCLIPPLANEXOESPROC}
  PFNGLGETFIXEDVOESPROC = procedure(pname: GLenum; params: PGLfixed);
  {$EXTERNALSYM PFNGLGETFIXEDVOESPROC}
  PFNGLGETLIGHTXVOESPROC = procedure(light: GLenum; pname: GLenum; params: PGLfixed);
  {$EXTERNALSYM PFNGLGETLIGHTXVOESPROC}
  PFNGLGETMATERIALXVOESPROC = procedure(face: GLenum; pname: GLenum; params: PGLfixed);
  {$EXTERNALSYM PFNGLGETMATERIALXVOESPROC}
  PFNGLGETTEXENVXVOESPROC = procedure(env: GLenum; pname: GLenum; params: PGLfixed);
  {$EXTERNALSYM PFNGLGETTEXENVXVOESPROC}
  PFNGLGETTEXPARAMETERXVOESPROC = procedure(target: GLenum; pname: GLenum; params: PGLfixed);
  {$EXTERNALSYM PFNGLGETTEXPARAMETERXVOESPROC}
  PFNGLLIGHTMODELXOESPROC = procedure(pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLLIGHTMODELXOESPROC}
  PFNGLLIGHTMODELXVOESPROC = procedure(pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLLIGHTMODELXVOESPROC}
  PFNGLLIGHTXOESPROC = procedure(light: GLenum; pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLLIGHTXOESPROC}
  PFNGLLIGHTXVOESPROC = procedure(light: GLenum; pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLLIGHTXVOESPROC}
  PFNGLLINEWIDTHXOESPROC = procedure(width: GLfixed);
  {$EXTERNALSYM PFNGLLINEWIDTHXOESPROC}
  PFNGLLOADMATRIXXOESPROC = procedure(const m: PGLfixed);
  {$EXTERNALSYM PFNGLLOADMATRIXXOESPROC}
  PFNGLMATERIALXOESPROC = procedure(face: GLenum; pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLMATERIALXOESPROC}
  PFNGLMATERIALXVOESPROC = procedure(face: GLenum; pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLMATERIALXVOESPROC}
  PFNGLMULTMATRIXXOESPROC = procedure(const m: PGLfixed);
  {$EXTERNALSYM PFNGLMULTMATRIXXOESPROC}
  PFNGLMULTITEXCOORD4XOESPROC = procedure(target: GLenum; s: GLfixed; t: GLfixed; r: GLfixed; q: GLfixed);
  {$EXTERNALSYM PFNGLMULTITEXCOORD4XOESPROC}
  PFNGLNORMAL3XOESPROC = procedure(nx: GLfixed; ny: GLfixed; nz: GLfixed);
  {$EXTERNALSYM PFNGLNORMAL3XOESPROC}
  PFNGLORTHOXOESPROC = procedure(left: GLfixed; right: GLfixed; bottom: GLfixed; top: GLfixed; zNear: GLfixed; zFar: GLfixed);
  {$EXTERNALSYM PFNGLORTHOXOESPROC}
  PFNGLPOINTPARAMETERXOESPROC = procedure(pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLPOINTPARAMETERXOESPROC}
  PFNGLPOINTPARAMETERXVOESPROC = procedure(pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLPOINTPARAMETERXVOESPROC}
  PFNGLPOINTSIZEXOESPROC = procedure(size: GLfixed);
  {$EXTERNALSYM PFNGLPOINTSIZEXOESPROC}
  PFNGLPOLYGONOFFSETXOESPROC = procedure(factor: GLfixed; units: GLfixed);
  {$EXTERNALSYM PFNGLPOLYGONOFFSETXOESPROC}
  PFNGLROTATEXOESPROC = procedure(angle: GLfixed; x: GLfixed; y: GLfixed; z: GLfixed);
  {$EXTERNALSYM PFNGLROTATEXOESPROC}
  PFNGLSAMPLECOVERAGEXOESPROC = procedure(value: GLclampx; invert: GLboolean);
  {$EXTERNALSYM PFNGLSAMPLECOVERAGEXOESPROC}
  PFNGLSCALEXOESPROC = procedure(x: GLfixed; y: GLfixed; z: GLfixed);
  {$EXTERNALSYM PFNGLSCALEXOESPROC}
  PFNGLTEXENVXOESPROC = procedure(target: GLenum; pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLTEXENVXOESPROC}
  PFNGLTEXENVXVOESPROC = procedure(target: GLenum; pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLTEXENVXVOESPROC}
  PFNGLTEXPARAMETERXOESPROC = procedure(target: GLenum; pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLTEXPARAMETERXOESPROC}
  PFNGLTEXPARAMETERXVOESPROC = procedure(target: GLenum; pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLTEXPARAMETERXVOESPROC}
  PFNGLTRANSLATEXOESPROC = procedure(x: GLfixed; y: GLfixed; z: GLfixed);
  {$EXTERNALSYM PFNGLTRANSLATEXOESPROC}

const
{  GL_OES_framebuffer_object }
  GL_OES_framebuffer_object = 1;
  {$EXTERNALSYM GL_OES_framebuffer_object}

function glIsRenderbufferOES (renderbuffer: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glIsRenderbufferOES';
{$EXTERNALSYM glIsRenderbufferOES}

procedure glBindRenderbufferOES(target: GLenum; renderbuffer: GLuint); cdecl;
 external AndroidEglLib name 'glBindRenderbufferOES';
{$EXTERNALSYM glBindRenderbufferOES}

procedure glDeleteRenderbuffersOES(n: GLsizei; const renderbuffers: PGLuint); cdecl;
 external AndroidEglLib name 'glDeleteRenderbuffersOES';
{$EXTERNALSYM glDeleteRenderbuffersOES}

procedure glGenRenderbuffersOES(n: GLsizei; renderbuffers: PGLuint); cdecl;
 external AndroidEglLib name 'glGenRenderbuffersOES';
{$EXTERNALSYM glGenRenderbuffersOES}

procedure glRenderbufferStorageOES(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); cdecl;
 external AndroidEglLib name 'glRenderbufferStorageOES';
{$EXTERNALSYM glRenderbufferStorageOES}

procedure glGetRenderbufferParameterivOES(target: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidEglLib name 'glGetRenderbufferParameterivOES';
{$EXTERNALSYM glGetRenderbufferParameterivOES}

function glIsFramebufferOES (framebuffer: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glIsFramebufferOES';
{$EXTERNALSYM glIsFramebufferOES}

procedure glBindFramebufferOES(target: GLenum; framebuffer: GLuint); cdecl;
 external AndroidEglLib name 'glBindFramebufferOES';
{$EXTERNALSYM glBindFramebufferOES}

procedure glDeleteFramebuffersOES(n: GLsizei; const framebuffers: PGLuint); cdecl;
 external AndroidEglLib name 'glDeleteFramebuffersOES';
{$EXTERNALSYM glDeleteFramebuffersOES}

procedure glGenFramebuffersOES(n: GLsizei; framebuffers: PGLuint); cdecl;
 external AndroidEglLib name 'glGenFramebuffersOES';
{$EXTERNALSYM glGenFramebuffersOES}

function glCheckFramebufferStatusOES (target: GLenum): GLenum; cdecl;
 external AndroidEglLib name 'glCheckFramebufferStatusOES';
{$EXTERNALSYM glCheckFramebufferStatusOES}

procedure glFramebufferRenderbufferOES(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); cdecl;
 external AndroidEglLib name 'glFramebufferRenderbufferOES';
{$EXTERNALSYM glFramebufferRenderbufferOES}

procedure glFramebufferTexture2DOES(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); cdecl;
 external AndroidEglLib name 'glFramebufferTexture2DOES';
{$EXTERNALSYM glFramebufferTexture2DOES}

procedure glGetFramebufferAttachmentParameterivOES(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidEglLib name 'glGetFramebufferAttachmentParameterivOES';
{$EXTERNALSYM glGetFramebufferAttachmentParameterivOES}

procedure glGenerateMipmapOES(target: GLenum); cdecl;
 external AndroidEglLib name 'glGenerateMipmapOES';
{$EXTERNALSYM glGenerateMipmapOES}

type
  PFNGLISRENDERBUFFEROESPROC = function(renderbuffer: GLuint): GLboolean;
  {$EXTERNALSYM PFNGLISRENDERBUFFEROESPROC}
  PFNGLBINDRENDERBUFFEROESPROC = procedure(target: GLenum; renderbuffer: GLuint);
  {$EXTERNALSYM PFNGLBINDRENDERBUFFEROESPROC}
  PFNGLDELETERENDERBUFFERSOESPROC = procedure(n: GLsizei; const renderbuffers: PGLuint);
  {$EXTERNALSYM PFNGLDELETERENDERBUFFERSOESPROC}
  PFNGLGENRENDERBUFFERSOESPROC = procedure(n: GLsizei; renderbuffers: PGLuint);
  {$EXTERNALSYM PFNGLGENRENDERBUFFERSOESPROC}
  PFNGLRENDERBUFFERSTORAGEOESPROC = procedure(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei);
  {$EXTERNALSYM PFNGLRENDERBUFFERSTORAGEOESPROC}
  PFNGLGETRENDERBUFFERPARAMETERIVOESPROC = procedure(target: GLenum; pname: GLenum; params: PGLint);
  {$EXTERNALSYM PFNGLGETRENDERBUFFERPARAMETERIVOESPROC}
  PFNGLISFRAMEBUFFEROESPROC = function(framebuffer: GLuint): GLboolean;
  {$EXTERNALSYM PFNGLISFRAMEBUFFEROESPROC}
  PFNGLBINDFRAMEBUFFEROESPROC = procedure(target: GLenum; framebuffer: GLuint);
  {$EXTERNALSYM PFNGLBINDFRAMEBUFFEROESPROC}
  PFNGLDELETEFRAMEBUFFERSOESPROC = procedure(n: GLsizei; const framebuffers: PGLuint);
  {$EXTERNALSYM PFNGLDELETEFRAMEBUFFERSOESPROC}
  PFNGLGENFRAMEBUFFERSOESPROC = procedure(n: GLsizei; framebuffers: PGLuint);
  {$EXTERNALSYM PFNGLGENFRAMEBUFFERSOESPROC}
  PFNGLCHECKFRAMEBUFFERSTATUSOESPROC = function(target: GLenum): GLenum;
  {$EXTERNALSYM PFNGLCHECKFRAMEBUFFERSTATUSOESPROC}
  PFNGLFRAMEBUFFERRENDERBUFFEROESPROC = procedure(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  {$EXTERNALSYM PFNGLFRAMEBUFFERRENDERBUFFEROESPROC}
  PFNGLFRAMEBUFFERTEXTURE2DOESPROC = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  {$EXTERNALSYM PFNGLFRAMEBUFFERTEXTURE2DOESPROC}
  PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVOESPROC = procedure(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint);
  {$EXTERNALSYM PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVOESPROC}
  PFNGLGENERATEMIPMAPOESPROC = procedure(target: GLenum);
  {$EXTERNALSYM PFNGLGENERATEMIPMAPOESPROC}

const
{  GL_OES_mapbuffer }
  GL_OES_mapbuffer = 1;
  {$EXTERNALSYM GL_OES_mapbuffer}

function glMapBufferOES(target: GLenum; access: GLenum): Pointer; cdecl;
 external AndroidEglLib name 'glMapBufferOES';
{$EXTERNALSYM glMapBufferOES}

function glUnmapBufferOES (target: GLenum): GLboolean; cdecl;
 external AndroidEglLib name 'glUnmapBufferOES';
{$EXTERNALSYM glUnmapBufferOES}

procedure glGetBufferPointervOES(target: GLenum; pname: GLenum; params: PPGLvoid); cdecl;
 external AndroidEglLib name 'glGetBufferPointervOES';
{$EXTERNALSYM glGetBufferPointervOES}

type
  PFNGLMAPBUFFEROESPROC = function(target: GLenum; access: GLenum): Pointer;
  {$EXTERNALSYM PFNGLMAPBUFFEROESPROC}
  PFNGLUNMAPBUFFEROESPROC = function(target: GLenum): GLboolean;
  {$EXTERNALSYM PFNGLUNMAPBUFFEROESPROC}
  PFNGLGETBUFFERPOINTERVOESPROC = procedure(target: GLenum; pname: GLenum; params: PPGLvoid);
  {$EXTERNALSYM PFNGLGETBUFFERPOINTERVOESPROC}

const
{  GL_OES_matrix_get }
  GL_OES_matrix_get = 1;
  {$EXTERNALSYM GL_OES_matrix_get}

{  GL_OES_matrix_palette }
  GL_OES_matrix_palette = 1;
  {$EXTERNALSYM GL_OES_matrix_palette}

procedure glCurrentPaletteMatrixOES(matrixpaletteindex: GLuint); cdecl;
 external AndroidEglLib name 'glCurrentPaletteMatrixOES';
{$EXTERNALSYM glCurrentPaletteMatrixOES}

procedure glLoadPaletteFromModelViewMatrixOES; cdecl;
 external AndroidEglLib name 'glLoadPaletteFromModelViewMatrixOES';
{$EXTERNALSYM glLoadPaletteFromModelViewMatrixOES}

procedure glMatrixIndexPointerOES(size: GLint; _type: GLenum; stride: GLsizei; const pointer: PGLvoid); cdecl;
 external AndroidEglLib name 'glMatrixIndexPointerOES';
{$EXTERNALSYM glMatrixIndexPointerOES}

procedure glWeightPointerOES(size: GLint; _type: GLenum; stride: GLsizei; const pointer: PGLvoid); cdecl;
 external AndroidEglLib name 'glWeightPointerOES';
{$EXTERNALSYM glWeightPointerOES}

type
    PFNGLCURRENTPALETTEMATRIXOESPROC = procedure(matrixpaletteindex: GLuint);
  {$EXTERNALSYM PFNGLCURRENTPALETTEMATRIXOESPROC}
    PFNGLLOADPALETTEFROMMODELVIEWMATRIXOESPROC = procedure;
  {$EXTERNALSYM PFNGLLOADPALETTEFROMMODELVIEWMATRIXOESPROC}
    PFNGLMATRIXINDEXPOINTEROESPROC = procedure(size: GLint; _type: GLenum; stride: GLsizei; const pointer: PGLvoid);
  {$EXTERNALSYM PFNGLMATRIXINDEXPOINTEROESPROC}
    PFNGLWEIGHTPOINTEROESPROC = procedure(size: GLint; _type: GLenum; stride: GLsizei; const pointer: PGLvoid);
  {$EXTERNALSYM PFNGLWEIGHTPOINTEROESPROC}

const
{  GL_OES_packed_depth_stencil }
  GL_OES_packed_depth_stencil = 1;
  {$EXTERNALSYM GL_OES_packed_depth_stencil}

{  GL_OES_query_matrix }
  GL_OES_query_matrix = 1;
  {$EXTERNALSYM GL_OES_query_matrix}
  
function glQueryMatrixxOES (mantissa: PGLfixed{array [0..15]}; exponent: PGLfixed{array [0..15]}): GLbitfield; cdecl;
 external AndroidEglLib name 'glQueryMatrixxOES';
{$EXTERNALSYM glQueryMatrixxOES}

type
  PFNGLQUERYMATRIXXOESPROC = function(mantissa: PGLfixed{array [0..15]}; exponent: PGLfixed{array [0..15]}): GLbitfield;
  {$EXTERNALSYM PFNGLQUERYMATRIXXOESPROC}

const
{  GL_OES_rgb8_rgba8 }
  GL_OES_rgb8_rgba8 = 1;
  {$EXTERNALSYM GL_OES_rgb8_rgba8}

{  GL_OES_single_precision }
  GL_OES_single_precision = 1;
  {$EXTERNALSYM GL_OES_single_precision}


procedure glDepthRangefOES(zNear: GLclampf; zFar: GLclampf); cdecl;
 external AndroidEglLib name 'glDepthRangefOES';
{$EXTERNALSYM glDepthRangefOES}

procedure glFrustumfOES(left: GLfloat; right: GLfloat; bottom: GLfloat; top: GLfloat; zNear: GLfloat; zFar: GLfloat); cdecl;
 external AndroidEglLib name 'glFrustumfOES';
{$EXTERNALSYM glFrustumfOES}

procedure glOrthofOES(left: GLfloat; right: GLfloat; bottom: GLfloat; top: GLfloat; zNear: GLfloat; zFar: GLfloat); cdecl;
 external AndroidEglLib name 'glOrthofOES';
{$EXTERNALSYM glOrthofOES}

procedure glClipPlanefOES(plane: GLenum; const equation: PGLfloat); cdecl;
 external AndroidEglLib name 'glClipPlanefOES';
{$EXTERNALSYM glClipPlanefOES}

procedure glGetClipPlanefOES(pname: GLenum; eqn: PGLfloat{array [0..3]}); cdecl;
 external AndroidEglLib name 'glGetClipPlanefOES';
{$EXTERNALSYM glGetClipPlanefOES}

procedure glClearDepthfOES(depth: GLclampf); cdecl;
 external AndroidEglLib name 'glClearDepthfOES';
{$EXTERNALSYM glClearDepthfOES}

type
  PFNGLDEPTHRANGEFOESPROC = procedure(zNear: GLclampf; zFar: GLclampf);
  {$EXTERNALSYM PFNGLDEPTHRANGEFOESPROC}
  PFNGLFRUSTUMFOESPROC = procedure(left: GLfloat; right: GLfloat; bottom: GLfloat; top: GLfloat; zNear: GLfloat; zFar: GLfloat);
  {$EXTERNALSYM PFNGLFRUSTUMFOESPROC}
  PFNGLORTHOFOESPROC = procedure(left: GLfloat; right: GLfloat; bottom: GLfloat; top: GLfloat; zNear: GLfloat; zFar: GLfloat);
  {$EXTERNALSYM PFNGLORTHOFOESPROC}
  PFNGLCLIPPLANEFOESPROC = procedure(plane: GLenum; const equation: PGLfloat);
  {$EXTERNALSYM PFNGLCLIPPLANEFOESPROC}
  PFNGLGETCLIPPLANEFOESPROC = procedure(pname: GLenum; eqn: PGLfloat{array [0..3]});
  {$EXTERNALSYM PFNGLGETCLIPPLANEFOESPROC}
  PFNGLCLEARDEPTHFOESPROC = procedure(depth: GLclampf);
  {$EXTERNALSYM PFNGLCLEARDEPTHFOESPROC}

const
{  GL_OES_stencil1 }
  GL_OES_stencil1 = 1;
  {$EXTERNALSYM GL_OES_stencil1}

{  GL_OES_stencil4 }
  GL_OES_stencil4 = 1;
  {$EXTERNALSYM GL_OES_stencil4}

{  GL_OES_stencil8 }
  GL_OES_stencil8 = 1;
  {$EXTERNALSYM GL_OES_stencil8}

{  GL_OES_stencil_wrap }
  GL_OES_stencil_wrap = 1;
  {$EXTERNALSYM GL_OES_stencil_wrap}

{  GL_OES_texture_cube_map }
  GL_OES_texture_cube_map = 1;
  {$EXTERNALSYM GL_OES_texture_cube_map}

procedure glTexGenfOES(coord: GLenum; pname: GLenum; param: GLfloat); cdecl;
 external AndroidEglLib name 'glTexGenfOES';
{$EXTERNALSYM glTexGenfOES}

procedure glTexGenfvOES(coord: GLenum; pname: GLenum; const params: PGLfloat); cdecl;
 external AndroidEglLib name 'glTexGenfvOES';
{$EXTERNALSYM glTexGenfvOES}

procedure glTexGeniOES(coord: GLenum; pname: GLenum; param: GLint); cdecl;
 external AndroidEglLib name 'glTexGeniOES';
{$EXTERNALSYM glTexGeniOES}

procedure glTexGenivOES(coord: GLenum; pname: GLenum; const params: PGLint); cdecl;
 external AndroidEglLib name 'glTexGenivOES';
{$EXTERNALSYM glTexGenivOES}

procedure glTexGenxOES(coord: GLenum; pname: GLenum; param: GLfixed); cdecl;
 external AndroidEglLib name 'glTexGenxOES';
{$EXTERNALSYM glTexGenxOES}

procedure glTexGenxvOES(coord: GLenum; pname: GLenum; const params: PGLfixed); cdecl;
 external AndroidEglLib name 'glTexGenxvOES';
{$EXTERNALSYM glTexGenxvOES}

procedure glGetTexGenfvOES(coord: GLenum; pname: GLenum; params: PGLfloat); cdecl;
 external AndroidEglLib name 'glGetTexGenfvOES';
{$EXTERNALSYM glGetTexGenfvOES}

procedure glGetTexGenivOES(coord: GLenum; pname: GLenum; params: PGLint); cdecl;
 external AndroidEglLib name 'glGetTexGenivOES';
{$EXTERNALSYM glGetTexGenivOES}

procedure glGetTexGenxvOES(coord: GLenum; pname: GLenum; params: PGLfixed); cdecl;
 external AndroidEglLib name 'glGetTexGenxvOES';
{$EXTERNALSYM glGetTexGenxvOES}

type
  PFNGLTEXGENFOESPROC = procedure(coord: GLenum; pname: GLenum; param: GLfloat);
  {$EXTERNALSYM PFNGLTEXGENFOESPROC}
  PFNGLTEXGENFVOESPROC = procedure(coord: GLenum; pname: GLenum; const params: PGLfloat);
  {$EXTERNALSYM PFNGLTEXGENFVOESPROC}
  PFNGLTEXGENIOESPROC = procedure(coord: GLenum; pname: GLenum; param: GLint);
  {$EXTERNALSYM PFNGLTEXGENIOESPROC}
  PFNGLTEXGENIVOESPROC = procedure(coord: GLenum; pname: GLenum; const params: PGLint);
  {$EXTERNALSYM PFNGLTEXGENIVOESPROC}
  PFNGLTEXGENXOESPROC = procedure(coord: GLenum; pname: GLenum; param: GLfixed);
  {$EXTERNALSYM PFNGLTEXGENXOESPROC}
  PFNGLTEXGENXVOESPROC = procedure(coord: GLenum; pname: GLenum; const params: PGLfixed);
  {$EXTERNALSYM PFNGLTEXGENXVOESPROC}
  PFNGLGETTEXGENFVOESPROC = procedure(coord: GLenum; pname: GLenum; params: PGLfloat);
  {$EXTERNALSYM PFNGLGETTEXGENFVOESPROC}
  PFNGLGETTEXGENIVOESPROC = procedure(coord: GLenum; pname: GLenum; params: PGLint);
  {$EXTERNALSYM PFNGLGETTEXGENIVOESPROC}
  PFNGLGETTEXGENXVOESPROC = procedure(coord: GLenum; pname: GLenum; params: PGLfixed);
  {$EXTERNALSYM PFNGLGETTEXGENXVOESPROC}

const
{  GL_OES_texture_env_crossbar }
  GL_OES_texture_env_crossbar = 1;
  {$EXTERNALSYM GL_OES_texture_env_crossbar}

{  GL_OES_texture_mirrored_repeat }
  GL_OES_texture_mirrored_repeat = 1;
  {$EXTERNALSYM GL_OES_texture_mirrored_repeat}

{  GL_OES_vertex_array_object }
  GL_OES_vertex_array_object = 1;
  {$EXTERNALSYM GL_OES_vertex_array_object}

{procedure glBindVertexArrayOES(_array: GLuint); cdecl;
 external AndroidEglLib name 'glBindVertexArrayOES';
{$EXTERNALSYM glBindVertexArrayOES}

{procedure glDeleteVertexArraysOES(n: GLsizei; const arrays: PGLuint); cdecl;
 external AndroidEglLib name 'glDeleteVertexArraysOES';
{$EXTERNALSYM glDeleteVertexArraysOES}

{procedure glGenVertexArraysOES(n: GLsizei; arrays: PGLuint); cdecl;
 external AndroidEglLib name 'glGenVertexArraysOES';
{$EXTERNALSYM glGenVertexArraysOES}
{
function glIsVertexArrayOES (_array: GLuint): GLboolean; cdecl;
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
{  GL_OES_EGL_image_external }
  GL_OES_EGL_image_external = 1;
  {$EXTERNALSYM GL_OES_EGL_image_external}

{ ------------------------------------------------------------------------
   AMD extension functions
  ------------------------------------------------------------------------ }

{  GL_AMD_compressed_3DC_texture }
  GL_AMD_compressed_3DC_texture = 1;
  {$EXTERNALSYM GL_AMD_compressed_3DC_texture}

{  GL_AMD_compressed_ATC_texture }
  GL_AMD_compressed_ATC_texture = 1;
  {$EXTERNALSYM GL_AMD_compressed_ATC_texture}

{ ------------------------------------------------------------------------
   APPLE extension functions
  ------------------------------------------------------------------------ }

{  GL_APPLE_texture_2D_limited_npot }
  GL_APPLE_texture_2D_limited_npot = 1;
  {$EXTERNALSYM GL_APPLE_texture_2D_limited_npot}

{ ------------------------------------------------------------------------
   EXT extension functions
  ------------------------------------------------------------------------ }

{  GL_EXT_blend_minmax }
  GL_EXT_blend_minmax = 1;
  {$EXTERNALSYM GL_EXT_blend_minmax}

{  GL_EXT_discard_framebuffer }
  GL_EXT_discard_framebuffer = 1;
  {$EXTERNALSYM GL_EXT_discard_framebuffer}


{procedure glDiscardFramebufferEXT(target: GLenum; numAttachments: GLsizei; const attachments: PGLenum); cdecl;
 external AndroidEglLib name 'glDiscardFramebufferEXT';
{$EXTERNALSYM glDiscardFramebufferEXT}

 {type
 PFNGLDISCARDFRAMEBUFFEREXTPROC = procedure(target: GLenum; numAttachments: GLsizei; const attachments: PGLenum);
  {$EXTERNALSYM PFNGLDISCARDFRAMEBUFFEREXTPROC}

const
{  GL_EXT_multi_draw_arrays }
  GL_EXT_multi_draw_arrays = 1;
  {$EXTERNALSYM GL_EXT_multi_draw_arrays}


{procedure glMultiDrawArraysEXT(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei); cdecl;
 external AndroidEglLib name 'glMultiDrawArraysEXT';
{$EXTERNALSYM glMultiDrawArraysEXT}

{procedure glMultiDrawElementsEXT(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: PPGLvoid; primcount: GLsizei); cdecl;
 external AndroidEglLib name 'glMultiDrawElementsEXT';
{$EXTERNALSYM glMultiDrawElementsEXT}

{type
  {PFNGLMULTIDRAWARRAYSEXTPROC = procedure(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei);
  {$EXTERNALSYM PFNGLMULTIDRAWARRAYSEXTPROC}
  {PFNGLMULTIDRAWELEMENTSEXTPROC = procedure(mode: GLenum; const count: PGLsizei; _type: GLenum; const indices: PPGLvoid; primcount: GLsizei);
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

{  GL_EXT_texture_lod_bias }
  GL_EXT_texture_lod_bias = 1;
  {$EXTERNALSYM GL_EXT_texture_lod_bias}

{ ------------------------------------------------------------------------
   IMG extension functions
  ------------------------------------------------------------------------ }

{  GL_IMG_read_format }
  GL_IMG_read_format = 1;
  {$EXTERNALSYM GL_IMG_read_format}

{  GL_IMG_texture_compression_pvrtc }
  GL_IMG_texture_compression_pvrtc = 1;
  {$EXTERNALSYM GL_IMG_texture_compression_pvrtc}

{  GL_IMG_texture_env_enhanced_fixed_function }
  GL_IMG_texture_env_enhanced_fixed_function = 1;
  {$EXTERNALSYM GL_IMG_texture_env_enhanced_fixed_function}

{  GL_IMG_user_clip_plane }
  GL_IMG_user_clip_plane = 1;
  {$EXTERNALSYM GL_IMG_user_clip_plane}

{procedure glClipPlanefIMG(p: GLenum; const eqn: PGLfloat); cdecl;
 external AndroidEglLib name 'glClipPlanefIMG';
{$EXTERNALSYM glClipPlanefIMG}

{procedure glClipPlanexIMG(p: GLenum; const eqn: PGLfixed); cdecl;
 external AndroidEglLib name 'glClipPlanexIMG';
{$EXTERNALSYM glClipPlanexIMG}

{type
  {PFNGLCLIPPLANEFIMGPROC = procedure(p: GLenum; const eqn: PGLfloat);
  {$EXTERNALSYM PFNGLCLIPPLANEFIMGPROC}
  {PFNGLCLIPPLANEXIMGPROC = procedure(p: GLenum; const eqn: PGLfixed);
  {$EXTERNALSYM PFNGLCLIPPLANEXIMGPROC}

const
{  GL_IMG_multisampled_render_to_texture }
  GL_IMG_multisampled_render_to_texture = 1;
  {$EXTERNALSYM GL_IMG_multisampled_render_to_texture}

{procedure glRenderbufferStorageMultisampleIMG(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); cdecl;
 external AndroidEglLib name 'glRenderbufferStorageMultisampleIMG';
{$EXTERNALSYM glRenderbufferStorageMultisampleIMG}

{procedure glFramebufferTexture2DMultisampleIMG(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; samples: GLsizei); cdecl;
 external AndroidEglLib name 'glFramebufferTexture2DMultisampleIMG';
{$EXTERNALSYM glFramebufferTexture2DMultisampleIMG}

{type
  {PFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMG = procedure(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  {$EXTERNALSYM PFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMG}
  {PFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMG = procedure(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; samples: GLsizei);
  {$EXTERNALSYM PFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMG}

{ ------------------------------------------------------------------------
   NV extension functions
  ------------------------------------------------------------------------ }
const
{  NV_fence }
  GL_NV_fence = 1;
  {$EXTERNALSYM GL_NV_fence}

{procedure glDeleteFencesNV(n: GLsizei; const fences: PGLuint); cdecl;
 external AndroidEglLib name 'glDeleteFencesNV';
{$EXTERNALSYM glDeleteFencesNV}

{procedure glGenFencesNV(n: GLsizei; fences: PGLuint); cdecl;
 external AndroidEglLib name 'glGenFencesNV';
{$EXTERNALSYM glGenFencesNV}

{function glIsFenceNV (fence: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glIsFenceNV';
{$EXTERNALSYM glIsFenceNV}

{function glTestFenceNV (fence: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glTestFenceNV';
{$EXTERNALSYM glTestFenceNV}

{procedure glGetFenceivNV(fence: GLuint; pname: GLenum; params: PGLint); cdecl;
 external AndroidEglLib name 'glGetFenceivNV';
{$EXTERNALSYM glGetFenceivNV}

{procedure glFinishFenceNV(fence: GLuint); cdecl;
 external AndroidEglLib name 'glFinishFenceNV';
{$EXTERNALSYM glFinishFenceNV}

{procedure glSetFenceNV(fence: GLuint; condition: GLenum); cdecl;
 external AndroidEglLib name 'glSetFenceNV';
{$EXTERNALSYM glSetFenceNV}

{type
  PFNGLDELETEFENCESNVPROC = procedure(n: GLsizei; const fences: PGLuint);
  {$EXTERNALSYM PFNGLDELETEFENCESNVPROC}
  {PFNGLGENFENCESNVPROC = procedure(n: GLsizei; fences: PGLuint);
  {$EXTERNALSYM PFNGLGENFENCESNVPROC}
  {PFNGLISFENCENVPROC = function(fence: GLuint): GLboolean;
  {$EXTERNALSYM PFNGLISFENCENVPROC}
  {PFNGLTESTFENCENVPROC = function(fence: GLuint): GLboolean;
  {$EXTERNALSYM PFNGLTESTFENCENVPROC}
  {PFNGLGETFENCEIVNVPROC = procedure(fence: GLuint; pname: GLenum; params: PGLint);
  {$EXTERNALSYM PFNGLGETFENCEIVNVPROC}
  {PFNGLFINISHFENCENVPROC = procedure(fence: GLuint);
  {$EXTERNALSYM PFNGLFINISHFENCENVPROC}
  {PFNGLSETFENCENVPROC = procedure(fence: GLuint; condition: GLenum);
  {$EXTERNALSYM PFNGLSETFENCENVPROC}

{ ------------------------------------------------------------------------
   QCOM extension functions
  ------------------------------------------------------------------------ }
const
{  GL_QCOM_driver_control }
  GL_QCOM_driver_control = 1;
  {$EXTERNALSYM GL_QCOM_driver_control}

{procedure glGetDriverControlsQCOM(num: PGLint; size: GLsizei; driverControls: PGLuint); cdecl;
 external AndroidEglLib name 'glGetDriverControlsQCOM';
{$EXTERNALSYM glGetDriverControlsQCOM}

{procedure glGetDriverControlStringQCOM(driverControl: GLuint; bufSize: GLsizei; length: PGLsizei; driverControlString: PGLchar); cdecl;
 external AndroidEglLib name 'glGetDriverControlStringQCOM';
{$EXTERNALSYM glGetDriverControlStringQCOM}

{procedure glEnableDriverControlQCOM(driverControl: GLuint); cdecl;
 external AndroidEglLib name 'glEnableDriverControlQCOM';
{$EXTERNALSYM glEnableDriverControlQCOM}

{procedure glDisableDriverControlQCOM(driverControl: GLuint); cdecl;
 external AndroidEglLib name 'glDisableDriverControlQCOM';
{$EXTERNALSYM glDisableDriverControlQCOM}

{type
  {PFNGLGETDRIVERCONTROLSQCOMPROC = procedure(num: PGLint; size: GLsizei; driverControls: PGLuint);
  {$EXTERNALSYM PFNGLGETDRIVERCONTROLSQCOMPROC}
  {PFNGLGETDRIVERCONTROLSTRINGQCOMPROC = procedure(driverControl: GLuint; bufSize: GLsizei; length: PGLsizei; driverControlString: PGLchar);
  {$EXTERNALSYM PFNGLGETDRIVERCONTROLSTRINGQCOMPROC}
  {PFNGLENABLEDRIVERCONTROLQCOMPROC = procedure(driverControl: GLuint);
  {$EXTERNALSYM PFNGLENABLEDRIVERCONTROLQCOMPROC}
  {PFNGLDISABLEDRIVERCONTROLQCOMPROC = procedure(driverControl: GLuint);
  {$EXTERNALSYM PFNGLDISABLEDRIVERCONTROLQCOMPROC}

const
{  GL_QCOM_extended_get }
  GL_QCOM_extended_get = 1;
  {$EXTERNALSYM GL_QCOM_extended_get}

{procedure glExtGetTexturesQCOM(textures: PGLuint; maxTextures: GLint; numTextures: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetTexturesQCOM';
{$EXTERNALSYM glExtGetTexturesQCOM}

{procedure glExtGetBuffersQCOM(buffers: PGLuint; maxBuffers: GLint; numBuffers: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetBuffersQCOM';
{$EXTERNALSYM glExtGetBuffersQCOM}

{procedure glExtGetRenderbuffersQCOM(renderbuffers: PGLuint; maxRenderbuffers: GLint; numRenderbuffers: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetRenderbuffersQCOM';
{$EXTERNALSYM glExtGetRenderbuffersQCOM}

{procedure glExtGetFramebuffersQCOM(framebuffers: PGLuint; maxFramebuffers: GLint; numFramebuffers: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetFramebuffersQCOM';
{$EXTERNALSYM glExtGetFramebuffersQCOM}

{procedure glExtGetTexLevelParameterivQCOM(texture: GLuint; face: GLenum; level: GLint; pname: GLenum; params: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetTexLevelParameterivQCOM';
{$EXTERNALSYM glExtGetTexLevelParameterivQCOM}

{procedure glExtTexObjectStateOverrideiQCOM(target: GLenum; pname: GLenum; param: GLint); cdecl;
 external AndroidEglLib name 'glExtTexObjectStateOverrideiQCOM';
{$EXTERNALSYM glExtTexObjectStateOverrideiQCOM}

{procedure glExtGetTexSubImageQCOM(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; _type: GLenum; texels: PGLvoid); cdecl;
 external AndroidEglLib name 'glExtGetTexSubImageQCOM';
{$EXTERNALSYM glExtGetTexSubImageQCOM}

{procedure glExtGetBufferPointervQCOM(target: GLenum; params: PPGLvoid); cdecl;
 external AndroidEglLib name 'glExtGetBufferPointervQCOM';
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
 external AndroidEglLib name 'glExtGetShadersQCOM';
{$EXTERNALSYM glExtGetShadersQCOM}

{procedure glExtGetProgramsQCOM(programs: PGLuint; maxPrograms: GLint; numPrograms: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetProgramsQCOM';
{$EXTERNALSYM glExtGetProgramsQCOM}

{function glExtIsProgramBinaryQCOM (_program: GLuint): GLboolean; cdecl;
 external AndroidEglLib name 'glExtIsProgramBinaryQCOM';
{$EXTERNALSYM glExtIsProgramBinaryQCOM}

{procedure glExtGetProgramBinarySourceQCOM(_program: GLuint; shadertype: GLenum; source: PGLchar; length: PGLint); cdecl;
 external AndroidEglLib name 'glExtGetProgramBinarySourceQCOM';
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
 external AndroidEglLib name 'glStartTilingQCOM';
{$EXTERNALSYM glStartTilingQCOM}

{procedure glEndTilingQCOM(preserveMask: GLbitfield); cdecl;
 external AndroidEglLib name 'glEndTilingQCOM';
{$EXTERNALSYM glEndTilingQCOM}

{type
  {PFNGLSTARTTILINGQCOMPROC = procedure(x: GLuint; y: GLuint; width: GLuint; height: GLuint; preserveMask: GLbitfield);
  {$EXTERNALSYM PFNGLSTARTTILINGQCOMPROC}
  {PFNGLENDTILINGQCOMPROC = procedure(preserveMask: GLbitfield);
  {$EXTERNALSYM PFNGLENDTILINGQCOMPROC}
  
  
implementation
end.
