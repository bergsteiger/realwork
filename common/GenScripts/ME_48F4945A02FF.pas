unit evStringStorable;

interface

uses
 l3IntfUses
 , evStorable
 , l3Interfaces
 , afwNavigation
 , nevBase
 , evdInterfaces
;

type
 TevStringStorable = class(TevStorable)
  {* Объекты реализующие возможность укладки в клипборд константной строки ([CQ 25894|$96482711]) }
  procedure GetAddress(var Addr: TevAddress);
  function Text: Tl3WString;
  function Address: TevAddress;
  procedure DoStore(const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
 end;//TevStringStorable
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , l3Base
 , Document_Const
 , TextPara_Const
 , HyperLink_Const
 , Address_Const
;

end.
