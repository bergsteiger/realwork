unit kw_Search_opDocumentsWithoutKey;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/kw_Search_opDocumentsWithoutKey.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 �������� ����������::Search::View::Search::Tkw_Search_opDocumentsWithoutKey
//
// ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutKey (�����)
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
 Tkw_Search_opDocumentsWithoutKey = {final scriptword} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ Search.DocumentsWithoutKey (�����) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_Search_opDocumentsWithoutKey
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_Search_opDocumentsWithoutKey

class function Tkw_Search_opDocumentsWithoutKey.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::�����_DocumentsWithoutKey';
end;//Tkw_Search_opDocumentsWithoutKey.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_Search_opDocumentsWithoutKey.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Search_DocumentsWithoutKey;
end;//Tkw_Search_opDocumentsWithoutKey.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Search_opDocumentsWithoutKey
 Tkw_Search_opDocumentsWithoutKey.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.