unit PrimSaveLoadUserTypes_slqtFilters_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtFilters_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtFilters
//
// �������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimSaveLoadUserTypes_slqtPublishSource_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtFilters }
  slqtFiltersName = 'slqtFilters';
   { ��������� ������������� ����������������� ���� "�������� ��������" }
  slqtFilters = TvcmUserType(slqtPublishSource + 1);
   { �������� �������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtFilters = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtFilters }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtFilters
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtFilters

class function Tkw_FormUserType_slqtFilters.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtFilters';
end;//Tkw_FormUserType_slqtFilters.GetWordNameForRegister

function Tkw_FormUserType_slqtFilters.GetInteger: Integer;
 {-}
begin
 Result := slqtFilters;
end;//Tkw_FormUserType_slqtFilters.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtFilters
 Tkw_FormUserType_slqtFilters.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.