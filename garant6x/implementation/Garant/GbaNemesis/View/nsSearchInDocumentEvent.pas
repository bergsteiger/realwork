unit nsSearchInDocumentEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsSearchInDocumentEvent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::Base Forms::TnsSearchInDocumentEvent
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
 TnsSearchInDocumentEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument;
    const aContext: Il3CString);
 end;//TnsSearchInDocumentEvent
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

// start class TnsSearchInDocumentEvent

class procedure TnsSearchInDocumentEvent.Log(const aDoc: IDocument;
  const aContext: Il3CString);
//#UC START# *4B0A8AF000C9_4B0A8AB30113_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0A8AF000C9_4B0A8AB30113_var*
begin
//#UC START# *4B0A8AF000C9_4B0A8AB30113_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(nsAStr(aContext).S);
 GetLogger.AddEvent(LE_SEARCH_IN_DOCUMENT, l_Data);
//#UC END# *4B0A8AF000C9_4B0A8AB30113_impl*
end;//TnsSearchInDocumentEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.