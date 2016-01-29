unit Concret;

interface

uses
 l3IntfUses
 , Pure
;

type
 Concret = interface
  function compare(const x: _T_;
   const y: _T_): Integer;
 end;//Concret
 
implementation

uses
 l3ImplUses
;

end.
