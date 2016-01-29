unit nevObjectSegmentFormatInfo;

interface

uses
 l3IntfUses
 , nevSegmentFormatInfo
 , nevBase
 , nevFormatInfo
;

type
 TnevCachedFontArray = array [Boolean] of TnevCachedFont;
 
 TnevObjectSegmentFormatInfo = class(TnevSegmentFormatInfo)
 end;//TnevObjectSegmentFormatInfo
 
implementation

uses
 l3ImplUses
 , nevTools
 , evGlyphFont
 , BitmapPara_Const
;

end.
