{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dccbut;

interface

{$I dc.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, dcdreamLib, dcsystem, dcconsts, dcToolTip;

Type
  {$IFNDEF D3}
  TCustomForm=TForm;
  {$ENDIF}

  TDCCaptionButton = class(TComponent)
  private
    FActive:Boolean;
    FCanvas:TCanvas;
    FCaption:TCaption;
    FCaptionRect:TRect;
    FDownGlyph:TBitmap;
    FFont:TFont;
    fForm : TCustomForm;
    FFormButtons:TObject;
    FFormHook:TObject;
    FGlyph:TBitmap;
    FHint:String;
    FIsMinimized:Boolean;
    FLeftMargin:Integer;
    FOnClick:TNotifyEvent;
    FOnDblClick:TNotifyEvent;
    FOnMouseDown:TMouseEvent;
    FOnMouseMove:TMouseMoveEvent;
    FOnMouseUp:TMouseEvent;
    FPopupMenu:TPopupMenu;
    FToggle:Boolean;
    FToolTip:TDCToolTip;
    FTopMargin:Integer;
    FWidth:Integer;

    FButtonDown:Boolean;
    FPressed:Boolean;
    FPrevButtonDown:Boolean;
    FResizing:Boolean;
    FShowHint:Boolean;
    FVisible:Boolean;
    FMouseOnControl:Boolean;

    FVersion : TDCVersion;

    Procedure CaptionRectUpdated;
    Function ConvertPointFromScreen(AX,AY:Integer):TPoint;
    Function ConvertToClient(AX,AY:Integer):TPoint;
    Function ConvertRectToClient(Const ARect:TRect):TRect;
    Procedure Draw;
    Procedure DrawCaption;
    Function GetBorderIcons:TBorderIcons;
    Function GetBorderStyle:TFormBorderStyle;
    Function GetButtonDefaultSize:TSize;
    Function GetFrameSize:TSize;
    Function GetLeftIconPos:Integer;
    Function GetButtonWidth:Integer;
    Procedure GlyphsChanged(Sender:TObject);
    Procedure FontChanged(Sender:TObject);
    Procedure HookWndProc(Var Message:TMessage);
    Procedure InternalMouseDown;
    Procedure Resize;
    Procedure SetButtonDown(Value:Boolean);
    Procedure SetCaption(const Value:TCaption);
    Procedure SetDownGlyph(Value:TBitmap);
    Procedure SetFont(Value:TFont);
    Procedure SetGlyph(Value:TBitmap);
    Procedure SetHint(const Value:String);
    Procedure SetLeftMargin(Value:Integer);
    Procedure SetPopupMenu(Value:TPopupMenu);
    Procedure SetToggle(Value:Boolean);
    Procedure SetShowHint(Value:Boolean);
    Procedure SetVisible(Value:Boolean);
    Procedure SetTopMargin(Value:Integer);
    Procedure SetWidth(Value:Integer);
    procedure SetForm(val : TCustomForm);
    Procedure UpdateCaption;
    Procedure UpdateFormWidth;
    Procedure UpdateHintControl;
    procedure InsertToForm;
    procedure RemoveFromForm;

    Procedure WMNCPaint(Var Message:TMessage);
    Procedure WMSysCommand(Var Message:TMessage);
    Procedure WMSize(Var Message:TMessage);
    Procedure WMWindowPosChanged(Var Message:TMessage);

    Property BorderIcons:TBorderIcons read GetBorderIcons;
    Property BorderStyle:TFormBorderStyle read GetBorderStyle;
  protected
    Procedure Click;virtual;
    Procedure DblClick;virtual;
    Procedure DoMouseDown(Var Message:TWMMouse;Button:TMouseButton;Shift:TShiftState);virtual;
    Procedure DoMouseMove(Var Message:TMessage);virtual;
    Procedure DoMouseUp(Var Message:TWMMouse;Button:TMouseButton;Shift:TShiftState);virtual;
    Procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);virtual;
    Procedure MouseMove(Shift:TShiftState;X,Y:Integer);virtual;
    Procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);virtual;
    Procedure Notification(AComponent:TComponent;Operation:TOperation);override;
    Procedure ValidateContainer(AComponent:TComponent);override;

    Property ButtonDown:Boolean read FButtonDown write SetButtonDown;
  public
    Constructor Create(AOwner:TComponent);override;
    Destructor Destroy;override;
  published
    Property Caption:TCaption read FCaption write SetCaption;
    Property DownGlyph:TBitmap read FDownGlyph write SetDownGlyph;
    property Down : boolean read fButtonDown write SetButtonDown default False;

    property Form : TCustomForm read fForm write SetForm;

    Property Font:TFont read FFont write SetFont;
    Property Glyph:TBitmap read FGlyph write SetGlyph;
    Property Hint:String read FHint write SetHint;
    Property LeftMargin:Integer read FLeftMargin write SetLeftMargin;
    Property OnClick:TNotifyEvent read FOnClick write FOnClick;
    Property OnMouseDown:TMouseEvent read FOnMouseDown write FOnMouseDown;
    Property OnMouseMove:TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    Property OnMouseUp:TMouseEvent read FOnMouseUp write FOnMouseUp;
    Property PopupMenu:TPopupMenu read FPopupMenu write SetPopupMenu;
    Property Toggle:Boolean read FToggle write SetToggle default False;
    Property ShowHint:Boolean read FShowHint write SetShowHint;

    Property TopMargin:Integer read FTopMargin write SetTopMargin default 0;
    Property Visible:Boolean read FVisible write SetVisible default True;
    Property Width:Integer read FWidth write SetWidth default -1;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TComponentProc=Procedure(AComponent:TComponent);
  
Var
  SelectComponentInDesignerProc:TComponentProc;
  
implementation
Uses dcCommon;

{$IFNDEF D4}
Const
  SPI_GETGRADIENTCAPTIONS = $1008;
  DC_GRADIENT = $20;
{$ENDIF}
Const
  ToolTipID=1;
Type
  TPublicComponent=Class(TComponent);{???}
  TPublicForm=Class(TForm);{???}
  TFormsHooks=Class;
  TFormHooks=Class;

  TFormHook=Class
  Private
    FNewWndProc:TWndMethod;
    FOldWndProc:TWndMethod;
    FOwner:TFormHooks;
    Procedure SetHook;
    Procedure StoreOldWndProc;
  Public
    Constructor Create(AOwner:TFormHooks;WndMethod:TWndMethod);
    Destructor Destroy;override;

    Procedure CallWndProc(Var Message:TMessage);
  End;

  TFormHooks=Class
  Private
    FForm:TForm;
    FHooks:TList;
    FOwner:TFormsHooks;
  Public
    Constructor Create(AOwner:TFormsHooks;AForm:TForm);
    Destructor Destroy;override;

    Function AddHook(WndMethod:TWndMethod):TFormHook;
    Procedure DeleteHook(AFormHook:TFormHook);

    Property Form:TForm read FForm;
  End;

  TFormsHooks=Class
  Private
    FFormsHooks:TList;
    Function GetForms(AForm:TForm):TFormHooks;
  Public
    Constructor Create;
    Destructor Destroy;override;

    Procedure Clear;
    Function IndexOf(AForm:TForm):Integer;
    Property Forms[Index:TForm]:TFormHooks read GetForms;
  End;

Type
  TFormsButtons=Class;

  TFormButtons=Class
  Private
    FButtons:TList;
    FForm:TForm;
    FOwner:TFormsButtons;
  Public
    Constructor Create(AOwner:TFormsButtons;AForm:TForm);
    Destructor Destroy;override;

    Procedure AddButton(Button:TDCCaptionButton);
    Procedure Draw(From:TDCCaptionButton;DrawCaption:Boolean);
    Function FirstButton:TDCCaptionButton;
    Function LastButton:TDCCaptionButton;
    Procedure RemoveButton(Button:TDCCaptionButton);
    Procedure Reposition(Button:TDCCaptionButton);
    Procedure UpdateButtons(From:Integer);

    Property Form:TForm read FForm;
  End;

  TFormsButtons=Class
  Private
    FFormsButtons:TList;
    Function GetForms(Index:TForm):TFormButtons;
  Public
    Constructor Create;
    Destructor Destroy;override;

    Property Forms[Index:TForm]:TFormButtons read GetForms;
  End;
  
Var
  FFormsHooks:TFormsHooks;
  FFormsButtons:TFormsButtons;

Function FormsHooks:TFormsHooks;
Begin
  If FFormsHooks=Nil Then
    FFormsHooks:=TFormsHooks.Create;
  Result:=FFormsHooks;
End;

{---------------------------------------------------------}

Function FormsButtons:TFormsButtons;
Begin
  If FFormsButtons=Nil Then
    FFormsButtons:=TFormsButtons.Create;
  Result:=FFormsButtons;
End;

{ TFormHook }

Constructor TFormHook.Create(AOwner:TFormHooks;WndMethod:TWndMethod);

Begin
  Inherited Create;
  FOwner:=AOwner;

  FNewWndProc:=WndMethod;
  StoreOldWndProc;
  SetHook;

  FOwner.FHooks.Add(Self);
End;

{---------------------------------------------------------}

Destructor TFormHook.Destroy;
Var
  Index:Integer;
Begin
  With FOwner Do
  Begin
    Index:=FHooks.IndexOf(Self);
    FHooks.Remove(Self);
    If Index=FHooks.Count Then
    Begin
      If Form.HandleAllocated Then
        Form.WindowProc:=FOldWndProc
    End    
    Else
      TFormHook(FHooks[Index]).FOldWndProc:=FOldWndProc;
  End;
  Inherited;
End;

{---------------------------------------------------------}

Procedure TFormHook.CallWndProc(Var Message:TMessage);
Begin
  FOldWndProc(Message);
End;

{---------------------------------------------------------}

Procedure TFormHook.SetHook;
Begin
  If Not (csDestroying In FOwner.Form.ComponentState) Then
    FOwner.Form.WindowProc:=FNewWndProc;
End;

{---------------------------------------------------------}

Procedure TFormHook.StoreOldWndProc;
Begin
  FOldWndProc:=FOwner.Form.WindowProc;
End;

{ TFormHooks }

Constructor TFormHooks.Create(AOwner:TFormsHooks;AForm:TForm);
Begin
  Inherited Create;
  FOwner:=AOwner;
  FForm:=AForm;
  FHooks:=TList.Create;
  FOwner.FFormsHooks.Add(Self);
End;

{---------------------------------------------------------}

Destructor TFormHooks.Destroy;
Begin
  FOwner.FFormsHooks.Remove(Self);
  If FOwner.FFormsHooks.Count=0 Then
  Begin
    FOwner.Destroy;
    FOwner:=Nil;
    FFormsHooks:=Nil;
  End;
  FHooks.Free;
  Inherited;
End;

{---------------------------------------------------------}

Function TFormHooks.AddHook(WndMethod:TWndMethod):TFormHook;
Begin
  Result:=TFormHook.Create(Self,WndMethod);
End;

{---------------------------------------------------------}

Procedure TFormHooks.DeleteHook(AFormHook:TFormHook);
Begin
  AFormHook.Free;
  If FHooks.Count=0 Then
    Destroy;
End;

{ TFormsHooks }

Constructor TFormsHooks.Create;
Begin
  Inherited;
  FFormsHooks:=TList.Create;
End;

{---------------------------------------------------------}

Destructor TFormsHooks.Destroy;
Begin
  Clear;
  FFormsHooks.Free;
  Inherited;
End;

{---------------------------------------------------------}

Procedure TFormsHooks.Clear;
Var
  I:Integer;
Begin
  For I:=FFormsHooks.Count-1 DownTo 0 Do
    FFormsHooks.Delete(I);
End;

{---------------------------------------------------------}

Function TFormsHooks.GetForms(AForm:TForm):TFormHooks;
Var
  Index:Integer;
Begin
  Index:=IndexOf(AForm);
  If Index<0 Then
    Result:=TFormHooks.Create(Self,AForm)
  Else
    Result:=FFormsHooks[Index];  
End;

{---------------------------------------------------------}

Function TFormsHooks.IndexOf(AForm:TForm):Integer;
Var
  I:Integer;
Begin
  For I:=0 To FFormsHooks.Count-1 Do
  Begin
    If TFormHooks(FFormsHooks[I]).Form=AForm Then
    Begin
      Result:=I;
      Exit;
    End;  
  End;
  Result:=-1;
End;

{ TFormButtons }

Constructor TFormButtons.Create(AOwner:TFormsButtons;AForm:TForm);
Begin
  Inherited Create;
  FOwner:=AOwner;
  FForm:=AForm;
  FButtons:=TList.Create;
  FOwner.FFormsButtons.Add(Self);
End;

{---------------------------------------------------------}

Destructor TFormButtons.Destroy;
Begin
  FButtons.Free;
  FOwner.FFormsButtons.Remove(Self);
  If FOwner.FFormsButtons.Count=0 Then
  Begin
    FOwner.Destroy;
    FOwner:=Nil;
    FFormsButtons:=Nil;
  End;  
  Inherited;
End;

{---------------------------------------------------------}

Procedure TFormButtons.AddButton(Button:TDCCaptionButton);
Begin
  FButtons.Add(Button);
  Reposition(Button);
End;

{---------------------------------------------------------}

Procedure TFormButtons.Draw(From:TDCCaptionButton;DrawCaption:Boolean);
Var
  I:Integer;
  ALastButton:TDCCaptionButton;
Begin
  ALastButton:=LastButton;
  If ALastButton<>From Then
    Exit;
  For I:=0 To FButtons.Count-1 Do
    With TDCCaptionButton(FButtons[I]) Do
      If Visible Then
        Draw;
  If DrawCaption Then
    From.DrawCaption;
End;

{---------------------------------------------------------}

Function TFormButtons.FirstButton:TDCCaptionButton;
Var
  I:Integer;
Begin
  Result:=Nil;
  For I:=0 To FButtons.Count-1 Do
  Begin
    Result:=FButtons[I];
    If Result.Visible Then
      Exit;
  End;
End;

{---------------------------------------------------------}

Function TFormButtons.LastButton:TDCCaptionButton;
Var
  I:Integer;
Begin
  Result:=Nil;
  For I:=FButtons.Count-1 DownTo 0 Do
  Begin
    Result:=FButtons[I];
    If Result.Visible Then
      Exit;
  End;
End;

{---------------------------------------------------------}

Procedure TFormButtons.RemoveButton(Button:TDCCaptionButton);
Var
  Index:Integer;
Begin
  Index:=FButtons.IndexOf(Button);
  FButtons.Delete(Index);
  If Index=0 Then
    UpdateButtons(0)
  Else
    UpdateButtons(Index-1);
  If FButtons.Count=0 Then
    Destroy;
End;

{---------------------------------------------------------}

Procedure TFormButtons.Reposition(Button:TDCCaptionButton);
Begin
  UpdateButtons(FButtons.IndexOf(Button));
End;

{---------------------------------------------------------}

Procedure TFormButtons.UpdateButtons(From:Integer);
Var
  I:Integer;
  RightPos:Integer;
  Y:Integer;
Begin
  If FButtons.Count=0 Then
    Exit;
  If From=0 Then
  Begin
//    TDCCaptionButton(FButtons[0]).UpdateCaptionRect;
    RightPos:=TDCCaptionButton(FButtons[0]).GetLeftIconPos
  End
  Else
  Begin
//    TDCCaptionButton(FButtons[From-1]).UpdateCaptionRect;
    RightPos:=TDCCaptionButton(FButtons[From-1]).FCaptionRect.Left;
  End;
  For I:=From To FButtons.Count-1 Do
  With TDCCaptionButton(FButtons[I]) Do
  Begin
    If Visible Then
    Begin
      Y:=GetFrameSize.cY+2;
      FCaptionRect:=Rect(RightPos-GetButtonWidth,Y,RightPos,Y+GetButtonDefaultSize.cY-4);
      FCaptionRect.Left:=RightPos-GetButtonWidth;
      FCaptionRect.Right:=FCaptionRect.Left+GetButtonWidth;
      CaptionRectUpdated;
      RightPos:=FCaptionRect.Left;
    End;
  End;
End;

{ TFormsButtons }

Constructor TFormsButtons.Create;
Begin
  Inherited;
  FFormsButtons:=TList.Create;
End;

{---------------------------------------------------------}

Destructor TFormsButtons.Destroy;
Begin
  FFormsButtons.Free;
  Inherited;
End;

{---------------------------------------------------------}

Function TFormsButtons.GetForms(Index:TForm):TFormButtons;
Var
  I:Integer;
Begin
  For I:=0 To FFormsButtons.Count-1 Do
  Begin
    Result:=FFormsButtons[I];
    If Result.Form=Index Then
      Exit;
  End;
  Result:=TFormButtons.Create(Self,Index);
End;

{ Common Procedures }

Procedure DrawButton(Canvas:TCanvas;ARect:TRect;Pressed:Boolean);
Begin
  If Pressed Then
  Begin
    DrawEdge(Canvas.Handle,ARect,BDR_SUNKENINNER,BF_TOPLEFT);
    DrawEdge(Canvas.Handle,ARect,BDR_SUNKENOUTER,BF_BOTTOMRIGHT);
    InflateRect(ARect,-1,-1);
    DrawEdge(Canvas.Handle,ARect,BDR_SUNKENINNER,BF_BOTTOMRIGHT);
    Dec(ARect.Right);
    Dec(ARect.Bottom);
    DrawEdge(Canvas.Handle,ARect,BDR_SUNKENOUTER,BF_TOPLEFT);
  End
  Else
  Begin
    DrawEdge(Canvas.Handle,ARect,BDR_RAISEDINNER,BF_TOPLEFT);
    DrawEdge(Canvas.Handle,ARect,BDR_RAISEDOUTER,BF_BOTTOMRIGHT);
    InflateRect(ARect,-1,-1);
    DrawEdge(Canvas.Handle,ARect,BDR_RAISEDINNER,BF_BOTTOMRIGHT);
  End;
End;

{---------------------------------------------------------}

Function DragContentsWindow:Boolean;
Begin
  SystemParametersInfo(SPI_GETDRAGFULLWINDOWS,0,@Result,0);
End;

{---------------------------------------------------------}

Constructor TDCCaptionButton.Create(AOwner:TComponent);
Begin
  Inherited Create(AOwner);

  FWidth:=-1;
  FVisible:=True;

  FFont:=TFont.Create;
  FFont.OnChange:=FontChanged;
  FCanvas:=TCanvas.Create;
  FCanvas.Font:=FFont;
  FDownGlyph:=TBitmap.Create;
  FDownGlyph.OnChange:=GlyphsChanged;
  FGlyph:=TBitmap.Create;
  FGlyph.OnChange:=GlyphsChanged;

  Form:=TForm(Owner);
End;

{---------------------------------------------------------}

Destructor TDCCaptionButton.Destroy;
Begin
  Form := nil;

//  FDCHint.Free;
  FGlyph.Free;
  FDownGlyph.Free;
  FFont.Free;
  FCanvas.Free;
  Inherited Destroy;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.CaptionRectUpdated;
Begin
  UpdateHintControl;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.Click;
Begin
  If Assigned(FOnClick) Then
    FOnClick(Self);
End;

{---------------------------------------------------------}


Function TDCCaptionButton.ConvertPointFromScreen(AX,AY:Integer):TPoint;
Var
  ParentWnd:THandle;
Begin
  ParentWnd:=GetParent(FForm.Handle);
  If Application.Handle=ParentWnd Then
    ParentWnd:=0;
  If ParentWnd=0 Then
    Result:=Point(AX-Form.Left,AY-FForm.Top)
  Else
  Begin
    Result:=Point(FForm.Left,FForm.Top);
    Windows.ClientToScreen(ParentWnd,Result);
    Result:=Point(AX-Result.X,AY-Result.Y);
  End;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.ConvertToClient(AX,AY:Integer):TPoint;
Var
  ParentWnd:THandle;
Begin
  ParentWnd:=GetParent(FForm.Handle);
  If Application.Handle=ParentWnd Then
    ParentWnd:=0;
  If ParentWnd=0 Then
    Result:=Point(AX+Form.Left,AY+FForm.Top)
  Else
  Begin
    Result:=Point(FForm.Left,FForm.Top);
    Windows.ClientToScreen(ParentWnd,Result);
    Result:=Point(AX+Result.X,AY+Result.Y);
  End;
  Result:=FForm.ScreenToClient(Result);
End;

{---------------------------------------------------------}

Function TDCCaptionButton.ConvertRectToClient(Const ARect:TRect):TRect;
Begin
  Result.TopLeft:=ConvertToClient(ARect.Left,ARect.Top);
  Result.BottomRight:=ConvertToClient(ARect.Right,ARect.Bottom);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.DblClick;
Begin
  If csDesigning In ComponentState Then
    Exit;
  FPrevButtonDown:=Not FPrevButtonDown;
  InternalMouseDown;
  If Assigned(FOnDblClick) Then
    FOnDblClick(Self);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.DoMouseDown(Var Message:TWMMouse;Button:TMouseButton;Shift:TShiftState);
Begin
  With Message,ConvertPointFromScreen(XPos,YPos) Do
     MouseDown(Button,KeysToShiftState(Keys)+Shift,X,Y);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.DoMouseMove(Var Message:TMessage);
Begin
  With TSmallPoint(Message.lParam),ConvertPointFromScreen(X,Y) Do
    MouseMove([],X,Y);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.DoMouseUp(Var Message:TWMMouse;Button:TMouseButton;Shift:TShiftState);
Begin
  With Message,ConvertPointFromScreen(XPos,YPos) Do
    MouseUp(Button,KeysToShiftState(Keys)+Shift,X,Y);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.Draw;
Var
  DrawBitmap:TBitmap;
  DrawRect:TRect;
  ImageRect:TRect;
  TextRect:TRect;
  Rgn:THandle;
Begin
  if Form = nil then
    exit;

  FCanvas.Handle:=GetWindowDC(Form.Handle);
  Try
    DrawRect:=FCaptionRect;
    DrawButton(FCanvas,FCaptionRect,FButtonDown);
    InflateRect(DrawRect,-1,-1);
    If FButtonDown Then
    Begin
      Inc(DrawRect.Left);
      Inc(DrawRect.Top);
    End
    Else
    Begin
      Dec(DrawRect.Right);
      Dec(DrawRect.Bottom);
    End;
    FCanvas.Font:=FFont;
    FCanvas.Brush.Color:=clBtnFace;
    If FCaption<>'' Then
    Begin
      TextRect:=DrawRect;
      Inc(TextRect.Left,FLeftMargin);
      Inc(TextRect.Top,FTopMargin);
      Rgn:=CreateRectRgnIndirect(DrawRect);
      SelectClipRgn(FCanvas.Handle,Rgn);
      DrawTextWithFill(FCanvas,FCaption,DT_CENTER Or DT_VCENTER Or DT_END_ELLIPSIS,TextRect);
      FillRectEx(FCanvas,DrawRect,TextRect);
      SelectClipRgn(FCanvas.Handle,0);
      DeleteObject(Rgn);
    End
    Else
    Begin
      DrawBitmap:=FGlyph;
      If FButtonDown And Not FDownGlyph.Empty Then
        DrawBitmap:=FDownGlyph;
      ImageRect:=AlignRectByRect(Rect(0,0,DrawBitmap.Width,DrawBitmap.Height),DrawRect,
                                 haCenter,vaCenter,0,0);
      If IsRectEmpty(ImageRect) Then
        FCanvas.FillRect(DrawRect)
      Else
      Begin
        DrawImage(FCanvas,DrawBitmap,clBtnFace,ImageRect,0);
        FillRectEx(FCanvas,DrawRect,ImageRect);
      End;
    End;
  Finally
    ReleaseDC(FForm.Handle, FCanvas.Handle);
    FCanvas.Handle:=0;
  End;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.DrawCaption;
Var
  CaptionRect:TRect;
  DC:THandle;
  DrawCaptionFlags:Integer;
  FrameSize:TSize;
  Data:Bool;
Begin
  FrameSize:=GetFrameSize;
  DC:=GetWindowDC(FForm.Handle);
  DrawCaptionFlags:=DC_TEXT Or DC_ICON;
  SystemParametersInfo(SPI_GETGRADIENTCAPTIONS,0,@Data,0);
  If Data Then
    DrawCaptionFlags:=DrawCaptionFlags Or DC_GRADIENT;

  If FActive{(GetForegroundWindow=FForm.Handle) And FForm.Active} Then
    DrawCaptionFlags:=DrawCaptionFlags Or DC_ACTIVE;

  CaptionRect.Left:=FrameSize.cX;
  CaptionRect.Top:=FrameSize.cY;
  With TFormButtons(FFormButtons) Do
    CaptionRect.Right:=LastButton.FCaptionRect.Left;
  CaptionRect.Bottom:=FCaptionRect.Bottom+2;

  Windows.DrawCaption(FForm.Handle,DC,CaptionRect,DrawCaptionFlags);
  ReleaseDC(FForm.Handle,DC);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.FontChanged(Sender:TObject);
Begin
  Draw;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.GetBorderIcons:TBorderIcons;
Begin
  If csDesigning In FForm.ComponentState Then
    Result:=[biSystemMenu,biMaximize,biMinimize]
  Else
    Result:=TForm(Form).BorderIcons;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.GetBorderStyle:TFormBorderStyle;
Begin
  If csDesigning In FForm.ComponentState Then
    Result:=bsSizeable
  Else
    Result:=TForm(FForm).BorderStyle;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.GetButtonDefaultSize:TSize;
Begin
  If BorderStyle In [bsSizeToolWin,bsToolWindow] then
  Begin
    Result.cX:=GetSystemMetrics(SM_CXSMSIZE);
    Result.cY:=GetSystemMetrics(SM_CYSMSIZE);
  End
  Else
  Begin
    If BorderStyle=bsNone Then
    Begin
      Result.cX:=0;
      Result.CY:=0;
    End
    Else
    Begin
      Result.cX:=GetSystemMetrics(SM_CXSIZE);
      Result.cY:=GetSystemMetrics(SM_CYSIZE);
    End;  
  End;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.GetButtonWidth:Integer;
Var
  ButtonSize:TSize;
Begin
  ButtonSize:=GetButtonDefaultSize;
  If FWidth=-1 Then
    Result:=ButtonSize.cX-2
  Else
    Result:=FWidth;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.GetFrameSize:TSize;
Begin
  Case BorderStyle Of
    bsNone:Begin
      Result.cX:=0;
      Result.cY:=0;
    End;
    bsSingle,bsDialog,bsToolWindow:Begin
      Result.cX:=GetSystemMetrics(SM_CXDLGFRAME);
      Result.cY:=GetSystemMetrics(SM_CYDLGFRAME);
    End;
    bsSizeable,bsSizeToolWin:Begin
      Result.cX:=GetSystemMetrics(SM_CXFRAME);
      Result.cY:=GetSystemMetrics(SM_CYFRAME);
    End;
  End;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.GlyphsChanged(Sender:TOBject);
Begin
  Draw;
End;

{---------------------------------------------------------}

Function TDCCaptionButton.GetLeftIconPos:Integer;
Var
  IconWidth:Integer;
Begin
  IconWidth:=GetButtonDefaultSize.cX-2;
  Result:=FForm.Width-GetFrameSize.cX-2;
  If BorderStyle=bsNone Then
    Exit;
  If Not (biSystemMenu In BorderIcons) Then
    Exit;
  Dec(Result,IconWidth);
  If BorderStyle In [bsToolWindow,bsSizeToolWin] Then
    Exit;
  If BorderStyle=bsDialog Then
  Begin
    If biHelp In BorderIcons Then
      Dec(Result,IconWidth+2)
  End
  Else
  Begin
    If [biMinimize,biMaximize]*BorderIcons<>[] Then
    Begin
      Dec(Result,2);
      Dec(Result,IconWidth);
      Dec(Result,IconWidth);
    End;
    If ([biMinimize,biMaximize]*BorderIcons<>[biMinimize,biMaximize]) And (biHelp In BorderIcons) Then
    Begin
      Dec(Result,IconWidth+2);
      If [biMinimize,biMaximize]*BorderIcons<>[] Then
        Dec(Result,4);
    End;

  End;
  Dec(Result,2);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.HookWndProc(var Message:TMessage);
  Function IsShowPopup(X,Y:Integer):Boolean;
  Begin
    Result:=((FPopupMenu<>Nil) And Not(csDesigning in ComponentState)) And
             PtInRect(FCaptionRect,Point(X,Y));
  End;
Var
  Delta:Integer;
  Pt:TPoint;
  NewMessage:TMessage;
Begin
  {$R-}
  If Form=Nil Then
    Exit;
  If Not FVisible Then
    TFormHook(FFormHook).CallWndProc(Message)
  Else
    Case Message.Msg of
      WM_NCACTIVATE:
      Begin
        TFormHook(FFormHook).CallWndProc(Message);
        FActive:=WordBool(Message.wParam);
        If Not FIsMinimized Then
          TFormButtons(FFormButtons).Draw(Self,True);
      End;
      WM_NCPAINT:
        If FIsMinimized Then
          TFormHook(FFormHook).CallWndProc(Message)
        Else
          WMNCPaint(Message);
      WM_SETTEXT:
        Begin
          TFormHook(FFormHook).CallWndProc(Message);
          TFormButtons(FFormButtons).Draw(Self,False);
        End;
{      WM_ACTIVATE:
        Begin
          TFormHook(FFormHook).CallWndProc(Message);
          If Not FIsMinimized Then
            TFormButtons(FFormButtons).Draw(Self,True);
        End;}
      WM_WINDOWPOSCHANGED:
        WMWindowPosChanged(Message);
      WM_SIZE:
        WMSize(Message);
      WM_SIZING:
        With PRect(Message.lParam)^ Do
        Begin
          If DragContentsWindow Then
          Begin
            Delta:=FForm.Width-(Right-Left);
            Dec(FCaptionRect.Left,Delta);
            Dec(FCaptionRect.Right,Delta);
            CaptionRectUpdated;
          End;
          TFormHook(FFormHook).CallWndProc(Message);
       End;
      WM_SYSCOMMAND:
        WMSysCommand(Message);
      WM_GETMINMAXINFO:
        Begin
          TFormHook(FFormHook).CallWndProc(Message);
          Inc(PMinMaxInfo(Message.LParam).ptMinTrackSize.X,FCaptionRect.Right-FCaptionRect.Left);
        End;
      WM_NCLBUTTONDOWN,WM_NCRBUTTONDOWN:
        Begin
          With TSmallPoint(Message.lParam),ConvertPointFromScreen(X,Y) Do
            If PtInRect(FCaptionRect,Point(X,Y)) Then
              If Message.Msg=WM_NCLBUTTONDOWN Then
                DoMouseDown(TWMMouse(Message),mbLeft,[]);
          TFormHook(FFormHook).CallWndProc(Message);
        End;
       WM_NCRBUTTONUP:
         Begin
           With TSmallPoint(Message.lParam) Do
           Begin
             If PtInRect(FCaptionRect,Point(X,Y)) Then
               DoMouseUp(TWMMouse(Message),mbRight,[]);
             Pt:=ConvertPointFromScreen(X,Y);
             If IsShowPopup(Pt.X,Pt.Y) Then
             Begin
               FPopupMenu.Popup(X,Y);
               Message.Result:=0;
             End;
             TFormHook(FFormHook).CallWndProc(Message);
{             Message.Msg:=WM_RBUTTONUP;
             Message.lParamLo:=X;
             Message.lParamHi:=Y;
             Message.wParam:=0;
             TFormHook(FFormHook).CallWndProc(Message);}
           End;
         End;
      WM_NCMOUSEMOVE:
        Begin
          With TSmallPoint(Message.lParam),ConvertPointFromScreen(X,Y) Do
            If (PtInRect(FCaptionRect,Point(X,Y))) Or FPressed Then
              DoMouseMove(Message)
            Else
            Begin
              FMouseOnControl:=False;
            End;
          TFormHook(FFormHook).CallWndProc(Message);
        End;
      WM_LBUTTONUP:
        Begin
          With TSmallPoint(Message.lParam) Do
            Pt:=FForm.ClientToScreen(Point(X,Y));
            NewMessage:=Message;
            NewMessage.lParamLo:=Pt.X;
            NewMessage.lParamHi:=Pt.Y;
            DoMouseUp(TWMMouse(NewMessage),mbLeft,[]);
            TFormHook(FFormHook).CallWndProc(Message);
        End;
      WM_CONTEXTMENU:
        Begin
          With TSmallPoint(Message.lParam) Do
          Begin
            Pt:=ConvertPointFromScreen(X,Y);
            If IsShowPopup(Pt.X,Pt.Y) Then
            Begin
              FPopupMenu.Popup(X,Y);
              Message.Result:=0;
            End
            Else
            Begin
              Message.wParam:=0;
              TFormHook(FFormHook).CallWndProc(Message);
            End;
          End;
        End;
      WM_MOUSEMOVE:
        Begin
          With TSmallPoint(Message.lParam) Do
            Pt:=FForm.ClientToScreen(Point(X,Y));
          Pt:=ConvertPointFromScreen(Pt.X,Pt.Y);
          If (PtInRect(FCaptionRect,Pt)) Or FPressed Then
          Begin
            NewMessage:=Message;
            With TSmallPoint(NewMessage.lParam) Do
              Pt:=FForm.ClientToScreen(Point(X,Y));
            NewMessage.lParamLo:=Pt.X;
            NewMessage.lParamHi:=Pt.Y;
            DoMouseMove(NewMessage);
          End
          Else
          Begin
            FMouseOnControl:=False;
          End;
          TFormHook(FFormHook).CallWndProc(Message);
        End;
      WM_NCHITTEST:
        With TSmallPoint(Message.lParam),ConvertPointFromScreen(X,Y) Do
          If PtInRect(FCaptionRect,Point(X,Y)) Then
            Message.Result:=HTBORDER
          Else
          TFormHook(FFormHook).CallWndProc(Message);
      WM_NCLBUTTONDBLCLK:
        Begin
          With TSmallPoint(Message.lParam),ConvertPointFromScreen(X,Y) Do
            If PtInRect(FCaptionRect,Point(X,Y)) Then
              DblClick;
          TFormHook(FFormHook).CallWndProc(Message);
        End;
      WM_SETTINGCHANGE :
        begin
          TFormHook(FFormHook).CallWndProc(Message);
          Resize;
          TFormButtons(FFormButtons).Draw(Self,False);
        end;
      WM_SHOWWINDOW:
        Begin
          If Message.lParam=SW_PARENTOPENING Then
            FIsMinimized:=False;
          TFormHook(FFormHook).CallWndProc(Message);
        End;
      Else
        TFormHook(FFormHook).CallWndProc(Message);
    End;
    {$R+}
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.InternalMouseDown;
Begin
  SetCapture(FForm.Handle);
  If FToggle Then
    ButtonDown:=Not FPrevButtonDown
  Else
    ButtonDown:=True;  
  FPressed:=True;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
Begin
  If Button=mbLeft Then
  Begin
    If csDesigning In ComponentState Then
    Begin
      If Assigned(SelectComponentInDesignerProc) Then
        SelectComponentInDesignerProc(Self);
      Exit;
    End;
    FPrevButtonDown:=FButtonDown;
    InternalMouseDown;
  End;
  If Assigned(FOnMouseDown) Then
    FOnMouseDown(Self,Button,Shift,X,Y);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.MouseMove(Shift:TShiftState;X,Y:Integer);
Begin
  If FPressed Then
    If FToggle Then
      If PtInRect(FCaptionRect,Point(X,Y)) Then
        ButtonDown:=Not FPrevButtonDown
      Else
        ButtonDown:=FPrevButtonDown
    Else
      ButtonDown:=PtInRect(FCaptionRect,Point(X,Y));
  If Assigned(FOnMouseMove) Then
    FOnMouseMove(Self,Shift,X,Y);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
Begin
  If FPressed Then
  Begin
    If Button=mbLeft Then
    Begin
      ReleaseCapture;
      If FToggle Then
        If PtInRect(FCaptionRect,Point(X,Y)) Then
          ButtonDown:=Not FPrevButtonDown
        Else
          ButtonDown:=FPrevButtonDown
      Else
        ButtonDown:=False;
      FPressed:=False;
    End;
    If PtInRect(FCaptionRect,Point(X,Y)) Then
    Begin
      If Assigned(FOnMouseUp) Then
        FOnMouseUp(Self,Button,Shift,X,Y);
      Click;
    End;
  End;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.Notification(AComponent:TComponent;Operation:TOperation);
Begin
  Inherited;
  If (AComponent=FPopupMenu) And (Operation=opRemove) Then
    PopupMenu:=Nil;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.Resize;
Begin
  TFormButtons(FFormButtons).UpdateButtons(0);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetButtonDown(Value:Boolean);
Begin
  If FButtonDown=Value Then
    Exit;
  FButtonDown:=Value;
  Draw;  
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetCaption(const Value:TCaption);
Begin
  If Caption=Value Then
    Exit;
  FCaption:=Value;
  Draw;  
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetDownGlyph(Value:TBitmap);
Begin
  FDownGlyph.Assign(Value);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetFont(Value:TFont);
Begin
  FFont.Assign(Value);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetGlyph(Value:TBitmap);
Begin
  FGlyph.Assign(Value);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetHint(const Value:String);
Begin
  If FHint=Value Then
    Exit;
  FHint:=Value;
  UpdateHintControl;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetLeftMargin(Value:Integer);
Begin
  If FLeftMargin=Value Then
    Exit;
  FLeftMargin:=Value;
  Draw;  
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetPopupMenu(Value:TPopupMenu);
Begin
  If FPopupMenu=Value Then
    Exit;
  FPopupMenu:=Value;
  If PopupMenu<>Nil Then
    FPopupMenu.FreeNotification(Self);
End;

{---------------------------------------------------------}

procedure TDCCaptionButton.SetToggle(Value:Boolean);
Begin
  If FToggle=Value Then
    Exit;
  FToggle:=Value;
  If Not Value Then
    ButtonDown:=False;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetShowHint(Value:Boolean);
Begin
  If FShowHint=Value Then
    Exit;
  FShowHint:=Value;
  If Not (csDesigning In ComponentState) Then
    If Value Then
    Begin
      FToolTip:=TDCToolTip.Create(FForm);
      FToolTip.CreateToolTipWindow;
      FToolTip.AddToolTip(ToolTipID,FForm.Handle,ConvertRectToClient(FCaptionRect),FHint,True);
    End
    Else
    Begin
      FToolTip.Free;
      FToolTip:=Nil;
    End;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetTopMargin(Value:Integer);
Begin
  If FTopMargin=Value Then
    Exit;
  FTopMargin:=Value;
  Draw;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetVisible(Value:Boolean);
Begin
  If FVisible=Value Then
    Exit;
  FVisible:=Value;
  Resize;
  UpdateFormWidth;
  UpdateCaption;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.SetWidth(Value:Integer);
Begin
  If FWidth=Value Then
    Exit;
  FWidth:=Value;
  If FWidth<-1 Then
    FWidth:=-1;
  Resize;
  UpdateFormWidth;
  UpdateCaption;
End;

{---------------------------------------------------------}

procedure TDCCaptionButton.RemoveFromForm;
begin
  FormsHooks.Forms[TForm(Form)].DeleteHook(TFormHook(FFormHook));
  If FFormButtons<>Nil Then
    TFormButtons(FFormButtons).RemoveButton(Self);
  UpdateCaption;
end;

{---------------------------------------------------------}

procedure TDCCaptionButton.InsertToForm;
begin
  if Form = nil then
    exit;

  With Application Do
    If (FForm.HandleAllocated And (GetActiveWindow=FForm.Handle)) Or
       ((MainForm<>Nil) And (GetActiveWindow=MainForm.Handle) And (MainForm.FormStyle=fsMdiForm) And
        (TForm(FForm).FormStyle=fsMDIChild) And (MainForm.ActiveMDIChild=FForm)) Then
      FActive:=True
    Else
      FActive:=False;
  FFormHook:=FormsHooks.Forms[TForm(Form)].AddHook(HookWndProc);
  FFormButtons:=FormsButtons.Forms[TForm(Form)];
  TFormButtons(FFormButtons).AddButton(Self);

  UpdateFormWidth;
  UpdateCaption
end;

{---------------------------------------------------------}

procedure TDCCaptionButton.SetForm(val : TCustomForm);
begin
  if val <> fForm then
    begin
      if fForm <> nil then
        RemoveFromForm;
      fForm := val;
      InsertToForm;
    end;
end;

{---------------------------------------------------------}

Procedure TDCCaptionButton.UpdateCaption;
Begin
  If fForm <> nil then
    if Not (csDestroying In FForm.ComponentState) Then
      RedrawWindow(FForm.Handle,Nil,0,RDW_FRAME Or RDW_NOINTERNALPAINT Or RDW_INVALIDATE);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.UpdateFormWidth;
Begin
  FResizing:=True;
  Resize;
//  SetWindowPos(FForm.Handle,0,0,0,FForm.Width,FForm.Height,SWP_NOZORDER Or SWP_NOMOVE Or SWP_NOACTIVATE);
  FResizing:=False;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.UpdateHintControl;
Var
  ClientCaptionRect:TRect;
Begin
  If FShowHint And Not (csDesigning In ComponentState) Then
  Begin
    ClientCaptionRect:=ConvertRectToClient(FCaptionRect);
    FToolTip.UpdateToolTipInfo(ToolTipID,FForm.Handle,ClientCaptionRect,FHint,True);
    FToolTip.Width:=GetSystemMetrics(SM_CXFULLSCREEN)-FForm.ClientToScreen(ClientCaptionRect.BottomRight).X;
  End;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.ValidateContainer(AComponent:TComponent);
Begin
  Inherited;
  If Not (AComponent Is TCustomForm) Then
    Error(SErrControlsInData);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.WMNCPaint(Var Message:TMessage);
Var
  NewRgn:THandle;
  ButtonRect:TRect;
  ButtonRgn:THandle;
  WindowRect:TRect;
  FrameSize:TSize;
  CaptionRect:TRect;
  CaptionRgn:THandle;
  FirstButton:TDCCaptionButton;
  LastButton:TDCCaptionButton;
Begin
  {$R-}
  If FResizing Then
    Exit;
  LastButton:=TFormButtons(FFormButtons).LastButton;
  If Not FVisible Or (LastButton<>Self) Then
  Begin
    TFormHook(FFormHook).CallWndProc(Message);
    Exit;
  End;
  FrameSize:=GetFrameSize;
  GetWindowRect(FForm.Handle,WindowRect);
  FirstButton:=TFormButtons(FFormButtons).FirstButton;
  ButtonRect.Left:=WindowRect.Left+FCaptionRect.Left;
  ButtonRect.Top:=WindowRect.Top+FCaptionRect.Top;
  ButtonRect.Right:=WindowRect.Left+FirstButton.FCaptionRect.Right;
  ButtonRect.Bottom:=WindowRect.Top+FirstButton.FCaptionRect.Bottom;
  ButtonRgn:=CreateRectRgnIndirect(ButtonRect);
  If Message.wParam=1 Then
  Begin
    NewRgn:=CreateRectRgnIndirect(WindowRect);
    CombineRgn(NewRgn,NewRgn,ButtonRgn,RGN_DIFF)
  End
  Else
  Begin
    NewRgn:=Message.wParam;
    CombineRgn(NewRgn,NewRgn,ButtonRgn,RGN_DIFF);
  End;
  CaptionRect.Left:=WindowRect.Left+FrameSize.cX;
  CaptionRect.Top:=WindowRect.Top+FrameSize.cY;
  CaptionRect.Right:=WindowRect.Left+LastButton.FCaptionRect.Left;
  CaptionRect.Bottom:=WindowRect.Top+FCaptionRect.Bottom+2;

  CaptionRgn:=CreateRectRgnIndirect(CaptionRect);
  CombineRgn(NewRgn,NewRgn,CaptionRgn,RGN_DIFF);
  TFormButtons(FFormButtons).Draw(Self,True);
  Message.wParam:=NewRgn;
  TFormHook(FFormHook).CallWndProc(Message);
  DeleteObject(CaptionRgn);
  DeleteObject(ButtonRgn);
  DeleteObject(NewRgn);
  {$R+}
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.WMSize(Var Message:TMessage);
Begin
  TFormHook(FFormHook).CallWndProc(Message);
  If Message.wParam=0 Then
  Begin
    Resize;
    UpdateCaption;
    TFormButtons(FFormButtons).Draw(Self,False);
  End;
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.WMSysCommand(Var Message:TMessage);
Var
  Delta:Integer;
  WindowRect:TRect;
  WindowPlacement:TWindowPlacement;
Begin
  Case (Message.wParam) And Not 2 Of
    SC_MAXIMIZE:
      Begin
        SystemParametersInfo(SPI_GETWORKAREA,0,@WindowRect,0);
        Delta:=FForm.Width-(WindowRect.Right-WindowRect.Left)-GetFrameSize.cX*2;
        Dec(FCaptionRect.Left,Delta);
        Dec(FCaptionRect.Right,Delta);
        FIsMinimized:=False;
      End;
    SC_RESTORE:
      Begin
        GetWindowPlacement(FForm.Handle,@WindowPlacement);
        Delta:=FForm.Width-(WindowPlacement.rcNormalPosition.Right-WindowPlacement.rcNormalPosition.Left);
        Dec(FCaptionRect.Left,Delta);
        Dec(FCaptionRect.Right,Delta);
        FIsMinimized:=False;
      End;
    SC_MINIMIZE:
      FIsMinimized:=True;
  End;
  TFormHook(FFormHook).CallWndProc(Message);
End;

{---------------------------------------------------------}

Procedure TDCCaptionButton.WMWindowPosChanged(Var Message:TMessage);
Begin
  TFormHook(FFormHook).CallWndProc(Message);
  Resize;
  UpdateCaption;
  TFormButtons(FFormButtons).Draw(Self,False);
End;

end.
