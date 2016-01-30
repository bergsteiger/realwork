unit SessionHelper;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SessionHelper.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 SessionHelper = class
  private
   constructor make; reintroduce; virtual;
  protected
   function pm_Getis_session_active: Boolean; virtual;
   procedure pm_Setis_session_active(aValue: Boolean); virtual;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: SessionHelper;
    {* Метод получения экземпляра синглетона SessionHelper }
  public
   property is_session_active: Boolean
    read pm_Getis_session_active
    write pm_Setis_session_active;
 end;//SessionHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_SessionHelper: SessionHelper = nil;
 {* Экземпляр синглетона SessionHelper }

procedure SessionHelperFree;
 {* Метод освобождения экземпляра синглетона SessionHelper }
begin
 l3Free(g_SessionHelper);
end;//SessionHelperFree

function SessionHelper.pm_Getis_session_active: Boolean;
//#UC START# *47711DCF03A0_47711DA00052get_var*
//#UC END# *47711DCF03A0_47711DA00052get_var*
begin
//#UC START# *47711DCF03A0_47711DA00052get_impl*
 Result := f_is_session_active
//#UC END# *47711DCF03A0_47711DA00052get_impl*
end;//SessionHelper.pm_Getis_session_active

procedure SessionHelper.pm_Setis_session_active(aValue: Boolean);
//#UC START# *47711DCF03A0_47711DA00052set_var*
//#UC END# *47711DCF03A0_47711DA00052set_var*
begin
//#UC START# *47711DCF03A0_47711DA00052set_impl*
 f_is_session_active := aValue
//#UC END# *47711DCF03A0_47711DA00052set_impl*
end;//SessionHelper.pm_Setis_session_active

constructor SessionHelper.make;
//#UC START# *477129B00039_47711DA00052_var*
//#UC END# *477129B00039_47711DA00052_var*
begin
//#UC START# *477129B00039_47711DA00052_impl*
 !!! Needs to be implemented !!!
//#UC END# *477129B00039_47711DA00052_impl*
end;//SessionHelper.make

class function SessionHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_SessionHelper <> nil;
end;//SessionHelper.Exists

class function SessionHelper.Instance: SessionHelper;
 {* Метод получения экземпляра синглетона SessionHelper }
begin
 if (g_SessionHelper = nil) then
 begin
  l3System.AddExitProc(SessionHelperFree);
  g_SessionHelper := Create;
 end;
 Result := g_SessionHelper;
end;//SessionHelper.Instance

end.
