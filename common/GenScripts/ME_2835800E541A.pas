unit kw_Search_opDocumentsWithoutClass;
 {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutClass (�����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\kw_Search_opDocumentsWithoutClass.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Search_opDocumentsWithoutClass" MUID: (2835800E541A)

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
 Tkw_Search_opDocumentsWithoutClass = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutClass (�����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Search_opDocumentsWithoutClass

class function Tkw_Search_opDocumentsWithoutClass.GetWordNameForRegister: AnsiString;
begin
 Result := '���::�����_DocumentsWithoutClass';
end;//Tkw_Search_opDocumentsWithoutClass.GetWordNameForRegister

class function Tkw_Search_opDocumentsWithoutClass.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Search_DocumentsWithoutClass;
end;//Tkw_Search_opDocumentsWithoutClass.GetModuleOperationCode

initialization
 Tkw_Search_opDocumentsWithoutClass.RegisterInEngine;
 {* ����������� Tkw_Search_opDocumentsWithoutClass }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
