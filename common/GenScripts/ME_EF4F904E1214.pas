unit kw_Search_opAttributeSearch;
 {* ����� ������� ��� ������ �������� ������ Search.AttributeSearch$Op (����� ����� �� ����������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opAttributeSearch.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opAttributeSearch" MUID: (EF4F904E1214)

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
 Tkw_Search_opAttributeSearch = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.AttributeSearch$Op (����� ����� �� ����������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opAttributeSearch

class function Tkw_Search_opAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_�����_��_����������';
end;//Tkw_Search_opAttributeSearch.GetWordNameForRegister

class function Tkw_Search_opAttributeSearch.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_AttributeSearch;
end;//Tkw_Search_opAttributeSearch.GetModuleOperationCode

initialization
 Tkw_Search_opAttributeSearch.RegisterInEngine;
 {* ����������� Tkw_Search_opAttributeSearch }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
