unit DocumentUserTypes_dftTips_UserType;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTips_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftTips" MUID: (4B040FE700A1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ dftTipsLocalConstants }
 str_dftTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsCaption'; rValue : '����� ���');
  {* ��������� ����������������� ���� "����� ���" }
 str_dftTipsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsSettingsCaption'; rValue : '����� ���: ����� ������');
  {* ��������� ����������������� ���� "����� ���" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftTips }
 dftTipsName = 'dftTips';
  {* ��������� ������������� ����������������� ���� "����� ���" }
 dftTips = TvcmUserType(dftAnnotationSynchroView + 1);
  {* ����� ��� }
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
 Tkw_FormUserType_dftTips = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftTips }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftTips
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftTips.GetInteger: Integer;
begin
 Result := dftTips;
end;//Tkw_FormUserType_dftTips.GetInteger

class function Tkw_FormUserType_dftTips.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftTips';
end;//Tkw_FormUserType_dftTips.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftTipsCaption.Init;
 {* ������������� str_dftTipsCaption }
 str_dftTipsSettingsCaption.Init;
 {* ������������� str_dftTipsSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTips.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
