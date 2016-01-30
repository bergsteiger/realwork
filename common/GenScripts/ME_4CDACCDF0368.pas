{$IfNDef PrintableBitmap_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas"
// Стереотип: "VCMForm"

{$Define PrintableBitmap_imp}

type
 Graphics_Bitmap = TBitmap;
  {* Переопределение TBitmap, чтобы не нарваться на конфликт с Windows.TBitmap }

 _Printable_Parent_ = _PrintableBitmap_Parent_;
 {$Include Printable.imp.pas}
 _PrintableBitmap_ = {abstract} class(_Printable_)
  private
   f_Preview: IafwDocumentPreview;
  protected
   function pm_GetBitmapForPrint: Graphics_Bitmap; virtual; abstract;
   function Name: Il3CString; virtual; abstract;
   function ShortName: Il3CString; virtual; abstract;
   function DPI: Integer; virtual;
   function MakePreview: IafwDocumentPreview; virtual;
   procedure ClearPreview; virtual;
   function pm_GetPreview: IafwDocumentPreview; override;
   procedure ClearFields; override;
  protected
   property BitmapForPrint: Graphics_Bitmap
    read pm_GetBitmapForPrint;
 end;//_PrintableBitmap_

{$Else PrintableBitmap_imp}

{$IfNDef PrintableBitmap_imp_impl}

{$Define PrintableBitmap_imp_impl}

{$Include Printable.imp.pas}

function _PrintableBitmap_.DPI: Integer;
//#UC START# *4CDAE15C035B_4CDACCDF0368_var*
//#UC END# *4CDAE15C035B_4CDACCDF0368_var*
begin
//#UC START# *4CDAE15C035B_4CDACCDF0368_impl*
 Result := 0;
//#UC END# *4CDAE15C035B_4CDACCDF0368_impl*
end;//_PrintableBitmap_.DPI

function _PrintableBitmap_.MakePreview: IafwDocumentPreview;
//#UC START# *5301CBFE023E_4CDACCDF0368_var*
//#UC END# *5301CBFE023E_4CDACCDF0368_var*
begin
//#UC START# *5301CBFE023E_4CDACCDF0368_impl*
 Result := TnsObjectPreview.Make(TevBitmapDataObject.Make(BitmapForPrint, Self.DPI),
                                 evDefaultPreviewCacheKey,
                                 TnsHAFPainter.Make(TnsFixedHAFMacroReplacer.Make(nil, ShortName, Name)));
//#UC END# *5301CBFE023E_4CDACCDF0368_impl*
end;//_PrintableBitmap_.MakePreview

procedure _PrintableBitmap_.ClearPreview;
//#UC START# *5592655F00B2_4CDACCDF0368_var*
//#UC END# *5592655F00B2_4CDACCDF0368_var*
begin
//#UC START# *5592655F00B2_4CDACCDF0368_impl*
 f_Preview := nil;
//#UC END# *5592655F00B2_4CDACCDF0368_impl*
end;//_PrintableBitmap_.ClearPreview

function _PrintableBitmap_.pm_GetPreview: IafwDocumentPreview;
//#UC START# *4CDAC5E902FF_4CDACCDF0368get_var*
//#UC END# *4CDAC5E902FF_4CDACCDF0368get_var*
begin
//#UC START# *4CDAC5E902FF_4CDACCDF0368get_impl*
 if not Assigned(f_Preview) then
  f_Preview := MakePreview;
 Result := f_Preview;
//#UC END# *4CDAC5E902FF_4CDACCDF0368get_impl*
end;//_PrintableBitmap_.pm_GetPreview

procedure _PrintableBitmap_.ClearFields;
begin
 f_Preview := nil;
 inherited;
end;//_PrintableBitmap_.ClearFields

{$EndIf PrintableBitmap_imp_impl}

{$EndIf PrintableBitmap_imp}

