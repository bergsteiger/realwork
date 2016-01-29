
{*****************************************************}
{                                                     }
{             EldoS Themes Support Library            }
{                                                     }
{           (C) 2002-2003 EldoS Corporation           }
{                http://www.eldos.com/                }
{                                                     }
{*****************************************************}

{$include elpack2.inc}

{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit ElThemesWindowsXPConsts;

interface

{$IFDEF ELPACK_THEME_ENGINE}

uses
  ElTmSchema;

const
  TS_MIN = 0;
  TS_TRUE = 1;
  TS_DRAW = 2;

  TPP_FIRST_PROP_TAG = 0;
  TPP_ACCENT_COLOR_HINT = 0;
  TPP_ALPHA_LEVEL = 1;
  TPP_ALPHA_THRESHOLD = 2;
  TPP_ALWAYS_SHOW_SIZING_BAR = 3;
  TPP_AUTO_SIZE = 4;
  TPP_BG_FILL = 5;
  TPP_BG_TYPE = 6;
  TPP_BORDER_COLOR = 7;
  TPP_BORDER_COLOR_HINT = 8;
  TPP_BORDER_ONLY = 9;
  TPP_BORDER_SIZE = 10;
  TPP_BORDER_TYPE = 11;
  TPP_CAPTION_MARGINS = 12;
  TPP_COLOR = 13;
  TPP_COMPOSITED = 14;
  TPP_CONTENT_ALIGNMENT = 15;
  TPP_CONTENT_MARGINS = 16;
  TPP_EDGE_DK_SHADOW_COLOR = 17;
  TPP_EDGE_FILL_COLOR = 18;
  TPP_EDGE_HIGHLIGHT_COLOR = 19;
  TPP_EDGE_LIGHT_COLOR = 20;
  TPP_EDGE_SHADOW_COLOR = 21;
  TPP_FILL_COLOR = 22;
  TPP_FILL_COLOR_HINT = 23;
  TPP_FILL_TYPE = 24;
  TPP_GLOW_COLOR = 25;
  TPP_GLYPH_IMAGE_FILE = 26;
  TPP_GLYPH_INDEX = 27;
  TPP_GLYPH_ONLY = 28;
  TPP_GLYPH_TRANSPARENT = 29;
  TPP_GLYPH_TYPE = 30;
  TPP_GRADIENT_COLOR1 = 31;
  TPP_GRADIENT_COLOR2 = 32;
  TPP_GRADIENT_COLOR3 = 33;
  TPP_GRADIENT_COLOR4 = 34;
  TPP_GRADIENT_COLOR5 = 35;
  TPP_GRADIENT_RATIO1 = 36;
  TPP_GRADIENT_RATIO2 = 37;
  TPP_GRADIENT_RATIO3 = 38;
  TPP_GRADIENT_RATIO4 = 39;
  TPP_GRADIENT_RATIO5 = 40;
  TPP_HALIGN = 41;
  TPP_HEIGHT = 42;
  TPP_HOT_TRACKING = 43;
  TPP_ICON_EFFECT = 44;
  TPP_INTEGRAL_SIZING = 44;
  TPP_IMAGE_COUNT = 45;
  TPP_IMAGE_FILE = 46;
  TPP_IMAGE_FILE1 = 47;
  TPP_IMAGE_FILE2 = 48;
  TPP_IMAGE_FILE3 = 49;
  TPP_IMAGE_FILE4 = 50;
  TPP_IMAGE_FILE5 = 51;
  TPP_IMAGE_LAYOUT = 52;
  TPP_IMAGE_SELECT = 53;
  TPP_MIN_DPI1 = 54;
  TPP_MIN_DPI2 = 55;
  TPP_MIN_DPI3 = 56;
  TPP_MIN_DPI4 = 57;
  TPP_MIN_DPI5 = 58;
  TPP_MIN_SIZE = 59;
  TPP_MIN_SIZE1 = 60;
  TPP_MIN_SIZE2 = 61;
  TPP_MIN_SIZE3 = 62;
  TPP_MIN_SIZE4 = 63;
  TPP_MIN_SIZE5 = 64;
  TPP_MIRROR_IMAGE = 65;
  TPP_NORMAL_INDEX = 66;
  TPP_NORMAL_SIZE = 67;
  TPP_OFFSET = 68;
  TPP_OFFSET_TYPE = 69;
  TPP_PROGRESS_CHUNK_SIZE = 70;
  TPP_PROGRESS_SPACE_SIZE = 71;
  TPP_ROUND_CORNER_HEIGHT = 72;
  TPP_ROUND_CORNER_WIDTH = 73;
  TPP_SATURATION = 74;
  TPP_SHADOW_COLOR = 75;
  TPP_SIZING_MARGINS = 76;
  TPP_SIZING_TYPE = 77;
  TPP_SOURCE_GROW = 78;
  TPP_SOURCE_SHRINK = 79;
  TPP_STOCK_IMAGE_FILE = 80;
  TPP_TEXT_BORDER_COLOR = 81;
  TPP_TEXT_BORDER_SIZE = 82;
  TPP_TEXT_COLOR = 83;
  TPP_TEXT_SHADOW_COLOR = 84;
  TPP_TEXT_SHADOW_OFFSET = 85;
  TPP_TEXT_SHADOW_TYPE = 86;
  TPP_TRANSPARENT = 87;
  TPP_TRANSPARENT_COLOR = 88;
  TPP_TRUESIZE_SCALING_TYPE = 89;
  TPP_TRUESIZE_STRETCH_MARK = 90;
  TPP_UNIFORM_SIZING = 91;
  TPP_VALIGN = 92;
  TPP_WIDTH = 93;
  TPP_LAST_PROP_TAG = 93;

  XPBoolPropCount = 13;
  XPBoolPropNames: array [0..XPBoolPropCount - 1] of string = (
    'AutoSize', 'AlwaysShowSizingBar', 'BgFill', 'BorderOnly',
    'Composited', 'GlyphOnly', 'GlyphTransparent', 'IntegralSizing',
    'MirrorImage', 'SourceGrow', 'SourceShrink', 'Transparent', 'UniformSizing'
  );
  XPBoolPropTags: array [0..XPBoolPropCount - 1] of integer = (
    TPP_AUTO_SIZE, TPP_ALWAYS_SHOW_SIZING_BAR, TPP_BG_FILL, TPP_BORDER_ONLY,
    TPP_COMPOSITED, TPP_GLYPH_ONLY, TPP_GLYPH_TRANSPARENT, TPP_INTEGRAL_SIZING,
    TPP_MIRROR_IMAGE, TPP_SOURCE_GROW, TPP_SOURCE_SHRINK, TPP_TRANSPARENT,
    TPP_UNIFORM_SIZING
  );
  XPBoolPropIDs: array [0..XPBoolPropCount - 1] of integer = (
    TMT_AUTOSIZE, TMT_ALWAYSSHOWSIZINGBAR, TMT_BGFILL, TMT_BORDERONLY,
    TMT_COMPOSITED, TMT_GLYPHONLY, TMT_GLYPHTRANSPARENT, TMT_INTEGRALSIZING,
    TMT_MIRRORIMAGE, TMT_SOURCEGROW, TMT_SOURCESHRINK, TMT_TRANSPARENT,
    TMT_UNIFORMSIZING
  );

  XPColorPropCount = 23;
  XPColorPropNames: array [0..XPColorPropCount - 1] of string = (
    'AccentColorHint', 'BorderColor', 'BorderColorHint', 'Color',
    'EdgeDkShadowColor', 'EdgeFillColor', 'EdgeHighlightColor',
    'EdgeLightColor', 'EdgeShadowColor', 'FillColor',
    'FillColorHint', 'GlowColor', 'GradientColor1',
    'GradientColor2', 'GradientColor3', 'GradientColor4',
    'GradientColor5', 'HotTracking', 'ShadowColor',
    'TextBorderColor', 'TextColor', 'TextShadowColor',
    'TransparentColor'
  );
  XPColorPropTags: array [0..XPColorPropCount - 1] of integer = (
    TPP_ACCENT_COLOR_HINT, TPP_BORDER_COLOR, TPP_BORDER_COLOR_HINT, TPP_COLOR,
    TPP_EDGE_DK_SHADOW_COLOR, TPP_EDGE_FILL_COLOR, TPP_EDGE_HIGHLIGHT_COLOR,
    TPP_EDGE_LIGHT_COLOR, TPP_EDGE_SHADOW_COLOR, TPP_FILL_COLOR,
    TPP_FILL_COLOR_HINT, TPP_GLOW_COLOR, TPP_GRADIENT_COLOR1,
    TPP_GRADIENT_COLOR2, TPP_GRADIENT_COLOR3, TPP_GRADIENT_COLOR4,
    TPP_GRADIENT_COLOR5, TPP_HOT_TRACKING, TPP_SHADOW_COLOR,
    TPP_TEXT_BORDER_COLOR, TPP_TEXT_COLOR, TPP_TEXT_SHADOW_COLOR,
    TPP_TRANSPARENT_COLOR
  );
  XPColorPropIDs: array [0..XPColorPropCount - 1] of integer = (
    TMT_ACCENTCOLORHINT, TMT_BORDERCOLOR, TMT_BORDERCOLORHINT, TMT_COLOR,
    TMT_EDGEDKSHADOWCOLOR, TMT_EDGEFILLCOLOR, TMT_EDGEHIGHLIGHTCOLOR,
    TMT_EDGELIGHTCOLOR, TMT_EDGESHADOWCOLOR, TMT_FILLCOLOR,
    TMT_FILLCOLORHINT, TMT_GLOWCOLOR, TMT_GRADIENTCOLOR1,
    TMT_GRADIENTCOLOR2, TMT_GRADIENTCOLOR3, TMT_GRADIENTCOLOR4,
    TMT_GRADIENTCOLOR5, TMT_HOTTRACKING, TMT_SHADOWCOLOR,
    TMT_TEXTBORDERCOLOR, TMT_TEXTCOLOR, TMT_TEXTSHADOWCOLOR,
    TMT_TRANSPARENTCOLOR
  );

  XPIntPropCount = 25;
  XPIntPropNames: array [0..XPIntPropCount - 1] of string = (
    'AlphaLevel', 'AlphaThreshold', 'BorderSize', 'GlyphIndex',
    'GradientRatio1', 'GradientRatio2', 'GradientRatio3',
    'GradientRatio4', 'GradientRatio5', 'Height', 'ImageCount',
    'MinDpi1', 'MinDpi2', 'MinDpi3', 'MinDpi4', 'MinDpi5',
    'NormalIndex', 'ProgressChunkSize', 'ProgressSpaceSize',
    'RoundCornerHeight', 'RoundCornerWidth', 'Saturation',
    'TextBorderSize', 'TrueSizeStretchMark', 'Width'
  );
  XPIntPropTags: array [0..XPIntPropCount - 1] of integer = (
    TPP_ALPHA_LEVEL, TPP_ALPHA_THRESHOLD, TPP_BORDER_SIZE, TPP_GLYPH_INDEX,
    TPP_GRADIENT_RATIO1, TPP_GRADIENT_RATIO2, TPP_GRADIENT_RATIO3,
    TPP_GRADIENT_RATIO4, TPP_GRADIENT_RATIO5, TPP_HEIGHT, TPP_IMAGE_COUNT,
    TPP_MIN_DPI1, TPP_MIN_DPI2, TPP_MIN_DPI3, TPP_MIN_DPI4, TPP_MIN_DPI5,
    TPP_NORMAL_INDEX, TPP_PROGRESS_CHUNK_SIZE, TPP_PROGRESS_SPACE_SIZE,
    TPP_ROUND_CORNER_HEIGHT, TPP_ROUND_CORNER_WIDTH, TPP_SATURATION,
    TPP_TEXT_BORDER_SIZE, TPP_TRUESIZE_STRETCH_MARK, TPP_WIDTH
  );
  XPIntPropIDs: array [0..XPIntPropCount - 1] of integer = (
    TMT_ALPHALEVEL, TMT_ALPHATHRESHOLD, TMT_BORDERSIZE, TMT_GLYPHINDEX,
    TMT_GRADIENTRATIO1, TMT_GRADIENTRATIO2, TMT_GRADIENTRATIO3,
    TMT_GRADIENTRATIO4, TMT_GRADIENTRATIO5, TMT_HEIGHT, TMT_IMAGECOUNT,
    TMT_MINDPI1, TMT_MINDPI2, TMT_MINDPI3, TMT_MINDPI4, TMT_MINDPI5,
    TMT_NORMALINDEX, TMT_PROGRESSCHUNKSIZE, TMT_PROGRESSSPACESIZE,
    TMT_ROUNDCORNERHEIGHT, TMT_ROUNDCORNERWIDTH, TMT_SATURATION,
    TMT_TEXTBORDERSIZE, TMT_TRUESIZESTRETCHMARK, TMT_WIDTH
  );

  XPMarginsPropCount = 3;
  XPMarginsPropNames: array [0..XPMarginsPropCount - 1] of string = (
    'CaptionMargins', 'ContentMargins', 'SizingMargins'
  );
  XPMarginsPropTags: array [0..XPMarginsPropCount - 1] of integer = (
    TPP_CAPTION_MARGINS, TPP_CONTENT_MARGINS, TPP_SIZING_MARGINS
  );
  XPMarginsPropIDs: array [0..XPMarginsPropCount - 1] of integer = (
    TMT_CAPTIONMARGINS, TMT_CONTENTMARGINS, TMT_SIZINGMARGINS
  );

  XPPointPropCount = 2;
  XPPointPropNames: array [0..XPPointPropCount - 1] of string = (
    'Offset', 'TextShadowOffset'
  );
  XPPointPropTags: array [0..XPPointPropCount - 1] of integer = (
    TPP_OFFSET, TPP_TEXT_SHADOW_OFFSET
  );
  XPPointPropIDs: array [0..XPPointPropCount - 1] of integer = (
    TMT_OFFSET, TMT_TEXTSHADOWOFFSET
  );

  XPSizePropCount = 7;
  XPSizePropNames: array [0..XPSizePropCount - 1] of string = (
    'MinSize', 'MinSize1', 'MinSize2', 'MinSize3', 'MinSize4',
    'MinSize5', 'NormalSize'
  );
  XPSizePropTags: array [0..XPSizePropCount - 1] of integer = (
    TPP_MIN_SIZE, TPP_MIN_SIZE1, TPP_MIN_SIZE2, TPP_MIN_SIZE3, TPP_MIN_SIZE4,
    TPP_MIN_SIZE5, TPP_NORMAL_SIZE
  );
  XPSizePropIDs: array [0..XPSizePropCount - 1] of integer = (
    TMT_MINSIZE, TMT_MINSIZE1, TMT_MINSIZE2, TMT_MINSIZE3, TMT_MINSIZE4,
    TMT_MINSIZE5, TMT_NORMALSIZE
  );

  XPStrPropCount = 8;
  XPStrPropNames: array [0..XPStrPropCount - 1] of string = (
    'GlyphImageFile', 'ImageFile', 'ImageFile1', 'ImageFile2',
    'ImageFile3', 'ImageFile4', 'ImageFile5', 'StockImageFile'
  );
  XPStrPropTags: array [0..XPStrPropCount - 1] of integer = (
    TPP_GLYPH_IMAGE_FILE, TPP_IMAGE_FILE, TPP_IMAGE_FILE1, TPP_IMAGE_FILE2,
    TPP_IMAGE_FILE3, TPP_IMAGE_FILE4, TPP_IMAGE_FILE5, TPP_STOCK_IMAGE_FILE
  );
  XPStrPropIDs: array [0..XPStrPropCount - 1] of integer = (
    TMT_GLYPHIMAGEFILE, TMT_IMAGEFILE, TMT_IMAGEFILE1, TMT_IMAGEFILE2,
    TMT_IMAGEFILE3, TMT_IMAGEFILE4, TMT_IMAGEFILE5, TMT_STOCKIMAGEFILE
  );

{$ENDIF}

implementation

end.
