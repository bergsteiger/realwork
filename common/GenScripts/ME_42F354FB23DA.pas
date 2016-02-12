unit PictureInfo_ut_PictureInfo_UserType;
 {* ���������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_ut_PictureInfo_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PictureInfo = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_PictureInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_PictureInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_PictureInfo';
end;//Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_PictureInfo.GetInteger: Integer;
begin
 Result := ut_PictureInfo;
end;//Tkw_FormUserType_ut_PictureInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PictureInfo.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_PictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
