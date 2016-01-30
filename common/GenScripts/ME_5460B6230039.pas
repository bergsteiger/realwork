unit ncsTransporterIOThread;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTransporterIOThread.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsTransporterThread
 , csIdIOHandlerAbstractAdapter
;

type
 TncsTransporterIOThread = class(TncsTransporterThread)
  private
   f_IOHandler: TcsIdIOHandlerAbstractAdapter;
    {* Поле для свойства IOHandler }
  protected
   procedure pm_SetIOHandler(aValue: TcsIdIOHandlerAbstractAdapter); virtual;
   procedure ReleaseIOHandler;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function TerminatedConnection: Boolean; override;
  public
   property IOHandler: TcsIdIOHandlerAbstractAdapter
    read f_IOHandler
    write pm_SetIOHandler;
 end;//TncsTransporterIOThread
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
;

procedure TncsTransporterIOThread.pm_SetIOHandler(aValue: TcsIdIOHandlerAbstractAdapter);
//#UC START# *545224C80036_5460B6230039set_var*
//#UC END# *545224C80036_5460B6230039set_var*
begin
//#UC START# *545224C80036_5460B6230039set_impl*
 Assert(Suspended);
 aValue.SetRefTo(f_IOHandler);
//#UC END# *545224C80036_5460B6230039set_impl*
end;//TncsTransporterIOThread.pm_SetIOHandler

procedure TncsTransporterIOThread.ReleaseIOHandler;
//#UC START# *545B3DEA0268_5460B6230039_var*
//#UC END# *545B3DEA0268_5460B6230039_var*
begin
//#UC START# *545B3DEA0268_5460B6230039_impl*
 FreeAndNil(f_IOHandler);
//#UC END# *545B3DEA0268_5460B6230039_impl*
end;//TncsTransporterIOThread.ReleaseIOHandler

procedure TncsTransporterIOThread.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Nemesis)

end.
