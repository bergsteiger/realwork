unit kw_DocumentListFromFile_opOpenDocumentListFromFile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentListFromFile/kw_DocumentListFromFile_opOpenDocumentListFromFile.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ������������ ��������::DocumentListFromFile::View::DocumentListFromFile::Tkw_DocumentListFromFile_opOpenDocumentListFromFile
//
// ����� ������� ��� ������ �������� ������ DocumentListFromFile.OpenDocumentListFromFile (������
// ���������� �� ����� ������� ������ ���������� �� �����)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  tfwModuleOperationWord
  {$IfEnd} //not NoScripts AND not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
 Tkw_DocumentListFromFile_opOpenDocumentListFromFile = {final scriptword} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ DocumentListFromFile.OpenDocumentListFromFile (������ ���������� �� ����� ������� ������ ���������� �� �����) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_DocumentListFromFile_opOpenDocumentListFromFile

class function Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::������_����������_��_�����_�������_������_����������_��_�����';
end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_DocumentListFromFile_OpenDocumentListFromFile;
end;//Tkw_DocumentListFromFile_opOpenDocumentListFromFile.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_DocumentListFromFile_opOpenDocumentListFromFile
 Tkw_DocumentListFromFile_opOpenDocumentListFromFile.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.