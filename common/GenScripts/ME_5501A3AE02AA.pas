unit l3DispatcherHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3DispatcherHelper.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3DispatcherHelper = interface
  {* Контракт сервиса Tl3DispatcherHelper }
  procedure ClearHistory;
 end;//Ml3DispatcherHelper
 *)

type
 Il3DispatcherHelper = interface
  {* Интерфейс сервиса Tl3DispatcherHelper }
  ['{BF29E5DD-DC50-4752-800C-CA9E91242A15}']
  procedure ClearHistory;
 end;//Il3DispatcherHelper

 Tl3DispatcherHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3DispatcherHelper;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3DispatcherHelper);
   procedure ClearFields; override;
  public
   procedure ClearHistory;
   class function Instance: Tl3DispatcherHelper;
    {* Метод получения экземпляра синглетона Tl3DispatcherHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: Il3DispatcherHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3DispatcherHelper }
 end;//Tl3DispatcherHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3DispatcherHelper: Tl3DispatcherHelper = nil;
 {* Экземпляр синглетона Tl3DispatcherHelper }

procedure Tl3DispatcherHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3DispatcherHelper }
begin
 l3Free(g_Tl3DispatcherHelper);
end;//Tl3DispatcherHelperFree

procedure Tl3DispatcherHelper.pm_SetAlien(const aValue: Il3DispatcherHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3DispatcherHelper.pm_SetAlien

procedure Tl3DispatcherHelper.ClearHistory;
//#UC START# *CA1F3F463873_5501A3AE02AA_var*
//#UC END# *CA1F3F463873_5501A3AE02AA_var*
begin
//#UC START# *CA1F3F463873_5501A3AE02AA_impl*
 if (f_Alien <> nil) then
  f_Alien.ClearHistory;
//#UC END# *CA1F3F463873_5501A3AE02AA_impl*
end;//Tl3DispatcherHelper.ClearHistory

class function Tl3DispatcherHelper.Instance: Tl3DispatcherHelper;
 {* Метод получения экземпляра синглетона Tl3DispatcherHelper }
begin
 if (g_Tl3DispatcherHelper = nil) then
 begin
  l3System.AddExitProc(Tl3DispatcherHelperFree);
  g_Tl3DispatcherHelper := Create;
 end;
 Result := g_Tl3DispatcherHelper;
end;//Tl3DispatcherHelper.Instance

class function Tl3DispatcherHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3DispatcherHelper <> nil;
end;//Tl3DispatcherHelper.Exists

procedure Tl3DispatcherHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3DispatcherHelper.ClearFields

end.
