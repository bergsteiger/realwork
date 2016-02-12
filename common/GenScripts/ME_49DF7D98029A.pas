unit evTextParaCursor;
 {* Реализация курсора для текстового параграфа }

// Модуль: "w:\common\components\gui\Garant\Everest\evTextParaCursor.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLeafParaCursor
 , nevTools
 , nevBase
 , l3Variant
 , l3IID
 , l3Core
 , l3Interfaces
;

type
 _nevTextParaTool_Parent_ = TevLeafParaCursor;
 {$Include w:\common\components\gui\Garant\Everest\new\nevTextParaTool.imp.pas}
 _nevTextParaViewBounds_Parent_ = _nevTextParaTool_;
 {$Include w:\common\components\gui\Garant\Everest\nevTextParaViewBounds.imp.pas}
 _nevTextParaAnchorModify_Parent_ = _nevTextParaViewBounds_;
 {$Include w:\common\components\gui\Garant\Everest\nevTextParaAnchorModify.imp.pas}
 TevTextParaCursor = class(_nevTextParaAnchorModify_, IevTagLine)
  {* Реализация курсора для текстового параграфа }
  private
   f_ParaEnd: Boolean;
  public
   f_LineEnd: Boolean;
  protected
   function DoPrevCharForDelete(const aView: InevView;
    const anOp: InevOp): Boolean;
   procedure CheckSegments(aPos: Integer;
    const anOp: InevOp);
   function GetLine(aMap: TnevFormatInfoPrim): Integer;
   function pm_GetLineEnd: Boolean;
   procedure pm_SetLineEnd(aValue: Boolean);
   procedure SetLinePrim(aValue: Integer;
    aMap: TnevFormatInfoPrim); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); override;
   function DoJoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp;
    MoveSubs: Boolean): Integer; override;
   function DoSplit(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef; override;
   function DoJoinWithNext(const aView: InevView;
    const anOp: InevOp): Boolean; override;
   function GetPaintOffsetY(const aView: InevView;
    aMap: TnevFormatInfoPrim): Integer; override;
   procedure DoInitPointByPt(const aView: InevView;
    const aPoint: TnevPoint;
    const aMap: InevMap); override;
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
   procedure DoSetAtEnd(const aView: InevView;
    aValue: Boolean); override;
   function GetAtStart: Boolean; override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   function GetReadOnly: Boolean; override;
   function GetDeltaX(const aView: InevView;
    const aMap: InevMap): Integer; override;
   function DoGetBlockLength: Integer; override;
   function DoGetStyle(Stop: PInteger): Tl3Variant; override;
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; override;
   {$If Defined(evNeedMarkers)}
   procedure DoGetMarkers(const aView: InevView;
    const aList: IevMarkersList); override;
   {$IfEnd} // Defined(evNeedMarkers)
   function DoDeleteHyperlink(const anOpPack: InevOp): Boolean; override;
   function DoInsertBreak(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function DoAddIndentMarker(const aView: InevView;
    aValue: Integer;
    const anOpPack: InevOp): Boolean; override;
   function DoDeleteIndentMarker(const aView: InevView;
    const anOpPack: InevOp): Boolean; override;
   function DoInsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp;
    InsertMode: Boolean;
    aFlags: TnevInsertStringFlags): Boolean; override;
   function DoDeleteString(const aView: InevView;
    aCount: Integer;
    const anOp: InevOp;
    aFlags: TnevInsertStringFlags): Boolean; override;
   function DoSetAtom(const aView: InevView;
    anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOp: InevOp): Boolean; override;
   function DoDeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   procedure DoSetEntryPointPrim(Value: Integer;
    const Context: IevCursorContext = nil); override;
 end;//TevTextParaCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evCursorConst
 {$If Defined(k2ForEditor)}
 , evTextParaTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(evNeedHotSpot)}
 , evHyperlink
 {$IfEnd} // Defined(evNeedHotSpot)
 , k2Tags
 , evDrawLineTool
 , LeafPara_Const
 , StyledLeafPara_Const
 , TableCell_Const
 , Document_Const
 , TextPara_Const
 , Formula_Const
 , BitmapPara_Const
 , HyperLink_Const
 , evdTypes
 , k2Base
 , nevNavigation
 {$If Defined(k2ForEditor)}
 , evSegLst
 {$IfEnd} // Defined(k2ForEditor)
 , k2Const
 , l3InterfacedString
 , l3CustomString
 , l3String
 , l3Types
 , ObjectSegment_Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2BaseTypes
 , evTextParaOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , Classes
 , l3Base
 , l3LineArray
 , l3Units
 , l3MinMax
 , evOp
 , l3Const
 , k2OpMisc
 , l3Chars
 , evExcept
 , evTabIndentMarker
 , nevInterfaces
 , evTextParaMarkers
 , evTextParaOpEx
 , evTextManipulationInterfaces
 , k2Facade
 , l3UnitsTools
 {$If Defined(k2ForEditor)}
 , evSegment
 {$IfEnd} // Defined(k2ForEditor)
 , ContentsElement_Const
 {$If Defined(k2ForEditor)}
 , evAlignBySeparatorUtils
 {$IfEnd} // Defined(k2ForEditor)
 , k2String
 , SysUtils
 , evdStyles
;

type
 PevTextParaCursor = ^TevTextParaCursor;

function GetLC(aSelf: _nevTextParaViewBounds_;
 aMap: TnevFormatInfoPrim): TnevLineCoord;
 {* Возвращает текущую строку }
//#UC START# *4A5CD65C01D4_49DF7D98029A_var*
//#UC END# *4A5CD65C01D4_49DF7D98029A_var*
begin
//#UC START# *4A5CD65C01D4_49DF7D98029A_impl*
 Result.rLine := TevTextParaCursor(aSelf).GetLine(aMap);
 Result.rOfs := TevTextParaCursor(aSelf).Position
                - evTextParaGetPosByLine(aMap.Lines, TevTextParaCursor(aSelf).ParaX.Text, Result.rLine);
//#UC END# *4A5CD65C01D4_49DF7D98029A_impl*
end;//GetLC

type _Instance_R_ = TevTextParaCursor;

{$Include w:\common\components\gui\Garant\Everest\new\nevTextParaTool.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevTextParaViewBounds.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevTextParaAnchorModify.imp.pas}

function TevTextParaCursor.DoPrevCharForDelete(const aView: InevView;
 const anOp: InevOp): Boolean;
//#UC START# *4A390AAF020D_49DF7D98029A_var*
var
 l_Parent      : InevBasePoint;
 l_Pos         : Integer;
 l_RightBorder : Integer;
 l_SpacesCount : Integer;
//#UC END# *4A390AAF020D_49DF7D98029A_var*
begin
//#UC START# *4A390AAF020D_49DF7D98029A_impl*
 if ReadOnly then
  raise EevReadOnly.Create('Backspace обработан');
 Result := True;
 l_Parent := Self.pm_GetParentPoint;
 if (l_Parent <> nil) then
 begin
  with ParaX do
  begin
   if (IntA[k2_tiStyle] = ev_saTxtNormalOEM) then
   begin
    with Attr[k2_tiText] do
     if IsValid then 
      with AsObject As Tl3CustomString do
       if not Empty then 
       begin
        l_Pos := Position;
        if (l_Pos = 0) OR (St[Pred(l_Pos)] in cc_Graph_Criteria) then
        begin
         with l_Parent do
         begin
          if (Position > 1) then
          begin
           with Obj.AsObject.Child[Position - 2] do
           begin
            if (IntA[k2_tiStyle] = ev_saTxtNormalOEM) then
            begin
             SetEntryPoint(Pred(Position), anOp);
             with Attr[k2_tiText] do
              if IsValid then with AsObject As Tl3CustomString do
               if not Empty then begin
                if (l_Pos < Len) then begin
                  l_RightBorder := l3CharSetPresentEx(St + l_Pos, Len - l_Pos, cc_Graph_Criteria);
                 if (l_RightBorder <> -1) then begin
                  if (l_RightBorder = 0) then begin
                    SetEntryPoint(Succ(Position), anOp);
                    if (l_Pos > 1) then
                     Inner.SetEntryPoint(l_Pos - 1, anOp)
                    else
                     Inner.SetEntryPoint(l_Pos, anOp);
                    raise EevReadOnly.Create('Backspace обработан');
                  end else begin
                    l_SpacesCount := l3CharSetPresentExR(St, l_Pos + Pred(l_RightBorder), cc_AllChars - [cc_HardSpace]);
                    if (l_SpacesCount <> -1) then
                     Inner.SetEntryPoint(l_SpacesCount, anOp)
                    else
                     Inner.SetEntryPoint(l_Pos + Pred(l_RightBorder), anOp);
                   end;//l_RightBorder = 0
                   Exit;
                  end;//l_RightBorder <> -1
                 end;//l_Pos < Len
                end;//not Empty
             Inner.Move(aView, ev_ocParaEnd, anOp);
            end;//IntA[k2_tiStyle] = ev_saTxtNormalOEM
           end;//with Obj.Child[Position - 2]
          end;//Position > 1
          raise EevReadOnly.Create('Backspace обработан');
         end;//with _TevBaseCursor(l_Parent)
        end;//l_Pos = 0
       end;//not Empty
   end;//IntA[k2_tiStyle] = ev_saTxtNormalOEM
  end;//l_Tag
 end;//l_Parent <> nil
 Result := false;
//#UC END# *4A390AAF020D_49DF7D98029A_impl*
end;//TevTextParaCursor.DoPrevCharForDelete

procedure TevTextParaCursor.CheckSegments(aPos: Integer;
 const anOp: InevOp);
var l_Segments: Tl3Variant;
var l_Seg: Tl3Variant;
var l_Index: Integer;
//#UC START# *4A391212035B_49DF7D98029A_var*
//#UC END# *4A391212035B_49DF7D98029A_var*
begin
//#UC START# *4A391212035B_49DF7D98029A_impl*
 l_Segments := ParaX.AsObject.Attr[k2_tiSegments];
 l_Seg := evSegments_GetSegmentOnPos(l_Segments, ev_slMistakes, aPos, l_Index);
 if l_Seg.IsValid then
  evSegments_GetLayer(l_Segments, ev_slMistakes).DeleteChild(l_Index, anOp)
 else
 begin
  if (aPos > 0) then
  begin
   l_Seg := evSegments_GetSegmentOnPos(l_Segments, ev_slMistakes, aPos-1, l_Index);
   if l_Seg.IsValid then
    evSegments_GetLayer(l_Segments, ev_slMistakes).DeleteChild(l_Index, anOp);
  end;//aPos > 0
 end;//l_Seg.IsValid
//#UC END# *4A391212035B_49DF7D98029A_impl*
end;//TevTextParaCursor.CheckSegments

function TevTextParaCursor.GetLine(aMap: TnevFormatInfoPrim): Integer;
//#UC START# *49DF7E0301AE_49DF7D98029A_var*
var
 l_Pos : Integer;
//#UC END# *49DF7E0301AE_49DF7D98029A_var*
begin
//#UC START# *49DF7E0301AE_49DF7D98029A_impl*
 l_Pos := Position;
 if (l_Pos = ev_cpTop) then
  Result := 1
 else
 begin
  if (aMap = nil) then
   Result := 1
  else
   Result := evTextParaGetLineByPos(aMap, ParaX.Text, l_Pos);
  if f_LineEnd AND (Result > 1) then
   Dec(Result);
 end;//l_Pos = ev_cpTop
//#UC END# *49DF7E0301AE_49DF7D98029A_impl*
end;//TevTextParaCursor.GetLine

function TevTextParaCursor.pm_GetLineEnd: Boolean;
//#UC START# *49DF7E25001C_49DF7D98029Aget_var*
//#UC END# *49DF7E25001C_49DF7D98029Aget_var*
begin
//#UC START# *49DF7E25001C_49DF7D98029Aget_impl*
 Result := f_LineEnd;
//#UC END# *49DF7E25001C_49DF7D98029Aget_impl*
end;//TevTextParaCursor.pm_GetLineEnd

procedure TevTextParaCursor.pm_SetLineEnd(aValue: Boolean);
//#UC START# *49DF7E25001C_49DF7D98029Aset_var*
//#UC END# *49DF7E25001C_49DF7D98029Aset_var*
begin
//#UC START# *49DF7E25001C_49DF7D98029Aset_impl*
 if (f_LineEnd <> aValue) then
 begin
  f_LineEnd := aValue;
  Refresh;
 end;//f_LineEnd <> aValue
//#UC END# *49DF7E25001C_49DF7D98029Aset_impl*
end;//TevTextParaCursor.pm_SetLineEnd

procedure TevTextParaCursor.SetLinePrim(aValue: Integer;
 aMap: TnevFormatInfoPrim);
//#UC START# *4B1D11DC00AD_49DF7D98029A_var*
var
 l_Line : Integer;
 l_Pos  : Integer;
//#UC END# *4B1D11DC00AD_49DF7D98029A_var*
begin
//#UC START# *4B1D11DC00AD_49DF7D98029A_impl*
 l_Line := aValue + 1;
 l_Pos := evTextParaGetPosByLine(aMap.Lines, ParaX.Text, l_Line);
 SetEntryPoint(l_Pos);
//#UC END# *4B1D11DC00AD_49DF7D98029A_impl*
end;//TevTextParaCursor.SetLinePrim

procedure TevTextParaCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49DF7D98029A_var*
//#UC END# *479731C50290_49DF7D98029A_var*
begin
//#UC START# *479731C50290_49DF7D98029A_impl*
 f_LineEnd := false;
 f_ParaEnd := false;
 inherited;
//#UC END# *479731C50290_49DF7D98029A_impl*
end;//TevTextParaCursor.Cleanup

procedure TevTextParaCursor.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *49DE3CD8004F_49DF7D98029A_var*
var
 l_TL  : IevTagLine;
 l_MP  : Integer;
 l_Pos : Integer;
 l_FI  : TnevFormatInfoPrim;
//#UC END# *49DE3CD8004F_49DF7D98029A_var*
begin
//#UC START# *49DE3CD8004F_49DF7D98029A_impl*
 inherited;
 if Supports(aPoint, IevTagLine, l_TL) then
 begin
  try
   f_LineEnd := l_TL.LineEnd;
  finally
   l_TL := nil;
  end;//try..finally
 end//Supports(aPoint, IevTagLine, l_TL)
 else
 begin
 // !!! когда aPoint - Anchor - не присваивается строка !!!
  l_MP := Succ(aPoint.VertPosition(aView,ObjMap(aView)));
  l_FI := nil;
  if (Position = 0) AND (l_MP > 0) then
  begin
   if (aView <> nil) then
    l_FI := aView.FormatInfoByPoint(Self);
   if (l_FI = nil) then
    l_Pos := 0
   else
    l_Pos := evTextParaGetPosByLine(l_FI.Lines, ParaX.Text, l_MP);
   if (l_FI <> nil) then
    SetEntryPointPrim(l_Pos);
  end;//Position = 0
 end;//try..finally
 f_ParaEnd := aPoint.AtEnd(aView);
//#UC END# *49DE3CD8004F_49DF7D98029A_impl*
end;//TevTextParaCursor.DoAssignPoint

function TevTextParaCursor.DoJoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp;
 MoveSubs: Boolean): Integer;
//#UC START# *49DEFB410161_49DF7D98029A_var*
var
 theResult : Integer absolute Result;

 function _ModifyCursor(C: PevTextParaCursor; Index: Integer): Boolean; 
 var
  PLC : InevBasePoint;
  OEP : Integer;
 begin//_ModifyCursor
  Result := true;
  PLC := InevPoint(C^).ParentPoint;
  if (PLC <> nil) then
  begin
   OEP := C^.Position;
   with PLC do
   begin
    SetEntryPoint(Pred(Position), anOp);
    Inner.SetEntryPoint(OEP + theResult, anOp);
    Inner.Refresh;
   end;//with PLC
  end;//PLC <> nil
 end;//_ModifyCursor

 procedure DoMoveSubs(aFrom : Tl3Variant;
                      aTo   : Tl3Variant);
 var
  l_SubList : InevSubList;
  l_AddSubs : Boolean;

  function AddSubLayer(aSubLayer: Tl3Variant; Index: Integer): Boolean; far;
  var
   l_Handle : Integer;
  begin//AddSubLayer
   Result := True;
   with aSubLayer do
   begin
    l_Handle := IntA[k2_tiHandle];
    if l_AddSubs OR (l_Handle <> Ord(ev_sbtSub)) then
     while (ChildrenCount > 0) do
      l_SubList.SubEx[Child[0].IntA[k2_tiHandle], l_Handle].SetTo(aTo);
   end;//with aSubLayer
  end;//AddSubLayer

 begin//DoMoveSubs
  l_AddSubs := MoveSubs OR not aTo.rAtomEx([k2_tiSubs,
                                           k2_tiChildren, k2_tiHandle,  Ord(ev_sbtSub),
                                           k2_tiChildren, k2_tiByIndex, 0]).IsValid;
  with aFrom.Attr[k2_tiSubs] do
   if IsValid then
   begin
    l_SubList := ParaX.MainSubList;
    if (l_SubList <> nil) then
     try
      IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@AddSubLayer));
     finally
      l_SubList := nil;
     end;//try..finally
   end;//IsValid
 end;//DoMoveSubs

var
 S           : Tl3InterfacedString;
 l_FirstPara : InevTextPara;
 l_NextPara  : Tl3Variant;
 l_Text      : Tl3CustomString;
{$IFNDEF Nemesis}
 l_Style     : Integer;
{$ENDIF Nemesis}
 l_Seg       : Tl3Variant;
 l_Para      : InevPara;
//#UC END# *49DEFB410161_49DF7D98029A_var*
begin
//#UC START# *49DEFB410161_49DF7D98029A_impl*
 l_FirstPara := ParaX;

 if aSecondPara.IsKindOf(k2_typFormula) OR
    aSecondPara.IsKindOf(k2_typBitmapPara) then
 begin
  Result := l_FirstPara.AsObject.PCharLenA[k2_tiText].SLen;
  if not (Result <= 0) then
   S := Tl3InterfacedString.Make(l3PCharLen(' * '))
  else
   S := Tl3InterfacedString.Make(l3PCharLen('* '));
  try
   DoInsertString(aView, S, anOp, true, [misfLockSegments]);
   // - misfLockSegments здесь чтобы можно было две формулы подряд вставлять
   Result := l_FirstPara.AsObject.PCharLenA[k2_tiText].SLen;
   l_Seg := k2_typObjectSegment.MakeTag.AsObject;
   try
    l_Seg.IntA[k2_tiStart] := Pred(Result);
    l_Seg.IntA[k2_tiFinish] := Pred(Result);
    l_NextPara := aSecondPara.AsObject;
    l_Seg.AddChild(l_NextPara.AsObject, anOp);
    evSegments_AddSegment(l_FirstPara,
                          l_FirstPara.AsObject.cAtom(k2_tiSegments, anOp),
                          ev_slObjects, l_Seg, anOp);
   finally
    l_Seg := nil;
   end;//try..finally
  finally
   FreeAndNil(S);
  end;//try..finally
  Exit;
 end;//aSecondPara.IsKindOf(k2_typFormula)
 if aSecondPara.IsKindOf(k2_typTextPara) then
 begin
  with l_FirstPara.AsObject.Attr[k2_tiText] do
  begin
   if IsValid then
    Result := (AsObject As Tl3CustomString).Len
   else
    Result := 0;
  end;
  if evHasText(aSecondPara.AsObject) then
  begin
   l_Text := aSecondPara.Attr[k2_tiText] As Tl3CustomString;
   {$IFNDEF Nemesis}
   if (l_FirstPara.Owner <> nil) and l_FirstPara.Owner.IsKindOf(k2_typTableCell) then
    l_Style := l_FirstPara.IntA[k2_tiStyle]
   else
    l_Style := ev_saEmpty;
   {$ENDIF Nemesis}
   if (Result = 0) then
   begin
    if aSecondPara.IsKindOf(l_FirstPara.AsObject.TagType) then
     l_FirstPara.AsObject.AssignCloneParams(aSecondPara.AsObject, k2_amAll, anOp)
    else
     l_FirstPara.AsObject.AssignCloneParams(aSecondPara.AsObject, k2_amAll - [k2_amNull], anOp);
    with l_FirstPara do
     (cAtom(k2_tiText).AsObject As Tl3CustomString).CodePage := l_Text.CodePage;
   {$IFNDEF Nemesis}
    if l_Style <> ev_saEmpty then
     l_FirstPara.IntA[k2_tiStyle] := l_Style;
   {$ENDIF Nemesis}
   end;//Result = 0
   if aSecondPara.HasSubAtom(k2_tiSegments) then
   begin
    evSegments_AddSegments(l_FirstPara,
                           //l_FirstPara.cAtom(k2_tiSegments, anOp),
                           aSecondPara.Attr[k2_tiSegments],
                           0, Result,
                           anOp);
    OevJoinParas.ToUndo(anOp, l_FirstPara.AsObject, aSecondPara);
   end;//aSecondPara.HasSubAtom(k2_tiSegments)
   S := Tl3InterfacedString.Make(l_Text.AsWStr);
   try
    if not Self.InsertString(aView, S,
                      anOp,
                      true,
                      [misfDirect, misfLockSegments, misfLockCursors]) then
     raise EevLimitReached.Create('Наверное достигнут лимит количества символов');                 
   finally
    FreeAndNil(S);
   end;//try..finally
  end;//evHasText(aSecondPara)
  DoMoveSubs(aSecondPara.AsObject, l_FirstPara.AsObject);
  if aSecondPara.Owner.IsValid then
   evIterateCursorsF(aSecondPara, l3L2IA(@_ModifyCursor));
   {-здесь не нужна коррекция курсоров, она осуществляется при удалении параграфа}
   {-нет коррекция нужна, но ее надо переделать на случай нетекстового параграфа
     (а может это бред)}
 end//aSecondPara.IsKindOf(k2_typTextPara)
 else
 // Закомментировано т.к. http://mdp.garant.ru/pages/viewpage.action?pageId=234363615
(* if aSecondPara.IsKindOf(k2_typContentsElement) then
 begin
  l_NextPara := aSecondPara.Child[0];
  Result := DoJoinWith(aView, l_NextPara, anOp, MoveSubs);
  if (Result >= 0) then
  begin
   if not l_NextPara.QT(InevPara, l_Para) then
    Assert(false);
   l_Para.Edit.Delete(anOp);
   if (aSecondPara.ChildrenCount = 0) then
   begin
    if not aSecondPara.QT(InevPara, l_Para) then
     Assert(false);
    l_Para.Edit.Delete(anOp);
   end;//aSecondPara.ChildrenCount = 0
  end;//Result >= 0
 end//aSecondPara.IsKindOf(k2_typContentsElement)
 else*)
 begin
  if not evHasText(l_FirstPara.AsObject) then
  begin
   if MoveSubs then
   begin
    // - надо тогда переставить Sub на листьевой параграф
    if evInPara(aSecondPara.AsObject, k2_typStyledLeafPara, l_NextPara) then
     DoMoveSubs(l_FirstPara.AsObject, l_NextPara);
   end;//MoveSubs
   Result := -2;
  end//not evHasText(l_FirstPara)
  else
   Result := -1;
 end;//aSecondPara.IsKindOf(k2_typTextPara)
//#UC END# *49DEFB410161_49DF7D98029A_impl*
end;//TevTextParaCursor.DoJoinWith

function TevTextParaCursor.DoSplit(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *49DEFB770015_49DF7D98029A_var*
var
 l_OldPara     : InevTextPara;
 l_OldSegments : Tl3Variant;
 l_Anchor      : Integer;
 l_Text        : Tl3CustomString;
 l_SaveBreak   : Boolean;
 l_O           : InevObject;
 l_Processor  : InevProcessor;
 l_TextProcessor : IevTextOpProcessor;
//#UC END# *49DEFB770015_49DF7D98029A_var*
begin
//#UC START# *49DEFB770015_49DF7D98029A_impl*
 if ReadOnly then
  Result := Tl3NullTag.Instance
 else
 begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=492622898
  l_Processor := anOp.Processor;
  if (l_Processor <> nil) then
  begin
   l_TextProcessor := (l_Processor as IevTextOpProcessor);
   try
    l_TextProcessor.CheckTextOp(nil, l3_opDelete);
   except
    on EevReadOnly do
    begin
     Result := Tl3NullTag.Instance;
     Raise;
    end;//on EvReadOnly
   end;//try..except
  end;//if (l_Processor <> nil)

  l_SaveBreak := false;
  l_Anchor := Position;
  l_OldPara := ParaX;
  Result := l_OldPara.AsObject.TagType.MakeTag;
  try
   Result.AsObject.AssignCloneParams(l_OldPara.AsObject);
   with l_OldPara.AsObject.Attr[k2_tiText] do
    if IsValid then
     l_Text := AsObject As Tl3CustomString
    else
     l_Text := nil;
   if not l_Text.Empty AND (l_Anchor >= 0) then
   begin
    if (l_Anchor < l_Text.Len) then
    begin
     if (l_Text.Len > 0) then
     begin
      l_OldSegments := l_OldPara.AsObject.Attr[k2_tiSegments];
      if l_OldSegments.IsValid then
      begin
       l_SaveBreak := true;
       if not Result.AsObject.QT(InevObject, l_O) then
        Assert(false);
       evSegments_AddSegments(l_O,
                              //Result.cAtom(k2_tiSegments),
                              l_OldSegments,
                              l_Anchor, -l_Anchor,
                              nil,
                              l_Text.Len - l_Anchor);
      end;//l_OldSegments.IsValid
      with (Result.AsObject.cAtom(k2_tiText) As Tl3String) do
      begin
       CodePage := l_Text.CodePage;
       AsPCharLen := l3PCharLen(l_Text.St + l_Anchor, l_Text.Len - l_Anchor, l_Text.CodePage);
      end;
      Self.DeleteString(aView, l_Text.Len-l_Anchor, anOp,
                        [misfLockSegments] + aFlags);
     end;//l_Text.Len > 0..
    end;//l_Anchor < l_Text.Len
   end;//not l_Text.Empty..
  except
   Result := nil;
   raise;
  end;//try..except
  if l_SaveBreak then
   OevBreakPara.ToUndo(anOp, l_OldPara.AsObject, Result.AsObject);
 end;//ReadOnly
//#UC END# *49DEFB770015_49DF7D98029A_impl*
end;//TevTextParaCursor.DoSplit

function TevTextParaCursor.DoJoinWithNext(const aView: InevView;
 const anOp: InevOp): Boolean;
//#UC START# *49DF4C6E0101_49DF7D98029A_var*
var
 l_SecondPara : Tl3Variant;
 l_Pos        : Integer;
 l_Parent     : Tl3Variant;
//#UC END# *49DF4C6E0101_49DF7D98029A_var*
begin
//#UC START# *49DF4C6E0101_49DF7D98029A_impl*
 try
  l_SecondPara := Self.pm_GetParentPoint.Obj.AsObject.Child[Self.pm_GetParentPoint.Position];
 except
  on EListError do
  begin
   if EvDeleteIfReadOnly(ParaX) then
    Result := true
   else
   begin
    with ParaX.AsObject.Attr[k2_tiText] do
     if IsValid then begin
      if (AsObject As Tl3CustomString).Empty then
       Result := False
      else
       Result := True;
     end else
      Result := False;
   end;//EvDeleteIfReadOnly(ParaX)
   Exit;
  end;{EListError}
 end;{try..except}
 l_Pos := Self.pm_GetText.Modify.JoinWith(aView, l_SecondPara, anOp);
 if (Self.pm_GetParentPoint <> nil) then
 begin
  if (l_Pos >= 0) then
   if l_SecondPara.IsKindOf(k2_typBitmapPara) then
   begin
    l_Parent := l_SecondPara.Owner;
    try
     Result := evDeletePara(anOp, Self.pm_GetParentPoint, [ev_dpfAtEnd]);
    finally
     l_SecondPara.Owner := l_Parent;
    end
   end
   else
    Result := evDeletePara(anOp, Self.pm_GetParentPoint, [ev_dpfAtEnd])
  else
  if (l_Pos = -2) then
  begin
   l_Parent := ParaX.AsObject.Owner;
   if (l_Parent.ChildrenCount > 1) then
    Result := evDeletePara(anOp, Self.pm_GetParentPoint, [])
   else
   begin
    if not l_Parent.IsKindOf(k2_typDocument) then
     Result := evDeletePara(anOp, Self.pm_GetParentPoint.ParentPoint, [])
    else
     Result := True;
   end;//l_Parent.ChildrenCount > 1
  end//l_Pos = -2
  else
   Result := True;
 end//Self.pm_GetParentPoint <> nil
 else
  Result := True;
//#UC END# *49DF4C6E0101_49DF7D98029A_impl*
end;//TevTextParaCursor.DoJoinWithNext

function TevTextParaCursor.GetPaintOffsetY(const aView: InevView;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *49DF6F2F0190_49DF7D98029A_var*
//#UC END# *49DF6F2F0190_49DF7D98029A_var*
begin
//#UC START# *49DF6F2F0190_49DF7D98029A_impl*
 Result := evTextParaGetDeltaByLine(aMap, ParaX, VertPosition(aView,aMap));
//#UC END# *49DF6F2F0190_49DF7D98029A_impl*
end;//TevTextParaCursor.GetPaintOffsetY

procedure TevTextParaCursor.DoInitPointByPt(const aView: InevView;
 const aPoint: TnevPoint;
 const aMap: InevMap);
//#UC START# *49DF703901BA_49DF7D98029A_var*

var
 l_Text : Tl3PCharLen;

 function evTextParaLineByDelta(anY : Integer): Integer;
   {-}

 var
  l_DY : Integer;

  function SubLineDelta(ppLI: PPevLineInfo; anIndex: Integer): Boolean;
  begin//SubLineDelta
   evTextParaLineByDelta := anIndex;
   Dec(l_DY, ppLI^^.LE.P.Y);
   Result := (l_DY > 0);
  end;//SubLineDelta

 var
  l_IA : Tl3IteratorAction;
 begin
  Result := 0;
  l_DY := anY;
  if (l_DY > 0) then
  begin
   Dec(l_DY, aMap.FI.Spacing.Top);
   if (l_DY > 0) then
   begin
    l_IA := l3L2IA(@SubLineDelta);
    try
     evTextParaIterateLines(aMap.FI, l_Text, ParaX, l_IA);
    finally
     l3FreeIA(l_IA);
    end;//try..finally
   end;//DY > 0
  end;//DY > 0
 end;

var
 l_FI   : TnevFormatInfoPrim;
 l_Line : Integer;
 l_Pos  : Integer;
 l_SC   : Integer;
 l_Map  : InevLines;
 l_Pt   : Tl3Point;
//#UC END# *49DF703901BA_49DF7D98029A_var*
begin
//#UC START# *49DF703901BA_49DF7D98029A_impl*
 inherited;
 l_FI := aMap.FI;
 if l_FI <> nil then // http://mdp.garant.ru/pages/viewpage.action?pageId=477647506
 begin
  l_Map := aMap.FI.Lines;
  l_SC := evTextParaLineCount(aMap.FI);
  l_Pt := Tl3Point(aPoint).Sub(aMap.Bounds.R.TopLeft);
  l_Text := ParaX.Text;
  if (l_SC <= 1) then
   l_Line := 1
  else
   l_Line := evTextParaLineByDelta(l_Pt.Y) + 1;
  if (l_Pt.X <= 0) then
   l_Pos := 0
  else
   if EvHeaderTextPara(ParaX) then
    l_Pos := 0
   else
    l_Pos := evTextParaGetPosByDelta(aMap.FI, l_Text, ParaX, l_Pt.X, l_Line);
  l_Pos := evTextParaGetPosByLine(l_Map, l_Text, l_Line) + l_Pos;
  SetEntryPointPrim(l_Pos);
  f_LineEnd := (l_Line < evTextParaGetLineByPos(aMap.FI, l_Text, l_Pos));
  if (l_Pt.X > 0) AND (l_Line = l_SC) then
   f_ParaEnd := (l_Pt.X > evTextParaGetDeltaByPos(aMap.FI, l_Text, ParaX, evTextParaGetLine(l_Map, l_Text, l_Line).SLen, l_Line) + 7 * l3Epsilon)
  else
   f_ParaEnd := False;
 end; // if l_FI = nil then
//#UC END# *49DF703901BA_49DF7D98029A_impl*
end;//TevTextParaCursor.DoInitPointByPt

procedure TevTextParaCursor.DoSetEntryPointPrim(Value: Integer;
 const Context: IevCursorContext = nil);
//#UC START# *49E2F8F80062_49DF7D98029A_var*
//#UC END# *49E2F8F80062_49DF7D98029A_var*
begin
//#UC START# *49E2F8F80062_49DF7D98029A_impl*
 if (Value = ev_cpBottom) then
  Value := ev_cpAtEnd;
 if (Value = ev_cpAtEnd) then
  f_ParaEnd := true;
 Value := Max(0, Min(Value, ParaX.AsObject.PCharLenA[k2_tiText].SLen));
 inherited DoSetEntryPointPrim(Value, Context);
//#UC END# *49E2F8F80062_49DF7D98029A_impl*
end;//TevTextParaCursor.DoSetEntryPointPrim

function TevTextParaCursor.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_49DF7D98029A_var*
var
 l_DeltaX     : Integer;
 l_Tag        : InevTextPara;
 l_Pos        : Integer;              {-позиция в текстовом параграфе}
 l_Line       : Integer;              {-строка в текстовом параграфе}
 l_LineOffset : Integer;              {-смещение строки l_Line с начала параграфа}
 l_LineCount  : Integer;              {-количество строк в параграфе}
 l_ParaLine   : Tl3PCharLen;       {-строка l_Line параграфа}
 l_CheckLine  : Boolean;              {-CheckLines}
 l_PrevX      : Integer;              {-смещение предыдущей строки}
 l_Text       : Tl3PCharLen;
 l_String     : Il3WordsSeq;
 l_LineRem    : Integer;
 l_NewLine    : Integer;
 l_Code       : Integer;
 l_ParentPnt  : InevBasePoint;
 l_LinesMap   : InevLines;
 l_Map        : TnevFormatInfoPrim;
//#UC END# *49E31657038E_49DF7D98029A_var*
begin
//#UC START# *49E31657038E_49DF7D98029A_impl*
 Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 if (Result = ev_dcDoneOk) then
 begin
  if (aCode = ev_ocBottomRight) or (aCode = ev_ocBottomRightIgnoreMergedCell) then
   f_ParaEnd := True
  else
  if (aCode = ev_ocTopLeft) then
   f_ParaEnd := False;
  Exit;
 end;//Result = ev_dcDoneOk
 l_ParentPnt := Self.pm_GetParentPoint;
 l_DeltaX := 0;
 l_Tag := ParaX;
 l_Map := ObjMap(aView);
 if (l_Map = nil) then
  l_LinesMap := nil
 else
  l_LinesMap := l_Map.Lines;
 l_Pos := Position;
 l_LineCount := evTextParaLineCount(l_Map);
 l_Text := l_Tag.Text;
 if (l_Pos = ev_cpTop) then
 begin
  l_Pos := 0;
  l_Line := 1
 end//l_Pos = ev_cpTop
 else
 begin
  l_Line := evTextParaGetLineByPos(l_Map, l_Text, l_Pos);
  if f_LineEnd AND (l_Line > 1) then Dec(l_Line);
 end;//l_Pos = ev_ocTop
 case aCode of
  ev_ocWordLeft,
  ev_ocWordRight,
  ev_ocWordStart,
  ev_ocWordFinish,
  ev_ocWholeWordRight :
   if not l_Tag.AsObject.QT(Il3WordsSeq, l_String, k2Proc(anOp)) then
    Exit;
 end;//case aCode of
 try
  if l3IsNil(l_Text) then
  begin
   l3AssignNil(l_ParaLine);
   l_LineOffset := 0;
  end//l3IsNil(l_Text)
  else
  begin
   l_ParaLine := evTextParaGetLine(l_LinesMap, l_Text, l_Line);
   if (l_ParaLine.S = nil) then
    l_LineOffset := 0
   else
    l_LineOffset := l_ParaLine.Diff(l_Text);
  end;//l3IsNil(l_Text)
  case aCode of
   ev_ocWordLeft:
   begin
    l_DeltaX := l_String.WordLeft(l_Pos) - l_Pos;
    if (l_DeltaX = 0) then
     aCode := ev_ocCharLeft;
   end;{ev_ocWordLeft}
   ev_ocWordStart: l_DeltaX := l_String.WordStart(l_Pos) - l_Pos;
   ev_ocWordRight:
   begin
    l_DeltaX := l_String.WordRight(l_Pos) - l_Pos;
    if (l_DeltaX = 0) then
     aCode := ev_ocCharRight;
   end;{ev_ocWordRight}
   ev_ocWordFinish: l_DeltaX := l_String.WordFinish(l_Pos) - l_Pos;
   ev_ocWholeWordRight :
   begin
    if (l_Pos = 0) OR (l3IsWordDelim(l_Text.S[l_Pos - 1], l_Text.SCodePage)) then
    begin
     l_DeltaX := l_String.WordRight(l_Pos) - l_Pos;
     if (l_DeltaX = 0) then aCode := ev_ocCharRight;
     //l_Pos = 0
    end//l_Pos = 0
    else
    begin
     l_DeltaX := l_String.WordFinish(l_Pos) - l_Pos;
     if (l_DeltaX = 0) then
     begin
      l_DeltaX := l_String.WordRight(l_Pos) - l_Pos;
      l_DeltaX := l_String.WordFinish(l_Pos + l_DeltaX) - l_Pos;
      if (l_DeltaX = 0) then aCode := ev_ocCharRight;
     end;//l_DeltaX = 0
    end;//l_Pos = 0
   end;//ev_ocWholeWordRight
  end;//сase aCode
  case aCode of
   ev_ocWordStart, ev_ocWordFinish, ev_ocWholeWordRight,
   ev_ocWordLeft,  ev_ocWordRight,
   ev_ocCharLeft,
   ev_ocPrevCharForDelete,
   ev_ocCharRight,
   ev_ocLineHome,  ev_ocLineEnd,
   ev_ocParaHome,  ev_ocParaEnd:
   begin
    l_CheckLine := True;
    case aCode of
     ev_ocCharLeft : l_DeltaX := -1;
     ev_ocPrevCharForDelete :
     begin
      if DoPrevCharForDelete(aView, anOp) then
      begin
       Result := ev_dcDoneOk;
       Exit;
      end//DoPrevCharForDelete(anOp)
      else
       l_DeltaX := -1;
     end;//ev_ocPrevCharForDelete
     ev_ocCharRight : l_DeltaX := 1;
     ev_ocLineHome  :
     begin
      l_DeltaX := l_LineOffset - l_Pos;
      l_CheckLine := false;
     end;//ev_ocLineHome
     ev_ocLineEnd   :
     begin
      l_DeltaX := (l_LineOffset + l_ParaLine.SLen) - l_Pos;
      {$IfDef Nemesis}
      if (l_DeltaX > 0) and (l_ParaLine.SLen > 0) and l_ParaLine.IsLast(cc_SoftEnter) then
      begin
       Dec(l_DeltaX);
       // Сбросим aCode - ведь реально мы не в конце строки.
       aCode := ev_ocCharRight;
      end;
      {$EndIf Nemesis}
      l_CheckLine := False;
     end;//ev_ocLineEnd
     ev_ocParaHome  :
     begin
      l_DeltaX := - l_Pos;
      l_CheckLine := False;
     end;//ev_ocParaHome
     ev_ocParaEnd   :
     begin
      l_DeltaX := l_Text.SLen - l_Pos;
      l_CheckLine := False;
     end;//ev_ocParaEnd
    end;{case CP ..}
    if (l_DeltaX <> 0) then
    begin
     if l_CheckLine then
     begin
      if (l_Pos + l_DeltaX < l_LineOffset) then
       { - На предыдущую строку. }
       aCode := ev_ocLineLeft
      else
      begin
       if (aCode = ev_ocCharRight) AND (l_Line < l_LineCount) then
       begin
        if (l_Pos + l_DeltaX >= l_LineOffset + l_ParaLine.SLen) then
         { - На следующую строку. }
         aCode := ev_ocLineRight
        else
         l_CheckLine := False;
       end//aCode = ev_ocCharRight
       else
       begin
        if (l_Pos + l_DeltaX > l_LineOffset + l_ParaLine.SLen) then
         { - На следующую строку. }
         aCode := ev_ocLineRight
        else
         l_CheckLine := False;
       end;//aCode = ev_ocCharRight..
      end;//l_Pos + l_DeltaX < l_LineOffset
     end;//l_CheckLine
     if not(l_CheckLine) then
     begin
      Inc(l_Pos, l_DeltaX);
      SetEntryPoint(l_Pos, anOp);
      case aCode of
       ev_ocLineHome :
       begin
        f_ParaEnd := False;
        pm_SetLineEnd(False);
       end;//ev_ocLineHome
       ev_ocLineEnd :
       begin
        f_ParaEnd := (l_Line = l_LineCount);
        pm_SetLineEnd((l_Line < l_LineCount));
       end;//ev_ocLineEnd
       ev_ocParaEnd :
       begin
        f_ParaEnd := True;
        pm_SetLineEnd(False);
       end;//ev_ocParaEnd
       else
       begin
        f_ParaEnd := False;
        pm_SetLineEnd((l_Line < evTextParaGetLineByPos(l_Map, l_Text, l_Pos)));
       end;//else
      end;//case aCode
      Result := ev_dcDoneOk;
     end;{if not(l_CheckLine)}
    end//l_DeltaX <> 0
    else
    begin
     Result := ev_dcDoneOk;
     case aCode of
      ev_ocLineHome :
      begin
       f_ParaEnd := false;
       pm_SetLineEnd(false);
      end;//ev_ocLineHome
      ev_ocLineEnd :
      begin
       f_ParaEnd := (l_Line = l_LineCount);
       pm_SetLineEnd((l_Line < l_LineCount));
      end;//ev_ocLineEnd
      ev_ocParaEnd:
      begin
       f_ParaEnd := True;
       pm_SetLineEnd(False);
      end;//..ev_ocParaEnd..
     end;//case aCode
    end;//l_DeltaX <> 0
   end;
  end;//case aCode..
  if (Result = ev_dcDoneOk) then Exit;
  case aCode of
   ev_ocLineLeft, ev_ocLineUp,
   ev_ocLineRight, ev_ocLineDown:
   begin
    case aCode of
     ev_ocLineLeft, ev_ocLineUp:
      l_NewLine := l_Line - aCount;
     ev_ocLineRight, ev_ocLineDown: 
      l_NewLine := l_Line + aCount;
     else
      l_NewLine := l_Line;
      Assert(False);
    end;//case aCode
    if (l_NewLine <= 0) then
    begin
     { - На предыдущий параграф. }
     l_LineRem := -(l_NewLine - 1);
     l_NewLine := 1;
    end//l_NewLine <= 0
    else
    if (l_NewLine > l_LineCount) then
    begin
     { - На следующий параграф. }
     l_LineRem := (l_NewLine - l_LineCount);
     l_NewLine := l_LineCount;
    end//l_NewLine > l_LineCount
    else
     l_LineRem := 0;
    if (l_Line <> l_NewLine) then
    begin
     l_PrevX := evTextParaGetDeltaByPos(l_Map, l_Text, l_Tag, l_Pos - l_LineOffset, l_Line);
     l_Line := l_NewLine; { - Перемещаемся на другую строку. }
     l_ParaLine := evTextParaGetLine(l_LinesMap, l_Text, l_Line);
     if (l_ParaLine.S = nil) OR (l_Text.S = nil) then
      l_LineOffset := 0
     else
      l_LineOffset := l_ParaLine.Diff(l_Text);
     case aCode of
      ev_ocLineUp,
      ev_ocLineDown  :
       l_Pos := evTextParaGetPosByDelta(l_Map, l_Text, l_Tag, l_PrevX, l_Line);
      ev_ocLineLeft  :
       l_Pos := Max(0, Pred(l_ParaLine.SLen));
      ev_ocLineRight :
       l_Pos := 0;
     end;//case aCode ..
     Inc(l_Pos, l_LineOffset);
     SetEntryPoint(l_Pos, anOp);
     pm_SetLineEnd((l_Line < evTextParaGetLineByPos(l_Map, l_Text, l_Pos)));
     f_ParaEnd := False;
     Result := ev_dcDoneOk;
    end;//l_Line <> l_NewLine
    case aCode of
     ev_ocLineUp :
      l_Code := ev_ocParaUp;
     ev_ocLineDown  :
      l_Code := ev_ocParaDown;
     ev_ocLineLeft  :
      l_Code := ev_ocParaLeft;
     ev_ocLineRight :
      l_Code := ev_ocParaRight;
     else
      l_Code := 0;
      Assert(False);
    end;//case aCode ..
    if (l_LineRem > 0) AND (l_ParentPnt <> nil) then
    begin
     if l_ParentPnt.Move(aView, l_Code, anOp) then
     begin
      Result := ev_dcDoneOk;
      Dec(l_LineRem);
      if (l_LineRem > 0) then
       l_ParentPnt.Move(aView, aCode, anOp, l_LineRem);
     end;//l_ParentPnt.Move
    end;//l_LineRem > 0
    Exit;
   end;//ev_ocLineLeft, ev_ocLineUp,
   ev_ocParaUp, ev_ocParaDown, ev_ocParaLeft, ev_ocParaRight,
   ev_ocPrevParaBottomRight, ev_ocNextParaTopLeft, ev_ocParaDownWithEmptyRow: ;
    // - Транслируем сообщение родителю
   else
    Result := ev_dcDoneFail;
  end;//case aCode
 finally
  l_String := nil;
 end;//try..finally
 if (Result = ev_dcNotDone) AND (l_ParentPnt <> nil) then
  Result := l_ParentPnt.DoMove(aView, aCode, anOp, aCount);
//#UC END# *49E31657038E_49DF7D98029A_impl*
end;//TevTextParaCursor.DoMovePrim

procedure TevTextParaCursor.DoSetAtEnd(const aView: InevView;
 aValue: Boolean);
//#UC START# *49E317B802F3_49DF7D98029A_var*
//#UC END# *49E317B802F3_49DF7D98029A_var*
begin
//#UC START# *49E317B802F3_49DF7D98029A_impl*
 if aValue then
  inherited
 else
  f_ParaEnd := aValue;
//#UC END# *49E317B802F3_49DF7D98029A_impl*
end;//TevTextParaCursor.DoSetAtEnd

function TevTextParaCursor.GetAtStart: Boolean;
//#UC START# *49E34DCB014D_49DF7D98029A_var*
//#UC END# *49E34DCB014D_49DF7D98029A_var*
begin
//#UC START# *49E34DCB014D_49DF7D98029A_impl*
 Result := (Position <= 0);
//#UC END# *49E34DCB014D_49DF7D98029A_impl*
end;//TevTextParaCursor.GetAtStart

function TevTextParaCursor.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *49E34DFB0259_49DF7D98029A_var*
//#UC END# *49E34DFB0259_49DF7D98029A_var*
begin
//#UC START# *49E34DFB0259_49DF7D98029A_impl*
 Result := f_ParaEnd and (Position >= ParaX.AsObject.PCharLenA[k2_tiText].SLen);
//#UC END# *49E34DFB0259_49DF7D98029A_impl*
end;//TevTextParaCursor.GetAtEnd

function TevTextParaCursor.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *49E34EDF0207_49DF7D98029A_var*
//#UC END# *49E34EDF0207_49DF7D98029A_var*
begin
//#UC START# *49E34EDF0207_49DF7D98029A_impl*
 if (aMap = nil) then
  Result := GetLine(ObjMap(aView))
 else
  Result := GetLine(aMap);
 Dec(Result);
//#UC END# *49E34EDF0207_49DF7D98029A_impl*
end;//TevTextParaCursor.GetVertPosition

function TevTextParaCursor.GetReadOnly: Boolean;
//#UC START# *49E3520F0174_49DF7D98029A_var*
//#UC END# *49E3520F0174_49DF7D98029A_var*
begin
//#UC START# *49E3520F0174_49DF7D98029A_impl*
 Result := inherited GetReadOnly;
 if not Result then
  if EvHeaderTextPara(ParaX) then
   Result := ParaX.OwnerPara.BoolA[k2_tiCollapsed];
//#UC END# *49E3520F0174_49DF7D98029A_impl*
end;//TevTextParaCursor.GetReadOnly

function TevTextParaCursor.GetDeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *49E3568201B9_49DF7D98029A_var*
var
 l_Line : Integer;
 l_Para : InevTextPara;
 l_Text : Tl3PCharLen;
 l_FI   : TInevFormatInfoRet;
//#UC END# *49E3568201B9_49DF7D98029A_var*
begin
//#UC START# *49E3568201B9_49DF7D98029A_impl*
 l_FI := aMap.FI;
 if (l_FI = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=259893686
  Result := 0
 else
 begin
  l_Line := GetLine(l_FI);
  l_Para := ParaX;
  l_Text := l_Para.Text;
  Result := evTextParaGetDeltaByPos(l_FI,
                                    l_Text,
                                    l_Para,
                                    Position - evTextParaGetPosByLine(l_FI.Lines, l_Text, l_Line),
                                    l_Line);
  Result := aMap.Bounds.Left + Result;
 end;//l_FI = nil
//#UC END# *49E3568201B9_49DF7D98029A_impl*
end;//TevTextParaCursor.GetDeltaX

function TevTextParaCursor.DoGetBlockLength: Integer;
//#UC START# *49E3662D028E_49DF7D98029A_var*
//#UC END# *49E3662D028E_49DF7D98029A_var*
begin
//#UC START# *49E3662D028E_49DF7D98029A_impl*
 Result := evTextLength(ParaX.AsObject);
//#UC END# *49E3662D028E_49DF7D98029A_impl*
end;//TevTextParaCursor.DoGetBlockLength

function TevTextParaCursor.DoGetStyle(Stop: PInteger): Tl3Variant;
//#UC START# *4A2945060101_49DF7D98029A_var*
//#UC END# *4A2945060101_49DF7D98029A_var*
begin
//#UC START# *4A2945060101_49DF7D98029A_impl*
 Result := ParaX.Formatting[Position].GetStyle(Stop);
//#UC END# *4A2945060101_49DF7D98029A_impl*
end;//TevTextParaCursor.DoGetStyle

function TevTextParaCursor.DoGetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger): InevFontPrim;
//#UC START# *4A29477801BF_49DF7D98029A_var*
//#UC END# *4A29477801BF_49DF7D98029A_var*
begin
//#UC START# *4A29477801BF_49DF7D98029A_impl*
 Result := ParaX.Formatting[Position].GetFont(aView, aMap, Stop);
//#UC END# *4A29477801BF_49DF7D98029A_impl*
end;//TevTextParaCursor.DoGetFont

{$If Defined(evNeedMarkers)}
procedure TevTextParaCursor.DoGetMarkers(const aView: InevView;
 const aList: IevMarkersList);
//#UC START# *4A38AA5C019F_49DF7D98029A_var*

 procedure TryToAddIndentMarker;
 var
  l_Marker  : TevTabIndentMarker;
  l_TabStop : Tl3Variant;
 begin
  if evGetDecimalTabIndentTag(ParaX.AsObject, l_TabStop) then
  begin
   l_Marker := TevTabIndentMarker.Create(aView,
                                         ParaX.AsObject,
                                         l_TabStop,
                                         str_nevmhTabIndent.AsCStr);
   try
    aList.Add(l_Marker);
   finally
    FreeAndNil(l_Marker);
   end;{try..finally}
  end;//if evGetDecimalTabIndentTag(ParaX, l_TabStop) then
 end;

//#UC END# *4A38AA5C019F_49DF7D98029A_var*
begin
//#UC START# *4A38AA5C019F_49DF7D98029A_impl*
 AddMarker(aView, aList, k2_tiLeftIndent, ev_pmsLeftIndent,
  str_nevmhLeftIndent.AsCStr);
 if (ParaX.AsObject.IntA[k2_tiStyle] <> ev_saTxtNormalOEM) then
  AddMarker(aView, aList, k2_tiRightIndent, ev_pmsWrapColumn,
   str_nevmhRightIndent.AsCStr,
   TevTextParaRightIndentMarker);
 AddMarker(aView, aList, k2_tiFirstIndent, ev_pmsFirstIndent,
  str_nevmhRedLineIndent.AsCStr);
 TryToAddIndentMarker;
//#UC END# *4A38AA5C019F_49DF7D98029A_impl*
end;//TevTextParaCursor.DoGetMarkers
{$IfEnd} // Defined(evNeedMarkers)

function TevTextParaCursor.DoDeleteHyperlink(const anOpPack: InevOp): Boolean;
//#UC START# *4A38F52201BA_49DF7D98029A_var*
var
 l_Si       : Integer;
 l_TextPara : InevPara;
 l_Segs     : Tl3Variant;
//#UC END# *4A38F52201BA_49DF7D98029A_var*
begin
//#UC START# *4A38F52201BA_49DF7D98029A_impl*
 Result := True;
 l_TextPara := ParaX;
 l_Segs := l_TextPara.AsObject.Attr[k2_tiSegments];
 with l_Segs do
  if IsValid then
   with evSegments_GetSegmentOnPos(l_Segs, ev_slHyperlinks, Position, l_Si) do
    if IsValid AND IsKindOf(k2_typHyperlink) then
    begin
     evSegments_DeleteSegment(l_TextPara, ev_slHyperlinks, l_Si, anOpPack);
     l_TextPara.Invalidate([nev_spExtent]);
    end;//..k2_idHyperlink..
//#UC END# *4A38F52201BA_49DF7D98029A_impl*
end;//TevTextParaCursor.DoDeleteHyperlink

function TevTextParaCursor.DoInsertBreak(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F59B0234_49DF7D98029A_var*
var
 l_Context : IevCursorContext;
 l_Pos     : Integer;

  function _ModifyCursor(C: PevTextParaCursor; Index: Integer): Boolean; far;
  var
   PLC : InevBasePoint;
   OEP : Integer;
   l_BrokenPara : InevPara;
   l_BrokenParaOwner : InevPara;
   l_BrokenParaOwnerOwner : InevPara;
   l_List : InevObject;
   l_Inn : InevBasePoint;
  begin{_ModifyCursor}
   Result := True;
   if (C^.Position >= l_Pos) then
   begin
    PLC := InevPoint(C^).ParentPoint;
    if (PLC <> nil) then
     try
      OEP := C^.Position;
      with PLC do
      begin
       l_BrokenPara := C^.ParaX;
       if not l_BrokenPara.AsObject.Owner.QT(InevPara, l_BrokenParaOwner) then
        Assert(false);
       l_List := Obj^;
       if l_List.AsObject.IsSame(l_BrokenParaOwner.AsObject) then
       // http://mdp.garant.ru/pages/viewpage.action?pageId=245760058
       // - параграф мог запросто переехать в другого родителя
       begin
        SetEntryPoint(Succ(Position), l_Context);
        if HasInner then
        begin
         if Inner.AsObject.IsKindOf(k2_typLeafPara) then
         // - Вставили листьевой параграф
         begin
          Inner.SetEntryPoint(OEP - l_Pos, l_Context);
          Inner.Refresh;
         end//Inner.IsKindOf(k2_typLeafPara)
         else
          Inner.Move(aView, ev_ocTopLeft, anOp);
          // - Формируем цепочку детей
        end;//HasInner
       end//l_List.IsSame(l_BrokenParaOwner)
       else
       begin
        if not l_BrokenParaOwner.AsObject.Owner.QT(InevPara, l_BrokenParaOwnerOwner) then
         Assert(false);
        if l_List.AsObject.IsSame(l_BrokenParaOwnerOwner.AsObject) then
        begin
         l_Inn := l_BrokenParaOwner.MakePoint;
         if not l_BrokenPara.AsObject.Box.QT(InevPara, l_BrokenPara) then
         // - это специальный такой трюк, иначе OwnerPara "залипает" и PID
         //   считается неправильно. Ну а дальше и Next - не работает.
          Assert(false);
         l_Inn.Inner := l_BrokenPara.MakePoint;
         l_Inn.Move(aView, ev_ocNextParaTopLeft, anOp);
         PLC.Inner := l_Inn;
        end//l_List.IsSame(l_BrokenParaOwnerOwner)
        else
         Assert(false, 'Странная ситуация после вставки разрыва параграфа');
       end;//l_List.IsSame(l_BrokenParaOwner)
      end;//with PLC
     finally
      PLC := nil;
     end;//try..finally
   end;//C^.Position >= l_Pos
  end;{_ModifyCursor}

var
 l_OldPara     : InevTextPara;
 l_NewPara     : Il3TagRef;
 l_RightBorder : Integer;
 l_SpacesCount : Integer;
 l_String      : Tl3InterfacedString;
//#UC END# *4A38F59B0234_49DF7D98029A_var*
begin
//#UC START# *4A38F59B0234_49DF7D98029A_impl*
 Result := True;
 l_Context := anOp As IevCursorContext;
 l_OldPara := ParaX;
 l_Pos := Position;
 if aDrawLines then
 begin
  with l_OldPara do 
  begin
   if (IntA[k2_tiStyle] = ev_saTxtNormalOEM) then
    with Attr[k2_tiText] do
     if IsValid then
      with (AsObject As Tl3CustomString) do 
      begin
       if IsOEMEx then 
       begin
        l_RightBorder := l3CharSetPresentEx(St + l_Pos, Len - l_Pos, cc_Graph_Criteria);
        if (l_RightBorder <> -1) then 
        begin
         l_SpacesCount := l3CharSetPresentExR(St + l_Pos, Pred(l_RightBorder), cc_AllChars - [cc_HardSpace]);
         l_String := Tl3InterfacedString.Create;
         try
          if (l_SpacesCount = -1) then
          begin
           Self.SetEntryPoint(l_Pos + l_RightBorder, l_Context);
           l_String.Append(cc_Hardspace);
           DoInsertString(aView, l_String, anOp, True, [misfDraw]);
           Self.AsPoint.Text.Modify.DeleteCharToLeft(aView, True, anOp);
          end//l_SpacesCount = -1
          else
          begin
           l_String.Append(cc_Hardspace, l_RightBorder);
           DoInsertString(aView, l_String, anOp, True, [misfDraw]);
          end;//l_SpacesCount = -1
         finally
          FreeAndNil(l_String);
         end;//try..finally
         Exit;
        end;//l_RightBorder <> -1
       end;//IsOEMEx
      end;//with (AsObject As Tl3CustomString)
  end;//with l_OldPara
 end;//aDrawLines
 begin
  l_NewPara := Split(aView, [misfLockCursors], anOp);
  try
   if (l_NewPara = nil) OR not l_NewPara.AsObject.IsValid then
   begin
    Result := False;
    Exit;
   end//l_NewPara = nil
   else
    evInsertPara(anOp, Self.pm_GetParentPoint, l_NewPara.AsObject, [ev_ipfAtEnd]);
  finally
   l_NewPara := nil;
  end;//try..finally
  evIterateCursorsF(l_OldPara.AsObject, l3L2IA(@_ModifyCursor));
 end;//aDrawLines
//#UC END# *4A38F59B0234_49DF7D98029A_impl*
end;//TevTextParaCursor.DoInsertBreak

function TevTextParaCursor.DoAddIndentMarker(const aView: InevView;
 aValue: Integer;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F69F0070_49DF7D98029A_var*
//#UC END# *4A38F69F0070_49DF7D98029A_var*
begin
//#UC START# *4A38F69F0070_49DF7D98029A_impl*
 Result := evNewIndentMarker(aView, aValue, ParaX, anOpPack);
//#UC END# *4A38F69F0070_49DF7D98029A_impl*
end;//TevTextParaCursor.DoAddIndentMarker

function TevTextParaCursor.DoDeleteIndentMarker(const aView: InevView;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F6CB003C_49DF7D98029A_var*
//#UC END# *4A38F6CB003C_49DF7D98029A_var*
begin
//#UC START# *4A38F6CB003C_49DF7D98029A_impl*
 Result := evDeleteIndentMarker(ParaX, anOpPack);
//#UC END# *4A38F6CB003C_49DF7D98029A_impl*
end;//TevTextParaCursor.DoDeleteIndentMarker

function TevTextParaCursor.DoInsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp;
 InsertMode: Boolean;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F71601D6_49DF7D98029A_var*
var
 l_Pos       : Integer;
 l_Ctx       : IevCursorContext;
 l_TextPara  : InevTextPara;
 l_InsString : Tl3InterfacedString;

  function _DoInsert: Boolean;
  begin{_DoInsert}
   if (misfLockSegments in aFlags) then
    Result := evDir_InsertText(l_TextPara, l_InsString, l_Pos, False)
   else
   begin
    CheckSegments(l_Pos, anOp);
    Result := evDir_InsertText(l_TextPara, l_InsString, l_Pos, True, False, anOp);
   end;//misfLockSegments in aFlags
  end;{_DoInsert}

  procedure MoveCursors(aLen : Integer);
  
   function _ModifyCursor(C: PevTextParaCursor; Index: Integer): Boolean; far;
   var
    oPos : Integer;
    nPos : Integer;
   begin{_ModifyCursor}
    Result := True;
    oPos := C^.Position;
    if (oPos >= l_Pos) then
     nPos := oPos + aLen
    else
     nPos := oPos;
    if (nPos = oPos) then
     C^.Refresh
    else begin
     C^.SetEntryPoint(nPos, l_Ctx);
     C^.f_LineEnd := False;
    end;
   end;{_ModifyCursor}

  begin
   if not(misfLockCursors in aFlags) then
    evIterateCursorsF(l_TextPara.AsObject.Box, l3L2IA(@_ModifyCursor));
  end;

var
 l_Text : Tl3String;

  function DoOverwrite: Boolean;
  var
   l_InsLen   : Integer;
   l_OvrLen   : Integer;
   l_Old      : Tl3String;
   l_MoveCount: Integer;
  begin//DoOverwrite
   if l_Text.Empty then
    Result := DoInsertString(aView, l_InsString, anOp, True, aFlags)
   else
   begin
    Result := True;
    l_InsLen := Max(0, l_InsString.Len - (l_Text.Len - l_Pos));
    // - Вычисляем сколько у нас останется после замены
    l_OvrLen := l_InsString.Len - l_InsLen;
    // - Вычисляем длину заменяемого куска

    if (l_OvrLen > 0) then 
    begin
     l_MoveCount := l_OvrLen;
     if l_Text.CodePage = CP_Unicode then
      l_Pos := l_Pos * SizeOf(WideChar);
     l_Old := Tl3String.Make(l3PCharLen(l_Text.St + l_Pos, l_OvrLen, l_Text.CodePage));
     // - Запоминаем старый текст
     try
      l_InsString.CodePage := l_Text.CodePage;
      // - Приводим кодировку строки в соответствие с кодировкой параграфа
      if l_Text.CodePage = CP_Unicode then
       l_OvrLen := l_OvrLen * SizeOf(WideChar);
      System.Move(l_InsString.St^, l_Text.St[l_Pos], l_OvrLen);
      // - Здесь осуществляем замену

      if (anOp <> nil) then
       anOp.MarkModified(l_TextPara.AsObject);

      l_TextPara.Invalidate([nev_spExtent]);
      if (misfForSelection in aFlags) then
       // МИНУС 1 из-за - http://mdp.garant.ru/pages/viewpage.action?pageId=220596558
       Dec(l_MoveCount);
      if (misfLockCursors in aFlags) AND (misfDirect in aFlags) then
       SetEntryPoint(l_Pos + l_MoveCount, l_Ctx)
       // - Перемещаем курсор
      else
      if not (misfDirect in aFlags) then
      // http://mdp.garant.ru/pages/viewpage.action?pageId=224788868
       MoveCursors(l_MoveCount);
       // http://mdp.garant.ru/pages/viewpage.action?pageId=216794957

      OevTextConvert.ToUndo(anOp,
                            l_TextPara.AsObject.Box,
                            l_Pos,
                            l_Old.AsPCharLen,
                            l3PCharLen(l_Text.St + l_Pos, l_OvrLen, l_Text.CodePage));
     finally
      FreeAndNil(l_Old);
     end;//try..finally
     l_InsString.Delete(0, l_OvrLen);
    end;//l_OvrLen > 0

    if (l_InsLen > 0) then
     // - Здесь вставляем остаток строки
     DoInsertString(aView, l_InsString, anOp, True, aFlags)
    else
    if (ParaX.DocumentContainer <> nil) AND
       (ParaX.DocumentContainer.TextSource <> nil) then
     ParaX.DocumentContainer.TextSource.ViewArea.Changed(nev_cpText);
   end;//l_Text.Empty
  end;//DoOverwrite

var
 l_TextProcessor : IevTextOpProcessor;

  procedure DoInsert;
  begin//DoInsert
   if _DoInsert then
   begin
    Result := True;
    if (l_TextProcessor <> nil) then
     l_TextProcessor.TextOp(l_InsString, l3_opInsert);
    MoveCursors(l_InsString.Len);
    if (misfLockSegments in aFlags) then
     OevInsertString1.ToUndo(anOp, l_TextPara.AsObject, l_Pos, l_InsString)
    else
     OevInsertString.ToUndo(anOp, l_TextPara.AsObject, l_Pos, l_InsString);
   end;//_DoInsert..
  end;//DoInsert

var
 l_StLen : Integer;

  function InsertIntoTable: Boolean;  
  var
   l_RightBorder  : Integer;

   procedure DeleteTail;
   begin//DeleteTail
    l_TextPara.SubRange(aView,
                        l_Pos + l_RightBorder,
                        l_Pos + l_RightBorder + l_InsString.Len).Modify.Delete(aView, anOp);
   end;//DeleteTail

   function InsertOverSpaces: Boolean;
   var
    l_SpacesCount  : Integer;
   begin//InsertOverSpaces
    Result := True;
    if (l_InsString.Len <= l_RightBorder) then 
    begin
     // - Вставляемая строка влезает
     l_SpacesCount := l3CharSetPresentEx(l_Text.St + l_Pos, Succ(l_RightBorder), cc_AllChars - [cc_HardSpace]);
     if (l_SpacesCount > l_InsString.Len) OR
        (l_SpacesCount = l_RightBorder) then 
     begin
      // - Вставляем на место пробелов
      DoOverwrite;
      Exit;
     end;//l_SpacesCount > l_InsString.Len
     l_SpacesCount := l3CharSetPresentExR(l_Text.St + l_Pos, Pred(l_RightBorder), cc_AllChars - [cc_HardSpace]);
     if (l_SpacesCount <> -1) AND
        (l_RightBorder - l_SpacesCount > l_InsString.Len) then 
     begin
      // - Вставляем строку и удаляем концевые пробелы
      DoInsert;
      DeleteTail;
      Exit;
     end;//l_SpacesCount >= l_InsString.Len
    end;//l_InsString.Len <= l_RightBorder
    Result := False;
   end;//InsertOverSpaces

   function InsertIntoNext: Boolean;        
   var
    l_OldParentPos : Integer;
    l_InsPos       : Integer;
    l_Next         : Tl3Variant;
    l_Parent       : InevBasePoint;

    procedure _IntoNext;
    var
     l_String     : Tl3InterfacedString;
     l_StringTool : Il3WordsSeq;
     l_FillLen    : Integer;
     l_MaxLen     : Integer;
     l_WordStart  : Integer;
     l_JumpLen    : Integer;
    begin//_IntoNext
     with l_Parent do
     begin
      if (l_RightBorder = 0) then
      begin
       SetEntryPoint(Succ(l_OldParentPos), anOp);
       Inner.SetEntryPoint(l_InsPos, anOp);
       Inner.Text.Modify.InsertString(aView, l_InsString, anOp, True, aFlags);
      end//l_RightBorder = 0
      else
      begin
       DoInsert;
       if l_TextPara.AsObject.QT(Il3WordsSeq, l_StringTool, k2Proc(anOp)) then
        try
         l_WordStart := l_StringTool.WordStart(l_Pos + l_RightBorder);
        finally
         l_StringTool := nil;
        end//try..finally
       else
        l_WordStart := l_Pos + l_RightBorder;
       l_FillLen := l_Pos + l_RightBorder + l_InsString.Len - l_WordStart;
       l_MaxLen := Max(0, l_Pos + l_RightBorder - l_InsPos);
       if (l_MaxLen < l_FillLen) then
       begin
        Inc(l_WordStart, l_FillLen - l_MaxLen);
        l_FillLen := l_MaxLen;
       end;//l_MaxLen < l_FillLen
       l_String := Tl3InterfacedString.Make(l3PCharLen(l_Text.St + l_WordStart,
                                             l_FillLen,
                                             l_Text.CodePage));
       try
        if (l_FillLen <> l_MaxLen) AND (l_String.Last <> cc_HardSpace) then
         l_String.Append(cc_HardSpace);
        l_JumpLen := (Pred(Self.Position) - l_WordStart);
        SetEntryPoint(Succ(l_OldParentPos), anOp);
        Inner.SetEntryPoint(l_InsPos, anOp);
        Inner.Text.Modify.InsertString(aView, l_String, anOp, True, aFlags);
       finally
        FreeAndNil(l_String);
       end;//try..finally
       SetEntryPoint(l_OldParentPos, anOp);
       try
        if (l_FillLen > l_InsString.Len) then
        begin
         Self.SetEntryPoint(l_WordStart, anOp);
         l_String := Tl3InterfacedString.Create;
         try
          l_String.Append(cc_HardSpace, l_FillLen - l_InsString.Len);
          InsertString(aView, l_String, anOp, False, aFlags);
         finally
          FreeAndNil(l_String);
         end;//try..finally
        end;//l_FillLen
       finally
        Inner.SetEntryPoint(l_Pos + l_InsString.Len, anOp);
       end;//try..finally
       if (l_JumpLen >= -1) then
       begin
        SetEntryPoint(Succ(l_OldParentPos), anOp);
        Inner.SetEntryPoint(l_InsPos + Succ(l_JumpLen), anOp);
       end;//l_Jump
       DeleteTail;
      end;//l_RightBorder = 0
     end;//with l_Parent
    end;//_IntoNext

   var
    l_String : Tk2String;
   begin//InsertIntoNext
    Result := True;
    l_Parent := Self.pm_GetParentPoint;
    if (l_Parent <> nil) then
    begin
     // - У нашего курсора есть родитель
     l_Next := k2NullTag;
     with l_Parent do
     begin
      l_OldParentPos := Position;
      if (l_OldParentPos < GetBlockLength) then // Было '<=' http://mdp.garant.ru/pages/viewpage.action?pageId=585939800
      begin
       // - У родителя еще есть следующий параграф
       l_Next := Obj.AsObject.Child[Position];
       // - Берем следующий
       if l_Next.IsKindOf(k2_typTextPara) then 
       begin
        // - Это текстовый параграф
        if (l_Next.IntA[k2_tiStyle] = ev_saTxtNormalOEM) then
        begin
         // - Стиль следующего нам подходит
         with l_Next.Attr[k2_tiText] do
          if IsValid then begin
           with (AsObject As Tl3CustomString) do
            if IsOEMEx then
            begin
             l_InsPos := l3CharSetPresentExR(St, Min(Len, Max(0, Pred(l_Pos))), cc_Graph_Criteria);
             Inc(l_InsPos);
             if (l_InsPos < Len) AND (St[l_InsPos] in cc_Graph_Criteria) then
              l_Next := k2NullTag;
              // - Проверяем на то что есть куда вставлять
            end//IsOEMEx
            else
             l_Next := k2NullTag;
          end
          else
           l_Next := k2NullTag;
        end
        else
         l_Next := k2NullTag;
       end 
       else
        l_Next := k2NullTag;
      end;//Position <= BlockLength
     end;//with TevCursor(l_Parent)
     if l_Next.IsValid then
      _IntoNext
     else 
     begin
      l_Next := l_TextPara.AsObject.TagType.MakeTag.AsObject;
      try
       l_Next.AsObject.AssignCloneParams(l_TextPara.AsObject);
       l_String := Tk2String.Create;
       try
        l_String.AssignString(l_Text);
        with l_String do
        begin
         l3Replace(AsPCharLen, cc_AllChars - cc_Graph_Criteria, cc_HardSpace);
         l_InsPos := l3CharSetPresentExR(St, Min(Len, Max(0, Pred(l_Pos))), cc_Graph_Criteria);
         Inc(l_InsPos);
        end;//with l_String
        l_Next.AttrW[k2_tiText, nil] := l_String;
        //l_Next.Attr[k2_tiText] := k2Tag(l_String);
       finally
        FreeAndNil(l_String);
       end;//try..finally
       evInsertPara(anOp, l_Parent, l_Next);
       _IntoNext;
      finally
       l_Next := nil;
      end;//try..finally
     end;//l_Next.IsValid
     Exit;
    end;//l_Parent Is TevCursor
    Result := false;
   end;//InsertIntoNext

  begin//InsertIntoTable
   Result := True;
   // - Здесь пытаемся нарезать псевдотаблицу на строки
   l_RightBorder := l3CharSetPresentEx(l_Text.St + l_Pos, l_StLen - l_Pos, cc_Graph_Criteria);
   if (l_RightBorder <> -1) then 
   begin
    // - Нашли правую границу
    if (l_RightBorder = 0) AND
       ((l_Pos <= 0) OR (l_Text.Ch[Pred(l_Pos)] in cc_Graph_Criteria)) then
     Exit;
     // - Вбивать букву некуда
    if InsertOverSpaces then
     Exit;
    // - Видимо с пробелами ничего не получилось - будем пробовать переносить слова
    if InsertIntoNext then
     Exit;
   end;//l_RightBorder <> -1
   Result := false;
  end;//InsertIntoTable

 procedure CheckQuotes(S: Tl3CustomString; Open: Boolean; IsOEM: Boolean);
 var
  i : Integer;
  C : AnsiChar;
 begin
  if IsOEM then Exit;
  for i := 0 to S.Len do
  begin
   C := S.St[i];
   case C of
    cc_DoubleQuote:
    begin
     S.St[i] := cc_DoubleQuotes[Open];
     Open := False;
    end;//cc_Quote
    cc_SingleQuote:
    begin
     S.St[i] := cc_SingleQuotes[Open];
     Open := False;
    end;//cc_Quote
    else
     Open := (C in cc_OpenQuotePrev[IsOEM]);
   end;//case C
  end;//for i
 end;

var
 PrevChar     : Integer;
 PrevSpace    : Boolean;
 SuccSpace    : Boolean;
 l_Processor  : InevProcessor;
 l_OEM        : Boolean;
 l_Str        : Tl3CustomString;
 l_NewStr     : Tk2String;
//#UC END# *4A38F71601D6_49DF7D98029A_var*
begin
//#UC START# *4A38F71601D6_49DF7D98029A_impl*
 Result := False;
 if l3IsNil(aString) AND (anOp = nil) then
  Exit;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=604485227
 if not ReadOnly AND not l3IsNil(aString) AND (anOp <> nil) then
 begin
  Supports(anOp, IevCursorContext, l_Ctx);
  l_TextPara := ParaX;
  l_Pos := Position;      
  l_Processor := anOp.Processor;
  //if (l_Processor <> nil) then
  begin
   l_InsString := Tl3InterfacedString.Make(l3PCharLen(aString));
   try
    try
     {$IFDEF Nemesis} // Это правили для БП (http://mdp.garant.ru/pages/viewpage.action?pageId=235048829). Для Арчи такого не заказывали.
     if InsertMode OR not (misfForSelection in aFlags) then
     // - если перезаписываем текст поверх, то ругаться воде бы и не нужно
     {$ENDIF Nemesis}
      if (l_Processor <> nil) then
      begin
       l_TextProcessor := (l_Processor as IevTextOpProcessor);
       l_TextProcessor.CheckTextOp(l_InsString, l3_opInsert);
       // В CheckTextOp длину строки могли уменьшить так, что она стала отрицательной
       // Видимо, тогда вставлять ничего не нужно
       // http://mdp.garant.ru/pages/viewpage.action?pageId=284165335
       if (not l_InsString.Empty) and (l_InsString.Len < 0) then
        l_InsString.Clear;
      end;//l_Processor <> nil

     if not l_InsString.Empty then
     begin
      // Всякие разные хитрости со вставляемой строкой:
      with l_TextPara.AsObject.Attr[k2_tiText] do
       if IsValid then
       begin
        l_Str := AsObject as Tl3CustomString;
        if (l_Str is Tl3String) then
         l_Text := Tl3String(l_Str)
        else
        begin
        // - Здесь делаем копию текста, которую мы знаем как редактировать
         l_NewStr := Tk2String.Make(l_Str);
         try
          l_TextPara.AsObject.AttrW[k2_tiText, anOp] := l_NewStr;
          //l_TextPara.AttrW[k2_tiText, anOp] := k2Tag(l_Str);
          l_Text := l_NewStr;
         finally
          FreeAndNil(l_NewStr);
         end;//try..finally
        end;//l_Str Is Tl3String
       end//IsValid
       else
        l_Text := nil;

      if InsertMode then
      begin
       if [misfDirect, misfSetText] * aFlags = [] then
       begin
        //- Если не прямая вставка строки
        if l_Text.Empty then
        begin
         l_StLen := 0;
         l_OEM := False;
        end//l_Text.Empty
        else
        begin
         l_StLen := l_Text.Len;
         l_OEM := l_Text.IsOEMEx;
        end;//l_Text.Empty
        if (l_StLen > 0) AND (l_Pos > 0) then 
        begin
         PrevChar := Ord(l_Text[l_Pos - 1]);
         SuccSpace := (l_Text[l_Pos] in (cc_OpenQuotePrev[l_OEM] - [cc_SoftEnter]));
        end 
        else 
        begin
         PrevChar := -1;
         SuccSpace := False;
        end;
        PrevSpace := (PrevChar = -1) OR (Char(PrevChar) in cc_OpenQuotePrev[l_OEM]);
        if (l_Processor <> nil) AND l_Processor.NeedReplaceQuotes then
         CheckQuotes(l_InsString, PrevSpace, l_OEM);
        with l_TextPara do
        begin
         if (IntA[k2_tiJustification] = Ord(ev_itPreformatted)) then 
         begin
          if (IntA[k2_tiStyle] = ev_saTxtNormalOEM) then 
          begin
           // - Здесь пытаемся нарезать псевдотаблицу на строки
           if (misfDraw in aFlags) AND
              l_OEM AND
              (not l_InsString.IsOEMEx OR
               not l3CharSetPresent(l_InsString.St, l_InsString.Len, cc_Graph_Criteria)) AND
               InsertIntoTable then 
           begin
            Result := True;
            Exit;
           end;//l_OEM..
           // - Здесь пытаемся нарезать псевдотаблицу на строки
          end; 
         end
         else 
         begin
          if PrevSpace then 
           l_InsString.LTrim;
          if SuccSpace then 
           l_InsString.RTrim;
          l_InsString.DeleteDoubleSpace;
         end;{IT <> ev_itPreformatted}
        end;{with l_TextPara} 
        if l_InsString.Empty then
        begin
         if SuccSpace then
          Move(aView, ev_ocCharRight, anOp);
         Exit;
        end;{l_InsString.Empty}
       end;//not (misfDirect in aFlags)
       DoInsert;
       //InsertMode
      end
      else
       Result := DoOverwrite;
     end;//not l_InsString.Empty
    finally
     l_Processor := nil;
    end;//try..finally
   finally
    FreeAndNil(l_InsString);
   end;//try..finally
  end;//l_Processor <> nil
 end;//not ReadOnly AND not l3IsNil(aString) AND (anOp <> nil)
//#UC END# *4A38F71601D6_49DF7D98029A_impl*
end;//TevTextParaCursor.DoInsertString

function TevTextParaCursor.DoDeleteString(const aView: InevView;
 aCount: Integer;
 const anOp: InevOp;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F748002D_49DF7D98029A_var*
var
 l_TextPara : InevTextPara;
 l_Pos      : Integer;
 Ctx        : IevCursorContext;

  function _ModifyCursor(C: PevTextParaCursor; Index: Integer): Boolean; far;
  var
   oPos : Integer;
   nPos : Integer;
  begin{_ModifyCursor}
   Result := True;
   oPos := C^.Position;

   if (oPos < l_Pos) then
    nPos := oPos
   else if (oPos < l_Pos + aCount) then
    nPos := l_Pos
   else
    nPos := oPos - aCount;

   if (nPos = oPos) then
    C^.Refresh
   else begin
    C^.SetEntryPoint(nPos, Ctx);
    C^.f_LineEnd := False;
   end;
  end;{_ModifyCursor}

var
 l_UndoString : Tl3String;
 
  function DoDelete: Boolean;
  begin//DoDelete
   if (misfLockSegments in aFlags) then
    Result := evDir_DeleteText(l_TextPara, l_Pos, aCount, l_UndoString.St)
   else
   begin
    CheckSegments(l_Pos, anOp);
    Result := evDir_DeleteText(l_TextPara, l_Pos, aCount, l_UndoString.St, anOp);
   end;//misfLockSegments in aFlags
  end;//DoDelete

  procedure SaveDeleted;
  begin//SaveDeleted
   if (misfLockSegments in aFlags) then
    OevDeleteString1.ToUndo(anOp, l_TextPara.AsObject, l_Pos, l_UndoString)
   else
    OevDeleteString.ToUndo(anOp, l_TextPara.AsObject, l_Pos, l_UndoString);
  end;//SaveDeleted

var
 l_Text      : Tl3CustomString;
 l_TextProcessor : IevTextOpProcessor;

  function DeleteInTable: Boolean;
  var
   l_RightBorder : Integer;
   l_SpacesCount : Integer;
   l_Spaces      : Tl3InterfacedString;
  begin//DeleteInTable
   Result := true;
   if (misfDraw in aFlags) AND l_Text.IsOEMEx then
    with l_TextPara do
    begin
     if (IntA[k2_tiStyle] = ev_saTxtNormalOEM) then
     begin
      l_RightBorder := l3CharSetPresentEx(l_Text.St + l_Pos, l_Text.Len - l_Pos, cc_Graph_Criteria);
      if (l_RightBorder <> -1) then 
      begin
       if (l_RightBorder > 0) then 
       begin
        l_SpacesCount := l3CharSetPresentExR(l_Text.St + l_Pos, Pred(l_RightBorder), cc_AllChars - [cc_HardSpace]);
        if (l_SpacesCount >= 0) AND DoDelete then 
        begin
         l_TextProcessor.TextOp(l_UndoString, l3_opDelete);
         SaveDeleted;
         try
          SetEntryPoint(l_Pos + Pred(l_RightBorder), anOp);
          l_Spaces := Tl3InterfacedString.Create;
          try
           l_Spaces.Append(cc_HardSpace, aCount);
           InsertString(aView, l_Spaces, anOp, true);
          finally
           FreeAndNil(l_Spaces);
          end;//try..finally
         finally
          SetEntryPoint(l_Pos, anOp);
         end;//try..finally
        end;//DoDelete
       end;//l_RightBorder > 0
       Exit;
      end;//l_RightBorder <> -1
     end;//IntA[k2_tiStyle] = ev_saTxtNormalOEM
    end;//with l_TextPara
   Result := false;
  end;//DeleteInTable

var
 l_Processor : InevProcessor;
//#UC END# *4A38F748002D_49DF7D98029A_var*
begin
//#UC START# *4A38F748002D_49DF7D98029A_impl*
 if ReadOnly then
  Result := False
 else
 begin
  Result := True;
  if (aCount > 0) then
  begin
   l_TextPara := ParaX;
   if evHasText(l_TextPara.AsObject) then
   begin
    if (anOp = nil) then
     Ctx := nil
    else
     anOp.QueryInterface(IevCursorContext, Ctx); 
    l_Pos := Position;
    if (anOp = nil) then
     evDir_DeleteText(l_TextPara, l_Pos, aCount)
    else 
    begin
     l_UndoString := Tl3String.Create;
     try
      l_Text := l_TextPara.AsObject.Attr[k2_tiText] As Tl3CustomString;
      l_UndoString.CodePage := l_Text.CodePage; 
      l_UndoString.Len := aCount;
      if (anOp = nil) then
       l_Processor := nil
      else
       l_Processor := anOp.Processor;
      //if (l_Processor <> nil) then
      //if l3IOk(Ctx.QueryInterface(InevProcessor, l_Processor)) then
       try
        if (l_Processor <> nil) then
        begin
         l_TextProcessor := (l_Processor As IevTextOpProcessor);
         l_TextProcessor.CheckTextOp(nil, l3_opDelete);
        end;//l_Processor <> nil
        if DeleteInTable then
         Exit
        else
        if DoDelete then
        begin
         if (l_TextProcessor <> nil) then
          l_TextProcessor.TextOp(l_UndoString, l3_opDelete);
        end//DoDelete
        else
         Exit;
       finally                                       
        l_Processor := nil;
       end;//try..finally
      SaveDeleted;
     finally
      FreeAndNil(l_UndoString);
     end;//try..finally
    end;//Ctx = nil
    if not (misfLockCursors in aFlags) then
     evIterateCursorsF(l_TextPara.AsObject, l3L2IA(@_ModifyCursor));
   end;//evHasText(l_TextPara)
  end;//aCount > 0
 end;//ReadOnly
//#UC END# *4A38F748002D_49DF7D98029A_impl*
end;//TevTextParaCursor.DoDeleteString

function TevTextParaCursor.DoSetAtom(const aView: InevView;
 anIndex: Cardinal;
 pSource: Tl3Variant;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7A40373_49DF7D98029A_var*
var
 l_Segments : Tl3Variant;
 l_TextPara : InevTextPara;

 function ApplyFont: Boolean;
   {* - сбрасывает параметры шрифта с текущих сегментов. }
 var
  l_Segment : Tl3Variant;
  l_Index   : Integer;
 begin//ApplyFont
  Result := false;
  if (anIndex = k2_tiFont) AND pSource.IsNull then
  begin
   if l_Segments.IsValid then
   begin
    l_Segment := evSegments_GetSegmentOnPos(l_Segments, ev_slView, Position, l_Index);
    if l_Segment.IsValid then
    begin
     Result := true;
     l_Segment.AttrW[anIndex, anOp] := nil;
     if not evSegmentHasSomeFormat(l_Segment.AsObject) then
      evSegments_DeleteSegment(l_TextPara, ev_slView, l_Index, anOp);
    end;//l_Segment.IsValid
    l_Segment := evSegments_GetSegmentOnPos(l_Segments, ev_slHyperlinks, Position, l_Index);
    if l_Segment.IsValid then
    begin
     Result := true;
     l_Segment.AttrW[anIndex, anOp] := nil;
     if not l_Segment.IsKindOf(k2_typHyperlink) AND
        not evSegmentHasSomeFormat(l_Segment.AsObject) then
      evSegments_DeleteSegment(l_TextPara, ev_slHyperlinks, l_Index, anOp);
    end;//l_Segment.IsValid
   end;//l_Segments.IsValid
  end;//anIndex = k2_tiFont
 end;//ApplyFont

 function _ParaParam: Boolean;
 begin//_ParaParam
  Result := (anIndex = k2_tiJustification) OR (anIndex = k2_tiBullet);
 end;//_ParaParam

var
 l_Index          : Integer;
 l_B              : TevPair;
 l_ApplyToSegment : Boolean;
 l_Text           : Tl3PCharLen;
//#UC END# *4A38F7A40373_49DF7D98029A_var*
begin
//#UC START# *4A38F7A40373_49DF7D98029A_impl*
 Result := true;
 l_TextPara := ParaX;
 with l_TextPara do
 begin
  l_Text := Text;
  l_Segments := Attr[k2_tiSegments];
  if not ApplyFont then
  begin
   if l_Segments.IsValid AND not _ParaParam AND not l3IsNil(l_Text) then
    l_ApplyToSegment := evSegments_CheckSegmentOnPos(l_Segments, ev_slView, Position, l_Index, l_B).IsValid
   else
   begin
    l_ApplyToSegment := false;
    l_B.rStart := 0;
    if l3IsNil(l_Text) then
     l_B.rFinish := 0
    else
     l_B.rFinish := l_Text.SLen;
   end;//l_Segments.IsValid
   if l_ApplyToSegment then
   begin
    if (l_B.rStart <= 0) AND
       (l3IsNil(l_Text) OR (l_B.rFinish >= l_Text.SLen)) AND
       (anIndex = k2_tiStyle) AND
       ((pSource.IsNull) OR
        pSource.BoolA[k2_tiApply2Para]) then
    begin
     evSegments_DeleteSegment(l_TextPara, ev_slView, l_Index, anOp);
     l_ApplyToSegment := false;
    end//l_B.rStart <= 0..
   end//l_ApplyToSegment
   else
    l_B.rFinish := Min(l_B.rFinish, GetBlockLength);
   if l_ApplyToSegment then
    evSegments_PaintSegment(l_TextPara,
                            l_Segments,
                            l_B,
                            anIndex, pSource,
                            anOp, false)
   else
   if (anIndex = k2_tiStyle) then
   begin
    if (pSource.IsNull) OR
       pSource.BoolA[k2_tiApply2Para] then
     evTextParaSetFontParam(l_TextPara, anIndex, pSource, anOp)
    else
     evSegments_PaintSegment(l_TextPara, cAtom(k2_tiSegments, anOp), l_B, anIndex, pSource, anOp, false);
   end//T = k2_tiStyle
   else
   begin
    if not l_Segments.IsValid OR
       not evSegments_GetLayer(l_Segments, ev_slView).IsValid OR
       _ParaParam then
     evTextParaSetFontParam(l_TextPara, anIndex, pSource, anOp)
    else
     evSegments_PaintSegment(l_TextPara, l_Segments, l_B, anIndex, pSource, anOp, false);
   end;//T = k2_tiStyle
  end;//not ApplyFont
 end;//with l_TextPara
 l_TextPara.Invalidate([]);
//#UC END# *4A38F7A40373_49DF7D98029A_impl*
end;//TevTextParaCursor.DoSetAtom

function TevTextParaCursor.DoDeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7F5022C_49DF7D98029A_var*
//#UC END# *4A38F7F5022C_49DF7D98029A_var*
begin
//#UC START# *4A38F7F5022C_49DF7D98029A_impl*
 if ReadOnly then
  Result := false
 else
  with ParaX.AsObject.Attr[k2_tiText] do
   if not IsValid OR ((AsObject As Tl3CustomString).Len <= Position) then
    Result := Self.pm_GetText.Modify.JoinWithNext(aView, anOp)
   else
   if aDrawLines then
    Result := Self.DeleteString(aView, 1, anOp, [misfDraw])
   else
    Result := Self.DeleteString(aView, 1, anOp);
//#UC END# *4A38F7F5022C_49DF7D98029A_impl*
end;//TevTextParaCursor.DoDeleteChar

function TevTextParaCursor.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_49DF7D98029A_var*
var
 ResultHL: TevHyperlink;

 function SegmentID(Seg: Tl3Variant; Index: Integer): Boolean;
 begin//SegmentID
  Result := true;
  if Seg.IsKindOf(k2_typHyperlink) then
  begin
   if (ResultHL.ID = 0) then
    ResultHL.Init(Seg.AsObject)
   else
   begin
    FreeAndNil(ResultHL);
    Result := false; { break }
   end;//ResultHL.ID = 0
  end;//Seg.IsKindOf(k2_typHyperlink)
 end;//SegmentID

var
 l_String : Il3WordsSeq;
 l_B      : TevPair;
//#UC END# *4A60B23E00C3_49DF7D98029A_var*
begin
//#UC START# *4A60B23E00C3_49DF7D98029A_impl*
 Result.SetOk;
 if IID.EQ(IevDrawLineTool) then
  IevDrawLineTool(Obj) := TevDrawLineTool.Make(Self)
 else
 if IID.EQ(IevHyperlink) then
 begin
  if QT(Il3WordsSeq, l_String) then
  try
   l_B.rStart := l_String.WordStart(Position);
   l_B.rFinish := l_String.WordFinish(Position);
   if l_B.Len > 0 then
   begin                                                         
    ResultHL := TevHyperlink.Create(Self, ParaX.AsObject);
    try
     evSegmentsLayer_IterateSegmentsF(ParaX.AsObject,
                                      ParaX.AsObject.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperLinks)]),
                                      Succ(l_B.rStart),
                                      l_B.rFinish,
                                      L2Mk2ChildrenIterateChildrenFAction(@SegmentID));

     if (ResultHL = nil) then
      Result := inherited COMQueryInterface(IID, Obj)
     else
      IevHyperlink(Obj) := ResultHL;
    finally
     FreeAndNil(ResultHL);
    end;//try..finally
   end//l_B.Len > 0
   else
    Result := inherited COMQueryInterface(IID, Obj);
  finally
    l_String := nil;
  end//QT(Il3WordsSeq, l_String)
  else
   Result := inherited COMQueryInterface(IID, Obj);
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_49DF7D98029A_impl*
end;//TevTextParaCursor.COMQueryInterface
{$IfEnd} // Defined(evUseVisibleCursors)

end.
