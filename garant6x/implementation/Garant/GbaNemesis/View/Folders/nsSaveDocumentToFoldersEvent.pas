unit nsSaveDocumentToFoldersEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/nsSaveDocumentToFoldersEvent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������� ����������::Folders::View::Folders::TnsSaveDocumentToFoldersEvent
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
 TnsSaveDocumentToFoldersEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument);
 end;//TnsSaveDocumentToFoldersEvent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsLogEventData,
  nsLogManager,
  LoggingUnit,
  LoggingWrapperInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSaveDocumentToFoldersEvent

class procedure TnsSaveDocumentToFoldersEvent.Log(const aDoc: IDocument);
//#UC START# *51BEFAC50138_51BEFA3D019E_var*
var
 l_Data: InsLogEventData;
//#UC END# *51BEFAC50138_51BEFA3D019E_var*
begin
//#UC START# *51BEFAC50138_51BEFA3D019E_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_SAVE_DOCUMENT_TO_FOLDERS, l_Data);
//#UC END# *51BEFAC50138_51BEFA3D019E_impl*
end;//TnsSaveDocumentToFoldersEvent.Log

{$IfEnd} //not Admin AND not Monitorings

end.