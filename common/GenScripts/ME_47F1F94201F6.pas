unit evSearch;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
 , evTypes
 , l3Variant
 , l3CustomString
 , nevBase
;

type
 TevSearchTool = class(Tl3ProtoObject, IevSearchTool)
  procedure Start;
   {* начало поиска. }
  procedure Finish(aCancel: Boolean;
   const aBlock: InevRange);
   {* конец поиска. }
  function Text: AnsiString;
  function Options: TevSearchOptionSet;
 end;//TevSearchTool
 
 TevBaseSearcher = class(TevSearchTool, IevSearcher)
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
  function Check(const aView: InevView;
   const aBlock: InevRange;
   out theStart: InevBasePoint;
   out theFinish: InevBasePoint;
   const PrevBlock: InevRange): Boolean;
   {* определяет критерий отбора параграфа (его фрагмента). }
 end;//TevBaseSearcher
 
 TevParaByIDSearcher = class(TevBaseSearcher)
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
 end;//TevParaByIDSearcher
 
 TevStyleSearcher = class(TevBaseSearcher)
  function IsStyleFound(aStyle: Tl3Tag): Boolean;
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
 end;//TevStyleSearcher
 
 TevORSearcher = class(TevBaseSearcher)
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
 end;//TevORSearcher
 
 TevStylesSearcher = class(TevORSearcher)
 end;//TevStylesSearcher
 
 TevRegExpMultipartSearcher = class
 end;//TevRegExpMultipartSearcher
 
 TevTextReplacer = class
 end;//TevTextReplacer
 
 TevMorphologySearcher = class
 end;//TevMorphologySearcher
 
 TevTextSearcher = class(TevBaseSearcher)
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
 end;//TevTextSearcher
 
 TevBMTextSearcher = class(TevBaseSearcher)
  {* Класс инструментов для поиска подстроки методом Боера-Мура }
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
 end;//TevBMTextSearcher
 
 TevBaseReplacer = class(TevSearchTool, IevReplacer)
  function ReplaceFunc(const aView: InevView;
   const Container: InevOp;
   const aBlock: InevRange): Boolean;
  function Replace(const Container: InevOp;
   const aBlock: InevRange;
   const aConfirm: InevConfirm): Boolean;
  function NeedProgress: Boolean;
  function Searcher: IevSearcher;
  function ReplaceCount: Integer;
 end;//TevBaseReplacer
 
 TevFakeSearcher = class(TevBaseSearcher)
  function DoCheckText(aPara: Tl3Variant;
   aText: Tl3CustomString;
   const aSel: TevPair;
   out theSel: TevPair): Boolean;
 end;//TevFakeSearcher
 
 TevAnyParagraphSearcher = class(TevFakeSearcher)
  {* Класс для нахождения любого параграфа. }
 end;//TevAnyParagraphSearcher
 
implementation

uses
 l3ImplUses
;

end.
