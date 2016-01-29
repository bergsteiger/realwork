unit ListUserTypes_lftDrugInternationalNameSynonyms_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftDrugInternationalNameSynonyms_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftDrugInternationalNameSynonyms
//
// �������� �� �������������� ��������
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
  ListUserTypes_lftDrugList_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftDrugInternationalNameSynonyms }
  lftDrugInternationalNameSynonymsName = 'lftDrugInternationalNameSynonyms';
   { ��������� ������������� ����������������� ���� "�������� �� �������������� ��������" }
  lftDrugInternationalNameSynonyms = TvcmUserType(lftDrugList + 1);
   { �������� �� �������������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftDrugInternationalNameSynonyms = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftDrugInternationalNameSynonyms }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftDrugInternationalNameSynonyms

class function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftDrugInternationalNameSynonyms';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister

function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger: Integer;
 {-}
begin
 Result := lftDrugInternationalNameSynonyms;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftDrugInternationalNameSynonyms
 Tkw_FormUserType_lftDrugInternationalNameSynonyms.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.