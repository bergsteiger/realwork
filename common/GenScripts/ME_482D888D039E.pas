unit evCustomMemoContainer;

interface

uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , Classes
 , nevTools
 , k2DocumentGenerator
 , k2Base
 , evOpProc
 , nevBase
 , k2TagGen
;

type
 TevCustomMemoContainer = class(TnevPrintableDocumentContainer)
  procedure UpdateParaParam(const Atom: Tk2StackAtom);
  procedure Create;
  function Make: InevDocumentContainer;
 end;//TevCustomMemoContainer
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evTagsListFilter
 , evCustomMemo
 , k2Facade
 , evdTypes
 , evMemoProcessor
 , TextPara_Const
 , SimpleDocument_Const
 , l3Types
 , l3Base
 , evDef
 , Font_Const
;

end.
