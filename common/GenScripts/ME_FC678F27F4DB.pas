unit kw_DocumentListFromFile_opOpenDocumentListFromFile;
 {* ����� ������� ��� ������ �������� ������ DocumentListFromFile.OpenDocumentListFromFile (������ ���������� �� ����� ������� ������ ���������� �� �����) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentListFromFile\kw_DocumentListFromFile_opOpenDocumentListFromFile.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Tkw_DocumentListFromFile_opOpenDocumentListFromFile" MUID: (FC678F27F4DB)

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
 Tkw_DocumentListFromFile_opOpenDocumentListFromFile = {final} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ DocumentListFromFile.OpenDocumentListFromFile (������ ���������� �� ����� ������� ������ ���������� �� �����) }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   class function GetModuleOperationCode: TvcmMOPID; override;
 end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile

class function Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetWordNameForRegister: AnsiString;
begin
 Result := '���::������_����������_��_�����_�������_������_����������_��_�����';
end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetWordNameForRegister

class function Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetModuleOperationCode: TvcmMOPID;
begin
 Result := TdmStdRes.mod_opcode_DocumentListFromFile_OpenDocumentListFromFile;
end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetModuleOperationCode

initialization
 Tkw_DocumentListFromFile_opOpenDocumentListFromFile.RegisterInEngine;
 {* ����������� Tkw_DocumentListFromFile_opOpenDocumentListFromFile }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)
end.
