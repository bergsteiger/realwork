unit ListInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\ListInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TbsLinkType = (
  {* ��� ������ �� ������ ��� ������. �������� ������ ���������� ���� ��� ��� ����������� ����� ������ ���������� ������� }
  ltDocument
   {* ������� ������ �������� }
  , ltList
   {* ������� ������ ������ }
 );//TbsLinkType
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
