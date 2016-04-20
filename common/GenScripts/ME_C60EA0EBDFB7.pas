unit kw_Search_opDocumentsWithoutIncluded;
 {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutIncluded (�����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opDocumentsWithoutIncluded.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opDocumentsWithoutIncluded" MUID: (C60EA0EBDFB7)

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
 Tkw_Search_opDocumentsWithoutIncluded = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutIncluded (�����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opDocumentsWithoutIncluded

class function Tkw_Search_opDocumentsWithoutIncluded.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_DocumentsWithoutIncluded';
end;//Tkw_Search_opDocumentsWithoutIncluded.GetWordNameForRegister

class function Tkw_Search_opDocumentsWithoutIncluded.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_DocumentsWithoutIncluded;
end;//Tkw_Search_opDocumentsWithoutIncluded.GetModuleOperationCode

initialization
 Tkw_Search_opDocumentsWithoutIncluded.RegisterInEngine;
 {* ����������� Tkw_Search_opDocumentsWithoutIncluded }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
