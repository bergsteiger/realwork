unit PrimCreateFilter_cfCreate_UserType;
 {* ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas"
// ���������: "UserType"
// ������� ������: "cfCreate" MUID: (4CB6D9AE0083)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ cfCreateLocalConstants }
 str_cfCreateCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cfCreateCaption'; rValue : '������� ������');
  {* ��������� ����������������� ���� "������� ������" }
 {* ��������� ��� ���� ����� cfCreate }
 cfCreateName = 'cfCreate';
  {* ��������� ������������� ����������������� ���� "������� ������" }
 cfCreate = TvcmUserType(0);
  {* ������� ������ }
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
 Tkw_FormUserType_cfCreate = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cfCreate }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cfCreate
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cfCreate.GetInteger: Integer;
begin
 Result := cfCreate;
end;//Tkw_FormUserType_cfCreate.GetInteger

class function Tkw_FormUserType_cfCreate.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cfCreate';
end;//Tkw_FormUserType_cfCreate.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cfCreateCaption.Init;
 {* ������������� str_cfCreateCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfCreate.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cfCreate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
