unit evCursorPair;
 {* Базовый класс для реализации выделения }

// Модуль: "w:\common\components\gui\Garant\Everest\evCursorPair.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evSelection
 , nevTools
 , l3IID
 , nevBase
 , l3Interfaces
 , k2ToolPrim
;

type
 TevCursorPair = class(TevRange)
  {* Базовый класс для реализации выделения }
  protected
   f_Start: InevBasePoint;
   f_Finish: InevBasePoint;
   f_B: TevPair;
  protected
   procedure GetBlockBorders; virtual;
   function IsSolid(const aView: InevView): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoDeleteCharToLeft(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; override;
   function DoInsertBreak(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function DoInsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp;
    InsertMode: Boolean;
    aFlags: TnevInsertStringFlags): Boolean; override;
   function DoDeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   procedure DoRefreshBorders; override;
   function IsCollapsed(const aView: InevView): Boolean; override;
   function TagReader: InevTagReader; override;
   function DoGetBorders: TevPair; override;
   procedure DoGetBorderPoints(out theStart: InevBasePoint;
    out theFinish: InevBasePoint); override;
   function DoSearchReplace(const aSearcher: IevSearcher;
    const aReplacer: IevReplacer;
    const aConfirm: InevConfirm;
    const Cursor: InevBasePoint;
    const anOpPack: InevOp;
    aNeedProgress: Boolean): Boolean; override;
   procedure DoForceStore; override;
  public
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure DoInit(const aStart: InevBasePoint;
    const aFinish: InevBasePoint;
    aSharp: Boolean); override;
   procedure Assign(Source: Tk2ToolPrim); override;
 end;//TevCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , l3Const
 , k2TagGen
 , l3MinMax
 , evCursor
 , nevPersistentDocumentContainer
 , evTypes
 , evExcept
 , nevInterfaces
 , SysUtils
;

procedure TevCursorPair.GetBlockBorders;
//#UC START# *52D7FCD700CF_4A2D2D5D0114_var*
//#UC END# *52D7FCD700CF_4A2D2D5D0114_var*
begin
//#UC START# *52D7FCD700CF_4A2D2D5D0114_impl*
 if (f_Start <> nil) then
  f_B.rStart := f_Start.Position
 else
  f_B.rStart := 0;
 if (f_Finish <> nil) then
  f_B.rFinish := f_Finish.Position
 else
  f_B.rFinish := l3NilLong;
//#UC END# *52D7FCD700CF_4A2D2D5D0114_impl*
end;//TevCursorPair.GetBlockBorders

function TevCursorPair.IsSolid(const aView: InevView): Boolean;
//#UC START# *52D79F9400EB_4A2D2D5D0114_var*
var
 SC, FC : InevBasePoint;
//#UC END# *52D79F9400EB_4A2D2D5D0114_var*
begin
//#UC START# *52D79F9400EB_4A2D2D5D0114_impl*
 GetBorderPoints(SC, FC);
 Result := (SC = nil) AND (FC = nil);
//#UC END# *52D79F9400EB_4A2D2D5D0114_impl*
end;//TevCursorPair.IsSolid

procedure TevCursorPair.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A2D2D5D0114_var*
//#UC END# *479731C50290_4A2D2D5D0114_var*
begin
//#UC START# *479731C50290_4A2D2D5D0114_impl*
 f_Start := nil;
 f_Finish := nil;
 f_B.rStart := l3NilLong;
 f_B.rFinish := l3NilLong;
 inherited;
//#UC END# *479731C50290_4A2D2D5D0114_impl*
end;//TevCursorPair.Cleanup

function TevCursorPair.DoDeleteCharToLeft(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A29419B0319_4A2D2D5D0114_var*
//#UC END# *4A29419B0319_4A2D2D5D0114_var*
begin
//#UC START# *4A29419B0319_4A2D2D5D0114_impl*
 Result := Delete(aView, anOp);
//#UC END# *4A29419B0319_4A2D2D5D0114_impl*
end;//TevCursorPair.DoDeleteCharToLeft

function TevCursorPair.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_4A2D2D5D0114_var*
{$IfDef evNeedMarkers}
var
 M : IevMarker;
{$EndIf evNeedMarkers}
//#UC END# *4A29465701BC_4A2D2D5D0114_var*
begin
//#UC START# *4A29465701BC_4A2D2D5D0114_impl*
{$IfDef evNeedMarkers}
 Result := false;
 if (aMarker.CompareLevel(GetRedirect) = 0) then
 begin
  M := aMarker.MakeCopy(Self.ParaX);
  try
   if (M.Value <> l3NilLong) then
   begin
    M.SetValue(aValue, anOp);
    Result := true;
   end;//M.Value <> l3NilLong
  finally
   M := nil;
  end;{try..finally}
 end;//aMarker.CompareLevel(GetRedirect^) = 0
{$else}
 inherited;
{$EndIf evNeedMarkers}
//#UC END# *4A29465701BC_4A2D2D5D0114_impl*
end;//TevCursorPair.DoChangeParam

function TevCursorPair.DoInsertBreak(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F59B0234_4A2D2D5D0114_var*
//#UC END# *4A38F59B0234_4A2D2D5D0114_var*
begin
//#UC START# *4A38F59B0234_4A2D2D5D0114_impl*
 Delete(aView, anOp);
 if (f_Start = nil) then
  Result := true
 else
  Result := f_Start.Text.Modify.InsertBreak(aView, aDrawLines, anOp);
//#UC END# *4A38F59B0234_4A2D2D5D0114_impl*
end;//TevCursorPair.DoInsertBreak

function TevCursorPair.DoInsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp;
 InsertMode: Boolean;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F71601D6_4A2D2D5D0114_var*
//#UC END# *4A38F71601D6_4A2D2D5D0114_var*
begin
//#UC START# *4A38F71601D6_4A2D2D5D0114_impl*
 Delete(aView, anOp);
 if (f_Start = nil) then
  Result := ParaX.MakePoint.Text.Modify.InsertString(aView, aString, anOp, InsertMode, aFlags)
 else
  Result := f_Start.Text.Modify.InsertString(aView, aString, anOp, InsertMode, aFlags);
 if Result then
  Unselect(aView);
//#UC END# *4A38F71601D6_4A2D2D5D0114_impl*
end;//TevCursorPair.DoInsertString

function TevCursorPair.DoDeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7F5022C_4A2D2D5D0114_var*
//#UC END# *4A38F7F5022C_4A2D2D5D0114_var*
begin
//#UC START# *4A38F7F5022C_4A2D2D5D0114_impl*
 Delete(aView, anOp);
 Result := true;
//#UC END# *4A38F7F5022C_4A2D2D5D0114_impl*
end;//TevCursorPair.DoDeleteChar

function TevCursorPair.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4A2D2D5D0114_var*
//#UC END# *4A60B23E00C3_4A2D2D5D0114_var*
begin
//#UC START# *4A60B23E00C3_4A2D2D5D0114_impl*
 if IID.EQ(Ik2TagGeneratorWrap) then
 begin
  Result.SetNoInterface;
  Assert(false);
(*  if (f_Start = nil) then
   Result := Self.Obj.Point.QueryInterface(IID.IID, Obj)
  else
   Result := f_Start.QueryInterface(IID.IID, Obj);*)
 end//IID.EQ(Ik2TagGeneratorWrap)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4A2D2D5D0114_impl*
end;//TevCursorPair.COMQueryInterface

procedure TevCursorPair.DoInit(const aStart: InevBasePoint;
 const aFinish: InevBasePoint;
 aSharp: Boolean);
//#UC START# *5108D53B0312_4A2D2D5D0114_var*
//#UC END# *5108D53B0312_4A2D2D5D0114_var*
begin
//#UC START# *5108D53B0312_4A2D2D5D0114_impl*
 inherited;
 f_Start := aStart;
 f_Finish := aFinish;
 GetBlockBorders;
 f_B.rFinish := Min(f_B.rFinish, DoGetBlockLength);
//#UC END# *5108D53B0312_4A2D2D5D0114_impl*
end;//TevCursorPair.DoInit

procedure TevCursorPair.Assign(Source: Tk2ToolPrim);
//#UC START# *52BC1DD60298_4A2D2D5D0114_var*
//#UC END# *52BC1DD60298_4A2D2D5D0114_var*
begin
//#UC START# *52BC1DD60298_4A2D2D5D0114_impl*
 if (Self = Source) then
  Exit
 else
 if (Source Is TevCursor) then
  Assert(false)(*;
  Init(TevCursor(aCursor).ClonePoint(nil).Point, TevCursor(aCursor).ClonePoint(nil).Point)*)
 else
  inherited;
//#UC END# *52BC1DD60298_4A2D2D5D0114_impl*
end;//TevCursorPair.Assign

procedure TevCursorPair.DoRefreshBorders;
//#UC START# *52D79E610203_4A2D2D5D0114_var*
//#UC END# *52D79E610203_4A2D2D5D0114_var*
begin
//#UC START# *52D79E610203_4A2D2D5D0114_impl*
 GetBlockBorders;
//#UC END# *52D79E610203_4A2D2D5D0114_impl*
end;//TevCursorPair.DoRefreshBorders

function TevCursorPair.IsCollapsed(const aView: InevView): Boolean;
//#UC START# *52D79FB703C9_4A2D2D5D0114_var*
//#UC END# *52D79FB703C9_4A2D2D5D0114_var*
begin
//#UC START# *52D79FB703C9_4A2D2D5D0114_impl*
 if (f_Start = nil) OR (f_Finish = nil) then
  Result := false
 else
  Result := (f_Start.Compare(f_Finish) >= 0);
//#UC END# *52D79FB703C9_4A2D2D5D0114_impl*
end;//TevCursorPair.IsCollapsed

function TevCursorPair.TagReader: InevTagReader;
//#UC START# *52D79FFA012A_4A2D2D5D0114_var*
var
 l_Container : InevDocumentContainer;
//#UC END# *52D79FFA012A_4A2D2D5D0114_var*
begin
//#UC START# *52D79FFA012A_4A2D2D5D0114_impl*
 l_Container := ParaX.DocumentContainer;
 if (l_Container = nil) then
  Result := TnevPersistentDocumentContainer.Make.TagReader
 else
  Result := l_Container.TagReader; 
//#UC END# *52D79FFA012A_4A2D2D5D0114_impl*
end;//TevCursorPair.TagReader

function TevCursorPair.DoGetBorders: TevPair;
//#UC START# *52D7A46B016F_4A2D2D5D0114_var*
//#UC END# *52D7A46B016F_4A2D2D5D0114_var*
begin
//#UC START# *52D7A46B016F_4A2D2D5D0114_impl*
 Result := f_B;
//#UC END# *52D7A46B016F_4A2D2D5D0114_impl*
end;//TevCursorPair.DoGetBorders

procedure TevCursorPair.DoGetBorderPoints(out theStart: InevBasePoint;
 out theFinish: InevBasePoint);
//#UC START# *52D7A56B029E_4A2D2D5D0114_var*
//#UC END# *52D7A56B029E_4A2D2D5D0114_var*
begin
//#UC START# *52D7A56B029E_4A2D2D5D0114_impl*
 theStart := f_Start;
 theFinish := f_Finish;
//#UC END# *52D7A56B029E_4A2D2D5D0114_impl*
end;//TevCursorPair.DoGetBorderPoints

function TevCursorPair.DoSearchReplace(const aSearcher: IevSearcher;
 const aReplacer: IevReplacer;
 const aConfirm: InevConfirm;
 const Cursor: InevBasePoint;
 const anOpPack: InevOp;
 aNeedProgress: Boolean): Boolean;
//#UC START# *52D7CCD70340_4A2D2D5D0114_var*
var
 l_Start          : InevBasePoint;
 l_Finish         : InevBasePoint;
 l_Cursor         : InevBasePoint;
 l_NeedReplace    : Boolean;
 l_Found          : Boolean;
 l_FoundSomething : Boolean;
 l_FoundBlock     : InevRange;
 ReplaceIndicator : Il3Progress;
 SearchIndicator  : Il3Progress;
 l_Back           : Boolean;
 l_Ctx            : IevCursorContext;
 l_RestartSource  : InevRestartPositionSource;

 procedure CheckIfFound;
 begin
  if not l_FoundSomething AND
     not (ev_soUseInternalCursor in aSearcher.Options) AND
     not (ev_soNoException in aSearcher.Options) then
   raise EevSearchFailed.Create(ev_warSearchFailed);
 end;
//#UC END# *52D7CCD70340_4A2D2D5D0114_var*
begin
//#UC START# *52D7CCD70340_4A2D2D5D0114_impl*
 Result := false;
 l_Found := False;
 if (Cursor = nil) then
 begin
  if (f_Start = nil) then
   l_Cursor := ParaX.MakePoint
  else
   l_Cursor := f_Start.ClonePoint(aConfirm.View);
 end//Cursor = nil
 else
  l_Cursor := Cursor;
 l_FoundSomething := false;
 l_NeedReplace := Assigned(aReplacer);
 if not aNeedProgress then
  SearchIndicator := nil
 else
  SearchIndicator := aConfirm.Progress;
 try
  if aNeedProgress AND l_NeedReplace AND aReplacer.NeedProgress then
   ReplaceIndicator := SearchIndicator
  else
   ReplaceIndicator := nil;
  if Assigned(ReplaceIndicator) then
   ReplaceIndicator.Start(DoGetBlockLength, str_nevmmReplace.AsCStr);
  try
   Sharp := true;
   l_Back := ev_soBackward in aSearcher.Options;
   while true do
   begin
    try
     l_Found := Search(aConfirm.View, aSearcher, SearchIndicator, l_Cursor, l_Start, l_Finish);
    except
     on EevSearcherRestart do
     begin
      Assert(Supports(aSearcher, InevRestartPositionSource, l_RestartSource));
      try
       l_Cursor.AssignPoint(aConfirm.View, l_RestartSource.RestartPos);
      finally
       l_RestartSource := nil;
      end;
      Continue;
     end;
    end;
    if l_Found then
    begin
     try
      Assert(l_Start <> nil);
      l_Start := l_Start.PointToParent(l_Cursor.Obj^, true);
      Assert(l_Finish <> nil);
      l_Finish := l_Finish.PointToParent(l_Cursor.Obj^, true);
      if Assigned(ReplaceIndicator) then
       ReplaceIndicator.Progress(l_Finish.Position);
      if (anOpPack <> nil) AND anOpPack.SaveUndo then
       if Supports(anOpPack, IevCursorContext, l_Ctx) then
        try
         l_Ctx.RecordCursor(l_Cursor);
        finally
         l_Ctx := nil;
        end;//try..finally
      with l_Cursor do
      begin
       if l_Back then
        AssignPoint(aConfirm.View, l_Start)
       else
        AssignPoint(aConfirm.View, l_Finish);
       Refresh;
      end;//l_Cursor
      l_FoundSomething := true;
      if not l_NeedReplace then
       break;
      try
       l_FoundBlock := Self.ParaX.Range(l_Start, l_Finish);
       if not aReplacer.Replace(anOpPack, l_FoundBlock, aConfirm) then
       begin
        Result := true;
        break;
       end;//not aReplacer.Replace
      finally
       l_FoundBlock := nil;
      end;//try..finally
      l_Cursor.AssignPoint(aConfirm.View, l_Finish);
     finally
      l_Start := nil;
      l_Finish := nil;
     end;//try..finally
    end//l_Found
    else
     break;
   end;//while true
  finally
   if Assigned(ReplaceIndicator) then
    ReplaceIndicator.Finish;
  end;//try..finally
 finally
  SearchIndicator := nil;
 end;//try..finally
 CheckIfFound;
//#UC END# *52D7CCD70340_4A2D2D5D0114_impl*
end;//TevCursorPair.DoSearchReplace

procedure TevCursorPair.DoForceStore;
//#UC START# *5321B9DF011A_4A2D2D5D0114_var*
//#UC END# *5321B9DF011A_4A2D2D5D0114_var*
begin
//#UC START# *5321B9DF011A_4A2D2D5D0114_impl*
 inherited;
 if (f_Start <> nil) then
  f_Start.AsObject.ForceStore;
 if (f_Finish <> nil) then
  f_Finish.AsObject.ForceStore;
//#UC END# *5321B9DF011A_4A2D2D5D0114_impl*
end;//TevCursorPair.DoForceStore
{$IfEnd} // Defined(evUseVisibleCursors)

end.
