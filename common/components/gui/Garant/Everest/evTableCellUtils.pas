unit evTableCellUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/evTableCellUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ParaUtils::evTableCellUtils
//
// Различные вспомогательные функции для работы с ячейками таблицы.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevBase,
  nevTools,
  l3Variant
  ;

function EvCheckCellWidth(aValue: Integer;
  aOnlySymbol: Boolean = False): Integer; overload; 
   {* Корректирует ширину/изменение ширины ячейки, чтобы она была кратна ширине символов, aOnlySymbol - возвращаемая ширина не может быть меньше одного символа }
function EvCheckCellWidth(aValue: Integer;
  aOuterWidth: Integer): Integer; overload; 
   {* Корректирует ширину ячейки, чтобы она была кратна ширине символов, Если полученная ширина меньше aOuterWidth, то возвращается aOuterWidth. }
function EvHasFormulaOnly(const aPara: InevPara;
  aFI: TnevFormatInfoPrim): Boolean;
function EvInEmptyTableCell(const aStart: InevBasePoint;
  const aFinish: InevBasePoint): Boolean;
   {* Проверяет попадают ли точки в пустую ячейку. }
function EvCloneCell(const aPack: InevOp;
  aCell: Tl3Variant): Il3TagRef;
   {* Создает копию ячейки. }
function EvCheckSingleContinueCell(const aPara: InevPara): Boolean;
   {* Проверяет содержит ли строка одну ячейку и эта ячейка часть объединения MergeStatus = ev_msContinue. }
function EvIsPointHeadCell(const aView: InevView;
  const aPoint: InevBasePoint): InevBasePoint;
   {* Проверяет указывает ли точка на начальную ячейку объединения. }
procedure EvCorrectTablePoint(aStart: Boolean;
  const aView: InevView;
  const aPoint: InevBasePoint;
  const aPointCopy: InevBasePoint;
  const aHeadPoint: InevBasePoint);
   {* Корректирует точку при необходимости }
function EvIsPointTextInCell(const aPoint: InevBasePoint): Boolean;
   {* Проверяет находится ли точка, указывающая на текст в ячейке таблицы. }
function EvMoreOrEqualOffset(const aFirst: Integer;
  aSecond: Integer): Boolean;
function EvEqualOffset(aFirst: Integer;
  aSecond: Integer): Boolean;
function EvCanDeleteRow(aRow: Tl3Tag;
  anIgnoreEmtpyRow: Boolean): Boolean;
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  l3LongintList,
  Math,
  l3UnitsTools,
  ObjectSegment_Const,
  Formula_Const,
  k2Base,
  TableCell_Const,
  evdTypes,
  evOp,
  k2Tags
  ;

// unit methods

function EvIsPointTextInCell(const aPoint: InevBasePoint): Boolean;
//#UC START# *4F44B12A0166_4C3849220132_var*
var
 l_Parent: InevBasePoint;
//#UC END# *4F44B12A0166_4C3849220132_var*
begin
//#UC START# *4F44B12A0166_4C3849220132_impl*
 l_Parent := aPoint.ParentPoint;
 Result := (l_Parent <> nil) and l_Parent.AsObject.IsValid;
 if Result then
  Result := l_Parent.AsObject.IsKindOf(k2_typTableCell);
//#UC END# *4F44B12A0166_4C3849220132_impl*
end;//EvIsPointTextInCell

function EvMoreOrEqualOffset(const aFirst: Integer;
  aSecond: Integer): Boolean;
//#UC START# *50F5119003E5_4C3849220132_var*
var
 l_Rslt: Integer;
//#UC END# *50F5119003E5_4C3849220132_var*
begin
//#UC START# *50F5119003E5_4C3849220132_impl*
 l_Rslt := aFirst - aSecond;
 Result := (Abs(l_Rslt) <= evCellWidthEpsilon) or (l_Rslt > evCellWidthEpsilon);
//#UC END# *50F5119003E5_4C3849220132_impl*
end;//EvMoreOrEqualOffset

function EvEqualOffset(aFirst: Integer;
  aSecond: Integer): Boolean;
//#UC START# *50F516FA010B_4C3849220132_var*
//#UC END# *50F516FA010B_4C3849220132_var*
begin
//#UC START# *50F516FA010B_4C3849220132_impl*
 Result := Abs(aFirst - aSecond) <= evCellWidthEpsilon;
//#UC END# *50F516FA010B_4C3849220132_impl*
end;//EvEqualOffset

function EvCanDeleteRow(aRow: Tl3Tag;
  anIgnoreEmtpyRow: Boolean): Boolean;
//#UC START# *5379A05600E1_4C3849220132_var*
var
 l_CellCount       : Integer;
 l_MergedCellCount : Integer;

 function lp_CheckCell(aCell: Tl3Variant; aCellIndex: Integer): Boolean; 
 begin//CheckCell
  Result := True;
  Inc(l_CellCount);
  if TevMergeStatus(aCell.IntA[k2_tiMergeStatus]) = ev_msContinue then
  begin
   Inc(l_MergedCellCount);
   Assert((aCell.ChildrenCount = 0) or ((aCell.ChildrenCount = 1) and (aCell.Child[0].StrA[k2_tiText] = '')));
  end; // if IsValid AND (AsLong = Ord(ev_msContinue)) then
 end;//lp_CheckCell

//#UC END# *5379A05600E1_4C3849220132_var*
begin
//#UC START# *5379A05600E1_4C3849220132_impl*
 l_CellCount := 0;
 l_MergedCellCount := 0;
 aRow.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckCell));
 Result := (l_CellCount = l_MergedCellCount);
 if anIgnoreEmtpyRow and Result then
  Result := l_CellCount > 0;
//#UC END# *5379A05600E1_4C3849220132_impl*
end;//EvCanDeleteRow

function EvCheckCellWidth(aValue: Integer;
  aOnlySymbol: Boolean = False): Integer;
//#UC START# *4C38498D00D0_4C3849220132_var*
var
 l_Epsilon : Integer;
 l_Delta   : Integer;
//#UC END# *4C38498D00D0_4C3849220132_var*
begin
//#UC START# *4C38498D00D0_4C3849220132_impl*
 l_Epsilon := evCellWidthEpsilon;
 l_Delta := Abs(aValue mod l_Epsilon);
 if l_Delta = 0 then
  Result := aValue
 else
 begin
  if l_Delta < EvHalfCellWidthEpsilon then
  begin
   Result := l_Epsilon * (aValue div l_Epsilon);
   if (Abs(aValue) < EvHalfCellWidthEpsilon) and (Result < 0) then
    Result := 0;
  end // if l_Delta < EvHalfCellWidthEpsilon then
  else
   Result := l_Epsilon * (aValue div l_Epsilon + Sign(aValue));
 end; // if l_Delta <> 0 then
 if aOnlySymbol and (Result < l_Epsilon) then
  Result := l_Epsilon;
//#UC END# *4C38498D00D0_4C3849220132_impl*
end;//EvCheckCellWidth

function EvCheckCellWidth(aValue: Integer;
  aOuterWidth: Integer): Integer;
//#UC START# *4C384A440171_4C3849220132_var*
//#UC END# *4C384A440171_4C3849220132_var*
begin
//#UC START# *4C384A440171_4C3849220132_impl*
 Result := evCheckCellWidth(aValue);
 if (aOuterWidth - Result) < evCellWidthEpsilon then
  Result := aValue;
//#UC END# *4C384A440171_4C3849220132_impl*
end;//EvCheckCellWidth

function EvHasFormulaOnly(const aPara: InevPara;
  aFI: TnevFormatInfoPrim): Boolean;
//#UC START# *4C77545B0230_4C3849220132_var*
var
 l_HasFormula: Boolean absolute Result;

 function CheckSegment(aSegment: Tl3Variant; Index: Integer): Boolean;
 begin//CheckSegment
  Result := Index = 0;
  l_HasFormula := Result and
                  aSegment.IsKindOf(k2_typObjectSegment) and
                  aSegment.Child[0].IsKindOf(k2_typFormula);
 end;//CheckSegment

var
 l_FI       : TnevFormatInfoPrim;
 l_Para     : InevPara;
 l_Segments : Tl3Variant;
 l_Layer    : Tl3Variant;
//#UC END# *4C77545B0230_4C3849220132_var*
begin
//#UC START# *4C77545B0230_4C3849220132_impl*
 l_HasFormula := False;
 if aPara.AsObject.ChildrenCount = 1 then
 begin
  l_Para := aPara.AsList.Para[0];
  l_FI := aFI.InfoForChild(l_Para);
  Assert(l_FI <> nil);
  if (l_FI.Lines <> nil) AND (l_FI.Lines.Count <> 1) then
   Exit;
  l_Layer := l_Para.AsObject.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slObjects)]);
  with l_Layer do
   if IsValid then
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckSegment));
 end; // if aPara.ChildrenCount = 1 then
//#UC END# *4C77545B0230_4C3849220132_impl*
end;//EvHasFormulaOnly

function EvInEmptyTableCell(const aStart: InevBasePoint;
  const aFinish: InevBasePoint): Boolean;
//#UC START# *4C7E0ABF0116_4C3849220132_var*
var
 l_Point: InevBasePoint;
//#UC END# *4C7E0ABF0116_4C3849220132_var*
begin
//#UC START# *4C7E0ABF0116_4C3849220132_impl*
 Result := false;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=259171242&focusedCommentId=259893043#comment-259893043
 if (aStart.Compare(aFinish) = 0) then
 begin
  l_Point := aStart;
  while l_Point <> nil do
  begin
   if l_Point.AsObject.IsKindOf(k2_typTableCell) then
   begin
    Result := True;
    Break;
   end; // if l_Point.IsKindOf(k2_tiTableCell) then
   l_Point := l_Point.Inner;
  end; // while l_Point <> nil do
 end;//aStart.Compare(aFinish) = 0
//#UC END# *4C7E0ABF0116_4C3849220132_impl*
end;//EvInEmptyTableCell

function EvCloneCell(const aPack: InevOp;
  aCell: Tl3Variant): Il3TagRef;
//#UC START# *4C8DF2F600EA_4C3849220132_var*
var
 l_Text : Tl3Variant;
 l_O : Tl3Variant;
//#UC END# *4C8DF2F600EA_4C3849220132_var*
begin
//#UC START# *4C8DF2F600EA_4C3849220132_impl*
 Result := aCell.TagType.MakeTag;
 l_O := Result.AsObject;
 l_O.IntW[k2_tiWidth, aPack] := aCell.IntA[k2_tiWidth];
 l_O.IntW[k2_tiFrame, aPack] := aCell.IntA[k2_tiFrame];
 l_Text := Tk2Type(l_O.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
 l_O.AddChild(l_Text);
//#UC END# *4C8DF2F600EA_4C3849220132_impl*
end;//EvCloneCell

function EvCheckSingleContinueCell(const aPara: InevPara): Boolean;
//#UC START# *4CA1ECEB001A_4C3849220132_var*
//#UC END# *4CA1ECEB001A_4C3849220132_var*
begin
//#UC START# *4CA1ECEB001A_4C3849220132_impl*
 Result := aPara.AsObject.ChildrenCount = 1;
 if Result then
  Result := TevMergeStatus(aPara.AsObject.Child[0].IntA[k2_tiMergeStatus]) = ev_msContinue;
//#UC END# *4CA1ECEB001A_4C3849220132_impl*
end;//EvCheckSingleContinueCell

function EvIsPointHeadCell(const aView: InevView;
  const aPoint: InevBasePoint): InevBasePoint;
//#UC START# *4D38236B03AD_4C3849220132_var*
var
 l_Inner: InevBasePoint;
//#UC END# *4D38236B03AD_4C3849220132_var*
begin
//#UC START# *4D38236B03AD_4C3849220132_impl*
 l_Inner := aPoint;
 while (l_Inner <> nil) and (l_Inner.Obj^.OverlapType <> otUpper) do
  l_Inner := l_Inner.Inner;
 if l_Inner = nil then
  Result := nil
 else
  Result := l_Inner.ClonePoint(aView)
//#UC END# *4D38236B03AD_4C3849220132_impl*
end;//EvIsPointHeadCell

procedure EvCorrectTablePoint(aStart: Boolean;
  const aView: InevView;
  const aPoint: InevBasePoint;
  const aPointCopy: InevBasePoint;
  const aHeadPoint: InevBasePoint);
//#UC START# *4D3823BB00DA_4C3849220132_var*
var
 l_Point     : InevBasePoint;
 l_PointCopy : InevBasePoint;

 procedure lp_CheckPoint;
 begin
  if aStart then
  begin
   l_Point.SetAtStart(aView, True);
   l_PointCopy.SetAtStart(aView, True);
  end // if aStart then
  else
  begin
   l_Point.SetAtEnd(aView, True);
   l_PointCopy.SetAtEnd(aView, True);
  end;
 end;

var
 l_VertPos1 : Integer;
 l_VertPos2 : Integer;
//#UC END# *4D3823BB00DA_4C3849220132_var*
begin
//#UC START# *4D3823BB00DA_4C3849220132_impl*
 l_Point := aPoint;
 l_PointCopy := aPointCopy;
 while (l_Point <> nil) and not l_Point.AsObject.IsKindOf(k2_typTableCell) do
 begin
  l_Point := l_Point.Inner;
  l_PointCopy := l_PointCopy.Inner;
 end; // while l_Point <> nil do
 if (l_Point <> nil) and not l_Point.Obj^.AsObject.IsSame(aHeadPoint.Obj^.AsObject) then
 begin
  l_VertPos1 := l_PointCopy.ParentPoint.Obj.PID;
  l_VertPos2 := aHeadPoint.Obj^.OwnerObj.PID;
  if l_VertPos1 > l_VertPos2 then
  begin
   l_Point.Move(aView, ev_ocParaUp);
   l_PointCopy.Move(aView, ev_ocParaUp);
   lp_CheckPoint;
  end // if l_Inner <> nil then
  else
   if l_VertPos1 = l_VertPos2 then
    lp_CheckPoint;
 end; // if l_Inner <> nil then
//#UC END# *4D3823BB00DA_4C3849220132_impl*
end;//EvCorrectTablePoint
{$IfEnd} //k2ForEditor

end.