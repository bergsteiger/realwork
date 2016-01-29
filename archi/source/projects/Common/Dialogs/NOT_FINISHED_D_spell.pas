unit NOT_FINISHED_D_spell;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/NOT_FINISHED_D_spell.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$common::Dialogs::CommonDialogs::D_spell
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

type
 TSpellCheckDlg = class
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TSpellCheckDlg;
    {- ���������� ��������� ����������. }
 end;//TSpellCheckDlg

implementation

uses
  l3Base {a}
  {$If not defined(NoScripts)}
  ,
  TSpellCheckDlgWordsPack
  {$IfEnd} //not NoScripts
  
  ;


// start class TSpellCheckDlg

var g_TSpellCheckDlg : TSpellCheckDlg = nil;

procedure TSpellCheckDlgFree;
begin
 l3Free(g_TSpellCheckDlg);
end;

class function TSpellCheckDlg.Instance: TSpellCheckDlg;
begin
 if (g_TSpellCheckDlg = nil) then
 begin
  l3System.AddExitProc(TSpellCheckDlgFree);
  g_TSpellCheckDlg := Create;
 end;
 Result := g_TSpellCheckDlg;
end;


class function TSpellCheckDlg.Exists: Boolean;
 {-}
begin
 Result := g_TSpellCheckDlg <> nil;
end;//TSpellCheckDlg.Exists

end.