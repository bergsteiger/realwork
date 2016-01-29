unit PrimSaveLoadUserTypes_slqtOldKW_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtOldKW_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtOldKW
//
// �����: �� ��������
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
  PrimSaveLoadUserTypes_slqtKW_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtOldKW }
  slqtOldKWName = 'slqtOldKW';
   { ��������� ������������� ����������������� ���� "�����: �� ��������" }
  slqtOldKW = TvcmUserType(slqtKW + 1);
   { �����: �� �������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtOldKW = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtOldKW }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtOldKW
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtOldKW

class function Tkw_FormUserType_slqtOldKW.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtOldKW';
end;//Tkw_FormUserType_slqtOldKW.GetWordNameForRegister

function Tkw_FormUserType_slqtOldKW.GetInteger: Integer;
 {-}
begin
 Result := slqtOldKW;
end;//Tkw_FormUserType_slqtOldKW.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtOldKW
 Tkw_FormUserType_slqtOldKW.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.