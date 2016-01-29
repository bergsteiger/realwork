unit nevBitmapFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevBitmapFormatInfo.pas"
// Начат: 01.09.2011 11:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevBitmapFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3InternalInterfaces,
  nevLeafRenderInfo,
  nevBase
  ;

type
 TnevBitmapFormatInfo = class(TnevLeafRenderInfo)
 private
 // private fields
   f_Rendered : Il3Bitmap;
 protected
 // overridden property methods
   function pm_GetRendered: Il3Bitmap; override;
 protected
 // overridden protected methods
   procedure ClearCache; override;
   procedure DoRecalc(const aView: InevViewMetrics); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TnevBitmapFormatInfo

implementation

uses
  k2Tags,
  l3Math
  ;

// start class TnevBitmapFormatInfo

procedure TnevBitmapFormatInfo.ClearCache;
//#UC START# *4E5E7D240227_4E5F35FF01B4_var*
//#UC END# *4E5E7D240227_4E5F35FF01B4_var*
begin
//#UC START# *4E5E7D240227_4E5F35FF01B4_impl*
 f_Rendered := nil;
 inherited;
//#UC END# *4E5E7D240227_4E5F35FF01B4_impl*
end;//TnevBitmapFormatInfo.ClearCache

function TnevBitmapFormatInfo.pm_GetRendered: Il3Bitmap;
//#UC START# *4E60F48503E6_4E5F35FF01B4get_var*
var
 l_Tag : Tl3Variant;
//#UC END# *4E60F48503E6_4E5F35FF01B4get_var*
begin
//#UC START# *4E60F48503E6_4E5F35FF01B4get_impl*
 if (f_Rendered = nil) then
 begin
  l_Tag := Obj.AsObject.Attr[k2_tiObject];
  if l_Tag.IsValid then
  begin
   if not l_Tag.QI(Il3Bitmap, f_Rendered) then
    Assert(false);
  end//l_Tag.IsValid
  else
   f_Rendered := nil;
 end;//f_Rendered = nil
 Result := f_Rendered;
//#UC END# *4E60F48503E6_4E5F35FF01B4get_impl*
end;//TnevBitmapFormatInfo.pm_GetRendered

procedure TnevBitmapFormatInfo.DoRecalc(const aView: InevViewMetrics);
//#UC START# *4E7094780214_4E5F35FF01B4_var*
var
 l_LimitHeight : Integer;
 l_Height      : Integer;
 l_Width       : Integer;
 l_LimitWidth  : Integer;
 l_B           : Il3Bitmap;
//#UC END# *4E7094780214_4E5F35FF01B4_var*
begin
//#UC START# *4E7094780214_4E5F35FF01B4_impl*
 inherited;
 l_Width := 0;
 l_Height := 0;
// with ParaX do
 begin
  if (Self.rLimitWidth > 0) then
  begin
   l_B := Rendered;
   l_Width := Obj.AsObject.IntA[k2_tiWidth];
   if (l_Width <= 0) AND (l_B <> nil) then
    l_Width := l_B.InchWidth + Obj.AsObject.IntA[k2_tiLeftIndent];
   l_Height := Obj.AsObject.IntA[k2_tiHeight];
   if (l_Height <= 0) AND (l_B <> nil) then
    l_Height := l_B.InchHeight;
   l_LimitWidth := Self.rLimitWidth;
   with Self.Get_Spacing do
    Dec(l_LimitWidth, Left + Right);
   if (l_Width > l_LimitWidth) then
   begin
    l_Height := l3MulDiv(l_Height, l_LimitWidth, l_Width);
    l_Width := l_LimitWidth;
   end;//l_Width > l_LimitWidth
   if aView.IsWebStyle then
   begin
    l_LimitHeight := aView.Extent.Y;
    if (l_LimitHeight > 0) then
    begin
     if (l_Height > l_LimitHeight) then
     begin
      l_Width := l3MulDiv(l_Width, l_LimitHeight, l_Height);
      l_Height := l_LimitHeight;
     end;//l_Height > l_LimitHeight
    end;//l_LimitHeight > 0
   end;//aView.IsWebStyle
  end;//aLimitWidth > 0
  with Self do
  begin
   wMap(nil);
   wWidth(l_Width);
   wHeight(l_Height);
  end;//with Self
 end;//ParaX
//#UC END# *4E7094780214_4E5F35FF01B4_impl*
end;//TnevBitmapFormatInfo.DoRecalc

procedure TnevBitmapFormatInfo.ClearFields;
 {-}
begin
 f_Rendered := nil;
 inherited;
end;//TnevBitmapFormatInfo.ClearFields

end.