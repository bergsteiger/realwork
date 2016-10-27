unit DocumentUserTypes_dftAACRight_UserType;
 {* ������ ����� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACRight_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftAACRight" MUID: (4FF2ECC2023E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACLeft_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftAACRightLocalConstants }
 str_dftAACRightCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightCaption'; rValue : '������ ����� ������������ �������');
  {* ��������� ����������������� ���� "������ ����� ������������ �������" }
 str_dftAACRightSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightSettingsCaption'; rValue : '������ ����� ������������ �������');
  {* ��������� ����������������� ���� "������ ����� ������������ �������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftAACRight }
 dftAACRightName = 'dftAACRight';
  {* ��������� ������������� ����������������� ���� "������ ����� ������������ �������" }
 dftAACRight = TvcmUserType(dftAACLeft + 1);
  {* ������ ����� ������������ ������� }
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
 Tkw_FormUserType_dftAACRight = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAACRight }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACRight
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACRight.GetInteger: Integer;
begin
 Result := dftAACRight;
end;//Tkw_FormUserType_dftAACRight.GetInteger

class function Tkw_FormUserType_dftAACRight.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAACRight';
end;//Tkw_FormUserType_dftAACRight.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAACRightCaption.Init;
 {* ������������� str_dftAACRightCaption }
 str_dftAACRightSettingsCaption.Init;
 {* ������������� str_dftAACRightSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACRight.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAACRight }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
