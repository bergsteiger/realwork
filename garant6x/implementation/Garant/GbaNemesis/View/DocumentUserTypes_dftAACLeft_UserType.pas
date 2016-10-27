unit DocumentUserTypes_dftAACLeft_UserType;
 {* ����� ����� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACLeft_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftAACLeft" MUID: (4FF2ECB40153)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftAACLeftLocalConstants }
 str_dftAACLeftCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftCaption'; rValue : '����� ����� ������������ �������');
  {* ��������� ����������������� ���� "����� ����� ������������ �������" }
 str_dftAACLeftSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftSettingsCaption'; rValue : '����� ����� ������������ �������');
  {* ��������� ����������������� ���� "����� ����� ������������ �������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftAACLeft }
 dftAACLeftName = 'dftAACLeft';
  {* ��������� ������������� ����������������� ���� "����� ����� ������������ �������" }
 dftAACLeft = TvcmUserType(dftDrugSynchroView + 1);
  {* ����� ����� ������������ ������� }
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
 Tkw_FormUserType_dftAACLeft = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAACLeft }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAACLeft
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAACLeft.GetInteger: Integer;
begin
 Result := dftAACLeft;
end;//Tkw_FormUserType_dftAACLeft.GetInteger

class function Tkw_FormUserType_dftAACLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAACLeft';
end;//Tkw_FormUserType_dftAACLeft.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAACLeftCaption.Init;
 {* ������������� str_dftAACLeftCaption }
 str_dftAACLeftSettingsCaption.Init;
 {* ������������� str_dftAACLeftSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACLeft.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAACLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
