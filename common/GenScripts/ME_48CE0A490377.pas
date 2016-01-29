unit nevParaPrim;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevTools
 , nevBase
 , l3Variant
;

type
 TnevParaPrim = class(Tk2TagTool, InevPara, InevObject, InevObjectModify)
  {* Пустой параграф }
  function TreatCollapsedAsHidden: Boolean; overload;
  function GetText: TnevStr;
  function DoGetBackColor: TnevColor;
  function GetNeedIncludeHeight(aCheckType: Boolean): Boolean;
  function GetOffsetX: Integer;
  function GetOverlapType: TOverlapType;
  function GetOwnerPara: InevParaList;
  function GetIsList: Boolean;
  function GetToList: InevObjectList;
  function GetAsList: InevParaList;
  function GetIsVertical: Boolean;
  function GetIsEmpty: Boolean;
  function GetAppliesToMaxWidth: Boolean;
  function GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  function GetDocumentContainer: InevDocumentContainer;
  function GetPID: TnevParaIndex;
  function GetPrev: InevPara;
  function GetNext: InevPara;
  function GetOwnerTag: Tl3Variant;
  function DoDelete(anInMerge: Boolean;
   const anOp: InevOp): Boolean;
  function GetAnchorID: Integer;
  function GetHolder: InevObjectHolder;
  procedure Create(aTag: Tl3Variant);
  function Range(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean): InevRange;
   {* выделение на данном объекте. }
  function SubRange(const aView: InevView;
   aStart: Integer;
   aFinish: Integer): InevRange;
   {* возвращает выделение на данном объекте от aStart до aFinish. }
  function MakePoint(const aParent: InevBasePoint): InevPoint;
   {* точка в объекте. }
  function CloneObj: InevObject;
  function OwnerObj: InevObjectList;
   {* родительский объект данного объекта. }
  function IsPara: Boolean;
  function AsPara: InevPara;
   {* преобразует объект к параграфу, если это возможно, иначе - исключение. }
  function ToList: InevObjectList;
  function MakeAnchor: InevAnchor;
  function Delete(anInMerge: Boolean;
   const anOp: InevOp): Boolean;
   {* удаляет параграф aPara. }
  function Edit: InevObjectModify;
  function Holder: InevObjectHolder;
  function IsEmpty: Boolean;
  function AnchorID: Integer;
  function OwnerTag: Tl3Variant;
   {* родительский тег данного параграфа. }
  function OwnerPara: InevParaList;
   {* родительский параграф данного параграфа. }
  function AsList: InevParaList;
  function IsComment: Boolean;
  function DocumentContainer: InevDocumentContainer;
  function Prev: InevPara;
   {* предыдущий параграф. }
  function Next: InevPara;
   {* следующий параграф. }
  function MainSubList: InevSubList;
  function Text: TnevStr;
  function TabStops: InevTabStops;
  function BackColor: TnevColor;
  function AppliesToMaxWidth: Boolean;
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  function OffsetX: Integer;
   {* Возвращает смещение дочернего объекта относительно родителя. }
  procedure Invalidate(aParts: TnevShapeParts);
   {* Сообщает о необходимости перерисовать форму, если она отображается в каком-нибудь View. }
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
  function IsCollapsed(const aView: InevView): Boolean;
  function BaseLine4Anchor: InevBaseLine4Anchor;
  function BaseLine4Print: InevBaseLine4Print;
  function IsDecorationElement: Boolean;
  function DecorObj(aType: TnevDecorType): Tl3Variant;
  function HolderPrim: InevObjectHolderPrim;
  function TreatCollapsedAsHidden: Boolean; overload;
 end;//TnevParaPrim
 
implementation

uses
 l3ImplUses
 , nevFacade
 , k2Base
 , k2Tags
 , evdStyles
 , k2Const
 , evdTextStyle_Const
 , l3String
 , evTabStops
 , k2NullTagImpl
;

end.
