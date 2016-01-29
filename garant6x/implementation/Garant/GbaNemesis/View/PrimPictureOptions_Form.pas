unit PrimPictureOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimPictureOptions_Form.pas"
// Начат: 08.09.2010 14:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Picture::PrimPictureOptions
//
// Рисунок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimPicture_Form,
  Common_Strange_Controls,
  l3Interfaces,
  afwInterfaces,
  Graphics
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _PrintableBitmap_Parent_ = TPrimPictureForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas}
 TPrimPictureOptionsForm = {form} class(_PrintableBitmap_)
  {* Рисунок }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   procedure Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
     {* Информация о документе }
   procedure Document_GetAttributesFrmAct_GetState(var State: TvcmOperationStateIndex);
     {* Информация о документе }
   procedure Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Информация о документе }
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Копировать }
   {$IfEnd} //not NoVCM
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
   function pm_GetBitmapForPrint: Graphics_Bitmap; override;
   function Name: Il3CString; override;
   function ShortName: Il3CString; override;
 end;//TPrimPictureOptionsForm

 TvcmEntityFormRef = TPrimPictureOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTrialSupport,
  afwFacade,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  L10nInterfaces,
  SysUtils,
  l3String,
  l3ValueMap,
  nsTypes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  evBitmapDataObject,
  nsFixedHAFMacroReplacer,
  nsObjectPreview,
  nevBase,
  nsHAFPainter,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Printing\PrintableBitmap.imp.pas}

// start class TPrimPictureOptionsForm

{$If not defined(NoVCM)}
procedure TPrimPictureOptionsForm.File_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495235F401C0_4C8768010125test_var*
//#UC END# *495235F401C0_4C8768010125test_var*
begin
//#UC START# *495235F401C0_4C8768010125test_impl*
 nsDisableOperationInTrialMode(aParams);
//#UC END# *495235F401C0_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.File_Save_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureOptionsForm.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureOptionsForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C762C910358_4C8768010125getstate_var*
//#UC END# *4C762C910358_4C8768010125getstate_var*
begin
//#UC START# *4C762C910358_4C8768010125getstate_impl*
 State := st_user_Result_Cancel_Close;
//#UC END# *4C762C910358_4C8768010125getstate_impl*
end;//TPrimPictureOptionsForm.Result_Cancel_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

procedure TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7B9EBC01AC_4C8768010125test_var*
//#UC END# *4C7B9EBC01AC_4C8768010125test_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal and
                                   Assigned(f_Info);
//#UC END# *4C7B9EBC01AC_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Test

procedure TPrimPictureOptionsForm.Document_GetAttributesFrmAct_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C7B9EBC01AC_4C8768010125getstate_var*
//#UC END# *4C7B9EBC01AC_4C8768010125getstate_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125getstate_impl*
 State := st_user_Document_GetAttributesFrmAct_Picture;
//#UC END# *4C7B9EBC01AC_4C8768010125getstate_impl*
end;//TPrimPictureOptionsForm.Document_GetAttributesFrmAct_GetState

procedure TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7B9EBC01AC_4C8768010125exec_var*
//#UC END# *4C7B9EBC01AC_4C8768010125exec_var*
begin
//#UC START# *4C7B9EBC01AC_4C8768010125exec_impl*
 TdmStdRes.OpenPictureInfo(nil, f_Info);
//#UC END# *4C7B9EBC01AC_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Document_GetAttributesFrmAct_Execute

{$If not defined(NoVCM)}
procedure TPrimPictureOptionsForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7D0C7B0185_4C8768010125test_var*
//#UC END# *4C7D0C7B0185_4C8768010125test_var*
begin
//#UC START# *4C7D0C7B0185_4C8768010125test_impl*
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4C7D0C7B0185_4C8768010125test_impl*
end;//TPrimPictureOptionsForm.Edit_Copy_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureOptionsForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7D0C7B0185_4C8768010125exec_var*
//#UC END# *4C7D0C7B0185_4C8768010125exec_var*
begin
//#UC START# *4C7D0C7B0185_4C8768010125exec_impl*
 ieProc.CopyToClipboard;
//#UC END# *4C7D0C7B0185_4C8768010125exec_impl*
end;//TPrimPictureOptionsForm.Edit_Copy_Execute
{$IfEnd} //not NoVCM

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

procedure TPrimPictureOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Picture, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Save, File_Save_Execute, File_Save_Test, nil);
  ShowInContextMenu(en_File, op_Save, true);
  ShowInToolbar(en_File, op_Save, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, Result_Cancel_GetState);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_Document, op_GetAttributesFrmAct, Document_GetAttributesFrmAct_Execute, Document_GetAttributesFrmAct_Test, Document_GetAttributesFrmAct_GetState);
  ShowInContextMenu(en_Document, op_GetAttributesFrmAct, false);
  ShowInToolbar(en_Document, op_GetAttributesFrmAct, true);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_Picture, op_Resize, Picture_Resize_Execute, Picture_Resize_Test, nil);
  ShowInContextMenu(en_Picture, op_Resize, false);
  ShowInToolbar(en_Picture, op_Resize, true);
  PublishOp(en_Picture, op_Enlarge, Picture_Enlarge_Execute, Picture_Enlarge_Test, nil);
  ShowInContextMenu(en_Picture, op_Enlarge, true);
  ShowInToolbar(en_Picture, op_Enlarge, true);
  PublishOp(en_Picture, op_Shrink, Picture_Shrink_Execute, Picture_Shrink_Test, nil);
  ShowInContextMenu(en_Picture, op_Shrink, true);
  ShowInToolbar(en_Picture, op_Shrink, true);
  PublishOp(en_Picture, op_ActualSize, Picture_ActualSize_Execute, Picture_ActualSize_Test, nil);
  ShowInContextMenu(en_Picture, op_ActualSize, true);
  ShowInToolbar(en_Picture, op_ActualSize, true);
  PublishOp(en_Picture, op_FitInWIndow, Picture_FitInWIndow_Execute, Picture_FitInWIndow_Test, nil);
  ShowInContextMenu(en_Picture, op_FitInWIndow, true);
  ShowInToolbar(en_Picture, op_FitInWIndow, true);{$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_Print, false);
  ShowInToolbar(en_File, op_Print, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_PrintDialog, true);
  ShowInToolbar(en_File, op_PrintDialog, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_PrintPreview, false);
  ShowInToolbar(en_File, op_PrintPreview, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimPictureOptions
 TtfwClassRef.Register(TPrimPictureOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.