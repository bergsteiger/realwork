unit PrimSaveLoadUserTypes_slqtPostingOrder_UserType;
 {* ��������� �������������� ����� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPostingOrder_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtPostingOrder" MUID: (4BD5BC59017D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtLegislationReview_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� slqtPostingOrder }
 slqtPostingOrderName = 'slqtPostingOrder';
  {* ��������� ������������� ����������������� ���� "��������� �������������� ����� ��������" }
 slqtPostingOrder = TvcmUserType(slqtLegislationReview + 1);
  {* ��������� �������������� ����� �������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtPostingOrder = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtPostingOrder }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtPostingOrder
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtPostingOrder.GetInteger: Integer;
begin
 Result := slqtPostingOrder;
end;//Tkw_FormUserType_slqtPostingOrder.GetInteger

class function Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtPostingOrder';
end;//Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPostingOrder.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtPostingOrder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
