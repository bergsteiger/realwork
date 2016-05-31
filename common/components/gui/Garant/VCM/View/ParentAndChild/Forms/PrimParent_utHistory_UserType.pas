unit PrimParent_utHistory_UserType;
 {* ������� ��������� }

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_utHistory_UserType.pas"
// ���������: "UserType"
// ������� ������: "utHistory" MUID: (4F72C32000CF)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utHistoryLocalConstants }
 str_utHistoryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utHistoryCaption'; rValue : '������� ���������');
  {* ��������� ����������������� ���� "������� ���������" }
 {* ��������� ��� ���� ����� utHistory }
 utHistoryName = 'utHistory';
  {* ��������� ������������� ����������������� ���� "������� ���������" }
 utHistory = TvcmUserType(0);
  {* ������� ��������� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utHistory = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utHistory }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utHistory
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utHistory.GetInteger: Integer;
begin
 Result := utHistory;
end;//Tkw_FormUserType_utHistory.GetInteger

class function Tkw_FormUserType_utHistory.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utHistory';
end;//Tkw_FormUserType_utHistory.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utHistoryCaption.Init;
 {* ������������� str_utHistoryCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utHistory.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utHistory }
{$IfEnd} // NOT Defined(NoScripts)

end.
