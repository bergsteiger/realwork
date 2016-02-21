unit l3DocumentsCacheService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3DocumentsCacheService.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3DocumentsCacheService = interface
  {* Контракт сервиса Tl3DocumentsCacheService }
  procedure Clear;
 end;//Ml3DocumentsCacheService
 *)

type
 Il3DocumentsCacheService = interface
  {* Интерфейс сервиса Tl3DocumentsCacheService }
  ['{A7573672-88C4-4CF0-8F63-F2AD42FA8794}']
  procedure Clear;
 end;//Il3DocumentsCacheService

 Tl3DocumentsCacheService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3DocumentsCacheService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3DocumentsCacheService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure Clear;
   class function Instance: Tl3DocumentsCacheService;
    {* Метод получения экземпляра синглетона Tl3DocumentsCacheService }
  public
   property Alien: Il3DocumentsCacheService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3DocumentsCacheService }
 end;//Tl3DocumentsCacheService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3DocumentsCacheService: Tl3DocumentsCacheService = nil;
 {* Экземпляр синглетона Tl3DocumentsCacheService }

procedure Tl3DocumentsCacheServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3DocumentsCacheService }
begin
 l3Free(g_Tl3DocumentsCacheService);
end;//Tl3DocumentsCacheServiceFree

procedure Tl3DocumentsCacheService.pm_SetAlien(const aValue: Il3DocumentsCacheService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3DocumentsCacheService.pm_SetAlien

class function Tl3DocumentsCacheService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3DocumentsCacheService <> nil;
end;//Tl3DocumentsCacheService.Exists

procedure Tl3DocumentsCacheService.Clear;
//#UC START# *0AC8DEBDD602_5506FEA6012A_var*
//#UC END# *0AC8DEBDD602_5506FEA6012A_var*
begin
//#UC START# *0AC8DEBDD602_5506FEA6012A_impl*
 if (f_Alien <> nil) then
  f_Alien.Clear;
//#UC END# *0AC8DEBDD602_5506FEA6012A_impl*
end;//Tl3DocumentsCacheService.Clear

class function Tl3DocumentsCacheService.Instance: Tl3DocumentsCacheService;
 {* Метод получения экземпляра синглетона Tl3DocumentsCacheService }
begin
 if (g_Tl3DocumentsCacheService = nil) then
 begin
  l3System.AddExitProc(Tl3DocumentsCacheServiceFree);
  g_Tl3DocumentsCacheService := Create;
 end;
 Result := g_Tl3DocumentsCacheService;
end;//Tl3DocumentsCacheService.Instance

procedure Tl3DocumentsCacheService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3DocumentsCacheService.ClearFields

end.
