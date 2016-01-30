unit PrimQueryCard_utqcPostingOrder_UserType;
 {* �������� �������������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcPostingOrder_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcAttributeSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utqcPostingOrder }
 utqcPostingOrderName = 'utqcPostingOrder';
  {* ��������� ������������� ����������������� ���� "�������� �������������� �����" }
 utqcPostingOrder = TvcmUserType(utqcAttributeSearch + 1);
  {* �������� �������������� ����� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcPostingOrder = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcPostingOrder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utqcPostingOrder
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcPostingOrder';
end;//Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcPostingOrder.GetInteger: Integer;
begin
 Result := utqcPostingOrder;
end;//Tkw_FormUserType_utqcPostingOrder.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcPostingOrder.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcPostingOrder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
