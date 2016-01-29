unit eeTagEditorTool;

interface

uses
 l3IntfUses
 , k2ProcessorTagTool
 , eeInterfacesEx
 , l3Variant
 , nevTools
 , k2Interfaces
;

type
 TeeTagEditorTool = class(Tk2ProcessorTagTool, IeeTool)
  procedure Create(aTagWrap: Tl3Variant;
   const aDocument: IeeDocumentEx;
   const aProcessor: InevProcessor);
  procedure OwnerDead;
   {* Нотификация о смерти родителя. }
 end;//TeeTagEditorTool
 
implementation

uses
 l3ImplUses
;

end.
