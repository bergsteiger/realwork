unit PrimUserProperty_admUseProperties_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimUserProperty_admUseProperties_UserType.pas"
// �����: 27.01.2009 15:50
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::PrimUserProperty::admUseProperties
//
// �������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
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
   { ��������� ��� ���� ����� admUseProperties }
  admUsePropertiesName = 'admUseProperties';
   { ��������� ������������� ����������������� ���� "�������� ������������" }
  admUseProperties = TvcmUserType(0);
   { �������� ������������ }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_admUseProperties = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� admUseProperties }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_admUseProperties
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_admUseProperties

class function Tkw_FormUserType_admUseProperties.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::admUseProperties';
end;//Tkw_FormUserType_admUseProperties.GetWordNameForRegister

function Tkw_FormUserType_admUseProperties.GetInteger: Integer;
 {-}
begin
 Result := admUseProperties;
end;//Tkw_FormUserType_admUseProperties.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_admUseProperties
 Tkw_FormUserType_admUseProperties.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.