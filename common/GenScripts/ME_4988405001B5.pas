unit evSubWaiter;

interface

uses
 l3IntfUses
 , l3Tool
 , nevTools
;

type
 TevSubWaiter = class(Tl3Tool)
  function TrySelectPara(const aContainer: InevDocumentContainer;
   const aSel: InevSelection;
   aParaID: Integer): Boolean;
 end;//TevSubWaiter
 
implementation

uses
 l3ImplUses
;

end.
