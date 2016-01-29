unit SessionHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/SessionHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::ApplicationHelper::SessionHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

type
 SessionHelper = class
 private
 // private methods
   constructor Make; virtual;
 protected
 // property methods
   function pm_GetIsSessionActive: Boolean; virtual;
   procedure pm_SetIsSessionActive(aValue: Boolean); virtual;
 public
 // public properties
   property is_session_active: Boolean
     read pm_GetIsSessionActive
     write pm_SetIsSessionActive;
 public
 // singleton factory method
   class function Instance: SessionHelper;
    {- возвращает экземпляр синглетона. }
 end;//SessionHelper

implementation

uses
  l3Base {a}
  ;


// start class SessionHelper

var g_SessionHelper : SessionHelper = nil;

procedure SessionHelperFree;
begin
 l3Free(g_SessionHelper);
end;

class function SessionHelper.Instance: SessionHelper;
begin
 if (g_SessionHelper = nil) then
 begin
  l3System.AddExitProc(SessionHelperFree);
  g_SessionHelper := Create;
 end;
 Result := g_SessionHelper;
end;


function SessionHelper.pm_GetIsSessionActive: Boolean;
//#UC START# *47711DCF03A0_47711DA00052get_var*
//#UC END# *47711DCF03A0_47711DA00052get_var*
begin
//#UC START# *47711DCF03A0_47711DA00052get_impl*
 Result := f_is_session_active
//#UC END# *47711DCF03A0_47711DA00052get_impl*
end;//SessionHelper.pm_GetIsSessionActive

procedure SessionHelper.pm_SetIsSessionActive(aValue: Boolean);
//#UC START# *47711DCF03A0_47711DA00052set_var*
//#UC END# *47711DCF03A0_47711DA00052set_var*
begin
//#UC START# *47711DCF03A0_47711DA00052set_impl*
 f_is_session_active := aValue
//#UC END# *47711DCF03A0_47711DA00052set_impl*
end;//SessionHelper.pm_SetIsSessionActive

constructor SessionHelper.Make;
//#UC START# *477129B00039_47711DA00052_var*
//#UC END# *477129B00039_47711DA00052_var*
begin
//#UC START# *477129B00039_47711DA00052_impl*
 !!! Needs to be implemented !!!
//#UC END# *477129B00039_47711DA00052_impl*
end;//SessionHelper.Make

end.