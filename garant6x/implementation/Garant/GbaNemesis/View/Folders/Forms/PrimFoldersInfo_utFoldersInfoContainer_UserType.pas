unit PrimFoldersInfo_utFoldersInfoContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersInfo_utFoldersInfoContainer_UserType.pas"
// �����: 29.10.2009 19:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Folders::View::Folders::PrimFoldersInfo::utFoldersInfoContainer
//
// �������� ����� (��������� ������)
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
   { ��������� ��� ���� ����� utFoldersInfoContainer }
  utFoldersInfoContainerName = 'utFoldersInfoContainer';
   { ��������� ������������� ����������������� ���� "�������� ����� (��������� ������)" }
  utFoldersInfoContainer = TvcmUserType(0);
   { �������� ����� (��������� ������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFoldersInfoContainer = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utFoldersInfoContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFoldersInfoContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFoldersInfoContainer

class function Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utFoldersInfoContainer';
end;//Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister

function Tkw_FormUserType_utFoldersInfoContainer.GetInteger: Integer;
 {-}
begin
 Result := utFoldersInfoContainer;
end;//Tkw_FormUserType_utFoldersInfoContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utFoldersInfoContainer
 Tkw_FormUserType_utFoldersInfoContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.