unit NOT_FINISHED_CustEditWin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Main"
// ������: "w:/archi/source/projects/Archi/Main/NOT_FINISHED_CustEditWin.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Main::MainWindows::CustEditWin
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
  afwNavigation
  ;

type
 TCustomEditorWindow = class
 protected
 // protected methods
   function DocEditorJumpTo(const aMoniker: IevMoniker): Boolean;
 end;//TCustomEditorWindow
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  arHyperLinkProcessor,
  D_spell
  ;

// start class TCustomEditorWindow

function TCustomEditorWindow.DocEditorJumpTo(const aMoniker: IevMoniker): Boolean;
//#UC START# *4E5C89E1034B_4E5C8996022B_var*
//#UC END# *4E5C89E1034B_4E5C8996022B_var*
begin
//#UC START# *4E5C89E1034B_4E5C8996022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E5C89E1034B_4E5C8996022B_impl*
end;//TCustomEditorWindow.DocEditorJumpTo
{$IfEnd} //AppClientSide

end.