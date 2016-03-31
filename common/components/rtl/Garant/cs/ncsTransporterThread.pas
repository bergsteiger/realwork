unit ncsTransporterThread;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTransporterThread.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsTransporterThread" MUID: (5452248C02B8)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Base
 , ncsMessageQueue
;

type
 TncsTransporterThread = class(Tl3ThreadContainer)
  private
   f_Queue: TncsMessageQueue;
    {* Поле для свойства Queue }
  protected
   function TerminatedConnection: Boolean; virtual;
   procedure DoExecute; override;
    {* основная процедура нити. Для перекрытия в потомках }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(anQueue: TncsMessageQueue); reintroduce;
  protected
   property Queue: TncsMessageQueue
    read f_Queue;
 end;//TncsTransporterThread
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
;

constructor TncsTransporterThread.Create(anQueue: TncsMessageQueue);
//#UC START# *5450EAAA0367_5452248C02B8_var*
//#UC END# *5450EAAA0367_5452248C02B8_var*
begin
//#UC START# *5450EAAA0367_5452248C02B8_impl*
 inherited Create;
 anQueue.SetRefTo(f_Queue);
//#UC END# *5450EAAA0367_5452248C02B8_impl*
end;//TncsTransporterThread.Create

function TncsTransporterThread.TerminatedConnection: Boolean;
//#UC START# *5459DB98029C_5452248C02B8_var*
//#UC END# *5459DB98029C_5452248C02B8_var*
begin
//#UC START# *5459DB98029C_5452248C02B8_impl*
 Result := Terminated or not Queue.Processing;
//#UC END# *5459DB98029C_5452248C02B8_impl*
end;//TncsTransporterThread.TerminatedConnection

procedure TncsTransporterThread.DoExecute;
 {* основная процедура нити. Для перекрытия в потомках }
//#UC START# *4911B69E037D_5452248C02B8_var*
//#UC END# *4911B69E037D_5452248C02B8_var*
begin
//#UC START# *4911B69E037D_5452248C02B8_impl*
 Assert(False);
//#UC END# *4911B69E037D_5452248C02B8_impl*
end;//TncsTransporterThread.DoExecute

procedure TncsTransporterThread.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5452248C02B8_var*
//#UC END# *479731C50290_5452248C02B8_var*
begin
//#UC START# *479731C50290_5452248C02B8_impl*
 FreeANdNil(f_Queue);
 inherited Cleanup;
//#UC END# *479731C50290_5452248C02B8_impl*
end;//TncsTransporterThread.Cleanup
{$IfEnd} // NOT Defined(Nemesis)

end.
