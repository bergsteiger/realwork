unit PrimeDomainInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimeDomainInterfaces.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimeUnit
;

type
 InsPrimeNode = interface
  {* Узел дерева новостных лент }
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
