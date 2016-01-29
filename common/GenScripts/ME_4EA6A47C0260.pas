unit evSearchWaiter;

interface

uses
 l3IntfUses
 , l3Tool
 , nevTools
 , l3Variant
;

type
 TevSearchWaiter = class(Tl3Tool, InevWaiter)
  procedure Create(const aControl: InevControl;
   const aSearcher: IevSearcher);
  function Make(const aControl: InevControl;
   const aSearcher: IevSearcher): InevWaiter;
  function TrySelect(const aContainer: InevDocumentContainer): Boolean;
  function TrySelectObj(const aContainer: InevDocumentContainer;
   aParent: Tl3Variant;
   aChild: Tl3Variant): Boolean;
 end;//TevSearchWaiter
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3Base
 , SysUtils
 , LeafPara_Const
 , evdInterfaces
 , evParaTools
 , k2Tags
;

end.
