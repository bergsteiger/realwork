unit DocumentUserTypes_dftAACContentsLeft_UserType;
 {* ����� ����� ���������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACContentsLeft_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftAACContentsLeft" MUID: (4FF43F4B0071)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACRight_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftAACContentsLeftLocalConstants }
 str_dftAACContentsLeftCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsLeftCaption'; rValue : '����� ����� ���������� ������������ �������');
  {* ��������� ����������������� ���� "����� ����� ���������� ������������ �������" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftAACContentsLeft = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAACContentsLeft }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACContentsLeft
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACContentsLeft.GetInteger: Integer;
begin
 Result := dftAACContentsLeft;
end;//Tkw_FormUserType_dftAACContentsLeft.GetInteger

class function Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAACContentsLeft';
end;//Tkw_FormUserType_dftAACContentsLeft.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAACContentsLeftCaption.Init;
 {* ������������� str_dftAACContentsLeftCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACContentsLeft.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAACContentsLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
