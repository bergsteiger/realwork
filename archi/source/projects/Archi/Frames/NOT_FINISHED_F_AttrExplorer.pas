unit NOT_FINISHED_F_AttrExplorer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Frames"
// ������: "w:/archi/source/projects/Archi/Frames/NOT_FINISHED_F_AttrExplorer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Frames::Frames::F_AttrExplorer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
type
 TAttrExplorer = class
 end;//TAttrExplorer
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  Classes
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  AttributeExplorerWordsPack
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  ;

{$IfEnd} //AppClientSide
end.