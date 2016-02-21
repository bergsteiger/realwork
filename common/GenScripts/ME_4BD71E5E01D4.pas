unit PrimPostingsList_MyPostingList_UserType;
 {* �����. ��� ��������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsList_MyPostingList_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_MyPostingList = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� MyPostingList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_MyPostingList
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_MyPostingList.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::MyPostingList';
end;//Tkw_FormUserType_MyPostingList.GetWordNameForRegister

function Tkw_FormUserType_MyPostingList.GetInteger: Integer;
begin
 Result := MyPostingList;
end;//Tkw_FormUserType_MyPostingList.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_MyPostingList.RegisterInEngine;
 {* ����������� Tkw_FormUserType_MyPostingList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
