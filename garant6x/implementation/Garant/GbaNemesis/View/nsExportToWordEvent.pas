unit nsExportToWordEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsExportToWordEvent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsExportToWordEvent
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsExportToWordEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
    ForSelection: Boolean;
    IntoActive: Boolean);
 end;//TnsExportToWordEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsExportToWordEvent

class procedure TnsExportToWordEvent.Log(const aDoc: IDocument;
  ForSelection: Boolean;
  IntoActive: Boolean);
//#UC START# *4B0B99D901AD_4B0B99CA0261_var*
var
 l_Data: InsLogEventData;
const
 cMap: array [Boolean] of Integer = (0, 1); 
//#UC END# *4B0B99D901AD_4B0B99CA0261_var*
begin
//#UC START# *4B0B99D901AD_4B0B99CA0261_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddULong(cMap[ForSelection]);
 l_Data.AddULong(cMap[IntoActive]);
 GetLogger.AddEvent(LE_EXPORT_TO_WORD, l_Data);
//#UC END# *4B0B99D901AD_4B0B99CA0261_impl*
end;//TnsExportToWordEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.