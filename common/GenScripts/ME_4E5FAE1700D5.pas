unit nevSegmentObject;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevBase
 , l3Variant
;

type
 TnevSegmentObject = class(Tk2TagTool, InevObjectPrim)
  procedure Create(aTag: Tl3Variant);
  function Make(aTag: Tl3Variant): InevObjectPrim;
  function Text: TnevStr;
  function TabStops: InevTabStops;
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  function OffsetX: Integer;
   {* Возвращает смещение дочернего объекта относительно родителя. }
  function IsList: Boolean;
  function PID: TnevParaIndex;
   {* индекс параграфа в родителе. }
  function IsVertical: Boolean;
  function OverlapType: TOverlapType;
   {* Перекрывающий объект }
  function NeedIncludeHeight(aCheckType: Boolean): Boolean;
   {* Нужно ли учитывать высоту объекта при подсчете высоты родительского. }
  function IsLegalComment: Boolean;
   {* Юридический комментарий? }
  function IsDecorationElement: Boolean;
  function DecorObj(aType: TnevDecorType): Tl3Variant;
  function HolderPrim: InevObjectHolderPrim;
  function TreatCollapsedAsHidden: Boolean;
 end;//TnevSegmentObject
 
implementation

uses
 l3ImplUses
 , l3String
 , TextSegment_Const
;

end.
