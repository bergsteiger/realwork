unit NOT_FINISHED_arMacroReplacer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editor"
// ������: "w:/archi/source/projects/Archi/Editor/NOT_FINISHED_arMacroReplacer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::Printing::TarMacroReplacer
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
  evCustomHAFMacroReplacer
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarMacroReplacer = class(TevCustomHAFMacroReplacer)
 end;//TarMacroReplacer
{$IfEnd} //AppClientSide

implementation

end.