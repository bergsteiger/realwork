unit kw_Search_opDocumentsWithoutKey;
 {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutKey (�����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opDocumentsWithoutKey.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opDocumentsWithoutKey" MUID: (82912AF63784)

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
 Tkw_Search_opDocumentsWithoutKey = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutKey (�����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opDocumentsWithoutKey

class function Tkw_Search_opDocumentsWithoutKey.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_DocumentsWithoutKey';
end;//Tkw_Search_opDocumentsWithoutKey.GetWordNameForRegister

class function Tkw_Search_opDocumentsWithoutKey.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_DocumentsWithoutKey;
end;//Tkw_Search_opDocumentsWithoutKey.GetModuleOperationCode

initialization
 Tkw_Search_opDocumentsWithoutKey.RegisterInEngine;
 {* ����������� Tkw_Search_opDocumentsWithoutKey }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
