unit evCellsOffsetsPair;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evCellsCharOffsets
 , edCellTypesList
 , evEditorInterfaces
;

type
 TedCellPosType = (
  ed_cpNone
  , ed_cpLast
  , ed_cpIgnoreLast
 );//TedCellPosType
 
 TevCellsOffsetsPair = class(Tl3ProtoObject)
  procedure Create;
  procedure Clear;
  procedure AddCellWidthAndRecalc;
  function GetOffset(aNew: Boolean): Integer;
  function GetWidth(aNew: Boolean): Integer;
  function LastNewWidth: Integer;
  function PrevNewWidth: Integer;
  procedure SetWidthPair(aNewWidth: Integer;
   aOldWidth: Integer);
  function CompareWidth(const aOffsetList: TevCellsOffsetsPair;
   var l_Delta: Integer): Integer;
  function FindUpper(const aOffsetList: TevCellsOffsetsPair;
   var l_Delta: Integer): Boolean;
  function FindLower(const aOffsetList: TevCellsOffsetsPair;
   var anIndex: Integer;
   var aDelta: Integer): Boolean;
  procedure UpdateNewWidth(anIndex: Integer;
   aDelta: Integer);
  function GetNextOffset(aNew: Boolean): Integer;
  function EqualCells(const anIterator: IedCellsIterator): Boolean;
  function GetRowWidth(aNew: Boolean): Integer;
  procedure CheckCurrentRow(aList: TevCellsOffsetsPair;
   aNewWidth: Integer;
   anOldCellWidth: Integer;
   aPrevRowWidth: Integer;
   aCelPosl: TedCellPosType;
   out aNeedBreak: Boolean);
  function FindOffset(const aOffsetList: TevCellsOffsetsPair): Boolean;
  procedure AlignByPrevious(const aData: TevCellsOffsetsPair);
  procedure CopyData(aData: TevCellsCharOffsets;
   const anIterator: IedCellsIterator); overload;
  procedure CopyData(const aData: TevCellsOffsetsPair;
   const anIterator: IedCellsIterator); overload;
  procedure CheckPrevAlignment(const aPrev: TevCellsOffsetsPair);
 end;//TevCellsOffsetsPair
 
implementation

uses
 l3ImplUses
 , l3UnitsTools
 , SysUtils
;

end.
