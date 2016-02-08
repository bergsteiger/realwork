unit NOT_FINISHED_l3Canvas;
 {* попытка реализации своего уровня абстракции над DeviceContext. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Canvas.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CanvasPrim
 , l3InternalInterfaces
 , l3Interfaces
 , l3Units
 , Windows
;

type
 Tl3Canvas = class(Tl3CanvasPrim, Il3InfoCanvas, Il3Canvas)
  {* Объект реализующий свой уровень абстракции над TCanvas и Device Context (hDC) }
  private
   f_AbortChecker: Il3AbortChecker;
  protected
   function NeedOpenRealPage(aDoc: Boolean;
    ByWidth: Boolean = False): Tl3OpenPageResult; virtual;
   function IsPreview: Boolean; virtual;
   procedure DoEndPaint; virtual;
    {* Реализация окончания рисования. }
   function GetCaret: Il3Caret; virtual;
   function DoGetDrawEnabled: Boolean; virtual;
   procedure DoStartPage; virtual;
   procedure DoStartObject(anObjectID: Integer); virtual;
   procedure DoSetPageTop; virtual;
   procedure Invalidate; virtual;
   procedure FireDCSetToNull; virtual;
   procedure FreeAlienDC(aDC: hDC); virtual;
   function Get_Size: Integer;
   function Get_Name: TFontName;
   function Get_Bold: Boolean;
   function Get_Italic: Boolean;
   function Get_Underline: Boolean;
   function Get_Strikeout: Boolean;
   function Get_ForeColor: Tl3Color;
   function Get_BackColor: Tl3Color;
   function Get_Pitch: TFontPitch;
   function Get_Index: Tl3FontIndex;
   procedure Lock;
   procedure Unlock;
   function Get_Font: Il3Font;
   function GetGlobalClipRectWithZoom: Tl3Rect; override;
  public
   function DoGetClientRect: Tl3Rect; virtual;
 end;//Tl3Canvas

 Tl3OldMFCanvas = class(Tl3Canvas)
  {* Канва для старого мета-файла. }
 end;//Tl3OldMFCanvas

implementation

uses
 l3ImplUses
 , l3CanvasUtils
 , l3LineArray
 , l3Region
;

function Tl3Canvas.NeedOpenRealPage(aDoc: Boolean;
 ByWidth: Boolean = False): Tl3OpenPageResult;
//#UC START# *478E406D004B_473C3D830066_var*
//#UC END# *478E406D004B_473C3D830066_var*
begin
//#UC START# *478E406D004B_473C3D830066_impl*
 assert(false, 'Tl3Canvas.NeedOpenRealPage not implemented');
//#UC END# *478E406D004B_473C3D830066_impl*
end;//Tl3Canvas.NeedOpenRealPage

function Tl3Canvas.IsPreview: Boolean;
//#UC START# *478E40D30089_473C3D830066_var*
//#UC END# *478E40D30089_473C3D830066_var*
begin
//#UC START# *478E40D30089_473C3D830066_impl*
 assert(false, 'Tl3Canvas.IsPreview not implemented');
//#UC END# *478E40D30089_473C3D830066_impl*
end;//Tl3Canvas.IsPreview

procedure Tl3Canvas.DoEndPaint;
 {* Реализация окончания рисования. }
//#UC START# *4797837E0112_473C3D830066_var*
//#UC END# *4797837E0112_473C3D830066_var*
begin
//#UC START# *4797837E0112_473C3D830066_impl*
 assert(false, 'Tl3Canvas.DoEndPaint not implemented');
//#UC END# *4797837E0112_473C3D830066_impl*
end;//Tl3Canvas.DoEndPaint

function Tl3Canvas.GetCaret: Il3Caret;
//#UC START# *47DFB3CE02C5_473C3D830066_var*
//#UC END# *47DFB3CE02C5_473C3D830066_var*
begin
//#UC START# *47DFB3CE02C5_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFB3CE02C5_473C3D830066_impl*
end;//Tl3Canvas.GetCaret

function Tl3Canvas.DoGetDrawEnabled: Boolean;
//#UC START# *47DFBDDA03CC_473C3D830066_var*
//#UC END# *47DFBDDA03CC_473C3D830066_var*
begin
//#UC START# *47DFBDDA03CC_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFBDDA03CC_473C3D830066_impl*
end;//Tl3Canvas.DoGetDrawEnabled

procedure Tl3Canvas.DoStartPage;
//#UC START# *47DFBEC80085_473C3D830066_var*
//#UC END# *47DFBEC80085_473C3D830066_var*
begin
//#UC START# *47DFBEC80085_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFBEC80085_473C3D830066_impl*
end;//Tl3Canvas.DoStartPage

procedure Tl3Canvas.DoStartObject(anObjectID: Integer);
//#UC START# *47DFC90A0366_473C3D830066_var*
//#UC END# *47DFC90A0366_473C3D830066_var*
begin
//#UC START# *47DFC90A0366_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFC90A0366_473C3D830066_impl*
end;//Tl3Canvas.DoStartObject

procedure Tl3Canvas.DoSetPageTop;
//#UC START# *47DFCA030114_473C3D830066_var*
//#UC END# *47DFCA030114_473C3D830066_var*
begin
//#UC START# *47DFCA030114_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *47DFCA030114_473C3D830066_impl*
end;//Tl3Canvas.DoSetPageTop

procedure Tl3Canvas.Invalidate;
//#UC START# *4FAE47320103_473C3D830066_var*
//#UC END# *4FAE47320103_473C3D830066_var*
begin
//#UC START# *4FAE47320103_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE47320103_473C3D830066_impl*
end;//Tl3Canvas.Invalidate

function Tl3Canvas.DoGetClientRect: Tl3Rect;
//#UC START# *4FAE4C740135_473C3D830066_var*
//#UC END# *4FAE4C740135_473C3D830066_var*
begin
//#UC START# *4FAE4C740135_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE4C740135_473C3D830066_impl*
end;//Tl3Canvas.DoGetClientRect

procedure Tl3Canvas.FireDCSetToNull;
//#UC START# *4FAE530D02C3_473C3D830066_var*
//#UC END# *4FAE530D02C3_473C3D830066_var*
begin
//#UC START# *4FAE530D02C3_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE530D02C3_473C3D830066_impl*
end;//Tl3Canvas.FireDCSetToNull

procedure Tl3Canvas.FreeAlienDC(aDC: hDC);
//#UC START# *4FAE532B0348_473C3D830066_var*
//#UC END# *4FAE532B0348_473C3D830066_var*
begin
//#UC START# *4FAE532B0348_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FAE532B0348_473C3D830066_impl*
end;//Tl3Canvas.FreeAlienDC

function Tl3Canvas.Get_Size: Integer;
//#UC START# *46A60D7A02E4_473C3D830066get_var*
//#UC END# *46A60D7A02E4_473C3D830066get_var*
begin
//#UC START# *46A60D7A02E4_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Size not implemented');
//#UC END# *46A60D7A02E4_473C3D830066get_impl*
end;//Tl3Canvas.Get_Size

function Tl3Canvas.Get_Name: TFontName;
//#UC START# *46A60E2802E4_473C3D830066get_var*
//#UC END# *46A60E2802E4_473C3D830066get_var*
begin
//#UC START# *46A60E2802E4_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Name not implemented');
//#UC END# *46A60E2802E4_473C3D830066get_impl*
end;//Tl3Canvas.Get_Name

function Tl3Canvas.Get_Bold: Boolean;
//#UC START# *46A60E58013F_473C3D830066get_var*
//#UC END# *46A60E58013F_473C3D830066get_var*
begin
//#UC START# *46A60E58013F_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Bold not implemented');
//#UC END# *46A60E58013F_473C3D830066get_impl*
end;//Tl3Canvas.Get_Bold

function Tl3Canvas.Get_Italic: Boolean;
//#UC START# *46A60E740045_473C3D830066get_var*
//#UC END# *46A60E740045_473C3D830066get_var*
begin
//#UC START# *46A60E740045_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Italic not implemented');
//#UC END# *46A60E740045_473C3D830066get_impl*
end;//Tl3Canvas.Get_Italic

function Tl3Canvas.Get_Underline: Boolean;
//#UC START# *46A60EA6032C_473C3D830066get_var*
//#UC END# *46A60EA6032C_473C3D830066get_var*
begin
//#UC START# *46A60EA6032C_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Underline not implemented');
//#UC END# *46A60EA6032C_473C3D830066get_impl*
end;//Tl3Canvas.Get_Underline

function Tl3Canvas.Get_Strikeout: Boolean;
//#UC START# *46A60EBF03BE_473C3D830066get_var*
//#UC END# *46A60EBF03BE_473C3D830066get_var*
begin
//#UC START# *46A60EBF03BE_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Strikeout not implemented');
//#UC END# *46A60EBF03BE_473C3D830066get_impl*
end;//Tl3Canvas.Get_Strikeout

function Tl3Canvas.Get_ForeColor: Tl3Color;
//#UC START# *46A60ED90325_473C3D830066get_var*
//#UC END# *46A60ED90325_473C3D830066get_var*
begin
//#UC START# *46A60ED90325_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_ForeColor not implemented');
//#UC END# *46A60ED90325_473C3D830066get_impl*
end;//Tl3Canvas.Get_ForeColor

function Tl3Canvas.Get_BackColor: Tl3Color;
//#UC START# *46A60EF300C9_473C3D830066get_var*
//#UC END# *46A60EF300C9_473C3D830066get_var*
begin
//#UC START# *46A60EF300C9_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_BackColor not implemented');
//#UC END# *46A60EF300C9_473C3D830066get_impl*
end;//Tl3Canvas.Get_BackColor

function Tl3Canvas.Get_Pitch: TFontPitch;
//#UC START# *46A60F63035F_473C3D830066get_var*
//#UC END# *46A60F63035F_473C3D830066get_var*
begin
//#UC START# *46A60F63035F_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Pitch not implemented');
//#UC END# *46A60F63035F_473C3D830066get_impl*
end;//Tl3Canvas.Get_Pitch

function Tl3Canvas.Get_Index: Tl3FontIndex;
//#UC START# *46A60F89031E_473C3D830066get_var*
//#UC END# *46A60F89031E_473C3D830066get_var*
begin
//#UC START# *46A60F89031E_473C3D830066get_impl*
 assert(false, 'Tl3Canvas.Get_Index not implemented');
//#UC END# *46A60F89031E_473C3D830066get_impl*
end;//Tl3Canvas.Get_Index

procedure Tl3Canvas.Lock;
//#UC START# *46A6157B0361_473C3D830066_var*
//#UC END# *46A6157B0361_473C3D830066_var*
begin
//#UC START# *46A6157B0361_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Lock not implemented');
//#UC END# *46A6157B0361_473C3D830066_impl*
end;//Tl3Canvas.Lock

procedure Tl3Canvas.Unlock;
//#UC START# *46A6158C0275_473C3D830066_var*
//#UC END# *46A6158C0275_473C3D830066_var*
begin
//#UC START# *46A6158C0275_473C3D830066_impl*
 assert(false, 'Tl3Canvas.Unlock not implemented');
//#UC END# *46A6158C0275_473C3D830066_impl*
end;//Tl3Canvas.Unlock

function Tl3Canvas.Get_Font: Il3Font;
//#UC START# *487D000802A4_473C3D830066get_var*
//#UC END# *487D000802A4_473C3D830066get_var*
begin
//#UC START# *487D000802A4_473C3D830066get_impl*
 !!! Needs to be implemented !!!
//#UC END# *487D000802A4_473C3D830066get_impl*
end;//Tl3Canvas.Get_Font

function Tl3Canvas.GetGlobalClipRectWithZoom: Tl3Rect;
//#UC START# *4E98521202B5_473C3D830066_var*
//#UC END# *4E98521202B5_473C3D830066_var*
begin
//#UC START# *4E98521202B5_473C3D830066_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E98521202B5_473C3D830066_impl*
end;//Tl3Canvas.GetGlobalClipRectWithZoom

end.
