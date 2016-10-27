unit PrimQueryCard_utqcPostingOrder_UserType;
 {* �������� �������������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcPostingOrder_UserType.pas"
// ���������: "UserType"
// ������� ������: "utqcPostingOrder" MUID: (4BD5C3510339)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcAttributeSearch_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ utqcPostingOrderLocalConstants }
 str_utqcPostingOrderCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utqcPostingOrderCaption'; rValue : '�������� �������������� �����');
  {* ��������� ����������������� ���� "�������� �������������� �����" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utqcPostingOrder = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcPostingOrder }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcPostingOrder
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcPostingOrder.GetInteger: Integer;
begin
 Result := utqcPostingOrder;
end;//Tkw_FormUserType_utqcPostingOrder.GetInteger

class function Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcPostingOrder';
end;//Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utqcPostingOrderCaption.Init;
 {* ������������� str_utqcPostingOrderCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcPostingOrder.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcPostingOrder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
