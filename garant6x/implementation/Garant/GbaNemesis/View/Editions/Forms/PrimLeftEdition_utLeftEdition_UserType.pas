unit PrimLeftEdition_utLeftEdition_UserType;
 {* ���������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimLeftEdition_utLeftEdition_UserType.pas"
// ���������: "UserType"
// ������� ������: "utLeftEdition" MUID: (4BD7056800D3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utLeftEditionLocalConstants }
 str_utLeftEditionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utLeftEditionCaption'; rValue : '���������� ��������');
  {* ��������� ����������������� ���� "���������� ��������" }
 {* ��������� ��� ���� ����� utLeftEdition }
 utLeftEditionName = 'utLeftEdition';
  {* ��������� ������������� ����������������� ���� "���������� ��������" }
 utLeftEdition = TvcmUserType(0);
  {* ���������� �������� }
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
 Tkw_FormUserType_utLeftEdition = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utLeftEdition }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utLeftEdition
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utLeftEdition.GetInteger: Integer;
begin
 Result := utLeftEdition;
end;//Tkw_FormUserType_utLeftEdition.GetInteger

class function Tkw_FormUserType_utLeftEdition.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utLeftEdition';
end;//Tkw_FormUserType_utLeftEdition.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utLeftEditionCaption.Init;
 {* ������������� str_utLeftEditionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utLeftEdition.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utLeftEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
