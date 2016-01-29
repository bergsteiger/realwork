unit evCustomParaListUtils;

interface

uses
 l3IntfUses
 , nevBase
 , nevTools
 , k2ProcessorTagTool
 , l3Variant
 , evEditorInterfaces
;

type
 TevLocationProcessorTagTool = class(Tk2ProcessorTagTool)
  {* Базовый класс для инструментов для тегов, с использованием _TevLocation. }
  procedure Create(const aView: InevView;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aLocation: InevLocation);
 end;//TevLocationProcessorTagTool
 
 TevTableChild = class(TevLocationProcessorTagTool)
  procedure Create(const aView: InevView;
   const aTable: IedTable;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aLocation: InevLocation);
  function GetTable: IedTable;
 end;//TevTableChild
 
 TevRowChild = class(TevLocationProcessorTagTool)
  function GetRow: IedRow;
  procedure Create(const aView: InevView;
   const aRow: IedRow;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aLocation: InevLocation);
 end;//TevRowChild
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , k2Base
 , k2Tags
 , evdStyles
;

end.
