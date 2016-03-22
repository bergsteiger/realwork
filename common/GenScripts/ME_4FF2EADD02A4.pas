unit AACContainerPrim_AACContainer_UserType;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerPrim_AACContainer_UserType.pas"
// ���������: "UserType"
// ������� ������: "AACContainer" MUID: (4FF2EADD02A4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_AACContainer = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� AACContainer }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_AACContainer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_AACContainer.GetInteger: Integer;
begin
 Result := AACContainer;
end;//Tkw_FormUserType_AACContainer.GetInteger

class function Tkw_FormUserType_AACContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::AACContainer';
end;//Tkw_FormUserType_AACContainer.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_AACContainer.RegisterInEngine;
 {* ����������� Tkw_FormUserType_AACContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
