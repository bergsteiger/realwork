unit evTableCursorPair;

interface

uses
 l3IntfUses
 , evParaListCursorPair
 , nevTools
 , l3Variant
 , nevBase
 , k2Interfaces
;

type
 TevTableCursorPair = class(TevParaListCursorPair, IevTableRange)
  {* Выделение для таблицы. }
  function GetRowBlock(const aView: InevView;
   aRow: Tl3Variant;
   aStartOffset: LongInt;
   aFinishOffset: LongInt;
   out theBlock: InevRange): Boolean;
   {* получить блок выделения для строки таблицы. }
  function GetRangeOffsets(out theStartOffset: Integer;
   out theFinishOffset: Integer): Boolean;
   {* возвращает горизонтальные границы диапазона выделения. }
  function GetRangeBorders(out theStartRow: Integer;
   out theFinishRow: Integer;
   out theStartOffset: Integer;
   out theFinishOffset: Integer): Boolean;
   {* возвращает границы диапазона выделения. }
  function Offset2Cells(aRow: Tl3Variant;
   aStartOffset: Integer;
   aFinishOffset: Integer;
   out theStartCell: Integer;
   out theFinishCell: Integer): Boolean;
   {* получить индексы для ячеек aRow для смещений (aStartOffset, aFinishOffset). }
 end;//TevTableCursorPair
 
implementation

uses
 l3ImplUses
 , evOp
 , evInternalInterfaces
 , k2OpMisc
 , evConst
 , l3MinMax
 , l3Base
 , evdInterfaces
 , nevFacade
 , k2Tags
 , evCursorTools
 , evdTypes
 , l3LongintList
 , SysUtils
 , k2Base
 , evTableCellUtils
;

end.
