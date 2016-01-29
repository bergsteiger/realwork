unit evSelection;

interface

uses
 l3IntfUses
 , nevRangePrim
 , nevTools
 , evdInterfaces
 , k2Interfaces
 , nevBase
 , l3Interfaces
 , l3Types
 , evTypes
 , l3Variant
 , l3Core
 , k2ToolPrim
;

type
 TevRange = class(TnevRangePrim, InevRange, InevStorable, IevdDataObject, InevDataObjectPrim2, InevRangeModify, InevRangeFactory, IevRange)
  procedure DoInit(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean);
  procedure DoStore(const aView: InevView;
   const G: Ik2TagGenerator;
   aFlags: TevStoreFlags);
  function DoDelete(const aView: InevView;
   const anOpPack: InevOp;
   aMode: TevClearMode;
   const aPara: InevPara): Boolean;
  function DoGetChildSel(const aView: InevView;
   aChildIndex: LongInt;
   aForDrawing: Boolean): InevRange;
  procedure DoRefreshBorders;
  procedure DeleteBeforeInsert(const aView: InevView;
   const anOp: InevOp);
  function SearchPrim(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ���� ��������� � ���������� ��������� ������� � (cFStart, cFFinish) }
  function IsSolid(const aView: InevView): Boolean;
  function IsCollapsed(const aView: InevView): Boolean;
  function GetContainsEnd(const aView: InevView): Boolean;
  function TagReader: InevTagReader;
  function DoBottomChildBlock(const aView: InevView): InevRange;
  function DoGetBorders: TevPair;
  procedure DoGetBorderPoints(out theStart: InevBasePoint;
   out theFinish: InevBasePoint);
  procedure DoIterate(anAction: InevRangePrim_Iterate_Action;
   const Progress: Il3Progress;
   const aMessage: Il3CString;
   aStart: LongInt);
   {* ���������� �������, �������� � ��������� � �������� anAction ��� ������� }
  procedure DoIterateBack(anAction: InevRangePrim_Iterate_Action;
   const Progress: Il3Progress;
   const aMessage: Il3CString);
   {* ���������� �������, �������� � ��������� � �������� anAction ��� ������� }
  procedure DoIterateF(anAction: InevRangePrim_Iterate_Action;
   const Progress: Il3Progress;
   const aMessage: Il3CString;
   aStart: LongInt);
   {* ���������� �������, �������� � ��������� � �������� anAction ��� ������� }
  procedure DoIterateBackF(anAction: InevRangePrim_Iterate_Action;
   const Progress: Il3Progress;
   const aMessage: Il3CString);
   {* ���������� �������, �������� � ��������� � �������� anAction ��� ������� }
  function DoSearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const Cursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* ��������� ��������� � G. }
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags): Boolean; overload;
   {* ��������� ��������� � ������� aFormat � Pool, ������� ������ ������������� IStream. }
  function SolidBottomChildBlock(const aView: InevView): InevRange;
  function GetChildSel(const aView: InevView;
   aChildIndex: Integer;
   aForDrawing: Boolean): InevRange;
  procedure GetBorderPoints(out BS: InevBasePoint;
   out BF: InevBasePoint);
  function BottomChildBlock(const aView: InevView): InevRange;
  function CloneSel(const aView: InevView): InevRange;
  function Delete(const aView: InevView;
   const anOp: InevOp;
   aMode: TevClearMode;
   const aPara: InevPara): Boolean;
  function Modify: InevRangeModify;
  function ParentRange(aLevel: Integer): InevRange;
  function Contains(const aView: InevView;
   const aPoint: InevBasePoint): Boolean;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aTarget: TevSelectTarget;
   const Ctx: InevOp); overload;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aOpen: Integer;
   aClose: Integer;
   const Ctx: InevOp); overload;
  function Borders: TevPair;
  function Data: IevdDataObject;
  procedure Init(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean);
  function Solid(const aView: InevView): Boolean;
  function ContainsEnd(const aView: InevView): Boolean;
  function Collapsed(const aView: InevView): Boolean;
  procedure AssignSel(const aView: InevView;
   const aSource: InevRange);
   {* ����������� ���� ��������� ������� }
  function GetBlock: InevRange;
   {* �������� ������� ������ ��������� }
  procedure SetToStart;
   {* ���������� ��������� � ������ }
  function Unselect(const aView: InevView): Boolean;
   {* ����� ��������� }
  function AsStorable: InevDataObjectPrim2;
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
   {* ������� ������/������. ���������� - ���� �� ������ ������. }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ���� � ��������� �������� �nSearch
             � ���������� ������ � ����� ���������� ��������� � (cFStart, cFFinish). }
  procedure SetToFinish(aMoveUpInLines: Integer);
  procedure RefreshBorders;
   {* ��������� ������� �����. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
 end;//TevRange
 
implementation

uses
 l3ImplUses
 , Classes
 , ParaList_Const
 , l3Stream
 , SysUtils
 , l3String
 , l3Base
 , nevInterfaces
 , nevFacade
 , Para_Const
 , evSelectConst
 , k2Tags
 , k2Base
;

end.
