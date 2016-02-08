unit l3KeyboardLayoutService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3KeyboardLayoutService.pas"
// Стереотип: "Service"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3KeyboardLayoutService = interface
  {* Контракт сервиса Tl3KeyboardLayoutService }
  procedure TryActivateKeyboardLayout;
 end;//Ml3KeyboardLayoutService
 *)

type
 Il3KeyboardLayoutService = interface
  {* Интерфейс сервиса Tl3KeyboardLayoutService }
  ['{B81FD1FC-A13C-4F60-A0D1-0D1F2E636216}']
  procedure TryActivateKeyboardLayout;
 end;//Il3KeyboardLayoutService

 Tl3KeyboardLayoutService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3KeyboardLayoutService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3KeyboardLayoutService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   procedure TryActivateKeyboardLayout;
   class function Instance: Tl3KeyboardLayoutService;
    {* Метод получения экземпляра синглетона Tl3KeyboardLayoutService }
  public
   property Alien: Il3KeyboardLayoutService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3KeyboardLayoutService }
 end;//Tl3KeyboardLayoutService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3KeyboardLayoutService: Tl3KeyboardLayoutService = nil;
 {* Экземпляр синглетона Tl3KeyboardLayoutService }

procedure Tl3KeyboardLayoutServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3KeyboardLayoutService }
begin
 l3Free(g_Tl3KeyboardLayoutService);
end;//Tl3KeyboardLayoutServiceFree

procedure Tl3KeyboardLayoutService.pm_SetAlien(const aValue: Il3KeyboardLayoutService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3KeyboardLayoutService.pm_SetAlien

class function Tl3KeyboardLayoutService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3KeyboardLayoutService <> nil;
end;//Tl3KeyboardLayoutService.Exists

procedure Tl3KeyboardLayoutService.TryActivateKeyboardLayout;
//#UC START# *747558CBA739_55099A8303E1_var*
//#UC END# *747558CBA739_55099A8303E1_var*
begin
//#UC START# *747558CBA739_55099A8303E1_impl*
 if (f_Alien <> nil) then
  f_Alien.TryActivateKeyboardLayout;
//#UC END# *747558CBA739_55099A8303E1_impl*
end;//Tl3KeyboardLayoutService.TryActivateKeyboardLayout

class function Tl3KeyboardLayoutService.Instance: Tl3KeyboardLayoutService;
 {* Метод получения экземпляра синглетона Tl3KeyboardLayoutService }
begin
 if (g_Tl3KeyboardLayoutService = nil) then
 begin
  l3System.AddExitProc(Tl3KeyboardLayoutServiceFree);
  g_Tl3KeyboardLayoutService := Create;
 end;
 Result := g_Tl3KeyboardLayoutService;
end;//Tl3KeyboardLayoutService.Instance

procedure Tl3KeyboardLayoutService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3KeyboardLayoutService.ClearFields

end.
