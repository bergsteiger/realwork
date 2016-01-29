unit PrimAdmin_utAdmin_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimAdmin_utAdmin_UserType.pas"
// �����: 11.11.2009 21:24
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������������::Admin::View::Admin::PrimAdmin::utAdmin
//
// ����������������� �������������
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
   { ��������� ��� ���� ����� utAdmin }
  utAdminName = 'utAdmin';
   { ��������� ������������� ����������������� ���� "����������������� �������������" }
  utAdmin = TvcmUserType(0);
   { ����������������� ������������� }
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
{$If defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utAdmin = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utAdmin }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utAdmin
{$IfEnd} //Admin AND not NoScripts

{$If defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utAdmin

class function Tkw_FormUserType_utAdmin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utAdmin';
end;//Tkw_FormUserType_utAdmin.GetWordNameForRegister

function Tkw_FormUserType_utAdmin.GetInteger: Integer;
 {-}
begin
 Result := utAdmin;
end;//Tkw_FormUserType_utAdmin.GetInteger

{$IfEnd} //Admin AND not NoScripts
{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utAdmin
 Tkw_FormUserType_utAdmin.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts

end.