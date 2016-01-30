{$IfNDef nevTableRowBaseLineCommon_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevTableRowBaseLineCommon.imp.pas"
// Стереотип: "Impurity"

{$Define nevTableRowBaseLineCommon_imp}

{$If Defined(evUseVisibleCursors)}
 {$Include nevPrimPoint.imp.pas}
 _nevTableRowBaseLineCommon_ = class(_nevPrimPoint_, InevPoint, InevBasePoint)
  {* Общие методы для базовых линий }
  private
   f_TopCellsWasInit: Boolean;
    {* Флаг инициализации массивов точек для объединенных ячеек/ }
   f_HasMergedCell: Boolean;
   f_Children: TnevBasePointList;
    {* Массив точек для обычных ячеек. }
   f_TopCells: TnevBasePointList;
    {* Кешированные значения начал объединенных ячеек. }
   f_HeadCells: TnevBasePointList;
    {* Список точек объединенных ячеек, продолжающихся в текущей строке. }
  private
   function GetCurrentPostion(const aView: InevView;
    aTableFI: TnevFormatInfoPrim;
    const anObject: InevObject): InevBasePoint;
    {* Инициализация точки для продолжения ячейки в f_HeadCellList }
  protected
   procedure InitHeadCells(const aView: InevView);
    {* Инициализирует точки с объединенными ячейками для текущей строки. }
   function SimpleMode: Boolean; virtual; abstract;
   function GetInner4SimpleMode: InevBasePoint; virtual; abstract;
   function IsAnchor: Boolean; virtual;
   function InternalClonePoint(const aView: InevView;
    const aPoint: InevBasePoint): InevBasePoint;
   procedure DoSetInner(const aValue: InevBasePoint); virtual;
   procedure DoBottom(const aView: InevView); virtual;
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aByLine: Boolean): Integer; virtual;
   procedure DoMergeTo(const aView: InevView;
    const aBaseLine: InevBasePoint); virtual;
   function DoInnerTop(const aChild: InevObject): InevBasePoint; virtual;
   procedure DoAddInner(const aView: InevView;
    const anInner: InevBaseLine4Anchor;
    anIndex: Integer;
    var aFirst: Boolean;
    aMode: TnevAddInnerMode); virtual;
   procedure DoCompareWithOtherInner(const aView: InevView;
    anMaxID: Integer = -1); virtual;
   procedure DoInitBaseLineInner(const aView: InevView;
    const anItem: InevPara); virtual;
   procedure DoInitByCursor(const aView: InevView;
    const anInnerPoint: InevBasePoint); virtual;
   procedure DoCopyHeadParts(const aFrom: InevBasePoint); virtual;
   procedure DoAddHeadInner(const aHeadInner: InevBasePoint); virtual;
   function DoHasHeadPart: Boolean; virtual;
   function DoInnerHead(aPID: Integer): InevBasePoint; virtual;
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; virtual; abstract;
   function CheckMaxID(aMaxID: Integer): InevBasePoint; virtual; abstract;
   function Range: InevRange;
   function pm_GetFormatting: InevDataFormatting;
   function VertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex;
   function NeedWindowsCaret: Boolean;
   function ClonePoint(const aView: InevView): InevBasePoint;
   function DeltaX(const aView: InevView;
    const aMap: InevMap): Integer;
   function pm_GetInner: InevBasePoint;
   procedure pm_SetInner(const aValue: InevBasePoint);
   function Get_Position: TnevPosition;
   function InnerFor(const aChild: InevObject;
    var aRealTop: InevBasePoint): InevBasePoint;
   function pm_GetAfterEnd: Boolean;
   function Get_AsLeaf: InevLeafPoint;
   function Get_LinkedPoint: InevLinkedPoint;
   function AtEnd(const aView: InevView): Boolean;
   function AtStart: Boolean;
   function pm_GetText: InevText;
   function Get_HasInner: Boolean;
   function Get_ShowCollapsed: Boolean;
   procedure Set_ShowCollapsed(aValue: Boolean);
   function Compare(const aPoint: InevBasePoint): Integer;
   procedure CheckPos(const anOp: InevOp);
    {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
   function ReadOnly: Boolean;
   function AsPoint: InevBasePoint;
   function AsCursor(const aView: InevView): InevPoint;
   {$If Defined(evNeedMarkers)}
   function Get_MarkersSource: IevMarkersSource;
   {$IfEnd} // Defined(evNeedMarkers)
   function ProcessMessage(const aView: InevControlView;
    var aMessage: TMessage;
    aTime: Cardinal): Boolean;
   function Get_Listener: InevPointListener;
   function GetBlockLength: Integer;
   procedure MergeTo(const aView: InevView;
    const aBaseLine: InevBasePoint);
    {* Объединяем значения отрисованных частей. }
   function InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
    aForDrawing: TnevInnerType): InevBasePoint;
    {* Получаем первый параграф, по которому можно получить вложенную точку. }
   function HasBaseLine: Boolean;
    {* Проверяет есть ли возможность работы с базовой линией на точке }
   procedure AddInner(const aView: InevView;
    const anInner: InevBaseLine4Anchor;
    anIndex: Integer;
    var aFirst: Boolean;
    aMode: TnevAddInnerMode);
   procedure CompareWithOtherInner(const aView: InevView;
    anMaxID: Integer = -1);
    {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
   function InnerHead(aPID: Integer): InevBasePoint;
    {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
   function HasHeadPart: Boolean;
    {* Строка содержит продолжение объединенных ячеек. }
   procedure AddHeadInner(const aHeadInner: InevBasePoint);
    {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
   procedure CopyHeadParts(const aFrom: InevBasePoint);
    {* Копирует только части продолжений ячеек, если они есть. }
   procedure InitByCursor(const aView: InevView;
    const anInnerPoint: InevBasePoint);
    {* Инициализируем базовую линию по курсору. }
   procedure InitBaseLineInner(const aView: InevView;
    const anItem: InevPara);
   function InnerTop(const aChild: InevObject): InevBasePoint;
    {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
   function pm_GetBeforeStart: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aRow: Tl3Variant); reintroduce; virtual;
   procedure AssignPoint(const aView: InevView;
    const aPoint: InevBasePoint);
   procedure Bottom(const aView: InevView);
   function IncLine(const aView: InevView;
    var theLine: Integer;
    aByLine: Boolean): Integer;
    {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
   function Diff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer;
    {* сравнивает курсор с "якорем" по вертикали. }
   procedure DisableListener;
    {* Отключает нотификацию об изменении }
   procedure EnableListener;
    {* Включает нотификацию об изменении }
   function PartiallyVisible(const aView: InevView;
    const aPoint: InevBasePoint;
    const aMap: TnevFormatInfoPrim): Boolean;
    {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
   procedure CorrectMoveRight(const aView: InevView;
    const aPoint: InevBasePoint;
    const anOp: InevOp);
 end;//_nevTableRowBaseLineCommon_

{$Else Defined(evUseVisibleCursors)}

{$Include nevPrimPoint.imp.pas}
_nevTableRowBaseLineCommon_ = _nevPrimPoint_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevTableRowBaseLineCommon_imp}

{$IfNDef nevTableRowBaseLineCommon_imp_impl}

{$Define nevTableRowBaseLineCommon_imp_impl}

{$If Defined(evUseVisibleCursors)}
type _Instance_R_ = _nevTableRowBaseLineCommon_;

{$Include nevPrimPoint.imp.pas}

procedure _nevTableRowBaseLineCommon_.InitHeadCells(const aView: InevView);
 {* Инициализирует точки с объединенными ячейками для текущей строки. }
//#UC START# *4DDC9289019A_4DD77B7C0163_var*
var
 i       : Integer;
 l_TblFI : TnevFormatInfoPrim;
 l_Point : InevBasePoint;
//#UC END# *4DDC9289019A_4DD77B7C0163_var*
begin
//#UC START# *4DDC9289019A_4DD77B7C0163_impl*
 if f_TopCellsWasInit then Exit;
 if f_HasMergedCell then // Нечего гонять цикл по-напрасну
 begin
  if (f_HeadCells.Count < f_Children.Count) then
  begin
   f_HeadCells.Count := f_Children.Count;
   f_TopCells.Count := f_Children.Count;
  end; // if (f_HeadCells.Count < f_Children.Count) then
  l_TblFI := nil;
  for i := 0 to f_Children.Count - 1 do
  begin
   if SimpleMode then
    l_Point := GetInner4SimpleMode
   else
    l_Point := f_Children[i];
   if (l_Point <> nil) and l_Point.AfterEnd then
   begin
    if l_TblFI = nil then
     l_TblFI := aView.FormatInfoByPara(ParaX.OwnerPara);
    l_Point := GetCurrentPostion(aView, l_TblFI, l_Point.Obj^);
    f_HeadCells[i] := l_Point;
    if l_Point = nil then
     f_TopCells[i] := nil
    else
     f_TopCells[i] := InternalClonePoint(aView, l_Point);
   end; // if l_Point.AfterEnd then
   if SimpleMode then Break;
  end; // for i := 0 to f_Children.Count - 1 do
  f_TopCellsWasInit := True;
 end // if f_HasMergedCell then
 else
  f_TopCellsWasInit := True;
//#UC END# *4DDC9289019A_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InitHeadCells

function _nevTableRowBaseLineCommon_.GetCurrentPostion(const aView: InevView;
 aTableFI: TnevFormatInfoPrim;
 const anObject: InevObject): InevBasePoint;
 {* Инициализация точки для продолжения ячейки в f_HeadCellList }
//#UC START# *4DDC92F301BC_4DD77B7C0163_var*
var
 l_Delta     : Integer;
 l_RowPara   : InevParaList;
 l_TableCell : InevTableCell;

 procedure lp_GetIncDelta;
 begin
  l_RowPara := l_TableCell.OwnerObj.AsPara.AsList;
  l_Delta := aTableFI.InfoForChild(l_RowPara).MaxLinesCount + 1;
 end;

//#UC END# *4DDC92F301BC_4DD77B7C0163_var*
begin
//#UC START# *4DDC92F301BC_4DD77B7C0163_impl*
 Result := nil;
 if evCheckSingleContinueCell(ParaX) then Exit;
 if TevMergeStatus(anObject.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue then
 begin
  anObject.AsObject.QT(InevTableCell, l_TableCell);
  l_TableCell := l_TableCell.GetMergeHead;
  if l_TableCell = nil then Exit;
  Result := l_TableCell.MakePoint;
  Result.SetEntryPoint(1);
  lp_GetIncDelta;
  while not l_RowPara.AsObject.IsSame(ParaX.AsObject) do
  begin
   Result.IncLine(aView, l_Delta, True);
   if l_Delta > 0 then
   begin
    Result := nil;
    Break; // Не нашли...
   end; // if l_Delta > 0 then
   l_TableCell := l_TableCell.GetContinueCell(True, fc_Down);
   if l_TableCell = nil then Break;
   lp_GetIncDelta;
  end; // while not l_RowAnchor.IsSame(Self.Target) do
 end; // if aPoint.AfterEnd and (TevMergeStatus(aPoint.IntA[k2_tiMergeStatus]) = ev_msContinue) then
//#UC END# *4DDC92F301BC_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.GetCurrentPostion

function _nevTableRowBaseLineCommon_.IsAnchor: Boolean;
//#UC START# *533BC81B002F_4DD77B7C0163_var*
//#UC END# *533BC81B002F_4DD77B7C0163_var*
begin
//#UC START# *533BC81B002F_4DD77B7C0163_impl*
 Result := False;
//#UC END# *533BC81B002F_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.IsAnchor

function _nevTableRowBaseLineCommon_.InternalClonePoint(const aView: InevView;
 const aPoint: InevBasePoint): InevBasePoint;
//#UC START# *533BC8C20205_4DD77B7C0163_var*
//#UC END# *533BC8C20205_4DD77B7C0163_var*
begin
//#UC START# *533BC8C20205_4DD77B7C0163_impl*
 if IsAnchor then
 begin
  if aPoint.AfterEnd or aPoint.BeforeStart then
   Result := aPoint.ClonePoint(aView)
  else
  begin
   Result := aPoint.Obj.MakeAnchor;
   Result.AssignPoint(aView, aPoint);
  end;
 end // if IsAnchor then
 else
  Result := aPoint.ClonePoint(aView)
//#UC END# *533BC8C20205_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InternalClonePoint

constructor _nevTableRowBaseLineCommon_.Create(aRow: Tl3Variant);
//#UC START# *4DD77FE302CB_4DD77B7C0163_var*
//#UC END# *4DD77FE302CB_4DD77B7C0163_var*
begin
//#UC START# *4DD77FE302CB_4DD77B7C0163_impl*
 inherited Create(aRow);
 f_Children := TnevBasePointList.Make;
 f_HeadCells := TnevBasePointList.Make;
 f_TopCells  := TnevBasePointList.Make;
 f_TopCellsWasInit := False;
 f_HasMergedCell := False;
//#UC END# *4DD77FE302CB_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.Create

procedure _nevTableRowBaseLineCommon_.DoSetInner(const aValue: InevBasePoint);
//#UC START# *4DD795FA0114_4DD77B7C0163_var*
//#UC END# *4DD795FA0114_4DD77B7C0163_var*
begin
//#UC START# *4DD795FA0114_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD795FA0114_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoSetInner

procedure _nevTableRowBaseLineCommon_.DoBottom(const aView: InevView);
//#UC START# *4DD797ED02CE_4DD77B7C0163_var*
//#UC END# *4DD797ED02CE_4DD77B7C0163_var*
begin
//#UC START# *4DD797ED02CE_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD797ED02CE_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoBottom

function _nevTableRowBaseLineCommon_.DoIncLine(const aView: InevView;
 var theLine: Integer;
 aByLine: Boolean): Integer;
//#UC START# *4DD7980F03AA_4DD77B7C0163_var*
//#UC END# *4DD7980F03AA_4DD77B7C0163_var*
begin
//#UC START# *4DD7980F03AA_4DD77B7C0163_impl*
 Result := 0;
 theLine := 0;
 Assert(False);
//#UC END# *4DD7980F03AA_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoIncLine

procedure _nevTableRowBaseLineCommon_.DoMergeTo(const aView: InevView;
 const aBaseLine: InevBasePoint);
//#UC START# *4DD79C030322_4DD77B7C0163_var*
//#UC END# *4DD79C030322_4DD77B7C0163_var*
begin
//#UC START# *4DD79C030322_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD79C030322_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoMergeTo

function _nevTableRowBaseLineCommon_.DoInnerTop(const aChild: InevObject): InevBasePoint;
//#UC START# *4DD79CB2037D_4DD77B7C0163_var*
//#UC END# *4DD79CB2037D_4DD77B7C0163_var*
begin
//#UC START# *4DD79CB2037D_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD79CB2037D_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoInnerTop

procedure _nevTableRowBaseLineCommon_.DoAddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4DD79CEC0371_4DD77B7C0163_var*
//#UC END# *4DD79CEC0371_4DD77B7C0163_var*
begin
//#UC START# *4DD79CEC0371_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD79CEC0371_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoAddInner

procedure _nevTableRowBaseLineCommon_.DoCompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
//#UC START# *4DD79DA50099_4DD77B7C0163_var*
//#UC END# *4DD79DA50099_4DD77B7C0163_var*
begin
//#UC START# *4DD79DA50099_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD79DA50099_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoCompareWithOtherInner

procedure _nevTableRowBaseLineCommon_.DoInitBaseLineInner(const aView: InevView;
 const anItem: InevPara);
//#UC START# *4DD7A0490365_4DD77B7C0163_var*
//#UC END# *4DD7A0490365_4DD77B7C0163_var*
begin
//#UC START# *4DD7A0490365_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD7A0490365_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoInitBaseLineInner

procedure _nevTableRowBaseLineCommon_.DoInitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
//#UC START# *4DD7A08200F7_4DD77B7C0163_var*
//#UC END# *4DD7A08200F7_4DD77B7C0163_var*
begin
//#UC START# *4DD7A08200F7_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD7A08200F7_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoInitByCursor

procedure _nevTableRowBaseLineCommon_.DoCopyHeadParts(const aFrom: InevBasePoint);
//#UC START# *4DD7A0C30353_4DD77B7C0163_var*
//#UC END# *4DD7A0C30353_4DD77B7C0163_var*
begin
//#UC START# *4DD7A0C30353_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD7A0C30353_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoCopyHeadParts

procedure _nevTableRowBaseLineCommon_.DoAddHeadInner(const aHeadInner: InevBasePoint);
//#UC START# *4DD7A0E30148_4DD77B7C0163_var*
//#UC END# *4DD7A0E30148_4DD77B7C0163_var*
begin
//#UC START# *4DD7A0E30148_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD7A0E30148_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoAddHeadInner

function _nevTableRowBaseLineCommon_.DoHasHeadPart: Boolean;
//#UC START# *4DD7A1010342_4DD77B7C0163_var*
//#UC END# *4DD7A1010342_4DD77B7C0163_var*
begin
//#UC START# *4DD7A1010342_4DD77B7C0163_impl*
 Result := False;
 Assert(False);
//#UC END# *4DD7A1010342_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoHasHeadPart

function _nevTableRowBaseLineCommon_.DoInnerHead(aPID: Integer): InevBasePoint;
//#UC START# *4DD7A1390112_4DD77B7C0163_var*
//#UC END# *4DD7A1390112_4DD77B7C0163_var*
begin
//#UC START# *4DD7A1390112_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *4DD7A1390112_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DoInnerHead

function _nevTableRowBaseLineCommon_.Range: InevRange;
//#UC START# *47C5B55D00B4_4DD77B7C0163_var*
//#UC END# *47C5B55D00B4_4DD77B7C0163_var*
begin
//#UC START# *47C5B55D00B4_4DD77B7C0163_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C5B55D00B4_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.Range

function _nevTableRowBaseLineCommon_.pm_GetFormatting: InevDataFormatting;
//#UC START# *47C5B603039F_4DD77B7C0163get_var*
//#UC END# *47C5B603039F_4DD77B7C0163get_var*
begin
//#UC START# *47C5B603039F_4DD77B7C0163get_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C5B603039F_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.pm_GetFormatting

function _nevTableRowBaseLineCommon_.VertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *47C5B65D0195_4DD77B7C0163_var*
//#UC END# *47C5B65D0195_4DD77B7C0163_var*
begin
//#UC START# *47C5B65D0195_4DD77B7C0163_impl*
 //Result := ParaX.PID;
 Result := 0;
//#UC END# *47C5B65D0195_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.VertPosition

function _nevTableRowBaseLineCommon_.NeedWindowsCaret: Boolean;
//#UC START# *47C5B6D30128_4DD77B7C0163_var*
//#UC END# *47C5B6D30128_4DD77B7C0163_var*
begin
//#UC START# *47C5B6D30128_4DD77B7C0163_impl*
 Result := false;
 Assert(false);
//#UC END# *47C5B6D30128_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.NeedWindowsCaret

function _nevTableRowBaseLineCommon_.ClonePoint(const aView: InevView): InevBasePoint;
//#UC START# *47C5B6E503C3_4DD77B7C0163_var*
//#UC END# *47C5B6E503C3_4DD77B7C0163_var*
begin
//#UC START# *47C5B6E503C3_4DD77B7C0163_impl*
 Result := nil;
 Assert(false);
//#UC END# *47C5B6E503C3_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.ClonePoint

function _nevTableRowBaseLineCommon_.DeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *47C5B6F202A0_4DD77B7C0163_var*
//#UC END# *47C5B6F202A0_4DD77B7C0163_var*
begin
//#UC START# *47C5B6F202A0_4DD77B7C0163_impl*
 Result := 0;
 Assert(false);
//#UC END# *47C5B6F202A0_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DeltaX

function _nevTableRowBaseLineCommon_.pm_GetInner: InevBasePoint;
//#UC START# *47C5B7400152_4DD77B7C0163get_var*
//#UC END# *47C5B7400152_4DD77B7C0163get_var*
begin
//#UC START# *47C5B7400152_4DD77B7C0163get_impl*
 Result := nil;
 // - возвращаем nil, т.к. все дети равноценны и мы никому не можем отдать предпочтение
//#UC END# *47C5B7400152_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.pm_GetInner

procedure _nevTableRowBaseLineCommon_.pm_SetInner(const aValue: InevBasePoint);
//#UC START# *47C5B7400152_4DD77B7C0163set_var*
//#UC END# *47C5B7400152_4DD77B7C0163set_var*
begin
//#UC START# *47C5B7400152_4DD77B7C0163set_impl*
 DoSetInner(aValue);
//#UC END# *47C5B7400152_4DD77B7C0163set_impl*
end;//_nevTableRowBaseLineCommon_.pm_SetInner

function _nevTableRowBaseLineCommon_.Get_Position: TnevPosition;
//#UC START# *47C5B75F00AF_4DD77B7C0163get_var*
//#UC END# *47C5B75F00AF_4DD77B7C0163get_var*
begin
//#UC START# *47C5B75F00AF_4DD77B7C0163get_impl*
 Result := Succ(VertPosition(nil, nil));
//#UC END# *47C5B75F00AF_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_Position

procedure _nevTableRowBaseLineCommon_.AssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *47C5C25C022F_4DD77B7C0163_var*
var
 i           : Integer;
 l_Para      : InevPara;
 l_List      : InevParaList;
 l_Point     : InevBasePoint;
 l_TopReal   : InevBasePoint;
 l_RealPoint : InevBasePoint;
//#UC END# *47C5C25C022F_4DD77B7C0163_var*
begin
//#UC START# *47C5C25C022F_4DD77B7C0163_impl*
 f_HeadCells.Clear;
 f_Children.Clear;
 f_TopCells.Clear;
 l_List := ParaX.AsList;
 for i := 0 to l_List.ParaCount - 1 do
 begin
  l_Para := l_List.Para[i];
  l_Point := aPoint.InnerFor(l_Para, l_RealPoint);
  l_TopReal := aPoint.InnerTop(l_Para);
  if l_Point = nil then
   f_Children.Add(nil)
  else
   f_Children.Add(InternalClonePoint(aView, l_Point));
  if l_TopReal = nil then
  begin
   f_HeadCells.Add(nil);
   f_TopCells.Add(nil);
  end // if l_RealPoint = nil then
  else
  begin
   if l_RealPoint = nil then
    f_HeadCells.Add(nil)
   else
    f_HeadCells.Add(InternalClonePoint(aView, l_RealPoint));
   f_TopCells.Add(InternalClonePoint(aView, l_TopReal));
  end;
 end; // for i := 0 to l_List.ParaCount - 1 do
 f_TopCellsWasInit := True;
//#UC END# *47C5C25C022F_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AssignPoint

procedure _nevTableRowBaseLineCommon_.Bottom(const aView: InevView);
//#UC START# *47C5C2970095_4DD77B7C0163_var*
//#UC END# *47C5C2970095_4DD77B7C0163_var*
begin
//#UC START# *47C5C2970095_4DD77B7C0163_impl*
 DoBottom(aView);
//#UC END# *47C5C2970095_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.Bottom

function _nevTableRowBaseLineCommon_.IncLine(const aView: InevView;
 var theLine: Integer;
 aByLine: Boolean): Integer;
 {* сдвигает якорь на указанное число строк. Возвращает количество параграфов на которое сдвинулся якорь. }
//#UC START# *47C5C2A40309_4DD77B7C0163_var*
//#UC END# *47C5C2A40309_4DD77B7C0163_var*
begin
//#UC START# *47C5C2A40309_4DD77B7C0163_impl*
 Result := DoIncLine(aView, theLine, aByLine);
//#UC END# *47C5C2A40309_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.IncLine

function _nevTableRowBaseLineCommon_.InnerFor(const aChild: InevObject;
 var aRealTop: InevBasePoint): InevBasePoint;
//#UC START# *47F5FDA303BC_4DD77B7C0163_var*
var
 l_Index : Integer;
//#UC END# *47F5FDA303BC_4DD77B7C0163_var*
begin
//#UC START# *47F5FDA303BC_4DD77B7C0163_impl*
 l_Index := aChild.PID;
 if l_Index < f_Children.Count then
 begin
  Result := f_Children[l_Index];
  Assert((Result = nil) or (l_Index = Result.Obj.PID));
 end // if l_Index >= f_Children.Count then
 else
  Result := nil;
 if (f_HeadCells <> nil) and (l_Index < f_HeadCells.Count) then
 begin
  aRealTop := f_HeadCells[l_Index];
  if (aRealTop <> nil) and not aRealTop.AsObject.IsValid then
   aRealTop := nil;
 end // if (f_HeadCells <> nil) and (l_Index < f_HeadCells.Count) then
 else
  aRealTop := nil;
//#UC END# *47F5FDA303BC_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InnerFor

function _nevTableRowBaseLineCommon_.pm_GetAfterEnd: Boolean;
//#UC START# *47F618A90162_4DD77B7C0163get_var*
var
 l_Point : InevBasePoint;
 l_Index : Integer;
//#UC END# *47F618A90162_4DD77B7C0163get_var*
begin
//#UC START# *47F618A90162_4DD77B7C0163get_impl*
 Result := true;
 Assert(not SimpleMode);
 for l_Index := 0 to f_Children.Hi do
 begin
  l_Point := f_Children[l_Index];
  if l_Point = nil then
  begin
   Result := False;
   Break;
  end; // if l_Point = nil then
  if l_Point.Obj.NeedIncludeHeight(False) then
   if l_Point.AfterEnd then
   begin
    if (l_Index < f_HeadCells.Count) and (f_HeadCells[l_Index] <> nil) and not f_HeadCells[l_Index].AfterEnd then
    begin
     Result := false;
     Break;
    end;//not l_Point.AfterEnd
   end
   else
   begin
    Result := false;
    Break;
   end;//not f_Children[l_Index].AfterEnd
 end; // for l_Index := 0 to f_Children.Hi do
//#UC END# *47F618A90162_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.pm_GetAfterEnd

function _nevTableRowBaseLineCommon_.Get_AsLeaf: InevLeafPoint;
//#UC START# *47FB32280262_4DD77B7C0163get_var*
//#UC END# *47FB32280262_4DD77B7C0163get_var*
begin
//#UC START# *47FB32280262_4DD77B7C0163get_impl*
 Result := nil;
//#UC END# *47FB32280262_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_AsLeaf

function _nevTableRowBaseLineCommon_.Get_LinkedPoint: InevLinkedPoint;
//#UC START# *47FCC68B03B1_4DD77B7C0163get_var*
//#UC END# *47FCC68B03B1_4DD77B7C0163get_var*
begin
//#UC START# *47FCC68B03B1_4DD77B7C0163get_impl*
 Result := nil;
//#UC END# *47FCC68B03B1_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_LinkedPoint

function _nevTableRowBaseLineCommon_.AtEnd(const aView: InevView): Boolean;
//#UC START# *47FF3F1800FE_4DD77B7C0163_var*
var
 l_Point : InevBasePoint;
 l_Index : Integer;
//#UC END# *47FF3F1800FE_4DD77B7C0163_var*
begin
//#UC START# *47FF3F1800FE_4DD77B7C0163_impl*
 Result := true;
 if SimpleMode then
 begin
  l_Point := GetInner4SimpleMode;
  if (l_Point = nil) or not l_Point.AtEnd(aView) then
   Result := False;
 end // if SimpleMode then
 else
 for l_Index := 0 to f_Children.Hi do
 begin
  l_Point := f_Children[l_Index];
  if l_Point = nil then
  begin
   Result := False;
   Break;
  end // if l_Point = nil then
  else
   if l_Point.Obj.NeedIncludeHeight then
    if not l_Point.AtEnd(aView) then
    begin
     Result := false;
     Break;
    end;//not f_Children[l_Index].AtEnd
 end; // for l_Index := 0 to f_Children.Hi do
//#UC END# *47FF3F1800FE_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AtEnd

function _nevTableRowBaseLineCommon_.AtStart: Boolean;
//#UC START# *47FF414E039D_4DD77B7C0163_var*
var
 l_Point : InevBasePoint;
 l_Index : Integer;
//#UC END# *47FF414E039D_4DD77B7C0163_var*
begin
//#UC START# *47FF414E039D_4DD77B7C0163_impl*
 Result := true;
 if SimpleMode then
 begin
  l_Point := GetInner4SimpleMode;
  if (l_Point = nil) or not l_Point.AtStart then
   Result := False;
 end // if SimpleMode then
 else
  for l_Index := 0 to f_Children.Hi do
  begin
   l_Point := f_Children[l_Index];
   if (l_Point = nil) or not f_Children[l_Index].AtStart then
   begin
    Result := false;
    Break;
   end;//not f_Children[l_Index].AtStart
  end; // for l_Index := 0 to f_Children.Hi do
//#UC END# *47FF414E039D_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AtStart

function _nevTableRowBaseLineCommon_.Diff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
 {* сравнивает курсор с "якорем" по вертикали. }
//#UC START# *49DF51870234_4DD77B7C0163_var*
//#UC END# *49DF51870234_4DD77B7C0163_var*
begin
//#UC START# *49DF51870234_4DD77B7C0163_impl*
 Result := DoDiff(aView, aPoint, aMap);
//#UC END# *49DF51870234_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.Diff

function _nevTableRowBaseLineCommon_.pm_GetText: InevText;
//#UC START# *49E6FB10002A_4DD77B7C0163get_var*
//#UC END# *49E6FB10002A_4DD77B7C0163get_var*
begin
//#UC START# *49E6FB10002A_4DD77B7C0163get_impl*
 Result := nil;
 Assert(false);
//#UC END# *49E6FB10002A_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.pm_GetText

procedure _nevTableRowBaseLineCommon_.DisableListener;
 {* Отключает нотификацию об изменении }
//#UC START# *4A4C856300DF_4DD77B7C0163_var*
//#UC END# *4A4C856300DF_4DD77B7C0163_var*
begin
//#UC START# *4A4C856300DF_4DD77B7C0163_impl*
 Assert(false);
//#UC END# *4A4C856300DF_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.DisableListener

procedure _nevTableRowBaseLineCommon_.EnableListener;
 {* Включает нотификацию об изменении }
//#UC START# *4A4C8581014B_4DD77B7C0163_var*
//#UC END# *4A4C8581014B_4DD77B7C0163_var*
begin
//#UC START# *4A4C8581014B_4DD77B7C0163_impl*
 Assert(false);
//#UC END# *4A4C8581014B_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.EnableListener

function _nevTableRowBaseLineCommon_.Get_HasInner: Boolean;
//#UC START# *4A58B79A0360_4DD77B7C0163get_var*
//#UC END# *4A58B79A0360_4DD77B7C0163get_var*
begin
//#UC START# *4A58B79A0360_4DD77B7C0163get_impl*
 Result := False;
//#UC END# *4A58B79A0360_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_HasInner

function _nevTableRowBaseLineCommon_.Get_ShowCollapsed: Boolean;
//#UC START# *4A5B48A701A9_4DD77B7C0163get_var*
//#UC END# *4A5B48A701A9_4DD77B7C0163get_var*
begin
//#UC START# *4A5B48A701A9_4DD77B7C0163get_impl*
 Result := True;
//#UC END# *4A5B48A701A9_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_ShowCollapsed

procedure _nevTableRowBaseLineCommon_.Set_ShowCollapsed(aValue: Boolean);
//#UC START# *4A5B48A701A9_4DD77B7C0163set_var*
//#UC END# *4A5B48A701A9_4DD77B7C0163set_var*
begin
//#UC START# *4A5B48A701A9_4DD77B7C0163set_impl*
 Assert(aValue);
//#UC END# *4A5B48A701A9_4DD77B7C0163set_impl*
end;//_nevTableRowBaseLineCommon_.Set_ShowCollapsed

function _nevTableRowBaseLineCommon_.Compare(const aPoint: InevBasePoint): Integer;
//#UC START# *4A5B60870158_4DD77B7C0163_var*
//#UC END# *4A5B60870158_4DD77B7C0163_var*
begin
//#UC START# *4A5B60870158_4DD77B7C0163_impl*
 Result := -1;
 Assert(false);
//#UC END# *4A5B60870158_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.Compare

procedure _nevTableRowBaseLineCommon_.CheckPos(const anOp: InevOp);
 {* Избавляемся от рассинхронизации позиции курсора и дочернего параграфа. Заплатка конечно }
//#UC START# *4A5B6D370262_4DD77B7C0163_var*
//#UC END# *4A5B6D370262_4DD77B7C0163_var*
begin
//#UC START# *4A5B6D370262_4DD77B7C0163_impl*
 // ничего не делаем
//#UC END# *4A5B6D370262_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.CheckPos

function _nevTableRowBaseLineCommon_.ReadOnly: Boolean;
//#UC START# *4A5C66200185_4DD77B7C0163_var*
//#UC END# *4A5C66200185_4DD77B7C0163_var*
begin
//#UC START# *4A5C66200185_4DD77B7C0163_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C66200185_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.ReadOnly

function _nevTableRowBaseLineCommon_.AsPoint: InevBasePoint;
//#UC START# *4A5C6DB4014D_4DD77B7C0163_var*
//#UC END# *4A5C6DB4014D_4DD77B7C0163_var*
begin
//#UC START# *4A5C6DB4014D_4DD77B7C0163_impl*
 Result := Self;
//#UC END# *4A5C6DB4014D_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AsPoint

function _nevTableRowBaseLineCommon_.AsCursor(const aView: InevView): InevPoint;
//#UC START# *4A5C750E01F7_4DD77B7C0163_var*
//#UC END# *4A5C750E01F7_4DD77B7C0163_var*
begin
//#UC START# *4A5C750E01F7_4DD77B7C0163_impl*
 Result := Self;
//#UC END# *4A5C750E01F7_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AsCursor

{$If Defined(evNeedMarkers)}
function _nevTableRowBaseLineCommon_.Get_MarkersSource: IevMarkersSource;
//#UC START# *4A5C7D2F0079_4DD77B7C0163get_var*
//#UC END# *4A5C7D2F0079_4DD77B7C0163get_var*
begin
//#UC START# *4A5C7D2F0079_4DD77B7C0163get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4A5C7D2F0079_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_MarkersSource
{$IfEnd} // Defined(evNeedMarkers)

function _nevTableRowBaseLineCommon_.ProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *4A5C8A9D0324_4DD77B7C0163_var*
//#UC END# *4A5C8A9D0324_4DD77B7C0163_var*
begin
//#UC START# *4A5C8A9D0324_4DD77B7C0163_impl*
 Result := false;
 Assert(false);
//#UC END# *4A5C8A9D0324_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.ProcessMessage

function _nevTableRowBaseLineCommon_.Get_Listener: InevPointListener;
//#UC START# *4A5C9138035D_4DD77B7C0163get_var*
//#UC END# *4A5C9138035D_4DD77B7C0163get_var*
begin
//#UC START# *4A5C9138035D_4DD77B7C0163get_impl*
 Result := nil;
 // - не надо никому ни о чём сообщать
//#UC END# *4A5C9138035D_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.Get_Listener

function _nevTableRowBaseLineCommon_.GetBlockLength: Integer;
//#UC START# *4A5C913F0235_4DD77B7C0163_var*
//#UC END# *4A5C913F0235_4DD77B7C0163_var*
begin
//#UC START# *4A5C913F0235_4DD77B7C0163_impl*
 Result := 0;
 Assert(false);
//#UC END# *4A5C913F0235_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.GetBlockLength

procedure _nevTableRowBaseLineCommon_.MergeTo(const aView: InevView;
 const aBaseLine: InevBasePoint);
 {* Объединяем значения отрисованных частей. }
//#UC START# *4A810F81018E_4DD77B7C0163_var*
//#UC END# *4A810F81018E_4DD77B7C0163_var*
begin
//#UC START# *4A810F81018E_4DD77B7C0163_impl*
 DoMergeTo(aView, aBaseLine);
//#UC END# *4A810F81018E_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.MergeTo

function _nevTableRowBaseLineCommon_.InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
 aForDrawing: TnevInnerType): InevBasePoint;
 {* Получаем первый параграф, по которому можно получить вложенную точку. }
//#UC START# *4AA76AE00147_4DD77B7C0163_var*
var
 l_MaxID : Integer;
//#UC END# *4AA76AE00147_4DD77B7C0163_var*
begin
//#UC START# *4AA76AE00147_4DD77B7C0163_impl*
 if aFI.Hidden then
  Result := nil
 else
 begin
  l_MaxID := aFI.GreatestObjPID;
  if (l_MaxID >= f_Children.Count) or (l_MaxID < 0) then
  begin
   Result := nil;
   Exit;
  end // if (l_MaxID >= f_Children.Count) or (l_MaxID < 0) then
  else
   Result := f_Children[l_MaxID];
  if (Result <> nil) then
  // ^ - Запил для: http://mdp.garant.ru/pages/viewpage.action?pageId=297700378
  // Написал новую задачу для разборок: http://mdp.garant.ru/pages/viewpage.action?pageId=297703832
  // После правок вернуть обратно!
  begin
   if (TevMergeStatus(Result.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue) then
    if (aForDrawing = nev_itNone) and (l_MaxID < f_HeadCells.Count) then
     Result := f_HeadCells[l_MaxID];
   if (Result <> nil) and Result.AfterEnd and (aForDrawing = nev_itNone) then
    Result := nil;
  end; // if (Result <> nil) then
 end;//l_FI.Hidden
//#UC END# *4AA76AE00147_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InnerForChildThatNotAfterEnd

function _nevTableRowBaseLineCommon_.HasBaseLine: Boolean;
 {* Проверяет есть ли возможность работы с базовой линией на точке }
//#UC START# *4AA76AF90174_4DD77B7C0163_var*
//#UC END# *4AA76AF90174_4DD77B7C0163_var*
begin
//#UC START# *4AA76AF90174_4DD77B7C0163_impl*
 Result := True;
//#UC END# *4AA76AF90174_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.HasBaseLine

procedure _nevTableRowBaseLineCommon_.AddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4B90DA600047_4DD77B7C0163_var*
//#UC END# *4B90DA600047_4DD77B7C0163_var*
begin
//#UC START# *4B90DA600047_4DD77B7C0163_impl*
 DoAddInner(aView, anInner, anIndex, aFirst, aMode);
//#UC END# *4B90DA600047_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AddInner

procedure _nevTableRowBaseLineCommon_.CompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
 {* После применения AnchorByPoint могут остаться "неинициализированные" (будут указывать на начало ячейки) дочерние точки в базовой линии. }
//#UC START# *4B9623150178_4DD77B7C0163_var*
//#UC END# *4B9623150178_4DD77B7C0163_var*
begin
//#UC START# *4B9623150178_4DD77B7C0163_impl*
 DoCompareWithOtherInner(aView, anMaxID);
//#UC END# *4B9623150178_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.CompareWithOtherInner

function _nevTableRowBaseLineCommon_.PartiallyVisible(const aView: InevView;
 const aPoint: InevBasePoint;
 const aMap: TnevFormatInfoPrim): Boolean;
 {* Определяет может ли точка "частично видимой" относительно другой точки (aPoint). Сделано для определения видимости начальной ячейки относительно якоря. }
//#UC START# *4BBB0DDD026D_4DD77B7C0163_var*
//#UC END# *4BBB0DDD026D_4DD77B7C0163_var*
begin
//#UC START# *4BBB0DDD026D_4DD77B7C0163_impl*
 Result := False;
 Assert(False);
//#UC END# *4BBB0DDD026D_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.PartiallyVisible

function _nevTableRowBaseLineCommon_.InnerHead(aPID: Integer): InevBasePoint;
 {* Аналог InnerFor, но для частей объдеиненных ячеек, попадающих на данную строку (пока используется только для печати). }
//#UC START# *4C456C8E027F_4DD77B7C0163_var*
//#UC END# *4C456C8E027F_4DD77B7C0163_var*
begin
//#UC START# *4C456C8E027F_4DD77B7C0163_impl*
 Result := DoInnerHead(aPID);
//#UC END# *4C456C8E027F_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InnerHead

function _nevTableRowBaseLineCommon_.HasHeadPart: Boolean;
 {* Строка содержит продолжение объединенных ячеек. }
//#UC START# *4C456CEA01DE_4DD77B7C0163_var*
//#UC END# *4C456CEA01DE_4DD77B7C0163_var*
begin
//#UC START# *4C456CEA01DE_4DD77B7C0163_impl*
 Result := DoHasHeadPart;
//#UC END# *4C456CEA01DE_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.HasHeadPart

procedure _nevTableRowBaseLineCommon_.AddHeadInner(const aHeadInner: InevBasePoint);
 {* Служит для добавления в базовую линию продолжений объединенных ячеек (используется только для печати). }
//#UC START# *4C456D220317_4DD77B7C0163_var*
//#UC END# *4C456D220317_4DD77B7C0163_var*
begin
//#UC START# *4C456D220317_4DD77B7C0163_impl*
 DoAddHeadInner(aHeadInner);
//#UC END# *4C456D220317_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.AddHeadInner

procedure _nevTableRowBaseLineCommon_.CopyHeadParts(const aFrom: InevBasePoint);
 {* Копирует только части продолжений ячеек, если они есть. }
//#UC START# *4C457D0502E1_4DD77B7C0163_var*
//#UC END# *4C457D0502E1_4DD77B7C0163_var*
begin
//#UC START# *4C457D0502E1_4DD77B7C0163_impl*
 DoCopyHeadParts(aFrom);
//#UC END# *4C457D0502E1_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.CopyHeadParts

procedure _nevTableRowBaseLineCommon_.InitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
 {* Инициализируем базовую линию по курсору. }
//#UC START# *4C735E600112_4DD77B7C0163_var*
//#UC END# *4C735E600112_4DD77B7C0163_var*
begin
//#UC START# *4C735E600112_4DD77B7C0163_impl*
 DoInitByCursor(aView, anInnerPoint);
//#UC END# *4C735E600112_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InitByCursor

procedure _nevTableRowBaseLineCommon_.InitBaseLineInner(const aView: InevView;
 const anItem: InevPara);
//#UC START# *4D9C113C0320_4DD77B7C0163_var*
//#UC END# *4D9C113C0320_4DD77B7C0163_var*
begin
//#UC START# *4D9C113C0320_4DD77B7C0163_impl*
 DoInitBaseLineInner(aView, anItem);
//#UC END# *4D9C113C0320_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InitBaseLineInner

function _nevTableRowBaseLineCommon_.InnerTop(const aChild: InevObject): InevBasePoint;
 {* Возвращает указатель на первоначальную позицию для точки. Для обычных точек - всегда nil. }
//#UC START# *4DDCD59301D5_4DD77B7C0163_var*
//#UC END# *4DDCD59301D5_4DD77B7C0163_var*
begin
//#UC START# *4DDCD59301D5_4DD77B7C0163_impl*
 if aChild.PID < f_TopCells.Count then
  Result := f_TopCells[aChild.PID]
 else
  Result := nil;
//#UC END# *4DDCD59301D5_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.InnerTop

function _nevTableRowBaseLineCommon_.pm_GetBeforeStart: Boolean;
//#UC START# *4EC3B0330271_4DD77B7C0163get_var*
//#UC END# *4EC3B0330271_4DD77B7C0163get_var*
begin
//#UC START# *4EC3B0330271_4DD77B7C0163get_impl*
 Result := False;
//#UC END# *4EC3B0330271_4DD77B7C0163get_impl*
end;//_nevTableRowBaseLineCommon_.pm_GetBeforeStart

procedure _nevTableRowBaseLineCommon_.CorrectMoveRight(const aView: InevView;
 const aPoint: InevBasePoint;
 const anOp: InevOp);
//#UC START# *50DAA7010050_4DD77B7C0163_var*
//#UC END# *50DAA7010050_4DD77B7C0163_var*
begin
//#UC START# *50DAA7010050_4DD77B7C0163_impl*
 Assert(False);
//#UC END# *50DAA7010050_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.CorrectMoveRight

procedure _nevTableRowBaseLineCommon_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DD77B7C0163_var*
//#UC END# *479731C50290_4DD77B7C0163_var*
begin
//#UC START# *479731C50290_4DD77B7C0163_impl*
 l3Free(f_Children);
 l3Free(f_HeadCells);
 l3Free(f_TopCells);
 f_HasMergedCell := False;
 f_TopCellsWasInit := False;
 inherited;
//#UC END# *479731C50290_4DD77B7C0163_impl*
end;//_nevTableRowBaseLineCommon_.Cleanup
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevTableRowBaseLineCommon_imp_impl}

{$EndIf nevTableRowBaseLineCommon_imp}

