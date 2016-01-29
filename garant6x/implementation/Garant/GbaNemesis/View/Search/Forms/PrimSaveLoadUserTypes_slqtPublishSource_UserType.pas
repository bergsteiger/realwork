unit PrimSaveLoadUserTypes_slqtPublishSource_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtPublishSource_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtPublishSource
//
// �����: �� ��������� �������������
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
  PrimSaveLoadUserTypes_slqtOldKW_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtPublishSource }
  slqtPublishSourceName = 'slqtPublishSource';
   { ��������� ������������� ����������������� ���� "�����: �� ��������� �������������" }
  slqtPublishSource = TvcmUserType(slqtOldKW + 1);
   { �����: �� ��������� ������������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtPublishSource = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtPublishSource }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtPublishSource
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtPublishSource

class function Tkw_FormUserType_slqtPublishSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtPublishSource';
end;//Tkw_FormUserType_slqtPublishSource.GetWordNameForRegister

function Tkw_FormUserType_slqtPublishSource.GetInteger: Integer;
 {-}
begin
 Result := slqtPublishSource;
end;//Tkw_FormUserType_slqtPublishSource.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtPublishSource
 Tkw_FormUserType_slqtPublishSource.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.