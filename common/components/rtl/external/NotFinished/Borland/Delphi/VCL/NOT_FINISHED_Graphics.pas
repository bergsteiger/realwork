unit NOT_FINISHED_Graphics;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\NOT_FINISHED_Graphics.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Graphics" MUID: (47D15712022D)

interface

uses
 l3IntfUses
 , Classes
 , Windows
;

const
 clDefault = TColor($20000000);
 clYellow = TColor($00FFFF);
 clAqua = TColor($FFFF00);
 clRed = TColor($0000FF);
 clSilver = ;
 clWindowText = ;
 clGrayText = ;
 clBlue = ;

type
 TGraphic = class(TInterfacedPersistent)
  {* TGraphic is the abstract base class type for objects such as icons, bitmaps, and metafiles that can store and display visual images. }
 end;//TGraphic

 TMetafileCanvas = class
 end;//TMetafileCanvas

 TGraphicsObject = class(TPersistent)
  {* TGraphicsObject is the abstract base class for objects which encapsulate a system graphics object: TBrush, TFont, and TPen. }
 end;//TGraphicsObject

 TFont = class(TGraphicsObject)
  {* TFont encapsulates a system font. }
 end;//TFont

 TBitmap = class(TGraphic)
 end;//TBitmap

 TMetafile = class(TGraphic)
  {* TMetafile is an encapsulation of the Win32 Enhanced metafile. }
 end;//TMetafile

 TFontPitch = (
  {* Тип шрифта }
  fpDefault
   {* The font pitch is set to the default value, which depends on the font specified in the font object's Name property. }
  , fpVariable
   {* The font pitch is set to variable. The characters in the font have different widths. }
  , fpFixed
   {* The font pitch is set to fixed. All characters in the font have the same width. }
 );//TFontPitch

 TColor = Integer;
  {* Цвет. }

 TFontName = type AnsiString;
  {* Гарнитура шрифта. }

 TFontStyle = (
  fsBold
   {* The font is boldfaced. }
  , fsItalic
   {* The font is italicized. }
  , fsUnderline
   {* The font is underlined. }
  , fsStrikeOut
   {* The font is displayed with a horizontal line through it. }
 );//TFontStyle

 TFontStyles = set of TFontStyle;
  {* TFontStyles is a set of TFontStyle values. }

 TGraphicsObject = class(TPersistent)
  {* TGraphicsObject is the abstract base class for objects which encapsulate a system graphics object: TBrush, TFont, and TPen. }
 end;//TGraphicsObject

 TFont = class(TGraphicsObject)
  {* Шрифт. }
 end;//TFont

 TCanvas = class(TPersistent)
  {* Канва для вывода. }
 end;//TCanvas

 TGraphic = class(TInterfacedPersistent)
  {* TGraphic is the abstract base class type for objects such as icons, bitmaps, and metafiles that can store and display visual images. }
 end;//TGraphic

 TBitmap = class(TGraphic)
  {* Картинка. TBitmap is an encapsulation of a Windows bitmap (HBITMAP), including its palette (HPALETTE). }
 end;//TBitmap

 TMetafileImage = class
 end;//TMetafileImage

 TSharedImage = class
 end;//TSharedImage

 TPicture = class
 end;//TPicture

 TCanvas = class
 end;//TCanvas

 TMetafileHeader = record
 end;//TMetafileHeader

 HENHMETAFILE = THandle;

 TBrush = {final} class
 end;//TBrush

 TPen = {final} class
 end;//TPen

procedure ColorToRGB;

implementation

uses
 l3ImplUses
;

procedure ColorToRGB;
//#UC START# *50F928A102E2_47D15712022D_var*
//#UC END# *50F928A102E2_47D15712022D_var*
begin
//#UC START# *50F928A102E2_47D15712022D_impl*
 !!! Needs to be implemented !!!
//#UC END# *50F928A102E2_47D15712022D_impl*
end;//ColorToRGB

end.
