unit QFLikeTextLoad_ut_QFLikeTextLoad_UserType;
 {* ����� ��� ������ � �� }

// ������: "w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_ut_QFLikeTextLoad_UserType.pas"
// ���������: "UserType"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* ��������� ��� ���� ����� ut_QFLikeTextLoad }
 ut_QFLikeTextLoadName = 'ut_QFLikeTextLoad';
  {* ��������� ������������� ����������������� ���� "����� ��� ������ � ��" }
 ut_QFLikeTextLoad = TvcmUserType(0);
  {* ����� ��� ������ � �� }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_QFLikeTextLoad = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_QFLikeTextLoad }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_QFLikeTextLoad
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_QFLikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_QFLikeTextLoad';
end;//Tkw_FormUserType_ut_QFLikeTextLoad.GetWordNameForRegister

function Tkw_FormUserType_ut_QFLikeTextLoad.GetInteger: Integer;
begin
 Result := ut_QFLikeTextLoad;
end;//Tkw_FormUserType_ut_QFLikeTextLoad.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_QFLikeTextLoad.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_QFLikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
