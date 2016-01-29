unit nevObjectHolderPrim;

interface

uses
 l3IntfUses
 , nevDocumentContainerPrim
 , nevTools
 , nevFormatPool
 , nevSectionBreakList
 , l3Interfaces
 , nevBase
 , l3Variant
 , k2Base
;

type
 TnevObjectHolderPrim = class(_l3Notifier_, InevObjectHolder)
  function DoGetControlImg(const aControl: TnevControlInfo;
   var theImageInfo: TnevControlImageInfo): Boolean;
  function GetObj: InevObject;
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function GetTagReader: InevTagReader;
  function GetTagWriter: InevTagWriter;
  function DoFindObjByID(aParaID: Integer;
   out aPara: InevObject): Boolean;
  function GetViewArea: InevViewArea;
  procedure DoChildAdded(aList: Tl3Variant;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure DoChildDeleted(aList: Tl3Variant;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure UnformatAll;
  function GetLock: Il3Lock;
  procedure DoUpdatePreview;
  procedure DoPropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
  function GetSubCache: IevSubCache;
  function TagReader: InevTagReader;
  function TagWriter: InevTagWriter;
  function FindObjByID(aParaID: Integer;
   out aPara: InevObject): Boolean;
  function Obj: InevObject;
  function Modified: Boolean;
  function FormatPool: InevFormatPool;
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function ViewArea: InevViewArea;
  procedure ChildAdded(aList: Tl3Variant;
   aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure ChildDeleted(aList: Tl3Variant;
   aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure UpdatePreview;
  procedure PropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
  function SubCache: IevSubCache;
  function SectionBreaks: InevSectionBreaks;
  function Lock: Il3Lock;
  procedure DoStyleTableChanged;
  procedure SectionBreakAdded(const anObject: InevObject);
   {* Добавился разрыв раздела }
  function GetControlImg(const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo): Boolean;
 end;//TnevObjectHolderPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , Para_Const
 , ObjectSegment_Const
 , SectionBreak_Const
 , l3Base
 , evStyleTableSpy
;

end.
