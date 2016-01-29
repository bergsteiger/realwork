unit evStyleTableSpy;

interface

uses
 l3IntfUses
 , afwInterfaces
 , l3InterfacePtrList
;

type
 TevSpies = class(Tl3InterfacePtrList)
  function Exists: Boolean;
 end;//TevSpies
 
implementation

uses
 l3ImplUses
 , evStyleInterface
 , k2Facade
 , l3Base
 , l3Types
 , SysUtils
 , evResultFont
 , k2Tags
;

end.
