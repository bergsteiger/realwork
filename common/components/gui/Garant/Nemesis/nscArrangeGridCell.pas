unit nscArrangeGridCell;
{* Ячейки сетки контролов. }

// Библиотека : Компоненты проекта Немезис
// Автор      : Морозов М.А.
// Модуль     : nscArrangeGridCell - Ячейки сетки контролов.
// Начат      : 22.03.2007
// Версия     : $Id: nscArrangeGridCell.pas,v 1.20 2013/12/25 15:10:31 lulin Exp $

(*-------------------------------------------------------------------------------
  $Log: nscArrangeGridCell.pas,v $
  Revision 1.20  2013/12/25 15:10:31  lulin
  {RequestLink:509706011}
  - перетрясаем модель.

  Revision 1.19  2013/10/28 08:19:43  morozov
  {RequestLink: 494505726}

  Revision 1.18  2013/04/26 16:21:32  lulin
  - правим под XE3.

  Revision 1.17  2013/04/24 09:35:37  lulin
  - портируем.

  Revision 1.16  2012/06/30 10:21:21  kostitsin
  [$371645804]

  Revision 1.15  2012/02/13 14:12:22  kostitsin
  [$336665276]

  Revision 1.14  2009/11/17 10:34:39  oman
  - fix: {RequestLink:171967027}

  Revision 1.13  2009/10/06 09:25:33  lulin
  - bug fix: не собиралось.

  Revision 1.12  2009/10/05 18:41:54  lulin
  {RequestLink:162596818}. Первые штрихи.

  Revision 1.11  2007/11/07 07:59:25  mmorozov
  - bugfix: учитываем режим переноса строк при расчете полной ширины (CQ: OIT5-27301);

  Revision 1.10  2007/10/30 12:36:29  mmorozov
  В рамках работы над CQ: OIT5-27189:
  - TvtHideField теперь компонент с фокусом ввода;
  - Подключаем TvtHideField к обработке ввода с клавиатуры;
  - Подключаем TvtHideField к таблице перехода фокуса;

  Revision 1.9  2007/10/24 11:41:16  mmorozov
  - new: поддержка межстрочного интервала (voShowInterRowSpace) для элементов дерева с фиксированной высотой (CQ: OIT5-25021);

  Revision 1.8  2007/09/04 11:40:50  mmorozov
  - new: при изменении видимости полос прокрутки у дерева, перестариваем сетку контролов (CQ: OIT5-25030);

  Revision 1.7  2007/08/23 13:29:23  mmorozov
  - bugfix: перестраиваем таблицу при изменении количества элементов в дереве (CQ: OIT5-);

  Revision 1.6  2007/08/22 12:01:53  mmorozov
  - add comment;

  Revision 1.5  2007/08/22 11:59:05  mmorozov
  - bugfix: при изменении рамера ячейки (высоты, ширины) пересчитываем размеры необходимые для полного показа  деревьев и при необходимости перестраиваем таблицу (CQ: OIT5-26237);

  Revision 1.4  2007/06/06 07:52:34  mmorozov
  - change: убран лишний вызов установки контрола, он будет присвоен в родительском конструкторе;

  Revision 1.3  2007/04/03 11:17:44  mmorozov
  - new behaviour: пересчитываем размер ячейки при изменении иконок дерева;

  Revision 1.2  2007/03/23 12:56:11  mmorozov
  - в рамках работы над представлением панели задач, представление обновляет своё содержимое при изменении данных;

  Revision 1.1  2007/03/22 12:13:02  mmorozov
  - change: ячейка сетки контролов в виде скрываемого поля с деревом перенесена в общее место;

-------------------------------------------------------------------------------*)

interface

uses
  Classes,
  Controls,
  Windows,
  ImgList,

  l3TreeInterfaces,
  l3Base,
  l3ProtoObject,

  vtLister,
  vtOutliner,
  vtHideField,

  nscInterfaces,
  nscArrangeGrid
  ;

type
  TagBaseCell = class(Tl3ProtoObject, IagBaseCell)
  private
  // fields
    f_MinHeight   : Integer;
    f_FullHeight  : Integer;
    f_MinWidth    : Integer;
    f_FullWidth   : Integer;
    f_StartRow    : Integer;
    f_EndRow      : Integer;
    f_StartColumn : Integer;
    f_EndColumn   : Integer;
    f_LastSize    : TSize;
  protected
  // IagBaseCell
    function pm_GetMinWidth: Integer;
      virtual;
      {-}
    procedure pm_SetMinWidth(const aValue: Integer);
      {* - минимальная ширина, до которой можно уменьшать компонент. }
    function pm_GetFullWidth: Integer;
      virtual;
      {-}
    procedure pm_SetFullWidth(const aValue: Integer);
      {* - ширина, при которой компонент будет показан полностью. }
    function pm_GetMinHeight: Integer;
      virtual;
      {-}
    procedure pm_SetMinHeight(const aValue: Integer);
      {* - минимальная высота, до которой можно уменьшать компонент. }
    function pm_GetFullHeight: Integer;
      virtual;
      {-}
    procedure pm_SetFullHeight(const aValue: Integer);
      {* - высота, при которой компонент будет показан полностью. }
    function pm_GetStartColumn: IagColumn;
    procedure pm_SetStartColumn(const Value: IagColumn);
      {-}
    function pm_GetEndColumn: IagColumn;
    procedure pm_SetEndColumn(const Value: IagColumn);
      {-}
    function pm_GetStartRow: IagRow;
    procedure pm_SetStartRow(const Value: IagRow);
      {-}
    function pm_GetEndRow: IagRow;
    procedure pm_SetEndRow(const Value: IagRow);
      {-}
    procedure Constraints(const aMinWidth   : Integer;
                          const aFullWidth  : Integer;
                          const aMinHeight  : Integer;
                          const aFullHeight : Integer);
      {* - ограничения на размер ячейки. }
    procedure ArrangeContent;
      virtual;
      {* - разместить содержимое ячейки. }
    procedure Attached;
      virtual;
      {* - вызывается при присоединении ячейки к таблице. }
    procedure BoundsChanged;
      virtual;
      {* - изменился размер ячейки. }
    procedure RecalcConstraints;
      virtual;
      {* - пересчитать ограничения ячейки. }
    function TwoStageBuild: Boolean;
      virtual;
      {-}
  protected
  // property methods
    function pm_GetBounds: TRect;
      {-}
    function pm_GetIsAttached: Boolean;
      {* - пристыкована ли ячейка к таблице. }
  protected
  // properties
    property MinWidth: Integer
      read pm_GetMinWidth
      write pm_SetMinWidth;
      {* - минимальная ширина, до которой можно уменьшать компонент. }
    property FullWidth: Integer
      read pm_GetFullWidth
      write pm_SetFullWidth;
      {* - ширина, при которой компонент будет показан полностью. }
    property MinHeight: Integer
      read pm_GetMinHeight
      write pm_SetMinHeight;
      {* - минимальная высота, до которой можно уменьшать компонент. }
    property FullHeight: Integer
      read pm_GetFullHeight
      write pm_SetFullHeight;
      {* - высота, при которой компонент будет показан полностью. }
    property StartColumn: IagColumn
      read pm_GetStartColumn
      write pm_SetStartColumn;
      {-}
    property EndColumn: IagColumn
      read pm_GetEndColumn
      write pm_SetEndColumn;
      {-}
    property StartRow: IagRow
      read pm_GetStartRow
      write pm_SetStartRow;
      {-}
    property EndRow: IagRow
      read pm_GetEndRow
      write pm_SetEndRow;
      {-}
    property Bounds: TRect
      read pm_GetBounds;
      {-}
    property IsAttached: Boolean
      read pm_GetIsAttached;
      {* - пристыкована ли ячейка к таблице. }
    property LastSize: TSize
      read f_LastSize
      write f_LastSize;
      {-}
  public
  // methods
    constructor Create;
      reintroduce;
      {-}
    class function Make: IagBaseCell;
      {-}
  end;//TagBaseCell

  TagControlCell = class(TagBaseCell,
                         IagControlCell)
  {* Ячейка содержащая компонент. }
  private
  // fields
    f_Control: TControl;
  protected
  // methods
    function pm_GetControl: TControl;
    procedure pm_SetControl(const aValue: TControl);
      virtual;
      {* - компонент ячейки. }
    procedure ArrangeContent;
      override;
      {* - разместить содержимое ячейки. }
    procedure Cleanup;
      override;
      {-}
  protected
  // methods
    property Control: TControl
      read pm_GetControl
      write pm_SetControl;
      {* - компонент ячейки. }
  public
  // methods
    constructor Create(aControl: TControl);
      reintroduce;
      virtual;
      {-}
    class function Make(aControl: TControl): IagControlCell;
      {-}
  end;//TagControlCell

  TnscHideFieldCell = class(TagControlCell)
  {* Ячейка сетки контролов с компонентом HideField содержащим Outliner. }
  private
  // field
    f_SizeByContent                 : Boolean;
    f_SaveStateChanged              : TNotifyEvent;
    f_SaveTreeChanged               : TvtTreeChangedEvent;
    f_SaveTreeVScrollVisibleChanged : TNotifyEvent;
    f_SaveTreeCountChanged          : TCountChanged;
    f_ChangeLink                    : TChangeLink;
  private
  // property methods
    function pm_GetTree: TvtCustomLister;
      {-}
    function pm_GetHideField: TvtHideField;
      {-}
    function pm_GetChangeLink: TChangeLink;
      {-}
  private
  // methods
    function CalcFullHeight: Integer;
      {-}
    function CalcFullWidth: Integer;
      {-}
  private
  // events
    procedure StateChanged(Sender: TObject);
      {-}
    procedure TreeVScrollVisibleChanged(Sender: TObject);
      {-}
    procedure TreeNeedRecalcConstaints(Sender: TObject);
      {-}
    procedure TreeChanged(aSender         : TObject;
                          const anOldTree : Il3SimpleTree;
                          const aNewTree  : Il3SimpleTree);
      {-}
    procedure ImageListChanged(aSender: TObject);
      {-}
    procedure TreeCountChanged(Sender : TObject; NewCount : LongInt);
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    procedure Attached;
      override;
      {* - вызывается при присоединении ячейки к таблице. }
    procedure BoundsChanged;
      override;
      {* - изменился размер ячейки. }
    procedure RecalcConstraints;
      override;
      {* - пересчитать ограничения ячейки. }
    procedure pm_SetControl(const aValue: TControl);
      override;
      {* - компонент ячейки. }
    function TwoStageBuild: Boolean;
      override;
      {-}
  protected
  // properties
    property Tree: TvtCustomLister
      read pm_GetTree;
      {-}
    property HideField: TvtHideField
      read pm_GetHideField;
      {-}
    property ChangeLink: TChangeLink
      read pm_GetChangeLink;
      {-}
    property SizeByContent: Boolean
      read f_SizeByContent
      write f_SizeByContent;
      {-}
  public
  // methods
    constructor Create(aHideField     : TvtHideField;
                       aSizeByContent : Boolean = False);
      reintroduce;
      {-}
    class function Make(aHideField     : TvtHideField;
                        aSizeByContent : Boolean = False): IagControlCell;
      {-}
  end;//TnscHideFieldCell

implementation

uses
  SysUtils
  , Types;

const
  c_MinControlHeight = 30;
    // - минимальная высота для размещения компонента в сетке контролов;

{ TnscHideFieldCell }

constructor TnscHideFieldCell.Create(aHideField     : TvtHideField;
                                    aSizeByContent : Boolean = False);
begin
 inherited Create(aHideField);
 SizeByContent := aSizeByContent;
end;

function TnscHideFieldCell.CalcFullHeight: Integer;
var
 l_Height : Integer;
begin
 l_Height := 0;
 // Высота дерева, списка
 with HideField do
 begin
  if Assigned(ClientControl) and (ClientControl is TvtCustomLister) then
   l_Height := TvtCustomLister(ClientControl).CalcFullHeight;
  // Полная высота
  Result := HeaderHeight + l_Height + AfterClientSpace;
 end;//with f_HideField do
end;//CalcFullHeight

function TnscHideFieldCell.CalcFullWidth: Integer;
begin
 with HideField do
  if SizeByContent and (ClientControl is TvtCustomLister) and
    not TvtCustomLister(ClientControl).MultiStrokeItem then
   Result :=  ClientIndent + TvtCustomLister(ClientControl).CalcFullWidth
  else
   Result := FullWidth;
end;//CalcFullWidth

procedure TnscHideFieldCell.BoundsChanged;
  //override;
  {* - изменился размер ячейки. }
begin
 inherited;
 // При изменении рамера ячейки (высоты, ширины) пересчитываем размеры
 // необходимые для полного показа  деревьев и при необходимости перестраиваем
 // таблицу:
 RecalcConstraints;
end;//BoundsChanged

procedure TnscHideFieldCell.Attached;
  //override;
  {* - вызывается при присоединении ячейки к таблице. }
begin
 inherited;
 RecalcConstraints;
end;//Attached

class function TnscHideFieldCell.Make(aHideField     : TvtHideField;
                                     aSizeByContent : Boolean = False): IagControlCell;
var
 l_Class: TnscHideFieldCell;
begin
 l_Class := Create(aHideField, aSizeByContent);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

procedure TnscHideFieldCell.ImageListChanged(aSender: TObject);
  {-}
begin
 RecalcConstraints;
end;//ImageListChanged

procedure TnscHideFieldCell.TreeCountChanged(Sender : TObject; NewCount : LongInt);
  {-}
begin
 if Assigned(f_SaveTreeCountChanged) then
  f_SaveTreeCountChanged(Sender, NewCount);
 RecalcConstraints;
end;//TreeCountChanged

procedure TnscHideFieldCell.TreeVScrollVisibleChanged(Sender: TObject);
begin
 if Assigned(f_SaveTreeVScrollVisibleChanged) then
  f_SaveTreeVScrollVisibleChanged(Sender);
 RecalcConstraints;
end;//TreeVScrollVisibleChanged

procedure TnscHideFieldCell.TreeNeedRecalcConstaints(Sender: TObject);
begin
 RecalcConstraints;
end;//TreeNeedRecalcConstraints

procedure TnscHideFieldCell.TreeChanged(aSender         : TObject;
                                       const anOldTree : Il3SimpleTree;
                                       const aNewTree  : Il3SimpleTree);
  {-}
begin
 if Assigned(f_SaveTreeChanged) then
  f_SaveTreeChanged(aSender, anOldTree, aNewTree);
 RecalcConstraints;
end;//TreeChanged

procedure TnscHideFieldCell.StateChanged(Sender: TObject);
begin
 if @f_SaveStateChanged <> nil then
  f_SaveStateChanged(Sender);
 RecalcConstraints;
 ArrangeContent;
end;//StateChanged

procedure TnscHideFieldCell.Cleanup;
begin
 FreeAndNil(f_ChangeLink);
 inherited;
end;//Cleanup

procedure TnscHideFieldCell.pm_SetControl(const aValue: TControl);
  //override;
  {* - компонент ячейки. }
begin
 if HideField <> nil then
 begin
  HideField.OnStateChanged := f_SaveStateChanged;
  f_SaveStateChanged := nil;
 end;//if HideField <> nil then
 if Tree <> nil then
 begin
  with Tree do
  begin
   OnCountChanged := f_SaveTreeCountChanged;
   f_SaveTreeCountChanged := nil;
   OnVScrollVisibleChanged := f_SaveTreeVScrollVisibleChanged;
   f_SaveTreeVScrollVisibleChanged := nil;
   if (f_ChangeLink <> nil) then
   // - мы ничего не регистрировали - значит нечего и разрегистрировать
    if (Images <> nil) then
     Images.UnRegisterChanges(ChangeLink);
  end;
  if Tree is TvtCustomOutliner then
   with TvtCustomOutliner(Tree) do
   begin
    OnTreeChanged := f_SaveTreeChanged;
    f_SaveTreeChanged := nil;
   end;//with Tree do
 end;
 inherited;
 if Tree <> nil then
 begin
  with Tree do
  begin
   f_SaveTreeCountChanged := OnCountChanged;
   OnCountChanged := Self.TreeCountChanged;
   f_SaveTreeVScrollVisibleChanged := OnVScrollVisibleChanged;
   OnVScrollVisibleChanged := Self.TreeVScrollVisibleChanged;
   OnNeedRecalcConstraints := Self.TreeNeedRecalcConstaints;
   if Images <> nil then
    Images.RegisterChanges(ChangeLink);
  end;//with TvtCustomLister(Tree) do
  if Tree is TvtCustomOutliner then
   with TvtCustomOutliner(Tree) do
   begin
    f_SaveTreeChanged := OnTreeChanged;
    OnTreeChanged := Self.TreeChanged;
   end;//with Tree do
 end;
 if HideField <> nil then
 begin
  f_SaveStateChanged := HideField.OnStateChanged;
  HideField.OnStateChanged := StateChanged;
 end;//if HideField <> nil then
end;//pm_SetControl

procedure TnscHideFieldCell.RecalcConstraints;
var
 l_MinHeight  : Integer;
 l_FullHeight : Integer;
 l_MinWidth   : Integer;
 l_FullWidth  : Integer;
begin
 inherited;
 // FixedHeight:
 if HideField.State = hfsHide then
  StartRow.FixedHeight := HideField.HeaderHeight
 else
 begin
  StartRow.FixedHeight := 0;
  // Height:
  l_FullHeight := CalcFullHeight;
  if l_FullHeight = 0 then
   l_FullHeight := FullHeight;
  if SizeByContent then
   l_MinHeight := l_FullHeight
  else
   l_MinHeight := HideField.HeaderHeight + c_MinControlHeight;
  // Width:
  l_FullWidth := CalcFullWidth;
  if l_FullWidth = 0 then
   l_FullWidth := FullWidth;
  if SizeByContent (*and (Tree <> nil) and (not Tree.MultiStrokeItem)*) then
   l_MinWidth := l_FullWidth
  else
   l_MinWidth := MinWidth;
  // Init:
  Constraints(l_MinWidth, l_FullWidth, l_MinHeight, l_FullHeight);
 end;//if HideField.State = hfsHide then
end;//RecalcConstraints

function TnscHideFieldCell.pm_GetHideField: TvtHideField;
  {-}
begin
 Result := TvtHideField(Control);
end;//pm_GetHideField

function TnscHideFieldCell.pm_GetTree: TvtCustomLister;
begin
 if HideField <> nil then
  with HideField do
   if ClientControl is TvtCustomLister then
   begin
    Result:= TvtCustomLister(ClientControl);
    Exit;
   end;//if (ClientControl <> nil)...
 Result := nil;
end;//pm_GetTree

function TnscHideFieldCell.pm_GetChangeLink: TChangeLink;
begin
 if (f_ChangeLink = nil) then
 begin
  f_ChangeLink := TChangeLink.Create;
  f_ChangeLink.OnChange := ImageListChanged;
 end;//if f_ChangeLink <> nil then
 Result := f_ChangeLink;
end;//pm_GetChangeLink

function TnscHideFieldCell.TwoStageBuild: Boolean;
begin
 with HideField do
  Result := SizeByContent and Assigned(ClientControl) and (ClientControl is TvtCustomLister);
end;

{ TagControlCell }

procedure TagControlCell.ArrangeContent;
begin
 with Bounds do
  f_Control.SetBounds(Left, Top, Right - Left, Bottom - Top);
 inherited;
end;//ArrangeContent

constructor TagControlCell.Create(aControl: TControl);
  // reintroduce;
  {-}
begin
 inherited Create;
 Control := aControl;
end;//Create

class function TagControlCell.Make(aControl: TControl): IagControlCell;
  {-}
var
 l_Class: TagControlCell;
begin
 l_Class := Create(aControl);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

procedure TagControlCell.Cleanup;
  //override;
  {-}
begin
 Control := nil;
 inherited;
end;

function TagControlCell.pm_GetControl: TControl;
begin
 Result := f_Control;
end;//pm_GetControl

procedure TagControlCell.pm_SetControl(const aValue: TControl);
begin
 f_Control := aValue;
 if aValue <> nil then
  aValue.Align := alNone;
end;//pm_GetFullHeight

{ TagBaseCell }

constructor TagBaseCell.Create;
  // reintroduce;
  {-}
begin
 inherited Create;
 MinWidth := c_agMinWidth;
 FullWidth := c_agFullWidth;
 MinHeight := c_agMinHeight;
 FullHeight := c_agFullHeight;
end;//Create

class function TagBaseCell.Make: IagBaseCell;
  {-}
var
 l_Class: TagBaseCell;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TagBaseCell.pm_GetFullWidth: Integer;
begin
 Result := f_FullWidth;
end;//pm_GetFullWidth

function TagBaseCell.pm_GetMinHeight: Integer;
begin
 Result := f_MinHeight;
end;//pm_GetMinHeight

function TagBaseCell.pm_GetMinWidth: Integer;
begin
 Result := f_MinWidth;
end;//pm_GetMinWidth

procedure TagBaseCell.pm_SetFullHeight(const aValue: Integer);
begin
 f_FullHeight := aValue;
end;//pm_SetFullHeight

procedure TagBaseCell.pm_SetFullWidth(const aValue: Integer);
begin
 f_FullWidth := aValue;
end;//pm_SetFullWidth

procedure TagBaseCell.pm_SetMinHeight(const aValue: Integer);
begin
 f_MinHeight := aValue;
end;//pm_SetMinHeight

procedure TagBaseCell.pm_SetMinWidth(const aValue: Integer);
begin
 f_MinWidth := aValue;
end;//pm_SetMinWidth

function TagBaseCell.pm_GetEndColumn: IagColumn;
begin
 Result := IagColumn(f_EndColumn);
end;//pm_GetEndColumn

function TagBaseCell.pm_GetEndRow: IagRow;
begin
 Result := IagRow(f_EndRow);
end;//pm_GetEndRow

function TagBaseCell.pm_GetStartColumn: IagColumn;
begin
 Result := IagColumn(f_StartColumn);
end;//pm_GetStartColumn

function TagBaseCell.pm_GetStartRow: IagRow;
begin
 Result := IagRow(f_StartRow);
end;//pm_GetStartRow

procedure TagBaseCell.pm_SetEndColumn(const Value: IagColumn);
begin
 f_EndColumn := Integer(Value);
end;//pm_SetEndColumn

procedure TagBaseCell.pm_SetEndRow(const Value: IagRow);
begin
 f_EndRow := Integer(Value);
end;//pm_SetEndRow

procedure TagBaseCell.pm_SetStartColumn(const Value: IagColumn);
begin
 f_StartColumn := Integer(Value);
end;//pm_SetStartColumn

procedure TagBaseCell.pm_SetStartRow(const Value: IagRow);
begin
 f_StartRow := Integer(Value);
end;//pm_SetStartRow

function TagBaseCell.pm_GetFullHeight: Integer;
begin
 Result := f_FullHeight;
end;//pm_GetFullHeight

procedure TagBaseCell.Constraints(const aMinWidth   : Integer;
                                  const aFullWidth  : Integer;
                                  const aMinHeight  : Integer;
                                  const aFullHeight : Integer);
  {-}
begin
 if (MinWidth <> aMinWidth) or (FullWidth <> aFullWidth) or
  (MinHeight <> aMinHeight) or (FullHeight <> aFullHeight) then
 begin
  MinWidth := aMinWidth;
  FullWidth := aFullWidth;
  MinHeight := aMinHeight;
  FullHeight := aFullHeight;
  if IsAttached then
  begin
   StartRow.CellChanged;
   if StartRow <> EndRow then
    EndRow.CellChanged;
   StartColumn.CellChanged;
   if StartColumn <> EndColumn then
    EndColumn.CellChanged;
  end;//if IsAttached then
 end;//if (MinWidth = aMinWidth)
end;//Constraints

procedure TagBaseCell.RecalcConstraints;
  //virtual;
  {* - пересчитать ограничения ячейки. }
begin

end;//Recalc

procedure TagBaseCell.BoundsChanged;
  //virtual;
  {* - изменился размер ячейки. }
begin

end;//BoundsChanged

procedure TagBaseCell.Attached;
  {* - вызывается при присоединении ячейки к таблице. }
begin

end;//Attached

procedure TagBaseCell.ArrangeContent;

 function lp_HeightChanged: Boolean;
 begin
  with Bounds do
   Result := LastSize.cy <> (Bottom - Top);
 end;//lp_HeightChanged

 function lp_WidthChanged: Boolean;
 begin
  with Bounds do
   Result := LastSize.cx <> (Right - Left);
 end;//lp_WidthChanged

var
 l_LS : TSize;
begin
 if ((LastSize.cx <> 0) and (LastSize.cy <> 0)) and
   (lp_HeightChanged or lp_WidthChanged) then
  BoundsChanged;
 with Bounds do
 begin
  l_LS.cx := Right - Left;
  l_LS.cy := Bottom - Top;
 end;//with Bounds do
 LastSize := l_LS;
end;//ArrangeContent

function TagBaseCell.pm_GetIsAttached: Boolean;
  {* - пристыкована ли ячейка к таблице. }
begin
 Result := (StartRow <> nil) and (EndRow <> nil) and
  (StartColumn <> nil) and (EndColumn <> nil);
end;//pm_GetIsAttached

function TagBaseCell.pm_GetBounds: TRect;
begin
 Result := Rect(StartColumn.Left, StartRow.Top, EndColumn.Right, EndRow.Bottom);
end;//pm_GetBounds

function TagBaseCell.TwoStageBuild: Boolean;
begin
 Result := False;
end;

end.
