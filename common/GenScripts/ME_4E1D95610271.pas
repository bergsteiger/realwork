unit nevActiveHyperlinkProxy;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevTools
 , l3Interfaces
;

type
 TnevActiveHyperlinkProxy = class(Tl3CProtoObject, InevActiveElement)
  procedure Create(const anActive: InevActiveElement);
  function Make(const anActive: InevActiveElement): InevActiveElement;
  function DoIsSame(const anElement: InevActiveElement): Boolean;
  procedure DoInvalidate;
  function IsSame(const anElement: InevActiveElement): Boolean;
  function Para: InevPara;
  procedure Invalidate;
   {* Перерисовывает область активного элемента }
 end;//TnevActiveHyperlinkProxy
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
;

end.
