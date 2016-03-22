unit DocumentUserTypes_dftAACContentsRight_UserType;
 {* ������ ����� ���������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsRight_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftAACContentsRight" MUID: (4FF43F64023A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACContentsLeft_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftAACContentsRight }
 dftAACContentsRightName = 'dftAACContentsRight';
  {* ��������� ������������� ����������������� ���� "������ ����� ���������� ������������ �������" }
 dftAACContentsRight = TvcmUserType(dftAACContentsLeft + 1);
  {* ������ ����� ���������� ������������ ������� }
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
 Tkw_FormUserType_dftAACContentsRight = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAACContentsRight }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACContentsRight
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACContentsRight.GetInteger: Integer;
begin
 Result := dftAACContentsRight;
end;//Tkw_FormUserType_dftAACContentsRight.GetInteger

class function Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAACContentsRight';
end;//Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsRight.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAACContentsRight }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
