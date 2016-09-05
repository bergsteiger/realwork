unit nevTableRowAnchor;
 {* Якорь для строки таблицы }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTableRowAnchor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevTableRowAnchor" MUID: (4A5D7B82016A)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaListAnchor
 , nevTools
 , nevBase
 {$If Defined(evUseVisibleCursors)}
 , nevParaListAnchorModifyTypes
 {$IfEnd} // Defined(evUseVisibleCursors)
;

type
 TnevTableRowAnchor = class(TnevParaListAnchor)
  {* Якорь для строки таблицы }
  private
   f_BaseLine: InevBaseLine4Anchor;
  private
   procedure CheckBaseLine(const aView: InevView);
    {* Проверяет, чтобы базовая линия была инициализирована }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAtStart: Boolean; override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   function GetInner: InevBasePoint; override;
   procedure SetInner(const aValue: InevBasePoint); override;
   function GetInnerFor(const aChild: InevObject;
    var aRealTop: InevBasePoint): InevBasePoint; override;
   function pm_GetHasInner: Boolean; override;
   function DoHasBaseLine: Boolean; override;
   function DoGetInnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
    aForDrawing: TnevInnerType): InevBasePoint; override;
   {$If Defined(evUseVisibleCursors)}
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   function GetInnerTop(const aChild: InevObject): InevBasePoint; override;
   {$If Defined(evUseVisibleCursors)}
   procedure DoBottom(const aView: InevView); override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); override;
   {$If Defined(evUseVisibleCursors)}
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
   procedure DoAddInner(const aView: InevView;
    const anInner: InevBaseLine4Anchor;
    anIndex: Integer;
    var aFirst: Boolean;
    aMode: TnevAddInnerMode); override;
   procedure DoCompareWithOtherInner(const aView: InevView;
    anMaxID: Integer = -1); override;
   procedure DoInitByCursor(const aView: InevView;
    const anInnerPoint: InevBasePoint); override;
    {* Инициализируем базовую линию по курсору. }
 end;//TnevTableRowAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevFacade
 , k2Tags
 , evdTypes
 {$If Defined(evUseVisibleCursors)}
 , nevAfterEndPoint
 {$IfEnd} // Defined(evUseVisibleCursors)
 //#UC START# *4A5D7B82016Aimpl_uses*
 //#UC END# *4A5D7B82016Aimpl_uses*
;

procedure TnevTableRowAnchor.CheckBaseLine(const aView: InevView);
 {* Проверяет, чтобы базовая линия была инициализирована }
//#UC START# *4A5D7BF302EB_4A5D7B82016A_var*
var
 l_RowFI : TnevFormatInfoPrim;

 function CheckChildren(const anItem: InevPara; anIndex: Integer): Boolean;
 var
  l_Point: InevBasePoint;
 begin
  Result := true;
  f_BaseLine.InitBaseLineInner(aView, anItem); 
 end;

//#UC END# *4A5D7BF302EB_4A5D7B82016A_var*
begin
//#UC START# *4A5D7BF302EB_4A5D7B82016A_impl*
 if f_BaseLine = nil then
 begin
  l_RowFI := aView.FormatInfoByPoint(Self);     
  if l_RowFI = nil then Exit; // Нечего инициализировать базовую линию, если форматирование строки недоступно - огребем кучу AV!
  f_BaseLine := ParaX.BaseLine4Anchor;
  ParaX.AsList.IterateParaF(nevL2PIA(@CheckChildren));
 end; // if f_BaseLine = nil then
//#UC END# *4A5D7BF302EB_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.CheckBaseLine

procedure TnevTableRowAnchor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A5D7B82016A_var*
//#UC END# *479731C50290_4A5D7B82016A_var*
begin
//#UC START# *479731C50290_4A5D7B82016A_impl*
 f_BaseLine := nil;
 inherited;
//#UC END# *479731C50290_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.Cleanup

function TnevTableRowAnchor.GetAtStart: Boolean;
//#UC START# *4A3B707700C9_4A5D7B82016A_var*
//#UC END# *4A3B707700C9_4A5D7B82016A_var*
begin
//#UC START# *4A3B707700C9_4A5D7B82016A_impl*
 if (f_BaseLine <> nil) then
  Result := f_BaseLine.AtStart
 else
  Result := inherited GetAtStart;
//#UC END# *4A3B707700C9_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.GetAtStart

function TnevTableRowAnchor.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *4A3B708900C4_4A5D7B82016A_var*
//#UC END# *4A3B708900C4_4A5D7B82016A_var*
begin
//#UC START# *4A3B708900C4_4A5D7B82016A_impl*
 if (f_BaseLine <> nil) then
  Result := f_BaseLine.AtEnd(aView)
 else
  Result := inherited GetAtEnd(aView);
//#UC END# *4A3B708900C4_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.GetAtEnd

function TnevTableRowAnchor.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *4A3B7F2E01CE_4A5D7B82016A_var*
//#UC END# *4A3B7F2E01CE_4A5D7B82016A_var*
begin
//#UC START# *4A3B7F2E01CE_4A5D7B82016A_impl*
 if (f_BaseLine <> nil) then
  Result := f_BaseLine.VertPosition(aView, aMap)
 else
  Result := inherited GetVertPosition(aView, aMap);
//#UC END# *4A3B7F2E01CE_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.GetVertPosition

function TnevTableRowAnchor.GetInner: InevBasePoint;
//#UC START# *4A3B826402B8_4A5D7B82016A_var*
//#UC END# *4A3B826402B8_4A5D7B82016A_var*
begin
//#UC START# *4A3B826402B8_4A5D7B82016A_impl*
 if (f_BaseLine = nil) then
  Result := inherited GetInner
 else
  Result := f_BaseLine.Inner;
//#UC END# *4A3B826402B8_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.GetInner

procedure TnevTableRowAnchor.SetInner(const aValue: InevBasePoint);
//#UC START# *4A3B82710255_4A5D7B82016A_var*
//#UC END# *4A3B82710255_4A5D7B82016A_var*
begin
//#UC START# *4A3B82710255_4A5D7B82016A_impl*
 inherited;
 Assert(False);
//#UC END# *4A3B82710255_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.SetInner

function TnevTableRowAnchor.GetInnerFor(const aChild: InevObject;
 var aRealTop: InevBasePoint): InevBasePoint;
//#UC START# *4A3B848302A5_4A5D7B82016A_var*
//#UC END# *4A3B848302A5_4A5D7B82016A_var*
begin
//#UC START# *4A3B848302A5_4A5D7B82016A_impl*
 if f_BaseLine <> nil then
  Result := f_BaseLine.InnerFor(aChild, aRealTop)
 else
  Result := inherited GetInnerFor(aChild, aRealTop);
//#UC END# *4A3B848302A5_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.GetInnerFor

function TnevTableRowAnchor.pm_GetHasInner: Boolean;
//#UC START# *4A58BA550111_4A5D7B82016Aget_var*
//#UC END# *4A58BA550111_4A5D7B82016Aget_var*
begin
//#UC START# *4A58BA550111_4A5D7B82016Aget_impl*
 Result := (f_BaseLine = nil);
 if Result then
  Result := inherited pm_GetHasInner;
//#UC END# *4A58BA550111_4A5D7B82016Aget_impl*
end;//TnevTableRowAnchor.pm_GetHasInner

function TnevTableRowAnchor.DoHasBaseLine: Boolean;
//#UC START# *4AA777B603B6_4A5D7B82016A_var*
//#UC END# *4AA777B603B6_4A5D7B82016A_var*
begin
//#UC START# *4AA777B603B6_4A5D7B82016A_impl*
 Result := (f_BaseLine <> nil);
//#UC END# *4AA777B603B6_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoHasBaseLine

function TnevTableRowAnchor.DoGetInnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
 aForDrawing: TnevInnerType): InevBasePoint;
//#UC START# *4AA7797701F5_4A5D7B82016A_var*
var
 l_BaseLine : InevBaseLine4Anchor;
//#UC END# *4AA7797701F5_4A5D7B82016A_var*
begin
//#UC START# *4AA7797701F5_4A5D7B82016A_impl*
 if (aForDrawing = nev_itNeedInit) and (f_BaseLine = nil) then
 begin
  l_BaseLine := ParaX.BaseLine4Anchor;
  Result := l_BaseLine.InnerForChildThatNotAfterEnd(aFI, aForDrawing);
 end // if (aForDrawing = nev_itNeedInit) and (f_BaseLine = nil) then
 else
  Result := f_BaseLine.InnerForChildThatNotAfterEnd(aFI, aForDrawing);
//#UC END# *4AA7797701F5_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoGetInnerForChildThatNotAfterEnd

{$If Defined(evUseVisibleCursors)}
function TnevTableRowAnchor.DoDiff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4AA785540310_4A5D7B82016A_var*
var
 i            : Integer;
 l_PointInner : InevBasePoint;
 l_Inner      : InevBasePoint;
 l_Line       : InevBasePoint;
 l_List       : InevParaList;
 l_Child      : InevPara;
 l_PointReal  : InevBasePoint;
 l_Real       : InevBasePoint;
//#UC END# *4AA785540310_4A5D7B82016A_var*
begin
//#UC START# *4AA785540310_4A5D7B82016A_impl*
 Result := inherited DoDiff(aView, aPoint, aMap);
 if (Result = 0) then
  if HasBaseLine and aPoint.HasBaseLine then
  begin
   Result := nev_PlusDiff;
   l_Line := aPoint;
   if (l_Line <> nil) then
   begin
    l_List := ParaX.AsList;
    for i := 0 to l_List.AsObject.ChildrenCount - 1 do
    begin
     l_Child := l_List.Para[i];
     l_PointInner := l_Line.InnerFor(l_Child, l_PointReal);
     l_Inner := InnerFor(l_Child, l_Real);
     if l_PointInner = nil then
      if l_Inner = nil then
       Result := 0
      else
       Result := nev_PlusDiff
     else
     if l_PointInner.AfterEnd then
      if l_Inner = nil then
       Result := nev_PlusDiff
      else
       if l_Inner.AfterEnd then
       begin
        if aMap.GreatestObjPID = i then
         if (l_PointReal = nil) or l_PointReal.AfterEnd then
          if (l_Real = nil) or l_Real.AfterEnd then
           Result := 0
          else
           Result := nev_PlusDiff
         else
          if (l_Real = nil) or l_Real.AfterEnd then
           Result := nev_MinusDiff
          else
           Result := l_Real.Diff(aView, l_PointReal, aView.FormatInfoByPoint(l_Real))
        else
         Result := 0;
      end // if l_Inner.AfterEnd then
      else
       Result := nev_PlusDiff
     else
      if l_Inner = nil then
       Result := nev_PlusDiff
      else
      if l_Inner.AfterEnd then
       Result := nev_MinusDiff
      else
       if l_Inner.BeforeStart then
        Result := nev_PlusDiff
       else
        Result := l_Inner.Diff(aView, l_PointInner, aMap.InfoForChild(l_Child));
     if Result <> 0 then Break;
    end; // for i := 0 to f_Children.Count - 1 do
   end;//l_Line <> nil
  end//if Result = 0 then
  else
   begin
    if HasBaseLine then
     l_Inner := InnerFor(ParaX.ToList.Obj[0], l_Real)
    else
     l_Inner := pm_GetInner;
    if aPoint.HasBaseLine then
     l_PointInner := aPoint.InnerFor(aPoint.Obj^.ToList.Obj[0], l_Real)
    else
     l_PointInner := pm_GetInner;
    if (l_Inner = nil) or (l_PointInner = nil) then
    begin
     if l_Inner <> nil then
      Result := nev_PlusDiff;
     if l_PointInner <> nil then
      Result := nev_MinusDiff;
    end
    else
     Result := l_Inner.Diff(aView, l_PointInner, aMap.InfoForChild(l_Inner.Obj^));
   end;
//#UC END# *4AA785540310_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoDiff
{$IfEnd} // Defined(evUseVisibleCursors)

function TnevTableRowAnchor.GetInnerTop(const aChild: InevObject): InevBasePoint;
//#UC START# *4AEC34960358_4A5D7B82016A_var*
//#UC END# *4AEC34960358_4A5D7B82016A_var*
begin
//#UC START# *4AEC34960358_4A5D7B82016A_impl*
 Result := inherited GetInnerTop(aChild);
 if f_BaseLine <> nil then
  Result := f_BaseLine.InnerTop(aChild);
//#UC END# *4AEC34960358_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.GetInnerTop

{$If Defined(evUseVisibleCursors)}
procedure TnevTableRowAnchor.DoBottom(const aView: InevView);
//#UC START# *4B1CFD7B0332_4A5D7B82016A_var*
//#UC END# *4B1CFD7B0332_4A5D7B82016A_var*
begin
//#UC START# *4B1CFD7B0332_4A5D7B82016A_impl*
 LockScroll;
 try
  CheckBaseLine(aView);
  if f_BaseLine <> nil then
   f_BaseLine.Bottom(aView);
 finally
  UnlockScroll;
 end;//try..finally
//#UC END# *4B1CFD7B0332_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoBottom
{$IfEnd} // Defined(evUseVisibleCursors)

procedure TnevTableRowAnchor.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *4B1D0220010E_4A5D7B82016A_var*
//#UC END# *4B1D0220010E_4A5D7B82016A_var*
begin
//#UC START# *4B1D0220010E_4A5D7B82016A_impl*
 inherited DoAssignPoint(aView, aPoint);
 if aPoint.HasBaseLine then
 begin
  if f_BaseLine = nil then
   f_BaseLine := ParaX.BaseLine4Anchor;
  f_BaseLine.AssignPoint(aView, aPoint);
 end // if aPoint.HasBaseLine then
 else
  if aPoint.HasInner then
   InitByCursor(aView, aPoint.Inner);
//#UC END# *4B1D0220010E_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoAssignPoint

{$If Defined(evUseVisibleCursors)}
function TnevTableRowAnchor.DoIncLine(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean;
 const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4A5D7B82016A_var*
//#UC END# *4B1D18650208_4A5D7B82016A_var*
begin
//#UC START# *4B1D18650208_4A5D7B82016A_impl*
 CheckBaseLine(aView);
 if f_BaseLine <> nil then
  Result := f_BaseLine.IncLine(aView, theLine, aSmall)
 else
  Result := 0;
//#UC END# *4B1D18650208_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoIncLine
{$IfEnd} // Defined(evUseVisibleCursors)

procedure TnevTableRowAnchor.DoAddInner(const aView: InevView;
 const anInner: InevBaseLine4Anchor;
 anIndex: Integer;
 var aFirst: Boolean;
 aMode: TnevAddInnerMode);
//#UC START# *4B90DBFE00EF_4A5D7B82016A_var*
//#UC END# *4B90DBFE00EF_4A5D7B82016A_var*
begin
//#UC START# *4B90DBFE00EF_4A5D7B82016A_impl*
 CheckBaseLine(aView);
 if f_BaseLine <> nil then
  f_BaseLine.AddInner(aView, anInner, anIndex, aFirst, aMode);
//#UC END# *4B90DBFE00EF_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoAddInner

procedure TnevTableRowAnchor.DoCompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
//#UC START# *4B9625260325_4A5D7B82016A_var*
//#UC END# *4B9625260325_4A5D7B82016A_var*
begin
//#UC START# *4B9625260325_4A5D7B82016A_impl*
 CheckBaseLine(aView);
 if f_BaseLine <> nil then
  f_BaseLine.CompareWithOtherInner(aView, anMaxID);
//#UC END# *4B9625260325_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoCompareWithOtherInner

procedure TnevTableRowAnchor.DoInitByCursor(const aView: InevView;
 const anInnerPoint: InevBasePoint);
 {* Инициализируем базовую линию по курсору. }
//#UC START# *4C7361850250_4A5D7B82016A_var*
//#UC END# *4C7361850250_4A5D7B82016A_var*
begin
//#UC START# *4C7361850250_4A5D7B82016A_impl*
 CheckBaseLine(aView);
 if f_BaseLine <> nil then
  f_BaseLine.InitByCursor(aView, anInnerPoint);
//#UC END# *4C7361850250_4A5D7B82016A_impl*
end;//TnevTableRowAnchor.DoInitByCursor
{$IfEnd} // Defined(k2ForEditor)

end.
