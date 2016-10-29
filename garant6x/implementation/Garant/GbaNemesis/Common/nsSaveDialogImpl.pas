unit nsSaveDialogImpl;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSaveDialogImpl.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "TnsSaveDialogImpl" MUID: (573B090C02C5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , nsSaveDialogExecutor
 , nsTypes
 , PresentationInterfaces
 , nsSaveDialog
;

type
 TnsSaveDialogImpl = {final} class(Tl3ProtoObject, InsSaveDialogExecutor)
  private
   f_FileFormat: TnsFileFormat;
   f_FileName: AnsiString;
   f_SaveObjects: TnsSaveDialogListTarget;
   f_MergeFiles: Boolean;
   f_SelectedOnly: Boolean;
   f_SaveObjDefault: Boolean;
   f_MergeDefault: Boolean;
   f_SelOnlyDefault: Boolean;
  protected
   procedure InitFields; override;
  public
   function Call(aDialog: TnsSaveDialog): Boolean;
   function GetFileName: AnsiString;
   procedure SetFileName(const aName: AnsiString);
   procedure SetFileFormat(aFileFormat: TnsFileFormat);
   procedure SetSaveObjects(aValue: TnsSaveDialogListTarget);
   procedure SetMergeFiles(aValue: Boolean);
   procedure SetSelectedOnly(aValue: Boolean);
   class function Instance: TnsSaveDialogImpl;
    {* Метод получения экземпляра синглетона TnsSaveDialogImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsSaveDialogImpl
{$IfEnd} // Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3BatchService
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 //#UC START# *573B090C02C5impl_uses*
 //#UC END# *573B090C02C5impl_uses*
;

var g_TnsSaveDialogImpl: TnsSaveDialogImpl = nil;
 {* Экземпляр синглетона TnsSaveDialogImpl }

procedure TnsSaveDialogImplFree;
 {* Метод освобождения экземпляра синглетона TnsSaveDialogImpl }
begin
 l3Free(g_TnsSaveDialogImpl);
end;//TnsSaveDialogImplFree

function TnsSaveDialogImpl.Call(aDialog: TnsSaveDialog): Boolean;
//#UC START# *52B375B038DC_573B090C02C5_var*
const
 c_ListKinds = [ns_sdkListInternal, ns_sdkList];
//#UC END# *52B375B038DC_573B090C02C5_var*
begin
//#UC START# *52B375B038DC_573B090C02C5_impl*
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  Result := True;
  if aDialog.DialogKind in c_ListKinds then
  begin
   if f_SaveObjDefault then
    f_SaveObjects := ns_sdlkTitles;
   if f_MergeDefault then
    f_MergeFiles := False;
   if f_SelOnlyDefault then
    f_SelectedOnly := True;
  end;
  f_FileName := ChangeFileExt(ParamStr(0), '.autosave');
  case f_FileFormat of
   ns_ffTxt: aDialog.FilterIndex := 2;
   ns_ffHTML: aDialog.FilterIndex := 3;
   ns_ffPDF: aDialog.FilterIndex := 4;
   ns_ffXML: aDialog.FilterIndex := 5;
   ns_ffEvd: aDialog.FilterIndex := 6;
   ns_ffNull: aDialog.FilterIndex := 7;
  else
   aDialog.FilterIndex := 1;
  end;
  Assert(aDialog.SelectedFileFormat = f_FileFormat);
  aDialog.FileName := f_FileName;
  if aDialog.DialogKind in c_ListKinds then
  begin
   aDialog.SaveListTarget := f_SaveObjects;
   aDialog.MergeChecked := f_MergeFiles;
   aDialog.SelectedOnlyChecked := f_SelectedOnly;
  end;
  f_SaveObjDefault := True;
  f_MergeDefault := True;
  f_SelOnlyDefault := True;
 end else
  Result := aDialog.Execute;
//#UC END# *52B375B038DC_573B090C02C5_impl*
end;//TnsSaveDialogImpl.Call

function TnsSaveDialogImpl.GetFileName: AnsiString;
//#UC START# *D50DF667C759_573B090C02C5_var*
//#UC END# *D50DF667C759_573B090C02C5_var*
begin
//#UC START# *D50DF667C759_573B090C02C5_impl*
 Result := f_FileName;
//#UC END# *D50DF667C759_573B090C02C5_impl*
end;//TnsSaveDialogImpl.GetFileName

procedure TnsSaveDialogImpl.SetFileName(const aName: AnsiString);
//#UC START# *8E32D0CAA2B7_573B090C02C5_var*
//#UC END# *8E32D0CAA2B7_573B090C02C5_var*
begin
//#UC START# *8E32D0CAA2B7_573B090C02C5_impl*
 f_FileName := aName;
//#UC END# *8E32D0CAA2B7_573B090C02C5_impl*
end;//TnsSaveDialogImpl.SetFileName

procedure TnsSaveDialogImpl.SetFileFormat(aFileFormat: TnsFileFormat);
//#UC START# *593F1F6D46A5_573B090C02C5_var*
//#UC END# *593F1F6D46A5_573B090C02C5_var*
begin
//#UC START# *593F1F6D46A5_573B090C02C5_impl*
 f_FileFormat := aFileFormat;
//#UC END# *593F1F6D46A5_573B090C02C5_impl*
end;//TnsSaveDialogImpl.SetFileFormat

procedure TnsSaveDialogImpl.SetSaveObjects(aValue: TnsSaveDialogListTarget);
//#UC START# *4020F60E166B_573B090C02C5_var*
//#UC END# *4020F60E166B_573B090C02C5_var*
begin
//#UC START# *4020F60E166B_573B090C02C5_impl*
 f_SaveObjDefault := False;
 f_SaveObjects := aValue;
//#UC END# *4020F60E166B_573B090C02C5_impl*
end;//TnsSaveDialogImpl.SetSaveObjects

procedure TnsSaveDialogImpl.SetMergeFiles(aValue: Boolean);
//#UC START# *8E9943B92E87_573B090C02C5_var*
//#UC END# *8E9943B92E87_573B090C02C5_var*
begin
//#UC START# *8E9943B92E87_573B090C02C5_impl*
 f_MergeDefault := False;
 f_MergeFiles := aValue;
//#UC END# *8E9943B92E87_573B090C02C5_impl*
end;//TnsSaveDialogImpl.SetMergeFiles

procedure TnsSaveDialogImpl.SetSelectedOnly(aValue: Boolean);
//#UC START# *242B3CA0CFEF_573B090C02C5_var*
//#UC END# *242B3CA0CFEF_573B090C02C5_var*
begin
//#UC START# *242B3CA0CFEF_573B090C02C5_impl*
 f_SelOnlyDefault := False;
 f_SelectedOnly := aValue;
//#UC END# *242B3CA0CFEF_573B090C02C5_impl*
end;//TnsSaveDialogImpl.SetSelectedOnly

class function TnsSaveDialogImpl.Instance: TnsSaveDialogImpl;
 {* Метод получения экземпляра синглетона TnsSaveDialogImpl }
begin
 if (g_TnsSaveDialogImpl = nil) then
 begin
  l3System.AddExitProc(TnsSaveDialogImplFree);
  g_TnsSaveDialogImpl := Create;
 end;
 Result := g_TnsSaveDialogImpl;
end;//TnsSaveDialogImpl.Instance

class function TnsSaveDialogImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsSaveDialogImpl <> nil;
end;//TnsSaveDialogImpl.Exists

procedure TnsSaveDialogImpl.InitFields;
//#UC START# *47A042E100E2_573B090C02C5_var*
//#UC END# *47A042E100E2_573B090C02C5_var*
begin
//#UC START# *47A042E100E2_573B090C02C5_impl*
 inherited;
 f_SaveObjDefault := True;
 f_MergeDefault := True;
 f_SelOnlyDefault := True;
//#UC END# *47A042E100E2_573B090C02C5_impl*
end;//TnsSaveDialogImpl.InitFields

initialization
 TnsSaveDialogExecutor.Instance.Alien := TnsSaveDialogImpl.Instance;
 {* Регистрация TnsSaveDialogImpl }
{$IfEnd} // Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
