unit PrimCommonDiction_utMedicDiction_UserType;
 {* ������� ����������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utMedicDiction_UserType.pas"
// ���������: "UserType"
// ������� ������: "utMedicDiction" MUID: (4BD6F18301FD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCommonDiction_utTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utMedicDictionLocalConstants }
 str_utMedicDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMedicDictionCaption'; rValue : '������� ����������� ��������');
  {* ��������� ����������������� ���� "������� ����������� ��������" }
 str_utMedicDictionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMedicDictionSettingsCaption'; rValue : '������� ����������� ��������: ������ �������� (�������)');
  {* ��������� ����������������� ���� "������� ����������� ��������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utMedicDiction }
 utMedicDictionName = 'utMedicDiction';
  {* ��������� ������������� ����������������� ���� "������� ����������� ��������" }
 utMedicDiction = TvcmUserType(utTips + 1);
  {* ������� ����������� �������� }
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
 Tkw_FormUserType_utMedicDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utMedicDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utMedicDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMedicDiction.GetInteger: Integer;
begin
 Result := utMedicDiction;
end;//Tkw_FormUserType_utMedicDiction.GetInteger

class function Tkw_FormUserType_utMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utMedicDiction';
end;//Tkw_FormUserType_utMedicDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utMedicDictionCaption.Init;
 {* ������������� str_utMedicDictionCaption }
 str_utMedicDictionSettingsCaption.Init;
 {* ������������� str_utMedicDictionSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMedicDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utMedicDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
