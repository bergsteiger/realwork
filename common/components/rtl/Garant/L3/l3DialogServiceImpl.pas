unit l3DialogServiceImpl;

// Модуль: "w:\common\components\rtl\Garant\L3\l3DialogServiceImpl.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "Tl3DialogServiceImpl" MUID: (573B090C02C5)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3DialogService
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 Tl3DialogServiceImpl = {final} class(Tl3ProtoObject, Il3DialogService)
  public
   function CallExecute(aDialog: TCommonDialog): Boolean;
   class function Instance: Tl3DialogServiceImpl;
    {* Метод получения экземпляра синглетона Tl3DialogServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3DialogServiceImpl

implementation

uses
 l3ImplUses
 , l3BatchService
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
;

var g_Tl3DialogServiceImpl: Tl3DialogServiceImpl = nil;
 {* Экземпляр синглетона Tl3DialogServiceImpl }

procedure Tl3DialogServiceImplFree;
 {* Метод освобождения экземпляра синглетона Tl3DialogServiceImpl }
begin
 l3Free(g_Tl3DialogServiceImpl);
end;//Tl3DialogServiceImplFree

function Tl3DialogServiceImpl.CallExecute(aDialog: TCommonDialog): Boolean;
//#UC START# *52B375B038DC_573B090C02C5_var*
//#UC END# *52B375B038DC_573B090C02C5_var*
begin
//#UC START# *52B375B038DC_573B090C02C5_impl*
{$ifdef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
  if (aDialog is TSaveDialog) then // пока вроде Open не нужен
  begin
   Result := True;
   TSaveDialog(aDialog).FileName := ChangeFileExt(Application.ExeName, '.autosave');
   Exit;
  end;
{$endif}
 Result := aDialog.Execute;
//#UC END# *52B375B038DC_573B090C02C5_impl*
end;//Tl3DialogServiceImpl.CallExecute

class function Tl3DialogServiceImpl.Instance: Tl3DialogServiceImpl;
 {* Метод получения экземпляра синглетона Tl3DialogServiceImpl }
begin
 if (g_Tl3DialogServiceImpl = nil) then
 begin
  l3System.AddExitProc(Tl3DialogServiceImplFree);
  g_Tl3DialogServiceImpl := Create;
 end;
 Result := g_Tl3DialogServiceImpl;
end;//Tl3DialogServiceImpl.Instance

class function Tl3DialogServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3DialogServiceImpl <> nil;
end;//Tl3DialogServiceImpl.Exists

initialization
 Tl3DialogService.Instance.Alien := Tl3DialogServiceImpl.Instance;
 {* Регистрация Tl3DialogServiceImpl }

end.
