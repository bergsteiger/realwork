unit BackPnl;

{ $Id: BackPnl.pas,v 1.4 2001/04/05 08:52:17 law Exp $ }

// $Log: BackPnl.pas,v $
// Revision 1.4  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.3  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

type
  TBackPanel = class(TPanel)
  private
   FPicture : TPicture;
  protected
    Procedure SetWallPaper(Value : TPicture);
    procedure Paint; override;
  Public
    Constructor Create(AOwner: TComponent); override;
    Destructor  Destroy; override;
  published
    Property WallPaper : TPicture Read FPicture write SetWallPaper;
  end;

  TMDIBackground = class(TComponent)
   Private
    FPicture : TPicture;
    Procedure SetWallPaper(Value : TPicture);
    procedure NewClientWndProc(var Message: TMessage);
   public
    FDefClientProc: TFarProc;
    FClientInstance: TFarProc;
    constructor Create(AOwner: TComponent); override;
    Destructor  Destroy; override;
    procedure SetBackground;

   published
    Property WallPaper : TPicture Read FPicture write SetWallPaper;

  end;

Procedure PaintOnCanvas(aCanvas : TCanvas; PaintRect : TRect; Pict : TPicture);
procedure Register;

implementation

constructor TMDIBackground.Create(AOwner: TComponent);
  Begin
   Inherited Create(AOwner);
   FPicture:=TPicture.Create;
  end;

 Destructor  TMDIBackground.Destroy;
  Begin
   FPicture.Free;
   Inherited Destroy;
  end;

procedure TMDIBackground.SetBackground;
 Begin
  (*If (TForm(Owner).FormStyle = fsMDIForm)
   {Not (csDesigning in ComponentState)
     and}
    then*)
    Begin
     FClientInstance := MakeObjectInstance(NewClientWndProc);
     FDefClientProc := Pointer(GetWindowLong(TForm(Owner).ClientHandle, GWL_WNDPROC));
     SetWindowLong(TForm(Owner).ClientHandle, GWL_WNDPROC, Longint(FClientInstance));
     InvalidateRect(TForm(Owner).ClientHandle, nil, True);
    end;
 end;

Procedure TMDIBackground.SetWallPaper(Value : TPicture);
  Begin
   FPicture.Assign(Value);
   {Invalidate;}
  end;

procedure TMDIBackground.NewClientWndProc(var Message: TMessage);
 Var
  SaveHandle: HDC;
  Obj : TObject;
 begin
  Obj:=FPicture.Graphic;
  with Message do
    If (Msg = WM_ERASEBKGND) {and Assigned(Application.MainForm)} and
       Assigned(Obj)
     then
      begin
       SaveHandle:=Application.MainForm.Canvas.Handle;
       Application.MainForm.Canvas.Handle:=TWMEraseBkGnd(Message).DC;
       PaintOnCanvas(Application.MainForm.Canvas,Application.MainForm.ClientRect,FPicture);
       Application.MainForm.Canvas.Handle:=SaveHandle;
       {FillRect(TWMEraseBkGnd(Message).DC, ClientRect, Brush.Handle);}
       Result := 1;
      end
     else
      Result := CallWindowProc(FDefClientProc, TForm(Owner).ClientHandle, Msg, wParam, lParam);
 end;

 constructor TBackPanel.Create(AOwner: TComponent);
  Begin
   Inherited Create(AOwner);
   FPicture:=TPicture.Create;
  end;

 Destructor  TBackPanel.Destroy;
  Begin
   FPicture.Free;
   Inherited Destroy;
  end;

 Procedure TBackPanel.SetWallPaper(Value : TPicture);
  Begin
   FPicture.Assign(Value);
   Invalidate;
  end;

procedure TBackPanel.Paint;
 Var
  TopColor, BottomColor: TColor;
  CRect : TRect;

 Procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;
 Begin

  CRect:=ClientRect;
  PaintOnCanvas(Canvas, ClientRect, FPicture);
  if BevelOuter <> bvNone then
   begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, CRect, TopColor, BottomColor, BevelWidth);
   end;
  Frame3D(Canvas, CRect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
   begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, CRect, TopColor, BottomColor, BevelWidth);
   end;
 end;

Procedure PaintOnCanvas(aCanvas : TCanvas; PaintRect : TRect; Pict : TPicture);
 var
  PctSize : TPoint;
  BX,BY  : Integer;

 Begin
  {Inherited Paint;}

  with aCanvas do
   begin
    If Assigned(Pict) and (Pict.Graphic <> Nil)
     then
      Begin
       PctSize := Point(Pict.Width, Pict.Height);
       BX:=PaintRect.Left;
       While BX < PaintRect.Right do
        Begin
         BY:=PaintRect.Top;
         While BY < PaintRect.Bottom do
          Begin
           Draw(BX, BY, Pict.Graphic);
           Inc(BY,PctSize.Y);
          end;
          Inc(BX,PctSize.X);
        end;
      end
     {else
      Begin
       Brush.Color := Color;
       FillRect(PaintRect);
      end};
   end;
 end;

procedure Register;
 begin
  RegisterComponents('Additional', [TBackPanel]);
 end;

end.
