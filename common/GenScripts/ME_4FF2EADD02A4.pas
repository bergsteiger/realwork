unit AACContainerPrim_AACContainer_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContainer_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� AACContainer }
 AACContainerName = 'AACContainer';
  {* ��������� ������������� ����������������� ���� "" }
 AACContainer = TvcmUserType(0);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContainer = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� AACContainer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_AACContainer
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_AACContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::AACContainer';
end;//Tkw_FormUserType_AACContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_AACContainer.GetInteger: Integer;
begin
 Result := AACContainer;
end;//Tkw_FormUserType_AACContainer.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContainer.RegisterInEngine;
 {* ����������� Tkw_FormUserType_AACContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
