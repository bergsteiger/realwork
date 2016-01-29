unit nscTabTable;
{* Таблица перехода фокуса. }

// Библиотека : Компоненты проекта Немезис
// Автор      : Морозов М.А.
// Модуль     : nscTabTable - Таблица перехода фокуса.
// Начат      : 27.03.2007
// Версия     : $Id: nscTabTable.pas,v 1.8 2011/05/19 13:50:15 lulin Exp $

(*-------------------------------------------------------------------------------
  $Log: nscTabTable.pas,v $
  Revision 1.8  2011/05/19 13:50:15  lulin
  {RequestLink:266409354}.

  Revision 1.7  2011/05/19 12:19:01  lulin
  {RequestLink:266409354}.

  Revision 1.6  2008/02/05 09:57:33  lulin
  - выделяем базовые объекты в отдельные файлы и переносим их на модель.

  Revision 1.5  2008/02/01 15:14:27  lulin
  - избавляемся от излишней универсальности списков.

  Revision 1.4  2007/11/02 12:23:22  mmorozov
  - new: при перемещении между столбцами таблицы перехода фокуса учитываем не порядковый номер ячейки в столбце из которого переходим, а координаты ячейки (в рамках работы над CQ: OIT5-27189) + сопутствующий рефакторинг;

  Revision 1.3  2007/03/28 13:12:09  mmorozov
  - new: очистка таблицы перехода фокуса;

  Revision 1.2  2007/03/28 11:39:38  mmorozov
  - подключаем таблицу перехода фокуса к панели задач;

  Revision 1.1  2007/03/28 11:02:54  mmorozov
  - "таблица перехода фокуса" перенесена в библиотеку визуальных компонентов проекта Немезис;

-------------------------------------------------------------------------------*)

interface

uses
  l3Base,
  l3ObjectRefList,
  l3ProtoObject,
  l3ProtoObjectRefList,

  nscInterfaces
  ;

type
  TnscTabTableColumn = class;
  TnscTabTable = class;
  TnscTabTableList = Tl3ProtoObjectRefList;

  Tnsc_ttBase = class(Tl3ProtoObject)
  {* Базовый класс таблицы перехода фокуса. }
  end;//Tnsc_ttBase

  TnscProcessKey = class(Tnsc_ttBase)
  {* - для обработки нажатия на клавиши в TeeTreeView, TvtLister. }
  private
  // private fields
    f_Cell   : InscTabTableCell;
    f_Column : TnscTabTableColumn;
    f_Index  : Integer;
  private
  // private methods
    function IsLocalJump(const aKey : TnscTabTableKey) : Boolean;
      {* - если True, значит фокус находился не на первом/последнем элементе
           дерева, списка, не передаем выше. }
    procedure OnProcessKey(const aKey : TnscTabTableKey);
      {* - событие нажатия на клавишу. }
  private
  // property methods
    function pm_GetCanFocus : Boolean;
      {-}
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
  protected
  // protected properties
    property Index : Integer
      read f_Index
      write f_Index;
      {* - порядковый номер в столбце, устанавливается при добавлении элемента
           в список. }
  public
  // public methods
    constructor Create(const aItem   : InscTabTableCell;
                       const aColumn : TnscTabTableColumn);
      reintroduce;
      virtual;
      {-}
    procedure SetFocus(const aFromNext: Boolean = True);
      {-}
  public
  // public properties
    property CanFocus : Boolean
      read pm_GetCanFocus;
      {* - может ли компонент получать фокус. }
    property Cell: InscTabTableCell
      read f_Cell;
      {-}
  end;//TnscProcessKey

  TnscTabTableColumn = class(TnscTabTableList, InscTabTableColumn)
  {* - колеция элементов одного столбца меню. }
  private
    f_Table : TnscTabTable;
    f_Index : Integer;
  private
  // private methods
    procedure ProcessKey(const aKey  : TnscTabTableKey;
                         const aItem : TnscProcessKey);
      {* - на элементе столбца aItem нажали клавишу, транслируем событие к
           TmmColums. }
    function CheckSetFocus(const aItem      : Integer;
                           const aUp        : Boolean = True;
                           const aLeftRight : Boolean = False;
                           const aTop       : Integer = -1) : Boolean;
      {* - устанавливает фокус элементу aItem, если фокус не может быть
           установлен, например элемент не виден, то ищем первый который может
           в зависимости от aUp. }
  protected
  // protected property
    property Index : Integer
      read f_Index
      write f_Index;
      {-}
  public
  // public methods
    constructor Create(const aTable: TnscTabTable);
      reintroduce;
      virtual;
      {-}
    procedure AddItem(const aItem: InscTabTableCell);
      {* - добавляет элемент в список. }
    procedure SetFocus(const aFromNext : Boolean = True);
      {-}
  end;//TnscTabTableColumn

  TnscTabTable = class(TnscTabTableList, InscTabTable)
  {* - столбцы в основном меню. }
  private
  // InscTabTable
    function pm_GetColumnCount: Integer;
      {-}
    function pm_GetColumn(const aIndex: Integer): InscTabTableColumn;
      {-}
    function AddColumn: InscTabTableColumn;
      {* - добавляет новый столбец. }
    procedure InscTabTable_Clear;
    procedure InscTabTable.Clear = InscTabTable_Clear;
      {-}
  private
  // private methods
    procedure ProcessKey(const aKey    : TnscTabTableKey;
                         const aColumn : Integer;
                         const aItem   : TnscProcessKey);
      {* - была нажата клавиша влево, вправо, нужно переместить фокус на
           соответствующий элемент соседнего стобца. }
  private
  // property methods
    function pm_GetLastColumn : TnscTabTableColumn;
      {-}
  public
  // public methods
    class function Make: InscTabTable;
      reintroduce;
      {-}
  public
  // public properties
    property LastColumn : TnscTabTableColumn
      read pm_GetLastColumn;
      {* - последний столбец в списке. }
  end;//TnscTabTable

implementation

uses
  Math,
  SysUtils
  ;

{ TnscProcessKey }

procedure TnscProcessKey.OnProcessKey(const aKey : TnscTabTableKey);
{* - событие нажатия на клавишу. }
begin
 if not IsLocalJump(aKey) then
  f_Column.ProcessKey(aKey, Self);
end;//OnProcessKey

function TnscProcessKey.IsLocalJump(const aKey : TnscTabTableKey) : Boolean;
{* - если True, значит фокус находился не на первом/последнем элементе
     дерева, списка, не передаем выше. }
begin
 Result := False;
 case aKey of
  // На предыдущий элемент
  ns_kUp:
  if f_Cell.Current > 0 then
  begin
   Result := True;
   f_Cell.Current := Pred(f_Cell.Current);
  end;//ns_kUp
  // На следующий элемент
  ns_kDown:
  if f_Cell.Current < Pred(f_Cell.Count) then
  begin
   Result := True;
   f_Cell.Current := Succ(f_Cell.Current);
  end;//ns_kDown
 end//case aKey of
end;//IsLocalJump

function TnscProcessKey.pm_GetCanFocus : Boolean;
  {-}
begin
 Result := f_Cell.Control.CanFocus;
end;//pm_GetCanFocus

procedure TnscProcessKey.Cleanup;
// override;
begin
 f_Cell := nil;
 inherited;
end;//Cleanup

constructor TnscProcessKey.Create(const aItem : InscTabTableCell;
                                 const aColumn  : TnscTabTableColumn);
// reintroduce;
// virtual;
begin
 inherited Create;
 f_Column := aColumn;
 f_Cell := aItem;
 f_Cell.OnProcessKey := OnProcessKey;
end;//Create

procedure TnscProcessKey.SetFocus(const aFromNext: Boolean = True);
{-}
begin
 f_Cell.SetFocus(aFromNext);
end;//SetFocus

{ TnscTabTableColumn }

constructor TnscTabTableColumn.Create(const aTable: TnscTabTable);
// reintroduce;
// virtual;
{-}
begin
 inherited Create;
 f_Table := aTable;
end;//Create

procedure TnscTabTableColumn.AddItem(const aItem: InscTabTableCell);
  {* - добавляет элемент в список. }
var
 l_Temp: TnscProcessKey;
begin
 l_Temp := TnscProcessKey.Create(aItem, Self);
 try
  l_Temp.Index := Add(l_Temp);
 finally
  FreeAndNil(l_Temp);
 end;{try..finally}
end;//AddItem

procedure TnscTabTableColumn.ProcessKey(const aKey  : TnscTabTableKey;
                                        const aItem : TnscProcessKey);
{* - на элементе столбца aItem нажали клавишу. }
var
 l_Process : Boolean;
begin
 l_Process := True;
 case aKey of
  ns_kUp:
   if aItem.Index > 0 then
    l_Process := not CheckSetFocus(Pred(aItem.Index), True);
  ns_kDown:
   if aItem.Index < Pred(Count) then
    l_Process := not CheckSetFocus(Succ(aItem.Index), False);
 end;//case aKey of
 if l_Process then
  f_Table.ProcessKey(aKey, f_Index, aItem);
end;//ProcessKey

function TnscTabTableColumn.CheckSetFocus(const aItem      : Integer;
                                          const aUp        : Boolean = True;
                                          const aLeftRight : Boolean = False;
                                          const aTop       : Integer = -1) : Boolean;
  {* - устанавливает фокус элементу aItem, если фокус не может быть установлен,
       например элемент не виден, то ищем первый который может в зависимости от
       aUp. }
 var
  l_Item : Integer;
  l_Top  : Integer;

 function lp_Item: TnscProcessKey;
 begin
  Result := TnscProcessKey(Items[l_Item]);
 end;//lp_Item

 function lp_NeedSetFocus: Boolean;
 begin
  with lp_Item, Cell.Bounds do
   Result := CanFocus and ((l_Top = -1) or (Top >= l_Top) or (Bottom >= l_Top));
 end;//lp_NeedSetFocus

 function lp_Move(const aLow  : Integer;
                  const aHigh : Integer;
                  const aUp   : Boolean = True) : Boolean;

   function lp_Finish: Boolean;
   begin
    Result := False;
    if aUp then
    begin
     if (l_Item < aLow) then
      Result := True;
    end//if aUp then
    else
     if (l_Item > aHigh) then
      Result := True;
   end;//lp_IsExit

   procedure lp_NextCell;
   begin
    if aUp then
     Dec(l_Item)
    else
     Inc(l_Item);
   end;//lp_NextCell

   procedure lp_InitCell;
   begin
    if aUp then
     l_Item := aHigh
    else
     l_Item := aLow;
   end;//lp_InitCell

 begin
  Result := False;
  lp_InitCell;
  while True do
  begin
   if lp_NeedSetFocus then
   begin
    lp_Item.SetFocus(aUp);
    Result := True;
    Break;
   end;//if TnscProcessKey(Items[l_Item]).CanFocus then
   lp_NextCell;
   if lp_Finish then
    Break;
  end;//while (l_Item >= aLow) do
 end;//lp_Up

begin
 l_Top := aTop;
 if aUp then
 begin
  // Продемся до верху
  Result := lp_Move(0, aItem);
  if not Result and aLeftRight then
  begin
   l_Top := -1;
   // Нет ни одного видимого идем сверху до aItem + 1
   Result := lp_Move(0, Pred(Count), False);
  end;//if not Result and aLeftRight then
 end//if aUp then
 else
 begin
  // Пройдемся до низу
  Result := lp_Move(aItem, Pred(Count), False);
  if not Result and aLeftRight then
  begin
   l_Top := -1;
   // Пройдемся с первого до aItem - 1
   Result := lp_Move(0, Pred(Count));
  end;//if not Result and aLeftRight then
 end;//if aUp then
end;//CheckSetFocus

procedure TnscTabTableColumn.SetFocus(const aFromNext : Boolean);
begin
 if Count > 0 then
  CheckSetFocus(IfThen(aFromNext, Pred(Count), 0), aFromNext);
end;

{ TnscTabTable }

class function TnscTabTable.Make: InscTabTable;
  {-}
var
 l_Class: TnscTabTable;
begin
 l_Class := inherited Make;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TnscTabTable.pm_GetColumn(const aIndex: Integer): InscTabTableColumn;
  {-}
begin
 Supports(Items[aIndex], InscTabTableColumn, Result);
end;//pm_GetColumn

function TnscTabTable.pm_GetColumnCount: Integer;
  {-}
begin
 Result := Count;
end;//pm_GetColumnCount

procedure TnscTabTable.InscTabTable_Clear;
begin
 Clear;
end;//InscTabTable_Clear

function TnscTabTable.AddColumn: InscTabTableColumn;
var
 l_Class: TnscTabTableColumn;
begin
 l_Class := TnscTabTableColumn.Create(Self);
 try
  l_Class.Index := Add(l_Class);
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//AddItem

procedure TnscTabTable.ProcessKey(const aKey    : TnscTabTableKey;
                                  const aColumn : Integer;
                                  const aItem   : TnscProcessKey);
{* - была нажата клавиша влево, вправо, нужно переместить фокус на
     соответствующий элемент соседнего стобца. }

  function lp_ItemIndex(const aColumn : TnscTabTableColumn) : Integer;
  begin
   if aItem.Index > Pred(aColumn.Count) then
    Result := Pred(aColumn.Count)
   else
    Result := aItem.Index;
  end;//lp_ItemIndex

  procedure lp_SetColumn(const aColumn : Integer;
                         const aTop    : Integer = -1);
    function lp_Index: Integer;
    begin
     if aTop = -1 then
      Result := lp_ItemIndex(TnscTabTableColumn(Items[aColumn]))
     else
      Result := 0;
    end;//lp_Index

  begin
   TnscTabTableColumn(Items[aColumn]).CheckSetFocus(lp_Index, False, True, aTop);
  end;//lp_SetColumn

var
 l_Index : Integer;
begin
 case aKey of
  ns_kUp:
  begin
   if aColumn > 0 then
    l_Index := Pred(aColumn)
   else
    l_Index := Pred(Count);
   TnscTabTableColumn(Items[l_Index]).SetFocus;
  end;
  ns_kDown:
  begin
   if aColumn < Pred(Count) then
    l_Index := Succ(aColumn)
   else
    l_Index := 0;
   TnscTabTableColumn(Items[l_Index]).SetFocus(False);
  end;
  ns_kLeft:
  begin
   if aColumn > 0 then
    l_Index := Pred(aColumn)
   else
    l_Index := Pred(Count);
   lp_SetColumn(l_Index, aItem.Cell.Bounds.Top);
  end;//ns_kLeft
  ns_kRight:
  begin
   if aColumn < Pred(Count) then
    l_Index := Succ(aColumn)
   else
    l_Index := 0;
   lp_SetColumn(l_Index, aItem.Cell.Bounds.Top);
  end;//ns_kRight
 end;//case aKey of
end;//ProcessKey

function TnscTabTable.pm_GetLastColumn: TnscTabTableColumn;
begin
 Result := nil;
 if Count > 0 then
  Result := TnscTabTableColumn(Items[Pred(Count)]);
end;//pm_GetLastColumn

end.
