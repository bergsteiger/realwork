unit PrimeDomainInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimeDomainInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "PrimeDomainInterfaces" MUID: (4ADF3FBB00C3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimeUnit
;

type
 InsPrimeNode = interface
  {* ���� ������ ��������� ���� }
  ['{E5BF71FF-A857-40FD-A325-7B8F18DEEA50}']
  function pm_GetData: IPrime;
  property Data: IPrime
   read pm_GetData;
 end;//InsPrimeNode
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
