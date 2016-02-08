unit l3EtalonsService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3EtalonsService.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

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
  ['{61640207-46D1-41DC-A087-0DC7D620B901}']
 end;//Il3EtalonsService

 Tl3EtalonsService = {final} class(Tl3ProtoObject)
  private
   f_EtalonNeedsComputerName: Boolean;
    {* Поле для свойства EtalonNeedsComputerName }
   f_EtalonNeedsOSName: Boolean;
    {* Поле для свойства EtalonNeedsOSName }
   {$If Defined(XE)}
   f_EtalonNeedsXE: Boolean;
    {* Поле для свойства EtalonNeedsXE }
   {$IfEnd} // Defined(XE)
   f_EtalonNeeds64: Boolean;
    {* Поле для свойства EtalonNeeds64 }
   f_Alien: Il3EtalonsService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3EtalonsService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tl3EtalonsService;
    {* Метод получения экземпляра синглетона Tl3EtalonsService }
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

class function Tl3EtalonsService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3EtalonsService <> nil;
end;//Tl3EtalonsService.Exists

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

procedure Tl3EtalonsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3EtalonsService.ClearFields

end.
