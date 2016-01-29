unit DictionContainerUserTypes_slqtMedicDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DictionContainerUserTypes_slqtMedicDiction_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::DictionLike::View::DictionLikeForms::DictionContainerUserTypes::slqtMedicDiction
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
  DictionContainerUserTypes_slqtDiction_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtMedicDiction }
  slqtMedicDictionName = 'slqtMedicDiction';
   { ��������� ������������� ����������������� ���� "������� ����������� ��������" }
  slqtMedicDiction = TvcmUserType(slqtDiction + 1);
   { ������� ����������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtMedicDiction = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtMedicDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtMedicDiction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtMedicDiction

class function Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtMedicDiction';
end;//Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister

function Tkw_FormUserType_slqtMedicDiction.GetInteger: Integer;
 {-}
begin
 Result := slqtMedicDiction;
end;//Tkw_FormUserType_slqtMedicDiction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtMedicDiction
 Tkw_FormUserType_slqtMedicDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.