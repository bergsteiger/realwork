unit PrimSaveLoadUserTypes_slqtKW_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtKW_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtKW
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
  PrimSaveLoadUserTypes_slqtAttribute_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtKW }
  slqtKWName = 'slqtKW';
   { ��������� ������������� ����������������� ���� "�����: �� ��������" }
  slqtKW = TvcmUserType(slqtAttribute + 1);
   { �����: �� �������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtKW = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtKW }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtKW
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtKW

class function Tkw_FormUserType_slqtKW.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtKW';
end;//Tkw_FormUserType_slqtKW.GetWordNameForRegister

function Tkw_FormUserType_slqtKW.GetInteger: Integer;
 {-}
begin
 Result := slqtKW;
end;//Tkw_FormUserType_slqtKW.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtKW
 Tkw_FormUserType_slqtKW.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.