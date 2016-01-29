unit nscArrangeGrid;

// Библиотека : Компоненты проекта Немезис;
// Название   : nscArrangeGrid;
// Автор      : Морозов М. А;
// Назначение : Сетка для выравнивания компонентов;
// Версия     : $Id: nscArrangeGrid.pas,v 1.22 2013/12/25 15:10:31 lulin Exp $

(*-------------------------------------------------------------------------------
   $Log: nscArrangeGrid.pas,v $
   Revision 1.22  2013/12/25 15:10:31  lulin
   {RequestLink:509706011}
   - перетрясаем модель.

   Revision 1.21  2009/11/17 10:34:39  oman
   - fix: {RequestLink:171967027}

   Revision 1.20  2009/10/12 11:27:13  lulin
   - коммитим после падения CVS.

   Revision 1.20  2009/10/08 09:50:53  lulin
   - показываем скроллеры и максимально подгоняем под макет.

   Revision 1.19  2009/10/06 13:37:55  lulin
   - bug fix: неправильно масштабировалась резиновая ячейка при наличии фиксированных.

   Revision 1.18  2009/10/06 13:14:05  lulin
   {RequestLink:162596818}. Добился правильной вёрстки.

   Revision 1.17  2009/09/02 12:02:00  lulin
   - bug fix: не компилировалось.

   Revision 1.16  2009/09/02 11:48:51  lulin
   {RequestLink:159360578}. №20.

   Revision 1.15  2008/08/06 16:57:06  mmorozov
   - bugfix: заливаем только область панели задач без детей (K<104435077>);

   Revision 1.14  2008/03/19 14:23:30  lulin
   - cleanup.

   Revision 1.13  2008/02/04 08:51:19  lulin
   - класс _Tl3InterfaceList выделен в отдельный модуль.

   Revision 1.12  2007/11/06 07:17:49  mmorozov
   - вернул DisableAlign при перерестроении, очень полезно например при быстром увеличении размера шрифта;

   Revision 1.11  2007/10/30 12:36:29  mmorozov
   В рамках работы над CQ: OIT5-27189:
   - TvtHideField теперь компонент с фокусом ввода;
   - Подключаем TvtHideField к обработке ввода с клавиатуры;
   - Подключаем TvtHideField к таблице перехода фокуса;

   Revision 1.10  2007/09/17 10:42:55  mmorozov
   New:
   - выделен интерфейс для получения уведомления о блокировке\разблокировки диспетчера форм на время выполенения операций модуля любым желающим (раньше только IvcmForm);
   - панель задач должна работать побыстрее, посколько перечитываем операции после добавления последней формы прецедента, а не каждой как это было раньше;
   - избавились от анимации в панели задач, при навигации между прецедентами;
   - почищен код;

   В рамках задачи CQ: OIT5-26623;

   Revision 1.9  2007/03/27 13:59:09  mmorozov
   - cleanup;

   Revision 1.8  2007/03/27 07:41:24  mmorozov
   - вставка строки в сетку контролов (начало);

   Revision 1.7  2007/03/23 12:56:11  mmorozov
   - в рамках работы над представлением панели задач, представление обновляет своё содержимое при изменении данных;

   Revision 1.6  2007/03/23 07:31:30  mmorozov
   - в рамках работы над представлением панели задач;

   Revision 1.5  2007/02/05 12:09:53  mmorozov
   - bugfix: не пересчитывали размер ячейки после объединения;

   Revision 1.4  2007/02/02 08:24:37  mmorozov
   - opt: не делаем лишней работы;

   Revision 1.3  2007/02/01 12:37:03  mmorozov
   - bugfix: на время размещения компонентов выключаем выравнивание (CQ: OIT5-24172);

   Revision 1.2  2007/01/18 12:58:38  mmorozov
   - new: Простое основное меню (CQ: OIT5-23939);

   Revision 1.1  2007/01/15 06:35:15  mmorozov
   - высносим общую функциональность из основного меню (выделен в отдельный модуль компонент управления фокусом с клавиатуры; использование компонента "сетка контролов", для управления размещением элементов основного меню), в рамках работы над "CQ: OIT5-23939";

-------------------------------------------------------------------------------*)

interface

uses
  Controls,
  Types,
  Classes,
  Forms,

  l3Base,
  l3InterfaceList,
  l3ProtoObject,

  nscInterfaces
  ;

const
  c_agMinWidth   = 40;
  c_agFullWidth  = 60;
  c_agMinHeight  = 40;
  c_agFullHeight = 60;
type
  TnscArrangeGrid = class;

  TagList = Tl3InterfaceList;

  TagCellsOwner = class(Tl3ProtoObject, IagCellsOwner)
  private
  // fields
    f_Cells : TagList;
    f_Grid  : TnscArrangeGrid;
  protected
  // IagCellsOwner
    function pm_GetCell(const aIndex: Integer): IagBaseCell;
    procedure pm_SetCell(const aIndex : Integer;
                         const Value  : IagBaseCell);
      {-}
    function pm_GetCellCount: Integer;
      {-}
    procedure AddCell(const aCell: IagBaseCell);
      {-}
    procedure DeleteCell(const aIndex: Integer);
      {-}
    procedure CellChanged;
      virtual;
      {-}
    procedure RecalcCells;
      {* - пересчитать размеры ячеек. }
    procedure ResetConstraints;
      virtual;
      {-}
    procedure Delete;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property Cell[const aIndex: Integer]: IagBaseCell
      read pm_GetCell
      write pm_SetCell;
      {-}
    property CellCount: Integer
      read pm_GetCellCount;
      {-}
    property Grid: TnscArrangeGrid
      read f_Grid;
      {-}
  public
  // methods
    constructor Create(const aGrid: TnscArrangeGrid);
      reintroduce;
      virtual;
      {-}
    class function Make(const aGrid: TnscArrangeGrid): IagCellsOwner;
      {-}
  end;//TagCellsOwner

  TagRow = class(TagCellsOwner, IagRow)
  {* Строка компонентов. }
  private
  // fields
    f_Top         : Integer;
    f_Bottom      : Integer;
    f_MinHeight   : Integer;
    f_FullHeight  : Integer;
    f_FixedHeight : Integer;
  private
  // IagRow
    function pm_GetHeight: Integer;
      {-}
    function pm_GetTop: Integer;
      {-}
    function pm_GetBottom: Integer;
      {-}
    function pm_GetMinHeight: Integer;
      {-}
      procedure pm_SetMinHeight(const aValue: Integer);
        {-}
    function pm_GetFullHeight: Integer;
      {-}
    function pm_GetFixedHeight: Integer;
    procedure pm_SetFixedHeight(const aValue: Integer);
      {* - строка имеет высоту фиксированного размера. }
    procedure SetBounds(const aTop, aBottom: Integer);
      {-}
  private
  // internal methods
    function TwoStageBuild: Boolean;
      {-}
    function CalcHeight(const aFull: Boolean = True): Integer;
      {-}
  protected
  // methods
    procedure CellChanged;
      override;
      {-}
    procedure ResetConstraints;
      override;
      {-}
  protected
  // properties
    property Top: Integer
      read pm_GetTop;
      {-}
    property Bottom: Integer
      read pm_GetBottom;
      {-}
    property FixedHeight: Integer
      read pm_GetFixedHeight;
      {-}
  public
  // methods
    constructor Create(const aGrid: TnscArrangeGrid);
      override;
      {-}
    class function Make(const aGrid: TnscArrangeGrid): IagRow;
      {-}
  end;//TagRow

  TagColumn = class(TagCellsOwner, IagColumn)
  private
  // fields
    f_Left       : Integer;
    f_Right      : Integer;
    f_MinWidth   : Integer;
    f_FullWidth  : Integer;
    f_FixedWidth : Integer;
  private
  // IagColumn
    function pm_GetLeft: Integer;
      {-}
    function pm_GetRight: Integer;
      {-}
    procedure SetBounds(const aLeft, aRight: Integer);
      {-}
    function pm_GetMinWidth: Integer;
      procedure pm_SetMinWidth(const aValue: Integer);
      {* - минимальная ширина для отображения содержимого столбца. }
    function pm_GetFullWidth: Integer;
      {* - ширина при которой отображается всё содержимое. }
    function pm_GetWidth: Integer;
      {* - реальная ширина столбца. }
      function pm_GetFixedWidth: Integer;
      procedure pm_SetFixedWidth(const aValue: Integer);
        {* - строка имеет высоту фиксированного размера. }
  private
  // internal methods
    function CalcWidth(const aFull: Boolean = True): Integer;
      {-}
  protected
  // methods
    procedure ResetConstraints;
      override;
      {-}
  public
  // methods
    constructor Create(const aGrid: TnscArrangeGrid);
      override;
      {-}
  end;//TagColumn

  TnscArrangeGrid = class(Tl3ProtoObject,
                          InscArrangeGrid)
  {* Сетка компонентов. }
  private
  // fields
    f_Columns         : TagList;
    f_Rows            : TagList;
    f_MinHeight       : Integer;
    f_MinWidth        : Integer;
    f_FullHeight      : Integer;
    f_FullWidth       : Integer;
    f_Left            : Integer;
    f_Top             : Integer;
    f_Width           : Integer;
    f_Height          : Integer;
    f_FixedRows       : TagList;
    f_StretchByHeight : Boolean;
    f_StretchByWidth  : Boolean;
    f_ArrangeRequest  : Integer;
    f_OnSizeChanged   : TNotifyEvent;
    f_LastMinWidth    : Integer;
    f_LastFullWidth   : Integer;
    f_LastMinHeight   : Integer;
    f_LastFullHeight  : Integer;
    f_IsUpdating      : Integer;
  private
  // InscArrangeGrid
    function pm_GetIsEmpty: Boolean;
      {* - является ли таблица пустой. }
    procedure BeginUpdate;
      {* - начата процедура обновления, в этот момент перестроения делать не
           нужно. }
    procedure EndUpdate;
      {* - закончена процедура обновления, нужно перестроить сетку, если до
           этого были запросы на перестроение. }
    function AddRow: IagRow;
      {* - добавить строку. }
    function AddColumn: IagColumn;
      {* - добавить столбец. }
    procedure InitCell(const aCell   : IagBaseCell;
                       const aColumn : IagColumn;
                       const aRow    : IagRow);
      {-}
    procedure SetBounds(const aLeft   : Integer;
                        const aTop    : Integer;
                        const aWidth  : Integer;
                        const aHeight : Integer);
      {-}
    procedure MergeCells(const aRow  : Integer;
                         const aFrom : Integer;
                         const aTo   : Integer;
                         const aCell : IagBaseCell);
      {* - объединить ячейки. }
  private
  // internal methods
    procedure ResetConstraints;
      {* - сбросить ограничения. }
    function TwoStageBuild: Boolean;
       {-}
    function CalcHeight(const aFull: Boolean = True): Integer;
      {-}
    function CalcWidth(const aFull: Boolean = True): Integer;
      {-}
    procedure ArrangeCells;
      {-}
    procedure JustifyColumns(aRest: Integer);
      {* - распределить остаток по ширине. }
    function ApplyFixedColumnWidth: Boolean;
      {* - попробывать применить фиксированную ширину к столбцам. }
    procedure ArrangeColumns;
      {-}
    procedure JustifyRows(const aRest: Integer);
      {* - распределить остаток по высоте. }
    procedure DistributeRestToRows(const aSize : Integer;
                                   const aRest : Boolean = True);
      {* - распределить остаток по строкам, если aRest = False, значит aSize
           является высотой строки, иначе остаток который нужно добавить к
           текущей высоте строки. }
    procedure ArrangeRows;
      {* - расположить строки. }
    function ApplyFixedRowHeight: Boolean;
      {* - попробывать назначить строкам одинаковую высоту. }
    procedure Arrange;
      {-}
    procedure RecalcHeight;
      {* - пересчитать таблицу по высоте. }
    procedure DoSizeChanged;
      {-}
    procedure Recalc;
      {* - пересчитать размеры ячеек. }
    procedure DeleteCells(const aCells: IagCellsOwner);
      {* - удалить строку или столбец. }
    function FindCells(const aList  : TagList;
                       const aCells : IagCellsOwner): Integer;
      {-}
  private
  // property methods
    function pm_GetIsUpdating: Boolean;
      {-}
    function pm_GetCell(const aRow : Integer;
                        const aCol : Integer): IagBaseCell;
    procedure pm_SetCell(const aRow  : Integer;
                         const aCol  : Integer;
                         const Value : IagBaseCell);
      {-}
    function pm_GetColumn(const aIndex: Integer): IagColumn;
      {-}
    function pm_GetRow(const aIndex: Integer): IagRow;
      {-}
    function pm_GetHeight: Integer;
      {* - высота таблицы. }
    function pm_GetWidth: Integer;
      {* - ширина таблицы. }
    function pm_GetRowCount: Integer;
      {-}
    function pm_GetColumnCount: Integer;
      {-}
    function pm_GetLastColumn: IagColumn;
      {-}
    function pm_GetLastRow: IagRow;
      {-}
    function pm_GetColumns: TagList;
      {-}
    function pm_GetRows: TagList;
      {-}
    function pm_GetLeft: Integer;
      {-}
    function pm_GetTop: Integer;
      {-}
    function pm_GetMinHeight: Integer;
      {-}
    function pm_GetMinWidth: Integer;
      {-}
    function pm_GetFullWidth: Integer;
      {* - ширина при которой содержимое ячейки показывается полностью. }
    function pm_GetFullHeight: Integer;
      {* - высота при которой содержимое ячейки показывается полностью. }
    function pm_GetFixedRows: TagList;
      {* - количество строк с фиксированным размером. }
    function pm_GetFixedRowsHeight: Integer;
      {* - высота строк фиксированного размера. }
  // property of events
    function pm_GetOnSizeChanged: TNotifyEvent;
    procedure pm_SetOnSizeChanged(const aValue: TNotifyEvent);
      {* - измененился размер таблицы. }
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  protected
  // properties
    property IsUpdating: Boolean
      read pm_GetIsUpdating;
      {* - сетка находится в состоянии обновления, перестраивать нельзя. }
    property Left: Integer
      read pm_GetLeft;
      {-}
    property Top: Integer
      read pm_GetTop;
      {-}
    property LastColumn: IagColumn
      read pm_GetLastColumn;
      {-}
    property LastRow: IagRow
      read pm_GetLastRow;
      {-}
    property Column[const aIndex: Integer]: IagColumn
      read pm_GetColumn;
      {-}
    property Row[const aIndex: Integer]: IagRow
      read pm_GetRow;
      {-}
    property Columns: TagList
      read pm_GetColumns;
      {-}
    property Rows: TagList
      read pm_GetRows;
      {-}
    property Cell[const aRow: Integer;
                  const aCol: Integer]: IagBaseCell
      read pm_GetCell
      write pm_SetCell;
      {-}
    property Height: Integer
      read pm_GetHeight;
      {* - высота таблицы. }
    property Width: Integer
      read pm_GetWidth;
      {* - ширина таблицы. }
    property MinHeight: Integer
      read pm_GetMinHeight;
      {-}
    property MinWidth: Integer
      read pm_GetMinWidth;
      {-}
    property FullWidth: Integer
      read pm_GetFullWidth;
      {* - ширина при которой содержимое ячейки показывается полностью. }
    property FullHeight: Integer
      read pm_GetFullHeight;
      {* - высота при которой содержимое ячейки показывается полностью. }
    property FixedRows: TagList
      read pm_GetFixedRows;
      {* - количество строк с фиксированным размером. }
    property FixedRowsHeight: Integer
      read pm_GetFixedRowsHeight;
      {* - высота строк фиксированного размера. }
  public
  // methods
    constructor Create(const aStretchByHeight : Boolean = True;
                       const aStretchByWidth  : Boolean = True);
      reintroduce;
      {-}
    class function Make(const aStretchByHeight : Boolean = True;
                        const aStretchByWidth  : Boolean = True): InscArrangeGrid;
      {-}
    procedure AddFixedRow(const aRow: IagRow);
      {* - добавить строку с фиксированным размером. }
    procedure RemoveFixedRow(const aRow: IagRow);
      {* - удалить строку с фиксированным размером. }
  end;//TnscArrangeGrid
  
procedure agArrangeGrid(const aGrid           : InscArrangeGrid;    
                        const aForm           : TCustomForm;
                        const aParent         : TWinControl;
                        const aOccuipedHeight : Integer);
  {* - определяет размеры таблицы и устанавливает полосы прокрутки формы. }

implementation

uses
  SysUtils,
  Windows,

  nscArrangeGridCell,

  evStyleTableSpy
  ;

procedure agArrangeGrid(const aGrid           : InscArrangeGrid;
                        const aForm           : TCustomForm;
                        const aParent         : TWinControl;
                        const aOccuipedHeight : Integer);
  {* - определяет размеры таблицы и устанавливает полосы прокрутки для владельца
       таблицы. }

 procedure lp_SetRange(const aSB       : TControlScrollBar;
                       const aSize     : Integer;
                       const aNeedSize : Integer);
 begin
  if aSize >= aNeedSize then
   aSB.Range := 0
  else
   aSB.Range := aNeedSize;
 end;//lp_SetRange

var
 l_Width  : Integer;
 l_Height : Integer;
begin
 if aGrid <> nil then
 begin
  if aGrid.MinWidth > aForm.Width then
   l_Width := aGrid.MinWidth
  else
   l_Width := aForm.Width;
  if aGrid.MinHeight > aForm.Height - aOccuipedHeight then
   l_Height := aGrid.MinHeight
  else
   l_Height := aForm.Height - aOccuipedHeight;
  // Полосы прокрутки:
  with aForm do
  begin
   lp_SetRange(HorzScrollBar, Width, l_Width);
   lp_SetRange(VertScrollBar, Height, l_Height + aOccuipedHeight);
  end;//with aForm do
  // Установим размеры:
  with aParent, ClientRect do
  begin
   DisableAlign;
   try
    aGrid.SetBounds(Left, Top, Right, Bottom);
   finally
    EnableAlign;
   end;//try..finally
  end;//with aParent, ClientRect do
 end;//if f_Grid <> nil then
end;//ArrangeGrid

{ TnscArrangeGrid }

procedure TnscArrangeGrid.MergeCells(const aRow  : Integer;
                                     const aFrom : Integer;
                                     const aTo   : Integer;
                                     const aCell : IagBaseCell);
  {* - объединить ячейки. }
var
 l_Index : Integer;
begin
 for l_Index := aFrom to aTo do
  Column[l_Index].Cell[aRow] := aCell;
 for l_Index := aFrom to aTo do
  Row[aRow].Cell[l_Index] := aCell;
 with aCell do
 begin
  StartColumn := Column[aFrom];
  EndColumn := Column[aTo];
  StartRow := Row[aRow];
  EndRow := Row[aRow];
  Attached;
 end;//with aCell do
end;//MergeCells

procedure TnscArrangeGrid.SetBounds(const aLeft   : Integer;
                                    const aTop    : Integer;
                                    const aWidth  : Integer;
                                    const aHeight : Integer);
  {-}
begin
 if (f_Left           <> aLeft)      or
    (f_Top            <> aTop)       or
    (f_Width          <> aWidth)     or
    (f_Height         <> aHeight)    or
    // Размеры доступной области остались прежними, но изменилось размеры
    // компонентов:
    (f_LastMinWidth   <> MinWidth)   or
    (f_LastFullWidth  <> FullWidth)  or
    (f_LastMinHeight  <> MinHeight)  or
    (f_LastFullHeight <> FullHeight) then
 begin
  f_Left           := aLeft;
  f_Top            := aTop;
  f_Width          := aWidth;
  f_Height         := aHeight;
  f_LastMinWidth   := MinWidth;
  f_LastFullWidth  := FullWidth;
  f_LastMinHeight  := MinHeight;
  f_LastFullHeight := FullHeight;
  Arrange;
 end;//if (f_Left <> aLeft)
end;//SetBounds

procedure TnscArrangeGrid.InitCell(const aCell   : IagBaseCell;
                                   const aColumn : IagColumn;
                                   const aRow    : IagRow);
begin
 with aCell do
 begin
  StartColumn := aColumn;
  EndColumn := aColumn;
  StartRow := aRow;
  EndRow := aRow;
  Attached;
 end;//with l_Item do
end;//InitCell

function TnscArrangeGrid.AddColumn: IagColumn;
  {* - добавить столбец. }
var
 l_Index : Integer;
 l_Cell  : IagBaseCell;
begin
 Columns.Add(TagColumn.Make(Self));
 Result := LastColumn;
 if Rows.Count = 0 then
  AddRow
 else
 begin
  for l_Index := 0 to Pred(Rows.Count) do
  begin
   l_Cell := TagBaseCell.Make;
   try
    InitCell(l_Cell, LastColumn, Row[l_Index]);
    LastColumn.AddCell(l_Cell);
    Row[l_Index].AddCell(l_Cell);
   finally
    l_Cell := nil;
   end;{try..finally}
  end;//for l_Index := 0
 end;//if Rows.Count = 0 then
end;//AddColumn

procedure TnscArrangeGrid.BeginUpdate;
  {* - начата процедура обновления, в этот момент перестроения делать не нужно. }
begin
 Inc(f_IsUpdating);
end;//BeginUpdate

procedure TnscArrangeGrid.EndUpdate;
  {* - закончена процедура обновления, нужно перестроить сетку, если до этого
       были запросы на перестроение. }
begin
 Dec(f_IsUpdating);
end;//EndUpdate

function TnscArrangeGrid.AddRow: IagRow;
  {* - добавить строку. }
var
 l_Index : Integer;
 l_Cell  : IagBaseCell;
begin
 Rows.Add(TagRow.Make(Self));
 if Columns.Count = 0 then
  AddColumn
 else
 begin
  for l_Index := 0 to Pred(Columns.Count) do
  begin
   l_Cell := TagBaseCell.Make;
   try
    InitCell(l_Cell, Column[l_Index], LastRow);
    LastRow.AddCell(l_Cell);
    Column[l_Index].AddCell(l_Cell);
   finally
    l_Cell := nil;
   end;{try..finally}
  end;//for l_Index := 0
 end;//if Columns.Count = 0 then
 Result := LastRow;
end;//AddRow

constructor TnscArrangeGrid.Create(const aStretchByHeight : Boolean = True;
                                   const aStretchByWidth  : Boolean = True);
begin
 inherited Create;
 f_Columns := TagList.Make;
 f_Rows := TagList.Make;
 f_MinHeight := -1;
 f_MinWidth := -1;
 f_FullHeight := -1;
 f_FullWidth := -1;
 f_StretchByHeight := aStretchByHeight;
 f_StretchByWidth := aStretchByWidth;
end;//Create

procedure TnscArrangeGrid.Cleanup;
begin
 f_OnSizeChanged := nil;
 FreeAndNil(f_FixedRows);
 FreeAndNil(f_Columns);
 FreeAndNil(f_Rows);
 inherited;
end;//Cleanup

procedure TnscArrangeGrid.RemoveFixedRow(const aRow: IagRow);
  {* - удалить строку с фиксированным размером. }
var
 l_Index: Integer;
begin
 l_Index := FixedRows.IndexOf(aRow);
 if l_Index <> -1 then
 begin
  FixedRows.Delete(l_Index);
  RecalcHeight;
 end;//if l_Index <> -1 then
end;//RemoveFixedRow

procedure TnscArrangeGrid.AddFixedRow(const aRow: IagRow);
  {* - добавить строку с фиксированным размером. }
begin
 if FixedRows.IndexOf(aRow) = -1 then
 begin
  FixedRows.Add(aRow);
  RecalcHeight;
 end;//if FixedRows.IndexOf(aRow) = -1 then
end;//AddFixedRow

class function TnscArrangeGrid.Make(const aStretchByHeight : Boolean = True;
                                    const aStretchByWidth  : Boolean = True): InscArrangeGrid;
var
 l_Class: TnscArrangeGrid;
begin
 l_Class := Create(aStretchByHeight, aStretchByWidth);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TnscArrangeGrid.pm_GetColumns: TagList;
begin
 Result := f_Columns;
end;//pm_GetColumns

function TnscArrangeGrid.pm_GetHeight: Integer;
begin
 Result := f_Height;
end;//pm_GetHeight

function TnscArrangeGrid.pm_GetWidth: Integer;
begin
 Result := f_Width;
end;//pm_GetWidth

function TnscArrangeGrid.pm_GetRowCount: Integer;
  {-}
begin
 Result := Rows.Count;
end;//pm_GetRowCount

function TnscArrangeGrid.pm_GetColumnCount: Integer;
  {-}
begin
 Result := Columns.Count;
end;//pm_GetColumnCount

function TnscArrangeGrid.pm_GetLastColumn: IagColumn;
begin
 with Columns do
  if Count > 0 then
   Supports(Items[Pred(Count)], IagColumn, Result)
  else
   Result := nil;
end;//pm_GetLastColumn

function TnscArrangeGrid.pm_GetRows: TagList;
begin
 Result := f_Rows;
end;//pm_GetRows

function TnscArrangeGrid.pm_GetLeft: Integer;
begin
 Result := f_Left;
end;//pm_GetLeft

function TnscArrangeGrid.pm_GetTop: Integer;
begin
 Result := f_Top;
end;//pm_GetTop

function TnscArrangeGrid.pm_GetFullWidth: Integer;
  {* - ширина при которой содержимое ячейки показывается полностью. }
begin
 if f_FullWidth = -1 then
  f_FullWidth := CalcWidth;
 Result := f_FullWidth;
end;//pm_GetFullWidth

function TnscArrangeGrid.pm_GetFixedRows: TagList;
  {* - количество строк с фиксированным размером. }
begin
 if f_FixedRows = nil then
  f_FixedRows := TagList.Make;
 Result := f_FixedRows;
end;//pm_GetFixedRows

function TnscArrangeGrid.pm_GetFullHeight: Integer;
  {* - высота при которой содержимое ячейки показывается полностью. }
begin
 if f_FullHeight = -1 then
  f_FullHeight := CalcHeight;
 Result := f_FullHeight;
end;//pm_GetFullHeight

function TnscArrangeGrid.pm_GetMinHeight: Integer;
begin
 if f_MinHeight = -1 then
  f_MinHeight := CalcHeight(False);
 Result := f_MinHeight;
end;//pm_GetMinHeight

function TnscArrangeGrid.pm_GetMinWidth: Integer;
begin
 if f_MinWidth = -1 then
  f_MinWidth := CalcWidth(False);
 Result := f_MinWidth;
end;//pm_GetMinWidth

procedure TnscArrangeGrid.ResetConstraints;
var
 l_Index: Integer;
begin
 f_MinHeight := -1;
 f_FullHeight := -1;
 f_MinWidth := -1;
 f_FullWidth := -1;
 for l_Index := 0 to Pred(Rows.Count) do
  with Row[l_Index] do
  begin
   RecalcCells;
   ResetConstraints;
  end;//with Row[l_Index] do
 for l_Index := 0 to Pred(Columns.Count) do
  Column[l_Index].ResetConstraints;
end;//ResetConstraints

function TnscArrangeGrid.FindCells(const aList  : TagList;
                                   const aCells : IagCellsOwner): Integer;
  {-}
var
 l_Index : Integer;
 l_Cells : IagCellsOwner;
begin
 for l_Index := 0 to Pred(aList.Count) do
  if Supports(aList.Items[l_Index], IagCellsOwner, l_Cells) and
   (l_Cells = aCells) then
  begin
   Result := l_Index;
   Exit;
  end;//if Supports(aList.Items[l_Index]...
 Result := -1;
end;//FindCells

procedure TnscArrangeGrid.DeleteCells(const aCells: IagCellsOwner);
  {* - удалить строку или столбец. }
var
 l_Index : Integer;
 l_Item  : Integer;
begin
 l_Index := FindCells(Rows, aCells);
 if l_Index = -1 then
 begin
  l_Index := FindCells(Columns, aCells);
  Columns.Delete(l_Index);
  for l_Item := 0 to Pred(Rows.Count) do
   Row[l_Item].DeleteCell(l_Index);
 end//if l_Index = -1 then
 else
 begin
  Rows.Delete(l_Index);
  for l_Item := 0 to Pred(Columns.Count) do
   Column[l_Item].DeleteCell(l_Index);
 end;//if l_Index = -1 then
end;//DeleteCells

procedure TnscArrangeGrid.Recalc;
  {* - пересчитать размеры ячеек. }
begin
 // После вычисления размеров ячеек, нам должны выставить размеры для таблицы,
 // до этого момента выравнивание производиться не будет:
 f_Width := 0;
 f_Height := 0;
 // Пересчитаем ограничения:
 ResetConstraints;
end;//Recalc

procedure TnscArrangeGrid.DoSizeChanged;
  {-}
begin
 if ((f_Width <> 0) and (f_Height <> 0)) and Assigned(f_OnSizeChanged) then
  f_OnSizeChanged(Self);
end;//DoSizeChanged

procedure TnscArrangeGrid.RecalcHeight;
  {* - пересчитать по высоте. }
begin
 f_MinHeight := -1;
 f_FullHeight := -1;
 Arrange;
 DoSizeChanged;
end;//RecalcHeight

procedure TnscArrangeGrid.DistributeRestToRows(const aSize : Integer;
                                               const aRest : Boolean = True);
var
 l_Top    : Integer;
 l_Index  : Integer;
 l_Height : Integer;
begin
 l_Top := Top;
 for l_Index := 0 to Pred(Rows.Count) do
 begin
  with Row[l_Index] do
  begin
   if FixedHeight <> 0 then
    l_Height := FixedHeight
   else
   begin
    if Height <> 0 then
     l_Height := Height
    else
     l_Height := MinHeight;
    if aRest then
     Inc(l_Height, aSize)
    else
     l_Height := aSize;
   end;//if FixedHeight <> 0 then
   SetBounds(l_Top, l_Top + l_Height);
   l_Top := Bottom;
  end;//with Row[l_Index] do
 end;//for l_Index := 0 to Pred(Rows.Count) do
end;//lp_DistributeRest

procedure TnscArrangeGrid.JustifyColumns(aRest: Integer);
var
 l_ColWidth : Integer;
 l_Left     : Integer;
 l_Index    : Integer;
begin
 if f_StretchByWidth and (aRest > 0) then
 begin
  l_ColWidth := Width div Columns.Count;
  l_Left := Left;
  for l_Index := 0 to Pred(Columns.Count) do
   with Column[l_Index] do
   begin
    if (FixedWidth > 0) then
    begin
     //Dec(aRest, l_ColWidth - FixedWidth);
     SetBounds(l_Left, l_Left + FixedWidth);
    end//FixedWidth > 0
    else
    // Если столбец имеет больше средней ширины, то ничего ему не даём:
    if (aRest > 0) and (Width < l_ColWidth) then
    begin
     if aRest < l_ColWidth - Width then
     begin
      SetBounds(l_Left, l_Left + Width + aRest);
      aRest := 0;
     end//if l_Rest < l_ColWidth - Width then
     else
     begin
      Dec(aRest, l_ColWidth - Width);
      SetBounds(l_Left, l_Left + Width + l_ColWidth - Width);
     end//if l_Rest < l_ColWidth - Width then
    end//if (l_Rest > 0)
    else
     SetBounds(l_Left, l_Left + Width);
    l_Left := Right;
   end;//with Column[l_Index] do
  // Осталось свободное место назначим последнему столбцу:
  if aRest > 0 then
   with LastColumn do
    SetBounds(Left, Right + aRest);
 end;//if l_Rest > 0 then
end;//JustifyColumns

procedure TnscArrangeGrid.JustifyRows(const aRest: Integer);
begin
 if f_StretchByHeight and (aRest > 0) and (Rows.Count - FixedRows.Count > 0) then
  DistributeRestToRows(aRest div (Rows.Count - FixedRows.Count));
end;//JustifyRows

function TnscArrangeGrid.ApplyFixedRowHeight: Boolean;
  {* - попробывать назначить строкам одинаковую высоту. }
var
 l_RowHeight : Integer;
 l_Index     : Integer;
begin
 Result := True;
 if f_StretchByHeight and (Rows.Count - FixedRows.Count > 0) then
 begin
  l_RowHeight := (Height - FixedRowsHeight) div (Rows.Count - FixedRows.Count);
  for l_Index := 0 to Pred(Rows.Count) do
   with Row[l_Index] do
    if (FixedHeight = 0) and (FullHeight > l_RowHeight) then
    begin
     Result := False;
     Break;
    end;//if (FixedHeight = 0)
  if Result then
   DistributeRestToRows(l_RowHeight, False);
 end//if Rows.Count - FixedRows.Count > 0 then
 else
  Result := False;
end;//ApplyFixedRowHeight

procedure TnscArrangeGrid.ArrangeRows;
var
 l_Index  : Integer;
 l_Rest   : Integer;
 l_Top    : Integer;
 l_Bottom : Integer;
begin
 if (Rows.Count = 0) then
  Exit;
 if ApplyFixedRowHeight then
  Exit;
 l_Rest := Height - MinHeight;
 if l_Rest < 0 then
  l_Rest := 0;
 l_Top := Top;
 for l_Index := 0 to Pred(Rows.Count) do
 begin
  with Row[l_Index] do
  begin
   if (l_Rest > 0) and (FixedHeight = 0) and (FullHeight > MinHeight) then
   begin
    if FullHeight - MinHeight > l_Rest then
    begin
     l_Bottom := l_Top + MinHeight + l_Rest;
     l_Rest := 0;
    end//if FullHeight - MinHeight > l_Rest then
    else
    begin
     l_Bottom := l_Top + FullHeight;
     Dec(l_Rest, FullHeight - MinHeight);
    end;//if FullHeight - MinHeight > l_Rest then
   end//if (l_Rest > 0) and FullHeight > MinHeight) then
   else
    l_Bottom := l_Top + MinHeight;
   SetBounds(l_Top, l_Bottom);
  end;//with Row[l_Index] do
  l_Top := l_Bottom;
 end;//for l_Index := 0 to Pred(Rows.Count) do
 // Раздаём оставшееся свободное место:
 JustifyRows(l_Rest);
end;//lp_ArrangeRows

function TnscArrangeGrid.ApplyFixedColumnWidth: Boolean;
var
 l_ColWidth : Integer;
 l_Left     : Integer;
 l_Index    : Integer;
 l_Width    : Integer;
 l_CC       : Integer;
begin
 Result := True;
 if f_StretchByWidth then
 begin
  l_Width := Width;
  l_CC := Columns.Count;
  for l_Index := 0 to Pred(Columns.Count) do
  begin
   if (Column[l_Index].FixedWidth > 0) then
   begin
    l_Width := l_Width - Column[l_Index].FixedWidth;
    Dec(l_CC);
   end;//Column[l_Index].FixedWidth > 0
  end;//for l_Index
  if (l_CC > 0) then
   l_ColWidth := l_Width div l_CC
  else
   l_ColWidth := 0; 
  for l_Index := 0 to Pred(Columns.Count) do
  begin
   if Column[l_Index].FullWidth > l_ColWidth then
   begin
    Result := False;
    Break;
   end;//if Row[l_Index].FullHeight > l_RowHeight then
  end;//for l_Index
  if Result then
  begin
   l_Left := Left;
   for l_Index := 0 to Pred(Columns.Count) do
   begin
    if (Column[l_Index].FixedWidth > 0) then
    begin
     Column[l_Index].SetBounds(l_Left, l_Left + Column[l_Index].FixedWidth);
     l_Left := l_Left + Column[l_Index].FixedWidth;
    end//Column[l_Index].FixedWidth > 0
    else
    begin
     Column[l_Index].SetBounds(l_Left, l_Left + l_ColWidth);
     l_Left := l_Left + l_ColWidth;
    end;//Column[l_Index].FixedWidth > 0
   end;//for l_Index := 0 to Pred(Rows.Count) do
  end;//if Result then
 end//if f_StretchByWidth then
 else
  Result := False;
end;//ApplyFixedHeight

procedure TnscArrangeGrid.ArrangeColumns;

var
 l_Index : Integer;
 l_Rest  : Integer;
 l_Left  : Integer;
 l_Right : Integer;
begin
 if Columns.Count = 0 then
  Exit;
 if ApplyFixedColumnWidth then
  Exit;
 l_Rest := Width - MinWidth;
 if l_Rest < 0 then
  l_Rest := 0;
 l_Left := Left;
 for l_Index := 0 to Pred(Columns.Count) do
 begin
  with Column[l_Index] do
  begin
   if (FixedWidth > 0) then
   begin
    l_Right := l_Left + FixedWidth;
    //Dec(l_Rest, FixedWidth);
   end//FixedWidth > 0
   else
   if (l_Rest > 0) and (FullWidth > MinWidth) then
   begin
    if FullWidth - MinWidth > l_Rest then
    begin
     l_Right := l_Left + MinWidth + l_Rest;
     l_Rest := 0;
    end//if FullWidth - MinWidth > l_Rest then
    else
    begin
     l_Right := l_Left + FullWidth;
     Dec(l_Rest, FullWidth - MinWidth);
    end;//if FullWidth - MinWidth > l_Rest then
   end//if (l_Rest > 0) and FullWidth > MinWidth) then
   else
    l_Right := l_Left + MinWidth;
   SetBounds(l_Left, l_Right);
  end;//with Row[l_Index] do
  l_Left := l_Right;
 end;//for l_Index := 0 to Pred(Columns.Count) do
 // Осталось свободное место, распределим:
 JustifyColumns(l_Rest);
end;//lp_ArrangeColumns

procedure TnscArrangeGrid.ArrangeCells;
var
 l_Row, l_Cell: Integer;
begin
 for l_Row := 0 to Pred(Rows.Count) do
  with Row[l_Row] do
   for l_Cell := 0 to Pred(CellCount) do
    Cell[l_Cell].ArrangeContent;
end;//lp_ArrangeCell

procedure TnscArrangeGrid.Arrange;
  {-}
var
 l_Temp: Integer;
begin
 if IsUpdating then
  Exit;
 if (f_Width = 0) or (f_Height = 0) then
  Exit;
 Inc(f_ArrangeRequest);
 if f_ArrangeRequest = 1 then
 begin
  ArrangeRows;
  ArrangeColumns;
  ArrangeCells;
  l_Temp := f_ArrangeRequest;
  f_ArrangeRequest := 0;
  // Во врмея построения поступл запрос на перестроение таблицы. Такое может
  // быть когда ячейке назначают размер и у нее меняются ограничения
  // (Min/Full/Height/Width):
  if l_Temp > 1 then
   Arrange;
 end;//if f_ArrangeRequest = 1 then
end;//Arrange

function TnscArrangeGrid.CalcHeight(const aFull: Boolean = True): Integer;
  {-}
var
 l_Index: Integer;
begin
 Result := 0;
 for l_Index := 0 to Pred(Rows.Count) do
 begin
  with Row[l_Index] do
  begin
   if aFull then
    Inc(Result, FullHeight)
   else
    Inc(Result, MinHeight)
  end;//with Column[l_ColIndex] do
 end;//for l_Col := 0 to Pred(Columns.Count) do
end;//CalcHeight

function TnscArrangeGrid.CalcWidth(const aFull: Boolean = True): Integer;
  {-}
var
 l_Index: Integer;
begin
 Result := 0;
 for l_Index := 0 to Pred(Columns.Count) do
 begin
  with Column[l_Index] do
  begin
   if aFull then
    Inc(Result, FullWidth)
   else
    Inc(Result, MinWidth);
  end;//with Row[l_Index] do
 end;//for l_Col := 0 to Pred(Columns.Count) do
end;//CalcWidth

function TnscArrangeGrid.pm_GetLastRow: IagRow;
begin
 with Rows do
  if Count > 0 then
   Supports(Items[Pred(Count)], IagRow, Result)
  else
   Result := nil;
end;//pm_GetLastRow

function TnscArrangeGrid.pm_GetColumn(const aIndex: Integer): IagColumn;
begin
 Assert(aIndex < Columns.Count);
 Supports(Columns[aIndex], IagColumn, Result);
end;//pm_GetColumn

function TnscArrangeGrid.pm_GetRow(const aIndex: Integer): IagRow;
begin
 Assert(aIndex < Rows.Count);
 Supports(Rows[aIndex], IagRow, Result);
end;//pm_GetRow

function TnscArrangeGrid.pm_GetCell(const aRow : Integer;
                                    const aCol : Integer): IagBaseCell;
begin
 Result := Row[aRow].Cell[aCol];
end;//pm_GetCell

procedure TnscArrangeGrid.pm_SetCell(const aRow  : Integer;
                                     const aCol  : Integer;
                                     const Value : IagBaseCell);
begin
 Row[aRow].Cell[aCol] := Value;
 Column[aCol].Cell[aRow] := Value;
 InitCell(Value, Column[aCol], Row[aRow]);
end;//pm_SetCell

function TnscArrangeGrid.pm_GetOnSizeChanged: TNotifyEvent;
begin
 Result := f_OnSizeChanged;
end;//pm_GetOnSizeChanged

procedure TnscArrangeGrid.pm_SetOnSizeChanged(const aValue: TNotifyEvent);
begin
 f_OnSizeChanged := aValue;
end;//pm_SetOnSizeChanged

function TnscArrangeGrid.pm_GetFixedRowsHeight: Integer;
var
 l_Index : Integer;
 l_Row   : IagRow;
begin
 Result := 0;
 for l_Index := 0 to Pred(FixedRows.Count) do
  if Supports(FixedRows.Items[l_Index], IagRow, l_Row) then
   Inc(Result, l_Row.FixedHeight);
end;//pm_GetFixedRowsHeight

function TnscArrangeGrid.pm_GetIsUpdating: Boolean;
begin
 Result := f_IsUpdating > 0;
end;//pm_GetIsUpdating

function TnscArrangeGrid.pm_GetIsEmpty: Boolean;
begin
 Result := (LastColumn = nil) or (LastRow = nil);
end;

function TnscArrangeGrid.TwoStageBuild: Boolean;
var
 l_Index: Integer;
begin
 Result := False;
 for l_Index := 0 to Pred(Rows.Count) do
  if Row[l_Index].TwoStageBuild then
  begin
   Result := True;
   Exit;
  end;
end;

{ TagColumn }

function TagColumn.CalcWidth(const aFull: Boolean = True): Integer;
var
 l_Index: Integer;
begin
 if (f_FixedWidth > 0) then
  Result := f_FixedWidth
 else
 begin
  Result := 0;
  for l_Index := 0 to Pred(CellCount) do
  begin
   // Для объединенных ячеек считаем размер только один раз:
   if Cell[l_Index].StartColumn <> (IagColumn(Self)) then
    Continue;
   if aFull then
   begin
    if Result < Cell[l_Index].FullWidth then
     Result := Cell[l_Index].FullWidth;
   end
   else
    if Result < Cell[l_Index].MinWidth then
     Result := Cell[l_Index].MinWidth;
  end;//for l_CellIndex := 0 to Pred(l_Col.CellCount) do
 end;//f_FixedWidth > 0
end;//CalcMinWidth

function TagColumn.pm_GetFullWidth: Integer;
  {-}
begin
 if f_FullWidth = -1 then
  f_FullWidth := CalcWidth;
 Result := f_FullWidth;
end;//pm_GetFullWidth

function TagColumn.pm_GetMinWidth: Integer;
begin
 if f_MinWidth = -1 then
  f_MinWidth := CalcWidth(False);
 Result := f_MinWidth;
end;//pm_GetMinWidth

procedure TagColumn.pm_SetMinWidth(const aValue: Integer);
begin
 f_MinWidth := aValue;
end;

function TagColumn.pm_GetWidth: Integer;
  {* - реальная ширина столбца. }
begin
 if (f_FixedWidth > 0) then
  Result := f_FixedWidth
 else
  Result := f_Right - f_Left;
end;//pm_GetWidth

function TagColumn.pm_GetFixedWidth: Integer;
begin
 Result := f_FixedWidth;
end;

procedure TagColumn.pm_SetFixedWidth(const aValue: Integer);
begin
 f_FixedWidth := aValue;
end;

function TagColumn.pm_GetLeft: Integer;
begin
 Result := f_Left;
end;//pm_GetLeft

function TagColumn.pm_GetRight: Integer;
begin
 if (f_FixedWidth > 0) then
  Result := f_Left + f_FixedWidth
 else
  Result := f_Right;
end;//pm_GetRight

procedure TagColumn.SetBounds(const aLeft, aRight : Integer);
  {-}
begin
 if (f_FixedWidth > 0) then
  Assert(aRight - aLeft = f_FixedWidth);
 f_Left := aLeft;
 f_Right := aRight;
end;//SetBounds

constructor TagColumn.Create(const aGrid: TnscArrangeGrid);
begin
 f_MinWidth := -1;
 f_FullWidth := -1;
 f_FixedWidth := 0;
 inherited Create(aGrid);
end;//Create

procedure TagColumn.ResetConstraints;
begin
 f_MinWidth := -1;
 f_FullWidth := -1;
end;//ResetConstraints

{ TagRow }

procedure TagRow.pm_SetFixedHeight(const aValue: Integer);
begin
 f_FixedHeight := aValue;
 if aValue <> 0 then
 begin
  f_MinHeight := aValue;
  f_FullHeight := aValue;
  f_Grid.AddFixedRow(Self);
 end//if aFixedHeight <> 0 then
 else
 begin
  ResetConstraints;
  f_Grid.RemoveFixedRow(Self);
 end;//if aValue <> 0 then
end;//pm_SetFixedHeight

function TagRow.pm_GetFixedHeight: Integer;
  {* - строка имеет высоту фиксированного размера. }
begin
 Result := f_FixedHeight;
end;//pm_GetFixedHeight

function TagRow.pm_GetFullHeight: Integer;
  {-}
begin
 if f_FullHeight = -1 then
  f_FullHeight := CalcHeight;
 Result := f_FullHeight;
end;//pm_GetFullHeight

function TagRow.pm_GetMinHeight: Integer;
begin
 if f_MinHeight = -1 then
  f_MinHeight := CalcHeight(False);
 Result := f_MinHeight;
end;//pm_GetMinHeight

procedure TagRow.pm_SetMinHeight(const aValue: Integer);
  {-}
begin
 f_MinHeight := aValue;
end;

function TagRow.CalcHeight(const aFull: Boolean = True): Integer;
var
 l_Index: Integer;
begin
 if FixedHeight > 0 then
  Result := FixedHeight
 else
 begin
  Result := 0;
  for l_Index := 0 to Pred(CellCount) do
  begin
   // Для объединенных ячеек считаем размер только один раз:
   if Cell[l_Index].StartRow <> (IagRow(Self)) then
    Continue;
   if aFull then
   begin
    if Result < Cell[l_Index].FullHeight then
     Result := Cell[l_Index].FullHeight;
   end//if aFull then
   else
    if Result < Cell[l_Index].MinHeight then
     Result := Cell[l_Index].MinHeight;
  end;//for l_Index := 0 to Pred(CellCount) do
 end;//FixedHeight > 0
end;//CalcMinHeight

constructor TagRow.Create(const aGrid: TnscArrangeGrid);
  // reintroduce;
  {-}
begin
 inherited Create(aGrid);
 f_MinHeight := -1;
 f_FullHeight := -1;
end;//Create

class function TagRow.Make(const aGrid: TnscArrangeGrid): IagRow;
var
 l_Class: TagRow;
begin
 l_Class := Create(aGrid);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TagRow.pm_GetBottom: Integer;
begin
 Result := f_Bottom;
end;//pm_GetBottom

function TagRow.pm_GetHeight: Integer;
  {-}
begin
 Result := Bottom - Top;
end;//pm_GetHeight

function TagRow.pm_GetTop: Integer;
begin
 Result := f_Top;
end;//pm_GetTop

procedure TagRow.SetBounds(const aTop, aBottom: Integer);
begin
 f_Top := aTop;
 f_Bottom := aBottom;
end;//SetBounds

procedure TagRow.CellChanged;
begin
 inherited;
 ResetConstraints;
 f_Grid.RecalcHeight;
end;//CellChanged

procedure TagRow.ResetConstraints;
begin
 inherited;
 f_MinHeight := -1;
 f_FullHeight := -1;
end;//ResetConstraints

function TagRow.TwoStageBuild: Boolean;
var
 l_Index: Integer;
begin
 Result := False;
 if CellCount > 1 then
  for l_Index := 0 to Pred(CellCount) do
  if Cell[l_Index].TwoStageBuild then
  begin
   Result := True;
   Exit;
  end;
end;

{ TagCellsOwner }

procedure TagCellsOwner.CellChanged;
  {-}
begin
end;//CellChanged
      
procedure TagCellsOwner.AddCell(const aCell: IagBaseCell);
begin
 f_Cells.Add(aCell);
end;//Add

procedure TagCellsOwner.Cleanup;
begin
 FreeAndNil(f_Cells);
 inherited;
end;//Cleanup

constructor TagCellsOwner.Create(const aGrid: TnscArrangeGrid);
begin
 inherited Create;
 f_Cells := TagList.Make;
 f_Grid := aGrid;
end;//Create

function TagCellsOwner.pm_GetCell(const aIndex: Integer): IagBaseCell;
begin
 with f_Cells do
 begin
  Assert((Count > 0) and (aIndex < Count));
  Supports(Items[aIndex], IagBaseCell, Result);
 end;//with f_Cells do
end;//pm_GetCell

function TagCellsOwner.pm_GetCellCount: Integer;
  {-}
begin
 Result := f_Cells.Count; 
end;//pm_GetCellCount

procedure TagCellsOwner.pm_SetCell(const aIndex : Integer;
                                   const Value  : IagBaseCell);
begin
 with f_Cells do
 begin
  Assert((Count > 0) and (aIndex < Count));
  Items[aIndex] := Value;
 end;//with f_Cells do
end;//pm_SetCell

procedure TagCellsOwner.DeleteCell(const aIndex: Integer);
  {-}
begin
 f_Cells.Delete(aIndex);
end;//DeleteCell

procedure TagCellsOwner.Delete;
  {-}
begin
 f_Grid.DeleteCells(Self);
end;//Delete

procedure TagCellsOwner.ResetConstraints;
  //virtual;
  {-}
begin

end;//ResetConstraints

procedure TagCellsOwner.RecalcCells;
  {* - пересчитать размеры ячеек. }
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(CellCount) do
  Cell[l_Index].RecalcConstraints;
end;//Recalc

class function TagCellsOwner.Make(const aGrid: TnscArrangeGrid): IagCellsOwner;
var
 l_Class: TagCellsOwner;
begin
 l_Class := Create(aGrid);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;

end.
