unit PrimFoldersElementInfo_utFoldersProperty_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersElementInfo_utFoldersProperty_UserType.pas"
// �����: 27.10.2009 17:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Folders::View::Folders::PrimFoldersElementInfo::utFoldersProperty
//
// ������ �������
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
   { ��������� ��� ���� ����� utFoldersProperty }
  utFoldersPropertyName = 'utFoldersProperty';
   { ��������� ������������� ����������������� ���� "������ �������" }
  utFoldersProperty = TvcmUserType(0);
   { ������ ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFoldersProperty = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utFoldersProperty }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFoldersProperty
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFoldersProperty

class function Tkw_FormUserType_utFoldersProperty.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utFoldersProperty';
end;//Tkw_FormUserType_utFoldersProperty.GetWordNameForRegister

function Tkw_FormUserType_utFoldersProperty.GetInteger: Integer;
 {-}
begin
 Result := utFoldersProperty;
end;//Tkw_FormUserType_utFoldersProperty.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utFoldersProperty
 Tkw_FormUserType_utFoldersProperty.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.