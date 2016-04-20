unit kw_Search_opInpharmSearch;
 {* ����� ������� ��� ������ �������� ������ Search.InpharmSearch$Op (����� ����� ������������� �������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opInpharmSearch.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opInpharmSearch" MUID: (27A93E3E279E)

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
 Tkw_Search_opInpharmSearch = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.InpharmSearch$Op (����� ����� ������������� �������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opInpharmSearch

class function Tkw_Search_opInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_�����_�������������_�������';
end;//Tkw_Search_opInpharmSearch.GetWordNameForRegister

class function Tkw_Search_opInpharmSearch.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_InpharmSearch;
end;//Tkw_Search_opInpharmSearch.GetModuleOperationCode

initialization
 Tkw_Search_opInpharmSearch.RegisterInEngine;
 {* ����������� Tkw_Search_opInpharmSearch }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
