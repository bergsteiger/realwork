unit NOT_FINISHED_arHAFPainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Editor"
// ������: "w:/archi/source/projects/Archi/Editor/NOT_FINISHED_arHAFPainer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::Printing::TarHAFPainer
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
  evHAFPainterEx
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarHAFPainer = class(TevHAFPainterEx)
 end;//TarHAFPainer
{$IfEnd} //AppClientSide

implementation

end.