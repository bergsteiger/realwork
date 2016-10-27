unit CompInfo_ut_CompInfo_UserType;
 {* ���������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_ut_CompInfo_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_CompInfo" MUID: (A462190E3592)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_CompInfoLocalConstants }
 str_ut_CompInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CompInfoCaption'; rValue : '���������� � ���������');
  {* ��������� ����������������� ���� "���������� � ���������" }
 {* ��������� ��� ���� ����� ut_CompInfo }
 ut_CompInfoName = 'ut_CompInfo';
  {* ��������� ������������� ����������������� ���� "���������� � ���������" }
 ut_CompInfo = TvcmUserType(0);
  {* ���������� � ��������� }
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
 Tkw_FormUserType_ut_CompInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_CompInfo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_CompInfo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CompInfo.GetInteger: Integer;
begin
 Result := ut_CompInfo;
end;//Tkw_FormUserType_ut_CompInfo.GetInteger

class function Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_CompInfo';
end;//Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_CompInfoCaption.Init;
 {* ������������� str_ut_CompInfoCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CompInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_CompInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
