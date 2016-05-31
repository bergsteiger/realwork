unit PrimSaveLoadUserTypes_slqtPublishSource_UserType;
 {* �����: �� ��������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPublishSource_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtPublishSource" MUID: (4BD5BBB602BB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtOldKW_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ slqtPublishSourceLocalConstants }
 str_slqtPublishSourceCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPublishSourceCaption'; rValue : '�����: �� ��������� �������������');
  {* ��������� ����������������� ���� "�����: �� ��������� �������������" }
 {* ��������� ��� ���� ����� slqtPublishSource }
 slqtPublishSourceName = 'slqtPublishSource';
  {* ��������� ������������� ����������������� ���� "�����: �� ��������� �������������" }
 slqtPublishSource = TvcmUserType(slqtOldKW + 1);
  {* �����: �� ��������� ������������� }
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
 Tkw_FormUserType_slqtPublishSource = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtPublishSource }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtPublishSource
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtPublishSource.GetInteger: Integer;
begin
 Result := slqtPublishSource;
end;//Tkw_FormUserType_slqtPublishSource.GetInteger

class function Tkw_FormUserType_slqtPublishSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtPublishSource';
end;//Tkw_FormUserType_slqtPublishSource.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtPublishSourceCaption.Init;
 {* ������������� str_slqtPublishSourceCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPublishSource.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtPublishSource }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
