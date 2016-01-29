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
  {* –еализаци€ интерфейса IedCell дл€ обычной €чейки таблицы. }
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
   {* рамка вокруг объекта }
  procedure UpdateWidthAndCheckHead(aNewWidth: Integer);
   {* измен€ет ширину €чейки, в том числе и объединенных }
  function Merge(aNeighbour: TedNeighbourIndex): Boolean;
   {* объедин€ет €чейку с соседом }
  function Split(aColNum: Integer;
   aRowNum: Integer): Boolean; overload;
   {* разбивает €чейку }
  function Split(anOrientation: Tl3Orientation1): Boolean; overload;
   {* разбивает €чейку }
  function IsFirst: Boolean;
   {* возвращает - перва€ ли это €чейка }
  function IsLast: Boolean;
   {* возвращает - последн€€ ли это €чейка }
  function IsBottom: Boolean;
   {* возвращает - сама€ ли €чейка нижн€€ }
  function Delete(const anOp: InevOp;
   anInMerge: Boolean): Boolean;
   {* удал€ет €чейку }
  function Table: IedTable;
   {* таблица к которой принадлежит €чейка }
  function Neighbour: IedCell;
   {* соседи €чейки }
  function Width: Integer;
   {* ширина €чейки }
  function VerticalAligment: TevVerticalAligment;
   {* выравнивание содержимого €чейки по вертикали }
  function MergeStatus: TevMergeStatus;
  function TextAsInteger: Integer;
   {* ѕытаетс€ преобразовать текст в €чейке к целому числу. }
  function GetFirstLineText: AnsiString;
   {* ¬озвращает первую строку €чейки. »спользыетс€ дл€ тестов. }
  function IsEmptyCell: Boolean;
  function IsFrameEmpty: Boolean;
  function GetCellType: TedCellType;
   {* ¬озвращает тип содержимого €чейки. }
  procedure MakeCellContinue(const anOp: InevOp);
   {* ¬ыставить тип €чейке (ev_msContinue) и очистить еЄ содержимое. }
  function CalcHeadCellHeghtInRow: Integer;
   {* ѕосчитать сколько занимает строк объедиенна€ €чейка. }
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
