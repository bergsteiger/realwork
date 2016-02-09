unit nsPrimCachedEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsPrimCachedEvent.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsLogEvent
 , LoggingInterfaces
;

type
 TnsPrimCachedEvent = {abstract} class(TnsLogEvent, InsDefferedEvent)
  protected
   procedure DoFireLog; virtual; abstract;
   procedure RequestWrite;
   procedure FireLog;
  public
   constructor Create; reintroduce;
 end;//TnsPrimCachedEvent

implementation

uses
 l3ImplUses
 , nsCachedEventsProcessor
 , nsLogEventData
 , nsLogManager
 , LoggingUnit
 , LoggingWrapperInterfaces
;

procedure TnsPrimCachedEvent.RequestWrite;
//#UC START# *4B13A22E0048_4B13A069037A_var*
//#UC END# *4B13A22E0048_4B13A069037A_var*
begin
//#UC START# *4B13A22E0048_4B13A069037A_impl*
 TnsCachedEventsProcessor.Make.RequestWriteCache;
//#UC END# *4B13A22E0048_4B13A069037A_impl*
end;//TnsPrimCachedEvent.RequestWrite

constructor TnsPrimCachedEvent.Create;
//#UC START# *4B13AB74036B_4B13A069037A_var*
//#UC END# *4B13AB74036B_4B13A069037A_var*
begin
//#UC START# *4B13AB74036B_4B13A069037A_impl*
 inherited Create;
 TnsCachedEventsProcessor.Make.RegisterEvent(Self);
//#UC END# *4B13AB74036B_4B13A069037A_impl*
end;//TnsPrimCachedEvent.Create

procedure TnsPrimCachedEvent.FireLog;
//#UC START# *4B0FA5CB0254_4B13A069037A_var*
//#UC END# *4B0FA5CB0254_4B13A069037A_var*
begin
//#UC START# *4B0FA5CB0254_4B13A069037A_impl*
 DoFireLog;
//#UC END# *4B0FA5CB0254_4B13A069037A_impl*
end;//TnsPrimCachedEvent.FireLog

end.
