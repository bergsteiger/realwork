unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    f_Edit: TWinControl;
  public
    { Public declarations }
  end;

  TXEdit = class(TEdit)
  private
    FFocusedBorder: Boolean;
    f_ImageRGN: HRGN;
   procedure WMNCPaint(var Msg: TWMNCPaint);
    message WM_NCPAINT;
   procedure WMNCCalcSize(var Msg: TWMNCCalcSize);
    message WM_NCCALCSIZE;
   procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd);
    message WM_ERASEBKGND;
   procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
   procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
   procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
   procedure UpdateWindowRegion;
   procedure SetFocusedBorder(const Value: Boolean);
   procedure ClearImageRGN;
   function GetImageRGN: HRGN;
   function TestThemeAvail: Boolean;
  protected
   procedure CreateParams(var Params: TCreateParams); override;
   procedure CreateWnd; override;
   procedure DestroyWnd; override;
   procedure Resize; override;
   property FocusedBorder: Boolean read FFocusedBorder write SetFocusedBorder;
//   procedure Paint; override;
  public
   constructor Create(aComponent: TComponent); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Themes;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Color := not Color;
end;

{ TXEdit }

const cBorder = 3;

procedure TXEdit.ClearImageRGN;
begin
 if f_ImageRGN <> 0 then
 begin
  DeleteObject(f_ImageRGN);
  f_ImageRGN := 0;
 end;
end;

procedure TXEdit.CMParentColorChanged(var Message: TMessage);
begin
 inherited;
 RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
end;

constructor TXEdit.Create(aComponent: TComponent);
begin
 inherited Create(aComponent);
 ControlStyle := ControlStyle - [csOpaque];
 Width := Width + 2*Height + cBorder * 2;
 Height := Height + cBorder * 2;
 AutoSize := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 l_Edit: TWinControl;
begin
 l_Edit := TXEdit.Create(Self);
 l_Edit.Top := 100;
 l_Edit.Left := 150;
 l_Edit.Parent := Self;
// l_Edit.Ctl3D := False;

 l_Edit := TXEdit.Create(Self);
 l_Edit.Top := 200;
 l_Edit.Left := 150;

 l_Edit.Parent := Self;
 f_Edit := l_Edit;
// l_Edit.Ctl3D := False;
end;

procedure TXEdit.CreateParams(var Params: TCreateParams);
begin
 inherited;
// Params.WindowClass.style := Params.WindowClass.style or CS_PARENTDC;
end;
(*
procedure TXEdit.Paint;
begin
 Canvas.Brush.Color := clRed;
 Canvas.FillRect(ClientRect);
end;
  *)
procedure TXEdit.CreateWnd;
begin
 inherited;
 if not TestThemeAvail then
  UpdateWindowRegion;
end;

procedure TXEdit.DestroyWnd;
begin
 inherited;
 ClearImageRGN;
end;

function TXEdit.GetImageRGN: HRGN;
var
 l_DrawRect: TRect;
 l_ClientRect: TRect;
begin
 if (f_ImageRGN = 0) and not TestThemeAvail then
 begin
  GetWindowRect(Handle, l_DrawRect);
  OffsetRect(l_DrawRect, -l_DrawRect.Left, -l_DrawRect.Top);


  l_ClientRect := l_DrawRect;
  InflateRect(l_ClientRect, -cBorder, -cBorder);
  InflateRect(l_ClientRect, -(l_ClientRect.Bottom - l_ClientRect.Top), 0);

  if not FocusedBorder then
   InflateRect(l_DrawRect, -cBorder, -cBorder);
  f_ImageRGN := CreateRoundRectRgn(l_DrawRect.Left, l_DrawRect.Top, l_DrawRect.Right, l_DrawRect.Bottom, l_ClientRect.Left - l_DrawRect.Left, (l_DrawRect.Bottom - l_DrawRect.Top));
 end;
 Result := f_ImageRGN;
end;

procedure TXEdit.Resize;
begin
 inherited;
 UpdateWindowRegion;
end;

procedure TXEdit.SetFocusedBorder(const Value: Boolean);
begin
 if FFocusedBorder <> Value then
 begin
  FFocusedBorder := Value;
  UpdateWindowRegion;
  RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE);
 end
end;

function TXEdit.TestThemeAvail: Boolean;
begin
 Result := ThemeServices.ThemesAvailable;
end;

procedure TXEdit.UpdateWindowRegion;
begin
 if not HandleAllocated or TestThemeAvail then
  exit;
 ClearImageRgn;
 SetWindowRgn(Handle, GetImageRGN, True);
end;

procedure TXEdit.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
// inherited;
 Msg.Result := 1;
end;

procedure TXEdit.WMKillFocus(var Message: TWMSetFocus);
begin
 inherited;
 FocusedBorder := False;
end;

procedure TXEdit.WMNCCalcSize(var Msg: TWMNCCalcSize);
begin
 inherited;
 InflateRect(Msg.CalcSize_Params^.rgrc[0], -cBorder - ((Msg.CalcSize_Params^.rgrc[0].Bottom - Msg.CalcSize_Params^.rgrc[0].Top) div 2), -cBorder);
 Msg.Result := 0;
end;

type
 THack = class(TWinControl);

procedure TXEdit.WMNCPaint(var Msg: TWMNCPaint);
var
 l_DC: HDC;
 l_Canvas: TControlCanvas;
 l_Rect: TRect;
 l_DrawRect: TRect;
 l_ClientRect: TRect;
 l_ParentRect: TRect;
 OldP: TPoint;
 P: TPoint;
 l_IDX: Integer;
begin
// inherited;
 Msg.Result := 0;

  l_Canvas := TControlCanvas.Create;
  l_DC := GetWindowDC(Handle);

  l_Canvas.Handle := l_DC;
  GetWindowRect(Handle, l_Rect);
  OffsetRect(l_Rect, -l_Rect.Left, -l_Rect.Top);
  l_ParentRect := l_Rect;

  l_ClientRect := l_Rect;
  InflateRect(l_ClientRect, -cBorder, -cBorder);
  InflateRect(l_ClientRect, -(l_ClientRect.Bottom - l_ClientRect.Top), 0);
//  ExcludeClipRect(l_Canvas.Handle, l_ClientRect.Left, l_ClientRect.Top, l_ClientRect.Right, l_ClientRect.Bottom);

  if TestThemeAvail then
  begin


//    P := Point(l_ClientRect.Left, l_ClientRect.Top);
//    P := Point(17, 5);
    P := Point((l_ClientRect.bottom - l_ClientRect.top) div 2 + 2*cBorder, 2 + cBorder);

//    SetMapMode(l_DC, MM_ANISOTROPIC);
    SetViewPortOrgEx(l_DC, P.x, P.y, @OldP);
    ThemeServices.DrawParentBackground(Handle, l_DC, nil, False, nil);
    SetViewPortOrgEx(l_DC, OldP.x, OldP.y, nil);
//    SetMapMode(l_DC, MM_TEXT);

  end
  else
  begin
   l_Canvas.Pen.Color := THack(Parent).Color;
   l_Canvas.Brush.Color := THack(Parent).Color;
   l_Canvas.FillRect(l_Rect);
  end;

  l_DrawRect := l_Rect;
  if FocusedBorder then
  begin
   l_Canvas.Pen.Color := clBlue;
   l_Canvas.Brush.Color := clBlue;
   for l_IDX := 1 to cBorder do
   begin
    l_Canvas.RoundRect(l_DrawRect.Left, l_DrawRect.Top, l_DrawRect.Right, l_DrawRect.Bottom, l_ClientRect.Left - l_DrawRect.Left, (l_DrawRect.Bottom - l_DrawRect.Top));
    InflateRect(l_DrawRect, -1, -1);
   end;
  end
  else
   InflateRect(l_DrawRect, -cBorder, -cBorder);

  l_Canvas.Brush.Color := Color;
  l_Canvas.Brush.Style := bsSolid;
  l_Canvas.Pen.Color := clRed;

  l_Canvas.RoundRect(l_DrawRect.Left, l_DrawRect.Top, l_DrawRect.Right, l_DrawRect.Bottom, l_ClientRect.Left - l_DrawRect.Left, (l_DrawRect.Bottom - l_DrawRect.Top));

 Msg.Result := 0;
end;

procedure TXEdit.WMSetFocus(var Message: TWMSetFocus);
begin
 inherited;
 FocusedBorder := True;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
 PaintBox1.Canvas.Brush.Color := clRed;
// PaintBox1.Canvas.Chord(50,50,100,100,75,50,75,100);

 PaintBox1.Canvas.RoundRect(50,50,150,72,22,22);

// PaintBox1.Canvas.Arc(50,50,100,100,75,50,75,100);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 if Assigned(f_Edit) then
  f_Edit.Width := Width - f_Edit.Left - 100;
end;

end.
