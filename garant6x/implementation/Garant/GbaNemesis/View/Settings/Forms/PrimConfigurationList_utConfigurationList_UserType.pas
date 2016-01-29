unit PrimConfigurationList_utConfigurationList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimConfigurationList_utConfigurationList_UserType.pas"
// �����: 27.04.2010 22:06
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Settings::View::Settings::PrimConfigurationList::utConfigurationList
//
// ������������
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
   { ��������� ��� ���� ����� utConfigurationList }
  utConfigurationListName = 'utConfigurationList';
   { ��������� ������������� ����������������� ���� "������������" }
  utConfigurationList = TvcmUserType(0);
   { ������������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utConfigurationList = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utConfigurationList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utConfigurationList
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utConfigurationList

class function Tkw_FormUserType_utConfigurationList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utConfigurationList';
end;//Tkw_FormUserType_utConfigurationList.GetWordNameForRegister

function Tkw_FormUserType_utConfigurationList.GetInteger: Integer;
 {-}
begin
 Result := utConfigurationList;
end;//Tkw_FormUserType_utConfigurationList.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utConfigurationList
 Tkw_FormUserType_utConfigurationList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.