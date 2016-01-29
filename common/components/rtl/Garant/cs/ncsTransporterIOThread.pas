unit ncsTransporterIOThread;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsTransporterIOThread.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsTransporterIOThread
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csIdIOHandlerAbstractAdapter,
  ncsTransporterThread
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsTransporterIOThread = class(TncsTransporterThread)
 private
 // private fields
   f_IOHandler : TcsIdIOHandlerAbstractAdapter;
    {* Поле для свойства IOHandler}
 protected
 // property methods
   procedure pm_SetIOHandler(aValue: TcsIdIOHandlerAbstractAdapter); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function TerminatedConnection: Boolean; override;
 protected
 // protected methods
   procedure ReleaseIOHandler;
     {* Сигнатура метода ReleaseIOHandler }
 public
 // public properties
   property IOHandler: TcsIdIOHandlerAbstractAdapter
     read f_IOHandler
     write pm_SetIOHandler;
 end;//TncsTransporterIOThread
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsTransporterIOThread

procedure TncsTransporterIOThread.ReleaseIOHandler;
//#UC START# *545B3DEA0268_5460B6230039_var*
//#UC END# *545B3DEA0268_5460B6230039_var*
begin
//#UC START# *545B3DEA0268_5460B6230039_impl*
 FreeAndNil(f_IOHandler);
//#UC END# *545B3DEA0268_5460B6230039_impl*
end;//TncsTransporterIOThread.ReleaseIOHandler

procedure TncsTransporterIOThread.pm_SetIOHandler(aValue: TcsIdIOHandlerAbstractAdapter);
//#UC START# *545224C80036_5460B6230039set_var*
//#UC END# *545224C80036_5460B6230039set_var*
begin
//#UC START# *545224C80036_5460B6230039set_impl*
 Assert(Suspended);
 aValue.SetRefTo(f_IOHandler);
//#UC END# *545224C80036_5460B6230039set_impl*
end;//TncsTransporterIOThread.pm_SetIOHandler

procedure TncsTransporterIOThread.Cleanup;
//#UC START# *479731C50290_5460B6230039_var*
//#UC END# *479731C50290_5460B6230039_var*
begin
//#UC START# *479731C50290_5460B6230039_impl*
 FreeANdNil(f_IOHandler);
 inherited;
//#UC END# *479731C50290_5460B6230039_impl*
end;//TncsTransporterIOThread.Cleanup

function TncsTransporterIOThread.TerminatedConnection: Boolean;
//#UC START# *5459DB98029C_5460B6230039_var*
//#UC END# *5459DB98029C_5460B6230039_var*
begin
//#UC START# *5459DB98029C_5460B6230039_impl*
 Result := inherited TerminatedConnection or not IOHandler.Connected;
//#UC END# *5459DB98029C_5460B6230039_impl*
end;//TncsTransporterIOThread.TerminatedConnection

{$IfEnd} //not Nemesis

end.