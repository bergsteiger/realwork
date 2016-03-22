{$IfNDef PrintableFlash_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableFlash.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrintableFlash" MUID: (4CDABB1C0025)
// Имя типа: "_PrintableFlash_"

{$Define PrintableFlash_imp}

 _PrintableBitmap_Parent_ = _PrintableFlash_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas}
 _PrintableFlash_ = {abstract} class(_PrintableBitmap_)
  {* Печать флеш-схем. [RequestLink:228689255] }
  private
   f_Bitmap: Tl3Bitmap;
  protected
   function pm_GetFlashForPrint: TvtShockwaveFlashEx; virtual; abstract;
   function pm_GetBitmapForPrint: Graphics_Bitmap; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DPI: Integer; override;
  protected
   property FlashForPrint: TvtShockwaveFlashEx
    read pm_GetFlashForPrint;
 end;//_PrintableFlash_

{$Else PrintableFlash_imp}

{$IfNDef PrintableFlash_imp_impl}

{$Define PrintableFlash_imp_impl}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas}

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
 {* Функция очистки полей объекта. }
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

{$EndIf PrintableFlash_imp_impl}

{$EndIf PrintableFlash_imp}

