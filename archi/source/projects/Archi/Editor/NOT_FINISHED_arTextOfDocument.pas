unit NOT_FINISHED_arTextOfDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editor"
// ������: "w:/archi/source/projects/Archi/Editor/NOT_FINISHED_arTextOfDocument.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::DocIntf::TarTextOfDocument
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  evTextSource,
  nevTools
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarTextOfDocument = class(TevTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TarTextOfDocument
 RarTextOfDocument = TarTextOfDocument;

{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  arDocumentContainer
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarTextOfDocument

function TarTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4E0072E100DB_var*
//#UC END# *482D9A030221_4E0072E100DB_var*
begin
//#UC START# *482D9A030221_4E0072E100DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *482D9A030221_4E0072E100DB_impl*
end;//TarTextOfDocument.DoMakeDocumentContainer

{$IfEnd} //AppClientSide

end.