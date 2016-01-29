unit PrimCommonDiction_utMedicDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimCommonDiction_utMedicDiction_UserType.pas"
// �����: 27.01.2009 12:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Diction::View::Diction::PrimCommonDiction::utMedicDiction
//
// ������� ����������� ��������
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
  ,
  PrimCommonDiction_utTips_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� utMedicDiction }
  utMedicDictionName = 'utMedicDiction';
   { ��������� ������������� ����������������� ���� "������� ����������� ��������" }
  utMedicDiction = TvcmUserType(utTips + 1);
   { ������� ����������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utMedicDiction = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utMedicDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utMedicDiction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utMedicDiction

class function Tkw_FormUserType_utMedicDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utMedicDiction';
end;//Tkw_FormUserType_utMedicDiction.GetWordNameForRegister

function Tkw_FormUserType_utMedicDiction.GetInteger: Integer;
 {-}
begin
 Result := utMedicDiction;
end;//Tkw_FormUserType_utMedicDiction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utMedicDiction
 Tkw_FormUserType_utMedicDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.