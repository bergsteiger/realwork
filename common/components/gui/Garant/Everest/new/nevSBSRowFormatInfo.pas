unit nevSBSRowFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevSBSRowFormatInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevSBSRowFormatInfo" MUID: (4E70655403BD)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevRubberCellsRenderInfo
 , nevBase
;

type
 TnevSBSRowFormatInfo = class(TnevRubberCellsRenderInfo)
  private
   f_SecondColWdith: Integer;
    {* Кешированная ширина второй колонки для проверки изменений. }
  private
   function CalcNewWidth(aParentWidth: Integer;
    aValue: Integer): Integer;
   function ParentWidth: Integer;
    {* Ширина для вычислений. }
  protected
   function WasChanged: Boolean; override;
   procedure ClearChangedFlag; override;
  public
   function CalcClientValue4Column(aColumnID: Integer): Integer; override;
   procedure ResizeColumn(aColumnID: Integer;
    aValue: Integer;
    const aContext: InevOp); override;
 end;//TnevSBSRowFormatInfo

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Math
 , l3MinMax
 , nevTools
 , evSectionPara
 , evConst
 //#UC START# *4E70655403BDimpl_uses*
 //#UC END# *4E70655403BDimpl_uses*
;

function TnevSBSRowFormatInfo.CalcNewWidth(aParentWidth: Integer;
 aValue: Integer): Integer;
//#UC START# *4ED4B9B50021_4E70655403BD_var*
var
 l_NewWidth: Integer;
 l_Width: Integer;
//#UC END# *4ED4B9B50021_4E70655403BD_var*
begin
//#UC START# *4ED4B9B50021_4E70655403BD_impl*
 l_NewWidth := LimitWidth;
 with Obj do
  l_Width := Abs(AsObject.Child[0].IntA[k2_tiWidth]) + Abs(AsObject.Child[1].IntA[k2_tiWidth]);
 if Abs(l_Width - aParentWidth) > evEpsilon then
  Result := l3MulDiv(aValue, aParentWidth, l_NewWidth)
 else
  Result := l3MulDiv(aValue, l_Width, l_NewWidth);
//#UC END# *4ED4B9B50021_4E70655403BD_impl*
end;//TnevSBSRowFormatInfo.CalcNewWidth

function TnevSBSRowFormatInfo.ParentWidth: Integer;
 {* Ширина для вычислений. }
//#UC START# *4ED61E7200D0_4E70655403BD_var*
var
 l_SB     : InevSectionBreaks;
 l_Holder : InevObjectHolder;
 l_Break  : InevObject;
 l_Obj    : InevObject;
 l_PI     : TnevFormatInfoPrim;
//#UC END# *4ED61E7200D0_4E70655403BD_var*
begin
//#UC START# *4ED61E7200D0_4E70655403BD_impl*
 Result := 0;
 if Metrics.IsWebStyle then
 begin
  l_Obj := (Obj As InevObject);
  l_Holder := l_Obj.Holder;
  if (l_Holder <> nil) then
  begin
   l_SB := l_Holder.SectionBreaks;
   if (l_SB <> nil) then
    if l_SB.GetSectionBreak(l_Obj, l_Break) then
     Result := evSectionExtent(l_Break.AsObject).X;
  end; // if (l_Holder <> nil) then
  if Result = 0 then
   Result := Abs(RootFormatInfo.Obj.AsObject.IntA[k2_tiWidth]);
  l_PI := ParentInfo;
  while l_PI <> nil do
  begin
   Dec(Result, l_PI.Obj.AsObject.IntA[k2_tiLeftIndent]);
   Dec(Result, l_PI.Obj.AsObject.IntA[k2_tiRightIndent]);
   l_PI := l_PI.ParentInfo;
  end; // while l_PI <> nil do
 end // if Metrics.IsWebStyle then
 else
  Result := LimitWidth;
//#UC END# *4ED61E7200D0_4E70655403BD_impl*
end;//TnevSBSRowFormatInfo.ParentWidth

function TnevSBSRowFormatInfo.CalcClientValue4Column(aColumnID: Integer): Integer;
//#UC START# *4ED4ADA90212_4E70655403BD_var*
var
 i       : Integer;
 l_Count : Integer;
//#UC END# *4ED4ADA90212_4E70655403BD_var*
begin
//#UC START# *4ED4ADA90212_4E70655403BD_impl*
 Result := 0;
 if Widthes = nil then Exit;
 l_Count := Min(Obj.AsObject.ChildrenCount, aColumnID);
 for i := 0 to l_Count - 1 do
  Inc(Result, Widthes[i]);
//#UC END# *4ED4ADA90212_4E70655403BD_impl*
end;//TnevSBSRowFormatInfo.CalcClientValue4Column

procedure TnevSBSRowFormatInfo.ResizeColumn(aColumnID: Integer;
 aValue: Integer;
 const aContext: InevOp);
//#UC START# *4ED4AE2B03D3_4E70655403BD_var*
var
 l_LW    : Integer;
 l_Delta : Integer;
 l_Width : Integer;
//#UC END# *4ED4AE2B03D3_4E70655403BD_var*
begin
//#UC START# *4ED4AE2B03D3_4E70655403BD_impl*
 if aColumnID > 1 then Exit;
 // ^ - фича с изменением последней колонки поддерживалась в старом редакторе,
 // но на самом деле не работала, т.к. после передергивания все равно "забывалась".
 l_LW := ParentWidth;
 l_Width := CalcNewWidth(l_LW, aValue);
 aContext.Lock; // Скобки для правильной перерисовки маркеров на линейке.
 try
  with Obj do
  begin
   AsObject.Child[aColumnID - 1].IntW[k2_tiWidth, aContext] := l_Width;
   AsObject.Child[aColumnID].IntW[k2_tiWidth, aContext] := l_LW - l_Width;
  end; // with Obj do
 finally
  aContext.Unlock;
 end;
//#UC END# *4ED4AE2B03D3_4E70655403BD_impl*
end;//TnevSBSRowFormatInfo.ResizeColumn

function TnevSBSRowFormatInfo.WasChanged: Boolean;
//#UC START# *4ED719EE01C1_4E70655403BD_var*
//#UC END# *4ED719EE01C1_4E70655403BD_var*
begin
//#UC START# *4ED719EE01C1_4E70655403BD_impl*
 Result := inherited WasChanged;
 {$IF Defined(Archi) or Defined(EverestLite)}
 if (Obj.ChildrenCount > 1) and not Result then
  Result := Abs(f_SecondColWdith - Abs(Obj.Child[1].IntA[k2_tiWidth])) > evEpsilon;
 {$IFEND}
//#UC END# *4ED719EE01C1_4E70655403BD_impl*
end;//TnevSBSRowFormatInfo.WasChanged

procedure TnevSBSRowFormatInfo.ClearChangedFlag;
//#UC START# *4ED71A110169_4E70655403BD_var*
//#UC END# *4ED71A110169_4E70655403BD_var*
begin
//#UC START# *4ED71A110169_4E70655403BD_impl*
 inherited ClearChangedFlag;
 {$IF Defined(Archi) or Defined(EverestLite)}
 if Obj.ChildrenCount > 1 then
  f_SecondColWdith := Abs(Obj.Child[1].IntA[k2_tiWidth]);
 {$IFEND}
//#UC END# *4ED71A110169_4E70655403BD_impl*
end;//TnevSBSRowFormatInfo.ClearChangedFlag

end.
