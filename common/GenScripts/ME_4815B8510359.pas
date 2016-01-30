unit nevListFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevListFormatInfo.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevParaFormatInfo
 , nevFormatInfoArray
 , nevTools
 , nevFormatInfo
 , nevBase
;

type
 _nevChildSpy_Parent_ = TnevParaFormatInfo;
 {$Include nevChildSpy.imp.pas}
 TnevListFormatInfo = class(_nevChildSpy_)
  private
   f_Children: TnevFormatInfoArray;
  private
   procedure RecalcImpl;
   procedure CellChanged;
   function NearestInfoForChild(const aChild: InevObject): TnevListFormatInfo;
  protected
   function AllowTotalRecalc: Boolean; virtual;
   procedure FormatChild(const anAtom: InevPara;
    var theMap: TnevFormatInfo);
   procedure HRecalcChild(const aChild: InevPara;
    var sPW: Integer;
    var sPH: Integer); virtual;
   function ChildWidth(aChild: TnevFormatInfo): Integer; virtual;
   procedure ChildrenChanged; virtual;
    {* Нотификация о смене состава детей. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetMaxLinesCount: Integer; override;
   procedure DoRecalc(const aView: InevViewMetrics); override;
  public
   procedure ChildAdded(const aList: InevParaList;
    const aChild: InevPara); override;
   procedure ChildDeleted(const aList: InevParaList;
    const aChild: InevPara); override;
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); override;
   function GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo; override;
 end;//TnevListFormatInfo

implementation

uses
 l3ImplUses
 , SysUtils
 , nevLeafRenderInfo
 , nevTextParaRenderInfo
 , nevRubberCellsRenderInfo
 , nevTableRowRenderInfo
 , k2Tags
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , nevTableCellFormatInfo
 , l3MinMax
 , TableRow_Const
 , CommentPara_Const
 , SBS_Const
 , SBSRow_Const
 , ReqRow_Const
 , TableCell_Const
 , SBSCell_Const
 , TextPara_Const
 , nevZoomedCellsRenderInfo
 , nevFacade
 , nevZoomedRubberCellsRenderInfo
 , evSectionPara
 , nevFormatInfoFactory
 , k2Base
 , Table_Const
;

{$Include nevChildSpy.imp.pas}

function TnevListFormatInfo.AllowTotalRecalc: Boolean;
//#UC START# *4E7095FC023D_4815B8510359_var*
//#UC END# *4E7095FC023D_4815B8510359_var*
begin
//#UC START# *4E7095FC023D_4815B8510359_impl*
 Result := true;
//#UC END# *4E7095FC023D_4815B8510359_impl*
end;//TnevListFormatInfo.AllowTotalRecalc

procedure TnevListFormatInfo.RecalcImpl;
//#UC START# *4E709676009E_4815B8510359_var*
//#UC END# *4E709676009E_4815B8510359_var*
begin
//#UC START# *4E709676009E_4815B8510359_impl*
 l_FixedWidth := Obj.AsObject.BoolA[k2_tiFixedWidth];
 if AllowTotalRecalc OR
    InPara(k2_typTable) then
 begin
  l_Space := Self.Get_Spacing;
  l_Vert := Obj.IsVertical;
  l_Delta := l_Space.TopLeft;
  l_sPH := 0;
  if l_FixedWidth then
   l_sPW := Self.rLimitWidth
  else
   l_sPW := 0;
  if l_Vert then
   RecalcVert
  else
   RecalcHorz;
  Inc(l_sPH, l_Delta.Y);
  Inc(l_sPH, l_Space.Bottom);
  Self.wHeight(l_sPH);
  if not l_FixedWidth then
  begin
   Inc(l_sPW, l_Delta.X);
   Inc(l_sPW, l_Space.Right);
  end;//not l_FixedWidth
  Self.wWidth(l_sPW);
 end//AllowTotalRecalc
 else
 begin
  Self.wHeight(0);
  if l_FixedWidth then
   Self.wWidth(Self.rLimitWidth)
  else
   Self.wWidth(0);
 end;//AllowTotalRecalc
//#UC END# *4E709676009E_4815B8510359_impl*
end;//TnevListFormatInfo.RecalcImpl

procedure TnevListFormatInfo.FormatChild(const anAtom: InevPara;
 var theMap: TnevFormatInfo);
//#UC START# *4E70969C03A0_4815B8510359_var*
//#UC END# *4E70969C03A0_4815B8510359_var*
begin
//#UC START# *4E70969C03A0_4815B8510359_impl*
 theMap := Self.GetInfoForChild(anAtom);
 // - мапа сама себя должна заполнить - http://mdp.garant.ru/pages/viewpage.action?pageId=89109263
 //   дернув Builder'а.
//#UC END# *4E70969C03A0_4815B8510359_impl*
end;//TnevListFormatInfo.FormatChild

procedure TnevListFormatInfo.HRecalcChild(const aChild: InevPara;
 var sPW: Integer;
 var sPH: Integer);
//#UC START# *4E7096D600BD_4815B8510359_var*
var
 l_PH  : Integer;
 l_Map : TnevFormatInfo;
//#UC END# *4E7096D600BD_4815B8510359_var*
begin
//#UC START# *4E7096D600BD_4815B8510359_impl*
 FormatChild(aChild, l_Map);
 Inc(sPW, l_Map.Width);
 l_PH := l_Map.Height;
 if (sPH < l_PH) then
  sPH := l_PH;
//#UC END# *4E7096D600BD_4815B8510359_impl*
end;//TnevListFormatInfo.HRecalcChild

procedure TnevListFormatInfo.CellChanged;
//#UC START# *5108C0320162_4815B8510359_var*
//#UC END# *5108C0320162_4815B8510359_var*
begin
//#UC START# *5108C0320162_4815B8510359_impl*
 wForce([nev_ripHeight, nev_ripWidth, nev_ripCellParams]);
 ForceParent;
//#UC END# *5108C0320162_4815B8510359_impl*
end;//TnevListFormatInfo.CellChanged

function TnevListFormatInfo.NearestInfoForChild(const aChild: InevObject): TnevListFormatInfo;
//#UC START# *4817250302EF_4815B8510359_var*
var
 l_Point : InevBasePoint;
 l_BP    : InevBasePoint;
 l_FI    : TnevFormatInfo;
//#UC END# *4817250302EF_4815B8510359_var*
begin
//#UC START# *4817250302EF_4815B8510359_impl*
 Result := nil; 
 l_Point := aChild.MakePoint;
 if (l_Point <> nil) then
 // - это не бред, такое случается при нотификации из _TevDocumentPartGenerator.FinishInsertion
 begin
  l_BP := l_Point.PointToParent(Obj);
  if (l_BP <> nil) then
  // - это тоже не бред, такое случается при вставке вложенных таблиц - http://mdp.garant.ru/pages/viewpage.action?pageId=97353892 
  begin
   if l_BP.HasInner then
   // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=106988150
   begin
    l_Point := l_BP.Inner;
    l_FI := f_Children[l_Point.Obj.PID];
    if (l_FI <> nil) then
    begin
     Assert(l_FI.Obj.AsObject.IsSame(l_Point.Obj^.AsObject));
     Result := (l_FI As TnevListFormatInfo);
     // - здесь As обязательно !
    end;//l_FI <> nil
   end;//l_BP.HasInner
  end;//l_BP <> nil
 end;//l_Point <> nil
//#UC END# *4817250302EF_4815B8510359_impl*
end;//TnevListFormatInfo.NearestInfoForChild

function TnevListFormatInfo.ChildWidth(aChild: TnevFormatInfo): Integer;
//#UC START# *4820985D0238_4815B8510359_var*
var
 l_Space  : TnevRect;
 l_SB     : InevSectionBreaks;
 l_Inited : Boolean;
 l_Holder : InevObjectHolder;
 l_Break  : InevObject;
 l_Obj    : InevObject;
//#UC END# *4820985D0238_4815B8510359_var*
begin
//#UC START# *4820985D0238_4815B8510359_impl*
 l_Inited := false;
 with aChild.Obj do
  if IsList then
  begin
   if AsObject.BoolA[k2_tiFixedWidth] then
    if not Tk2Type(AsObject.TagType).Prop[k2_tiWidth].ReadOnly then
    begin
     Result := AsObject.IntA[k2_tiWidth];
     l_Inited := true;
     Exit;
     // - наверное надо выйти - т.к. незачем учитывать отступы родителя, т.к. мы уже
     //   нашли собственную фиксированную ширину ребёнка.
    end//not TagType.Prop[k2_tiWidth].ReadOnly
    else
     Assert(false);
     // - что за странная проверка - скорее всего от старой логики блоков
  end;//IsList
 if not l_Inited then
 begin
  if not Metrics.IsWebStyle AND
     not Obj.AsObject.BoolA[k2_tiFixedWidth] AND
     not Metrics.InfoCanvas.Printing
     //not Metrics.FormatCanvas.Printing
     then
  begin
   // - здесь надо найти подходящий разрыв раздела,
   //   но если мы не находимся в процессе печати,
   //   т.к. если мы печатаем, то все размеры уже актуальные
   l_Holder := (Obj As InevObject).Holder;
   if (l_Holder <> nil) then
   begin
    l_SB := l_Holder.SectionBreaks;
    if (l_SB <> nil) then
    begin
     l_Obj := aChild.Obj As InevObject;
     if l_Obj.AppliesToMaxWidth then
     begin
      Result := High(Integer) div 2;
      Exit;
     end//l_Obj.AppliesToMaxWidth
     else
     if (aChild.SectionBreak <> nil) then
     begin
      l_Break := aChild.SectionBreak;
      if (not l_Break.AsObject.IsValid OR
          (l_Break.OwnerObj.AsObject.IsValid AND (l_Break.PID >= 0))) then
       l_Inited := true
      else
       l_Break := nil;
     end;//aChild.SectionBreak <> nil
     if not l_Inited then
     begin
      if l_SB.GetSectionBreak(l_Obj, l_Break) then
      begin
       l_Inited := true;
       if not aChild.Obj.AsObject.IsSame(l_Break.AsObject) then
        aChild.SectionBreak := l_Break;
      end//l_SB.GetSectionBreak(aChild, l_Break)
      else
       aChild.SectionBreak := nil;
     end;//l_Inited
     if l_Inited then
     begin
      Result := evSectionExtent(l_Break.AsObject).X;
      l_Space := Self.RootFormatInfo.Spacing;
      // - учитываем отступы документа
      Dec(Result, l_Space.Left);
      Dec(Result, l_Space.Right);
      Exit;
     end;//l_Inited
    end;//l_SB <> nil
   end;//l_Holder <> nil
  end; //if not Metrics.IsWebStyle then
  if not l_Inited then
   Result := Self.LimitWidth;
 end;//not l_Inited
 l_Space := Self.Spacing;
 Dec(Result, l_Space.Left);
 Dec(Result, l_Space.Right);
//#UC END# *4820985D0238_4815B8510359_impl*
end;//TnevListFormatInfo.ChildWidth

procedure TnevListFormatInfo.ChildrenChanged;
 {* Нотификация о смене состава детей. }
//#UC START# *482161BE001C_4815B8510359_var*
//#UC END# *482161BE001C_4815B8510359_var*
begin
//#UC START# *482161BE001C_4815B8510359_impl*
 wForce([nev_ripHeight, nev_ripWidth]);
 ForceParent;
 // - надо переформатировать список параграфов
//#UC END# *482161BE001C_4815B8510359_impl*
end;//TnevListFormatInfo.ChildrenChanged

procedure TnevListFormatInfo.ChildAdded(const aList: InevParaList;
 const aChild: InevPara);
//#UC START# *481710BB0076_4815B8510359_var*
var
 l_FI : TnevListFormatInfo;
//#UC END# *481710BB0076_4815B8510359_var*
begin
//#UC START# *481710BB0076_4815B8510359_impl*
 if (f_Children <> nil) then
 begin
  if Obj.AsObject.IsSame(aList.AsObject) then
  begin
   f_Children.ChildAdded(aChild.PID);
   ChildrenChanged; 
  end//Obj.IsSame(aList)
  else
  begin
   // - здесь надо найти подходящего родителя
   l_FI := NearestInfoForChild(aChild);
   if (l_FI <> nil) then
    l_FI.ChildAdded(aList, aChild);
  end;//Obj.IsSame(aList)
 end;//f_Children <> nil
//#UC END# *481710BB0076_4815B8510359_impl*
end;//TnevListFormatInfo.ChildAdded

procedure TnevListFormatInfo.ChildDeleted(const aList: InevParaList;
 const aChild: InevPara);
//#UC START# *481710C100FB_4815B8510359_var*
var
 l_FI : TnevListFormatInfo;
//#UC END# *481710C100FB_4815B8510359_var*
begin
//#UC START# *481710C100FB_4815B8510359_impl*
 if (f_Children <> nil) then
 begin
  if Obj.AsObject.IsSame(aList.AsObject) then
  begin
   f_Children.ChildDeleted(aChild.PID);
   ChildrenChanged;
  end//Obj.IsSame(aList)
  else
  begin
   // - здесь надо найти подходящего родителя
   l_FI := NearestInfoForChild(aChild);
   if (l_FI <> nil) then
    l_FI.ChildDeleted(aList, aChild);
  end;//Obj.IsSame(aList)
 end;//f_Children <> nil
//#UC END# *481710C100FB_4815B8510359_impl*
end;//TnevListFormatInfo.ChildDeleted

procedure TnevListFormatInfo.DoInvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *48172A690313_4815B8510359_var*
var
 l_FI : TnevFormatInfo;
//#UC END# *48172A690313_4815B8510359_var*
begin
//#UC START# *48172A690313_4815B8510359_impl*
 if aShape.AsObject.IsSame(Obj.AsObject) then
 begin
  if (nev_spExtent in aParts) then
   ChildrenChanged;
  if (nev_spCellExtent in aParts) then
   CellChanged;
 end//aShape.IsSame(Obj)
 else
 if (f_Children <> nil) then
 begin
  l_FI := nil;
  if Obj.AsObject.IsSame(aShape.OwnerObj.AsObject) then
   l_FI := f_Children[aShape.PID]
  else
   // - здесь надо найти подходящего родителя
   l_FI := NearestInfoForChild(aShape);
  if (l_FI <> nil) then
   l_FI.DoInvalidateShape(aShape, aParts);
 end;//f_Children <> nil
//#UC END# *48172A690313_4815B8510359_impl*
end;//TnevListFormatInfo.DoInvalidateShape

procedure TnevListFormatInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4815B8510359_var*
//#UC END# *479731C50290_4815B8510359_var*
begin
//#UC START# *479731C50290_4815B8510359_impl*
 if (f_Children <> nil) then
  f_Children.ClearReferencesToParentFormatInfo;
 FreeAndNil(f_Children);
 inherited;
//#UC END# *479731C50290_4815B8510359_impl*
end;//TnevListFormatInfo.Cleanup

function TnevListFormatInfo.GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo;
//#UC START# *4815C94A027A_4815B8510359_var*
var
 l_PID   : Integer;
 l_Child : TnevFormatInfo;
//#UC END# *4815C94A027A_4815B8510359_var*
begin
//#UC START# *4815C94A027A_4815B8510359_impl*
 Assert(not aChild.IsDecorationElement);
 l_PID := aChild.PID;
 if (l_PID < 0) then
  Result := nil
 else
 begin
  if not aChild.AsObject.Owner.IsSame(Obj.AsObject) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=110986032
  // вообще-то это заплатка, м.б. её можно будет убрать после починки:
  //  http://mdp.garant.ru/pages/viewpage.action?pageId=110986057
  begin
   Result := nil;
   Exit;
  end;//not aChild.OwnerObj.IsSame(Obj)
  Assert(aChild.AsObject.Owner.IsSame(Obj.AsObject));
  if (f_Children = nil) then
   f_Children := TnevFormatInfoArray.Create;
  l_Child := f_Children[l_PID];
  Result := l_Child;
  if (Result <> nil) AND not Result.Obj.AsObject.IsSame(aChild.AsObject) then
  // - думаем, что документ изменился из-за переключения баз и пытаемся
  //   исправить эту ситуацию.
  // http://mdp.garant.ru/pages/viewpage.action?pageId=91850255
  begin
   f_Children[l_PID] := nil;
   Result := nil;
  end;//Result <> nil
  if (Result = nil) then
  begin
   l_Child := nil;
   try
    l_Child := TnevFormatInfoFactory.CreateFormatInfo(aChild, Self, Metrics);
    Assert(l_Child <> nil);
    f_Children[l_PID] := l_Child;
    l_Child.LimitWidth := ChildWidth(l_Child);
    Result := l_Child;
   finally
    FreeAndNil(l_Child);
   end;//try..finally
  end//Result = nil
  else
  begin
   Assert(Result.Obj.AsObject.IsSame(aChild.AsObject));
   l_Child.LimitWidth := ChildWidth(l_Child);
   // - закомментировано, ибо - http://mdp.garant.ru/pages/viewpage.action?pageId=178323663
  end;//Result = nil
 end;//l_PID < 0
//#UC END# *4815C94A027A_4815B8510359_impl*
end;//TnevListFormatInfo.GetInfoForChild

function TnevListFormatInfo.GetMaxLinesCount: Integer;
//#UC START# *4BC45843011E_4815B8510359_var*
var
 l_LinesCount : Integer absolute Result;

 function lp_IncLinesCount(const anItem: InevPara; anIndex: Integer): Boolean;
 var
  l_CI : TnevFormatInfoPrim;
 begin//lp_IncLinesCount
  Result := True;
  l_CI := InfoForChild(anItem);
  Assert(l_CI <> nil);
  Inc(l_LinesCount, l_CI.MaxLinesCount);
 end;//lp_IncLinesCount

//#UC END# *4BC45843011E_4815B8510359_var*
begin
//#UC START# *4BC45843011E_4815B8510359_impl*
 l_LinesCount := inherited GetMaxLinesCount;
 (Obj As InevObject).AsPara.AsList.IterateParaF(nevL2PIA(@lp_IncLinesCount));
//#UC END# *4BC45843011E_4815B8510359_impl*
end;//TnevListFormatInfo.GetMaxLinesCount

procedure TnevListFormatInfo.DoRecalc(const aView: InevViewMetrics);
//#UC START# *4E7094780214_4815B8510359_var*
//#UC END# *4E7094780214_4815B8510359_var*
begin
//#UC START# *4E7094780214_4815B8510359_impl*
 RecalcImpl;
 Self.wMap(nil);
//#UC END# *4E7094780214_4815B8510359_impl*
end;//TnevListFormatInfo.DoRecalc

end.
