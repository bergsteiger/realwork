unit PrimChild_cutUsual_UserType;

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\PrimChild_cutUsual_UserType.pas"
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
 {* ��������� ��� ���� ����� cutUsual }
 cutUsualName = 'cutUsual';
  {* ��������� ������������� ����������������� ���� "" }
 cutUsual = TvcmUserType(0);

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutUsual = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cutUsual }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_cutUsual
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_cutUsual.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cutUsual';
end;//Tkw_FormUserType_cutUsual.GetWordNameForRegister

function Tkw_FormUserType_cutUsual.GetInteger: Integer;
begin
 Result := cutUsual;
end;//Tkw_FormUserType_cutUsual.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutUsual.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cutUsual }
{$IfEnd} // NOT Defined(NoScripts)

end.
