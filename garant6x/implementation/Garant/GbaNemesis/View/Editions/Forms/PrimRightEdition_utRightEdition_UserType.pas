unit PrimRightEdition_utRightEdition_UserType;
 {* ������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas"
// ���������: "UserType"
// ������� ������: "utRightEdition" MUID: (4BD705A001E0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utRightEditionLocalConstants }
 str_utRightEditionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRightEditionCaption'; rValue : '������� ��������');
  {* ��������� ����������������� ���� "������� ��������" }
 {* ��������� ��� ���� ����� utRightEdition }
 utRightEditionName = 'utRightEdition';
  {* ��������� ������������� ����������������� ���� "������� ��������" }
 utRightEdition = TvcmUserType(0);
  {* ������� �������� }
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
 Tkw_FormUserType_utRightEdition = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utRightEdition }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utRightEdition
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utRightEdition.GetInteger: Integer;
begin
 Result := utRightEdition;
end;//Tkw_FormUserType_utRightEdition.GetInteger

class function Tkw_FormUserType_utRightEdition.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utRightEdition';
end;//Tkw_FormUserType_utRightEdition.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utRightEditionCaption.Init;
 {* ������������� str_utRightEditionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRightEdition.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utRightEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
