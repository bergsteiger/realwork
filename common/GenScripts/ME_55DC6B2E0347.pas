unit ddNSRCSegments;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3CustomString
 , k2Interfaces
 , segTargetList
;

type
 TsegSegment = class(Tl3ProtoObject)
 end;//TsegSegment
 
 TsegTextSegment = class(TsegSegment)
 end;//TsegTextSegment
 
 TsegDecorSegment = class(TsegTextSegment)
 end;//TsegDecorSegment
 
 TddNSRCStackItem = class(Tl3ProtoObject)
  procedure Create(aDecor: TsegDecorSegment);
  function IsOn(Ch: AnsiChar): Boolean;
 end;//TddNSRCStackItem
 
 TsegSeg = class(TsegDecorSegment)
  procedure Create(aDecor: TsegDecorSegment;
   anItem: TddNSRCStackItem;
   aFinish: Integer);
  procedure GetFromStackItem(StackItem: TddNSRCStackItem);
  procedure SaveToGenerator(aText: Tl3CustomString;
   const aGenerator: Ik2TagGenerator);
 end;//TsegSeg
 
 TsegHyperLink = class(TsegTextSegment)
  procedure Create;
  procedure Add(aDocID: Integer;
   aSubID: Integer);
 end;//TsegHyperLink
 
 TsegObject = class(TsegSegment)
 end;//TsegObject
 
 TsegPicture = class(TsegObject)
 end;//TsegPicture
 
 TsegFormula = class(TsegObject)
 end;//TsegFormula
 
implementation

uses
 l3ImplUses
 , ddSegmentScanner
 , evNSRCConst
 , k2Tags
 , TextSegment_Const
 , evdStyles
 , Math
 , SysUtils
 , segTarget
;

end.
