unit PrimCommonDiction_utTips_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimCommonDiction_utTips_UserType.pas"
// �����: 27.01.2009 12:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Diction::View::Diction::PrimCommonDiction::utTips
//
// ����� ���
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
   { ��������� ��� ���� ����� utTips }
  utTipsName = 'utTips';
   { ��������� ������������� ����������������� ���� "����� ���" }
  utTips = TvcmUserType(0);
   { ����� ��� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utTips = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utTips }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utTips
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utTips

class function Tkw_FormUserType_utTips.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utTips';
end;//Tkw_FormUserType_utTips.GetWordNameForRegister

function Tkw_FormUserType_utTips.GetInteger: Integer;
 {-}
begin
 Result := utTips;
end;//Tkw_FormUserType_utTips.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utTips
 Tkw_FormUserType_utTips.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.