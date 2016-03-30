unit SessionHelper;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SessionHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "SessionHelper" MUID: (47711DA00052)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 SessionHelper = class
  private
   constructor Make; reintroduce; virtual; stdcall;
  protected
   function GetIsSessionActive: ByteBool; virtual; stdcall;
   procedure SetIsSessionActive(const aValue: ByteBool); virtual; stdcall;
  public
   class function Exists: ByteBool; stdcall;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: SessionHelper;
    {* Метод получения экземпляра синглетона SessionHelper }
  public
   property IsSessionActive: ByteBool
    read GetIsSessionActive
    write SetIsSessionActive;
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

function SessionHelper.GetIsSessionActive: ByteBool;
//#UC START# *47711DCF03A0_47711DA00052get_var*
//#UC END# *47711DCF03A0_47711DA00052get_var*
begin
//#UC START# *47711DCF03A0_47711DA00052get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711DCF03A0_47711DA00052get_impl*
end;//SessionHelper.GetIsSessionActive

procedure SessionHelper.SetIsSessionActive(const aValue: ByteBool);
//#UC START# *47711DCF03A0_47711DA00052set_var*
//#UC END# *47711DCF03A0_47711DA00052set_var*
begin
//#UC START# *47711DCF03A0_47711DA00052set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711DCF03A0_47711DA00052set_impl*
end;//SessionHelper.SetIsSessionActive

constructor SessionHelper.Make;
//#UC START# *477129B00039_47711DA00052_var*
//#UC END# *477129B00039_47711DA00052_var*
begin
//#UC START# *477129B00039_47711DA00052_impl*
 !!! Needs to be implemented !!!
//#UC END# *477129B00039_47711DA00052_impl*
end;//SessionHelper.Make

class function SessionHelper.Exists: ByteBool;
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
