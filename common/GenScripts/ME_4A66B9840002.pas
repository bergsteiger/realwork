unit ChatTypes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\ChatTypes.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTypesUnit
;

type
 TnsContactType = (
  {* ��� ���������� �������� }
  ctActive
   {* ��������� }
  , ctInactive
   {* ��������� }
 );//TnsContactType

 TContactListFilterTypes = (
  {* ��� ������� ������ ��������� }
  clftNone
   {* ��� �������� }
  , clftActive
   {* ������ ������������ }
 );//TContactListFilterTypes

 TbsUserID = TUid;
  {* ID ������������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
