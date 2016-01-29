unit nsLogEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Logging"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsLogEvent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Logging::Logging::TnsLogEvent
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
 protected
 // protected methods
   class function MakeParamsList: InsLogEventData;
   class function GetLogger: InsLogManager;
 end;//TnsLogEvent

implementation

uses
  nsLogEventData,
  nsLogManager
  ;

{$Include ..\Logging\nsLogEvent.imp.pas}

// start class TnsLogEvent

class function TnsLogEvent.MakeParamsList: InsLogEventData;
//#UC START# *4B0A61540153_4B0A6109010C_var*
//#UC END# *4B0A61540153_4B0A6109010C_var*
begin
//#UC START# *4B0A61540153_4B0A6109010C_impl*
 Result := TnsLogEventData.Make;
//#UC END# *4B0A61540153_4B0A6109010C_impl*
end;//TnsLogEvent.MakeParamsList

class function TnsLogEvent.GetLogger: InsLogManager;
//#UC START# *4B0A65A302E7_4B0A6109010C_var*
//#UC END# *4B0A65A302E7_4B0A6109010C_var*
begin
//#UC START# *4B0A65A302E7_4B0A6109010C_impl*
 Result := TnsLogManager.Instance;
//#UC END# *4B0A65A302E7_4B0A6109010C_impl*
end;//TnsLogEvent.GetLogger

end.