unit PrimBaseSearchInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\PrimBaseSearchInterfaces.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
;

type
 InsBaseSearchResultProcessor = interface
  ['{C3264FA1-C168-4D5E-94B7-3D7DE897A780}']
  procedure SearchResultEmpty(TryFullList: Boolean);
  procedure SearchResultExists;
  procedure AnotherSearchSuccessed;
  procedure AnotherSearchCancelled;
 end;//InsBaseSearchResultProcessor
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
