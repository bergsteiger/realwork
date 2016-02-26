unit l3PopupControlService;

// Модуль: "w:\common\components\rtl\Garant\L3\l3PopupControlService.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Windows
;

 (*
 Ml3PopupControlService = interface
  {* Контракт сервиса Tl3PopupControlService }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Ml3PopupControlService
 *)

type
 Il3PopupControlService = interface
  {* Интерфейс сервиса Tl3PopupControlService }
  ['{C4427BB1-962C-43A9-82FB-9DC18D0EB557}']
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Il3PopupControlService

 Tl3PopupControlService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3PopupControlService;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3PopupControlService);
   procedure ClearFields; override;
  public
   function IsPopupControlWindow(aControlWnd: HWND): Boolean;
   class function Instance: Tl3PopupControlService;
    {* Метод получения экземпляра синглетона Tl3PopupControlService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3PopupControlService
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3PopupControlService }
 end;//Tl3PopupControlService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3PopupControlService: Tl3PopupControlService = nil;
 {* Экземпляр синглетона Tl3PopupControlService }

procedure Tl3PopupControlServiceFree;
 {* Метод освобождения экземпляра синглетона Tl3PopupControlService }
begin
 l3Free(g_Tl3PopupControlService);
end;//Tl3PopupControlServiceFree

procedure Tl3PopupControlService.pm_SetAlien(const aValue: Il3PopupControlService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3PopupControlService.pm_SetAlien

function Tl3PopupControlService.IsPopupControlWindow(aControlWnd: HWND): Boolean;
//#UC START# *D2E4642CC7BC_55879E12008D_var*
const
 cMenuClassName: String = '#32768';
var
 l_ClassName: String;
//#UC END# *D2E4642CC7BC_55879E12008D_var*
begin
//#UC START# *D2E4642CC7BC_55879E12008D_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.IsPopupControlWindow(aControlWnd)
 else
 begin
  SetLength(l_ClassName, 128);
  GetClassName(aControlWnd, PChar(l_ClassName), 128);
  l_ClassName := PChar(l_ClassName);
  Result := (l_ClassName = cMenuClassName);
 end;
//#UC END# *D2E4642CC7BC_55879E12008D_impl*
end;//Tl3PopupControlService.IsPopupControlWindow

class function Tl3PopupControlService.Instance: Tl3PopupControlService;
 {* Метод получения экземпляра синглетона Tl3PopupControlService }
begin
 if (g_Tl3PopupControlService = nil) then
 begin
  l3System.AddExitProc(Tl3PopupControlServiceFree);
  g_Tl3PopupControlService := Create;
 end;
 Result := g_Tl3PopupControlService;
end;//Tl3PopupControlService.Instance

class function Tl3PopupControlService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3PopupControlService <> nil;
end;//Tl3PopupControlService.Exists

procedure Tl3PopupControlService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3PopupControlService.ClearFields

end.
