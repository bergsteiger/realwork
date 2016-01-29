unit kw_CommonPost_opSavePostList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/kw_CommonPost_opSavePostList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::Tkw_CommonPost_opSavePostList
//
// ����� ������� ��� ������ �������� ������ CommonPost.SavePostList$Op (���� �������������� ���
// �������������� ����� � ����)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
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
{$IfEnd} //not Admin AND not NoScripts


implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}
type
 Tkw_CommonPost_opSavePostList = {final scriptword} class(TtfwModuleOperationWord)
  {* ����� ������� ��� ������ �������� ������ CommonPost.SavePostList$Op (���� �������������� ��� �������������� ����� � ����) }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   {$If not defined(NoScripts) AND not defined(NoVCM)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts AND not NoVCM
 end;//Tkw_CommonPost_opSavePostList
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_CommonPost_opSavePostList

class function Tkw_CommonPost_opSavePostList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::����_��������������_���_��������������_�����_�_����';
end;//Tkw_CommonPost_opSavePostList.GetWordNameForRegister

{$If not defined(NoScripts) AND not defined(NoVCM)}
class function Tkw_CommonPost_opSavePostList.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_CommonPost_SavePostList;
end;//Tkw_CommonPost_opSavePostList.GetModuleOperationCode
{$IfEnd} //not NoScripts AND not NoVCM

{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_CommonPost_opSavePostList
 Tkw_CommonPost_opSavePostList.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.