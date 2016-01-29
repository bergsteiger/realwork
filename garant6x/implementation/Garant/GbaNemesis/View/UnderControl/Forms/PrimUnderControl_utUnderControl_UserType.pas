unit PrimUnderControl_utUnderControl_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/UnderControl/Forms/PrimUnderControl_utUnderControl_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������ � ���������� � ������� ����������::UnderControl::View::UnderControl::PrimUnderControl::utUnderControl
//
// ��������� �� ��������
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
   { ��������� ��� ���� ����� utUnderControl }
  utUnderControlName = 'utUnderControl';
   { ��������� ������������� ����������������� ���� "��������� �� ��������" }
  utUnderControl = TvcmUserType(0);
   { ��������� �� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utUnderControl = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utUnderControl }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utUnderControl
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utUnderControl

class function Tkw_FormUserType_utUnderControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utUnderControl';
end;//Tkw_FormUserType_utUnderControl.GetWordNameForRegister

function Tkw_FormUserType_utUnderControl.GetInteger: Integer;
 {-}
begin
 Result := utUnderControl;
end;//Tkw_FormUserType_utUnderControl.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utUnderControl
 Tkw_FormUserType_utUnderControl.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.