unit msmDrawingView;

// Модуль: "w:\common\components\gui\Garant\msm\msmDrawingView.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TmsmDrawingView" MUID: (57D00ACC01B0)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , afwControl
 , msmEvents
 , msmConcreteModels
 , Classes
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *57D00ACC01B0intf_uses*
 , Messages
 , l3Units
 , msmModelElements
 //#UC END# *57D00ACC01B0intf_uses*
;

type
 //#UC START# *57D00ACC01B0ci*
 //#UC END# *57D00ACC01B0ci*
 //#UC START# *57D00ACC01B0cit*
 //#UC END# *57D00ACC01B0cit*
 TmsmDrawingView = class(TafwControl, ImsmEventsSubscriber)
  private
   f_Model: ImsmDrawingModel;
  protected
   procedure pm_SetModel(const aValue: ImsmDrawingModel);
   procedure ModelStateChanged;
   procedure Fire(anEvent: TmsmEvent);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   {$If NOT Defined(NoVCL)}
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure ClearFields; override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property Model: ImsmDrawingModel
    read f_Model
    write pm_SetModel;
 //#UC START# *57D00ACC01B0publ*
  private
   f_Origin : Tl3SPoint;
   f_DoubleClickMoment : TDateTime;
   f_DisableUpSelect : Boolean;
  private
   function ElementRect(const anElement: ImsmModelElement): Tl3SRect;
   function ElementOnPoint(const aPoint: Tl3SPoint): ImsmModelElement;
   function ElementOnPointOrParent(const aPoint: Tl3SPoint): ImsmModelElement;
   procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
   procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
   procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
   procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
   procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
   procedure WndProc(var Message: TMessage); override;
   procedure WMSize(var Msg: TWMSize); message WM_SIZE;
   procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_ERASEBKGND;
   procedure SetScrollInfo;
   procedure ScrollBy(const aDelta: Tl3SPoint);
 //#UC END# *57D00ACC01B0publ*
 end;//TmsmDrawingView

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57D00ACC01B0impl_uses*
 , Windows
 , SysUtils
 , DateUtils
 , StdCtrls
 , Graphics
 , l3Interfaces
 , l3String
 , l3Bits
 , l3MinMax
 , l3Base
 , msmElementViews
 , msmLineF
 , msmDrawArrow
 //#UC END# *57D00ACC01B0impl_uses*
;

procedure TmsmDrawingView.pm_SetModel(const aValue: ImsmDrawingModel);
//#UC START# *57D00B180365_57D00ACC01B0set_var*
//#UC END# *57D00B180365_57D00ACC01B0set_var*
begin
//#UC START# *57D00B180365_57D00ACC01B0set_impl*
 if (f_Model <> aValue) then
 begin
  if (f_Model <> nil) then
   f_Model.As_ImsmEventsPublisher.Unsubscribe(Self);
  f_Model := aValue;
  if (f_Model <> nil) then
   f_Model.As_ImsmEventsPublisher.Subscribe(Self);
  ModelStateChanged;
 end;//f_Model <> aValue
//#UC END# *57D00B180365_57D00ACC01B0set_impl*
end;//TmsmDrawingView.pm_SetModel

procedure TmsmDrawingView.ModelStateChanged;
//#UC START# *57D0199B00F9_57D00ACC01B0_var*
//#UC END# *57D0199B00F9_57D00ACC01B0_var*
begin
//#UC START# *57D0199B00F9_57D00ACC01B0_impl*
 if Self.HandleAllocated then
  Self.Invalidate;
//#UC END# *57D0199B00F9_57D00ACC01B0_impl*
end;//TmsmDrawingView.ModelStateChanged

procedure TmsmDrawingView.Fire(anEvent: TmsmEvent);
//#UC START# *57AD8E570241_57D00ACC01B0_var*
//#UC END# *57AD8E570241_57D00ACC01B0_var*
begin
//#UC START# *57AD8E570241_57D00ACC01B0_impl*
 if (anEvent = ListChangedEvent.Instance) then
  ModelStateChanged
 else
 if (anEvent = ListContentChangedEvent.Instance) then
  ModelStateChanged
 else
 if (anEvent = CurrentElementChangedEvent.Instance) then
  ModelStateChanged
 else
 if (anEvent = SelectionChangedEvent.Instance) then
  ModelStateChanged;
//#UC END# *57AD8E570241_57D00ACC01B0_impl*
end;//TmsmDrawingView.Fire

procedure TmsmDrawingView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D00ACC01B0_var*
//#UC END# *479731C50290_57D00ACC01B0_var*
begin
//#UC START# *479731C50290_57D00ACC01B0_impl*
 Model := nil;
 inherited;
//#UC END# *479731C50290_57D00ACC01B0_impl*
end;//TmsmDrawingView.Cleanup

constructor TmsmDrawingView.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57D00ACC01B0_var*
//#UC END# *47D1602000C6_57D00ACC01B0_var*
begin
//#UC START# *47D1602000C6_57D00ACC01B0_impl*
 inherited;
 ScrollStyle := ssBoth;
//#UC END# *47D1602000C6_57D00ACC01B0_impl*
end;//TmsmDrawingView.Create

procedure TmsmDrawingView.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_57D00ACC01B0_var*

 function FontName: AnsiString;
 begin//FontName
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
   if (Win32MajorVersion >= 6) then
   // - Vista
    Result := 'Segoe UI'
   else
    Result := 'Arial';
  end//Win32Platform = VER_PLATFORM_WIN32_NT
  else
   Result := 'Arial';
 end;//FontName

const
 cPtExtent = 3 * 2;

 procedure DrawPoint(const aPoint: Tl3SPoint);
 var
  l_Rect : Tl3SRect;
 begin//DrawPoint
  l_Rect := l3SRectBnd(aPoint, l3SPoint(cPtExtent, cPtExtent));
  if Focused then
   CN.Font.BackColor := clBlack
  else
   CN.Font.BackColor := clSilver;
  CN.FillRect(l_Rect);
 end;//DrawPoint
 
var
 l_TextColor : TColor;
 l_FillColor : TColor;

 procedure DrawElement(const anElement: ImsmModelElement;
                       const aRect: Tl3SRect;
                       const aSelection: ImsmElementSelection);

  procedure DrawSelection(const aRect: Tl3SRect);

  begin//DrawSelection
   DrawPoint(aRect.TopLeft.Add(l3SPoint(-cPtExtent, -cPtExtent)));
   DrawPoint(l3SPoint(aRect.Left - cPtExtent, aRect.Bottom));
   DrawPoint(aRect.BottomRight);
   DrawPoint(l3SPoint(aRect.Right, aRect.Top - cPtExtent));
  end;//DrawSelection

  procedure SetBrush;
  begin//SetBrush
   CN.Font.ForeColor := l_TextColor;
   CN.Font.BackColor := l_FillColor;
  end;//SetBrush

 var
  l_PenColor : TColor;

  procedure SetPen;
  begin//SetPen
   CN.Canvas.Pen.Width := 2;
   CN.Canvas.Pen.Color := l_PenColor;
   CN.Canvas.Brush.Color := l_PenColor;
   CN.Canvas.Pen.Style := psSolid;
  end;//SetPen

 const
  cCornerHeight = 20;
 var
  l_Rect : Tl3SRect;
  l_TextRect : Tl3SRect;
  l_WR : TRect;
  l_N : Il3CString;
  l_IsCategory : Boolean;
 begin//DrawElement
  CN.SWindowOrg := l3SPoint(0, 0);
  l_Rect := aRect;
  SetBrush;
  l_IsCategory := anElement.BoolProp['IsCategory'];
  l_PenColor := clBlack;
  if l_IsCategory then
  begin
   l_Rect.Right := l_Rect.Left + (l_Rect.Right - l_Rect.Left) div 3;
   l_Rect.Bottom := l_Rect.Top + cCornerHeight;
   CN.FillRect(l_Rect);
   SetPen;
   CN.Canvas.FrameRect(l_Rect.R.WR);
   l_Rect := aRect;
   l_Rect.Top := l_Rect.Top + cCornerHeight - 1;
   SetBrush;
  end//l_IsCategory
  else
  begin
   if anElement.BoolProp['HasMainDiagram'] then
    l_PenColor := clRed;
  end;//l_IsCategory
  CN.FillRect(l_Rect);

  CN.Font.Name := FontName;
  CN.Font.Size := 8;
  CN.Font.Bold := false;
  CN.Font.Italic := false;
  SetBrush;
  l_TextRect := l_Rect;
  l_TextRect.Inflate1(-3);
  l_N := anElement.StringProp['StereotypeName'];
  if not l3IsNil(l_N) then
  begin
   CN.PushClipRect;
   try
    CN.ClipRect := CN.DR2LR(l_TextRect);
    l_WR := l_TextRect.R.WR;
    CN.DrawText(l3PCharLen(l_N), l_WR, DT_CENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
    l_TextRect.Top := l_TextRect.Top + CN.LP2DP(CN.TextExtent(l3PCharLen(l_N))).Y + 3;
   finally
    CN.PopClipRect;
   end;//try..finally
  end;//not l3IsNil(l_N)
  l_N := anElement.StringProp['Signature'];
  CN.PushClipRect;
  try
   CN.Font.Bold := anElement.BoolProp['IsFinal'];
   CN.Font.Italic := anElement.BoolProp['IsAbstract'];
   l_WR := l_TextRect.R.WR;
   CN.DrawText(l3PCharLen(l_N), l_WR, DT_CALCRECT or DT_CENTER or DT_WORDBREAK or DT_END_ELLIPSIS);
   if (l_WR.Bottom > l_TextRect.Bottom) then
   begin
    CN.Font.BackColor := clWhite;
    CN.FillEmptyRect(l3SRect(l_TextRect.Left, l_TextRect.Bottom, l_TextRect.Right, l_WR.Bottom));
    SetBrush;
   end;//l_WR.Bottom > l_TextRect.Bottom
   CN.ClipRect := CN.DR2LR(l_TextRect);
   l_WR := l_TextRect.R.WR;
   CN.DrawText(l3PCharLen(l_N), l_WR, DT_CENTER or DT_WORDBREAK or DT_END_ELLIPSIS);
  finally
   CN.PopClipRect;
  end;//try..finally

  SetPen;
  CN.Canvas.FrameRect(l_Rect.R.WR);
  if aSelection.IsElementSelectedOrCurrent(anElement) then
   DrawSelection(aRect);
 end;//DrawElement

 procedure DrawLink(const anElement: ImsmModelElement;
                    const aRect: Tl3SRect;
                    const aSelection: ImsmElementSelection);

  procedure SetBrush;
  begin//SetBrush
   CN.Font.ForeColor := clBlack;
   CN.Font.BackColor := clWhite;
  end;//SetBrush

 var
  l_PenColor : TColor;
   
  procedure SetPen;
  begin//SetPen
   CN.Canvas.Pen.Width := 1{2};
   CN.Canvas.Pen.Color := l_PenColor{clBlack};
   CN.Canvas.Brush.Color := clWhite{clBlack};
   CN.Canvas.Pen.Style := TPenStyle(anElement.IntProp['msm:View:LinkLineStyle']){psDash};
  end;//SetPen

 var
  l_FromP : Tl3SPoint;
  l_ToP : Tl3SPoint;
  l_N : Il3CString;
  l_TextRect : Tl3SRect;
  l_WR : TRect;
  l_Flags : Word;
  l_BkMode: Cardinal;
 begin//DrawLink
  l_FromP := aRect.TopLeft;
  l_ToP := aRect.BottomRight;
  if aSelection.IsElementSelectedOrCurrent(anElement) then
   l_PenColor := clRed
  else
   l_PenColor := anElement.IntProp['msm:View:LinkLineColor'];

  if (l_PenColor = clDefault) then
   l_PenColor := clSilver;
  SetPen;
  CN.Canvas.MoveTo(l_FromP.X, l_FromP.Y);
  CN.Canvas.LineTo(l_ToP.X, l_ToP.Y);
  if not l_FromP.EQ(l_ToP) then
  begin
   CN.Canvas.Pen.Style := psSolid;
   DrawArrow(l_FromP, l_ToP, CN.Canvas, anElement.BoolProp['msm:View:LinkArrowIsPolygon']);
  end;//not l_FromP.EQ(l_ToP)
  l_N := anElement.StringProp['LinkName'];
  if not l3IsNil(l_N) then
  begin
   if (l_FromP.X < l_ToP.X) then
   begin
    l_TextRect.Left := l_FromP.X;
    l_TextRect.Right := l_ToP.X;
   end//l_FromP.X < l_ToP.X
   else
   begin
    l_TextRect.Right := l_FromP.X;
    l_TextRect.Left := l_ToP.X;
   end;//l_FromP.X < l_ToP.X

   if (l_FromP.Y < l_ToP.Y) then
   begin
    l_TextRect.Top := l_FromP.Y;
    l_TextRect.Bottom := l_ToP.Y;
   end//l_FromP.Y < l_ToP.Y
   else
   begin
    l_TextRect.Bottom := l_FromP.Y;
    l_TextRect.Top := l_ToP.Y;
   end;//l_FromP.Y < l_ToP.Y
   CN.Font.Name := FontName;
   CN.Font.Size := 7;
   CN.Font.Bold := false;
   CN.Font.Italic := false;
   SetBrush;
   l_WR := l_TextRect.R.WR;
   l_Flags := CN.etoFlags;
   CN.etoFlags := l_Flags AND not eto_Opaque;
   l_BkMode := SetBkMode(CN.DC, TRANSPARENT);
   try
    CN.DrawText(l3PCharLen(l_N), l_WR, DT_CENTER or DT_VCENTER or DT_SINGLELINE {or DT_END_ELLIPSIS});
   finally
    SetBkMode(CN.DC, l_BkMode);
   end;//try..finally
   CN.etoFlags := l_Flags;
  end;//not l3IsNil(l_N)

  if aSelection.IsElementSelectedOrCurrent(anElement) then
  begin
   DrawPoint(l_FromP.Add(l3SPoint(-cPtExtent div 2, -cPtExtent div 2)));
   DrawPoint(l_ToP.Add(l3SPoint(-cPtExtent div 2, -cPtExtent div 2)));
  end;//aSelection.IsElementSelectedOrCurrent(anElement)
 end;//DrawLink

 procedure FillEmpty;
 begin//FillEmpty
  CN.Font.BackColor := clWhite;
  CN.FillEmptyRect(CN.LR2DR(CN.ClipRect));
 end;//FillEmpty

var
 l_List : ImsmModelElementStringList;
 l_E : ImsmModelElement;
 l_Selection: ImsmElementSelection;
 l_Index : Integer;
//#UC END# *48C6C044025E_57D00ACC01B0_var*
begin
//#UC START# *48C6C044025E_57D00ACC01B0_impl*
 inherited;
 if (Model <> nil) then
 begin
  l_List := Model.List;
  if (l_List <> nil) then
  begin
   l_Selection := Model.Selection;
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_E := l_List[l_Index];
    if (l_E <> nil) AND l_E.IsView then
    begin
     l_TextColor := clBlack;
     l_FillColor := l_E.IntProp['msm:View:BackColor'];
     if (l_FillColor = clDefault) then
      l_FillColor := clYellow;
     if (l_FillColor = clRed)
        OR (l_FillColor = clNavy)
        OR (l_FillColor = clBlue)
        OR (l_FillColor = clGreen)
      then
      l_TextColor := clWhite;
     DrawElement(l_E, ElementRect(l_E), l_Selection);
    end;//l_E <> nil
   end;//for l_Index
   FillEmpty;
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_E := l_List[l_Index];
    if (l_E <> nil) AND not l_E.IsView then
     DrawLink(l_E, ElementRect(l_E), l_Selection);
   end;//for l_Index
   Exit;
  end;//l_List <> nil
 end;//Model <> nil
 FillEmpty;
//#UC END# *48C6C044025E_57D00ACC01B0_impl*
end;//TmsmDrawingView.Paint

{$If NOT Defined(NoVCL)}
procedure TmsmDrawingView.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_57D00ACC01B0_var*
//#UC END# *48E22B250241_57D00ACC01B0_var*
begin
//#UC START# *48E22B250241_57D00ACC01B0_impl*
 inherited;
//#UC END# *48E22B250241_57D00ACC01B0_impl*
end;//TmsmDrawingView.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmDrawingView.CreateWnd;
//#UC START# *4CC8414403B8_57D00ACC01B0_var*
//#UC END# *4CC8414403B8_57D00ACC01B0_var*
begin
//#UC START# *4CC8414403B8_57D00ACC01B0_impl*
 inherited;
 Self.SetScrollInfo;
//#UC END# *4CC8414403B8_57D00ACC01B0_impl*
end;//TmsmDrawingView.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmDrawingView.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_57D00ACC01B0_var*

 procedure SelectCurrent;
 begin//SelectCurrent
  Model.Selection.Clear;
  Model.CurrentElement := ElementOnPointOrParent(l3SPoint(X, Y));
 end;//SelectCurrent
 
var
 l_E : ImsmModelElement;
//#UC END# *4E7896270076_57D00ACC01B0_var*
begin
//#UC START# *4E7896270076_57D00ACC01B0_impl*
 inherited;
 if (Model = nil) then
  Exit;
 Case Button of
  mbLeft:
   if (MilliSecondsBetween(Now, f_DoubleClickMoment) > 100)
      AND not f_DisableUpSelect then
   begin
    if (ssCtrl in Shift) then
    begin
     l_E := ElementOnPoint(l3SPoint(X, Y));
     if (l_E <> nil) then
     begin
      Model.Selection.InvertElement(l_E);
     end//l_E <> nil
     {else
      SelectCurrent};
     // - не надо сбрасывать выделение при зажатом Ctrl, чтобы случайно не сбросить всё
     //   Если пользователь захочет, то он отпустит Ctrl и ткнёт. Тогда выделение снимется. 
    end//ssCtrl in Shift
    else
     SelectCurrent;
   end;//MilliSecondsBetween(Now, f_DoubleClickMoment) > 100
 end;//Case Button
//#UC END# *4E7896270076_57D00ACC01B0_impl*
end;//TmsmDrawingView.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmDrawingView.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_57D00ACC01B0_var*

var
 l_Pt : Tl3SPoint;
 l_NewPt : Tl3SPoint;
 
 function DoElement(const anElement: ImsmModelElement): Boolean;
 var
  l_ElementOrigin : Tl3SPoint;
  l_ElementNewOrigin : Tl3SPoint;
 begin//DoElement
  Result := true;
  if anElement.IsView then
  begin
   l_ElementOrigin := l3SPoint(anElement.IntProp['msm:View:X'],
                               anElement.IntProp['msm:View:Y']);
   l_ElementNewOrigin := l_ElementOrigin.Add(l_NewPt.Sub(l_Pt));
   anElement.IntProp['msm:View:X'] := l_ElementNewOrigin.X;
   anElement.IntProp['msm:View:Y'] := l_ElementNewOrigin.Y;
  end;//anElement.IsView
 end;//DoElement

var
 l_LeftButton : Byte;
 l_E : ImsmModelElement;
//#UC END# *4F88473B03CD_57D00ACC01B0_var*
begin
//#UC START# *4F88473B03CD_57D00ACC01B0_impl*
 inherited;
 if (Model = nil) then
  Exit;
 Case Button of
  mbLeft:
  begin
   if (ssDouble in Shift) then
   begin
    f_DoubleClickMoment := Now;
    f_DisableUpSelect := true;
    Model.Selection.Clear;
    Model.ElementToAction := ElementOnPointOrParent(l3SPoint(X, Y));
   end//ssDouble in Shift
   else
   begin
    f_DisableUpSelect := false;
    l_Pt.GetCursorPos;
    l_Pt.Convert(ScreenToClient);
    l_E := ElementOnPoint(l_Pt);
    if (l_E <> nil) then
    begin
     with l3System.Mouse do
     begin
      l_LeftButton := LeftButton;
      SetCapture(Self.Handle);
      // - activate capture
     end;//with l3System.Mouse
     try
      repeat
       l_NewPt.GetCursorPos;
       l_NewPt.Convert(ScreenToClient);
       if not l_Pt.EQ(l_NewPt) then
       begin
        f_DisableUpSelect := true;
        if Self.Model.Selection.IsElementSelectedOrCurrent(l_E) then
         Self.Model.Selection.ProcessSelectedF(L2ImsmElementSelectionProcessSelectedFAction(@DoElement))
        else
        begin
         Self.Model.Selection.Clear;
         Model.CurrentElement := l_E;
         DoElement(l_E);
        end;//Self.Model.Selection.IsElementSelectedOrCurrent(l_E)
        l_Pt := l_NewPt;
        Invalidate;
        Repaint;
       end;//not l_Pt.EQ(l_NewPt)
      until not l3System.Keyboard.AsyncKey[l_LeftButton].Down;
     finally
      l3System.Mouse.ReleaseCapture;
     end;//try..finally
    end//l_E <> nil
    else
    begin
     with l3System.Mouse do
     begin
      l_LeftButton := LeftButton;
      SetCapture(Self.Handle);
      // - activate capture
     end;//with l3System.Mouse
     try
      repeat
       l_NewPt.GetCursorPos;
       l_NewPt.Convert(ScreenToClient);
       if not l_Pt.EQ(l_NewPt) then
       begin
        f_DisableUpSelect := true;
        ScrollBy(l_NewPt.Sub(l_Pt).Neg);
        l_Pt := l_NewPt;
        Update;
       end;//not l_Pt.EQ(l_NewPt)
      until not l3System.Keyboard.AsyncKey[l_LeftButton].Down;
     finally
      l3System.Mouse.ReleaseCapture;
     end;//try..finally
    end;//l_E <> nil
   end;//ssDouble in Shift
  end;//mbLeft
  mbRight:
  begin
   Model.Selection.Clear;
   Model.CurrentElement := ElementOnPointOrParent(l3SPoint(X, Y));
  end;//mbRight
 end;//Case Button
//#UC END# *4F88473B03CD_57D00ACC01B0_impl*
end;//TmsmDrawingView.MouseDown
{$IfEnd} // NOT Defined(NoVCL)

procedure TmsmDrawingView.ClearFields;
begin
 Model := nil;
 inherited;
end;//TmsmDrawingView.ClearFields

//#UC START# *57D00ACC01B0impl*

function TmsmDrawingView.ElementRect(const anElement: ImsmModelElement): Tl3SRect;
var
 l_X : Integer;
 l_Y : Integer;
 l_W : Integer;
 l_H : Integer;
 l_From : ImsmModelElement;
 l_To : ImsmModelElement;
 l_ToR : Tl3SRect;
 l_FromR : Tl3SRect;
 l_FromP : Tl3SPoint;
 l_ToP : Tl3SPoint;
 l_Line : TmsLineF;
begin
 if anElement.IsView then
 begin
  l_X := anElement.IntProp['msm:View:X'];
  l_Y := anElement.IntProp['msm:View:Y'];
  l_W := anElement.IntProp['msm:View:Width'];
  l_H := anElement.IntProp['msm:View:Height'];
  Result := l3SBounds(l_X, l_Y, l_W, l_H);
  Result.Inflate1(-10);
  Result := Result.SubPt(f_Origin);
 end//anElement.IsView
 else
 begin
  l_From := anElement.ElementProp['msm:View:From'];
  l_To := anElement.ElementProp['msm:View:To'];
  if (l_From <> nil) AND (l_To <> nil) then
  begin
   l_FromR := ElementRect(l_From);
   l_ToR := ElementRect(l_To);
   l_FromP.X := (l_FromR.Left + l_FromR.Right) div 2;
   l_FromP.Y := (l_FromR.Top + l_FromR.Bottom) div 2;
   l_ToP.X := (l_ToR.Left + l_ToR.Right) div 2;
   l_ToP.Y := (l_ToR.Top + l_ToR.Bottom) div 2;

   l_Line := TmsLineF_Create(l_FromP, l_ToP);
   TmsRectF_Create(l_FromR).Cross(l_Line, l_FromP);
   TmsRectF_Create(l_ToR).Cross(l_Line, l_ToP);
   Result := l3SRect(l_FromP, l_ToP);
  end//(l_From <> nil) AND (l_To <> nil)
  else
   Result := l3SRect(0, 0, 0, 0);
 end;//anElement.IsView
end;

type
 TmsmLinePos =
     (LEFT,  RIGHT,  BEYOND,  BEHIND, BETWEEN, ORIGIN, DESTINATION);
//    СЛЕВА, СПРАВА, ВПЕРЕДИ, ПОЗАДИ, МЕЖДУ,   НАЧАЛО, КОНЕЦ

function SamePoint(const A: Tl3SPoint; const B: Tl3SPoint): Boolean;
const
 cEpsilon = 5;
begin
 Result := (Abs(A.X - B.X) <= cEpsilon) AND (Abs(A.Y - B.Y) <= cEpsilon);
end;

function ClassifyLinePos(const this: Tl3SPoint; const p0: Tl3SPoint; const p1: Tl3SPoint): TmsmLinePos; overload;
const
 cEpsilon = 2000;
var
 p2 : Tl3SPoint;
 a : Tl3SPoint;
 b : Tl3SPoint;
 sa : Pixel;
begin
  p2 := this;
  a := p1.Sub(p0);
  b := p2.Sub(p0);
  sa := a.x * b.y - b.x * a.y;
  if SamePoint(p0, p2) then
   Result := ORIGIN
  else
  if SamePoint(p1, p2) then
   Result := DESTINATION
  else
  if (sa > cEpsilon{0.0}) then
   Result := LEFT
  else
  if (sa < -cEpsilon{0.0}) then
   Result := RIGHT
  else  
  if ((a.x * b.x < 0.0) OR (a.y * b.y < 0.0)) then
   Result := BEHIND
  else
  if (a.length < b.length) then
   Result := BEYOND
  else
  if SamePoint(p0, p2) then
   Result := ORIGIN
  else
  if SamePoint(p1, p2) then
   Result := DESTINATION
  else
   Result := BETWEEN;
end;

function ClassifyLinePos(const this: Tl3SPoint; const aRect: Tl3SRect): TmsmLinePos; overload;
begin
 Result := ClassifyLinePos(this, aRect.TopLeft, aRect.BottomRight);
end;

function TmsmDrawingView.ElementOnPoint(const aPoint: Tl3SPoint): ImsmModelElement;
var
 l_List : ImsmModelElementStringList;
 l_E : ImsmModelElement;
 l_Index : Integer;
begin
 Result := nil;
 if (Model <> nil) then
 begin
  l_List := Model.List;
  if (l_List <> nil) then
  begin
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_E := l_List[l_Index];
    if (l_E <> nil) then
    begin
     if l_E.IsView then
     begin
      if ElementRect(l_E).ContainsPt(aPoint) then
      begin
       Result := l_E;
       Exit;
      end;//ElementRect(l_E).ContainsPt(aPoint)
     end//l_E.IsView
     else
     begin
      Case ClassifyLinePos(aPoint, ElementRect(l_E)) of
       BETWEEN,
       ORIGIN,
       DESTINATION:
       begin
        Result := l_E;
        Exit;
       end;//BETWEEN..
      end;//Case ClassifyLinePos
     end;//l_E.IsView
    end;//l_E <> nil
   end;//for l_Index
  end;//l_List <> nil
 end;//Model <> nil
end;

function TmsmDrawingView.ElementOnPointOrParent(const aPoint: Tl3SPoint): ImsmModelElement;
begin
 Result := ElementOnPoint(aPoint);
 if (Result = nil) then
  if (Model <> nil) then
   if (Model.List <> nil) then
    //Result := Model.List.Owner.Parent;
    Result := Model.List.Owner;
end;

procedure TmsmDrawingView.WMMouseActivate(var Msg: TWMMouseActivate);
begin
 if csDesigning in ComponentState then
  Exit;
 inherited;
 if CanFocus then
  SetFocus;
end;//TmsmDrawingView.WMMouseActivate

procedure TmsmDrawingView.WMSetFocus(var Msg: TWMSetFocus);
begin
 inherited;
 Invalidate;
end;

procedure TmsmDrawingView.WMKillFocus(var Msg: TWMKillFocus);
begin
 inherited;
 Invalidate;
end;

procedure TmsmDrawingView.ScrollBy(const aDelta: Tl3SPoint);
begin
 f_Origin := f_Origin.Add(aDelta);
 SetScrollPos(Self.Handle, SB_HORZ, Max(0, f_Origin.X), true);
 SetScrollPos(Self.Handle, SB_VERT, Max(0, f_Origin.Y), true);
 Windows.ScrollWindow(Self.Handle, -aDelta.X, -aDelta.Y, nil, nil);
end;

const
 cSmallDelta = 4;
 cWheelDelta = cSmallDelta * 10;

const
 SB_WheelUp   = SB_EndScroll + 1;
 SB_WheelDown = SB_WheelUp + 1;

procedure TmsmDrawingView.WMHScroll(var Msg: TWMHScroll);
var
 l_Delta : Integer;
 l_ScrollInfo : TScrollInfo;
begin
 inherited;
 l_Delta := 0;
 Case Msg.ScrollCode of
  SB_LINELEFT:
   l_Delta := -cSmallDelta;
  SB_LINERIGHT:
   l_Delta := +cSmallDelta;
  SB_PAGELEFT:
   l_Delta := -Self.Width div 3;
  SB_PAGERIGHT:
   l_Delta := +Self.Width div 3;
  SB_THUMBPOSITION,
  SB_THUMBTRACK :
  begin
   with l_ScrollInfo do
   begin
    cbSize := SizeOf(l_ScrollInfo);
    fMask := SIF_TrackPos;
   end;//with l_ScrollInfo
   GetScrollInfo(Handle, SB_Horz, l_ScrollInfo);
   l_Delta := l_ScrollInfo.nTrackPos - f_Origin.X;
  end;//SB_THUMBTRACK
  else
   Exit;
 end;//Case Msg.ScrollCode
 ScrollBy(l3SPoint(l_Delta, 0));
end;

procedure TmsmDrawingView.WMVScroll(var Msg: TWMVScroll);
var
 l_Delta : Integer;
 l_ScrollInfo : TScrollInfo;
begin
 inherited;
 l_Delta := 0;
 Case Msg.ScrollCode of
  SB_LINEUP:
   l_Delta := -cSmallDelta;
  SB_LINEDOWN:
   l_Delta := +cSmallDelta;
  SB_PAGEUP:
   l_Delta := -Self.Height div 3;
  SB_PAGEDOWN:
   l_Delta := +Self.Height div 3;
  SB_THUMBPOSITION,
  SB_THUMBTRACK :
  begin
   with l_ScrollInfo do
   begin
    cbSize := SizeOf(l_ScrollInfo);
    fMask := SIF_TrackPos;
   end;//with l_ScrollInfo
   GetScrollInfo(Handle, SB_Vert, l_ScrollInfo);
   l_Delta := l_ScrollInfo.nTrackPos - f_Origin.Y;
  end;//SB_THUMBTRACK
  SB_WheelUp:
   l_Delta := -cWheelDelta;
  SB_WheelDown:
   l_Delta := +cWheelDelta;
  else
   Exit;
 end;//Case Msg.ScrollCode
 ScrollBy(l3SPoint(0, l_Delta));
end;

procedure TmsmDrawingView.WndProc(var Message: TMessage);
  {override;}
  {-}
begin
 if (Cardinal(Message.Msg) = WM_MOUSEWHEEL) then
 begin
  if l3TestBit(Longint(Message.wParam), 31) then
   Perform(WM_VScroll, SB_WheelDown, 0)
  else
   Perform(WM_VScroll, SB_WheelUp, 0);
 end//Cardinal(Message.Msg) = WM_MOUSEWHEEL
 else
  inherited;
end;

procedure TmsmDrawingView.WMSize(var Msg: TWMSize);
begin
 inherited;
 Self.SetScrollInfo;
end;

procedure TmsmDrawingView.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
  {-}
begin
 Msg.Result := 1;  {don't erase background}
end;

procedure TmsmDrawingView.SetScrollInfo;
var
 l_ScrollInfo : TScrollInfo;
begin
 l3FillChar(l_ScrollInfo, SizeOf(l_ScrollInfo), 0);
 with l_ScrollInfo do
 begin
  cbSize := SizeOf(l_ScrollInfo);
  fMask := SIF_PAGE or SIF_RANGE or SIF_POS;
  nPos := f_Origin.X;
  nMin := 0;
  nMax := Self.Width * 10;
  nPage := Self.Width div 3;
 end;//with l_ScrollInfo
 Windows.SetScrollInfo(Handle, SB_Horz, l_ScrollInfo, true);
 with l_ScrollInfo do
 begin
  cbSize := SizeOf(l_ScrollInfo);
  fMask := SIF_PAGE or SIF_RANGE or SIF_POS;
  nPos := f_Origin.Y;
  nMin := 0;
  nMax := Self.Height * 10;
  nPage := Self.Height div 3;
 end;//with l_ScrollInfo
 Windows.SetScrollInfo(Handle, SB_Vert, l_ScrollInfo, true);
end;

//#UC END# *57D00ACC01B0impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmDrawingView);
 {* Регистрация TmsmDrawingView }
{$IfEnd} // NOT Defined(NoScripts)

end.
