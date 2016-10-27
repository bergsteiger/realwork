unit PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType;
 {* �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType.pas"
// ���������: "UserType"
// ������� ������: "utMainMenuWithProfNews" MUID: (56FACF1F00E0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utMainMenuWithProfNewsLocalConstants }
 str_utMainMenuWithProfNewsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainMenuWithProfNewsCaption'; rValue : '�������� ����');
  {* ��������� ����������������� ���� "�������� ����" }
 {* ��������� ��� ���� ����� utMainMenuWithProfNews }
 utMainMenuWithProfNewsName = 'utMainMenuWithProfNews';
  {* ��������� ������������� ����������������� ���� "�������� ����" }
 utMainMenuWithProfNews = TvcmUserType(0);
  {* �������� ���� }
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
 Tkw_FormUserType_utMainMenuWithProfNews = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utMainMenuWithProfNews }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utMainMenuWithProfNews
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMainMenuWithProfNews.GetInteger: Integer;
begin
 Result := utMainMenuWithProfNews;
end;//Tkw_FormUserType_utMainMenuWithProfNews.GetInteger

class function Tkw_FormUserType_utMainMenuWithProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utMainMenuWithProfNews';
end;//Tkw_FormUserType_utMainMenuWithProfNews.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utMainMenuWithProfNewsCaption.Init;
 {* ������������� str_utMainMenuWithProfNewsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainMenuWithProfNews.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utMainMenuWithProfNews }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
