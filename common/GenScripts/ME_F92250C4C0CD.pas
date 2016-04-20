unit kw_Search_opAllSearch;
 {* ����� ������� ��� ������ �������� ������ Search.AllSearch (����� �����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opAllSearch.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opAllSearch" MUID: (F92250C4C0CD)

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
 Tkw_Search_opAllSearch = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.AllSearch (����� �����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opAllSearch

class function Tkw_Search_opAllSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_�����';
end;//Tkw_Search_opAllSearch.GetWordNameForRegister

class function Tkw_Search_opAllSearch.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_AllSearch;
end;//Tkw_Search_opAllSearch.GetModuleOperationCode

initialization
 Tkw_Search_opAllSearch.RegisterInEngine;
 {* ����������� Tkw_Search_opAllSearch }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
