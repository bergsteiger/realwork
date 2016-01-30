unit nevTextParaRenderInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTextParaRenderInfo.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevLeafRenderInfo
 , nevBase
 , l3Variant
 , nevFormatInfoList
 , nevFormatInfo
 , nevTools
;

type
 TnevTextParaRenderInfo = class(TnevLeafRenderInfo)
  private
   f_L: InevLines;
   f_VS: Tl3Variant;
   f_Children: TnevFormatInfoList;
  private
   function GetBlockHeaderIndent: Integer;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetViewSegmentsPlace: Tl3Variant; override;
   function pm_GetLinesPlace: InevLines; override;
   procedure pm_SetLinesPlace(const aValue: InevLines); override;
   function GetMaxLinesCount: Integer; override;
   function Get_FirstIndent: Integer; override;
   function pm_GetlocSpacing: TnevRect; override;
   procedure DoRecalc(const aView: InevViewMetrics); override;
  public
   function GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo; override;
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); override;
   procedure wForce(aParts: TnevRenderingInfoParts); override;
 end;//TnevTextParaRenderInfo

implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 {$If Defined(k2ForEditor)}
 , evSegLst
 {$IfEnd} // Defined(k2ForEditor)
 , k2Base
 , l3String
 , SysUtils
 , TextPara_Const
 , LeafPara_Const
 , nevFormatInfoFactory
 , TextSegment_Const
 , l3LineArray
 , l3Types
 , l3Interfaces
 , TableCell_Const
 , evTextParaConst
 , l3Chars
 , l3Utils
 , nevSegmentObject
 , l3MinMax
 , l3SingleLineInfo
 {$If Defined(k2ForEditor)}
 , evTextParaTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evAACContentUtils
 {$IfEnd} // Defined(k2ForEditor)
;

function TnevTextParaRenderInfo.GetBlockHeaderIndent: Integer;
//#UC START# *55C1CF0C00C1_481F174D01BF_var*
//#UC END# *55C1CF0C00C1_481F174D01BF_var*
begin
//#UC START# *55C1CF0C00C1_481F174D01BF_impl*
 Result := -EvParentGetLeftIndent(Obj.AsObject) + cnPlusIconSpace;
//#UC END# *55C1CF0C00C1_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.GetBlockHeaderIndent

procedure TnevTextParaRenderInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_481F174D01BF_var*
//#UC END# *479731C50290_481F174D01BF_var*
begin
//#UC START# *479731C50290_481F174D01BF_impl*
 if (f_Children <> nil) then
  f_Children.ClearReferencesToParentFormatInfo;
 FreeAndNil(f_Children);
 f_L := nil;
 FreeAndNil(f_VS);
 inherited;
//#UC END# *479731C50290_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.Cleanup

function TnevTextParaRenderInfo.GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo;
//#UC START# *4815C94A027A_481F174D01BF_var*
var
 l_Index : Integer;
 l_Item  : TnevFormatInfo;  
//#UC END# *4815C94A027A_481F174D01BF_var*
begin
//#UC START# *4815C94A027A_481F174D01BF_impl*
 Assert(aChild.AsObject.IsKindOf(k2_typLeafPara) OR
        aChild.AsObject.IsKindOf(k2_typTextSegment));
 if (f_Children = nil) then
  f_Children := TnevFormatInfoList.Create;
 with f_Children do
 begin
  for l_Index := 0 to Pred(Count) do
  begin
   l_Item := Items[l_Index];
   if l_Item.Obj.AsObject.IsSame(aChild.AsObject) then
   begin
    Result := l_Item;
    Exit;
   end;//l_Item.f_Obj.IsSame(aShape)
  end;//for l_Index
  l_Item := TnevFormatInfoFactory.CreateFormatInfo(aChild, Self, Metrics);
  try
   l_Item.LimitWidth := LimitWidth;
          // ^ - может быть здесь надо отступы учесть
   Add(l_Item);
   Result := l_Item;
  finally
   FreeAndNil(l_Item);
  end;//try..finally
 end;//with f_Children
//#UC END# *4815C94A027A_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.GetInfoForChild

procedure TnevTextParaRenderInfo.DoInvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *48172A690313_481F174D01BF_var*
//#UC END# *48172A690313_481F174D01BF_var*
begin
//#UC START# *48172A690313_481F174D01BF_impl*
 if (nev_spSegments in aParts) then
 begin
  if (f_VS <> nil) then
  begin
   FreeAndNil(f_VS);
   Include(aParts, nev_spExtent);
  end;//f_VS <> nil
 end;//nev_spSegments in aParts
 inherited;
//#UC END# *48172A690313_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.DoInvalidateShape

procedure TnevTextParaRenderInfo.wForce(aParts: TnevRenderingInfoParts);
//#UC START# *48175C1302A3_481F174D01BF_var*
//#UC END# *48175C1302A3_481F174D01BF_var*
begin
//#UC START# *48175C1302A3_481F174D01BF_impl*
 if (([nev_ripWidth, nev_ripLines, nev_ripHeight] * aParts) <> []) then
  FreeAndNil(f_Children);
 inherited;
//#UC END# *48175C1302A3_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.wForce

function TnevTextParaRenderInfo.pm_GetViewSegmentsPlace: Tl3Variant;
//#UC START# *4821DB2500CB_481F174D01BFget_var*
var
 l_Super       : Tl3Variant absolute Result;
 l_SuperHandle : Integer;
 l_Exclude     : TevNormalSegLayerHandleSet;
 l_TextPara    : InevTextPara;

 function _AddLayer(SegLst: Tl3Variant; Index: Integer): Boolean; 

  function _AddSegment(Seg: Tl3Variant; Index: Integer): Boolean; 
  var
   S1 : Tl3Variant;
  begin
   S1 := Seg.CloneTag.AsObject;
   try
    evSegmentsLayer_AddSegment(l_TextPara.AsObject, l_Super, S1);
   finally
    S1 := nil;
   end;{try..finally}
   Result := true;
  end;{_AddSegment}

 var
  l_Handle : TevSegmentHandle;
 begin
  l_Handle := TevSegmentHandle(SegLst.IntA[k2_tiHandle]);
  if (l_Handle > ev_slSuperposition) AND not (l_Handle in l_Exclude) then
   SegLst.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_AddSegment));
  Result := true;
 end;{_AddLayer}

var
 l_Segments : Tl3Variant;
 l_CC       : Integer;
//#UC END# *4821DB2500CB_481F174D01BFget_var*
begin
//#UC START# *4821DB2500CB_481F174D01BFget_impl*
 if (f_VS = nil) then
 begin
  if not Obj.AsObject.QT(InevTextPara, l_TextPara) then
   Assert(false);
  l_Segments := l_TextPara.AsObject.Attr[k2_tiSegments];
  if l_Segments.IsValid then
  begin
   if not l3IsNil(l_TextPara.Text) then
   begin
    l_CC := l_Segments.ChildrenCount;
    if (l_CC <= 0) then
    begin
     // - нет никакого оформления, значит и суперпозиция не нужна
     Result := k2NullTag;
     l_TextPara.AsObject.AttrW[k2_tiSegments, nil] := nil;
     // - зачищаем странные сегменты
    end//l_CC <= 0
    else
    begin
     l_SuperHandle := 0;
     if Self.Parent <> nil then
      l_Exclude := Metrics.ExcludeSuper
     else
      l_Exclude := [];
     if (l_Exclude = []) AND (l_CC = 1) then
     begin
      // - не нужно копировать сегменты в суперпозицию
      Result := l_Segments.Child[0];
     end
     else
     begin
      Result := l_Segments.rAtomEx([k2_tiChildren, k2_tiHandle, l_SuperHandle]);
      if (Result = nil) OR not Result.IsValid then
      begin
       Result := l_Segments.cAtomEx([k2_tiChildren, k2_tiHandle, l_SuperHandle], nil);
       l_Segments.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_AddLayer));
       Result.SetRef(f_VS);
       // - чтобы вовремя сохранить ссылку на объект
       l_Segments.DeleteChild(Result);
      end//not Result.IsValid
      else
       Assert(false);
     end;//l_Exclude = []..
    end;//l_CC <= 0
   end//not l3IsNil(Text)
   else
    Result := k2NullTag;
  end//l_Segments.IsValid
  else
   Result := k2NullTag;
  Result.SetRef(f_VS);
 end//f_VS = nil
 else
  Result := f_VS;
//#UC END# *4821DB2500CB_481F174D01BFget_impl*
end;//TnevTextParaRenderInfo.pm_GetViewSegmentsPlace

function TnevTextParaRenderInfo.pm_GetLinesPlace: InevLines;
//#UC START# *4821DE24003D_481F174D01BFget_var*
//#UC END# *4821DE24003D_481F174D01BFget_var*
begin
//#UC START# *4821DE24003D_481F174D01BFget_impl*
 Result := f_L;
//#UC END# *4821DE24003D_481F174D01BFget_impl*
end;//TnevTextParaRenderInfo.pm_GetLinesPlace

procedure TnevTextParaRenderInfo.pm_SetLinesPlace(const aValue: InevLines);
//#UC START# *4821DE24003D_481F174D01BFset_var*
//#UC END# *4821DE24003D_481F174D01BFset_var*
begin
//#UC START# *4821DE24003D_481F174D01BFset_impl*
 f_L := aValue;
//#UC END# *4821DE24003D_481F174D01BFset_impl*
end;//TnevTextParaRenderInfo.pm_SetLinesPlace

function TnevTextParaRenderInfo.GetMaxLinesCount: Integer;
//#UC START# *4BC45843011E_481F174D01BF_var*
var
 l_Lines: InevLines;
//#UC END# *4BC45843011E_481F174D01BF_var*
begin
//#UC START# *4BC45843011E_481F174D01BF_impl*
 l_Lines := Lines;
 if l_Lines = nil then
  Result := 1
 else
 begin
  Result := l_Lines.Count;
  Assert(Result > 0);
 end;//l_Lines = nil
//#UC END# *4BC45843011E_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.GetMaxLinesCount

function TnevTextParaRenderInfo.Get_FirstIndent: Integer;
//#UC START# *4E5E57E503E4_481F174D01BFget_var*
//#UC END# *4E5E57E503E4_481F174D01BFget_var*
begin
//#UC START# *4E5E57E503E4_481F174D01BFget_impl*
 if EvHeaderTextPara(Obj) then
  Result := GetBlockHeaderIndent
 else
 begin
  Result := inherited Get_FirstIndent;
  if (Metrics.AACLike = nev_aacLeft) then
   Result := Result + cnAACContentsLeftIndent;
 end;
//#UC END# *4E5E57E503E4_481F174D01BFget_impl*
end;//TnevTextParaRenderInfo.Get_FirstIndent

function TnevTextParaRenderInfo.pm_GetlocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_481F174D01BFget_var*
//#UC END# *4E5F3D1102B8_481F174D01BFget_var*
begin
//#UC START# *4E5F3D1102B8_481F174D01BFget_impl*
 Result := inherited pm_GetLocSpacing;
 if EvHeaderTextPara(Obj) then
  Result.Left := GetBlockHeaderIndent;
 if (Metrics.AACLike = nev_aacLeft) then
 begin
  Result.Left := Result.Left + cnAACContentsLeftIndent;
  Result.Right := Result.Right + cnAACContentsRigthIndent;
  if EvIsAACHyperlink(Obj.AsObject, True) then
  begin
   Result.Top := Result.Top + cnTopAACItem;
   Result.Bottom := Result.Bottom + cnTopAACItem;
  end // if EvIsParaHyperlink(Obj.AsObject) then
  else
   if EvAACNeedSpaceBefore(Obj.AsObject) then
    Result.Top := Result.Top + cnAACSeparatorSpace;
 end; // if (Metrics.AACLike = nev_aacLeft) and EvIsParaHyperlink(Obj) then
//#UC END# *4E5F3D1102B8_481F174D01BFget_impl*
end;//TnevTextParaRenderInfo.pm_GetlocSpacing

procedure TnevTextParaRenderInfo.DoRecalc(const aView: InevViewMetrics);
//#UC START# *4E7094780214_481F174D01BF_var*
var
 l_Height       : Integer;
 l_InfoCanvas   : InevInfoCanvas;
 l_Map          : TevLineArray;
 l_InLimitWidth : Integer;

 procedure DoFormat{(const ETAOIN_SHRDLU_aSegmentAndFontTool: InevFontTool)};   
 var
  l_SoftEnterCount : Integer;
  l_Str            : Tl3PCharLen;    // - Строка параграфа.
  l_PrevWrap       : PAnsiChar;
  l_FontIndexes    : Tl3FontIndexes;
  l_AllowHyphen    : Boolean;
  l_ITabInfo       : Il3TabInfo;
  l_MTabInfo       : Il3TabInfo;
  l_MeasureCanvas  : InevInfoCanvas;
  l_CharSize       : Integer;
  l_Spaces         : TnevRect;

  procedure FormatStr(var theLimitWidth : Integer;
                      const aCurFont    : InevFont;
                      IsSeg             : Boolean;
                      var aStr          : Tl3PCharLen;
                      var theStrExtent  : TnevPoint);   
  var
   l_AddHyphen : Boolean;
   l_StrExtent : TnevPoint;

   procedure AddLine;
   begin{AddLine}
    l_PrevWrap := aStr.S;
    if (theStrExtent.Y = 0) then
     theStrExtent.Y := l_MeasureCanvas.AverageCharHeight;
    l_Map.Add((aStr.S - l_Str.S) div l_CharSize,
              theStrExtent, l_FontIndexes, l_AddHyphen);

    l_InfoCanvas.FinishTabs(l_ITabInfo);
    l_InfoCanvas.StartTabs(l_ITabInfo, Obj.TabStops);
    // - Переоткрываем новую строку

    if (l_InfoCanvas <> l_MeasureCanvas) then 
    begin
     l_MeasureCanvas.FinishTabs(l_MTabInfo);
     l_MeasureCanvas.StartTabs(l_MTabInfo, Obj.TabStops);
     // - Переоткрываем новую строку
    end;//l_InfoCanvas <> l_MeasureCanvas

    Inc(l_Height, theStrExtent.Y);
    theStrExtent := nevPt0;
    l_StrExtent := nevPt0;
    l_FontIndexes := [l_InfoCanvas.Font.Index];
    theLimitWidth := l_InLimitWidth - l_Spaces.Left;
   end;//AddLine

  var
   l_WrappedStr : Tl3PCharLen;
   l_OTabInfo   : Il3TabInfo;

   procedure MeasureStr(aNeedTrim: Boolean);
   var
    l_Str     : Tl3WString;
    l_TabInfo : Il3TabInfo;
    l_Len     : Integer;
   begin//MeasureStr
    if aNeedTrim then
     l_Str := l3RTrim(l_WrappedStr)
    else
     l_Str := l_WrappedStr;
    if (l_InfoCanvas = l_MeasureCanvas) then
    begin
     l_MeasureCanvas.StartTabs(l_TabInfo, l_OTabInfo);
     with l_MeasureCanvas.TextExtent(l_Str).P do
     begin
      Inc(theStrExtent.P.X, X);
      Inc(l_StrExtent.P.X, X);
      if l_AddHyphen then
      begin
       Inc(theStrExtent.P.X, evHyphenWidth);
       Inc(l_StrExtent.P.X, evHyphenWidth);
      end;//l_AddHyphen
      if (Y > theStrExtent.Y) then
      begin
       theStrExtent.Y := Y;
       l_StrExtent.Y := Y;
      end;//Y > theStrExtent.Y
     end;//with l_MeasureCanvas.TextExtent(l_Str).P
     l_MeasureCanvas.FinishTabs(l_TabInfo);
    end//l_InfoCanvas = l_MeasureCanvas
    else
    begin
     l_MeasureCanvas.Font := l_InfoCanvas.Font;
     l_MeasureCanvas.StartTabs(l_TabInfo, l_OTabInfo);
     with l_MeasureCanvas.TextExtent(l_Str).P do
     begin
      Inc(theStrExtent.P.X, X);
      if l_AddHyphen then 
       Inc(theStrExtent.P.X, evHyphenWidth);
      if (Y > theStrExtent.Y) then
       theStrExtent.Y := Y;
     end;//with l_MeasureCanvas.TextExtent(l_Str).P
     l_MeasureCanvas.FinishTabs(l_TabInfo);
     l_InfoCanvas.StartTabs(l_TabInfo, l_OTabInfo);
     with l_InfoCanvas.TextExtent(l_Str).P do
     begin
      Inc(l_StrExtent.P.X, X);
      if l_AddHyphen then
       Inc(l_StrExtent.P.X, evHyphenWidth);
      if (Y > l_StrExtent.Y) then
       l_StrExtent.Y := Y;
     end;//with l_MeasureCanvas.TextExtent(l_Str).P
     l_InfoCanvas.FinishTabs(l_TabInfo);
    end;//l_InfoCanvas = l_MeasureCanvas
   end;//MeasureStr

  var
   l_WrapPos      : Integer;  { - Позиция соответствующая максимальной ширине. }
   l_SoftEnterStr : PAnsiChar; { - Позиция SoftEnter'а. }
   l_NoTabs       : Boolean;
   l_InTable      : Boolean;
  begin//FormatStr
   Assert(aStr.SLen >= 0);
   l_StrExtent := theStrExtent;
   with l_InfoCanvas do
   begin
    Font := aCurFont;
    Include(l_FontIndexes, Font.Index);
   end;//with l_InfoCanvas
   l_NoTabs := False;
   while True do
   begin
    l_AddHyphen := False;
    l_OTabInfo := l_InfoCanvas.TabInfo;
    l_WrapPos := l_InfoCanvas.Pos2IndexQ(theLimitWidth - l_StrExtent.X, aStr, l_NoTabs);
    Assert(l_WrapPos >= 0);
    //l_WrapPos := l_InfoCanvas.Pos2Index(theLimitWidth - l_StrExtent.X, aStr);
    if (l_WrapPos <= 0) then
    begin
     if (l_StrExtent.X <= 0) then
      l_WrapPos := 1
     else
     if l3Same(aStr, l_Str) then
     //if (aStr.S = l_Str.S) then
     // - если често - я не до конца понял, что это за проверка и какая из двух
     //   проверок правильнее.
      Break
{     else
     if (aStr.SLen > 0) then
      Assert(false)};
    end;//l_WrapPos <= 0
    l_WrappedStr := aStr;
    if (l_WrapPos >= aStr.SLen) then
     l_WrappedStr.SLen := l_WrapPos
    else
     l_WrappedStr.SLen := l3Utils.l3FindNextLine(aStr, l_WrapPos);
    // - Нашли где должна кончаться строка без учета SoftEnter.
    if (l_SoftEnterCount > 0) then
    begin
     // - Еще есть SoftEnter'ы - надо их обработать.
     l_SoftEnterStr := ev_lpScan(cc_SoftEnter, l_WrappedStr.S, l_WrappedStr.SLen);
     if (l_SoftEnterStr <> nil) then
     begin
      Dec(l_SoftEnterCount);
      l_WrappedStr.SLen := l_SoftEnterStr - l_WrappedStr.S;
      aStr.Init(l_SoftEnterStr + 1, aStr.SLen - (l_WrappedStr.SLen + 1), aStr.SCodePage);
      MeasureStr(False); // - Измеряем размеры полученной строки.
      AddLine;  // - Добавляем строку с SoftEnter'ом.
      if (aStr.SLen = 0) then
       Break // - Строка закончилась
      else
       Continue; // - Продолжаем форматировать остаток строки.
     end;//l_SoftEnterStr <> nil
    end;//l_SoftEnterCount > 0
    l_InTable := Obj.AsObject.Owner.IsValid and Obj.AsObject.Owner.IsKindOf(k2_typTableCell); 
    if (l_WrapPos < aStr.SLen) then
    begin
     // - Обрабатываем переносы по слогам
     if l_AllowHyphen then
     begin
      case l3SplitBySlog(aStr, l_WrapPos, l_InTable) of
       l3_ssHyphen : l_WrappedStr.SLen := l_WrapPos;
       l3_ssYes    :
       begin
        l_WrappedStr.SLen := l_WrapPos;
        l_AddHyphen := True;
       end;//l3_ssYes
      end;//case l3SplitBySlog(aStr, l_WrapPos)
     end//l_AllowHyphen
     else
     (*with l_WrappedStr do
      if not evWhiteSpace(S[Pred(SLen)]) then*)
      if (l_StrExtent.X <= 0) then
        l_AddHyphen := l3SplitBySlog(aStr, l_WrappedStr.SLen, l_InTable) = l3_ssYes;
    end;//l_AllowHyphen
    aStr.Shift(l_WrappedStr.SLen);
    if (aStr.SLen = 0) then
    begin
     // - Строка вся кончилась. 
     MeasureStr(False); // - Измеряем размеры полученной строки. 
     Break; // - Выходим, т.к. добавлять нецелую строку не надо. 
    end;//aStr.SLen
    if not l_AddHyphen AND
       // не было переноса
       (l_WrappedStr.S > l_PrevWrap) AND
       (l_WrappedStr.SLen > 0) then
       // - предыдущие две проверки защищают от зацикливания и выхода за границы
    begin
     if not l3IsWhiteSpace((aStr.S-1)^) then
      // - разрезали посередине слова
      if l3IsWhiteSpace((l_WrappedStr.S-1)^)
          // - пробел был где-то раньше
          OR IsSeg
          // - это сегмент, который не надо резать пополам
         then
     begin
      // - Учитываем ситуацию когда сегмент режется посередине слова
      aStr.Init(l_WrappedStr.S, aStr.SLen + l_WrappedStr.SLen, aStr.SCodePage);
      l_WrappedStr.SLen := 0;
     end;//evWhiteSpace(l_WrappedStr.S-1)^)
    end;//not l_AddHyphen..
    MeasureStr(True); // - Измеряем размеры полученной строки. 
    AddLine; // - Добавляем полученную строку. 
   end;//while True
  end;//FormatStr

 var
  l_CurStr     : Tl3PCharLen;
  l_StrExtent  : TnevPoint;
  l_LimitWidth : Integer;
  l_ParaFont   : InevFont;

  function FormatSegment(aSegment: Tl3Variant; Index: Integer): Boolean;
  var
   l_SegFont   : InevFont;
   l_SegStart  : Integer;
   l_SegFinish : Integer;
  begin//FormatSegment
   Result := True;
   with aSegment do
   begin
    l_SegStart := Pred(IntA[k2_tiStart]);
    l_SegFinish := IntA[k2_tiFinish];
   end;//with aSegment
   { Обрабатываем часть строки до выделения: }
   l_CurStr.SLen := Min(l_SegStart, l_Str.SLen) - (l_CurStr.S - l_Str.S);
   if (l_CurStr.SLen > 0) then
    FormatStr(l_LimitWidth, l_ParaFont, false, l_CurStr, l_StrExtent);
   { Обрабатываем отрезок выделения. }
   l_CurStr.SLen := Min(l_SegFinish - l_SegStart,
                        l_Str.SLen - (l_CurStr.S - l_Str.S));
   if (l_CurStr.SLen > 0) then
   begin
    //evCheckRenderedObject(aView, aSegment, Obj, aSegmentAndFontTool, Self);
    l_SegFont := Self.InfoForChild(TnevSegmentObject.Make(aSegment.AsObject)).Font[true];
    //l_SegFont := aSegmentAndFontTool.ETAOIN_SHRDLU_GetObjIFont(aView, aSegment, true, Self);
    try
     FormatStr(l_LimitWidth, l_SegFont, true, l_CurStr, l_StrExtent);
    finally
     l_SegFont := nil;
    end;//try..finally
   end;//l_CurStr.SLen > 0
  end;//FormatSegment

  function CheckSegmentHeight(aSegment: Tl3Variant; Index: Integer): Boolean;
  var
   l_SegFont   : InevFont;
   l_SegStart  : Integer;
   l_SegFinish : Integer;
  begin//
   Result := True;
   with aSegment do
   begin
    l_SegStart := Pred(IntA[k2_tiStart]);
    l_SegFinish := IntA[k2_tiFinish];
   end;//with aSegment
   l_CurStr.S := l_Str.S + l_SegStart;
   l_CurStr.SLen := l_SegFinish - l_SegStart;
   if (l_CurStr.SLen > 0) then
   begin
    //evCheckRenderedObject(aView, aSegment, Obj, aSegmentAndFontTool, Self);
    l_SegFont := Self.InfoForChild(TnevSegmentObject.Make(aSegment.AsObject)).Font[true];
    //l_SegFont := aSegmentAndFontTool.ETAOIN_SHRDLU_GetObjIFont(aView, aSegment, true, Self);
    try
     l_MeasureCanvas.Font := l_SegFont;
     l_Height := Max(l_Height, l_MeasureCanvas.TextExtent(l_Str).Y);
    finally
     l_SegFont := nil;
    end;//try..finally
   end;//l_CurStr.SLen > 0
  end;//CheckSegmentHeight

 var
  l_FirstIndent : Integer;
  l_SLI         : Tl3SingleLineInfo;
 begin//DoFormat
  (*if (RecalcThread <> nil) AND not RecalcThread.ChangeCanvas then
   l_MeasureCanvas := l_InfoCanvas
  else *)begin
   l_MeasureCanvas := aView.InfoCanvas;
   //l_MeasureCanvas := l_InfoCanvas;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=88639598
   // - может статься, что что-то не доделал
   // Точно не доделал:
   // http://mdp.garant.ru/pages/viewpage.action?pageId=195758154
   //l_MeasureCanvas := ETAOIN_SHRDLU_l3CrtIC;
   if l_InfoCanvas.EQ(l_MeasureCanvas) then
    l_MeasureCanvas := l_InfoCanvas;
  end;//RecalcThread <> nil
  l_Spaces := Self.Get_Spacing;
  l_Map := TevLineArray.Create;
  try
   Self.wMap(l_Map);
  finally
   l_Map := l_Map.Free;
  end;//try..finally
  try
   if not Obj.TreatCollapsedAsHidden OR not aView.IsTagCollapsed(Obj.AsObject) then
   begin
    l_AllowHyphen := Obj.AsObject.BoolA[k2_tiAllowHyphen];
    l_Str := Obj.Text;
    if (l_Str.SCodePage = CP_Unicode) then
     l_CharSize := SizeOf(WideChar)
    else
     l_CharSize := SizeOf(ANSIChar);
    l_ParaFont := Self.Get_Font(true);
    //l_ParaFont := aSegmentAndFontTool.ETAOIN_SHRDLU_GetObjIFont(aView, Obj, False, Self);
    try
     l_InfoCanvas.Font := l_ParaFont;
     if (l_InfoCanvas <> l_MeasureCanvas) then
      l_MeasureCanvas.Font := l_ParaFont;
     l_InfoCanvas.StartTabs(l_ITabInfo, Obj.TabStops);
     if (l_InfoCanvas <> l_MeasureCanvas) then
      l_MeasureCanvas.StartTabs(l_MTabInfo, Obj.TabStops);
     try
      Dec(l_InLimitWidth, l_Spaces.Right);
      if l3IsNil(l_Str) then
      begin
       l_Height := l_MeasureCanvas.AverageCharHeight;
       l_Map.Add(0, Tl3_Point_C(0, l_Height));
       if (Obj.AsObject.IntA[k2_tiJustification] = Ord(ev_itPreformatted)) then
        Self.wWidth(0)
       else
        Self.wWidth(l_InLimitWidth);
      end//l3IsNil(l_Str)
      else
      if (Obj.AsObject.IntA[k2_tiJustification] = Ord(ev_itPreformatted)) and Obj.AsObject.IsValid then
      begin
       l_StrExtent := l_MeasureCanvas.TextExtent(l_Str);
       l_Height := l_StrExtent.Y;
       with Self.ViewSegments do
        if IsValid then
        begin
         IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckSegmentHeight));
         l_StrExtent.Y := l_Height;
        end;//IsValid
       // Не уверен, что такая проверка нужна... 
       l_Map.Add(l_Str.SLen, l_StrExtent);
       Self.wWidth(l_StrExtent.X + l_Spaces.Left);
      end//IntA[k2_tiJustification] = Ord(ev_itPreformatted)
      else
      begin
       Self.wWidth(l_InLimitWidth);
       l_FirstIndent := Self.Get_FirstIndent;
       if (l_Spaces.Left >= l_InLimitWidth - 100) OR
          (l_FirstIndent >= l_InLimitWidth - 100) then
       begin
        l_Height := l_MeasureCanvas.AverageCharHeight;
        l_Map.Add(0, Tl3_Point_C(0, l_Height));
       end//l_Spaces.Left >= l_InLimitWidth - 100
       else
       begin
        l_Height := 0;
        l_StrExtent := nevPt0;
        l_LimitWidth := l_InLimitWidth - l_FirstIndent;
        l_FontIndexes := [];
        l_SoftEnterCount := l3CountOfChar(cc_SoftEnter, l_Str);
        l_CurStr := l_Str;
        l_PrevWrap := l_Str.S;
        with Self.ViewSegments do
         if IsValid then
         begin
          IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@FormatSegment));
          if (l_Str.SCodePage = CP_Unicode) then
           l_CurStr.SLen := l_Str.SLen - ((l_CurStr.S - l_Str.S) div SizeOf(WideChar))
          else
           l_CurStr.SLen := l_Str.SLen - (l_CurStr.S - l_Str.S);
          Assert(l_CurStr.SLen >= 0);
          FormatStr(l_LimitWidth, l_ParaFont, false, l_CurStr, l_StrExtent);
          // - доформатируем хвост после последнего сегмента
         end//IsValid
         else
          FormatStr(l_LimitWidth, l_ParaFont, false, l_CurStr, l_StrExtent);
        if (l_StrExtent.Y <= 0) then
        begin
         l_MeasureCanvas.Font := l_ParaFont;
         l_StrExtent.Y := l_MeasureCanvas.AverageCharHeight;
        end;//l_StrExtent.Y <= 0
        l_Map.Add(l_Str.SLen, l_StrExtent, l_FontIndexes, false);
        Inc(l_Height, l_StrExtent.Y);
       end;//l_Spaces.Left >=..
      end;//..ev_itPreformatted..
     finally
      if (l_InfoCanvas <> l_MeasureCanvas) then
       l_MeasureCanvas.FinishTabs(l_MTabInfo);
      l_InfoCanvas.FinishTabs(l_ITabInfo);
     end;//try..finally
    finally
     l_ParaFont := nil;
    end;//try..finally
 (*   with Obj.rAtomEx([k2_tiFrame, k2_tiFrameUp]) do
     if IsValid then
      Inc(l_Height, IntA[k2_tiWidth]);*)
   end//not Obj.TreatCollapsedAsHidden OR not aView.IsTagCollapsed(Obj)
   else
   begin
    Self.wWidth(0);
    l_Height := 0;
   end//not Obj.TreatCollapsedAsHidden OR not aView.IsTagCollapsed(Obj)
   ;
   Inc(l_Height, l_Spaces.Top);
   Inc(l_Height, l_Spaces.Bottom);
  finally
   if (l_Map <> nil) then
   begin
    if (l_Map.Count < 1) then
    begin
     // - удаляем ненужное в данном случае форматирование
     l_Map := nil;
     Self.wMap(nil);
    end//l_Map.Count < 1
    else
    if (l_Map.Count = 1) then
    begin
     if (Obj.AsObject.IntA[k2_tiJustification] = Ord(ev_itPreformatted)) then
     begin
      // - удаляем ненужное в данном случае форматирование
      l_Map := nil;
      Self.wMap(nil);
     end//IntA[k2_tiJustification] = Ord(ev_itPreformatted)
     else
     begin
      with PevLineInfo(l_Map.Items[0])^ do
       l_SLI := Tl3SingleLineInfo.Make(LE.X, LE.Y, FI);
      try
       l_Map := nil;
       Self.wMap(l_SLI);
      finally
       FreeAndNil(l_SLI);
      end;//try..finally
     end;//IntA[k2_tiJustification] = Ord(ev_itPreformatted)
    end;//l_Map.Count <= 1
   end;//l_Map <> nil
  end;//try..finally
 end;//DoFormat

{var
 l_SegmentAndFontTool : InevFontTool;}
//#UC END# *4E7094780214_481F174D01BF_var*
begin
//#UC START# *4E7094780214_481F174D01BF_impl*
 l_InLimitWidth := Self.rLimitWidth;
 l_Height := 0;
 Obj.AsObject.DoLoad;
 l_InfoCanvas := aView.FormatCanvas;
// l_InfoCanvas := aView.InfoCanvas;
 try
  if Self.IsHidden(false,
                  (l_InfoCanvas <> nil) AND
                  l_InfoCanvas.Printing) then
  begin
   Self.wWidth(0);
   Self.wMap(nil);
  end//Obj.IsHiddenPrim(Self, aView.HiddenStyles)
  else
  begin
(*   l_SegmentAndFontTool := aView.FontTool{ As InevFontTool};
   try*)
(*    l_SegmentAndFontTool.ForPrinting := (l_InfoCanvas.Printing
                                         {$IFNDef Nemesis}OR not aView.IsWebStyle{$EndIf});*)
    l_InfoCanvas.Lock;
    try
     l_InfoCanvas.PushBC;
     l_InfoCanvas.PushFC;
     // - Запоминаем - чтобы не испортить фон для отрисовки
     try
      DoFormat{(l_SegmentAndFontTool)};
     finally
      l_InfoCanvas.PopFC;
      l_InfoCanvas.PopBC;
     end;//try..finally
    finally
     l_InfoCanvas.Unlock;
    end;//try..finally
(*   finally
    l_SegmentAndFontTool := nil;
   end;//try..finally*)
  end;//not Obj.IsHiddenPrim(Self, aView.HiddenStyles)
 finally
  l_InfoCanvas := nil;
 end;//try..finally
 Self.wHeight(l_Height);
//#UC END# *4E7094780214_481F174D01BF_impl*
end;//TnevTextParaRenderInfo.DoRecalc

end.
