unit ListUserTypes_lftUserCR1_UserType;
 {* ������������� ������� ��������� ���������� 1 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCR1_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftUserCR1" MUID: (4BD5892F01D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCToPart_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ lftUserCR1LocalConstants }
 str_lftUserCR1Caption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1Caption'; rValue : '������������� ������� ��������� ���������� 1');
  {* ��������� ����������������� ���� "������������� ������� ��������� ���������� 1" }
 str_lftUserCR1SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftUserCR1SettingsCaption'; rValue : '������: ������ �� ��������� (��� ����������)/������ �� �������� (��� ����������)');
  {* ��������� ����������������� ���� "������������� ������� ��������� ���������� 1" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftUserCR1 }
 lftUserCR1Name = 'lftUserCR1';
  {* ��������� ������������� ����������������� ���� "������������� ������� ��������� ���������� 1" }
 lftUserCR1 = TvcmUserType(lftCToPart + 1);
  {* ������������� ������� ��������� ���������� 1 }
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
 Tkw_FormUserType_lftUserCR1 = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftUserCR1 }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftUserCR1
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftUserCR1.GetInteger: Integer;
begin
 Result := lftUserCR1;
end;//Tkw_FormUserType_lftUserCR1.GetInteger

class function Tkw_FormUserType_lftUserCR1.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftUserCR1';
end;//Tkw_FormUserType_lftUserCR1.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftUserCR1Caption.Init;
 {* ������������� str_lftUserCR1Caption }
 str_lftUserCR1SettingsCaption.Init;
 {* ������������� str_lftUserCR1SettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCR1.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftUserCR1 }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
