unit NonrectangularForm;

interface
Uses Windows, Graphics, Forms, Controls, Dialogs, SysUtils, Types,
     l3Forms, l3Region;

const
  cTransparentColor = $123456;

type

 TNonrectangularForm = class(Tl3Form)
 private
  f_Region: Tl3Region;
  f_BorderColor: TColor;
  procedure pm_SetBorderColor(Value: TColor);
 protected
  procedure Cleanup; override;
  procedure DoCreate; override;
  procedure CreateParams(var Params: TCreateParams); override;
  procedure Paint; override;
  procedure TuneRegion(aRegion: Tl3Region); virtual;
 public
  property BorderColor: TColor
   read f_BorderColor
   write pm_SetBorderColor;
 end;

implementation

procedure TNonrectangularForm.DoCreate;
begin
 BorderStyle := bsNone;
 f_BorderColor := clSilver;
 if SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED) = 0 then
   ShowMessage(SysErrorMessage(GetLastError));
  if not SetLayeredWindowAttributes(Handle, cTransparentColor, 128, LWA_COLORKEY) then
   ShowMessage(SysErrorMessage(GetLastError));
  inherited ;
end;

procedure TNonrectangularForm.Cleanup;
begin
 FreeAndNil(f_Region);
 inherited ;
end;

procedure TNonrectangularForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_POPUP;
end;

procedure TNonrectangularForm.pm_SetBorderColor(Value: TColor);
begin
 if f_BorderColor <> Value then
 begin
  f_BorderColor := Value;
  Invalidate;
 end;
end;

procedure TNonrectangularForm.TuneRegion(aRegion: Tl3Region);
var
 l_R : Tl3Region;
const
 cSpace = 16;
begin
 l_R := Tl3Region.Create;
 try
  l_R.Rgn := CreateRoundRectRgn(Left + cSpace, Top, Width, Height, cSpace, cSpace);
  aRegion.Combine(l_R, RGN_OR);
 finally
  FreeAndNil(l_R);
 end;
end;

procedure TNonrectangularForm.Paint;
begin
 Canvas.Pen.Style := psSolid;
 Canvas.Brush.Color := cTransparentColor;
 Canvas.FillRect(Rect(0, 0, Width, Height));
 Canvas.Brush.Color := Self.Color;
 try
  if f_Region = nil then
  begin
   f_Region := Tl3Region.Create;
   f_Region.Rgn := CreateRectRgnIndirect(Rect(0, 0, Width-1, Height-1));
  end;

  // Это временное решение. Планируется:
  //   1) TuneRegion() вынести за пределы Paint-а
  //   2) f_Region надо заменить на TvgPath
  TuneRegion(f_Region);

  PaintRgn(Canvas.Handle, f_Region.Rgn);
  Canvas.Brush.Color := f_BorderColor;
  FrameRgn(Canvas.Handle, f_Region.Rgn, Canvas.Brush.Handle, 2, 2);
 finally
  FreeAndNil(f_Region);
 end;
 inherited ;
end;

end.
