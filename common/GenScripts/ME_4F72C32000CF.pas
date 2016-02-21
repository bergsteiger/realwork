unit PrimParent_utHistory_UserType;
 {* ������� ��������� }

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimParent_utHistory_UserType.pas"
// ���������: "UserType"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utHistory = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utHistory }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utHistory
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utHistory.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utHistory';
end;//Tkw_FormUserType_utHistory.GetWordNameForRegister

function Tkw_FormUserType_utHistory.GetInteger: Integer;
begin
 Result := utHistory;
end;//Tkw_FormUserType_utHistory.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utHistory.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utHistory }
{$IfEnd} // NOT Defined(NoScripts)

end.
