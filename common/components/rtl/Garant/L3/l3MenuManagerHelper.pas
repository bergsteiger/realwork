unit l3MenuManagerHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MenuManagerHelper.pas"
// Стереотип: "Service"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3MenuManagerHelper = interface
  {* Контракт сервиса Tl3MenuManagerHelper }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Ml3MenuManagerHelper
 *)

type
 Il3MenuManagerHelper = interface
  {* Интерфейс сервиса Tl3MenuManagerHelper }
  ['{ECC961D9-9F47-4CCE-87B8-CBDE8D5ABCDA}']
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Il3MenuManagerHelper

 Tl3MenuManagerHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3MenuManagerHelper;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3MenuManagerHelper);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function CreateManager: Boolean;
   procedure FreeManager;
   class function Instance: Tl3MenuManagerHelper;
    {* Метод получения экземпляра синглетона Tl3MenuManagerHelper }
  public
   property Alien: Il3MenuManagerHelper
    write pm_SetAlien;
    {* Внешняя реализация сервиса Il3MenuManagerHelper }
 end;//Tl3MenuManagerHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3MenuManagerHelper: Tl3MenuManagerHelper = nil;
 {* Экземпляр синглетона Tl3MenuManagerHelper }

procedure Tl3MenuManagerHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3MenuManagerHelper }
begin
 l3Free(g_Tl3MenuManagerHelper);
end;//Tl3MenuManagerHelperFree

procedure Tl3MenuManagerHelper.pm_SetAlien(const aValue: Il3MenuManagerHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3MenuManagerHelper.pm_SetAlien

class function Tl3MenuManagerHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3MenuManagerHelper <> nil;
end;//Tl3MenuManagerHelper.Exists

function Tl3MenuManagerHelper.CreateManager: Boolean;
//#UC START# *9CBAC5378D28_550199070251_var*
//#UC END# *9CBAC5378D28_550199070251_var*
begin
//#UC START# *9CBAC5378D28_550199070251_impl*
if (f_Alien <> nil) then
  Result := f_Alien.CreateManager
 else
  Result := false; 
//#UC END# *9CBAC5378D28_550199070251_impl*
end;//Tl3MenuManagerHelper.CreateManager

procedure Tl3MenuManagerHelper.FreeManager;
//#UC START# *FFCD4B7E45D8_550199070251_var*
//#UC END# *FFCD4B7E45D8_550199070251_var*
begin
//#UC START# *FFCD4B7E45D8_550199070251_impl*
 if (f_Alien <> nil) then
  f_Alien.FreeManager;
//#UC END# *FFCD4B7E45D8_550199070251_impl*
end;//Tl3MenuManagerHelper.FreeManager

class function Tl3MenuManagerHelper.Instance: Tl3MenuManagerHelper;
 {* Метод получения экземпляра синглетона Tl3MenuManagerHelper }
begin
 if (g_Tl3MenuManagerHelper = nil) then
 begin
  l3System.AddExitProc(Tl3MenuManagerHelperFree);
  g_Tl3MenuManagerHelper := Create;
 end;
 Result := g_Tl3MenuManagerHelper;
end;//Tl3MenuManagerHelper.Instance

procedure Tl3MenuManagerHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3MenuManagerHelper.ClearFields

end.
