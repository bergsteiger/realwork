unit PrimBaseSearch_BaseSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/PrimBaseSearch_BaseSearch_UserType.pas"
// �����: 21.09.2009 18:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::BaseSearch::View::BaseSearch$Module::PrimBaseSearch::BaseSearch
//
// ������� �����
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
   { ��������� ��� ���� ����� BaseSearch }
  BaseSearchName = 'BaseSearch';
   { ��������� ������������� ����������������� ���� "������� �����" }
  BaseSearch = TvcmUserType(0);
   { ������� ����� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_BaseSearch = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� BaseSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_BaseSearch
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_BaseSearch

class function Tkw_FormUserType_BaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::BaseSearch';
end;//Tkw_FormUserType_BaseSearch.GetWordNameForRegister

function Tkw_FormUserType_BaseSearch.GetInteger: Integer;
 {-}
begin
 Result := BaseSearch;
end;//Tkw_FormUserType_BaseSearch.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_BaseSearch
 Tkw_FormUserType_BaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.