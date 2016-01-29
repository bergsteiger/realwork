unit nevDecorActiveHyperlink;

interface

uses
 l3IntfUses
 , nevActiveHyperlinkProxy
 , nevBase
 , nevTools
;

type
 InevDecorActiveHyperlink = interface
 end;//InevDecorActiveHyperlink
 
 RnevDecorActiveHyperlinkClass = class of TnevDecorActiveHyperlink;
 
 TnevDecorActiveHyperlink = class(TnevActiveHyperlinkProxy, InevDecorActiveHyperlink)
  procedure Create(const aPara: InevObjectPrim;
   const anActive: InevActiveElement);
  function Make(const aPara: InevObjectPrim;
   const anActive: InevActiveElement): InevActiveElement;
  function Obj: InevObjectPrim;
 end;//TnevDecorActiveHyperlink
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
