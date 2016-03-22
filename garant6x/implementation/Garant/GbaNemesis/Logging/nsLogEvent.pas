unit nsLogEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsLogEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::Logging::TnsLogEvent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  LoggingUnit,
  l3SimpleObject,
  LoggingWrapperInterfaces,
  BaseTypesUnit
  ;

type
 InsLogEventData = LoggingWrapperInterfaces.InsLogEventData;

 TLogEvent = LoggingUnit.TLogEvent;

 _nsLogEvent_Parent_ = Tl3SimpleObject;
 {$Include ..\Logging\nsLogEvent.imp.pas}
 TnsLogEvent = {abstract} class(_nsLogEvent_)
 private
 // private fields
   f_Logger : InsLogManager;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   class function GetLogger: InsLogManager;
   class function MakeParamsList: InsLogEventData;
 end;//TnsLogEvent

implementation

uses
  nsLogEventData,
  nsLogManager
  ;

{$Include ..\Logging\nsLogEvent.imp.pas}

// start class TnsLogEvent

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