unit nsSearchInDocumentNextEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsSearchInDocumentNextEvent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsSearchInDocumentNextEvent
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
  l3Interfaces,
  nsLogEvent
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSearchInDocumentNextEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString);
 end;//TnsSearchInDocumentNextEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LoggingUnit,
  nsTypes,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSearchInDocumentNextEvent

class procedure TnsSearchInDocumentNextEvent.Log(const aDoc: IDocument;
  const aContext: Il3CString);
//#UC START# *5280A6F5009C_5280A6CC0073_var*
var
 l_Data: InsLogEventData;
//#UC END# *5280A6F5009C_5280A6CC0073_var*
begin
//#UC START# *5280A6F5009C_5280A6CC0073_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(nsAStr(aContext).S);
 GetLogger.AddEvent(LE_NEXT_SEARCH_IN_DOCUMENT, l_Data);
//#UC END# *5280A6F5009C_5280A6CC0073_impl*
end;//TnsSearchInDocumentNextEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.