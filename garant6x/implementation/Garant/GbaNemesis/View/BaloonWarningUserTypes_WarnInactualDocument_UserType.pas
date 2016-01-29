unit BaloonWarningUserTypes_WarnInactualDocument_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnInactualDocument_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnInactualDocument
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
  BaloonWarningUserTypes_WarnOnControl_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { ��������� ��� ���� ����� WarnInactualDocument }
  WarnInactualDocumentName = 'WarnInactualDocument';
   { ��������� ������������� ����������������� ���� "" }
  WarnInactualDocument = TvcmUserType(WarnOnControl + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnInactualDocument = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� WarnInactualDocument }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnInactualDocument
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnInactualDocument

class function Tkw_FormUserType_WarnInactualDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::WarnInactualDocument';
end;//Tkw_FormUserType_WarnInactualDocument.GetWordNameForRegister

function Tkw_FormUserType_WarnInactualDocument.GetInteger: Integer;
 {-}
begin
 Result := WarnInactualDocument;
end;//Tkw_FormUserType_WarnInactualDocument.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_WarnInactualDocument
 Tkw_FormUserType_WarnInactualDocument.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.