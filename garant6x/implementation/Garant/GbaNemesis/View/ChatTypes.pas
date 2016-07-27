unit ChatTypes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChatTypes.pas"
// ���������: "Interfaces"
// ������� ������: "ChatTypes" MUID: (4A66B9840002)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTypesUnit
 , SecurityUnit
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
