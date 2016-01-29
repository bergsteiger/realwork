{$IfNDef PrintableFlash_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Printing"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Printing/PrintableFlash.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Aspects::Printing::Printing::Printing::PrintableFlash
//
// Печать флеш-схем. {RequestLink:228689255}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define PrintableFlash_imp}
 _PrintableBitmap_Parent_ = _PrintableFlash_Parent_;
 {$Include ..\Printing\PrintableBitmap.imp.pas}
 _PrintableFlash_ = {abstract form} class(_PrintableBitmap_)
  {* Печать флеш-схем. [RequestLink:228689255] }
 private
 // private fields
   f_Bitmap : Tl3Bitmap;
 protected
 // property methods
   function pm_GetFlashForPrint: TvtShockwaveFlashEx; virtual; abstract;
 protected
 // realized methods
   function pm_GetBitmapForPrint: Graphics_Bitmap; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DPI: Integer; override;
 protected
 // protected properties
   property FlashForPrint: TvtShockwaveFlashEx
     read pm_GetFlashForPrint;
 end;//_PrintableFlash_

{$Else PrintableFlash_imp}

{$Include ..\Printing\PrintableBitmap.imp.pas}

// start class _PrintableFlash_

function _PrintableFlash_.pm_GetBitmapForPrint: Graphics_Bitmap;
//#UC START# *4CDACD8302DD_4CDABB1C0025get_var*
var
 l_Flash : TvtShockwaveFlashEx;
 l_DC    : hDC;
//#UC END# *4CDACD8302DD_4CDABB1C0025get_var*
begin
//#UC START# *4CDACD8302DD_4CDABB1C0025get_impl*
 if (f_Bitmap = nil) then
 begin
  f_Bitmap := Tl3Bitmap.Create;
  f_Bitmap.PixelFormat := pf24bit;
 end;//f_Bitmap = nil
 l_Flash := FlashForPrint;
 f_Bitmap.Width := l_Flash.Width;
 f_Bitmap.Height := l_Flash.Height;
 l_DC := f_Bitmap.Canvas.Handle;
 SendMessage(l_Flash.Handle, WM_Paint, WParam(l_DC), 0);
 Assert(l_Flash <> nil);
 Result := f_Bitmap;
//#UC END# *4CDACD8302DD_4CDABB1C0025get_impl*
end;//_PrintableFlash_.pm_GetBitmapForPrint

procedure _PrintableFlash_.Cleanup;
//#UC START# *479731C50290_4CDABB1C0025_var*
//#UC END# *479731C50290_4CDABB1C0025_var*
begin
//#UC START# *479731C50290_4CDABB1C0025_impl*
 FreeAndNil(f_Bitmap);
 inherited;
//#UC END# *479731C50290_4CDABB1C0025_impl*
end;//_PrintableFlash_.Cleanup

function _PrintableFlash_.DPI: Integer;
//#UC START# *4CDAE15C035B_4CDABB1C0025_var*
//#UC END# *4CDAE15C035B_4CDABB1C0025_var*
begin
//#UC START# *4CDAE15C035B_4CDABB1C0025_impl*
 Result := 20;
//#UC END# *4CDAE15C035B_4CDABB1C0025_impl*
end;//_PrintableFlash_.DPI

{$EndIf PrintableFlash_imp}
