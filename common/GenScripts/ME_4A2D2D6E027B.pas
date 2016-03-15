unit evParaListCursorPair;
 {* Выделение для списка параграфов }

// Модуль: "w:\common\components\gui\Garant\Everest\evParaListCursorPair.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evCursorPair
 , nevTools
 , l3Variant
 , l3IID
 , l3Interfaces
 , l3Core
 , nevBase
 , k2Interfaces
;

type
 _nevParaListTool_Parent_ = TevCursorPair;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 TevParaListCursorPair = class(_nevParaListTool_)
  {* Выделение для списка параграфов }
  protected
   f_ChildStart: InevBasePoint;
   f_ChildFinish: InevBasePoint;
  protected
   function GetParaBlockBordersPrim(const aChildPara: InevPara;
    aPID: LongInt;
    out cParaStart: InevBasePoint;
    out cParaFinish: InevBasePoint): Boolean; virtual;
   procedure ArrangeFoundCursors(anIndex: LongInt;
    var theStart: InevBasePoint;
    var theFinish: InevBasePoint); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   function DoGetBlockLength: Integer; override;
   function DoGetStyle(Stop: PInteger): Tl3Variant; override;
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; override;
   function DoGetFont(const aView: InevView;
    aMap: TnevFormatInfoPrim;
    Stop: PInteger): InevFontPrim; override;
   function DoDeleteHyperlink(const anOpPack: InevOp): Boolean; override;
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
   function DoSetAtom(const aView: InevView;
    anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOp: InevOp): Boolean; override;
   function DoDeleteSegments(const anOpPack: InevOp): Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure DoStore(const aView: InevView;
    const G: Ik2TagGenerator;
    aFlags: TevStoreFlags); override;
   {$If Defined(evNeedEditableCursors)}
   function DoDelete(const aView: InevView;
    const anOpPack: InevOp = nil;
    aMode: TevClearMode = nevTools.ev_cmAll;
    const aPara: InevPara = nil): Boolean; override;
   {$IfEnd} // Defined(evNeedEditableCursors)
   function DoGetChildSel(const aView: InevView;
    aChildIndex: LongInt;
    aForDrawing: Boolean): InevRange; override;
   function SearchPrim(const aView: InevView;
    const aSearcher: IevSearcher;
    const Progress: Il3Progress;
    const aStart: InevBasePoint;
    out cFStart: InevBasePoint;
    out cFFinish: InevBasePoint): Boolean; override;
    {* ищет подстроку и возвращает найденную позицию в (cFStart, cFFinish) }
   function IsSolid(const aView: InevView): Boolean; override;
   function IsCollapsed(const aView: InevView): Boolean; override;
   function DoBottomChildBlock(const aView: InevView): InevRange; override;
   procedure GetBlockBorders; override;
  public
   procedure DoInit(const aStart: InevBasePoint;
    const aFinish: InevBasePoint;
    aSharp: Boolean); override;
 end;//TevParaListCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , SysUtils
 , Classes
 , l3MinMax
 , l3Base
 , nevFacade
 , k2Base
 , afwFacade
 , l3InterfacesMisc
 , k2Tags
 , nevNavigation
 , ParaList_Const
 , evdInterfaces
 , k2BaseTypes
 , evParaPackOperation
 , k2OpMisc
 , evdStyles
 , evOp
 , TextPara_Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , evCursorConst
 , evTypes
 , nevInterfaces
 , l3Const
 , evParaListCursorPrim
;

type _Instance_R_ = TevParaListCursorPair;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

function TevParaListCursorPair.GetParaBlockBordersPrim(const aChildPara: InevPara;
 aPID: LongInt;
 out cParaStart: InevBasePoint;
 out cParaFinish: InevBasePoint): Boolean;
//#UC START# *5108D4820232_4A2D2D6E027B_var*

 procedure CheckCursor(var theChildCursor : InevBasePoint);
 // Проверяет, что мир исказился (например вставили LeafParaDecorationsHolder),
 // а курсоры про это не узнали, ну и их структура поехала
 var
  l_PrevChild : InevBasePoint;

  procedure lp_SaveInner;
  var
   l_Inner: InevBasePoint;
   l_NewInner: InevBasePoint;
  begin
   l_Inner := theChildCursor;
   theChildCursor := aChildPara.MakePoint;
   l_NewInner := theChildCursor;
   while (l_Inner <> nil) and (l_NewInner <> nil) do
   begin
    l_NewInner.PositionW := l_Inner.Position;
    l_NewInner := l_NewInner.Inner;
    l_Inner := l_Inner.Inner;
   end; // while l_Inner <> nil do
  end;

 begin//CheckCursor
  if (theChildCursor <> nil) then
  begin
   if not theChildCursor.Obj.AsObject.Box.IsSame(aChildPara.AsObject) then
   // - наш дочерний курсор указывает не на тот параграф, который на самом деле
   //   является нашим ребёнком
   begin
    if not theChildCursor.Obj.AsObject.Owner.IsValid then
    // - параграф был удалён, например в результате Undo
    begin
     theChildCursor := aChildPara.MakePoint;
     // - создаём курсор на правильный параграф
     // !!! может быть надо будет создават ЦЕПОЧКУ параграфов, если параграф
     //     нелистьевой и мы опять на это наткнёмся.
    end//not theChildCursor.Obj.Owner.IsValid
    else
    begin
     l_PrevChild := theChildCursor;
     //Assert(theChildCursor.Position = 0);
     //Assert(theChildCursor.Inner = nil);
     if theChildCursor.Inner = nil then
     begin
      theChildCursor := aChildPara.MakePoint;
      if aChildPara.AsObject.IsSame(l_PrevChild.Obj.AsObject.Owner) then
      // - видимо появился контейнер типа LeafParaDecorationsHolder
       theChildCursor.Inner := l_PrevChild;
      // - иначе - скорее всего удаляли параграф l_PrevChild.Obj
     end
     else
      lp_SaveInner;
    end;//not theChildCursor.Obj.Box.IsSame(aChildPara)
   end;//not theChildCursor.Obj.Owner.IsValid
  end;//theChildCursor <> nil
 end;//CheckCursor
 
//#UC END# *5108D4820232_4A2D2D6E027B_var*
begin
//#UC START# *5108D4820232_4A2D2D6E027B_impl*
 Result := (f_B.rStart > 0) AND (aPID >= f_B.rStart) AND (aPID <= f_B.rFinish);
 if Result then
 begin
  if aChildPara.AsObject.IsValid then
  begin
   Assert(aChildPara.PID = Pred(aPID));
   if (aPID = f_B.rStart) then
    cParaStart := f_ChildStart
   else
    cParaStart := nil;
   if (aPID = f_B.rFinish) then
    cParaFinish := f_ChildFinish
   else
    cParaFinish := nil;
   CheckCursor(cParaStart);
   CheckCursor(cParaFinish);
   Assert((cParaStart = nil) OR cParaStart.Obj^.AsObject.Box.IsSame(aChildPara.AsObject));
   Assert((cParaFinish = nil) OR cParaFinish.Obj^.AsObject.Box.IsSame(aChildPara.AsObject));
  end//aChildPara.IsValid
  else
  begin
   Result := false;
   cParaStart := nil;
   cParaFinish := nil;
  end;//aChildPara.IsValid
 end//Result
 else
 begin
  cParaStart := nil;
  cParaFinish := nil;
 end;//InBlock
//#UC END# *5108D4820232_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.GetParaBlockBordersPrim

procedure TevParaListCursorPair.ArrangeFoundCursors(anIndex: LongInt;
 var theStart: InevBasePoint;
 var theFinish: InevBasePoint);
//#UC START# *52D80D430151_4A2D2D6E027B_var*
//#UC END# *52D80D430151_4A2D2D6E027B_var*
begin
//#UC START# *52D80D430151_4A2D2D6E027B_impl*
//#UC END# *52D80D430151_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.ArrangeFoundCursors

procedure TevParaListCursorPair.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A2D2D6E027B_var*
//#UC END# *479731C50290_4A2D2D6E027B_var*
begin
//#UC START# *479731C50290_4A2D2D6E027B_impl*
 f_ChildStart := nil;
 f_ChildFinish := nil;
 inherited;
//#UC END# *479731C50290_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.Cleanup

function TevParaListCursorPair.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_4A2D2D6E027B_var*

 function DoChild(const aTag: InevPara; anIndex: TnevParaIndex): Boolean;
 begin//DoChild
  Result := Action(aTag.AsObject, anIndex);
 end;//DoChild
 
//#UC END# *48CF96D80241_4A2D2D6E027B_var*
begin
//#UC START# *48CF96D80241_4A2D2D6E027B_impl*
 try
  Result := -1;
  if (f_B.Len >= 0) AND (f_B.rFinish > 0) then
  begin
   aLo := Max(aLo, Pred(f_B.rStart));
   aHi := Min(aHi, Pred(f_B.rFinish));
   Result := ParaX.IterateParaF(nevL2PIA(@DoChild), aLo, aHi, aLoadedOnly);
  end;//f_B.Len >= 0
 finally
  k2FreeTIA(Action);
 end;//try..finally
//#UC END# *48CF96D80241_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoIterateChildrenF

function TevParaListCursorPair.DoGetBlockLength: Integer;
//#UC START# *49E3662D028E_4A2D2D6E027B_var*
//#UC END# *49E3662D028E_4A2D2D6E027B_var*
begin
//#UC START# *49E3662D028E_4A2D2D6E027B_impl*
 Result := ParaX.ParaCount;
//#UC END# *49E3662D028E_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoGetBlockLength

function TevParaListCursorPair.DoGetStyle(Stop: PInteger): Tl3Variant;
//#UC START# *4A2945060101_4A2D2D6E027B_var*
{$IfDef evNeedGetBlockStyle}
var
 ResultStyle : Tl3Variant absolute Result;
 Ass         : Boolean;

 function AddChildStyle(const aChild: InevRange; anIndex: LongInt): Boolean;
 var
  St : Tl3Variant;
 begin//AddChildStyle
  Result := false;
  if (Stop <> nil) AND (Stop^ > 1) then Exit;
  if aChild = nil then Exit; //Заплатка!!!
  St := aChild.Formatting.GetStyle(Stop);
  if (Stop <> nil) AND (Stop^ > 1) then Exit;
  if (St = nil) OR St.IsNull then
  begin
   ResultStyle := k2NullTag;
   Exit;
  end//St = nil
  else
  if Ass then
  begin
   if not St.IsSame(ResultStyle) then
   begin
    ResultStyle := k2NullTag;
    Exit;
   end;//not St.IsSame(ResultStyle)
  end//Ass
  else
  begin
   ResultStyle := St;
   Ass := true;
  end;//Ass                       
  //if not afw.InOp then
  // afw.ProcessMessages;
  Result := true;
 end;//AddChildStyle
{$EndIf evNeedGetBlockStyle}
//#UC END# *4A2945060101_4A2D2D6E027B_var*
begin
//#UC START# *4A2945060101_4A2D2D6E027B_impl*
{$IfDef evNeedGetBlockStyle}
 Result := k2NullTag;
 Ass := false;
 DoIterateF(evL2TSA(@AddChildStyle));
{$else}
 Result := inherited DoGetStyle(Stop);
{$EndIf evNeedGetBlockStyle}
//#UC END# *4A2945060101_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoGetStyle

function TevParaListCursorPair.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_4A2D2D6E027B_var*
 function _DoChild(const aBlock: InevRange; aBlockIndex: LongInt): Boolean;
 begin
  Result := true;
  if aBlock.Formatting.Modify(aView).ChangeParam(aView, aMarker, aValue, anOp) then
   DoChangeParam := true;
 end;

var
 l_Progress: Il3Progress;
//#UC END# *4A29465701BC_4A2D2D6E027B_var*
begin
//#UC START# *4A29465701BC_4A2D2D6E027B_impl*
 Result := inherited DoChangeParam(aView, aMarker, aValue, anOp);
 if not Result then
 begin
  if (anOp = nil) then
   l_Progress := nil
  else
   anOp.QueryInterface(Il3Progress, l_Progress);
  try
   DoIterateF(evL2TSA(@_DoChild), l_Progress);
  finally
   l_Progress := nil;
  end;//try..finally
 end;//not Result
//#UC END# *4A29465701BC_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoChangeParam

function TevParaListCursorPair.DoGetFont(const aView: InevView;
 aMap: TnevFormatInfoPrim;
 Stop: PInteger): InevFontPrim;
//#UC START# *4A29477801BF_4A2D2D6E027B_var*
{$IfDef evNeedGetBlockFont}
var
 NF1 : InevFontPrim;
 pNF : ^InevFontPrim;
 Ass : Boolean;
 NF  : InevFontPrim absolute Result;

 function AddChildFont(const aChild: InevRange; anIndex: LongInt): Boolean;
 var
  l_ChildMap: TnevFormatInfoPrim;
 begin//AddChildFont
  Result := False;
  try
   if (Stop <> nil) AND (Stop^ > 1) then Exit;
   if aChild = nil then Exit; //Заплатка!!!
   l_ChildMap := aMap.InfoForChild(aChild.Obj^);
   if l_ChildMap = nil then Exit;
   pNF^ := aChild.Formatting.GetFont(aView, l_ChildMap, Stop);
   if (Stop <> nil) AND (Stop^ > 1) then Exit;
   if (NF <> nil) then
   begin
    if not Ass then
     pNF := @NF1
    else
    if NF.SubFont(pNF^) then
     Exit;
   end;//NF <> nil
   {$IFNDEF Archi}
   if not afw.InOp then
    afw.ProcessMessages;
   {$ENDIF Archi}
  finally
   if Ass then
    NF1 := nil
   else
   if (NF <> nil) then
    Ass := true;
  end;//try..finally
  Result := true;
 end;//AddChildFont
{$EndIf evNeedGetBlockFont}
//#UC END# *4A29477801BF_4A2D2D6E027B_var*
begin
//#UC START# *4A29477801BF_4A2D2D6E027B_impl*
{$IfDef evNeedGetBlockFont}
 Ass := false;
 pNF := @Result;
 DoIterateF(evL2TSA(@AddChildFont));
{$else}
 inherited;
{$EndIf evNeedGetBlockFont}
//#UC END# *4A29477801BF_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoGetFont

function TevParaListCursorPair.DoDeleteHyperlink(const anOpPack: InevOp): Boolean;
//#UC START# *4A38F52201BA_4A2D2D6E027B_var*
 function _DoChild(const aBlock: InevRange; aBlockIndex: LongInt): Boolean;
 begin
  Result := true;
  if aBlock.Formatting.Modify(nil).DeleteHyperlink(anOpPack) then
  begin
   DoDeleteHyperlink := true;
   if anOpPack <> nil then
    anOpPack.MarkModified(aBlock.Obj^.AsObject);
  end;
 end;

var
 l_Progress: Il3Progress;
//#UC END# *4A38F52201BA_4A2D2D6E027B_var*
begin
//#UC START# *4A38F52201BA_4A2D2D6E027B_impl*
 Result := false;
 if (anOpPack = nil) then
  l_Progress := nil
 else
  anOpPack.QueryInterface(Il3Progress, l_Progress);
 try
  DoIterateF(evL2TSA(@_DoChild), l_Progress);
 finally
  l_Progress := nil;
 end;//try..finally
//#UC END# *4A38F52201BA_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoDeleteHyperlink

function TevParaListCursorPair.DoAddIndentMarker(const aView: InevView;
 aValue: Integer;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F69F0070_4A2D2D6E027B_var*
 function _DoChild(const aBlock: InevRange; aBlockIndex: LongInt): Boolean;
 begin
  Result := True;
  if aBlock.Formatting.Modify(aView).AddIndentMarker(aView, aValue, anOpPack) then
   DoAddIndentMarker := True;
 end;

var
 l_Progress: Il3Progress;
//#UC END# *4A38F69F0070_4A2D2D6E027B_var*
begin
//#UC START# *4A38F69F0070_4A2D2D6E027B_impl*
 Result := inherited DoAddIndentMarker(aView, aValue, anOpPack);
 if not Result then
 begin
  if (anOpPack = nil) then
   l_Progress := nil
  else
   anOpPack.QueryInterface(Il3Progress, l_Progress);
  try
   DoIterateF(evL2TSA(@_DoChild), l_Progress);
  finally
   l_Progress := nil;
  end;//try..finally
 end;//not Result
//#UC END# *4A38F69F0070_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoAddIndentMarker

function TevParaListCursorPair.DoDeleteIndentMarker(const aView: InevView;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F6CB003C_4A2D2D6E027B_var*
 function _DoChild(const aBlock: InevRange; aBlockIndex: LongInt): Boolean;
 begin
  Result := True;
  if aBlock.Formatting.Modify(aView).DeleteIndentMarker(aView, anOpPack) then
   DoDeleteIndentMarker := True;
 end;

var
 l_Progress: Il3Progress;
//#UC END# *4A38F6CB003C_4A2D2D6E027B_var*
begin
//#UC START# *4A38F6CB003C_4A2D2D6E027B_impl*
 Result := inherited DoDeleteIndentMarker(aView, anOpPack);
 if not Result then
 begin
  if (anOpPack = nil) then
   l_Progress := nil
  else
   anOpPack.QueryInterface(Il3Progress, l_Progress);
  try
   DoIterateF(evL2TSA(@_DoChild), l_Progress);
  finally
   l_Progress := nil;
  end;//try..finally
 end;//not Result
//#UC END# *4A38F6CB003C_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoDeleteIndentMarker

function TevParaListCursorPair.DoInsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp;
 InsertMode: Boolean;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F71601D6_4A2D2D6E027B_var*
var
 l_R : InevRange;  
//#UC END# *4A38F71601D6_4A2D2D6E027B_var*
begin
//#UC START# *4A38F71601D6_4A2D2D6E027B_impl*
 l_R := BottomChildBlock(aView);
 if (l_R <> nil) AND not l3IEQ(l_R, Self) then
                 //  ^ - это защита от бесконечной рекурсии 
  Result := l_R.Text.Modify.InsertString(aView, aString, anOp, InsertMode, aFlags)
 else
  Result := inherited DoInsertString(aView, aString, anOp, InsertMode, aFlags);
//#UC END# *4A38F71601D6_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoInsertString

function TevParaListCursorPair.DoSetAtom(const aView: InevView;
 anIndex: Cardinal;
 pSource: Tl3Variant;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7A40373_4A2D2D6E027B_var*

 function _DoChild(const aBlock: InevRange; aBlockIndex: LongInt): Boolean;
 var
  l_F : InevDataFormattingModify;
 begin//_DoChild
  Result := true;
  l_F := aBlock.Formatting.Modify(aView);
  if (l_F <> nil) AND l_F.SetAtom(aView, anIndex, pSource, anOp) then
   DoSetAtom := true;
 end;//_DoChild

var
 l_Progress: Il3Progress;
//#UC END# *4A38F7A40373_4A2D2D6E027B_var*
begin
//#UC START# *4A38F7A40373_4A2D2D6E027B_impl*
 Result := false;
 if (anOp = nil) then
  l_Progress := nil
 else
  anOp.QueryInterface(Il3Progress, l_Progress);
 try
  if (anIndex = k2_tiStyle) then
   DoIterateBackF(evL2TSA(@_DoChild), l_Progress)
  else
   DoIterateF(evL2TSA(@_DoChild), l_Progress);
 finally
  l_Progress := nil;
 end;//try..finally
//#UC END# *4A38F7A40373_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoSetAtom

function TevParaListCursorPair.DoDeleteSegments(const anOpPack: InevOp): Boolean;
//#UC START# *4A3A8F8800AD_4A2D2D6E027B_var*
 function _DoChild(const aBlock: InevRange; aBlockIndex: LongInt): Boolean;
 begin//_DoChild
  Result := true;
  if aBlock.Formatting.Modify(nil).DeleteSegments(anOpPack) then
   DoDeleteSegments := true;
 end;//_DoChild
//#UC END# *4A3A8F8800AD_4A2D2D6E027B_var*
begin
//#UC START# *4A3A8F8800AD_4A2D2D6E027B_impl*
 Result := false;
 DoIterateF(evL2TSA(@_DoChild));
//#UC END# *4A3A8F8800AD_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoDeleteSegments

function TevParaListCursorPair.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4A2D2D6E027B_var*
//#UC END# *4A60B23E00C3_4A2D2D6E027B_var*
begin
//#UC START# *4A60B23E00C3_4A2D2D6E027B_impl*
 if IID.EQ(IevHyperlink) AND (f_B.rStart = f_B.rFinish) then
 begin
  if Supports(DoGetChildSel(nil, Pred(f_B.rStart), False), IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end 
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.COMQueryInterface

procedure TevParaListCursorPair.DoInit(const aStart: InevBasePoint;
 const aFinish: InevBasePoint;
 aSharp: Boolean);
//#UC START# *5108D53B0312_4A2D2D6E027B_var*
//#UC END# *5108D53B0312_4A2D2D6E027B_var*
begin
//#UC START# *5108D53B0312_4A2D2D6E027B_impl*
 inherited;
 if (f_Start = nil) then
  f_ChildStart := nil
 else
 if not f_Start.HasInner then
  f_ChildStart := nil
 else
  f_ChildStart := f_Start.Inner;
 if (f_Finish = nil) then
  f_ChildFinish := nil
 else
 if not f_Finish.HasInner then
  f_ChildFinish :=  nil
 else
  f_ChildFinish := f_Finish.Inner;
//#UC END# *5108D53B0312_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoInit

procedure TevParaListCursorPair.DoStore(const aView: InevView;
 const G: Ik2TagGenerator;
 aFlags: TevStoreFlags);
//#UC START# *5108D5CB0048_4A2D2D6E027B_var*
var
 l_ChildProp : Tk2ArrayProperty;
 l_Tag       : Tl3Variant;
 l_WasOut    : Boolean;
 l_Last      : LongInt;

 function StoreChild(aChild: Tl3Variant; Index: LongInt): Boolean; 
 var
  l_Block : InevRange;
  l_B     : TevPair;
 begin
  Result := True;
  if l_ChildProp.GetStoredChild(l_Tag, aChild, G.Context) then
  begin
   l_Block := DoGetChildSel(aView, Index, False);
   try
    if l_WasOut {AND not StoreParaEnd} AND (Index = l_Last) AND
       not aChild.IsKindOf(k2_typParaList) AND
       not l_Block.ContainsEnd(aView) then
    begin
     l_B := l_Block.Borders;
     if (l_B.rStart = l_B.rFinish) then
      Exit;
    end;//l_WasOut
    if l_Block <> nil then
     l_Block.AsStorable.Store(aView, G, aFlags - [evd_sfChildrenOnly]);
    l_WasOut := True;
   finally
    l_Block := nil;
   end;//try..finally
  end;//l_ChildProp.GetStored(..
 end;
//#UC END# *5108D5CB0048_4A2D2D6E027B_var*
begin
//#UC START# *5108D5CB0048_4A2D2D6E027B_impl*
 l_Tag := GetRedirect;
 if l_Tag.IsValid then
 begin
  if Solid(aView) then
  begin
   aFlags := aFlags - [evd_sfStoreParaEnd];
   if not (evd_sfChildrenOnly in aFlags) then
   begin
    G.StartChild(l_Tag.TagType);
    try
     l_Tag.AsObject.WriteTag(G, l3_spfAll);
    finally
     G.Finish;
    end;//try..finally
    Exit;
   end;//not ChildrenOnly
  end;//Solid
  l_WasOut := false;
  l_Last := Pred(f_B.rFinish);
  l_ChildProp := Tk2Type(l_Tag.TagType).ArrayProp[k2_tiChildren];
  if (evd_sfChildrenOnly in aFlags) then
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@StoreChild))
  else
  begin
   G.StartChild(l_Tag.TagType);
   try
    l_Tag.AsObject.WriteTag(G, l3_spfAll - [l3_spfChildren]);
    Self.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@StoreChild));
   finally
    G.Finish;
   end;//try..finally
  end;//(evd_sfChildrenOnly in aFlags)
 end;//l_Tag.IsValid
//#UC END# *5108D5CB0048_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoStore

{$If Defined(evNeedEditableCursors)}
function TevParaListCursorPair.DoDelete(const aView: InevView;
 const anOpPack: InevOp = nil;
 aMode: TevClearMode = nevTools.ev_cmAll;
 const aPara: InevPara = nil): Boolean;
//#UC START# *5108D66900C9_4A2D2D6E027B_var*
 procedure DeleteParasInRange(const aParaList : InevParaList;
                              aStart, aFinish : LongInt);
 var
  l_Op       : Ok2DeleteChildren;
  l_Deleted  : Il3TagRef;
  l_Index    : LongInt;
  l_DelIndex : Integer;
  l_SaveUndo : Boolean;
  l_PL       : InevParaListModify;
 begin//DeleteParasInRange
  l_Op := Ok2DeleteChildren.Create;
  try
   l_Op.SetParam(aParaList.AsObject, Tk2Type(aParaList.AsObject.TagType).ArrayProp[k2_tiChildren], Pred(aStart));
   l_DelIndex := Pred(aStart);
   if (anOpPack <> nil) then
   begin
    l_SaveUndo := anOpPack.SaveUndo;
    anOpPack.SaveUndo := false;
   end//anOpPack <> nil
   else
    l_SaveUndo := false;
   try
    l_PL := aParaList.Modify;
    l_Deleted := nil;
    for l_Index := aStart to aFinish do
    begin
     if l_PL.AsObject.DeleteChild(l_DelIndex, anOpPack, l_Deleted) then
      try
       l_Op.Deleted.Add(l_Deleted.AsObject);
      finally
       l_Deleted := nil;
      end//try..finally
     else
      Inc(l_DelIndex);
    end;//for l_Index..
   finally
    if (anOpPack <> nil) then
     anOpPack.SaveUndo := l_SaveUndo;
   end;//try..finally
   if (anOpPack <> nil) AND not l_Op.Deleted.Empty then
   begin
    anOpPack.MarkModified(ParaX.AsObject);
    l_Op.Put(anOpPack);
   end;
  finally
   l3Free(l_Op);
  end;//try..finally
  aParaList.Invalidate([]); 
 end;//DeleteParasInRange

 function DeleteAll: Boolean;

  function _SetCursorToParaListTop(C: PevParaListCursor; Index: LongInt): Boolean; far;
  begin//_SetCursorToParaListTop
   Result := true;
   C^.Move(aView, ev_ocTopLeft, anOpPack);
  end;//_SetCursorToParaListTop

 var
  l_ParaList  : InevParaList;
  l_PrevStyle : LongInt;
  l_ParaCount : LongInt;
  l_Start     : LongInt;
  l_Child     : InevPara;
 begin//DeleteAll
  Result := false;
  if Solid(aView) AND (aMode in [ev_cmKeepOne, ev_cmForceKeepOne]) then
  begin
   if QT(InevParaList, l_ParaList, k2Proc(anOpPack)) then
    try
     Result := true;
     l_ParaCount := l_ParaList.ParaCount;
     if (l_ParaCount > 0) then
     begin
      l_Start := f_B.rStart;
      l_PrevStyle := ev_saTxtNormalANSI;
      l_Child := l_ParaList.Para[0];
      with l_Child do
       if IsKindOf(k2_typTextPara) then
       begin
        if (l_ParaCount = 1) AND
           not evHasText(l_Child.AsObject) then
         Exit;
         // - параграф один и он пустой - ничего удалять не надо
        l_Child.Range.Modify.Delete(aView, anOpPack, ev_cmKeepOne);
        if (l_ParaCount = 1) then
         Exit;
        Inc(l_Start);
        l_PrevStyle := IntA[k2_tiStyle];
       end//IsKindOf(k2_typTextPara)
       else
       if (l_ParaCount > 1) then
        with l_ParaList.Para[Pred(l_ParaCount)] do
         if IsKindOf(k2_typTextPara) then
          l_PrevStyle := IntA[k2_tiStyle];
      DeleteParasInRange(l_ParaList, l_Start, f_B.rFinish);
      if (l_Start = f_B.rStart) then
      begin
       l_ParaList.Modify.InsertDefaultPara(nev_piFirst, anOpPack);
       if (l_PrevStyle <> ev_saTxtNormalANSI) then
        l_ParaList.Para[0].AsObject.IntA[k2_tiStyle] := l_PrevStyle;
      end;//l_Start = f_B.rStart
      evIterateCursorsF(l_ParaList.AsObject, l3L2IA(@_SetCursorToParaListTop));
     end;//l_ParaCount > 0
    finally
     l_ParaList := nil;
    end;//try..finally
  end;//Solid..
 end;//DeleteAll

var
 l_Start  : LongInt;
 l_Finish : LongInt;

 procedure DeleteInnerParas;

  function _ModifyCursorOnParaForDelete(PLC: PevParaListCursor; Index: LongInt): Boolean; far;
  var
   l_Pos : LongInt;
  begin//_ModifyCursorOnParaForDelete
   Result := true;
   l_Pos := PLC^.Position;
   if (l_Pos >= l_Start) AND (l_Pos <= l_Finish) then
   begin
    (* - курсор стоит на удаляемом параграфе - надо что-то делать,
         а то куда же ему потом показывать *)
    PLC^.SetEntryPoint(l_Finish, anOpPack);
    if aMode = ev_cmVertMergeCells then
     PLC^.ChangePointByPara(aView, anOpPack, aPara)
    else 
    if not PLC^.Move(aView, ev_ocNextParaTopLeft, anOpPack) then
    begin
     // не смогли сместиться на следующий параграф
     PLC^.SetEntryPoint(l_Start, anOpPack);
     // - в начало удаляемого блока
     if not PLC^.Move(aView, ev_ocPrevParaBottomRight, anOpPack) then
      // - не смогли сместиться на предыдущий параграф
      PLC^.SetEntryPoint(ev_cpNull, anOpPack);
      // - надо что то делать !!!
    end;
   end;//l_Pos >= l_Start
  end;//_ModifyCursorOnParaForDelete

  function _ModifyCursor(C: PevParaListCursor; Index: LongInt): Boolean; far;
  begin//_ModifyCursor
   Result := true;
   if (C^.Position > l_Finish) then
    C^.OffsetPID(-Succ(l_Finish - l_Start), anOpPack);
  end;//_ModifyCursor

 begin//DeleteInnerParas
  if (l_Start <= l_Finish) then
  begin
   evIterateCursorsF(ParaX.AsObject, l3L2IA(@_ModifyCursorOnParaForDelete));
   DeleteParasInRange(ParaX, l_Start, l_Finish);
   evIterateCursorsF(ParaX.AsObject, l3L2IA(@_ModifyCursor));
  end;//l_Start <= l_Finish
 end;//DeleteInnerParas

 procedure InitIndexes;
 var
  l_Sel : InevRange;
 begin//InitIndexes
  l_Start := f_B.rStart;
  if (aMode in [ev_cmAll, ev_cmVertMergeCells]) then
  begin
   if not DoGetChildSel(aView, Pred(l_Start), False).Solid(aView) then
    Inc(l_Start);
  end//aMode = ev_cmAll
  else
   Inc(l_Start);
  l_Finish := f_B.rFinish;
  if (f_B.Len > 0) then
  begin
   if (aMode in [ev_cmAll, ev_cmVertMergeCells]) then
   begin
    l_Sel := DoGetChildSel(aView, Pred(l_Finish), False);
    if (l_Sel <> nil) AND not l_Sel.Solid(aView) then
     Dec(l_Finish);
   end//aMode = ev_cmAll
   else
    Dec(l_Finish);
  end;//f_B.Len > 0
 end;//InitIndexes

var
 l_NeedJoin : Boolean;
 
 procedure DeleteFirstParaTail;
 var
  l_Range: InevRange;
 begin//DeleteFirstParaTail
  if (l_Start > f_B.rStart) then
  begin
   l_NeedJoin := true;
   l_Range := DoGetChildSel(aView, Pred(f_B.rStart), False);
   try
    if l_Range <> nil then
     l_Range.Modify.Delete(aView, anOpPack, aMode);
   finally
    l_Range := nil;
   end;
  end//l_Start > f_B.rStart
  else
   l_NeedJoin := false;
 end;//DeleteFirstParaTail

 procedure DeleteLastParaHead;
 var
  OBF : LongInt;
 begin//DeleteLastParaHead
  OBF := f_B.rFinish;
  Dec(f_B.rFinish, Succ(l_Finish - l_Start));
  if (l_Finish < OBF) then
  begin
   if (f_Start <> nil) then
   begin
    // - какая-то корректировка, а зачем - я не помню.. надо разбираться
    f_Start.SetEntryPoint(f_B.rStart, anOpPack);
    if f_Start.HasInner then
    begin
     if (l_Start > f_B.rStart) then
      f_Start.Inner.Move(aView, ev_ocBottomRight, anOpPack)
     else
      f_Start.Inner.Move(aView, ev_ocTopLeft, anOpPack);
    end;//f_Start.ChildCursor <> nil
   end;//f_Start <> nil
   Init(f_Start, f_Finish);
   if not DoGetChildSel(aView, Pred(f_B.rFinish), False).Modify.Delete(aView, anOpPack, aMode, aPara) then
   begin
    evDeletePara(anOpPack, f_Finish, [ev_dpfInternal]);
    l_NeedJoin := false;
   end;//not l_ChildBlock..
  end//l_Finish < OBF
  else
   l_NeedJoin := false;
 end;//DeleteLastParaHead

 procedure JoinFirstAndLast;

  function lp_IsEmptyInner(const anInner: InevBasePoint): Boolean;

   function lp_CheckEmty(const aTag: InevPara; anIndex: TnevParaIndex): Boolean;
   begin
    Result := not aTag.IsEmpty;
    if not Result then
     lp_IsEmptyInner := Result;
   end;

  begin
   Result := anInner.Obj.IsEmpty;
   if not Result then
   begin
    Result := True;
    if anInner.Obj^.IsList then
     anInner.Obj^.AsPara.AsList.IterateParaF(nevL2PIA(@lp_CheckEmty))
    else
     Result := anInner.Obj^.IsEmpty; 
   end; // if not Result then
  end;

 var
  l_StartCursor : InevPoint;
  l_Point       : InevBasePoint;
 begin//JoinFirstAndLast
  if (aMode = ev_cmEmpty) or (aMode = ev_cmEmpty4BlockResize) then
  begin
   l_StartCursor := ParaX.MakePoint;
   try
    l_StartCursor.PositionW := f_B.rStart;
    l_StartCursor.ShowCollapsed := True;
    if l_StartCursor.Inner.Obj.IsEmpty then
    begin
     evDeletePara(anOpPack, l_StartCursor, [ev_dpfInternal]);  
     if l_NeedJoin then
     begin
      l_StartCursor.PositionW := f_B.rStart;
      if lp_IsEmptyInner(l_StartCursor.Inner) then
       evDeletePara(anOpPack, l_StartCursor, [ev_dpfInternal]);
     end;//l_NeedJoin
     l_NeedJoin := false; // - по любому уже ничего не надо объединять
    end;//evEmpty(l_StartCursor.Inner.Target)
    if l_NeedJoin then
     l_StartCursor.Text.Modify.JoinWithNext(aView, anOpPack);
   finally
    l_StartCursor := nil;
   end;//try..finally
  end//aMode = ev_cmEmpty
  else
  if l_NeedJoin then
  begin
   l_Point := f_Start;
   try
    if (l_Point = nil) then
    begin
     l_Point := ParaX.MakePoint;
     l_Point.Move(aView, ev_ocTopLeft);
    end;//l_Point = nil
    l_Point.Text.Modify.JoinWithNext(aView, anOpPack);
   finally
    l_StartCursor := nil;
   end;//try..finally
  end;//aMode = ev_cmEmpty
 end;//JoinFirstAndLast
//#UC END# *5108D66900C9_4A2D2D6E027B_var*
begin
//#UC START# *5108D66900C9_4A2D2D6E027B_impl*
 if (f_B.Len >= 0) then
 begin
  // - есть что удалять
  if not DeleteAll then                     
  begin
   InitIndexes;
   DeleteInnerParas;
   DeleteFirstParaTail;
   DeleteLastParaHead;
   JoinFirstAndLast;
  end;//not DeleteAll
 end;//f_B.Len >= 0
 Result := true;
//#UC END# *5108D66900C9_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoDelete
{$IfEnd} // Defined(evNeedEditableCursors)

function TevParaListCursorPair.DoGetChildSel(const aView: InevView;
 aChildIndex: LongInt;
 aForDrawing: Boolean): InevRange;
//#UC START# *52D79DFC0347_4A2D2D6E027B_var*
var
 cParaStart  : InevBasePoint;
 cParaFinish : InevBasePoint;
 l_Para      : InevPara;
//#UC END# *52D79DFC0347_4A2D2D6E027B_var*
begin
//#UC START# *52D79DFC0347_4A2D2D6E027B_impl*
 if (aChildIndex < 0) then
 begin
  Result := nil;
  Exit;
 end;//aChildIndex < 0
 try
  if (aChildIndex >= ParaX.ParaCount) then
  begin
   Result := nil;
   Exit;
  end//aChildIndex >= ParaX.ChildrenCount
  else
   l_Para := ParaX[aChildIndex];
 except                        
  on EListError do
  begin
   Result := nil;
   Exit;
  end;//on EListError
 end;//try..except
 if GetParaBlockBordersPrim(l_Para, Succ(aChildIndex), cParaStart, cParaFinish) then
  try
   Result := l_Para.Range(cParaStart, cParaFinish, Sharp);
  finally
   cParaStart := nil;
   cParaFinish := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *52D79DFC0347_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoGetChildSel

function TevParaListCursorPair.SearchPrim(const aView: InevView;
 const aSearcher: IevSearcher;
 const Progress: Il3Progress;
 const aStart: InevBasePoint;
 out cFStart: InevBasePoint;
 out cFFinish: InevBasePoint): Boolean;
 {* ищет подстроку и возвращает найденную позицию в (cFStart, cFFinish) }
//#UC START# *52D79F3B0081_4A2D2D6E027B_var*
var
 l_ChildStart : InevBasePoint;

 function ChildSearch(const aChildBlock: InevRange; anIndex: LongInt): Boolean; far;
 var
  l_thisChildStart : InevBasePoint;
 begin//ChildSearch
  Inc(anIndex);
  if (l_ChildStart <> nil) AND
     l_ChildStart.Obj.AsObject.IsSame(aChildBlock.Obj^.AsObject) then
   l_thisChildStart := l_ChildStart
  else
   l_thisChildStart := nil;
  if (aChildBlock <> nil) and
     aChildBlock.Search(aView,
                        aSearcher,
                        Progress,
                        l_thisChildStart,
                        cFStart,
                        cFFinish) then
  begin
   SearchPrim := true;
   Result := false;
   ArrangeFoundCursors(anIndex, cFStart, cFFinish);
  end//aChildBlock.Search
  else
   Result := true;
 end;//ChildSearch

 function ChildFunc(Child: Tl3Variant; Index: LongInt): Boolean;
 begin//ChildFunc
  Result := ChildSearch(DoGetChildSel(aView, Index, False), Index);
 end;//ChildFunc

var
 l_BS                : LongInt;
 l_PrevShowCollapsed : Boolean;
 l_B                 : Integer;
 l_Back              : Boolean;
//#UC END# *52D79F3B0081_4A2D2D6E027B_var*
begin
//#UC START# *52D79F3B0081_4A2D2D6E027B_impl*
 l_PrevShowCollapsed := false;
 Result := false;
 l_Back := (ev_soBackward in aSearcher.Options);
 if l_Back then
  l_B := f_B.rFinish
 else
  l_B := f_B.rStart;
 if (aStart <> nil) AND aStart.Obj.AsObject.IsSame(GetRedirect) then
 begin
  if l_Back then
   l_BS := Min(l_B, aStart.Position)
  else
   l_BS := Max(l_B, aStart.Position);
  if not aStart.HasInner then
   l_ChildStart := nil
  else
   l_ChildStart := aStart.Inner;
  if (l_ChildStart <> nil) then
  begin
   l_PrevShowCollapsed := l_ChildStart.ShowCollapsed;
   l_ChildStart.ShowCollapsed := true;
  end;//(l_ChildStart <> nil)
 end//aStart <> nil..
 else
 begin
  l_BS := l_B;
  l_ChildStart := nil;
 end;//aStart <> nil..
 if l_Back then
  IterateChildrenBackF(L2Mk2ChildrenIterateChildrenFAction(@ChildFunc), Max(0, Pred(l_BS)))
 else
  DoIterateF(evL2TSA(@ChildSearch), Progress, str_nevmmSearch.AsCStr,
           Max(0, Pred(l_BS)));
 if (l_ChildStart <> nil) then
  l_ChildStart.ShowCollapsed := l_PrevShowCollapsed;
//#UC END# *52D79F3B0081_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.SearchPrim

function TevParaListCursorPair.IsSolid(const aView: InevView): Boolean;
//#UC START# *52D79F9400EB_4A2D2D6E027B_var*
var
 l_StartCursor  : InevBasePoint;
 l_FinishCursor : InevBasePoint;
 l_BlockLenght  : LongInt;
 l_Range: InevRange;
//#UC END# *52D79F9400EB_4A2D2D6E027B_var*
begin
//#UC START# *52D79F9400EB_4A2D2D6E027B_impl*
 l_BlockLenght := DoGetBlockLength;
 if (l_BlockLenght = 0) then
  Result := True
 else
 if (f_B.rStart <= 1) AND (f_B.rFinish >= l_BlockLenght) then
 begin
  GetBorderPoints(l_StartCursor, l_FinishCursor);
  if (l_StartCursor = nil) then
   Result := True
  else
  begin
   if (l_StartCursor.Position <= 0) then
   // - Начальный курсор стоит ПЕРЕД первым параграфом
    Result := True
   else
   begin
    l_Range := DoGetChildSel(aView, l_StartCursor.Position - 1, False); 
    if l_Range <> nil then
     Result := l_Range.Solid(aView)        
    else 
     Result := False;
   end; 
  end;//l_StartCursor = nil
  if Result then
  begin
   if (l_FinishCursor = nil) then
    Result := True
   else
   begin
    if (l_FinishCursor.Position <= 0) then
    // - Конечный курсор стоит ПЕРЕД первым параграфом
     Result := False
    else
    begin
     if (l_FinishCursor.Position > l_BlockLenght) then
     // - Конечный курсор стоит ПОСЛЕ последнего параграфа
      Result := True
     else
      begin
       l_Range := DoGetChildSel(aView, l_FinishCursor.Position - 1, False); 
       if l_Range <> nil then
        Result := l_Range.Solid(aView)        
       else 
        Result := False;
      end; 
    end;//l_FinishCursor.Position <= 0
   end;//l_FinishCursor = nil
  end;//Result
 end//(f_B.rStart <= 1) AND (f_B.rFinish >= l_BlockLenght)
 else
  Result := false;
//#UC END# *52D79F9400EB_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.IsSolid

function TevParaListCursorPair.IsCollapsed(const aView: InevView): Boolean;
//#UC START# *52D79FB703C9_4A2D2D6E027B_var*
var
 l_B   : TevPair;
 l_Sel : InevRange;
//#UC END# *52D79FB703C9_4A2D2D6E027B_var*
begin
//#UC START# *52D79FB703C9_4A2D2D6E027B_impl*
 l_B := Borders;
 if (l_B.rStart = l_B.rFinish) then
 begin
  // - спускаемся на уровень вниз
  l_Sel := DoGetChildSel(aView, Pred(l_B.rStart), False);
  if (l_Sel = nil) then
   Result := true
  else
   Result := l_Sel.Collapsed(aView)
 end//l_B.rStart = l_B.rFinish
 else
  Result := inherited IsCollapsed(aView);
//#UC END# *52D79FB703C9_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.IsCollapsed

function TevParaListCursorPair.DoBottomChildBlock(const aView: InevView): InevRange;
//#UC START# *52D7A3F100E0_4A2D2D6E027B_var*
var
 l_B    : TevPair;
 l_Range: InevRange;
//#UC END# *52D7A3F100E0_4A2D2D6E027B_var*
begin
//#UC START# *52D7A3F100E0_4A2D2D6E027B_impl*
 l_B := Borders;
 if (l_B.rStart = l_B.rFinish) then
 begin
  // - спускаемся на уровень вниз
  l_Range := DoGetChildSel(aView, Pred(l_B.rStart), False);
  if l_Range <> nil then
   Result := l_Range.BottomChildBlock(aView);
 end // if (l_B.rStart = l_B.rFinish) then
 else
  Result := inherited DoBottomChildBlock(aView);
  // - мы и есть блок самого нижнего уровня
//#UC END# *52D7A3F100E0_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.DoBottomChildBlock

procedure TevParaListCursorPair.GetBlockBorders;
//#UC START# *52D7FCD700CF_4A2D2D6E027B_var*
//#UC END# *52D7FCD700CF_4A2D2D6E027B_var*
begin
//#UC START# *52D7FCD700CF_4A2D2D6E027B_impl*
 if (f_Start = nil) then
  f_B.rStart := 1
 else
  f_B.rStart := f_Start.Position;
 if (f_Finish = nil) then
  f_B.rFinish := l3NilLong
 else
  f_B.rFinish := f_Finish.Position;
//#UC END# *52D7FCD700CF_4A2D2D6E027B_impl*
end;//TevParaListCursorPair.GetBlockBorders
{$IfEnd} // Defined(evUseVisibleCursors)

end.
