unit ncsTransporterThread;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsTransporterThread.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsTransporterThread
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
  l3Base,
  ncsMessageQueue
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsTransporterThread = class(Tl3ThreadContainer)
 private
 // private fields
   f_Queue : TncsMessageQueue;
    {* Поле для свойства Queue}
 protected
 // realized methods
   procedure DoExecute; override;
     {* основная процедура нити. Для перекрытия в потомках }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function TerminatedConnection: Boolean; virtual;
 public
 // public methods
   constructor Create(anQueue: TncsMessageQueue); reintroduce;
 protected
 // protected properties
   property Queue: TncsMessageQueue
     read f_Queue;
 end;//TncsTransporterThread
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsTransporterThread

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
//#UC START# *4911B69E037D_5452248C02B8_var*
//#UC END# *4911B69E037D_5452248C02B8_var*
begin
//#UC START# *4911B69E037D_5452248C02B8_impl*
 Assert(False);
//#UC END# *4911B69E037D_5452248C02B8_impl*
end;//TncsTransporterThread.DoExecute

procedure TncsTransporterThread.Cleanup;
//#UC START# *479731C50290_5452248C02B8_var*
//#UC END# *479731C50290_5452248C02B8_var*
begin
//#UC START# *479731C50290_5452248C02B8_impl*
 FreeANdNil(f_Queue);
 inherited Cleanup;
//#UC END# *479731C50290_5452248C02B8_impl*
end;//TncsTransporterThread.Cleanup

{$IfEnd} //not Nemesis

end.