unit ListUserTypes_lftDrugList_UserType;
 {* ������ ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugList_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftDrugList" MUID: (4BD58B4002A1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ lftDrugListLocalConstants }
 str_lftDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugListCaption'; rValue : '������ ����������');
  {* ��������� ����������������� ���� "������ ����������" }
 {* ��������� ��� ���� ����� lftDrugList }
 lftDrugListName = 'lftDrugList';
  {* ��������� ������������� ����������������� ���� "������ ����������" }
 lftDrugList = TvcmUserType(lftUserCRList2_SynchorForm + 1);
  {* ������ ���������� }
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
 Tkw_FormUserType_lftDrugList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftDrugList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftDrugList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftDrugList.GetInteger: Integer;
begin
 Result := lftDrugList;
end;//Tkw_FormUserType_lftDrugList.GetInteger

class function Tkw_FormUserType_lftDrugList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftDrugList';
end;//Tkw_FormUserType_lftDrugList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftDrugListCaption.Init;
 {* ������������� str_lftDrugListCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftDrugList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
