unit ForbidAutoregistration_ut_ForbidAutoregistration_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/ForbidAutoregistration_ut_ForbidAutoregistration_UserType.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::Admin::ForbidAutoregistration::ut_ForbidAutoregistration
//
// ��������� ���������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
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
    { ��������� ��� ���� ����� ut_ForbidAutoregistration }
   ut_ForbidAutoregistrationName = 'ut_ForbidAutoregistration';
    { ��������� ������������� ����������������� ���� "��������� ���������������" }
   ut_ForbidAutoregistration = TvcmUserType(0);
    { ��������� ��������������� }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_ForbidAutoregistration = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_ForbidAutoregistration }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_ForbidAutoregistration
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_ForbidAutoregistration

class function Tkw_FormUserType_ut_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_ForbidAutoregistration';
end;//Tkw_FormUserType_ut_ForbidAutoregistration.GetWordNameForRegister

function Tkw_FormUserType_ut_ForbidAutoregistration.GetInteger: Integer;
 {-}
begin
 Result := ut_ForbidAutoregistration;
end;//Tkw_FormUserType_ut_ForbidAutoregistration.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_ForbidAutoregistration
 Tkw_FormUserType_ut_ForbidAutoregistration.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.