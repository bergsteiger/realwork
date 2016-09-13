unit msmDrawing;

// Модуль: "w:\common\components\gui\Garant\msm\msmDrawing.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TmsmDrawing" MUID: (57D00ACC01B0)

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
 TmsmDrawing = class(TafwControl, ImsmEventsSubscriber)
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
 end;//TmsmDrawing

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
 //#UC END# *57D00ACC01B0impl_uses*
;

procedure TmsmDrawing.pm_SetModel(const aValue: ImsmDrawingModel);
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
end;//TmsmDrawing.pm_SetModel

procedure TmsmDrawing.ModelStateChanged;
//#UC START# *57D0199B00F9_57D00ACC01B0_var*
//#UC END# *57D0199B00F9_57D00ACC01B0_var*
begin
//#UC START# *57D0199B00F9_57D00ACC01B0_impl*
 if Self.HandleAllocated then
  Self.Invalidate;
//#UC END# *57D0199B00F9_57D00ACC01B0_impl*
end;//TmsmDrawing.ModelStateChanged

procedure TmsmDrawing.Fire(anEvent: TmsmEvent);
//#UC START# *57AD8E570241_57D00ACC01B0_var*
//#UC END# *57AD8E570241_57D00ACC01B0_var*
begin
//#UC START# *57AD8E570241_57D00ACC01B0_impl*
 if (anEvent = ListChangedEvent.Instance) then
  ModelStateChanged
 else
 if (anEvent = CurrentElementChangedEvent.Instance) then
  ModelStateChanged;
//#UC END# *57AD8E570241_57D00ACC01B0_impl*
end;//TmsmDrawing.Fire

procedure TmsmDrawing.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D00ACC01B0_var*
//#UC END# *479731C50290_57D00ACC01B0_var*
begin
//#UC START# *479731C50290_57D00ACC01B0_impl*
 Model := nil;
 inherited;
//#UC END# *479731C50290_57D00ACC01B0_impl*
end;//TmsmDrawing.Cleanup

constructor TmsmDrawing.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57D00ACC01B0_var*
//#UC END# *47D1602000C6_57D00ACC01B0_var*
begin
//#UC START# *47D1602000C6_57D00ACC01B0_impl*
 inherited;
 ScrollStyle := ssBoth;
//#UC END# *47D1602000C6_57D00ACC01B0_impl*
end;//TmsmDrawing.Create

procedure TmsmDrawing.Paint(const CN: Il3Canvas);
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

var
 l_TextColor : TColor;
 l_FillColor : TColor;

 procedure DrawElement(const anElement: ImsmModelElement;
                       const aRect: Tl3SRect;
                       const aCurrentElement: ImsmModelElement);

  procedure DrawSelection(const aRect: Tl3SRect);
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
  if anElement.IsSameElement(aCurrentElement) then
   DrawSelection(aRect);
 end;//DrawElement

 procedure DrawLink(const anElement: ImsmModelElement);

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
  l_From : ImsmModelElement;
  l_To : ImsmModelElement;
  l_FromR : Tl3SRect;
  l_ToR : Tl3SRect;
  l_FromP : Tl3SPoint;
  l_ToP : Tl3SPoint;
  l_ClipRgn : HRGN;
  l_RectRgn : HRGN;
  l_N : Il3CString;
  l_TextRect : Tl3SRect;
  l_WR : TRect;
  l_Flags : Word;
  l_BkMode: Cardinal;
 begin//DrawLink
  l_From := anElement.ElementProp['From'];
  l_To := anElement.ElementProp['To'];
  if (l_From <> nil) AND (l_To <> nil) then
  begin
   l_FromR := ElementRect(l_From);
   l_ToR := ElementRect(l_To);
   l_FromP.X := (l_FromR.Left + l_FromR.Right) div 2;
   l_FromP.Y := (l_FromR.Top + l_FromR.Bottom) div 2;
   l_ToP.X := (l_ToR.Left + l_ToR.Right) div 2;
   l_ToP.Y := (l_ToR.Top + l_ToR.Bottom) div 2;
   l_PenColor := anElement.IntProp['msm:View:LinkLineColor'];
   if (l_PenColor = clDefault) then
    l_PenColor := clSilver;
   SetPen;
   with CN.LR2DR(CN.ClipRect) do
   begin
    l_ClipRgn := CreateRectRgn(Left, Top, Right, Bottom);
   end;//with CN.LR2DR(CN.ClipRect)
   try
    l_RectRgn := CreateRectRgn(l_FromR.Left, l_FromR.Top, l_FromR.Right, l_FromR.Bottom);
    try
     CombineRgn(l_ClipRgn, l_ClipRgn, l_RectRgn, RGN_DIFF);
    finally
     DeleteObject(l_RectRgn);
    end;//try..finally
    l_RectRgn := CreateRectRgn(l_ToR.Left, l_ToR.Top, l_ToR.Right, l_ToR.Bottom);
    try
     CombineRgn(l_ClipRgn, l_ClipRgn, l_RectRgn, RGN_DIFF);
    finally
     DeleteObject(l_RectRgn);
    end;//try..finally
    CN.PushClipRect;
    try
     SelectClipRgn(CN.DC, l_ClipRgn);
     CN.Canvas.MoveTo(l_FromP.X, l_FromP.Y);
     CN.Canvas.LineTo(l_ToP.X, l_ToP.Y);
    finally
     CN.PopClipRect;
    end;//try..finally
   finally
    DeleteObject(l_ClipRgn);
   end;//try..finally
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
  end;//(l_From <> nil) AND (l_To <> nil)
 end;//DrawLink

 procedure FillEmpty;
 begin//FillEmpty
  CN.Font.BackColor := clWhite;
  CN.FillEmptyRect(CN.LR2DR(CN.ClipRect));
 end;//FillEmpty

var
 l_List : ImsmModelElementStringList;
 l_E : ImsmModelElement;
 l_Current : ImsmModelElement;
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
   l_Current := Model.CurrentElement;
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
     DrawElement(l_E, ElementRect(l_E), l_Current);
    end;//l_E <> nil
   end;//for l_Index
   FillEmpty;
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_E := l_List[l_Index];
    if (l_E <> nil) AND not l_E.IsView then
     DrawLink(l_E);
   end;//for l_Index
   Exit;
  end;//l_List <> nil
 end;//Model <> nil
 FillEmpty;
//#UC END# *48C6C044025E_57D00ACC01B0_impl*
end;//TmsmDrawing.Paint

{$If NOT Defined(NoVCL)}
procedure TmsmDrawing.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_57D00ACC01B0_var*
//#UC END# *48E22B250241_57D00ACC01B0_var*
begin
//#UC START# *48E22B250241_57D00ACC01B0_impl*
 inherited;
//#UC END# *48E22B250241_57D00ACC01B0_impl*
end;//TmsmDrawing.MouseMove
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmDrawing.CreateWnd;
//#UC START# *4CC8414403B8_57D00ACC01B0_var*
//#UC END# *4CC8414403B8_57D00ACC01B0_var*
begin
//#UC START# *4CC8414403B8_57D00ACC01B0_impl*
 inherited;
 Self.SetScrollInfo;
//#UC END# *4CC8414403B8_57D00ACC01B0_impl*
end;//TmsmDrawing.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmDrawing.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_57D00ACC01B0_var*
//#UC END# *4E7896270076_57D00ACC01B0_var*
begin
//#UC START# *4E7896270076_57D00ACC01B0_impl*
 inherited;
 if (Model = nil) then
  Exit;
 Case Button of
  mbLeft:
   if MilliSecondsBetween(Now, f_DoubleClickMoment) > 100 then
    Model.CurrentElement := ElementOnPointOrParent(l3SPoint(X, Y));
 end;//Case Button
//#UC END# *4E7896270076_57D00ACC01B0_impl*
end;//TmsmDrawing.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TmsmDrawing.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_57D00ACC01B0_var*
var
 l_LeftButton : Byte;
 l_E : ImsmModelElement;
 l_Pt : Tl3SPoint;
 l_NewPt : Tl3SPoint;
 l_ElementOrigin : Tl3SPoint;
 l_ElementNewOrigin : Tl3SPoint;
//#UC END# *4F88473B03CD_57D00ACC01B0_var*
begin
//#UC START# *4F88473B03CD_57D00ACC01B0_impl*
 inherited;
 if (Model = nil) then
  Exit;
 Case Button of
  mbLeft:
   if (ssDouble in Shift) then
   begin
    f_DoubleClickMoment := Now;
    Model.ElementToAction := ElementOnPointOrParent(l3SPoint(X, Y));
   end//ssDouble in Shift
   else
   begin
    l_Pt := l3SPoint(X, Y);
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
      l_ElementOrigin := Self.ElementRect(l_E).TopLeft;
      repeat
       l_NewPt.GetCursorPos;
       l_NewPt.Convert(ScreenToClient);
       if not l_Pt.EQ(l_NewPt) then
       begin
        l_ElementNewOrigin := l_ElementOrigin.Add(l_NewPt.Sub(l_Pt)).Add(f_Origin);
        l_E.IntProp['msm:View:X'] := l_ElementNewOrigin.X;
        l_E.IntProp['msm:View:Y'] := l_ElementNewOrigin.Y;
        l_ElementOrigin := l_ElementNewOrigin.Sub(f_Origin);
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
  mbRight:
   Model.CurrentElement := ElementOnPointOrParent(l3SPoint(X, Y));
 end;//Case Button
//#UC END# *4F88473B03CD_57D00ACC01B0_impl*
end;//TmsmDrawing.MouseDown
{$IfEnd} // NOT Defined(NoVCL)

procedure TmsmDrawing.ClearFields;
begin
 Model := nil;
 inherited;
end;//TmsmDrawing.ClearFields

//#UC START# *57D00ACC01B0impl*

function TmsmDrawing.ElementRect(const anElement: ImsmModelElement): Tl3SRect;
var
 l_X : Integer;
 l_Y : Integer;
 l_W : Integer;
 l_H : Integer;
begin
 l_X := anElement.IntProp['msm:View:X'];
 l_Y := anElement.IntProp['msm:View:Y'];
 l_W := 120;
 l_H := 100;
 Result := l3SBounds(l_X, l_Y, l_W, l_H);
 Result.Inflate1(-10);
 Result := Result.SubPt(f_Origin);
end;

function TmsmDrawing.ElementOnPoint(const aPoint: Tl3SPoint): ImsmModelElement;
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
    if ElementRect(l_E).ContainsPt(aPoint) then
    begin
     Result := l_E;
     Exit;
    end;//ElementRect(l_E).ContainsPt(aPoint)
   end;//for l_Index
  end;//l_List <> nil
 end;//Model <> nil
end;

function TmsmDrawing.ElementOnPointOrParent(const aPoint: Tl3SPoint): ImsmModelElement;
begin
 Result := ElementOnPoint(aPoint);
 if (Result = nil) then
  if (Model <> nil) then
   if (Model.List <> nil) then
    Result := Model.List.Owner.Parent;
    //Result := Model.List.Owner;
end;

procedure TmsmDrawing.WMMouseActivate(var Msg: TWMMouseActivate);
begin
 if csDesigning in ComponentState then
  Exit;
 inherited;
 if CanFocus then
  SetFocus;
end;//TmsmDrawing.WMMouseActivate

procedure TmsmDrawing.WMSetFocus(var Msg: TWMSetFocus);
begin
 inherited;
 Invalidate;
end;

procedure TmsmDrawing.WMKillFocus(var Msg: TWMKillFocus);
begin
 inherited;
 Invalidate;
end;

procedure TmsmDrawing.ScrollBy(const aDelta: Tl3SPoint);
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

procedure TmsmDrawing.WMHScroll(var Msg: TWMHScroll);
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

procedure TmsmDrawing.WMVScroll(var Msg: TWMVScroll);
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

procedure TmsmDrawing.WndProc(var Message: TMessage);
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

procedure TmsmDrawing.WMSize(var Msg: TWMSize);
begin
 inherited;
 Self.SetScrollInfo;
end;

procedure TmsmDrawing.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
  {-}
begin
 Msg.Result := 1;  {don't erase background}
end;

procedure TmsmDrawing.SetScrollInfo;
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
 TtfwClassRef.Register(TmsmDrawing);
 {* Регистрация TmsmDrawing }
{$IfEnd} // NOT Defined(NoScripts)

end.
