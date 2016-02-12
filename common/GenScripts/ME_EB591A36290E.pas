unit F1LikeTextLoad_ut_F1LikeTextLoad_UserType;
 {* F1LikeTextLoad }

// ������: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_ut_F1LikeTextLoad_UserType.pas"
// ���������: "UserType"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� ut_F1LikeTextLoad }
 ut_F1LikeTextLoadName = 'ut_F1LikeTextLoad';
  {* ��������� ������������� ����������������� ���� "F1LikeTextLoad" }
 ut_F1LikeTextLoad = TvcmUserType(0);
  {* F1LikeTextLoad }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeTextLoad = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_F1LikeTextLoad }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_F1LikeTextLoad
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_F1LikeTextLoad';
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister

function Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger: Integer;
begin
 Result := ut_F1LikeTextLoad;
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeTextLoad.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_F1LikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
