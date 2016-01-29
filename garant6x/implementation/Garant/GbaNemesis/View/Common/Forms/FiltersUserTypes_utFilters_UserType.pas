unit FiltersUserTypes_utFilters_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/FiltersUserTypes_utFilters_UserType.pas"
// �����: 16.03.2011 18:08
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::FiltersUserTypes::utFilters
//
// �������
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
   { ��������� ��� ���� ����� utFilters }
  utFiltersName = 'utFilters';
   { ��������� ������������� ����������������� ���� "�������" }
  utFilters = TvcmUserType(0);
   { ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFilters = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utFilters }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFilters
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFilters

class function Tkw_FormUserType_utFilters.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utFilters';
end;//Tkw_FormUserType_utFilters.GetWordNameForRegister

function Tkw_FormUserType_utFilters.GetInteger: Integer;
 {-}
begin
 Result := utFilters;
end;//Tkw_FormUserType_utFilters.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utFilters
 Tkw_FormUserType_utFilters.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.