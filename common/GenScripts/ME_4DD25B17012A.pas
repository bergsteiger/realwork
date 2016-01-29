unit nevDocumentContainerList;

interface

uses
 l3IntfUses
 , nevDocumentContainerListPrim
 , k2Interfaces
 , k2Prim
;

type
 TnevDocumentContainerList = class(TnevDocumentContainerListPrim, Ik2Listener)
  function Exists: Boolean;
  procedure Fire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
   {* сообщение о том, что что-то произошло. }
 end;//TnevDocumentContainerList
 
implementation

uses
 l3ImplUses
 , k2Facade
 , afwFacade
;

end.
