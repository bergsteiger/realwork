unit nsLogEvent;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEvent.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , LoggingWrapperInterfaces
 , LoggingUnit
;

type
 InsLogEventData = LoggingWrapperInterfaces.InsLogEventData;

 TLogEvent = LoggingUnit.TLogEvent;

 _nsLogEvent_Parent_ = Tl3SimpleObject;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEvent.imp.pas}
 TnsLogEvent = {abstract} class(_nsLogEvent_)
  private
   f_Logger: InsLogManager;
  protected
   class function GetLogger: InsLogManager;
   class function MakeParamsList: InsLogEventData;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TnsLogEvent

implementation

uses
 l3ImplUses
 , nsLogEventData
 , nsLogManager
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogEvent.imp.pas}

class function TnsLogEvent.GetLogger: InsLogManager;
//#UC START# *566AE04B01D3_4B0A6109010C_var*
//#UC END# *566AE04B01D3_4B0A6109010C_var*
begin
//#UC START# *566AE04B01D3_4B0A6109010C_impl*
 //Result := f_Logger;
 Result := TnsLogManager.Instance;
//#UC END# *566AE04B01D3_4B0A6109010C_impl*
end;//TnsLogEvent.GetLogger

class function TnsLogEvent.MakeParamsList: InsLogEventData;
//#UC START# *4B0A61540153_4B0A6109010C_var*
//#UC END# *4B0A61540153_4B0A6109010C_var*
begin
//#UC START# *4B0A61540153_4B0A6109010C_impl*
 Result := TnsLogEventData.Make;
//#UC END# *4B0A61540153_4B0A6109010C_impl*
end;//TnsLogEvent.MakeParamsList

procedure TnsLogEvent.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B0A6109010C_var*
//#UC END# *479731C50290_4B0A6109010C_var*
begin
//#UC START# *479731C50290_4B0A6109010C_impl*
 f_Logger := nil;
 inherited;
//#UC END# *479731C50290_4B0A6109010C_impl*
end;//TnsLogEvent.Cleanup

procedure TnsLogEvent.InitFields;
//#UC START# *47A042E100E2_4B0A6109010C_var*
//#UC END# *47A042E100E2_4B0A6109010C_var*
begin
//#UC START# *47A042E100E2_4B0A6109010C_impl*
 inherited;
 f_Logger := TnsLogManager.Instance;
//#UC END# *47A042E100E2_4B0A6109010C_impl*
end;//TnsLogEvent.InitFields

end.
