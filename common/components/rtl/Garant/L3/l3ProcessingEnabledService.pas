unit l3ProcessingEnabledService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProcessingEnabledService.pas"
// Стереотип: "Service"
// Элемент модели: "Tl3ProcessingEnabledService" MUID: (561CEB90011D)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3ProcessingEnabledService = interface
  {* Контракт сервиса Tl3ProcessingEnabledService }
  function Enabled: Boolean;
 end;//Ml3ProcessingEnabledService
 *)

type
 Il3ProcessingEnabledService = interface
  {* Интерфейс сервиса Tl3ProcessingEnabledService }
  function Enabled: Boolean;
 end;//Il3ProcessingEnabledService

 Tl3ProcessingEnabledService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ProcessingEnabledService;
    {* Внешняя реализация сервиса Il3ProcessingEnabledService }
  protected
   procedure pm_SetAlien(const aValue: Il3ProcessingEnabledService);
   procedure ClearFields; override;
  public
   function Enabled: Boolean;
   class function Instance: Tl3ProcessingEnabledService;
    {* Метод получения экземпляра синглетона Tl3ProcessingEnabledService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3ProcessingEnabledService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3ProcessingEnabledService }
 end;//Tl3ProcessingEnabledService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *561CEB90011Dimpl_uses*
 //#UC END# *561CEB90011Dimpl_uses*
;

var g_Tl3ProcessingEnabledService: Tl3ProcessingEnabledService = nil;
 {* Экземпляр синглетона Tl3ProcessingEnabledService }

procedure Tl3ProcessingEnabledServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3ProcessingEnabledService }
begin
 l3Free(g_Tl3ProcessingEnabledService);
end;//Tl3ProcessingEnabledServiceFree

procedure Tl3ProcessingEnabledService.pm_SetAlien(const aValue: Il3ProcessingEnabledService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ProcessingEnabledService.pm_SetAlien

function Tl3ProcessingEnabledService.Enabled: Boolean;
//#UC START# *561CEBC40218_561CEB90011D_var*
//#UC END# *561CEBC40218_561CEB90011D_var*
begin
//#UC START# *561CEBC40218_561CEB90011D_impl*
 Result := Assigned(f_Alien) and f_Alien.Enabled;
//#UC END# *561CEBC40218_561CEB90011D_impl*
end;//Tl3ProcessingEnabledService.Enabled

class function Tl3ProcessingEnabledService.Instance: Tl3ProcessingEnabledService;
 {* Метод получения экземпляра синглетона Tl3ProcessingEnabledService }
begin
 if (g_Tl3ProcessingEnabledService = nil) then
 begin
  l3System.AddExitProc(Tl3ProcessingEnabledServiceFree);
  g_Tl3ProcessingEnabledService := Create;
 end;
 Result := g_Tl3ProcessingEnabledService;
end;//Tl3ProcessingEnabledService.Instance

class function Tl3ProcessingEnabledService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ProcessingEnabledService <> nil;
end;//Tl3ProcessingEnabledService.Exists

procedure Tl3ProcessingEnabledService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ProcessingEnabledService.ClearFields

end.
