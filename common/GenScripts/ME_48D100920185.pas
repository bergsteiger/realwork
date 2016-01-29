unit nevTextPara;

interface

uses
 l3IntfUses
 , nevLeafPara
 , nevTools
 , l3Variant
 , nevBase
 , l3CacheableBase
 , l3Interfaces
;

type
 TnevTextPara = class(TnevLeafPara, InevTextPara)
  {* Реализация инструмента InevTextPara }
  function SegmentIsHidden(aSegment: Tl3Variant;
   aHiddenStyles: TnevStandardStyles): Boolean;
  function Make(aTag: Tl3Variant): InevTextPara;
  function Formatting: InevDataFormatting;
 end;//TnevTextPara
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , evTabStops
 , l3String
 , k2Base
 , nevFontPrim
 , l3Types
 , nevSegmentObject
 , evSegLst
;

type
 TnevTextParaFormatting = class(Tl3CacheableBase, InevDataFormatting)
  procedure Create(const aPara: InevTextPara;
   aPosition: Integer);
  procedure Make(const aPara: InevTextPara;
   aPosition: Integer);
  function GetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger): InevFontPrim;
  function GetStyle(Stop: PInteger): Tl3Variant;
  function Modify(const aView: InevView): InevDataFormattingModify;
 end;//TnevTextParaFormatting
 
end.
