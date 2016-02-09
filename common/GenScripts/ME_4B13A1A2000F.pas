unit nsCounterEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsCounterEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsPrimCachedEvent
 , LoggingUnit
;

type
 TnsCounterEvent = {abstract} class(TnsPrimCachedEvent)
  private
   f_Counter: Cardinal;
  protected
   function EventID: TLogEvent; virtual; abstract;
   procedure DoFireLog; override;
  public
   procedure Log;
 end;//TnsCounterEvent

implementation

uses
 l3ImplUses
 , LoggingWrapperInterfaces
 , nsLogEventData
 , nsLogManager
;

procedure TnsCounterEvent.Log;
//#UC START# *4B13A5F10200_4B13A1A2000F_var*
//#UC END# *4B13A5F10200_4B13A1A2000F_var*
begin
//#UC START# *4B13A5F10200_4B13A1A2000F_impl*
 Inc(f_Counter);
 RequestWrite;
//#UC END# *4B13A5F10200_4B13A1A2000F_impl*
end;//TnsCounterEvent.Log

procedure TnsCounterEvent.DoFireLog;
//#UC START# *4B13A1F202D9_4B13A1A2000F_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B13A1F202D9_4B13A1A2000F_var*
begin
//#UC START# *4B13A1F202D9_4B13A1A2000F_impl*
 if f_Counter > 0 then
 begin
  l_Data := MakeParamsList;
  l_Data.AddULong(f_Counter);
  GetLogger.AddEvent(EventID, l_Data);
  f_Counter := 0;
 end;
//#UC END# *4B13A1F202D9_4B13A1A2000F_impl*
end;//TnsCounterEvent.DoFireLog

end.
