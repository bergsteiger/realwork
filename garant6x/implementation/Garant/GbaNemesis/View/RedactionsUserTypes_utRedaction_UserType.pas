unit RedactionsUserTypes_utRedaction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/RedactionsUserTypes_utRedaction_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::RedactionsUserTypes::utRedaction
//
// ��������
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
   { ��������� ��� ���� ����� utRedaction }
  utRedactionName = 'utRedaction';
   { ��������� ������������� ����������������� ���� "��������" }
  utRedaction = TvcmUserType(0);
   { �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utRedaction = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utRedaction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utRedaction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utRedaction

class function Tkw_FormUserType_utRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utRedaction';
end;//Tkw_FormUserType_utRedaction.GetWordNameForRegister

function Tkw_FormUserType_utRedaction.GetInteger: Integer;
 {-}
begin
 Result := utRedaction;
end;//Tkw_FormUserType_utRedaction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utRedaction
 Tkw_FormUserType_utRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.