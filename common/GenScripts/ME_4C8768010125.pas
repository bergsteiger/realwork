unit PrimPictureOptions_Form;
 {* Рисунок }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPicture_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
 , l3Interfaces
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _PrintableBitmap_Parent_ = TPrimPictureForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas}
 TPrimPictureOptionsForm = class(_PrintableBitmap_)
  {* Рисунок }
  protected
   function pm_GetBitmapForPrint: Graphics_Bitmap; override;
   function Name: Il3CString; override;
   function ShortName: Il3CString; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
    {* Информация о документе }
   procedure Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Информация о документе }
   procedure Document_GetAttributesFrmAct_GetState(var State: TvcmOperationStateIndex);
    {* Информация о документе }
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Picture_Resize_Test(const aParams: IvcmTestParamsPrim);
   procedure Picture_Resize_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Picture_Enlarge_Test(const aParams: IvcmTestParamsPrim);
   procedure Picture_Enlarge_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Picture_Shrink_Test(const aParams: IvcmTestParamsPrim);
   procedure Picture_Shrink_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Picture_ActualSize_Test(const aParams: IvcmTestParamsPrim);
   procedure Picture_ActualSize_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Picture_FitInWIndow_Test(const aParams: IvcmTestParamsPrim);
   procedure Picture_FitInWIndow_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimPictureOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsTrialSupport
 , afwFacade
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , L10nInterfaces
 , SysUtils
 , Classes
 , l3String
 , l3ValueMap
 , nsTypes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , evBitmapDataObject
 , nsFixedHAFMacroReplacer
 , nsObjectPreview
 , nevBase
 , nsHAFPainter
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.File_Save_Test(const aParams: IvcmTestParamsPrim);
 {* Сохранить }
//#UC START# *495235F401C0_4C8768010125test_var*
//#UC END# *495235F401C0_4C8768010125test_var*
begin
//#UC START# *495235F401C0_4C8768010125test_impl*
 nsDisableOperationInTrialMode(aParams);
//#UC END# *495235F401C0_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.File_Save_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Сохранить }
//#UC START# *495235F401C0_4C8768010125exec_var*
var
 l_FileExt: string;
//#UC END# *495235F401C0_4C8768010125exec_var*
begin
//#UC START# *495235F401C0_4C8768010125exec_impl*
 with GetSaveDialog do
 begin
  l_FileExt := ExtractFileExt(FileName);

  if ((StrIComp(PChar(l_FileExt), '.bmp') = 0) or
      (StrIComp(PChar(l_FileExt), '.jpg') = 0) or
      (StrIComp(PChar(l_FileExt), '.gif') = 0))
  then
   FileName := ChangeFileExt(FileName, ''); // cleanup file extension

  if Execute then
  try
   case FilterIndex of
    1: ieIO.SaveToFileBMP(ChangeFileExt(FileName, '.bmp'));
    2: ieIO.SaveToFileJpeg(ChangeFileExt(FileName, '.jpg'));
    3: ieIO.SaveToFileGif(ChangeFileExt(FileName, '.gif'));
   end;
  except
   on EFCreateError do
   begin
    if Windows.GetLastError = ERROR_ACCESS_DENIED then
     Say(err_CannotCreateFile, [ExtractFileName(FileName)])
    else
     raise;
   end;//on EFCreateError do
  end;{try..except}
 end;//with GetSaveDialog do
//#UC END# *495235F401C0_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.File_Save_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4C762C910358_4C8768010125exec_var*
//#UC END# *4C762C910358_4C8768010125exec_var*
begin
//#UC START# *4C762C910358_4C8768010125exec_impl*
 if IsModalForm then
  ModalResult := mrCancel
 else
  Dispatcher.History.Back;
//#UC END# *4C762C910358_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* Отмена }
//#UC START# *4C762C910358_4C8768010125getstate_var*
//#UC END# *4C762C910358_4C8768010125getstate_var*
begin
//#UC START# *4C762C910358_4C8768010125getstate_impl*
 State := st_user_Result_Cancel_Close;
//#UC END# *4C762C910358_4C8768010125getstate_impl*
end;//TPrimPictureOptionsForm.Result_Cancel_GetState
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
 {* Информация о документе }
//#UC START# *4C7B9EBC01AC_4C8768010125test_var*
//#UC END# *4C7B9EBC01AC_4C8768010125test_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal and
                                   Assigned(f_Info);
//#UC END# *4C7B9EBC01AC_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Test

procedure TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Информация о документе }
//#UC START# *4C7B9EBC01AC_4C8768010125exec_var*
//#UC END# *4C7B9EBC01AC_4C8768010125exec_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125exec_impl*
 TdmStdRes.OpenPictureInfo(nil, f_Info);
//#UC END# *4C7B9EBC01AC_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Execute

procedure TPrimPictureOptionsForm.Document_GetAttributesFrmAct_GetState(var State: TvcmOperationStateIndex);
 {* Информация о документе }
//#UC START# *4C7B9EBC01AC_4C8768010125getstate_var*
//#UC END# *4C7B9EBC01AC_4C8768010125getstate_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125getstate_impl*
 State := st_user_Document_GetAttributesFrmAct_Picture;
//#UC END# *4C7B9EBC01AC_4C8768010125getstate_impl*
end;//TPrimPictureOptionsForm.Document_GetAttributesFrmAct_GetState

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C8768010125test_var*
//#UC END# *4C7D0C7B0185_4C8768010125test_var*
begin
//#UC START# *4C7D0C7B0185_4C8768010125test_impl*
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4C7D0C7B0185_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Edit_Copy_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C8768010125exec_var*
//#UC END# *4C7D0C7B0185_4C8768010125exec_var*
begin
//#UC START# *4C7D0C7B0185_4C8768010125exec_impl*
 ieProc.CopyToClipboard;
//#UC END# *4C7D0C7B0185_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Edit_Copy_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPictureOptionsForm.Picture_Resize_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C876C1F014C_4C8768010125test_var*
var
 l_Strings : IvcmStrings;
 l_StringSource: InsStringsSource;
//#UC END# *4C876C1F014C_4C8768010125test_var*
begin
//#UC START# *4C876C1F014C_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := True;
 l_Strings := aParams.Op.SubItems;
 if (l_Strings = nil) then
  Exit;
 if not ieViewer.AutoFit then
  aParams.Op.SelectedString := f_ValueMap.ValueToDisplayName(nsCStr(IntToStr(Scale)))
 else
  aParams.Op.SelectedString := f_ValueMap.SpecialDisplayName;
 if (l_Strings.Count = 0) and Supports(f_ValueMap, InsStringsSource, l_StringSource) then
  l_StringSource.FillStrings(l_Strings);
//#UC END# *4C876C1F014C_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Picture_Resize_Test

procedure TPrimPictureOptionsForm.Picture_Resize_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C876C1F014C_4C8768010125exec_var*
//#UC END# *4C876C1F014C_4C8768010125exec_var*
begin
//#UC START# *4C876C1F014C_4C8768010125exec_impl*
 if l3IsNil(aParams.SelectedString) then
  Exit;
 if l3Same(f_ValueMap.SpecialDisplayName, aParams.SelectedString)then
  FitInWindow
 else
  try
   ieViewer.AutoFit := False;
   Scale := StrToInt(l3Str(f_ValueMap.DisplayNameToValue(aParams.SelectedString)))
  except
   on El3ValueMapValueNotFound do
    Say(war_PictureRangeWarning, [f_ValueMap.MinValue, f_ValueMap.MaxValue]);
  end;//try..except
//#UC END# *4C876C1F014C_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Picture_Resize_Execute

procedure TPrimPictureOptionsForm.Picture_Enlarge_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C876E670305_4C8768010125test_var*
//#UC END# *4C876E670305_4C8768010125test_var*
begin
//#UC START# *4C876E670305_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanEnlarge;
//#UC END# *4C876E670305_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Picture_Enlarge_Test

procedure TPrimPictureOptionsForm.Picture_Enlarge_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C876E670305_4C8768010125exec_var*
//#UC END# *4C876E670305_4C8768010125exec_var*
begin
//#UC START# *4C876E670305_4C8768010125exec_impl*
 Enlarge;
//#UC END# *4C876E670305_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Picture_Enlarge_Execute

procedure TPrimPictureOptionsForm.Picture_Shrink_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C876E850207_4C8768010125test_var*
//#UC END# *4C876E850207_4C8768010125test_var*
begin
//#UC START# *4C876E850207_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanShrink;
//#UC END# *4C876E850207_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Picture_Shrink_Test

procedure TPrimPictureOptionsForm.Picture_Shrink_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C876E850207_4C8768010125exec_var*
//#UC END# *4C876E850207_4C8768010125exec_var*
begin
//#UC START# *4C876E850207_4C8768010125exec_impl*
 Shrink;
//#UC END# *4C876E850207_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Picture_Shrink_Execute

procedure TPrimPictureOptionsForm.Picture_ActualSize_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C876EA202FF_4C8768010125test_var*
//#UC END# *4C876EA202FF_4C8768010125test_var*
begin
//#UC START# *4C876EA202FF_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Scale <> 100;
//#UC END# *4C876EA202FF_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Picture_ActualSize_Test

procedure TPrimPictureOptionsForm.Picture_ActualSize_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C876EA202FF_4C8768010125exec_var*
//#UC END# *4C876EA202FF_4C8768010125exec_var*
begin
//#UC START# *4C876EA202FF_4C8768010125exec_impl*
 Scale := 100;
//#UC END# *4C876EA202FF_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Picture_ActualSize_Execute

procedure TPrimPictureOptionsForm.Picture_FitInWIndow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C876EB40188_4C8768010125test_var*
//#UC END# *4C876EB40188_4C8768010125test_var*
begin
//#UC START# *4C876EB40188_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not ieViewer.AutoFit;
//#UC END# *4C876EB40188_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Picture_FitInWIndow_Test

procedure TPrimPictureOptionsForm.Picture_FitInWIndow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C876EB40188_4C8768010125exec_var*
//#UC END# *4C876EB40188_4C8768010125exec_var*
begin
//#UC START# *4C876EB40188_4C8768010125exec_impl*
 FitInWindow;
//#UC END# *4C876EB40188_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Picture_FitInWIndow_Execute

function TPrimPictureOptionsForm.pm_GetBitmapForPrint: Graphics_Bitmap;
//#UC START# *4CDACD8302DD_4C8768010125get_var*
//#UC END# *4CDACD8302DD_4C8768010125get_var*
begin
//#UC START# *4CDACD8302DD_4C8768010125get_impl*
 Result := ieViewer.IEBitmap.VclBitmap;
//#UC END# *4CDACD8302DD_4C8768010125get_impl*
end;//TPrimPictureOptionsForm.pm_GetBitmapForPrint

function TPrimPictureOptionsForm.Name: Il3CString;
//#UC START# *4CDAD282005F_4C8768010125_var*
//#UC END# *4CDAD282005F_4C8768010125_var*
begin
//#UC START# *4CDAD282005F_4C8768010125_impl*
 Result := f_Info.Name;
//#UC END# *4CDAD282005F_4C8768010125_impl*
end;//TPrimPictureOptionsForm.Name

function TPrimPictureOptionsForm.ShortName: Il3CString;
//#UC START# *4CDAD29D0169_4C8768010125_var*
//#UC END# *4CDAD29D0169_4C8768010125_var*
begin
//#UC START# *4CDAD29D0169_4C8768010125_impl*
 Result := f_Info.ShortName;
//#UC END# *4CDAD29D0169_4C8768010125_impl*
end;//TPrimPictureOptionsForm.ShortName

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPictureOptionsForm);
 {* Регистрация PrimPictureOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
