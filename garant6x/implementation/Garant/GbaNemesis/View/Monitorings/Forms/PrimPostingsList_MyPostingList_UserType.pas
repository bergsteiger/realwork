unit PrimPostingsList_MyPostingList_UserType;
 {* �����. ��� ��������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_MyPostingList_UserType.pas"
// ���������: "UserType"
// ������� ������: "MyPostingList" MUID: (4BD71E5E01D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ MyPostingListLocalConstants }
 str_MyPostingListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MyPostingListCaption'; rValue : '�����. ��� ��������� �����');
  {* ��������� ����������������� ���� "�����. ��� ��������� �����" }
 {* ��������� ��� ���� ����� MyPostingList }
 MyPostingListName = 'MyPostingList';
  {* ��������� ������������� ����������������� ���� "�����. ��� ��������� �����" }
 MyPostingList = TvcmUserType(0);
  {* �����. ��� ��������� ����� }
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
 Tkw_FormUserType_MyPostingList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� MyPostingList }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_MyPostingList
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_MyPostingList.GetInteger: Integer;
begin
 Result := MyPostingList;
end;//Tkw_FormUserType_MyPostingList.GetInteger

class function Tkw_FormUserType_MyPostingList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::MyPostingList';
end;//Tkw_FormUserType_MyPostingList.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_MyPostingListCaption.Init;
 {* ������������� str_MyPostingListCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_MyPostingList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_MyPostingList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
