unit PrimEditionsContainer_utEditionsContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimEditionsContainer_utEditionsContainer_UserType.pas"
// �����: 28.07.2009 13:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������������� �������::CompareEditions::View::Editions::PrimEditionsContainer::utEditionsContainer
//
// ��������� �������� ���������
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
   { ��������� ��� ���� ����� utEditionsContainer }
  utEditionsContainerName = 'utEditionsContainer';
   { ��������� ������������� ����������������� ���� "��������� �������� ���������" }
  utEditionsContainer = TvcmUserType(0);
   { ��������� �������� ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utEditionsContainer = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utEditionsContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utEditionsContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utEditionsContainer

class function Tkw_FormUserType_utEditionsContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utEditionsContainer';
end;//Tkw_FormUserType_utEditionsContainer.GetWordNameForRegister

function Tkw_FormUserType_utEditionsContainer.GetInteger: Integer;
 {-}
begin
 Result := utEditionsContainer;
end;//Tkw_FormUserType_utEditionsContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utEditionsContainer
 Tkw_FormUserType_utEditionsContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.