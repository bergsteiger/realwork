unit PrimSaveLoadUserTypes_slqtOldKW_UserType;
 {* �����: �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtOldKW_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtOldKW" MUID: (4BD5BB9E0201)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtKW_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ slqtOldKWLocalConstants }
 str_slqtOldKWCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWCaption'; rValue : '�����: �� ��������');
  {* ��������� ����������������� ���� "�����: �� ��������" }
 str_slqtOldKWSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtOldKWSettingsCaption'; rValue : '�����: �� �������� (�������������)');
  {* ��������� ����������������� ���� "�����: �� ��������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� slqtOldKW }
 slqtOldKWName = 'slqtOldKW';
  {* ��������� ������������� ����������������� ���� "�����: �� ��������" }
 slqtOldKW = TvcmUserType(slqtKW + 1);
  {* �����: �� �������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtOldKW = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtOldKW }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtOldKW
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtOldKW.GetInteger: Integer;
begin
 Result := slqtOldKW;
end;//Tkw_FormUserType_slqtOldKW.GetInteger

class function Tkw_FormUserType_slqtOldKW.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtOldKW';
end;//Tkw_FormUserType_slqtOldKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtOldKWCaption.Init;
 {* ������������� str_slqtOldKWCaption }
 str_slqtOldKWSettingsCaption.Init;
 {* ������������� str_slqtOldKWSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtOldKW.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtOldKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
