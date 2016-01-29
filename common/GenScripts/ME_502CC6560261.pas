unit evCell;

interface

uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , evdTypes
 , l3Interfaces
;

type
 TevCell = class(TevTableChild, IedCell)
  {* ���������� ���������� IedCell ��� ������� ������ �������. }
  procedure Create(const aView: InevView;
   const aTable: IedTable;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aNeighbours: TevCellNeighbours;
   const aLocation: InevLocation);
  function Make(const aView: InevView;
   const aTable: IedTable;
   aTagWrap: Tl3Variant;
   const aProcessor: InevProcessor;
   const aNeighbours: TevCellNeighbours;
   const aLocation: InevLocation): IedCell;
  function Frame: IedFrame;
   {* ����� ������ ������� }
  procedure UpdateWidthAndCheckHead(aNewWidth: Integer);
   {* �������� ������ ������, � ��� ����� � ������������ }
  function Merge(aNeighbour: TedNeighbourIndex): Boolean;
   {* ���������� ������ � ������� }
  function Split(aColNum: Integer;
   aRowNum: Integer): Boolean; overload;
   {* ��������� ������ }
  function Split(anOrientation: Tl3Orientation1): Boolean; overload;
   {* ��������� ������ }
  function IsFirst: Boolean;
   {* ���������� - ������ �� ��� ������ }
  function IsLast: Boolean;
   {* ���������� - ��������� �� ��� ������ }
  function IsBottom: Boolean;
   {* ���������� - ����� �� ������ ������ }
  function Delete(const anOp: InevOp;
   anInMerge: Boolean): Boolean;
   {* ������� ������ }
  function Table: IedTable;
   {* ������� � ������� ����������� ������ }
  function Neighbour: IedCell;
   {* ������ ������ }
  function Width: Integer;
   {* ������ ������ }
  function VerticalAligment: TevVerticalAligment;
   {* ������������ ����������� ������ �� ��������� }
  function MergeStatus: TevMergeStatus;
  function TextAsInteger: Integer;
   {* �������� ������������� ����� � ������ � ������ �����. }
  function GetFirstLineText: AnsiString;
   {* ���������� ������ ������ ������. ������������ ��� ������. }
  function IsEmptyCell: Boolean;
  function IsFrameEmpty: Boolean;
  function GetCellType: TedCellType;
   {* ���������� ��� ����������� ������. }
  procedure MakeCellContinue(const anOp: InevOp);
   {* ��������� ��� ������ (ev_msContinue) � �������� � ����������. }
  function CalcHeadCellHeghtInRow: Integer;
   {* ��������� ������� �������� ����� ����������� ������. }
  procedure UpdateWidth(aNewWidth: Integer);
 end;//TevCell
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , evParaFrame
 , k2Tags
 , k2Base
 , evParaTools
 , evMsgCode
 , l3IID
 , k2OpMisc
 , TextPara_Const
 , evCursorTools
 , l3UnitsTools
 , l3String
 , l3Chars
;

end.
