unit PictureInfo_ut_PictureInfo_UserType;
 {* ���������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_ut_PictureInfo_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_PictureInfo" MUID: (42F354FB23DA)

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
 {* ������������ ������ ut_PictureInfoLocalConstants }
 str_ut_PictureInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PictureInfoCaption'; rValue : '���������� � ��������');
  {* ��������� ����������������� ���� "���������� � ��������" }
 {* ��������� ��� ���� ����� ut_PictureInfo }
 ut_PictureInfoName = 'ut_PictureInfo';
  {* ��������� ������������� ����������������� ���� "���������� � ��������" }
 ut_PictureInfo = TvcmUserType(0);
  {* ���������� � �������� }
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
 Tkw_FormUserType_ut_PictureInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_PictureInfo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_PictureInfo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_PictureInfo.GetInteger: Integer;
begin
 Result := ut_PictureInfo;
end;//Tkw_FormUserType_ut_PictureInfo.GetInteger

class function Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_PictureInfo';
end;//Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_PictureInfoCaption.Init;
 {* ������������� str_ut_PictureInfoCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PictureInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_PictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
