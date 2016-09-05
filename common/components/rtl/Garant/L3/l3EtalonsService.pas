unit l3EtalonsService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3EtalonsService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3EtalonsService" MUID: (555F49A0015B)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3EtalonsService = interface
  {* Контракт сервиса Tl3EtalonsService }
 end;//Ml3EtalonsService
 *)

type
 Il3EtalonsService = interface
  {* Интерфейс сервиса Tl3EtalonsService }
 end;//Il3EtalonsService

 Tl3EtalonsService = {final} class(Tl3ProtoObject)
  private
   f_EtalonNeedsComputerName: Boolean;
   f_EtalonNeedsOSName: Boolean;
   {$If Defined(XE)}
   f_EtalonNeedsXE: Boolean;
   {$IfEnd} // Defined(XE)
   f_EtalonNeeds64: Boolean;
   f_Alien: Il3EtalonsService;
    {* Внешняя реализация сервиса Il3EtalonsService }
  protected
   procedure pm_SetAlien(const aValue: Il3EtalonsService);
   procedure ClearFields; override;
  public
   class function Instance: Tl3EtalonsService;
    {* Метод получения экземпляра синглетона Tl3EtalonsService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property EtalonNeedsComputerName: Boolean
    read f_EtalonNeedsComputerName
    write f_EtalonNeedsComputerName;
   property EtalonNeedsOSName: Boolean
    read f_EtalonNeedsOSName
    write f_EtalonNeedsOSName;
   {$If Defined(XE)}
   property EtalonNeedsXE: Boolean
    read f_EtalonNeedsXE
    write f_EtalonNeedsXE;
   {$IfEnd} // Defined(XE)
   property EtalonNeeds64: Boolean
    read f_EtalonNeeds64
    write f_EtalonNeeds64;
   property Alien: Il3EtalonsService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3EtalonsService }
 end;//Tl3EtalonsService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *555F49A0015Bimpl_uses*
 //#UC END# *555F49A0015Bimpl_uses*
;

var g_Tl3EtalonsService: Tl3EtalonsService = nil;
 {* Экземпляр синглетона Tl3EtalonsService }

procedure Tl3EtalonsServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3EtalonsService }
begin
 l3Free(g_Tl3EtalonsService);
end;//Tl3EtalonsServiceFree

procedure Tl3EtalonsService.pm_SetAlien(const aValue: Il3EtalonsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3EtalonsService.pm_SetAlien

class function Tl3EtalonsService.Instance: Tl3EtalonsService;
 {* Метод получения экземпляра синглетона Tl3EtalonsService }
begin
 if (g_Tl3EtalonsService = nil) then
 begin
  l3System.AddExitProc(Tl3EtalonsServiceFree);
  g_Tl3EtalonsService := Create;
 end;
 Result := g_Tl3EtalonsService;
end;//Tl3EtalonsService.Instance

class function Tl3EtalonsService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3EtalonsService <> nil;
end;//Tl3EtalonsService.Exists

procedure Tl3EtalonsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3EtalonsService.ClearFields

end.
