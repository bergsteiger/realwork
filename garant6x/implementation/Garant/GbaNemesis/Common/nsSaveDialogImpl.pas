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
 , nsSaveDialog
;

type
 TnsSaveDialogImpl = {final} class(Tl3ProtoObject, InsSaveDialogExecutor)
  private
   f_FileFormat: TnsFileFormat;
   f_FileName: AnsiString;
  public
   function Call(aDialog: TnsSaveDialog): Boolean;
   function GetFileName: AnsiString;
   procedure SetFileFormat(aFileFormat: TnsFileFormat);
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
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3BatchService
 , SysUtils
 , l3Base
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
//#UC END# *52B375B038DC_573B090C02C5_var*
begin
//#UC START# *52B375B038DC_573B090C02C5_impl*
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  Result := True;
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

procedure TnsSaveDialogImpl.SetFileFormat(aFileFormat: TnsFileFormat);
//#UC START# *593F1F6D46A5_573B090C02C5_var*
//#UC END# *593F1F6D46A5_573B090C02C5_var*
begin
//#UC START# *593F1F6D46A5_573B090C02C5_impl*
 f_FileFormat := aFileFormat;
//#UC END# *593F1F6D46A5_573B090C02C5_impl*
end;//TnsSaveDialogImpl.SetFileFormat

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

initialization
 TnsSaveDialogExecutor.Instance.Alien := TnsSaveDialogImpl.Instance;
 {* Регистрация TnsSaveDialogImpl }
{$IfEnd} // Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
