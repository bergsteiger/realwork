unit NOT_FINISHED_ExprEditForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/NOT_FINISHED_ExprEditForm.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$common::Dialogs::CommonDialogs::ExprEditForm
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

type
 TExprEditor = class
 end;//TExprEditor

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TExprEditorWordsPack
  {$IfEnd} //not NoScripts
  
  ;

end.