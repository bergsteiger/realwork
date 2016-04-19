unit kw_Document_opOpenDocOnNumber;
 {* ����� ������� ��� ������ �������� ������ Document.OpenDocOnNumber (�������� ������� �������� �� ������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\kw_Document_opOpenDocOnNumber.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_Document_opOpenDocOnNumber" MUID: (A84598360094)

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
 Tkw_Document_opOpenDocOnNumber = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Document.OpenDocOnNumber (�������� ������� �������� �� ������) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_Document_opOpenDocOnNumber

class function Tkw_Document_opOpenDocOnNumber.GetWordNameForRegister: AnsiString;
begin
 Result := '���::��������_�������_��������_��_������';
end;//Tkw_Document_opOpenDocOnNumber.GetWordNameForRegister

class function Tkw_Document_opOpenDocOnNumber.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_Document_OpenDocOnNumber;
end;//Tkw_Document_opOpenDocOnNumber.GetModuleOperationCode

initialization
 Tkw_Document_opOpenDocOnNumber.RegisterInEngine;
 {* ����������� Tkw_Document_opOpenDocOnNumber }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
