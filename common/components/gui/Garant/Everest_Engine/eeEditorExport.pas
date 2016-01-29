unit eeEditorExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeEditorExport.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeeEditorExport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  l3Interfaces,
  ActiveX,
  Classes,
  nevTools
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evInternalInterfaces,
  eeInterfaces,
  eeInterfacesEx,
  eeEditorExportModelPart,
  vtScrollBar,
  evCustomTextSource,
  l3IID,
  afwInterfaces,
  nevGUIInterfaces,
  Types,
  Windows,
  nevBase,
  evExcept,
  l3InternalInterfaces,
  evdTypes,
  l3Variant
  ;

type
 TeeMouseActionEvent = function (aSender: TObject;
  const aHotSpot: IeeHotSpot;
  aButton: TeeMouseButton;
  anAction: TeeMouseAction;
  Keys: TeeShiftState;
  aWasSelection: Boolean): Boolean of object;

 TeeEditorExport = class(TeeEditorExportModelPart, IeeDocumentEx, IevF1LikeEditor)
 private
 // private fields
   f_PrevScrollPos : Integer;
   f_PrevScrollPart : IevSub;
   f_PrevPart : IevSub;
   f_VScrollBar : TvtScrollBar;
    {* Поле для свойства VScrollBar}
   f_NeedDrawDocumentEdge : Boolean;
    {* Поле для свойства NeedDrawDocumentEdge}
   f_OnMouseAction : TeeMouseActionEvent;
    {* Поле для свойства OnMouseAction}
   f_OnVScroll : TNotifyEvent;
    {* Поле для свойства OnVScroll}
   f_OnUserCommentsHidden : TNotifyEvent;
    {* Поле для свойства OnUserCommentsHidden}
 private
 // private methods
   class procedure RaiseUserCommentsHidden;
     {* Сигнатура метода RaiseUserCommentsHidden }
   class function MB2eeMB(aButton: TMouseButton): TeeMouseButton;
 protected
 // property methods
   procedure pm_SetVScrollBar(aValue: TvtScrollBar);
 protected
 // realized methods
   function Get_DocumentPart(anID: Integer): IevDocumentPart;
   function Get_DocumentPartEx(anID: Integer; aLayerID: Integer): IevDocumentPart;
   function Get_Sub(anID: Integer): IevSub;
   function Get_SubEx(anID: Integer; aLayerID: Integer): IevSub;
   function Get_Selection: InevSelection;
   function Get_EntryPoint: Tl3Tag;
   function Get_Processor: InevProcessor;
   function Get_NewSub: IevSub;
   function Get_NewSubEx(aLayerID: Integer): IevSub;
   function AsIeeDocumentEx: IeeDocumentEx; override;
 protected
 // overridden property methods
   function pm_GetTextSource: TevCustomTextSource; override;
   procedure pm_SetTextSource(aValue: TevCustomTextSource); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ParaChange; override;
     {* текущий параграф изменился. }
   procedure MakeTextSource(out theTextSource: TevCustomTextSource); override;
   function AllowDrawDocumentEdge: Boolean; override;
   function WantTab(aKeyPressed: Boolean = False): Boolean; override;
   function DoDoDragOver(const aData: IDataObject;
    const aPoint: TPoint): Boolean; override;
   function DoGetAcceptableFormats: Tl3ClipboardFormats; override;
   function DoDoDrop(aFormat: Tl3ClipboardFormat;
    const aMedium: Tl3StoragePlace;
    var dwEffect: Integer): Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {$If not defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
     Shift: TShiftState;
     X: Integer;
     Y: Integer); override;
    {$IfEnd} //not NoVCL
   procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    {$If not defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
     Shift: TShiftState;
     X: Integer;
     Y: Integer); override;
    {$IfEnd} //not NoVCL
   procedure DoHitTest(const aHotSpot: IevHotSpot;
     const aState: TafwCursorState;
     var theInfo: TafwCursorInfo); override;
    {$If not defined(NoVCM)}
   function TextGetTarget(const aPt: TPoint;
     out theTarget: IUnknown): Boolean; override;
    {$IfEnd} //not NoVCM
   function InTable: Boolean; override;
   function CheckMouseUp(const aHotSpot: IevHotSpot;
     const aState: TevMouseState): Boolean; override;
   procedure ScrollInfoChange(aVert: Boolean;
     const aScrollInfo: TScrollInfo;
     aPosChanged: Boolean); override;
   function DoBreakPara(aDrawLines: Boolean;
     const anOp: InevOp): Boolean; override;
   function HandledReadOnly(E: EevReadOnly): Boolean; override;
    {$If not defined(NoVCM)}
   function CanCut: Boolean; override;
    {$IfEnd} //not NoVCM
   function VScrollWidth(const anIC: Il3InfoCanvas): Integer; override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
   function IsReadOnlyTarget(const aTarget: IUnknown): Boolean; override;
   function InsertPageBreak(NeedNewSection: Boolean = False;
     aPageOrientation: TevPageOrientation = ev_poPortrait): Boolean; override;
   procedure DecIndent; override;
     {* Сигнатура метода DecIndent }
   procedure IncIndent; override;
     {* Сигнатура метода IncIndent }
 protected
 // protected methods
   function DontBreakInAACMode: Boolean;
   function InUserComment: Boolean;
   function CanInsertParaOnMove: Boolean;
     {* Можно ли вставлять параграфы при движении курсора }
   function IsInReadOnlyPara(const aPara: InevPara;
     Delete: Boolean): Boolean;
     {* Находимся ли в параграфе, в котором запрещено редактирование }
 public
 // public methods
   procedure SaveTo(const aStream: IStream;
     aFormat: Tl3ClipboardFormat;
     aSaveSelection: Boolean = True);
   function GetBlockByCursor(const aCursor: InevBasePoint): IevDocumentPart;
   procedure InsertUserComment;
     {* Сигнатура метода InsertUserComment }
   function GetNearestSubByCursor(const aCursor: InevBasePoint = nil): IeeSub;
   function GetNearestBlockByCursor(const aCursor: InevBasePoint): IevDocumentPart;
 protected
 // protected properties
   property OnUserCommentsHidden: TNotifyEvent
     read f_OnUserCommentsHidden
     write f_OnUserCommentsHidden;
 public
 // public properties
   property VScrollBar: TvtScrollBar
     read f_VScrollBar
     write pm_SetVScrollBar;
   property NeedDrawDocumentEdge: Boolean
     read f_NeedDrawDocumentEdge
     write f_NeedDrawDocumentEdge;
   property OnMouseAction: TeeMouseActionEvent
     read f_OnMouseAction
     write f_OnMouseAction;
   property OnVScroll: TNotifyEvent
     read f_OnVScroll
     write f_OnVScroll;
 end;//TeeEditorExport

implementation

uses
  eeExceptions,
  LeafPara_Const,
  ContentsElement_Const,
  CommentPara_Const,
  LeafParaDecorationsHolder_Const,
  Document_Const,
  Table_Const,
  Block_Const,
  k2Tags
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evMsgCode
  {$If defined(Nemesis)}
  ,
  eeSub
  {$IfEnd} //Nemesis
  ,
  evOp,
  nevFacade,
  l3Base,
  afwFacade
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  l3MinMax,
  l3Units,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeEditorExport

class procedure TeeEditorExport.RaiseUserCommentsHidden;
//#UC START# *54C10C4B034D_4952693000EA_var*
//#UC END# *54C10C4B034D_4952693000EA_var*
begin
//#UC START# *54C10C4B034D_4952693000EA_impl*
 raise EeeUserCommentsHidden.Create('Нельзя вставить комментарий. Режим пользовательских комментариев выключен.');
//#UC END# *54C10C4B034D_4952693000EA_impl*
end;//TeeEditorExport.RaiseUserCommentsHidden

class function TeeEditorExport.MB2eeMB(aButton: TMouseButton): TeeMouseButton;
//#UC START# *54C10EA7019B_4952693000EA_var*
const
 _MB : array [TMouseButton] of TeeMouseButton = (ee_mbLeft, ee_mbRight, ee_mbMiddle);
//#UC END# *54C10EA7019B_4952693000EA_var*
begin
//#UC START# *54C10EA7019B_4952693000EA_impl*
 Result := _MB[aButton];
//#UC END# *54C10EA7019B_4952693000EA_impl*
end;//TeeEditorExport.MB2eeMB

function TeeEditorExport.DontBreakInAACMode: Boolean;
//#UC START# *54C0FD320345_4952693000EA_var*
//#UC END# *54C0FD320345_4952693000EA_var*
begin
//#UC START# *54C0FD320345_4952693000EA_impl*
 Result := AACLike in [nev_aacLeft, nev_aacRight];
//#UC END# *54C0FD320345_4952693000EA_impl*
end;//TeeEditorExport.DontBreakInAACMode

procedure TeeEditorExport.SaveTo(const aStream: IStream;
  aFormat: Tl3ClipboardFormat;
  aSaveSelection: Boolean = True);
//#UC START# *54C0FE7902BD_4952693000EA_var*
//#UC END# *54C0FE7902BD_4952693000EA_var*
begin
//#UC START# *54C0FE7902BD_4952693000EA_impl*
 if Assigned(aStream) then
  if aSaveSelection and (not Selection.Collapsed) then
  begin
   InevSelection(Selection).GetBlock.Data.Store(aFormat, aStream, MakeExportFilters(aSaveSelection, true));
  end//not Selection.Collaped
  else
   Document.Range.Data.Store(aFormat, aStream, MakeExportFilters(false, true));
//#UC END# *54C0FE7902BD_4952693000EA_impl*
end;//TeeEditorExport.SaveTo

function TeeEditorExport.InUserComment: Boolean;
//#UC START# *54C100260224_4952693000EA_var*
var
 l_Cursor : InevBasePoint;
//#UC END# *54C100260224_4952693000EA_var*
begin
//#UC START# *54C100260224_4952693000EA_impl*
 Result := InPara(k2_typCommentPara, l_Cursor);
 if Result then
 begin
  if (l_Cursor = nil) then
   Result := false
  else
   Result := not l_Cursor.Obj.AsObject.BoolA[k2_tiCollapsed];
 end;//Result
//#UC END# *54C100260224_4952693000EA_impl*
end;//TeeEditorExport.InUserComment

function TeeEditorExport.CanInsertParaOnMove: Boolean;
//#UC START# *54C106630180_4952693000EA_var*
//#UC END# *54C106630180_4952693000EA_var*
begin
//#UC START# *54C106630180_4952693000EA_impl*
 Result := false;
//#UC END# *54C106630180_4952693000EA_impl*
end;//TeeEditorExport.CanInsertParaOnMove

function TeeEditorExport.IsInReadOnlyPara(const aPara: InevPara;
  Delete: Boolean): Boolean;
//#UC START# *54C106AB020C_4952693000EA_var*
//#UC END# *54C106AB020C_4952693000EA_var*
begin
//#UC START# *54C106AB020C_4952693000EA_impl*
 Result := false;
//#UC END# *54C106AB020C_4952693000EA_impl*
end;//TeeEditorExport.IsInReadOnlyPara

function TeeEditorExport.GetBlockByCursor(const aCursor: InevBasePoint): IevDocumentPart;
//#UC START# *54C10A9901CD_4952693000EA_var*
var
 l_DocumentPart : IevDocumentPart;
 l_Cursor       : InevBasePoint;
 l_aCursor      : InevBasePoint;
 l_Block        : Tl3Variant;
//#UC END# *54C10A9901CD_4952693000EA_var*
begin
//#UC START# *54C10A9901CD_4952693000EA_impl*
 Result := nil;
 if (aCursor = nil) then
  l_aCursor := Selection.Cursor
 else
  l_aCursor := aCursor;
 if evInPara(l_aCursor.MostInner.Obj^.AsObject, k2_typBlock, l_Block) then
 begin
  l_DocumentPart := TextSource.DocumentContainer.SubList.
                     BlockEx[l_Block.IntA[k2_tiHandle],
                             l_Block.IntA[k2_tiLayerID]];
     //Supports(l_Cursor, IevDocumentPart, l_DocumentPart) then
  try
   while (l_DocumentPart <> nil) AND (l_DocumentPart.LayerID <> Ord(ev_sbtSub)) do
    l_DocumentPart := l_DocumentPart.ParentDocumentPart;
   Result := l_DocumentPart;
  finally
   l_DocumentPart := nil;
  end;//try..finally
 end;//evInPara(l_aCursor, k2_idBlock, l_Block)
//#UC END# *54C10A9901CD_4952693000EA_impl*
end;//TeeEditorExport.GetBlockByCursor

procedure TeeEditorExport.InsertUserComment;
//#UC START# *54C10B750137_4952693000EA_var*
//#UC END# *54C10B750137_4952693000EA_var*
begin
//#UC START# *54C10B750137_4952693000EA_impl*
 ProcessCommand(ev_msgBreakPara, true, 1);
//#UC END# *54C10B750137_4952693000EA_impl*
end;//TeeEditorExport.InsertUserComment

function TeeEditorExport.GetNearestSubByCursor(const aCursor: InevBasePoint = nil): IeeSub;
//#UC START# *54C10B810344_4952693000EA_var*
var
 l_DocumentPart : IevSub;
 l_aCursor      : InevBasePoint;
 l_Cursor       : InevBasePoint;
//#UC END# *54C10B810344_4952693000EA_var*
begin
//#UC START# *54C10B810344_4952693000EA_impl*
 Result := nil;
 if (aCursor = nil) then
 begin
  if (Selection <> nil) then
   l_aCursor := Selection.Cursor
  else
  begin
   Result := nil;
   exit;
  end;
 end
 else
  l_aCursor := aCursor;
 l_aCursor := l_aCursor.ClonePoint(View);
 try
  while true do
  begin
   if Supports(l_aCursor.MostInner, IevSub, l_DocumentPart) then
   try
    if l_DocumentPart.Exists AND (l_DocumentPart.LayerID = Ord(ev_sbtSub)) then
     {$If Declared(TeeSub)}
     Result := TeeSub.Make(Self, l_DocumentPart.ID, l_DocumentPart.LayerID, 0);
     {$Else}
     Assert(false);
     {$ifEnd}
   finally
    l_DocumentPart := nil;
   end;//try..finally
   if (Result = nil) AND
      evInPara(l_aCursor, k2_typBlock, l_Cursor) then
   begin
    if (l_Cursor.Position = 1) AND
       Supports(l_Cursor, IevDocumentPart, l_DocumentPart) AND
       (l_DocumentPart.LayerID = Ord(ev_sbtSub)) then
     try
      Result := Get_BlockEx(l_DocumentPart.ID, l_DocumentPart.LayerID);
     finally
      l_DocumentPart := nil;
     end//try..finally
    else
    if not l_aCursor.MostInner.Move(View, ev_ocPrevParaBottomRight) then
     break;
   end;//Result = nil
   if (Result <> nil) then
    if (Result.LayerID = Ord(ev_sbtSub)) then
     break
    else
     Result := nil;
  end;//while true
 finally
  l_aCursor := nil;
 end;//try..finally
//#UC END# *54C10B810344_4952693000EA_impl*
end;//TeeEditorExport.GetNearestSubByCursor

function TeeEditorExport.GetNearestBlockByCursor(const aCursor: InevBasePoint): IevDocumentPart;
//#UC START# *54C10B9F01AE_4952693000EA_var*
var
 l_Cursor : InevBasePoint;
 l_Res    : IevDocumentPart absolute Result;

 function SkipLeaves: Boolean;
 var
  l_PID   : Integer;
  l_Block : InevObjectList;
  l_Child : Tl3Variant;
 begin//SkipLeaves
  Result := false;
  l_PID := l_Cursor.Position - 1;
  l_Block := l_Cursor.Obj.ToList;
  if l_Block.AsObject.IsKindOf(k2_typDocument) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=255972328
   Exit;
  if (l_PID = 0) then
  // - не надо пересмещать позицию, т.к. можем не встать на самого внутреннего ребёнка
  //   а на k2_idContentsElement и зависнуть
  // http://mdp.garant.ru/pages/viewpage.action?pageId=221251387 
   Result := (l_Res <> nil) AND not l_Block.AsObject.IsKindOf(k2_typCommentPara)
  else
  begin
   if (l_Block.AsObject.ChildrenCount = l_Block.LeafShapeCount) then
   // - заточка для плоских блоков
   begin
    l_Cursor.Move(View, ev_ocTopLeft);
    Result := not l_Block.AsObject.IsKindOf(k2_typCommentPara);
   end//l_Block.ChildrenCount = l_Block.LeafShapeCount
   else
   begin
    while (l_PID > 0) do
    begin
     l_Child := l_Block.AsObject.Child[l_PID];
     if not l_Child.IsKindOf(k2_typLeafPara) then
      if not l_Child.IsKindOf(k2_typLeafParaDecorationsHolder) then
       if not l_Child.IsKindOf(k2_typContentsElement) then
        break;
     Dec(l_PID);
    end;//l_PID > 0
    l_Cursor.PositionW := l_PID + 1;
    l_Cursor.Inner.Move(View, ev_ocBottomRight);
    if (l_PID = 0) then
     Result := not l_Block.AsObject.IsKindOf(k2_typCommentPara);
   end;//l_Block.ChildrenCount = l_Block.LeafShapeCount
  end;//l_PID = 0
 end;//SkipLeaves

var
 l_DocumentPart : IevDocumentPart;
 l_aCursor      : InevBasePoint;
 l_TableCursor  : InevBasePoint;
//#UC END# *54C10B9F01AE_4952693000EA_var*
begin
//#UC START# *54C10B9F01AE_4952693000EA_impl*
 Result := nil;
 if not HasDocument OR (TextSource.DocumentContainer.ContentsTree = nil) then
  // - оглавления нету, ну и нечего дёргаться
  Exit;
 if (aCursor = nil) then
 begin
  if (Selection <> nil) then
   l_aCursor := Selection.Cursor
  else
  begin
   Result := nil;
   exit;
  end;//Selection <> nil
 end//aCursor = nil
 else
  l_aCursor := aCursor;
 l_aCursor := l_aCursor.ClonePoint(View);
 try
  while true do
  begin
   if (Result = nil) AND
      evInPara(l_aCursor, k2_typBlock, l_Cursor) then
   begin
    if (l_Cursor.Position = 1) AND
       // http://mdp.garant.ru/pages/viewpage.action?pageId=173509795
       // НЕЛЬЗЯ эту проверку трогать, ибо тогда мы находим не ближайший БЛОК,
       // а ближайшего РОДИТЕЛЯ.
       Supports(l_Cursor, IevDocumentPart, l_DocumentPart) AND
       (l_DocumentPart.LayerID = Ord(ev_sbtSub)) then
     try
      Result := l_DocumentPart;
     finally
      l_DocumentPart := nil;
     end//try..finally
    else
    begin
     if EvInPara(l_aCursor, k2_typTable, l_TableCursor) then
     begin
      l_TableCursor.Move(View, ev_ocTopLeft);
     end//EvInPara(l_aCursor, k2_idTable, l_TableCursor)
     else
     if SkipLeaves then
      continue;
     if not l_aCursor.MostInner.Move(nil{View}, ev_ocPrevParaBottomRight) then
                                   //^ это не потому что Шура, сука, так захотел
                                   //  а чтобы игнорировалась скрытость параграфов
                                   //  ибо http://mdp.garant.ru/pages/viewpage.action?pageId=217690373
      break;
    end;//l_Cursor.Position = 1
   end;//Result = nil
   if (Result <> nil) then
    if (Result.LayerID = Ord(ev_sbtSub)) then
     break
    else
     Result := nil;
  end;//while true
 finally
  l_aCursor := nil;
 end;//try..finally
//#UC END# *54C10B9F01AE_4952693000EA_impl*
end;//TeeEditorExport.GetNearestBlockByCursor

procedure TeeEditorExport.pm_SetVScrollBar(aValue: TvtScrollBar);
//#UC START# *54C0F6E701DB_4952693000EAset_var*
//#UC END# *54C0F6E701DB_4952693000EAset_var*
begin
//#UC START# *54C0F6E701DB_4952693000EAset_impl*
 if (f_VScrollBar <> aValue) then
 begin
  f_VScrollBar := aValue;
  if (f_VScrollBar <> nil) then
  begin
   if (ScrollStyle in [ssHorizontal, ssBoth]) then
    ScrollStyle := ssHorizontal
   else
    ScrollStyle := ssNone;
   f_VScrollBar.OnScroll := VScrollEvent;
  end{ else ScrollStyle := ssBoth};
  UpdateScrollRange([afw_sbVert]);
 end;
//#UC END# *54C0F6E701DB_4952693000EAset_impl*
end;//TeeEditorExport.pm_SetVScrollBar

function TeeEditorExport.Get_DocumentPart(anID: Integer): IevDocumentPart;
//#UC START# *54872A3C0371_4952693000EAget_var*
//#UC END# *54872A3C0371_4952693000EAget_var*
begin
//#UC START# *54872A3C0371_4952693000EAget_impl*
 if (TextSource = nil) then
  Result := nil
 else
  Result := TextSource.DocumentContainer.SubList.Block[anID];
//#UC END# *54872A3C0371_4952693000EAget_impl*
end;//TeeEditorExport.Get_DocumentPart

function TeeEditorExport.Get_DocumentPartEx(anID: Integer; aLayerID: Integer): IevDocumentPart;
//#UC START# *54872A520084_4952693000EAget_var*
//#UC END# *54872A520084_4952693000EAget_var*
begin
//#UC START# *54872A520084_4952693000EAget_impl*
 if (TextSource = nil) then
  Result := nil
 else
  Result := TextSource.DocumentContainer.SubList.BlockEx[anID, aLayerID];
//#UC END# *54872A520084_4952693000EAget_impl*
end;//TeeEditorExport.Get_DocumentPartEx

function TeeEditorExport.Get_Sub(anID: Integer): IevSub;
//#UC START# *54872A8901AE_4952693000EAget_var*
//#UC END# *54872A8901AE_4952693000EAget_var*
begin
//#UC START# *54872A8901AE_4952693000EAget_impl*
 if (TextSource = nil) then
  Result := nil
 else
  Result := TextSource.DocumentContainer.SubList.Sub[anID];
//#UC END# *54872A8901AE_4952693000EAget_impl*
end;//TeeEditorExport.Get_Sub

function TeeEditorExport.Get_SubEx(anID: Integer; aLayerID: Integer): IevSub;
//#UC START# *54872AA70157_4952693000EAget_var*
//#UC END# *54872AA70157_4952693000EAget_var*
begin
//#UC START# *54872AA70157_4952693000EAget_impl*
 if (TextSource = nil) then
  Result := nil
 else
  Result := TextSource.DocumentContainer.SubList.SubEx[anID, aLayerID];
//#UC END# *54872AA70157_4952693000EAget_impl*
end;//TeeEditorExport.Get_SubEx

function TeeEditorExport.Get_Selection: InevSelection;
//#UC START# *54872B13014E_4952693000EAget_var*
//#UC END# *54872B13014E_4952693000EAget_var*
begin
//#UC START# *54872B13014E_4952693000EAget_impl*
 Result := Selection;
//#UC END# *54872B13014E_4952693000EAget_impl*
end;//TeeEditorExport.Get_Selection

function TeeEditorExport.Get_EntryPoint: Tl3Tag;
//#UC START# *54872B4900D7_4952693000EAget_var*
//#UC END# *54872B4900D7_4952693000EAget_var*
begin
//#UC START# *54872B4900D7_4952693000EAget_impl*
 Result := Selection.Cursor.MostInner.Obj^.AsObject;
//#UC END# *54872B4900D7_4952693000EAget_impl*
end;//TeeEditorExport.Get_EntryPoint

function TeeEditorExport.Get_Processor: InevProcessor;
//#UC START# *54872BB40123_4952693000EAget_var*
//#UC END# *54872BB40123_4952693000EAget_var*
begin
//#UC START# *54872BB40123_4952693000EAget_impl*
 Result := Processor; 
//#UC END# *54872BB40123_4952693000EAget_impl*
end;//TeeEditorExport.Get_Processor

function TeeEditorExport.Get_NewSub: IevSub;
//#UC START# *54872BBC00B3_4952693000EAget_var*
//#UC END# *54872BBC00B3_4952693000EAget_var*
begin
//#UC START# *54872BBC00B3_4952693000EAget_impl*
 if (TextSource = nil) then
  Result := nil
 else
  Result := TextSource.DocumentContainer.SubList.NewSub;
//#UC END# *54872BBC00B3_4952693000EAget_impl*
end;//TeeEditorExport.Get_NewSub

function TeeEditorExport.Get_NewSubEx(aLayerID: Integer): IevSub;
//#UC START# *54872BE102BF_4952693000EAget_var*
//#UC END# *54872BE102BF_4952693000EAget_var*
begin
//#UC START# *54872BE102BF_4952693000EAget_impl*
 if (TextSource = nil) then
  Result := nil
 else
  Result := TextSource.DocumentContainer.SubList.NewSubEx[aLayerID];
//#UC END# *54872BE102BF_4952693000EAget_impl*
end;//TeeEditorExport.Get_NewSubEx

function TeeEditorExport.AsIeeDocumentEx: IeeDocumentEx;
//#UC START# *54C0D31200D7_4952693000EA_var*
//#UC END# *54C0D31200D7_4952693000EA_var*
begin
//#UC START# *54C0D31200D7_4952693000EA_impl*
 Result := Self;
//#UC END# *54C0D31200D7_4952693000EA_impl*
end;//TeeEditorExport.AsIeeDocumentEx

procedure TeeEditorExport.Cleanup;
//#UC START# *479731C50290_4952693000EA_var*
//#UC END# *479731C50290_4952693000EA_var*
begin
//#UC START# *479731C50290_4952693000EA_impl*
 f_PrevPart := nil;
 f_PrevScrollPart := nil;
 f_PrevScrollPos  := 0;
 VScrollBar := nil;
 inherited;
//#UC END# *479731C50290_4952693000EA_impl*
end;//TeeEditorExport.Cleanup

constructor TeeEditorExport.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4952693000EA_var*
//#UC END# *47D1602000C6_4952693000EA_var*
begin
//#UC START# *47D1602000C6_4952693000EA_impl*
 inherited;
 PersistentSelection := false;
 LeftIndentDelta := 16;
 AllowMultiSelect := true;
 f_NeedDrawDocumentEdge := true;
//#UC END# *47D1602000C6_4952693000EA_impl*
end;//TeeEditorExport.Create

procedure TeeEditorExport.ParaChange;
//#UC START# *482BFA340236_4952693000EA_var*
var
 l_Block : IevSub;
//#UC END# *482BFA340236_4952693000EA_var*
begin
//#UC START# *482BFA340236_4952693000EA_impl*
 inherited;
 if Assigned(OnBlockChange) AND
    (Selection <> nil) AND (Selection.Cursor <> nil) then
 begin
  if not Selection.Cursor.MostInner.Obj.AsObject.IsKindOf(k2_typLeafPara) then
   Exit;
   // - отсекаем "переходные" процессы
  l_Block := GetBlockByCursor(nil);
  try
   if (l_Block = nil) then
    Exit;
   if (f_PrevPart <> nil) then
   begin
    if (f_PrevPart.ID = l_Block.ID) AND (f_PrevPart.LayerID = l_Block.LayerID) then
     Exit;
   end//f_PrevPart <> nil
   else
   begin
    if (l_Block.ID = 0) AND (l_Block.LayerID = Ord(ev_sbtSub)) then
    begin
     f_PrevPart := l_Block;
     Exit;
    end;//l_Block.ID = 0
   end;//f_PrevPart <> nil
   f_PrevPart := l_Block;
   OnBlockChange(Self);
  finally
   l_Block := nil;
  end;//try..finally
 end;//Assigned(f_OnBlockChange)..
//#UC END# *482BFA340236_4952693000EA_impl*
end;//TeeEditorExport.ParaChange

procedure TeeEditorExport.MakeTextSource(out theTextSource: TevCustomTextSource);
//#UC START# *482BFB0A00E0_4952693000EA_var*
//#UC END# *482BFB0A00E0_4952693000EA_var*
begin
//#UC START# *482BFB0A00E0_4952693000EA_impl*
 {$If Declared(TeeTextSourceExport)}
 theTextSource := TeeTextSourceExport.Create(Self);
 {$Else}
 inherited;
 {$IfEnd}
//#UC END# *482BFB0A00E0_4952693000EA_impl*
end;//TeeEditorExport.MakeTextSource

function TeeEditorExport.AllowDrawDocumentEdge: Boolean;
//#UC START# *482BFBEE00D5_4952693000EA_var*
//#UC END# *482BFBEE00D5_4952693000EA_var*
begin
//#UC START# *482BFBEE00D5_4952693000EA_impl*
 Result := f_NeedDrawDocumentEdge;
//#UC END# *482BFBEE00D5_4952693000EA_impl*
end;//TeeEditorExport.AllowDrawDocumentEdge

function TeeEditorExport.WantTab(aKeyPressed: Boolean = False): Boolean;
//#UC START# *482BFCAE0072_4952693000EA_var*
//#UC END# *482BFCAE0072_4952693000EA_var*
begin
//#UC START# *482BFCAE0072_4952693000EA_impl*
 Result := not ReadOnly and InUserComment;
 // - если не в комментарии, то по Tab надо переходить на другой контрол.
//#UC END# *482BFCAE0072_4952693000EA_impl*
end;//TeeEditorExport.WantTab

function TeeEditorExport.DoDoDragOver(const aData: IDataObject;
  const aPoint: TPoint): Boolean;
//#UC START# *48BFA1300211_4952693000EA_var*
//#UC END# *48BFA1300211_4952693000EA_var*
begin
//#UC START# *48BFA1300211_4952693000EA_impl*
 if ShowUserComments and (AACLike <> nev_aacLeft) then
  Result := inherited DoDoDragOver(aData, aPoint)
 else
  Result := false; 
//#UC END# *48BFA1300211_4952693000EA_impl*
end;//TeeEditorExport.DoDoDragOver

function TeeEditorExport.DoGetAcceptableFormats: Tl3ClipboardFormats;
//#UC START# *48BFB42C002A_4952693000EA_var*
//#UC END# *48BFB42C002A_4952693000EA_var*
begin
//#UC START# *48BFB42C002A_4952693000EA_impl*
 if ShowUserComments then
  Result := inherited DoGetAcceptableFormats
 else
  Result := nil;
//#UC END# *48BFB42C002A_4952693000EA_impl*
end;//TeeEditorExport.DoGetAcceptableFormats

function TeeEditorExport.DoDoDrop(aFormat: Tl3ClipboardFormat;
  const aMedium: Tl3StoragePlace;
  var dwEffect: Integer): Boolean;
//#UC START# *48BFB6D800B3_4952693000EA_var*
var
 l_TopAnchor     : InevBasePoint;
 l_Reversed      : Boolean;
 l_SearchCommand : Integer;
 l_Cursor        : InevBasePoint;

 function DoReverse : Boolean;
 begin//DoReverse
  if not l_Reversed then
  begin
   l_Reversed := True;
   l_SearchCommand := ev_ocNextParaTopLeft;
   InevSelection(Selection).SelectPoint(l_Cursor, False, False);
   if Assigned(l_TopAnchor) then
    ScrollToCursor(l_TopAnchor);
   Result := true; 
  end//not l_Reversed
  else
   Result := false;
 end;//DoReverse
var
 l_LastInner : Il3TagRef;
//#UC END# *48BFB6D800B3_4952693000EA_var*
begin
//#UC START# *48BFB6D800B3_4952693000EA_impl*
 Result := false;
 if (Selection <> nil) AND (Selection.Cursor <> nil) then
  if ShowUserComments then
  begin
   Lock(Self);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=278135821
   // чтобы не дёргаться на каждый чих при вставке по DnD, которое операцию
   // то открыло, а окно - не залочило, что правильно, ну вот тут - надо бы уже залочить.
   try
    if not GetTopCursor(l_TopAnchor) then
     l_TopAnchor := nil;
    l_Cursor := Selection.Cursor.ClonePoint(View);
    l_Reversed := False;
    l_SearchCommand := ev_ocPrevParaBottomRight;
    l_LastInner := nil;
    try
     while not Result do
     begin
      try
       Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
       Exit;
      except
       on EeeCannotInsertPara do
       begin
        Result := false;
        if (Selection <> nil) then
         InevSelection(Selection).Unselect;
       end;//EeeCannotInsertPara
       on EeeCannotDeletePara do
       begin
        Result := false;
        if (Selection <> nil) then
         InevSelection(Selection).Unselect;
        if not l_Cursor.HasInner and (l_Cursor.Position > 1) then
        begin
         l_Cursor.Move(View, ev_ocBottomRight, StartOp(ev_msgMove));
         InevSelection(Selection).SelectPoint(l_Cursor, False, False);
        end;
       end;//EeeCannotDeletePara
       on EevLimitReached do
       // http://mdp.garant.ru/pages/viewpage.action?pageId=453166247
       begin
        Result := true{false};
        Exit;
       end;//EevLimitReached
      end;//try..except
      if not MoveLeafCursor(l_SearchCommand) then
      begin
       if not MoveLeafCursor(l_SearchCommand, true) then
        // Если в одну строну найти не удалось - разворачиваемся в другую
        if not DoReverse then
         break;
      end//not MoveLeafCursor(l_SearchCommand)
      else
       if (l_LastInner <> nil) AND
          l_LastInner.AsObject.IsSame(Selection.Cursor.MostInner.Obj^.AsObject) then
        // http://mdp.garant.ru/pages/viewpage.action?pageId=294589436
        if not MoveLeafCursor(l_SearchCommand) then
         if not DoReverse then
         begin
          Result := true;
          break;
         end;//not DoReverse
      l_LastInner := Selection.Cursor.MostInner.Obj^;
     end;//while not Result
    finally
     l_LastInner := nil;
    end;//try..finally
   finally
    Unlock(Self);
   end;//try..finally
  end;//ShowUserComments
//#UC END# *48BFB6D800B3_4952693000EA_impl*
end;//TeeEditorExport.DoDoDrop

function TeeEditorExport.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *48C7C4990287_4952693000EA_var*
//#UC END# *48C7C4990287_4952693000EA_var*
begin
//#UC START# *48C7C4990287_4952693000EA_impl*
 if IID.EQ(IeeHotSpot) then
 begin
  Assert(false);
  Result.SetNoInterface;
 end//IID.EQ(IeeHotSpot)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *48C7C4990287_4952693000EA_impl*
end;//TeeEditorExport.COMQueryInterface

{$If not defined(NoVCL)}
procedure TeeEditorExport.MouseUp(Button: TMouseButton;
  Shift: TShiftState;
  X: Integer;
  Y: Integer);
//#UC START# *4E7896270076_4952693000EA_var*
var
 l_HotSpot : IeeHotSpot;
//#UC END# *4E7896270076_4952693000EA_var*
begin
//#UC START# *4E7896270076_4952693000EA_impl*
 if Assigned(f_OnMouseAction) AND
    (Button <> mbLeft)
    // - этот случай особо отрабатывается в CheckMouseUp
    //   см. http://mdp.garant.ru/pages/viewpage.action?pageId=155030165
    then
 begin
  if GetHotspotOnPoint(Point(X, Y), l_HotSpot) then
   try
    {$IfDef XE}
    assert(false);
    {$Else}
    if f_OnMouseAction(Self,
                       l_HotSpot,
                       MB2eeMB(Button),
                       ee_maUp,
                       TeeShiftState(Shift),
                       fl_WasAsyncLoop) then
    begin
     fl_WasAsyncLoop := false;
     Exit;
    end;//f_OnMouseAction
    {$EndIf}
   finally
    l_HotSpot := nil;
   end;//try..finally
 end;//Assigned(f_OnMouseAction)
 inherited;
//#UC END# *4E7896270076_4952693000EA_impl*
end;//TeeEditorExport.MouseUp
{$IfEnd} //not NoVCL

procedure TeeEditorExport.Notification(AComponent: TComponent;
  Operation: TOperation);
//#UC START# *4F884378016A_4952693000EA_var*
//#UC END# *4F884378016A_4952693000EA_var*
begin
//#UC START# *4F884378016A_4952693000EA_impl*
 inherited;
 if (Operation = opRemove) then begin
  if (aComponent = f_VScrollBar) then
   VScrollBar := nil;
 end;//Operation = opRemove
//#UC END# *4F884378016A_4952693000EA_impl*
end;//TeeEditorExport.Notification

{$If not defined(NoVCL)}
procedure TeeEditorExport.MouseDown(Button: TMouseButton;
  Shift: TShiftState;
  X: Integer;
  Y: Integer);
//#UC START# *4F88473B03CD_4952693000EA_var*
var
 l_HotSpot : IeeHotSpot;
 l_Op      : InevOp;
//#UC END# *4F88473B03CD_4952693000EA_var*
begin
//#UC START# *4F88473B03CD_4952693000EA_impl*
 afw.BeginOp;
 try
  if GetHotspotOnPoint(Point(X, Y), l_HotSpot) then
   try
    // Проверку Assigned(f_OnMouseAction) убрал вглубь.
    // http://mdp.garant.ru/pages/viewpage.action?pageId=565015212
    if not l_HotSpot.InSelection AND (Button = mbRight) then
    begin
     // - переставляем курсор по клику правой кнопкой
     begin
      l_Op := StartOp(ev_msgMove);
      try
       InevSelection(Selection).SelectPoint(Selection.Mouse, false);
      finally
       l_Op := nil;
      end;//try..finally
     end;//
    end;//not l_HotSpot.InSelection
   {$IfDef XE}
   assert(false);
   {$Else}
    if Assigned(f_OnMouseAction) and
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=565015212
       f_OnMouseAction(Self,
                       l_HotSpot,
                       MB2eeMB(Button),
                       ee_maDown,
                       TeeShiftState(Shift),
                       fl_WasAsyncLoop) then
     Exit;
    {$EndIf}
   finally
    l_HotSpot := nil;
   end;//try..finally
  inherited;
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *4F88473B03CD_4952693000EA_impl*
end;//TeeEditorExport.MouseDown
{$IfEnd} //not NoVCL

function TeeEditorExport.pm_GetTextSource: TevCustomTextSource;
//#UC START# *54C0FC1000D3_4952693000EAget_var*
//#UC END# *54C0FC1000D3_4952693000EAget_var*
begin
//#UC START# *54C0FC1000D3_4952693000EAget_impl*
 Result := inherited pm_GetTextSource;
//#UC END# *54C0FC1000D3_4952693000EAget_impl*
end;//TeeEditorExport.pm_GetTextSource

procedure TeeEditorExport.pm_SetTextSource(aValue: TevCustomTextSource);
//#UC START# *54C0FC1000D3_4952693000EAset_var*
var
 l_OldTextSource : TevCustomTextSource;
//#UC END# *54C0FC1000D3_4952693000EAset_var*
begin
//#UC START# *54C0FC1000D3_4952693000EAset_impl*
 if (f_TextSource <> aValue) then
 begin
  if (f_TextSource <> nil) AND (f_TextSource.Owner = Self) then
  begin
   l_OldTextSource := f_TextSource;
   try
    f_TextSource.UnlinkEditor(Self);
    f_TextSource := nil;
    RemoveComponent(l_OldTextSource);
   finally
    l3Free(l_OldTextSource);
   end;//try..finally
  end;//f_TextSource <> nil..
  inherited;
 end;//f_TextSource <> aValue
//#UC END# *54C0FC1000D3_4952693000EAset_impl*
end;//TeeEditorExport.pm_SetTextSource

procedure TeeEditorExport.DoHitTest(const aHotSpot: IevHotSpot;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *54C0FCF701F6_4952693000EA_var*
var
 l_HotSpot: IeeHotSpot;
 l_Picture: IeePicture;
//#UC END# *54C0FCF701F6_4952693000EA_var*
begin
//#UC START# *54C0FCF701F6_4952693000EA_impl*
 inherited;
 if MakeHotSpot(aState.rPoint, aHotSpot, l_HotSpot) then
  try
   if Supports(l_HotSpot.Para, IeePicture, l_Picture) then
    try
     theInfo.rCursor := ev_csHandPoint;
    finally
     l_Picture := nil;
    end;//try..finally
  finally
   l_HotSpot := nil;
  end;//try..finally
//#UC END# *54C0FCF701F6_4952693000EA_impl*
end;//TeeEditorExport.DoHitTest

{$If not defined(NoVCM)}
function TeeEditorExport.TextGetTarget(const aPt: TPoint;
  out theTarget: IUnknown): Boolean;
//#UC START# *54C0FF240304_4952693000EA_var*
//#UC END# *54C0FF240304_4952693000EA_var*
begin
//#UC START# *54C0FF240304_4952693000EA_impl*
 Result := GetHotspotOnPoint(aPt, IeeHotSpot(theTarget));
//#UC END# *54C0FF240304_4952693000EA_impl*
end;//TeeEditorExport.TextGetTarget
{$IfEnd} //not NoVCM

function TeeEditorExport.InTable: Boolean;
//#UC START# *54C0FF7C0012_4952693000EA_var*
var
 l_C : InevBasePoint;
//#UC END# *54C0FF7C0012_4952693000EA_var*
begin
//#UC START# *54C0FF7C0012_4952693000EA_impl*
 Result := InPara(k2_typTable, l_C);
 if Result then
  Result := evInPara(l_C.Obj^.AsObject, k2_typCommentPara);
//#UC END# *54C0FF7C0012_4952693000EA_impl*
end;//TeeEditorExport.InTable

function TeeEditorExport.IsReadOnlyTarget(const aTarget: IUnknown): Boolean;
//#UC START# *54C0FFEF0266_4952693000EA_var*
var
 l_HotSpot : IeeHotSpot;
//#UC END# *54C0FFEF0266_4952693000EA_var*
begin
//#UC START# *54C0FFEF0266_4952693000EA_impl*
 Result := inherited IsReadOnlyTarget(aTarget);
 if not Result then
  if Supports(aTarget, IeeHotSpot, l_HotSpot) then
   try
    if (l_HotSpot.Para = nil) then
     Result := true
    else
     Result := not l_HotSpot.Para.IsUserComment;
   finally
    l_HotSpot := nil;
   end;//try..finally 
//#UC END# *54C0FFEF0266_4952693000EA_impl*
end;//TeeEditorExport.IsReadOnlyTarget

function TeeEditorExport.CheckMouseUp(const aHotSpot: IevHotSpot;
  const aState: TevMouseState): Boolean;
//#UC START# *54C1012501EA_4952693000EA_var*
var
 l_HotSpot : IeeHotSpot;
//#UC END# *54C1012501EA_4952693000EA_var*
begin
//#UC START# *54C1012501EA_4952693000EA_impl*
 if Assigned(f_OnMouseAction) then
 begin
  if MakeHotSpot(aState.rPoint, aHotSpot, l_HotSpot) then
   try
    {$IfDef XE}
    assert(false);
    {$Else}
    if f_OnMouseAction(Self,
                       l_HotSpot,
                       ee_mbLeft,
                       ee_maUp,
                       TeeShiftState(aState.rKeys),
                       fl_WasAsyncLoop) then
    begin
     fl_WasAsyncLoop := false;
     Result := true;
     Exit;
    end;//f_OnMouseAction
    {$EndIf}
   finally
    l_HotSpot := nil;
   end;//try..finally
 end;//Assigned(f_OnMouseAction)
 Result := inherited CheckMouseUp(aHotSpot, aState);
//#UC END# *54C1012501EA_4952693000EA_impl*
end;//TeeEditorExport.CheckMouseUp

procedure TeeEditorExport.ScrollInfoChange(aVert: Boolean;
  const aScrollInfo: TScrollInfo;
  aPosChanged: Boolean);
//#UC START# *54C101DD01C5_4952693000EA_var*
var
 l_ScrollInfo : TeeScrollInfo;
 l_Cursor     : InevBasePoint;
 l_Block      : IevSub;
 l_ScrollBar  : TvtScrollBar;
 l_Page       : Integer;
//#UC END# *54C101DD01C5_4952693000EA_var*
begin
//#UC START# *54C101DD01C5_4952693000EA_impl*
 if aVert then
  if aPosChanged then
   if Assigned(f_OnVScroll) then
    f_OnVScroll(Self);
 with l_ScrollInfo do
 begin
  rScrollInfo := aScrollInfo;
  with rScrollInfo do
  begin
   if ((fMask AND SIF_PAGE) <> 0) then
   begin
    if aVert then
    begin
     rSmallChange := l3MinMax.Max(1, nev.LineScrollDelta.Y);
     rLargeChange := l3MinMax.Max(1, nMax div 3);
    end//aVert
    else
    begin
     rSmallChange := l3MinMax.Max(1, nev.LineScrollDelta.X);
     rLargeChange := l3MinMax.Max(1, nPage);
    end;//aVert
   end;//(fMask AND SIF_PAGE) <> 0
   if ((fMask AND SIF_POS) <> 0) AND Assigned(OnBlockScroll) AND aVert then
   begin
    if GetTopCursor(l_Cursor) then
     try
      l_Block := GetBlockByCursor(l_Cursor);
      if (l_Block <> nil) then
       try
        if (f_PrevScrollPart = nil) OR
           not ((f_PrevScrollPart.ID = l_Block.ID) AND
                (f_PrevScrollPart.LayerID = l_Block.LayerID)) then
        begin
         f_PrevScrollPart := l_Block;
         OnBlockScroll(Self, f_PrevScrollPos < aScrollInfo.nPos);
         f_PrevScrollPos := aScrollInfo.nPos;
        end;//f_PrevScrollPart = nil..
       finally
        l_Block := nil;
       end;//try..finally
     finally
      l_Cursor := nil;
     end;//try..finally
   end;//(fMask AND SIF_POS) <> 0..
  end;//with rScrollInfo
 end;//with l_ScrollInfo
 if aVert then
 begin
  l_ScrollBar := f_VScrollBar;
  if (l_ScrollBar <> nil) and (aScrollInfo.nMax > 0) then
  begin
   l_Page := aScrollInfo.nPage;
   if not WasFirstPaint then
    Inc(l_Page);
   l_ScrollBar.Visible := (aScrollInfo.nPos > 0) OR (l_Page {+ 1} < aScrollInfo.nMax);
   if not WasFirstPaint then
    Invalidate;
   //if l_ScrollBar.Visible then
    with l_ScrollBar, l_ScrollInfo, rScrollInfo do
    begin
     if ((fMask AND SIF_PAGE) <> 0) then
      PageSize := nPage;
     if ((fMask AND SIF_RANGE) <> 0) then
     begin
      if (nMax < PageSize) then
       nMax := PageSize;
       // - чтобы не летел exception в TvtScrollBar.SetParams
      SetParams(nPos, nMin, nMax);
      SmallChange := rSmallChange;
      LargeChange := rLargeChange;
     end//(fMask AND SIF_RANGE) <> 0
     else
     if ((fMask AND SIF_POS) <> 0) then
      Position := nPos;
    end;//with l_ScrollBar
  end;//l_ScrollBar <> nil
 end;//aVert
//#UC END# *54C101DD01C5_4952693000EA_impl*
end;//TeeEditorExport.ScrollInfoChange

function TeeEditorExport.DoBreakPara(aDrawLines: Boolean;
  const anOp: InevOp): Boolean;
//#UC START# *54C1028A038A_4952693000EA_var*

 procedure lp_CheckCursor;
 var
  l_Cursor: InevBasePoint;
 begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=595427682
  l_Cursor := Selection.Cursor;
  if l_Cursor <> nil then
  begin
   l_Cursor := l_Cursor.MostInner;
   if (l_Cursor <> nil) and not l_Cursor.ParentPoint.Obj.IsKindOf(k2_typCommentPara) then
    Selection.Cursor.Move(View, ev_ocParaUp, anOp);
  end; // if l_Cursor <> nil then
 end;

 function lp_IsHeaderText: Boolean;
 var
  l_Cursor: InevBasePoint;
 begin
  Result := False;
  l_Cursor := Selection.Cursor;
  if l_Cursor <> nil then
  begin
   l_Cursor := l_Cursor.MostInner;
   if (l_Cursor <> nil) then
   begin
    Result := evHeaderTextPara(l_Cursor.Obj.AsObject);
    if not Result then
     Result := evExpandedText(l_Cursor.Obj.AsObject);
   end; // if (l_Cursor <> nil) then
  end; // if l_Cursor <> nil then12
 end;

var
 l_WasSelection  : Bool;
 l_Pack          : InevOp;
 l_Block         : InevRange;
 l_S, l_F        : InevBasePoint;
 l_TopAnchor     : InevBasePoint;
 l_Cursor        : InevBasePoint;
 l_Reversed      : Bool;
 l_SearchCommand : Integer;
//#UC END# *54C1028A038A_4952693000EA_var*
begin
//#UC START# *54C1028A038A_4952693000EA_impl*
 if DontBreakInAACMode then
 begin
  Result := False;
  Exit;
 end; // if DontBreakInAACMode then
 l_Pack := StartOp(ev_msgInsertPara);
 try
  Result := false;
  if not ShowUserComments then
  begin
   if IsStaticText then
    Exit;
   if Assigned(f_OnUserCommentsHidden) then
    f_OnUserCommentsHidden(Self)
   else
    RaiseUserCommentsHidden;
  end;//not ShowUserComments
  if ShowUserComments then
  begin
   l_WasSelection := not Selection.Collapsed;
   if l_WasSelection then
   begin
    l_Block := InevSelection(Selection).GetBlock;
    l_Block.GetBorderPoints(l_S, l_F);
    if not evInPara(l_S.MostInner, k2_typCommentPara) OR
       not evInPara(l_F.MostInner, k2_typCommentPara) then
     InevSelection(Selection).Unselect;
   end;//l_WasSelection

   try
    if not GetTopCursor(l_TopAnchor) then
     l_TopAnchor := nil;
   except
    on EnevMaybeBaseSwitched do
     l_TopAnchor := nil;
   end;//try..except
   l_Cursor := Selection.Cursor.ClonePoint(View);
   l_Reversed := False;
   //l_SearchCommand := ev_ocPrevParaBottomRight;
   l_SearchCommand := ev_ocNextParaTopLeft;

   while not Result do
   begin
    try
     if not lp_IsHeaderText then
      if inherited DoBreakPara(aDrawLines, anOp) then
      begin
       Result := true;
       lp_CheckCursor;
       Exit;
      end//inherited DoBreakPara
      else
      if IsStaticText then
       Exit;
    except
     on EeeCannotInsertPara do
      Result := false;
     on EeeCannotDeletePara do
      Result := false;
    end;//try..except
    if l_WasSelection {AND Selection.Collapsed} then
    begin
     if (l_Pack <> nil) then
      l_Pack.Undo(Processor);
     InevSelection(Selection).Unselect;
     l_WasSelection := false;
     continue;
     // - типа повторяем попытку :-)
    end;//l_WasSelection
    if not MoveLeafCursor(l_SearchCommand) then
     if not MoveLeafCursor(l_SearchCommand, true) then
      // Если в одну строну найти не удалось - разворачиваемся в другую
      if not l_Reversed then
      begin
       l_Reversed := True;
       l_SearchCommand := ev_ocPrevParaBottomRight;
       //l_SearchCommand := ev_ocNextParaTopLeft;
       InevSelection(Selection).SelectPoint(l_Cursor, False, False);
       if Assigned(l_TopAnchor) then
        ScrollToCursor(l_TopAnchor);
      end // if not l_Reversed then
      else
       break;
   end;//while not Result
  end//ShowUserComments
  else
   Result := true;
   // - типа вставили - чтобы не спрашивать пользователя 2 раза
 finally
  l_Pack := nil;
 end;//try..finally
//#UC END# *54C1028A038A_4952693000EA_impl*
end;//TeeEditorExport.DoBreakPara

function TeeEditorExport.HandledReadOnly(E: EevReadOnly): Boolean;
//#UC START# *54C1033D03DF_4952693000EA_var*
//#UC END# *54C1033D03DF_4952693000EA_var*
begin
//#UC START# *54C1033D03DF_4952693000EA_impl*
 Result := not (E Is EeeCannotInsertPara) AND not (E Is EeeCannotDeletePara);
//#UC END# *54C1033D03DF_4952693000EA_impl*
end;//TeeEditorExport.HandledReadOnly

{$If not defined(NoVCM)}
function TeeEditorExport.CanCut: Boolean;
//#UC START# *54C1051E0360_4952693000EA_var*
var
 l_Block  : InevRange;
 l_S, l_F : InevBasePoint;
//#UC END# *54C1051E0360_4952693000EA_var*
begin
//#UC START# *54C1051E0360_4952693000EA_impl*
 Result := inherited CanCut;
 if Result then
 begin
  l_Block := InevSelection(Selection).GetBlock;
  l_Block.GetBorderPoints(l_S, l_F);
  if evInPara(l_S.MostInner, k2_typCommentPara, l_S) AND
     evInPara(l_F.MostInner, k2_typCommentPara, l_F) then
  begin
   if not l_S.Obj.AsObject.IsSame(l_F.Obj^.AsObject) then
    Result := false;
  end//evInPara
  else
   Result := false;   
 end;//Result
//#UC END# *54C1051E0360_4952693000EA_impl*
end;//TeeEditorExport.CanCut
{$IfEnd} //not NoVCM

function TeeEditorExport.VScrollWidth(const anIC: Il3InfoCanvas): Integer;
//#UC START# *54C108A40224_4952693000EA_var*
//#UC END# *54C108A40224_4952693000EA_var*
begin
//#UC START# *54C108A40224_4952693000EA_impl*
 if Assigned(f_VScrollBar) then
  if f_VScrollBar.Visible
   then Result := 0
   else Result := anIC.DP2LP(PointX(f_VScrollBar.Width)).X
 else
  Result := inherited VScrollWidth(anIC);
//#UC END# *54C108A40224_4952693000EA_impl*
end;//TeeEditorExport.VScrollWidth

function TeeEditorExport.InsertPageBreak(NeedNewSection: Boolean = False;
  aPageOrientation: TevPageOrientation = ev_poPortrait): Boolean;
//#UC START# *54C10AFF0075_4952693000EA_var*
//#UC END# *54C10AFF0075_4952693000EA_var*
begin
//#UC START# *54C10AFF0075_4952693000EA_impl*
 Result := false;
//#UC END# *54C10AFF0075_4952693000EA_impl*
end;//TeeEditorExport.InsertPageBreak

procedure TeeEditorExport.DecIndent;
//#UC START# *54C10BEA0345_4952693000EA_var*
//#UC END# *54C10BEA0345_4952693000EA_var*
begin
//#UC START# *54C10BEA0345_4952693000EA_impl*
 // - ничего не делаем, т.к. для комментариев это неактуально, а остальные параграфы
 //   типа ReadOnly.
//#UC END# *54C10BEA0345_4952693000EA_impl*
end;//TeeEditorExport.DecIndent

procedure TeeEditorExport.IncIndent;
//#UC START# *54C10BFE0098_4952693000EA_var*
//#UC END# *54C10BFE0098_4952693000EA_var*
begin
//#UC START# *54C10BFE0098_4952693000EA_impl*
 // - ничего не делаем, т.к. для комментариев это неактуально, а остальные параграфы
 //   типа ReadOnly.
//#UC END# *54C10BFE0098_4952693000EA_impl*
end;//TeeEditorExport.IncIndent

initialization
{$If not defined(NoScripts)}
// Регистрация TeeEditorExport
 TtfwClassRef.Register(TeeEditorExport);
{$IfEnd} //not NoScripts

end.