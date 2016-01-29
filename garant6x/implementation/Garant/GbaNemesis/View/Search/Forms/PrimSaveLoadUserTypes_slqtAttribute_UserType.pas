unit PrimSaveLoadUserTypes_slqtAttribute_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtAttribute_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtAttribute
//
// �����: �� ����������
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtAttribute }
  slqtAttributeName = 'slqtAttribute';
   { ��������� ������������� ����������������� ���� "�����: �� ����������" }
  slqtAttribute = TvcmUserType(0);
   { �����: �� ���������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtAttribute = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtAttribute }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtAttribute
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtAttribute

class function Tkw_FormUserType_slqtAttribute.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtAttribute';
end;//Tkw_FormUserType_slqtAttribute.GetWordNameForRegister

function Tkw_FormUserType_slqtAttribute.GetInteger: Integer;
 {-}
begin
 Result := slqtAttribute;
end;//Tkw_FormUserType_slqtAttribute.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtAttribute
 Tkw_FormUserType_slqtAttribute.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.