unit m3StorageService;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageService.pas"
// Стереотип: "Service"
// Элемент модели: "Tm3StorageService" MUID: (5551C8670144)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , SyncObjs
;

 (*
 Mm3StorageService = interface
  {* Контракт сервиса Tm3StorageService }
  function UseSplitted: Boolean;
  function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Mm3StorageService
 *)

type
 Im3StorageService = interface
  {* Интерфейс сервиса Tm3StorageService }
  function UseSplitted: Boolean;
  function SetUseSplitted(aValue: Boolean): Boolean;
 end;//Im3StorageService

 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3StorageService = {final} class(_l3CriticalSectionHolder_)
  private
   f_UseSplitted: Boolean;
   f_Alien: Im3StorageService;
    {* Внешняя реализация сервиса Im3StorageService }
  protected
   procedure pm_SetAlien(const aValue: Im3StorageService);
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   function UseSplitted: Boolean;
   function SetUseSplitted(aValue: Boolean): Boolean;
   class function Instance: Tm3StorageService;
    {* Метод получения экземпляра синглетона Tm3StorageService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Im3StorageService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Im3StorageService }
 end;//Tm3StorageService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tm3StorageService: Tm3StorageService = nil;
 {* Экземпляр синглетона Tm3StorageService }

procedure Tm3StorageServiceFree;
 {* Метод освобождения экземпляра синглетона Tm3StorageService }
begin
 l3Free(g_Tm3StorageService);
end;//Tm3StorageServiceFree

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

procedure Tm3StorageService.pm_SetAlien(const aValue: Im3StorageService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tm3StorageService.pm_SetAlien

function Tm3StorageService.UseSplitted: Boolean;
//#UC START# *AA9D589FDBFC_5551C8670144_var*
//#UC END# *AA9D589FDBFC_5551C8670144_var*
begin
//#UC START# *AA9D589FDBFC_5551C8670144_impl*
 Lock;
 try
  if (f_Alien <> nil) then
   Result := f_Alien.UseSplitted
  else
   Result := f_UseSplitted;
 finally
  Unlock;
 end;//try..finally
//#UC END# *AA9D589FDBFC_5551C8670144_impl*
end;//Tm3StorageService.UseSplitted

function Tm3StorageService.SetUseSplitted(aValue: Boolean): Boolean;
//#UC START# *FEF2A1107807_5551C8670144_var*
//#UC END# *FEF2A1107807_5551C8670144_var*
begin
//#UC START# *FEF2A1107807_5551C8670144_impl*
 Lock;
 try
  if (f_Alien <> nil) then
   Result := f_Alien.SetUseSplitted(aValue)
  else
  begin
   Result := f_UseSplitted;
   f_UseSplitted := aValue;
  end;//f_Alien <> nil
 finally
  Unlock;
 end;//try..finally
//#UC END# *FEF2A1107807_5551C8670144_impl*
end;//Tm3StorageService.SetUseSplitted

class function Tm3StorageService.Instance: Tm3StorageService;
 {* Метод получения экземпляра синглетона Tm3StorageService }
begin
 if (g_Tm3StorageService = nil) then
 begin
  l3System.AddExitProc(Tm3StorageServiceFree);
  g_Tm3StorageService := Create;
 end;
 Result := g_Tm3StorageService;
end;//Tm3StorageService.Instance

class function Tm3StorageService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tm3StorageService <> nil;
end;//Tm3StorageService.Exists

procedure Tm3StorageService.InitFields;
//#UC START# *47A042E100E2_5551C8670144_var*
//#UC END# *47A042E100E2_5551C8670144_var*
begin
//#UC START# *47A042E100E2_5551C8670144_impl*
 inherited;
 f_UseSplitted := true;
//#UC END# *47A042E100E2_5551C8670144_impl*
end;//Tm3StorageService.InitFields

procedure Tm3StorageService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tm3StorageService.ClearFields

end.
