unit PrimRightEdition_utRightEdition_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimRightEdition_utRightEdition_UserType.pas"
// �����: 27.07.2009 11:44
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������������� �������::CompareEditions::View::Editions::PrimRightEdition::utRightEdition
//
// ������� ��������
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
   { ��������� ��� ���� ����� utRightEdition }
  utRightEditionName = 'utRightEdition';
   { ��������� ������������� ����������������� ���� "������� ��������" }
  utRightEdition = TvcmUserType(0);
   { ������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utRightEdition = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utRightEdition }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utRightEdition
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utRightEdition

class function Tkw_FormUserType_utRightEdition.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utRightEdition';
end;//Tkw_FormUserType_utRightEdition.GetWordNameForRegister

function Tkw_FormUserType_utRightEdition.GetInteger: Integer;
 {-}
begin
 Result := utRightEdition;
end;//Tkw_FormUserType_utRightEdition.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utRightEdition
 Tkw_FormUserType_utRightEdition.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.