unit IWRegion;

interface

uses
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  {$IFDEF Linux}QForms,{$ELSE}Forms,{$ENDIF}
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  {$IFDEF Linux}Qt, Types,{$ELSE}Windows, Messages,{$ENDIF}
  Classes,
  IWContainer, IWControl, IWHTMLTag, IWLayoutMgr, IWCompRectangle,
  IWLayoutMgrForm;

type
  TIWRegion = class(TIWContainer)
  protected
    FCanvas: TControlCanvas;
    FRectangle: TIWRectangle;
    //
    {$IFDEF Linux}
    procedure Painting(Sender: QObjectH; EventRegion: QRegionH); override;
    procedure Resize; override;
    {$ELSE}
    procedure Resizing(State: TWindowState); override;
    {$IFNDEF RUNTIME}
    procedure PaintWindow(ADC: HDC); override;
    {$ENDIF}
    {$ENDIF}
    procedure Loaded; override;
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
    procedure RequestAlign; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Rectangle: TIWRectangle read FRectangle;
  published
    property Align;
    property Anchors;
    property TabOrder;
    property Color: TColor read GetColor write SetColor;
  end;

implementation

uses
  IWForm,
  SWSystem, SysUtils;

{ TIWRegion }

constructor TIWRegion.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if csDesigning in ComponentState then begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
    ControlState := [csCustomPaint];
    {$IFNDEF Linux}
    DoubleBuffered := true;
    {$ENDIF}
    {$IFDEF Linux}
    VertScrollBar.Visible := false;
    HorzScrollBar.Visible := false;
    {$ENDIF}
    FRectangle := nil;
  end
  else begin
    FRectangle := TIWRectangle.Create(Owner);
  end;
  Width := 20;
  Height := 20;
  Color := clNone;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents, csSetCaption, csDoubleClicks];
  Visible := True;
end;

destructor TIWRegion.Destroy;
begin
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

procedure TIWRegion.Loaded;
{Var
  i: Integer;}
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then begin
    {if Form is TIWForm and ((TIWForm(Form).TemplateProcessor = nil) or
      (TIWForm(Form).TemplateProcessor is TIWLayoutMgrForm)) then begin}
      FRectangle.Parent := self;
      FRectangle.ComponentIndex := 0;

      (Form as TIWForm).TabOrderList.Insert(0, FRectangle);

      FRectangle.SetBounds(0, 0, Width, Height);
      FRectangle.Align := Align;
      FRectangle.Anchors := Anchors;
      FRectangle.ZIndex := -100;
      FRectangle.Color := Color;
      FRectangle.Text := '';
      FRectangle.Visible := Visible;
    {end
    else begin
      FreeAndNil(FRectangle);
      // Move all controls to the form.
      i := 0;
      while i < ControlCount do begin
        if Controls[i].Parent = self then begin
          Controls[i].Parent := Parent;
        end
        else
          Inc(i);
      end;
    end;}
  end;
end;

{$IFNDEF Linux}
{$IFNDEF RUNTIME}
procedure TIWRegion.PaintWindow(ADC: HDC);
begin
  FCanvas.Lock; try
    FCanvas.Handle := ADC; try
      if Color <> clNone then begin
        FCanvas.Brush.Color := Color;
      end
      else begin
        FCanvas.Brush.Color := clWhite;
      end;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.FillRect(ClientRect);
      FCanvas.Brush.Color := clBlack;
      FCanvas.FrameRect(ClientRect);
    finally FCanvas.Handle := 0; end;
  finally FCanvas.Unlock; end;
end;
{$ENDIF}

procedure TIWRegion.Resizing(State: TWindowState);
begin
  inherited Resizing(State);
  if Assigned(FRectangle) then begin
    FRectangle.SetBounds(0, 0, Width, Height);
  end;
  Invalidate;
end;
{$ENDIF}

{$IFDEF Linux}
procedure TIWRegion.Painting(Sender: QObjectH; EventRegion: QRegionH);
Var
  LPoints: array[0..4] of TPoint; 
begin
  inherited Painting(Sender, EventRegion);
  TControlCanvas(FCanvas).StartPaint;
  try
    if Color <> clNone then begin
      FCanvas.Brush.Color := Color;
    end
    else begin
      FCanvas.Brush.Color := clWhite;
    end;
    FCanvas.Brush.Style := bsSolid;
    FCanvas.FillRect(ClientRect);

    LPoints[0] := Point(0, 0);
    LPoints[1] := Point(Width - 1, 0);
    LPoints[2] := Point(Width - 1, Height - 1);
    LPoints[3] := Point(0, Height - 1);
    LPoints[4] := Point(0, 0);
    FCanvas.Polyline(LPoints);
  finally
    TControlCanvas(FCanvas).StopPaint;
  end;
end;

procedure TIWRegion.Resize;
begin
  inherited Resize;
  if Assigned(FRectangle) then begin
    FRectangle.SetBounds(0, 0, Width, Height);
  end;
  Invalidate;
end;
{$ENDIF}

function TIWRegion.GetColor: TColor;
begin
  result := inherited Color;
end;

procedure TIWRegion.SetColor(const Value: TColor);
begin
  inherited Color := Value;

  if Assigned(FRectangle) then begin
    FRectangle.Color := Value;
  end;
end;

procedure TIWRegion.RequestAlign;
begin
  inherited RequestAlign;
  if Assigned(FRectangle) then begin
    FRectangle.Visible := Visible;
    FRectangle.SetBounds(0, 0, Width, Height);
  end;
end;

end.
