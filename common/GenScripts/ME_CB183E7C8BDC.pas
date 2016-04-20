unit kw_Search_opOpenKeyWordSearch;
 {* ����� ������� ��� ������ �������� ������ Search.OpenKeyWordSearch (����� ����� �� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opOpenKeyWordSearch.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opOpenKeyWordSearch" MUID: (CB183E7C8BDC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , tfwModuleOperationWord
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
type
 Tkw_Search_opOpenKeyWordSearch = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.OpenKeyWordSearch (����� ����� �� ��������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opOpenKeyWordSearch

class function Tkw_Search_opOpenKeyWordSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_�����_��_��������';
end;//Tkw_Search_opOpenKeyWordSearch.GetWordNameForRegister

class function Tkw_Search_opOpenKeyWordSearch.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_OpenKeyWordSearch;
end;//Tkw_Search_opOpenKeyWordSearch.GetModuleOperationCode

initialization
 Tkw_Search_opOpenKeyWordSearch.RegisterInEngine;
 {* ����������� Tkw_Search_opOpenKeyWordSearch }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
