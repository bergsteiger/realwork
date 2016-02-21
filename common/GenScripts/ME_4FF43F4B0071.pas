unit DocumentUserTypes_dftAACContentsLeft_UserType;
 {* ����� ����� ���������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsLeft_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACRight_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftAACContentsLeft }
 dftAACContentsLeftName = 'dftAACContentsLeft';
  {* ��������� ������������� ����������������� ���� "����� ����� ���������� ������������ �������" }
 dftAACContentsLeft = TvcmUserType(dftAACRight + 1);
  {* ����� ����� ���������� ������������ ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsLeft = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAACContentsLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAACContentsLeft
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAACContentsLeft';
end;//Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister

function Tkw_FormUserType_dftAACContentsLeft.GetInteger: Integer;
begin
 Result := dftAACContentsLeft;
end;//Tkw_FormUserType_dftAACContentsLeft.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsLeft.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAACContentsLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
