{$IfNDef PrintableFlashWithInfo_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableFlashWithInfo.imp.pas"
// Стереотип: "VCMForm"

{$Define PrintableFlashWithInfo_imp}

 _PrintableFlash_Parent_ = _PrintableFlashWithInfo_Parent_;
 {$Include PrintableFlash.imp.pas}
 _PrintableFlashWithInfo_ = {abstract} class(_PrintableFlash_)
  private
   f_InfoPreview: IafwDocumentPreview;
    {* Поле для свойства InfoPreview }
   f_FlashPreview: IafwDocumentPreview;
    {* Поле для свойства FlashPreview }
  protected
   function pm_GetInfoPreview: IafwDocumentPreview; virtual;
   function pm_GetFlashPreview: IafwDocumentPreview; virtual;
   function MakeDocumentPreview: IafwDocumentPreview;
   function MakeInfoPreview: IafwDocumentPreview;
   function GetDocumentForInfo: IdeDocInfo; virtual; abstract;
   procedure ClearFields; override;
   function MakePreview: IafwDocumentPreview; override;
   procedure ClearPreview; override;
  protected
   property InfoPreview: IafwDocumentPreview
    read pm_GetInfoPreview;
   property FlashPreview: IafwDocumentPreview
    read pm_GetFlashPreview;
 end;//_PrintableFlashWithInfo_

{$Else PrintableFlashWithInfo_imp}

{$IfNDef PrintableFlashWithInfo_imp_impl}

{$Define PrintableFlashWithInfo_imp_impl}

{$Include PrintableFlash.imp.pas}

function _PrintableFlashWithInfo_.pm_GetInfoPreview: IafwDocumentPreview;
//#UC START# *54D886BC0229_54D879C9030Cget_var*
//#UC END# *54D886BC0229_54D879C9030Cget_var*
begin
//#UC START# *54D886BC0229_54D879C9030Cget_impl*
 if (f_InfoPreview = nil) then
  f_InfoPreview := MakeInfoPreview;
 Result := f_InfoPreview;
//#UC END# *54D886BC0229_54D879C9030Cget_impl*
end;//_PrintableFlashWithInfo_.pm_GetInfoPreview

function _PrintableFlashWithInfo_.pm_GetFlashPreview: IafwDocumentPreview;
//#UC START# *54D886F20388_54D879C9030Cget_var*
//#UC END# *54D886F20388_54D879C9030Cget_var*
begin
//#UC START# *54D886F20388_54D879C9030Cget_impl*
 if (f_FlashPreview = nil) then
  f_FlashPreview := MakeDocumentPreview;
 Result := f_FlashPreview;
//#UC END# *54D886F20388_54D879C9030Cget_impl*
end;//_PrintableFlashWithInfo_.pm_GetFlashPreview

function _PrintableFlashWithInfo_.MakeDocumentPreview: IafwDocumentPreview;
//#UC START# *54D879F001C4_54D879C9030C_var*
//#UC END# *54D879F001C4_54D879C9030C_var*
begin
//#UC START# *54D879F001C4_54D879C9030C_impl*
 Result := TnsObjectPreview.Make(TevBitmapDataObject.Make(BitmapForPrint, Self.DPI),
                                 evDefaultPreviewCacheKey,
                                 TnsHAFPainter.Make(TnsFixedHAFMacroReplacer.Make(nil, ShortName, Name)));
//#UC END# *54D879F001C4_54D879C9030C_impl*
end;//_PrintableFlashWithInfo_.MakeDocumentPreview

function _PrintableFlashWithInfo_.MakeInfoPreview: IafwDocumentPreview;
//#UC START# *54D87A03022C_54D879C9030C_var*
//#UC END# *54D87A03022C_54D879C9030C_var*
begin
//#UC START# *54D87A03022C_54D879C9030C_impl*
 Result := nsGetRelatedDocPreview(GetDocumentForInfo.Doc, True, False, False);
//#UC END# *54D87A03022C_54D879C9030C_impl*
end;//_PrintableFlashWithInfo_.MakeInfoPreview

procedure _PrintableFlashWithInfo_.ClearFields;
begin
 f_InfoPreview := nil;
 f_FlashPreview := nil;
 inherited;
end;//_PrintableFlashWithInfo_.ClearFields

function _PrintableFlashWithInfo_.MakePreview: IafwDocumentPreview;
//#UC START# *5301CBFE023E_54D879C9030C_var*
//#UC END# *5301CBFE023E_54D879C9030C_var*
begin
//#UC START# *5301CBFE023E_54D879C9030C_impl*
 Result := TafwComplexDocumentPreview.Make(FlashPreview, InfoPreview);
//#UC END# *5301CBFE023E_54D879C9030C_impl*
end;//_PrintableFlashWithInfo_.MakePreview

procedure _PrintableFlashWithInfo_.ClearPreview;
//#UC START# *5592655F00B2_54D879C9030C_var*
//#UC END# *5592655F00B2_54D879C9030C_var*
begin
//#UC START# *5592655F00B2_54D879C9030C_impl*
 f_InfoPreview := nil;
 f_FlashPreview := nil;
 inherited;
//#UC END# *5592655F00B2_54D879C9030C_impl*
end;//_PrintableFlashWithInfo_.ClearPreview

{$EndIf PrintableFlashWithInfo_imp_impl}

{$EndIf PrintableFlashWithInfo_imp}

