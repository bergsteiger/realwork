unit k2InterfaceFactory;

interface

uses
 l3IntfUses
 , l3SimpleObject
 , k2Interfaces
 , k2InterfaceCache
 , l3Variant
 , l3Interfaces
 , l3Types
 , l3IID
 , k2ToolPrim
;

type
 Rk2InterfaceFactory = class of Tk2InterfaceFactory;
 
 Tk2InterfaceFactory = class(Tl3SimpleObject)
  {* Фабрика "старых" интерфейсов. Для поддержки старого кода, без настоящих интерфейсов. }
  function QueryTool(aTag: Tl3Variant;
   const ID: Tl3IID;
   out I: Tk2ToolPrim): Boolean;
  function LoadTool(const ID: Tl3IID): Tk2ToolPrim;
   {* загрузить инструмент }
  function StoreTool(const ID: Tl3IID;
   I: Tk2ToolPrim): Boolean;
   {* сохранить инструмент }
  function COMQueryTool(aTag: Tl3Tag;
   const aIID: Tl3GUID;
   out theTool;
   const aProcessor: Ik2Processor): Boolean;
  function PreCOMQueryTool(aTag: Tl3Tag;
   const aIID: Tl3GUID;
   out theTool;
   const aProcessor: Ik2Processor): Boolean;
  function QueryToolN(aTag: Tl3Variant;
   const IID: TGUID;
   out Tool;
   const aProcessor: Ik2Processor): Boolean;
  procedure Iterate(Tag: Tl3Variant;
   Action: Tl3IteratorAction);
  procedure IterateCursors;
 end;//Tk2InterfaceFactory
 
implementation

uses
 l3ImplUses
 , k2Base
 , k2TagPointer
;

end.
