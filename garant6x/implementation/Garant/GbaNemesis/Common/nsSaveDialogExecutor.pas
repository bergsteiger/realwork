unit nsSaveDialogExecutor;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsSaveDialogExecutor.pas"
// Стереотип: "Service"
// Элемент модели: "TnsSaveDialogExecutor" MUID: (573A0A7E0387)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , nsSaveDialog
 , nsTypes
 , PresentationInterfaces
;

 (*
 MnsSaveDialogExecutor = interface
  {* Контракт сервиса TnsSaveDialogExecutor }
  function Call(aDialog: TnsSaveDialog): Boolean;
  function GetFileName: AnsiString;
  procedure SetFileName(const aName: AnsiString);
  procedure SetFileFormat(aFileFormat: TnsFileFormat);
  procedure SetSaveObjects(aValue: TnsSaveDialogListTarget);
  procedure SetMergeFiles(aValue: Boolean);
  procedure SetSelectedOnly(aValue: Boolean);
 end;//MnsSaveDialogExecutor
 *)

type
 InsSaveDialogExecutor = interface
  {* Интерфейс сервиса TnsSaveDialogExecutor }
  function Call(aDialog: TnsSaveDialog): Boolean;
  function GetFileName: AnsiString;
  procedure SetFileName(const aName: AnsiString);
  procedure SetFileFormat(aFileFormat: TnsFileFormat);
  procedure SetSaveObjects(aValue: TnsSaveDialogListTarget);
  procedure SetMergeFiles(aValue: Boolean);
  procedure SetSelectedOnly(aValue: Boolean);
 end;//InsSaveDialogExecutor

 TnsSaveDialogExecutor = {final} class(Tl3ProtoObject)
  private
   f_Alien: InsSaveDialogExecutor;
    {* Внешняя реализация сервиса InsSaveDialogExecutor }
  protected
   procedure pm_SetAlien(const aValue: InsSaveDialogExecutor);
   procedure ClearFields; override;
  public
   function Call(aDialog: TnsSaveDialog): Boolean;
   function GetFileName: AnsiString;
   procedure SetFileName(const aName: AnsiString);
   procedure SetFileFormat(aFileFormat: TnsFileFormat);
   procedure SetSaveObjects(aValue: TnsSaveDialogListTarget);
   procedure SetMergeFiles(aValue: Boolean);
   procedure SetSelectedOnly(aValue: Boolean);
   class function Instance: TnsSaveDialogExecutor;
    {* Метод получения экземпляра синглетона TnsSaveDialogExecutor }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: InsSaveDialogExecutor
    write pm_SetAlien;
    {* Внешняя реализация сервиса InsSaveDialogExecutor }
 end;//TnsSaveDialogExecutor
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , nsSaveDialogImpl
 {$IfEnd} // Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SaveDialogWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *573A0A7E0387impl_uses*
 //#UC END# *573A0A7E0387impl_uses*
;

var g_TnsSaveDialogExecutor: TnsSaveDialogExecutor = nil;
 {* Экземпляр синглетона TnsSaveDialogExecutor }

procedure TnsSaveDialogExecutorFree;
 {* Метод освобождения экземпляра синглетона TnsSaveDialogExecutor }
begin
 l3Free(g_TnsSaveDialogExecutor);
end;//TnsSaveDialogExecutorFree

procedure TnsSaveDialogExecutor.pm_SetAlien(const aValue: InsSaveDialogExecutor);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TnsSaveDialogExecutor.pm_SetAlien

function TnsSaveDialogExecutor.Call(aDialog: TnsSaveDialog): Boolean;
//#UC START# *52B375B038DC_573A0A7E0387_var*
//#UC END# *52B375B038DC_573A0A7E0387_var*
begin
//#UC START# *52B375B038DC_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  Result := f_Alien.Call(aDialog)
 else
  Result := aDialog.Execute;
//#UC END# *52B375B038DC_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.Call

function TnsSaveDialogExecutor.GetFileName: AnsiString;
//#UC START# *D50DF667C759_573A0A7E0387_var*
//#UC END# *D50DF667C759_573A0A7E0387_var*
begin
//#UC START# *D50DF667C759_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  Result := f_Alien.GetFileName
 else
  Assert(False);
//#UC END# *D50DF667C759_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.GetFileName

procedure TnsSaveDialogExecutor.SetFileName(const aName: AnsiString);
//#UC START# *8E32D0CAA2B7_573A0A7E0387_var*
//#UC END# *8E32D0CAA2B7_573A0A7E0387_var*
begin
//#UC START# *8E32D0CAA2B7_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  f_Alien.SetFileName(aName)
 else
  Assert(False);
//#UC END# *8E32D0CAA2B7_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.SetFileName

procedure TnsSaveDialogExecutor.SetFileFormat(aFileFormat: TnsFileFormat);
//#UC START# *593F1F6D46A5_573A0A7E0387_var*
//#UC END# *593F1F6D46A5_573A0A7E0387_var*
begin
//#UC START# *593F1F6D46A5_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  f_Alien.SetFileFormat(aFileFormat)
 else
  Assert(False);
//#UC END# *593F1F6D46A5_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.SetFileFormat

procedure TnsSaveDialogExecutor.SetSaveObjects(aValue: TnsSaveDialogListTarget);
//#UC START# *4020F60E166B_573A0A7E0387_var*
//#UC END# *4020F60E166B_573A0A7E0387_var*
begin
//#UC START# *4020F60E166B_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  f_Alien.SetSaveObjects(aValue)
 else
  Assert(False);
//#UC END# *4020F60E166B_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.SetSaveObjects

procedure TnsSaveDialogExecutor.SetMergeFiles(aValue: Boolean);
//#UC START# *8E9943B92E87_573A0A7E0387_var*
//#UC END# *8E9943B92E87_573A0A7E0387_var*
begin
//#UC START# *8E9943B92E87_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  f_Alien.SetMergeFiles(aValue)
 else
  Assert(False);
//#UC END# *8E9943B92E87_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.SetMergeFiles

procedure TnsSaveDialogExecutor.SetSelectedOnly(aValue: Boolean);
//#UC START# *242B3CA0CFEF_573A0A7E0387_var*
//#UC END# *242B3CA0CFEF_573A0A7E0387_var*
begin
//#UC START# *242B3CA0CFEF_573A0A7E0387_impl*
 if Assigned(f_Alien) then
  f_Alien.SetSelectedOnly(aValue)
 else
  Assert(False);
//#UC END# *242B3CA0CFEF_573A0A7E0387_impl*
end;//TnsSaveDialogExecutor.SetSelectedOnly

class function TnsSaveDialogExecutor.Instance: TnsSaveDialogExecutor;
 {* Метод получения экземпляра синглетона TnsSaveDialogExecutor }
begin
 if (g_TnsSaveDialogExecutor = nil) then
 begin
  l3System.AddExitProc(TnsSaveDialogExecutorFree);
  g_TnsSaveDialogExecutor := Create;
 end;
 Result := g_TnsSaveDialogExecutor;
end;//TnsSaveDialogExecutor.Instance

class function TnsSaveDialogExecutor.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsSaveDialogExecutor <> nil;
end;//TnsSaveDialogExecutor.Exists

procedure TnsSaveDialogExecutor.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TnsSaveDialogExecutor.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
