unit evCellsCharOffsets;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evOneCharLongIntList
 , evEditorInterfaces
 , edCellTypesList
;

type
 TevCellsCharOffsets = class(Tl3ProtoObject)
  {* работа со смещени€ми €чеек }
  procedure AddCellWidthAndRecalc;
  procedure Clear;
  function FindOffset(const aOffsetList: TevCellsCharOffsets;
   var anIndex: Integer): Boolean; overload;
  function FindOffset(anOffset: Integer;
   var anIndex: Integer): Boolean; overload;
  function LastWidth: Integer;
  function PrevWidth: Integer;
  function GetNextOffset: Integer;
  procedure SetCurrent(anIndex: Integer);
  function GetOffset: Integer;
  procedure SetWidth(aWidth: Integer);
  function GetWidth: Integer;
  procedure UpdateWidth(anIndex: Integer;
   aDelta: Integer);
  function Equals(const anIterator: IedCellsIterator): Boolean; overload;
  procedure CopyData(const aData: TevCellsCharOffsets;
   const anIterator: IedCellsIterator);
  procedure CheckList;
  function GetRowWidth: Integer;
  procedure AlignByPrevious(const aData: TevCellsCharOffsets);
  function Equals(const anIterator: IedCellsIterator;
   aForTempate: Boolean): Boolean; overload;
  procedure IncUsingCount;
  function GetWidthByIndex(anIndex: Integer): Integer;
  function GetOffsetByIndex(anIndex: Integer): Integer;
  function GetCount: Integer;
  procedure AlignByOffset(anOffset: Integer;
   anIndex: Integer;
   aCellTypeList: TedCellTypesList);
 end;//TevCellsCharOffsets
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3UnitsTools
 , evTableCellUtils
 , evExcept
;

end.
