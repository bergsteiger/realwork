unit PrimFolders_utFolders_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFolders_utFolders_UserType.pas"
// �����: 27.08.2009 20:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Folders::View::Folders::PrimFolders::utFolders
//
// ��� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� utFolders }
  utFoldersName = 'utFolders';
   { ��������� ������������� ����������������� ���� "��� ���������" }
  utFolders = TvcmUserType(0);
   { ��� ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFolders = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utFolders }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFolders
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFolders

class function Tkw_FormUserType_utFolders.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utFolders';
end;//Tkw_FormUserType_utFolders.GetWordNameForRegister

function Tkw_FormUserType_utFolders.GetInteger: Integer;
 {-}
begin
 Result := utFolders;
end;//Tkw_FormUserType_utFolders.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utFolders
 Tkw_FormUserType_utFolders.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.