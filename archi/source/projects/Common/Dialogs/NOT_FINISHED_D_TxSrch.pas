unit NOT_FINISHED_D_TxSrch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/NOT_FINISHED_D_TxSrch.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$common::Dialogs::CommonDialogs::D_TxSrch
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

type
 TTextSearchDlg = class
 end;//TTextSearchDlg

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TTextSearchDlgWordsPack
  {$IfEnd} //not NoScripts
  
  ;

end.