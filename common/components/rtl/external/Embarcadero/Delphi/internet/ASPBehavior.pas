{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit ASPBehavior;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.OleCtrls,
  Winapi.ActiveX, SHDocVw, MSHTML, mshtmcid, idoc, System.Contnrs, System.Variants,
  System.Win.ComObj, WebBrowserEx, System.Win.ComObjWrapper, WBComp;

type
  TASPBehaviorEvents = class(TBehaviorElementEvents)
  protected
    function DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps: tagDISPPARAMS; pDispIds: PDispIDList;
      VarResult: Pointer; ExcepInfo: Pointer; ArgErr: Pointer): HRESULT; override;
  end;

  TASPBehavior = class(TCustomPaintedBehavior)
  private
    FDenoteASPControl: Boolean;
    FBitmap: TBitmap;
  protected
    procedure DoCanvasCreated; override;
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    function GetElementEventsClass: TBehaviorElementEventsClass; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    property DenoteASPControl: Boolean read FDenoteASPControl write FDenoteASPControl;
  end;

  TShowTagsBehaviorWrapper = class(TBehaviorWrapper)
  private
    FIgnoreTags: TStringList;
    FTagColor: TColor;
    procedure SetIgnoreTags(const Value: TStringList);
  protected
    procedure DoCreated(const ComObj: TWrappedComObject); override;
    function GetComClass: TComClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property IgnoreTags: TStringList read FIgnoreTags write SetIgnoreTags;
    property TagColor: TColor read FTagColor write FTagColor default clGray;
  end;

  TShowTagsBehavior = class(TCustomPaintedBehavior)
  private
    FTagBehaviorWrapper: TShowTagsBehaviorWrapper;
  protected
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    procedure DoCanvasCreated; override;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

  TTagBehavior = class(TCustomPaintedBehavior)
  private
    FTag: IHTMLElement;
    procedure SetTag(const Value: IHTMLElement);
  protected
    procedure DoCanvasCreated; override;
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    function Detach: HRESULT; override; stdcall;
  public
    property Tag: IHTMLElement read FTag write SetTag;
  end;

  TRulerOption = (roLeft, roTop, roBottom, roRight);
  TRulerOptions = set of TRulerOption;

  TRulerBehavior = class(TCustomPaintedBehavior)
  private
    FShowLabels: Boolean;
    FRulerOptions: TRulerOptions;
    FIncrement: Integer;
    FLabelColor: TColor;
    FTickColor: TColor;
    procedure SetRulerOptions(const Value: TRulerOptions);
    procedure SetShowLabels(const Value: Boolean);
    procedure SetIncrement(const Value: Integer);
    procedure SetLabelColor(const Value: TColor);
    procedure SetTickColor(const Value: TColor);
  protected
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    procedure DoCanvasCreated; override;
    procedure Refresh;
  public
    procedure Initialize; override;
    property Increment: Integer read FIncrement write SetIncrement;
    property LabelColor: TColor read FLabelColor write SetLabelColor;
    property RulerOptions: TRulerOptions read FRulerOptions write SetRulerOptions;
    property ShowLabels: Boolean read FShowLabels write SetShowLabels;
    property TickColor: TColor read FTickColor write SetTickColor;
  end;

  TMessageBehavior = class(TCustomPaintedBehavior)
  private
    FFont: TFont;
    FMessage: string;
    procedure SetFont(const Value: TFont);
    procedure SetMessage(const Value: string);
  protected
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    procedure FontChanged(Sender: TObject);
  public
    procedure Initialize; override;
    destructor Destroy; override;
    property Font: TFont read FFont write SetFont;
    property Message: string read FMessage write SetMessage;
  end;

  TFocusBehavior = class(TCustomPaintedBehavior)
  protected
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    procedure DoCanvasCreated; override;
  end;

  TEditFocusBehavior = class(TCustomPaintedBehavior)
  protected
    function DoDraw(const BoundsRect, UpdateRect: TRect;
      const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT; override;
    procedure DoCanvasCreated; override;
    function Detach: HRESULT; override;
    function GetPainterInfo(out pInfo: _HTML_PAINTER_INFO): HRESULT; override;
  end;

implementation

uses Mshtmdid, Vcl.Forms, Vcl.Dialogs, System.Types;

{$R behavior.res}

{ TASPBehaviorEvents }

function TASPBehaviorEvents.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: tagDISPPARAMS;
  pDispIds: PDispIDList; VarResult, ExcepInfo, ArgErr: Pointer): HRESULT;
begin
  Result := inherited DoInvoke(DispID, IID, LocaleID, Flags, dps, pDispIds,
    VarResult, ExcepInfo, ArgErr);
  case DispID of
    // ASP Behaviors cannot receive edit focus so we prevent it here.
    // Use frozen attribute instead
    DISPID_HTMLELEMENTEVENTS_ONBEFOREEDITFOCUS: ; // OleVariant(VarResult^) := WordBool(False);
  end;
end;

{ TASPBehavior }

destructor TASPBehavior.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TASPBehavior.DoCanvasCreated;
begin
  inherited;
  Canvas.Font.Name := 'Small Fonts';
  Canvas.Font.Size := 7;
  Canvas.Font.Style := [];
  Canvas.Font.Color := clRed;
  Canvas.Brush.Style := bsSolid;
end;

function TASPBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
begin
  Result := S_OK;
  if not FDenoteASPControl then exit;
  Canvas.Draw(BoundsRect.Left, BoundsRect.Top, FBitmap);
end;

function TASPBehavior.GetElementEventsClass: TBehaviorElementEventsClass;
begin
  Result := TASPBehaviorEvents;
end;

procedure TASPBehavior.Initialize;
begin
  inherited;
  FDenoteASPControl := True;
  FBitmap := TBitmap.Create;
  FBitmap.TransparentColor := clFuchsia;
  FBitmap.Transparent := True;
  FBitmap.LoadFromResourceName(hInstance, 'ASPBEHAVIOR');
  ExpandRect := Rect(4,2,0,0);
end;

{ TShowTagsBehavior }

destructor TShowTagsBehavior.Destroy;
begin
  inherited;
end;

procedure TShowTagsBehavior.DoCanvasCreated;
begin
  inherited;
  Canvas.Font.Name := 'Small Fonts';
  Canvas.Font.Size := 6;
  Canvas.Font.Style := [];
end;

function TShowTagsBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
var
  E: IHTMLElement;
  C: IHTMLElementCollection;
  I: Integer;
  BgTag: string;
  EndTag: string;
  TagWidth: Integer;
  TagHeight: Integer;
  OffsetLeft, OffsetTop: Integer;
begin
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if (Result = S_OK) and Supports(Element.all, IHTMLElementCollection, C) then
  begin
    if Assigned(FTagBehaviorWrapper) then
      Canvas.Font.Color := FTagBehaviorWrapper.TagColor
    else
      Canvas.Font.Color := clGray;
    Canvas.Brush.Style := bsClear;
    TagHeight := Canvas.TextHeight(Element.tagName);
    for I := 0 to C.length - 1 do
    begin
      E := C.item(i, i) as IHTMLElement;
      OffsetLeft := E.offsetLeft;
      OffsetTop := E.offsetTop;
      if OffsetTop > Abs(BoundsRect.Top) + UpdateRect.Bottom then continue;
      if Assigned(FTagBehaviorWrapper) then
        if FTagBehaviorWrapper.IgnoreTags.IndexOf(E.tagName) >= 0 then continue;
      while E.tagName <> 'BODY' do
      begin
        E := E.offsetParent;
        Inc(OffsetLeft, E.offsetLeft);
        Inc(OffsetTop, E.offsetTop);
      end;
      E := C.item(i, i) as IHTMLElement;
      OffsetLeft := OffsetLeft + BoundsRect.Left;
      OffsetTop := OffsetTop + BoundsRect.Top;
      BgTag := '<' + E.tagName + '>';
      EndTag := '</' + E.tagName + '>';
      TagWidth := Canvas.TextWidth(BgTag);
      if UpdateRect.Contains(Point(OffsetLeft, OffsetTop)) or
         UpdateRect.Contains(Point(OffsetLeft + E.offsetWidth - TagWidth, OffsetTop + E.offsetHeight - TagHeight)) or
         UpdateRect.Contains(Point(OffsetLeft + E.offsetWidth - TagWidth, OffsetTop + E.offsetHeight - TagHeight + 4)) then
      begin
                                                                                        
        if CompareText(E.tagName, 'B') = 0 then
          Canvas.TextOut(OffsetLeft, OffsetTop - 4, BgTag)
        else
        if CompareText(E.tagName, 'TABLE') = 0 then
          Canvas.TextOut(OffsetLeft, OffsetTop - 4, BgTag)
        else
        if CompareText(E.tagName, 'TR') = 0 then
          Canvas.TextOut(OffsetLeft, OffsetTop, BgTag)
        else
        if CompareText(E.tagName, 'TD') = 0 then
          Canvas.TextOut(OffsetLeft, OffsetTop, BgTag)
        else
          Canvas.TextOut(OffsetLeft, OffsetTop, BgTag);
        // Drawing end tags will require caching of end tags that didn't get painted
        // in the previous call (when a prior band was painted)
        TagWidth := Canvas.TextWidth(EndTag);
        if CompareText(E.tagName, 'HR') = 0 then
          Continue
        else
        if CompareText(E.tagName, 'BR') = 0 then
          Continue
        else
        if CompareText(E.tagName, 'TABLE') = 0 then
          Canvas.TextOut(OffsetLeft + E.offsetWidth - TagWidth, OffsetTop + E.offsetHeight - TagHeight + 4, EndTag)
        else
          Canvas.TextOut(OffsetLeft + E.offsetWidth - TagWidth, OffsetTop + E.offsetHeight - TagHeight, EndTag);
      end
    end;
  end;
end;

procedure TShowTagsBehavior.Initialize;
begin
  inherited;
  PaintZOrder :=  pzWindowTop;
  PainterFlags := PainterFlags + [pfOverlay];
end;

{ TShowTagsBehaviorWrapper }

constructor TShowTagsBehaviorWrapper.Create(AOwner: TComponent);
begin
  inherited;
  FTagColor := clGray;
  FIgnoreTags := TStringList.Create;
  FIgnoreTags.Sorted := True;
  FIgnoreTags.Add('TBODY');
  FIgnoreTags.Add('!');
  FIgnoreTags.Add('SCRIPT');
  FIgnoreTags.Add('STYLE');
end;

destructor TShowTagsBehaviorWrapper.Destroy;
begin
  FIgnoreTags.Free;
  inherited;
end;

procedure TShowTagsBehaviorWrapper.DoCreated(const ComObj: TWrappedComObject);
begin
  inherited;
  if ComObj is TShowTagsBehavior then
    with ComObj as TShowTagsBehavior do
      FTagBehaviorWrapper := Self;
end;

function TShowTagsBehaviorWrapper.GetComClass: TComClass;
begin
  Result := TShowTagsBehavior;
end;

procedure TShowTagsBehaviorWrapper.SetIgnoreTags(const Value: TStringList);
begin
  FIgnoreTags.Assign(Value);
end;

{ TTagBehavior }

function TTagBehavior.Detach: HRESULT;
begin
  FTag := nil;
  Result := inherited Detach;
end;

function InRect(P: TPoint; R: TRect): Boolean;
begin
  Result := (P.X >= R.Left) and (P.X <= R.Right) and (P.Y >= R.Top) and (P.Y <= R.Bottom);
end;

{function InRect(P: TPoint; BoundsRect, UpdateRect: TRect): Boolean;
var
  R: TRect;
begin
  R := Rect(UpdateRect.Left + Abs(BoundsRect.Left), UpdateRect.Top + Abs(BoundsRect.Top),
    UpdateRect.Right, UpdateRect.Bottom);
  Result := (P.X >= R.Left) and (P.X <= R.Right) and (P.Y >= R.Top) and (P.Y <= R.Bottom);
end;}

procedure TTagBehavior.DoCanvasCreated;
begin
  inherited;
  Canvas.Font.Name := 'Small Fonts';
  Canvas.Font.Style := [];
  Canvas.Font.Size := 7;
  Canvas.Font.Color := clRed;
  Canvas.Brush.Style := bsClear;
end;

function TTagBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
var
  OffsetLeft, OffsetTop: Integer;
  E: IHTMLElement;
  E2: IHTMLElement2;
  R, InterRect: TRect;
  Top: Integer;
  TagText: string;
begin
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if (Result = S_OK) and Assigned(Tag) then
  begin
    OffsetLeft := Tag.offsetLeft;
    OffsetTop := Tag.offsetTop;
    E := Tag;
    while Assigned(E) and (E.tagName <> 'BODY') do
    begin
      E := E.offsetParent;
      if Assigned(E) then
      begin
        Inc(OffsetLeft, E.offsetLeft);
        Inc(OffsetTop, E.offsetTop);
      end;
    end;
    E2 := E as IHTMLElement2;
    Inc(OffsetLeft, -E2.scrollLeft);
    Inc(OffsetTop, -E2.scrollTop);
    R := Rect(OffsetLeft, OffsetTop, OffsetLeft + Canvas.TextWidth(Tag.tagName),
      OffsetTop + Canvas.TextHeight(Tag.tagName));
    Top := Abs(BoundsRect.Top) - E2.scrollTop;
    TagText := '<' + Tag.tagName + '>';
    if IntersectRect(InterRect, R, Rect(UpdateRect.Left, Top,
       UpdateRect.Right, Abs(BoundsRect.Top) + UpdateRect.Bottom - E2.scrollLeft)) then
      Canvas.TextOut(OffsetLeft, OffsetTop - Top, Tag.tagName);
{    Canvas.MoveTo(OffsetLeft, OffsetTop + 5);
    Canvas.LineTo(OffsetLeft, OffsetTop);
    Canvas.LineTo(OffsetLeft + 5, OffsetTop);
    Canvas.MoveTo(OffsetLeft + E.offsetWidth, E.offsetHeight);
    Canvas.LineTo(0,0);
    Canvas.LineTo(5,0);}
  end;
end;

procedure TTagBehavior.SetTag(const Value: IHTMLElement);
begin
  if Value <> FTag then
  begin
    FTag := Value;
    PaintSite.InvalidateRect(nil);
  end;
end;

{ TRulerBehavior }

procedure TRulerBehavior.DoCanvasCreated;
begin
  inherited;
  Canvas.Pen.Color := FTickColor;
  Canvas.Font.Name := 'Small Fonts';
  Canvas.Font.Size := 7;
  Canvas.Font.Color := FLabelColor;
  Canvas.Brush.Style := bsClear;
end;

function TRulerBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
var
  W, I: Integer;
  S: string;
begin
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if Result = S_OK then
  begin
    // Top/Bottom Ruler
    if (roTop in RulerOptions) or (roBottom in RulerOptions) then
    begin
      I := 0;
      if Element2.scrollLeft <> 0 then
        I := -10 - Element2.scrollLeft mod 10;
      Canvas.Font.Orientation := 0;
      while I <= UpdateRect.Right do
      begin
        if (roTop in RulerOptions) and (Abs(BoundsRect.Top) = Element2.scrollTop) then
        begin
          Canvas.MoveTo(I, 0);
          if (I + Element2.scrollLeft) mod 50 = 0 then
          begin
            Canvas.LineTo(I, 7);
            if ShowLabels and (I <> 0) and ((I + Element2.scrollLeft) mod 100 = 0) then
            begin
              S := IntToStr(I + Element2.scrollLeft);
              W := Canvas.TextWidth(S);
              Canvas.TextOut(I - 2 - W, 3, S);
            end;
          end
          else
            Canvas.LineTo(I, 3);
        end;
        if (roBottom in RulerOptions) and
           (Abs(BoundsRect.Top) - Element2.scrollTop + UpdateRect.Bottom >= Element2.clientHeight) then
        begin
          Canvas.MoveTo(I, UpdateRect.Bottom + 1);
          if (I + Element2.scrollLeft) mod 50 = 0 then
          begin
            Canvas.LineTo(I, UpdateRect.Bottom - 7);
            if ShowLabels and (I <> 0) and ((I + Element2.scrollLeft) mod 100 = 0) then
            begin
              S := IntToStr(I + Element2.scrollLeft);
              W := Canvas.TextWidth(S);
              Canvas.TextOut(I - 2 - W, UpdateRect.Bottom - 4 - Canvas.TextHeight(S), S);
            end;
          end
          else
            Canvas.LineTo(I, UpdateRect.Bottom - 4);
        end;
        Inc(I, 5);
      end;
    end;
    // Left/Right Ruler
    if (roLeft in RulerOptions) or (roRight in RulerOptions) then
    begin
      Canvas.Font.Orientation := 900;
      I := 0;
      if Element2.scrollTop <> 0 then
        I := -10 - Element2.scrollTop mod 10;
      while I <= UpdateRect.Bottom do
      begin
        if roLeft in RulerOptions then
        begin
          Canvas.MoveTo(0, I);
          if (I + Element2.scrollTop) mod 50 = 0 then
          begin
            Canvas.LineTo(7, I);
            if ShowLabels and (I <> 0) and ((I + Abs(BoundsRect.Top)) mod 100 = 0) then
            begin
              S := IntToStr(I + Abs(BoundsRect.Top));
              Canvas.TextOut(4, I - 2, S);
            end;
          end
          else
            Canvas.LineTo(4, I);
        end;
        if roRight in RulerOptions then
        begin
          Canvas.MoveTo(UpdateRect.Right - 6, I);
          if (I + Element2.scrollTop) mod 50 = 0 then
          begin
            Canvas.LineTo(UpdateRect.Right, I);
            if ShowLabels and (I <> 0) and ((I + Abs(BoundsRect.Top)) mod 100 = 0) then
            begin
              S := IntToStr(I + Abs(BoundsRect.Top));
              Canvas.TextOut(UpdateRect.Right - Canvas.TextWidth(S), I - 2, S);
            end;
          end
          else
          begin
            Canvas.MoveTo(UpdateRect.Right - 3, I);
            Canvas.LineTo(UpdateRect.Right, I);
          end;
        end;
        Inc(I, 5);
      end;
    end;
  end;
end;

procedure TRulerBehavior.Initialize;
begin
  inherited;
  FRulerOptions := [roLeft, roTop];
  FShowLabels := True;
  FLabelColor := clGray;
  FTickColor := clLtGray;
  PaintZOrder := pzBelowContent;
end;

procedure TRulerBehavior.Refresh;
begin
  if Assigned(PaintSite) then
    PaintSite.InvalidateRect(nil);
end;

procedure TRulerBehavior.SetIncrement(const Value: Integer);
begin
  if FIncrement <> Value then
  begin
    FIncrement := Value;
    Refresh;
  end;
end;

procedure TRulerBehavior.SetLabelColor(const Value: TColor);
begin
  if FLabelColor <> Value then
  begin
    FLabelColor := Value;
    if Assigned(Canvas) then
      Canvas.Font.Color := FLabelColor;
    Refresh;
  end;
end;

procedure TRulerBehavior.SetRulerOptions(const Value: TRulerOptions);
begin
  if FRulerOptions <> Value then
  begin
    FRulerOptions := Value;
    Refresh;
  end;
end;

procedure TRulerBehavior.SetShowLabels(const Value: Boolean);
begin
  if FShowLabels <> Value then
  begin
    FShowLabels := Value;
    Refresh;
  end;
end;

procedure TRulerBehavior.SetTickColor(const Value: TColor);
begin
  if FTickColor <> Value then
  begin
    FTickColor := Value;
    if Assigned(Canvas) then
      Canvas.Pen.Color := FTickColor;
    Refresh;
  end;
end;

{ TMessageBehavior }

destructor TMessageBehavior.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TMessageBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
var
  TextRect: TRect;
  E2: IHTMLElement2;
begin
// Testing remove later
  OutputDebugString(PChar(Format('TMessageBehavior.DoDraw Message: %s', [Message])));
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if Result <> S_OK then exit;

  (* Use grid behavior painting
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(FFont);
  TextRect.Left := 0;
  E2 := Element2;
  TextRect.Right := BoundsRect.Right - E2.scrollLeft;
  DrawText(Canvas.Handle, PChar(Message), Length(Message), TextRect, DT_CALCRECT or DT_CENTER);
  OffsetRect(TextRect, E2.clientWidth div 2 - TextRect.Right div 2,
    E2.scrollTop + E2.ClientHeight div 2 + BoundsRect.Top);
  DrawText(Canvas.Handle, PChar(Message), Length(Message), TextRect, DT_CENTER);
  *)

  if Length(Message) > 0 then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clWhite;
    Canvas.Font.Color := clRed;
    E2 := Element2;
    TextRect := Rect(25, 0, BoundsRect.Right - E2.scrollLeft - 25, BoundsRect.Bottom);
    DrawText(Canvas.Handle, PChar(Message), Length(Message), TextRect, DT_CALCRECT or DT_CENTER or DT_WORDBREAK);
    OffsetRect(TextRect, E2.clientWidth div 2 - TextRect.Right div 2,
      (E2.scrollTop + E2.ClientHeight div 2 + BoundsRect.Top) - (TextRect.Bottom - TextRect.Top) div 2);
    DrawText(Canvas.Handle, PChar(Message), Length(Message), TextRect, DT_CENTER or DT_WORDBREAK);
  end;

end;

procedure TMessageBehavior.FontChanged(Sender: TObject);
begin
  InvalidatePainterInfo;
end;

procedure TMessageBehavior.Initialize;
begin
  inherited;
  FFont := TFont.Create;
  FFont.Name := 'Tahoma';  { do not localize }
  FFont.Color := clGray;
  FFont.OnChange := FontChanged;
end;

procedure TMessageBehavior.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TMessageBehavior.SetMessage(const Value: string);
begin
  FMessage := Value;
  InvalidatePainterInfo;
end;

{ TFocusBehavior }

procedure TFocusBehavior.DoCanvasCreated;
begin
  inherited;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 2;
  Canvas.Pen.Color := clBlack;
end;

function TFocusBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
begin
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if (Result <> S_OK) then exit;
  Canvas.Rectangle(BoundsRect);
end;

{ TEditFocusBehavior }

var
  FExpandFocusRectWidth: Integer = 3;
  FExpandFocusRectHeight: Integer = 3;
procedure TEditFocusBehavior.DoCanvasCreated;
begin
  inherited;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Width := 1;
  //Canvas.Pen.Color := clBlack;
  Canvas.Pen.Color := clRed; // testing
end;

var
  LTemp: Integer;
function TEditFocusBehavior.Detach: HRESULT;
var
  LHtmlStyle: IHTMLStyle;
  LWidth1: Integer;
  LWidth2: Integer;
  LHTMLElement2: IHTMLElement2;
begin
  // Testing change to runtime width
  LHTMLElement2 := Self.Element2;
  LHtmlStyle :=  LHTMLElement2.runtimeStyle;
  LWidth1 := LHtmlStyle.pixelWidth;
  Result := inherited Detach;
  LWidth2 := LHtmlStyle.pixelWidth;
  LTemp := LWidth1 + LWidth2;
end;

function TEditFocusBehavior.GetPainterInfo(out pInfo: _HTML_PAINTER_INFO): HRESULT;
begin
  Result := inherited GetPainterInfo(pInfo);
  pInfo.rcExpand.Top := FExpandFocusRectHeight;
  pInfo.rcExpand.Bottom := FExpandFocusRectHeight;
  pInfo.rcExpand.Left := FExpandFocusRectWidth;
  pInfo.rcExpand.Right := FExpandFocusRectWidth;
end;

function TEditFocusBehavior.DoDraw(const BoundsRect, UpdateRect: TRect;
  const DrawFlags: TPainterDrawFlags; DrawObject: Pointer): HRESULT;
begin
  Result := inherited DoDraw(BoundsRect, UpdateRect, DrawFlags, DrawObject);
  if (Result <> S_OK) then exit;
  Canvas.Rectangle(BoundsRect);
end;


end.
