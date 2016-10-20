unit msmListView;

// Модуль: "w:\common\components\gui\Garant\msm\msmListView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListView" MUID: (57B4564702F8)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtLister
 , l3ControlsTypes
 , Classes
 , msmDefaultModels
 , l3Interfaces
 , l3TreeInterfaces
 //#UC START# *57B4564702F8intf_uses*
 , Types
 , vtOutlinerWithDragDrop
 //#UC END# *57B4564702F8intf_uses*
;

type
 TmsmGetNodeEvent = procedure(aSender: TObject;
  anIndex: Integer;
  var theNode: Il3SimpleNode) of object;

 //#UC START# *57B4564702F8ci*
 //#UC END# *57B4564702F8ci*
 //#UC START# *57B4564702F8cit*
 //#UC END# *57B4564702F8cit*
 TmsmListView = class(TvtLister)
  private
   f_OnGetItemImage: Tl3GetItemImage;
   f_OnGetTotal: TNotifyEvent;
   f_OnGetNode: TmsmGetNodeEvent;
   f_Model: ImsmDragAndDropModel;
  private
   function DoGetItemImageIndex(Sender: TObject;
    Index: LongInt): Integer;
   procedure QuickSearchHintTimerEvent(Sender: TObject);
   procedure QuickSearchHandler(Sender: TObject;
    const aString: AnsiString);
  protected
   procedure Invalidate;
    {* Запрос на перерисовку. }
   function DoDoDragOver(const aData: IDataObject;
    const aPoint: TPoint): Boolean; override;
   function DoGetAcceptableFormats: Tl3ClipboardFormats; override;
   function DoDoDrop(aFormat: Tl3ClipboardFormat;
    const aMedium: Tl3StoragePlace;
    var dwEffect: Integer): Boolean; override;
   function pm_GetTotal: LongInt; override;
   procedure pm_SetTotal(aValue: LongInt); override;
   function GetDragAndDropSupported: Boolean; override;
   procedure TryDragAndDrop(aNodeIndex: Integer;
    aKey: Integer); override;
   procedure ClearFields; override;
  public
   procedure CallDropDrawPoints;
   constructor Create(AOwner: TComponent); override;
  public
   property OnGetItemImage: Tl3GetItemImage
    read f_OnGetItemImage
    write f_OnGetItemImage;
   property OnGetTotal: TNotifyEvent
    read f_OnGetTotal
    write f_OnGetTotal;
   property OnGetNode: TmsmGetNodeEvent
    read f_OnGetNode
    write f_OnGetNode;
   property Model: ImsmDragAndDropModel
    read f_Model
    write f_Model;
 //#UC START# *57B4564702F8publ*
  private
   f_MousePos: TPoint;
   f_OnCanBeginDrag  : Tl3CanBeginDrag;
  protected 
      {$IfNDef DesignTimeLibrary}
      function  DataObjectClass: RvtNodeDataObject;
        virtual;
        {-}
      {$EndIf  DesignTimeLibrary}  
  public
      property OnCanBeginDrag: Tl3CanBeginDrag
        read f_OnCanBeginDrag
        write f_OnCanBeginDrag;
        {-}
   property AllowWithoutCurrent; 
 //#UC END# *57B4564702F8publ*
 end;//TmsmListView

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B4564702F8impl_uses*
 , Windows
 , Graphics
 , Controls
 , Forms
 , ImgList
 //, l3Interfaces
 , l3BitmapContainer
 //, l3TreeInterfaces
 , l3InternalInterfaces
 , l3Units
 , l3Base
 , l3TreeConst
 , evNodeData
 //#UC END# *57B4564702F8impl_uses*
;

procedure TmsmListView.CallDropDrawPoints;
//#UC START# *57B565DA01A1_57B4564702F8_var*
//#UC END# *57B565DA01A1_57B4564702F8_var*
begin
//#UC START# *57B565DA01A1_57B4564702F8_impl*
 DropDrawPoints;
//#UC END# *57B565DA01A1_57B4564702F8_impl*
end;//TmsmListView.CallDropDrawPoints

function TmsmListView.DoGetItemImageIndex(Sender: TObject;
 Index: LongInt): Integer;
//#UC START# *57D94AB5005D_57B4564702F8_var*
var
 l_Images : TCustomImageList;
//#UC END# *57D94AB5005D_57B4564702F8_var*
begin
//#UC START# *57D94AB5005D_57B4564702F8_impl*
 Result := -1;
 if Assigned(f_OnGetItemImage) then
 begin
  l_Images := Self.Images;
  Result := f_OnGetItemImage(Sender, Index, l_Images);
  if (l_Images <> Self.Images) then
   Self.Images := l_Images;
 end;//Assigned(f_OnGetItemImage)
//#UC END# *57D94AB5005D_57B4564702F8_impl*
end;//TmsmListView.DoGetItemImageIndex

procedure TmsmListView.QuickSearchHintTimerEvent(Sender: TObject);
//#UC START# *57E3EAD8009E_57B4564702F8_var*
var
  l_Point: TPoint;
//#UC END# *57E3EAD8009E_57B4564702F8_var*
begin
//#UC START# *57E3EAD8009E_57B4564702F8_impl*
 GetCursorPos(l_Point);
 if (f_MousePos.X = l_Point.X) and (f_MousePos.Y = l_Point.Y) then
  exit;
 with ScreentoClient(l_Point) do
  if (X < 0) or (X > ClientWidth) or (Y < 0) or (Y > ClientHeight) or (not Application.Active) then
   FreeHintWindow;
//#UC END# *57E3EAD8009E_57B4564702F8_impl*
end;//TmsmListView.QuickSearchHintTimerEvent

procedure TmsmListView.QuickSearchHandler(Sender: TObject;
 const aString: AnsiString);
//#UC START# *57E3EB230241_57B4564702F8_var*
var
  l_HintWindow: THintWindow;
  l_Rect: TRect;
//#UC END# *57E3EB230241_57B4564702F8_var*
begin
//#UC START# *57E3EB230241_57B4564702F8_impl*
{use Application.Hint
  if aString = '' then
    FreeHintWindow
  else begin
    GetCursorPos(f_MousePos);
    l_Rect := GetDrawTextRect(Current);
    with l_Rect do begin
      TopLeft := ClientToScreen(TopLeft);
      BottomRight := ClientToScreen(BottomRight);
      Top := Bottom;
      Left := Left  - 1;
      Top := Top - 3;
      Right := Left + Canvas.Canvas.TextWidth(aString) + 6;
      Bottom := Top + Canvas.Canvas.TextHeight(aString) + 2;
      ShowHintWindow(aString, TopLeft);
    end;
    fHintTimer.OnTimer := QuickSearchHintTimerEvent;
    fHintTimer.Enabled := True;
  end;
}
//use fHintWindow
  if (aString = '') then
    FreeHintWindow
  else
  begin
   l_HintWindow := GetHintWindow;
   if Assigned(l_HintWindow) then
   begin
    GetCursorPos(f_MousePos);
    l_Rect := GetDrawTextRect(Current);
    with l_Rect do
    begin
     TopLeft := ClientToScreen(TopLeft);
     BottomRight := ClientToScreen(BottomRight);
     Top := Bottom;
     DrawText(
       hDC(l_HintWindow.Canvas.Handle),
       PChar(aString),
       -1,
       l_Rect,//with
       DT_CALCRECT or DT_LEFT);// or DT_WORDBREAK
     Left := Left  - 1;
     Top := Top - 3;
     Right := Right + 6;
     Bottom := Bottom - 2;
    end;//with l_Rect
    l_HintWindow.ActivateHint(l_Rect, aString);
    f_HintTimer.OnTimer := QuickSearchHintTimerEvent;
    f_HintTimer.Enabled := True;
   end;//Assigned(l_HintWindow)
  end;//aString = ''
//#UC END# *57E3EB230241_57B4564702F8_impl*
end;//TmsmListView.QuickSearchHandler

procedure TmsmListView.Invalidate;
 {* Запрос на перерисовку. }
//#UC START# *46A5AA4B003C_57B4564702F8_var*
//#UC END# *46A5AA4B003C_57B4564702F8_var*
begin
//#UC START# *46A5AA4B003C_57B4564702F8_impl*
 inherited;
//#UC END# *46A5AA4B003C_57B4564702F8_impl*
end;//TmsmListView.Invalidate

constructor TmsmListView.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57B4564702F8_var*
//#UC END# *47D1602000C6_57B4564702F8_var*
begin
//#UC START# *47D1602000C6_57B4564702F8_impl*
 inherited;
 Self.BorderStyle := bsNone;
 Self.BevelInner := bvNone;
 Self.BevelOuter := bvNone;
 Self.Ctl3D := false;
 Self.OnGetItemImageIndex := Self.DoGetItemImageIndex;
 Self.OnQuickSearchStrChanged := Self.QuickSearchHandler;
//#UC END# *47D1602000C6_57B4564702F8_impl*
end;//TmsmListView.Create

function TmsmListView.DoDoDragOver(const aData: IDataObject;
 const aPoint: TPoint): Boolean;
//#UC START# *48BFA1300211_57B4564702F8_var*
//#UC END# *48BFA1300211_57B4564702F8_var*
begin
//#UC START# *48BFA1300211_57B4564702F8_impl*
 if (Model = nil) then
  Result := false
 else
  Result := Model.DragOver(aData, aPoint);
//#UC END# *48BFA1300211_57B4564702F8_impl*
end;//TmsmListView.DoDoDragOver

function TmsmListView.DoGetAcceptableFormats: Tl3ClipboardFormats;
//#UC START# *48BFB42C002A_57B4564702F8_var*
//#UC END# *48BFB42C002A_57B4564702F8_var*
begin
//#UC START# *48BFB42C002A_57B4564702F8_impl*
 if (Model <> nil) then
  Result := l3CatFormatArray(inherited DoGetAcceptableFormats,
   [{CF_TreeNodes, }CF_TreeNode])
 else
  Result := inherited DoGetAcceptableFormats;
//#UC END# *48BFB42C002A_57B4564702F8_impl*
end;//TmsmListView.DoGetAcceptableFormats

function TmsmListView.DoDoDrop(aFormat: Tl3ClipboardFormat;
 const aMedium: Tl3StoragePlace;
 var dwEffect: Integer): Boolean;
//#UC START# *48BFB6D800B3_57B4564702F8_var*
//#UC END# *48BFB6D800B3_57B4564702F8_var*
begin
//#UC START# *48BFB6D800B3_57B4564702F8_impl*
 if (Model <> nil) then
 begin
  (*l_Pt.GetCursorPos;
  l_Pt.Convert(ScreenToClient);*)
  //Result := Model.Drop(aFormat, aMedium, dwEffect, l_Pt.Add(f_Origin));
  Result := Model.Drop(aFormat, aMedium, dwEffect, l3SPoint(0, 0));
  if Result then
   if CanFocus then
    SetFocus;
 end//Model <> nil
 else
  Result := inherited DoDoDrop(aFormat, aMedium, dwEffect);
//#UC END# *48BFB6D800B3_57B4564702F8_impl*
end;//TmsmListView.DoDoDrop

function TmsmListView.pm_GetTotal: LongInt;
//#UC START# *514C89A601FE_57B4564702F8get_var*
//#UC END# *514C89A601FE_57B4564702F8get_var*
begin
//#UC START# *514C89A601FE_57B4564702F8get_impl*
 if Assigned(OnGetTotal) then
  if (Parent <> nil) then
   if Self.HandleAllocated then
    if (f_LockTotal <= 0) AND not InUpdating then
     OnGetTotal(Self);
 Result := inherited pm_GetTotal;
//#UC END# *514C89A601FE_57B4564702F8get_impl*
end;//TmsmListView.pm_GetTotal

procedure TmsmListView.pm_SetTotal(aValue: LongInt);
//#UC START# *514C89A601FE_57B4564702F8set_var*
//#UC END# *514C89A601FE_57B4564702F8set_var*
begin
//#UC START# *514C89A601FE_57B4564702F8set_impl*
 inherited;
//#UC END# *514C89A601FE_57B4564702F8set_impl*
end;//TmsmListView.pm_SetTotal

function TmsmListView.GetDragAndDropSupported: Boolean;
//#UC START# *5152C16A028F_57B4564702F8_var*
//#UC END# *5152C16A028F_57B4564702F8_var*
begin
//#UC START# *5152C16A028F_57B4564702F8_impl*
 Result := true;
//#UC END# *5152C16A028F_57B4564702F8_impl*
end;//TmsmListView.GetDragAndDropSupported

procedure TmsmListView.TryDragAndDrop(aNodeIndex: Integer;
 aKey: Integer);
//#UC START# *5152C18C00BA_57B4564702F8_var*

 function MakeDraggingText(const aNode: Il3SimpleNode): Il3CString;
 begin//MakeDraggingText
(*  if (SelectedCount > 1) then
   Result := l3Fmt(str_nsc_MultiSelectDraggingText.AsCStr, [SelectedCount])
  else*)
   Result := l3CStr(aNode.Text);
 end;//MakeDraggingText

 function GetNode(aNodeIndex: Integer): Il3SimpleNode;
 begin//GetNode
  Result := nil;
  if Assigned(f_OnGetNode) then
   f_OnGetNode(Self, aNodeIndex, Result);
 end;//GetNode

var
 l_Bitmap     : Tl3BitmapContainer;
 l_Node       : Il3SimpleNode;

  {$IfNDef DesignTimeLibrary}
  function lp_MakeDataObject: IDataObject;
  begin
(*   Result := TreeStruct.MakeDataObject(l_Node, l_Bitmap);
   if Result = nil then*)
    Result := DataObjectClass.Make(l_Node, l_Bitmap);
  end;//lp_MakeDataObject
  {$EndIf  DesignTimeLibrary}

var
 l_Rect       : TRect;
 l_DnDCaption : Il3CString;

  function lp_CalcRect(const aCanvas: Il3Canvas): TRect;
  begin
   Result := l_Rect;
    // - размер рамки у элемента дерева;
   with aCanvas do
    if MultiStrokeItem then
     DrawText(l_DnDCaption.AsWStr, Result, DT_WORDBREAK or DT_CALCRECT)
    else
    begin
     DrawText(l_DnDCaption.AsWStr, Result, DT_SINGLELINE or DT_CALCRECT);
     // Если прямоугольник получился длинее чем элемент дерева, то корректируем
     // его:
     if Result.Right > l_Rect.Right then
      Result.Right := l_Rect.Right;
    end;//if MultiStrokeItem then
  end;//lp_CalcRect

const
 cTextIndent = 15;
  // - отступ при выводе текста.
var
 l_dwOkEffect : Longint;
 l_dwEffect   : Longint;
 l_R          : Tl3SRect;
 l_DO         : IDataObject;
//#UC END# *5152C18C00BA_57B4564702F8_var*
begin
//#UC START# *5152C18C00BA_57B4564702F8_impl*
 l_Node := GetNode(aNodeIndex);
 if (l_Node <> nil) then
 try
  if Assigned(f_OnCanBeginDrag) then
  begin
   l_dwOkEffect := DROPEFFECT_COPY or DROPEFFECT_MOVE;
   f_OnCanBeginDrag(l_Node, l_dwOkEffect);
   if (l_dwOkEffect = DROPEFFECT_NONE) then
    Exit;
  end//Assigned(f_OnCanBeginDrag)
  else
   if l_Node.CanMove then
    l_dwOkEffect := DROPEFFECT_COPY or DROPEFFECT_MOVE
   else
    l_dwOkEffect := DROPEFFECT_COPY;
  inherited TryDragAndDrop(aNodeIndex, aKey);
  {$IfNDef DesignTimeLibrary}
  l_DnDCaption := MakeDraggingText(l_Node);
  l_Bitmap := Tl3BitmapContainer.Create; // Создаем растр
  try
   with l_Bitmap do
   begin
    Bitmap.PixelFormat := pf24bit;
    l_Rect := GetDrawTextRect(Current);//GetDrawTextRect
    with Canvas do
    begin
     BeginPaint;
     try
      with Font do
      begin
       ForeColor := clRed;
       BackColor := clWindow;
      end;//with Font do
      DrawEnabled := true;
      // Определим размер выводимой подписи:
      l_Rect := lp_CalcRect(l_Bitmap.Canvas);
      // Добавим пространства для рамки:
      InflateRect(l_Rect, 1, 1);
      // Установим размер изображения:
      Width := l_Rect.Right - l_Rect.Left + 1 + cTextIndent;
      Height := l_Rect.Bottom - l_Rect.Top + 1;
      // Рамка:
      l_R := l3SRect(cTextIndent, 0, l_Bitmap.Width, l_Bitmap.Height);
       // - смещение рамки с текстом относительно курсора;
      DrawFocusRect(l_R);
      Brush.Style := bsClear;
      // Текст:
      l_R.Inflate1(-1);
      ClipRect := DR2LR(l_R);
      if MultiStrokeItem then
       DrawText(l_DnDCaption.AsWStr, TRect(l_R), DT_WORDBREAK)
      else
       DrawText(l_DnDCaption.AsWStr, TRect(l_R), DT_SINGLELINE);
     finally
      EndPaint;
     end;//try..finally
    end;//with Canvas
   end;//with l_Bitmap
   l_DO := lp_MakeDataObject;
   try
    DoDragDrop(l_DO, l_dwOkEffect, l_dwEffect);
   finally
    l_DO := nil;
   end;//try..finally
  finally
   l3Free(l_Bitmap);
  end;//try..finally
  {$EndIf  DesignTimeLibrary}
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *5152C18C00BA_57B4564702F8_impl*
end;//TmsmListView.TryDragAndDrop

procedure TmsmListView.ClearFields;
begin
 Model := nil;
 inherited;
end;//TmsmListView.ClearFields

//#UC START# *57B4564702F8impl*
{$IfNDef DesignTimeLibrary}
function TmsmListView.DataObjectClass: RvtNodeDataObject;
  //virtual;
  {-}
begin
 Result := TevNodeData;
end;
{$EndIf DesignTimeLibrary}
//#UC END# *57B4564702F8impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmListView);
 {* Регистрация TmsmListView }
{$IfEnd} // NOT Defined(NoScripts)

end.
