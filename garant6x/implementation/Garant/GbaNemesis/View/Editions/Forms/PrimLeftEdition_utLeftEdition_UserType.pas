unit PrimLeftEdition_utLeftEdition_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimLeftEdition_utLeftEdition_UserType.pas"
// �����: 27.07.2009 11:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������������� �������::CompareEditions::View::Editions::PrimLeftEdition::utLeftEdition
//
// ���������� ��������
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
   { ��������� ��� ���� ����� utLeftEdition }
  utLeftEditionName = 'utLeftEdition';
   { ��������� ������������� ����������������� ���� "���������� ��������" }
  utLeftEdition = TvcmUserType(0);
   { ���������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utLeftEdition = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utLeftEdition }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utLeftEdition
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utLeftEdition

class function Tkw_FormUserType_utLeftEdition.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utLeftEdition';
end;//Tkw_FormUserType_utLeftEdition.GetWordNameForRegister

function Tkw_FormUserType_utLeftEdition.GetInteger: Integer;
 {-}
begin
 Result := utLeftEdition;
end;//Tkw_FormUserType_utLeftEdition.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utLeftEdition
 Tkw_FormUserType_utLeftEdition.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.