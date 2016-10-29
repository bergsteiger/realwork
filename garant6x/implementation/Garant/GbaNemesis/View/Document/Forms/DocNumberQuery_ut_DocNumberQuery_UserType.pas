unit DocNumberQuery_ut_DocNumberQuery_UserType;
 {* ������� �������� �� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQuery_ut_DocNumberQuery_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_DocNumberQuery" MUID: (AB56D1A71FAC)

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
 {* ������������ ������ ut_DocNumberQueryLocalConstants }
 str_ut_DocNumberQueryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DocNumberQueryCaption'; rValue : '������� �������� �� ������');
  {* ��������� ����������������� ���� "������� �������� �� ������" }
 {* ��������� ��� ���� ����� ut_DocNumberQuery }
 ut_DocNumberQueryName = 'ut_DocNumberQuery';
  {* ��������� ������������� ����������������� ���� "������� �������� �� ������" }
 ut_DocNumberQuery = TvcmUserType(0);
  {* ������� �������� �� ������ }
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
 Tkw_FormUserType_ut_DocNumberQuery = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_DocNumberQuery }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_DocNumberQuery
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_DocNumberQuery.GetInteger: Integer;
begin
 Result := ut_DocNumberQuery;
end;//Tkw_FormUserType_ut_DocNumberQuery.GetInteger

class function Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_DocNumberQuery';
end;//Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_DocNumberQueryCaption.Init;
 {* ������������� str_ut_DocNumberQueryCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DocNumberQuery.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_DocNumberQuery }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
