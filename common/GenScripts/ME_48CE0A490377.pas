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
  {* ������ �������� }
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
   {* ��������� �� ������ �������. }
  function SubRange(const aView: InevView;
   aStart: Integer;
   aFinish: Integer): InevRange;
   {* ���������� ��������� �� ������ ������� �� aStart �� aFinish. }
  function MakePoint(const aParent: InevBasePoint): InevPoint;
   {* ����� � �������. }
  function CloneObj: InevObject;
  function OwnerObj: InevObjectList;
   {* ������������ ������ ������� �������. }
  function IsPara: Boolean;
  function AsPara: InevPara;
   {* ����������� ������ � ���������, ���� ��� ��������, ����� - ����������. }
  function ToList: InevObjectList;
  function MakeAnchor: InevAnchor;
  function Delete(anInMerge: Boolean;
   const anOp: InevOp): Boolean;
   {* ������� �������� aPara. }
  function Edit: InevObjectModify;
  function Holder: InevObjectHolder;
  function IsEmpty: Boolean;
  function AnchorID: Integer;
  function OwnerTag: Tl3Variant;
   {* ������������ ��� ������� ���������. }
  function OwnerPara: InevParaList;
   {* ������������ �������� ������� ���������. }
  function AsList: InevParaList;
  function IsComment: Boolean;
  function DocumentContainer: InevDocumentContainer;
  function Prev: InevPara;
   {* ���������� ��������. }
  function Next: InevPara;
   {* ��������� ��������. }
  function MainSubList: InevSubList;
  function Text: TnevStr;
  function TabStops: InevTabStops;
  function BackColor: TnevColor;
  function AppliesToMaxWidth: Boolean;
  function IsHiddenPrim(aMap: TnevFormatInfoPrim;
   aHiddenStyles: TnevStandardStyles): Boolean;
  function OffsetX: Integer;
   {* ���������� �������� ��������� ������� ������������ ��������. }
  procedure Invalidate(aParts: TnevShapeParts);
   {* �������� � ������������� ������������ �����, ���� ��� ������������ � �����-������ View. }
  function IsList: Boolean;
  function PID: TnevParaIndex;
   {* ������ ��������� � ��������. }
  function IsVertical: Boolean;
  function OverlapType: TOverlapType;
   {* ������������� ������ }
  function NeedIncludeHeight(aCheckType: Boolean): Boolean;
   {* ����� �� ��������� ������ ������� ��� �������� ������ �������������. }
  function IsLegalComment: Boolean;
   {* ����������� �����������? }
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
