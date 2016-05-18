unit l3DialogService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3DialogService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3DialogService" MUID: (573A0A7E0387)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

 (*
 Ml3DialogService = interface
  {* Контракт сервиса Tl3DialogService }
  function CallExecute(aDialog: TCommonDialog): Boolean;
 end;//Ml3DialogService
 *)

type
 Il3DialogService = interface
  {* Интерфейс сервиса Tl3DialogService }
  ['{707E704B-202F-4512-90B2-070DD76980A2}']
  function CallExecute(aDialog: TCommonDialog): Boolean;
 end;//Il3DialogService

 Tl3DialogService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3DialogService;
    {* Внешняя реализация сервиса Il3DialogService }
  protected
   procedure pm_SetAlien(const aValue: Il3DialogService);
   procedure ClearFields; override;
  public
   function CallExecute(aDialog: TCommonDialog): Boolean;
   class function Instance: Tl3DialogService;
    {* Метод получения экземпляра синглетона Tl3DialogService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3DialogService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3DialogService }
 end;//Tl3DialogService

implementation

uses
 l3ImplUses
 , l3DialogServiceImpl
 , SysUtils
 , l3Base
;

var g_Tl3DialogService: Tl3DialogService = nil;
 {* Экземпляр синглетона Tl3DialogService }

procedure Tl3DialogServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3DialogService }
begin
 l3Free(g_Tl3DialogService);
end;//Tl3DialogServiceFree

procedure Tl3DialogService.pm_SetAlien(const aValue: Il3DialogService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3DialogService.pm_SetAlien

function Tl3DialogService.CallExecute(aDialog: TCommonDialog): Boolean;
//#UC START# *52B375B038DC_573A0A7E0387_var*
//#UC END# *52B375B038DC_573A0A7E0387_var*
begin
//#UC START# *52B375B038DC_573A0A7E0387_impl*
 if Assigned(f_Alien)
  then Result := f_Alien.CallExecute(aDialog)
  else Result := aDialog.Execute;
//#UC END# *52B375B038DC_573A0A7E0387_impl*
end;//Tl3DialogService.CallExecute

class function Tl3DialogService.Instance: Tl3DialogService;
 {* Метод получения экземпляра синглетона Tl3DialogService }
begin
 if (g_Tl3DialogService = nil) then
 begin
  l3System.AddExitProc(Tl3DialogServiceFree);
  g_Tl3DialogService := Create;
 end;
 Result := g_Tl3DialogService;
end;//Tl3DialogService.Instance

class function Tl3DialogService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3DialogService <> nil;
end;//Tl3DialogService.Exists

procedure Tl3DialogService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3DialogService.ClearFields

end.
