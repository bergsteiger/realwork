unit arEditorUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/arEditorUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::arEditorUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  kwClickOnCommentHeader,
  kwEditorDblClickOnSub,
  kwDeleteSub,
  kwDocEditorSetModified,
  kwAddBlock,
  kwEditorSetTOC,
  kwGotoSub,
  kwEndAddSubByMouse,
  kwSetExpiredStyle
  ;

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
end.