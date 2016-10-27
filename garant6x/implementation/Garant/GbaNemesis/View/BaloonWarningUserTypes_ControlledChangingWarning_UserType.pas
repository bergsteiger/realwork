unit BaloonWarningUserTypes_ControlledChangingWarning_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_ControlledChangingWarning_UserType.pas"
// ���������: "UserType"
// ������� ������: "ControlledChangingWarning" MUID: (4DBFF6FD020F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ ControlledChangingWarningLocalConstants }
 str_ControlledChangingWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningCaption'; rValue : '');
  {* ��������� ����������������� ���� "" }
 {* ��������� ��� ���� ����� ControlledChangingWarning }
 ControlledChangingWarningName = 'ControlledChangingWarning';
  {* ��������� ������������� ����������������� ���� "" }
 ControlledChangingWarning = TvcmUserType(OldBaseWarning + 1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ControlledChangingWarning = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ControlledChangingWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ControlledChangingWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ControlledChangingWarning.GetInteger: Integer;
begin
 Result := ControlledChangingWarning;
end;//Tkw_FormUserType_ControlledChangingWarning.GetInteger

class function Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ControlledChangingWarning';
end;//Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ControlledChangingWarningCaption.Init;
 {* ������������� str_ControlledChangingWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ControlledChangingWarning.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ControlledChangingWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
