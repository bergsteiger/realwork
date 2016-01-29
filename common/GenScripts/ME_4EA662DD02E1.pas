unit dd_lcBaseFilter;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2TagFilter
 , ddHeaderFilter
;

type
 Tdd_lcParaFilter = class(TevdLeafParaFilter)
 end;//Tdd_lcParaFilter
 
 Tdd_lcBaseFilter = class(Tk2TagFilter)
 end;//Tdd_lcBaseFilter
 
 Tdd_lcSynoFilter = class(Tdd_lcBaseFilter)
 end;//Tdd_lcSynoFilter
 
 Tdd_lcBaseHeaderFilter = class(TddHeaderFilter)
 end;//Tdd_lcBaseHeaderFilter
 
implementation

uses
 l3ImplUses
;

end.
