unit evParaUtilClasses;

interface

uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , evdTypes
 , nevBase
 , k2Interfaces
;

type
 TevTable = class(TevLocationProcessorTagTool, IedTable, IedCells)
  {* –еализаци€ интерфейсов IedCell и IedCells дл€ таблицы. }
  function Frame: IedFrame;
   {* рамка вокруг объекта }
  function Merge(aMergeAlg: TedMergeAlgorythm): Boolean; overload;
   {* объединить €чейки в диапазоне }
  function TableRange: IevTableRange;
   {* диапазон выделени€ в таблице }
  function Table: IedTable;
   {* таблица, к которому принадлежит данный диапазон €чеек }
  function VerticalAligment: TevVerticalAligment;
   {* выравнивание содержимого €чейки по вертикали }
  function InsertRows(NumRows: Integer): Boolean;
   {* втавл€ет NumRows строк в текущее место таблицы }
  function Split(const anIndicator: InevProgress): Boolean;
   {* раздел€ет таблицу на две, в текущем месте }
  function Merge(const anIndicator: InevProgress): Boolean; overload;
   {* объедин€ет таблицу со следующей }
  function FirstRowID: Integer;
   {* возвращает номер первой выделенной строки }
  function Delete: Boolean;
   {* удал€ет таблицу }
  function RowCount: Integer;
   {* возварщает количество строк в таблице }
  function Cell: IedCell;
   {* текуща€ €чейка таблицы }
  function Cells: IedCells;
   {* диапазон €чеек таблицы дл€ выделени€ }
  function Column: IedColumn;
   {* текуща€ колонка таблицы }
  function ColumnsIterator: IedColumnsIterator;
  function RowsIterator: IedRowsIterator;
  function OldNSRC: Boolean;
  procedure Translate2Text;
   {* преобразуем диапазон €чеек в текст. }
  function GetTagCell(aRow: Tl3Variant;
   const aCell: InevPara;
   aTagIndex: LongInt;
   const aLocation: InevLocation;
   anInitNeighbours: Boolean): IedCell;
   {* ¬рем€нка до переноса на модель evParaUtilClasses на модель. }
  function GetTag: Tl3Variant;
 end;//TevTable
 
implementation

uses
 l3ImplUses
;

end.
