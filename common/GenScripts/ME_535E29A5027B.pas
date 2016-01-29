unit evdParaStylePainter;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2TagGen
 , l3Variant
;

type
 TevdParaStylePainter = class(TevdLeafParaFilter)
  function SetTo(var theGenerator: Tk2TagGenerator;
   aTargetStyle: Integer): Pointer;
 end;//TevdParaStylePainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , k2OperationContainer
 , SysUtils
;

end.
