unit NOT_FINISHED_D_spell;

// ������: "w:\archi\source\projects\Common\Dialogs\NOT_FINISHED_D_spell.pas"
// ���������: "UtilityPack"
// ������� ������: "D_spell" MUID: (55C8D80A0304)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
;

type
 TSpellCheckDlg = class
  public
   class function Instance: TSpellCheckDlg;
    {* ����� ��������� ���������� ���������� TSpellCheckDlg }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TSpellCheckDlg

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TSpellCheckDlgWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
;

var g_TSpellCheckDlg: TSpellCheckDlg = nil;
 {* ��������� ���������� TSpellCheckDlg }

procedure TSpellCheckDlgFree;
 {* ����� ������������ ���������� ���������� TSpellCheckDlg }
begin
 l3Free(g_TSpellCheckDlg);
end;//TSpellCheckDlgFree

class function TSpellCheckDlg.Instance: TSpellCheckDlg;
 {* ����� ��������� ���������� ���������� TSpellCheckDlg }
begin
 if (g_TSpellCheckDlg = nil) then
 begin
  l3System.AddExitProc(TSpellCheckDlgFree);
  g_TSpellCheckDlg := Create;
 end;
 Result := g_TSpellCheckDlg;
end;//TSpellCheckDlg.Instance

class function TSpellCheckDlg.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TSpellCheckDlg <> nil;
end;//TSpellCheckDlg.Exists

end.
