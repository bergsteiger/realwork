unit NOT_FINISHED_arTextOfDocumentWithContentsTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editor"
// ������: "w:/archi/source/projects/Archi/Editor/NOT_FINISHED_arTextOfDocumentWithContentsTree.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::DocIntf::TarTextOfDocumentWithContentsTree
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
  arTextOfDocument
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarTextOfDocumentWithContentsTree = class(TarTextOfDocument)
 end;//TarTextOfDocumentWithContentsTree
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  arDocumentContainerWithContentsTree
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}


{$IfEnd} //AppClientSide
end.