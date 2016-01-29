{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.TextLayout;

{$MINENUMSIZE 4}

interface

uses
  System.Types, System.UITypes, System.UIConsts, System.Math,
  System.Classes, System.SysUtils, System.StrUtils,
  System.Generics.Collections, System.Generics.Defaults, FMX.Types;

{$SCOPEDENUMS ON}

type
  TTextRange = record
    Pos: Integer;
    Length: Integer;
    constructor Create(APos, ALength: Integer);
  end;

  TTextAttribute = record
  public
    Font: TFont;
    Color: TAlphaColor;
                                 

    constructor Create(const AFont: TFont;
                       AColor : TAlphaColor); overload;

    constructor Create(const AExisting: TTextAttribute;
                       const ANewFont: TFont); overload;

    constructor Create(const AExisting: TTextAttribute;
                       ANewColor: TAlphaColor); overload;
  end;

  TTextAttributedRange = class
  public
    Range: TTextRange;
    Attribute: TTextAttribute;

    constructor Create(ARange: TTextRange; AAttribute : TTextAttribute);
  end;

  TTextLayout = class abstract
  private
    FAttributes: TList<TTextAttributedRange>;
    FFont: TFont;
    FColor: TAlphaColor;
    FText: string;
    FWordWrap : Boolean;
    FHorizontalAlign: TTextAlign;
    FVerticalAlign: TTextAlign;
    FPadding: TBounds;
    FNeedUpdate: Boolean;
    FMaxSize: TPointF;
    FTopLeft: TPointF;
    FUpdating: Integer;
    FOpacity: Single;
    FTrimming: TTextTrimming;
    FRightToLeft: Boolean;
    FCanvas: TCanvas;
    FMessageId: Integer;
    procedure SetMaxSize(const Value: TPointF);
    procedure AttributesChanged(Sender: TObject; const Item: TTextAttributedRange;
      Action: TCollectionNotification);
    procedure ChangedHandler(Sender: TObject);
    function GetAttribute(const Index: Integer): TTextAttributedRange;
    function GetAttributesCount: Integer;
    procedure SetHorizontalAlign(const Value: TTextAlign);
    procedure SetFont(const Value: TFont);
    procedure SetPadding(const Value: TBounds);
    procedure SetText(const Value: string);
    procedure SetWordWrap(const Value: Boolean);
    function GetHeight: Single;
    function GetWidth: Single;
    procedure NeedUpdate;
    procedure SetVerticalAlign(const Value: TTextAlign);
    procedure SetTrimming(const Value: TTextTrimming);
    procedure SetRightToLeft(const Value: Boolean);
    procedure SetCanvas(const Value: TCanvas);
  protected
    procedure DoRenderLayout; virtual; abstract;
    procedure DoDrawLayout(const ACanvas: TCanvas); virtual; abstract;
    function GetTextHeight: Single; virtual; abstract;
    function GetTextWidth: Single; virtual; abstract;
    function GetTextRect: TRectF; virtual; abstract;
    //Get character position from it's coordinates
    function DoPositionAtPoint(const APoint: TPointF): Integer; virtual; abstract;
    //Get region for text range
    function DoRegionForRange(const ARange: TTextRange): TRegion; virtual; abstract;
  public
    constructor Create(const ACanvas: TCanvas = nil); virtual;
    destructor Destroy; override;

    //Attributes
    procedure AddAttribute(const ARange: TTextRange;
                           const AAttribute : TTextAttribute); overload;
    procedure AddAttribute(const AAttributeRange: TTextAttributedRange); overload;
    procedure DeleteAttribute(const AIndex: Integer);
    procedure DeleteAttributeRange(const AFromIndex, AToIndex: Integer);
    procedure ClearAttributes;

    //Render layout with desired opacity
    procedure RenderLayout(const ACanvas: TCanvas);

    //Convert layout to TPathData
    procedure ConvertToPath(const APath: TPathData); virtual; abstract;
    //Get character position from it's coordinates
    function PositionAtPoint(const APoint: TPointF; const RoundToWord: Boolean = False): Integer;
    //Get region for text range
    function RegionForRange(const ARange: TTextRange; const RoundToWord: Boolean = False): TRegion;

    //Restrict frequently updates
    procedure BeginUpdate;
    procedure EndUpdate;

    property LayoutCanvas: TCanvas read FCanvas write SetCanvas;

    ///  <summary>
    ///  List of layout attributes
    ///  </summary>
    property Attributes[const Index: Integer]: TTextAttributedRange read GetAttribute;
    ///  <summary>
    ///  Count of layout attributes
    ///  </summary>
    property AttributesCount: Integer read GetAttributesCount;
    ///  <summary>
    ///  Layout text
    ///  </summary>
    property Text: string read FText write SetText;
    property Padding: TBounds read FPadding write SetPadding;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property HorizontalAlign: TTextAlign read FHorizontalAlign write SetHorizontalAlign;
    property VerticalAlign: TTextAlign read FVerticalAlign write SetVerticalAlign;
    property Color: TAlphaColor read FColor write FColor default TAlphaColorRec.Black;
    property Font: TFont read FFont write SetFont;
    property Opacity: Single read FOpacity write FOpacity;
    ///  <summary>
    ///  Text trimmin options
    ///  </summary>
    property Trimming: TTextTrimming read FTrimming write SetTrimming;
    ///  <summary>
    ///  Layout size limits
    ///  </summary>
    property RightToLeft: Boolean read FRightToLeft write SetRightToLeft;
    property MaxSize: TPointF read FMaxSize write SetMaxSize;
    ///  <summary>
    ///  Coordinates of top-left layout corner.
    ///  </summary>
    ///  <remarks>
    ///  Use this property to change layout position on canvas, which by
    ///  default is (0;0)
    ///  </remarks>
    property TopLeft: TPointF read FTopLeft write FTopLeft;
    //Real size of layout
    property Height: Single read GetHeight;
    property Width: Single read GetWidth;
    //Text size only
    property TextHeight: Single read GetTextHeight;
    property TextWidth: Single read GetTextWidth;
    property TextRect: TRectF read GetTextRect;
  end;

  TTextLayoutClass = class of TTextLayout;

  ETextLayoutManagerException = class(Exception);

  TTextLayoutManager = class sealed
  private type
    TTextLayoutRecord = record
      LayoutClass: TTextLayoutClass;
      CanvasClass: TCanvasClass;
    end;
  strict private
    class var FLayoutList: TList<TTextLayoutRecord>;
    class var FDefaultLayoutClass: TTextLayoutClass;
  private
    class function GetDefaultLayout: TTextLayoutClass; static;
  public
    // Reserved for internal use only - do not call directly!
    class procedure UnInitialize;
    // Register a rendering Text Layout class
    class procedure RegisterTextLayout(const LayoutClass: TTextLayoutClass;
      const CanvasClass: TCanvasClass);
    // Return default Text Layout
    class property DefaultTextLayout: TTextLayoutClass read GetDefaultLayout;
    // Return Text Layout by type of Canvas
    class function TextLayoutByCanvas(const ACanvasClass: TClass): TTextLayoutClass;
  end;

implementation

uses
  System.TypInfo, FMX.Consts, FMX.Text, FMX.Messages;

{ TTextRange }

constructor TTextRange.Create(APos, ALength: Integer);
begin
  Pos := APos;
  Length := ALength;
end;

{ TTextAttribute }

constructor TTextAttribute.Create(const AFont: TFont; AColor: TAlphaColor);
begin
  Self.Font := AFont;
  Self.Color := AColor;
end;

constructor TTextAttribute.Create(const AExisting: TTextAttribute;
  const ANewFont: TFont);
begin
  Self := AExisting;
  Self.Font := ANewFont;
end;

constructor TTextAttribute.Create(const AExisting: TTextAttribute;
  ANewColor: TAlphaColor);
begin
  Self := AExisting;
  Self.Color := ANewColor;
end;

{ TTextAttributedRange }

constructor TTextAttributedRange.Create(ARange: TTextRange;
  AAttribute: TTextAttribute);
begin
  Self.Range := ARange;
  Self.Attribute := AAttribute;
end;

{ TTextLayout }

procedure TTextLayout.AddAttribute(const AAttributeRange: TTextAttributedRange);
begin
  FAttributes.Add(AAttributeRange);
end;

procedure TTextLayout.AddAttribute(const ARange: TTextRange;
  const AAttribute: TTextAttribute);
begin
  FAttributes.Add(TTextAttributedRange.Create(ARange, AAttribute));
end;

procedure TTextLayout.ClearAttributes;
begin
  FAttributes.Clear;
end;

constructor TTextLayout.Create(const ACanvas: TCanvas);
begin
  FMessageId := TMessageManager.DefaultManager.SubscribeToMessage(TCanvasDestroyMessage,
    procedure (const Sender : TObject; const M : TMessage)
    begin
      LayoutCanvas := nil;
    end);
  FCanvas := ACanvas;
  FAttributes := TList<TTextAttributedRange>.Create;
  FAttributes.OnNotify := AttributesChanged;
  FFont := TFont.Create;
  FFont.OnChanged := ChangedHandler;
  FColor := TAlphaColorRec.Black;
  FMaxSize := ClosePolygon;
  FOpacity := 1;
  FWordWrap := False;
  FHorizontalAlign := TTextAlign.taLeading;
  FVerticalAlign := TTextAlign.taLeading;
  FPadding := TBounds.Create(RectF(0, 0, 0, 0));
  FPadding.OnChange := ChangedHandler;
  FTopLeft := PointF(0, 0);
  FUpdating := 0;
  FTrimming := TTextTrimming.ttNone;
  FRightToLeft := False;
end;

procedure TTextLayout.DeleteAttribute(const AIndex: Integer);
begin
  FAttributes.Delete(AIndex);
end;

procedure TTextLayout.DeleteAttributeRange(const AFromIndex, AToIndex: Integer);
begin
  FAttributes.DeleteRange(AFromIndex, AToIndex - AFromIndex + 1);
end;

destructor TTextLayout.Destroy;
begin
  if FMessageId > 0 then
  begin
    TMessageManager.DefaultManager.Unsubscribe(TCanvasDestroyMessage, FMessageId);
    FMessageId := 0;
  end;
  FCanvas := nil;
  if Assigned(FAttributes) then
    FAttributes.OnNotify := nil;
  FreeAndNil(FAttributes);
  FreeAndNil(FFont);
  FreeAndNil(FPadding);
  inherited;
end;

procedure TTextLayout.EndUpdate;
begin
  if FUpdating > 0 then
  begin
    Dec(FUpdating);
    if (FUpdating = 0) and FNeedUpdate then
    begin
      DoRenderLayout;
      FNeedUpdate := False;
    end;
  end;
end;

procedure TTextLayout.ChangedHandler(Sender: TObject);
begin
  NeedUpdate;
end;

function TTextLayout.GetAttribute(const Index: Integer): TTextAttributedRange;
begin
  Result := FAttributes[Index];
end;

function TTextLayout.GetAttributesCount: Integer;
begin
  Result := FAttributes.Count;
end;

function TTextLayout.GetHeight: Single;
begin
  Result := Padding.Top + Padding.Bottom + GetTextHeight;
end;

function TTextLayout.GetWidth: Single;
begin
  Result := Padding.Left + Padding.Right + GetTextWidth;
end;

procedure TTextLayout.NeedUpdate;
begin
  FNeedUpdate := True;
  if FUpdating = 0 then
  begin
    DoRenderLayout;
    FNeedUpdate := False;
  end;
end;

function TTextLayout.PositionAtPoint(const APoint: TPointF;
  const RoundToWord: Boolean): Integer;
var
  WordBegin, WordEnd: Integer;
begin
  Result := DoPositionAtPoint(APoint);
  if (Result >= 0) and RoundToWord then
  begin
    WordBegin := GetLexemeBegin(Text, Result);
    WordEnd := Min(GetLexemeEnd(Text, Result) + 1, Text.Length);
    if (Result - WordBegin) > (WordEnd - Result) then
      Result := WordEnd
    else
      Result := WordBegin;
  end;
end;

procedure TTextLayout.AttributesChanged(Sender: TObject;
  const Item: TTextAttributedRange; Action: TCollectionNotification);
begin
  NeedUpdate;
end;

procedure TTextLayout.BeginUpdate;
begin
  FUpdating := FUpdating + 1;
end;

function TTextLayout.RegionForRange(const ARange: TTextRange;
  const RoundToWord: Boolean): TRegion;
var
  LRange: TTextRange;
begin
  if not RoundToWord then
    LRange := ARange
  else
  begin
    LRange.Pos := GetLexemeBegin(Text, ARange.Pos);
    LRange.Length := GetLexemeEnd(Text, ARange.Pos + ARange.Length) - LRange.Pos + 1;
  end;
  Result := DoRegionForRange(LRange);
end;

procedure TTextLayout.RenderLayout(const ACanvas: TCanvas);
begin
  if FNeedUpdate then
    DoRenderLayout;
  DoDrawLayout(ACanvas);
  FNeedUpdate := False;
end;

procedure TTextLayout.SetHorizontalAlign(const Value: TTextAlign);
begin
  if FHorizontalAlign = Value then
    Exit;
  FHorizontalAlign := Value;
  NeedUpdate;
end;

procedure TTextLayout.SetCanvas(const Value: TCanvas);
begin
  if FCanvas = Value then
    Exit;
  FCanvas := Value;
  NeedUpdate;
end;

procedure TTextLayout.SetFont(const Value: TFont);
begin
  if FFont.Equals(Value) then
    Exit;
  FFont.Assign(Value);
end;

procedure TTextLayout.SetPadding(const Value: TBounds);
begin
  if FPadding.Equals(Value) then
    Exit;
  FPadding.Assign(Value);
  NeedUpdate;
end;

procedure TTextLayout.SetMaxSize(const Value: TPointF);
begin
  if FMaxSize = Value then
    Exit;
  FMaxSize := Value;
  if WordWrap or (Trimming <> TTextTrimming.ttNone) or
     (FHorizontalAlign <> TTextAlign.taLeading) or (FVerticalAlign <> TTextAlign.taLeading) or
     FRightToLeft or
     (Value.X < Self.Width) or (Value.Y < Self.Height) then
    //Recreating layout if text is not in top-left corner or new size is less
    //than layout size or text is wrapping or trimming
    NeedUpdate;
end;

procedure TTextLayout.SetRightToLeft(const Value: Boolean);
begin
  if FRightToLeft = Value then
    Exit;
  FRightToLeft := Value;
  NeedUpdate;
end;

procedure TTextLayout.SetText(const Value: string);
begin
  if FText = Value then
    Exit;
  FText := Value;
  NeedUpdate;
end;

procedure TTextLayout.SetTrimming(const Value: TTextTrimming);
begin
  if FTrimming = Value then
    Exit;
  FTrimming := Value;
  NeedUpdate;
end;

procedure TTextLayout.SetVerticalAlign(const Value: TTextAlign);
begin
  if FVerticalAlign = Value then
    Exit;
  FVerticalAlign := Value;
  NeedUpdate;
end;

procedure TTextLayout.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap = Value then
    Exit;
  FWordWrap := Value;
  NeedUpdate;
end;

{ TTextLayoutManager }

class function TTextLayoutManager.GetDefaultLayout: TTextLayoutClass;
var
  LayoutClassRec: TTextLayoutRecord;
begin
  if not Assigned(FDefaultLayoutClass) then
  begin
    Result := nil;
    if Assigned(FLayoutList) and (FLayoutList.Count > 0) then
    begin
      for LayoutClassRec in FLayoutList do
      begin
        if LayoutClassRec.CanvasClass = TCanvasManager.DefaultCanvas then
        begin
          Result := LayoutClassRec.LayoutClass;
          Break;
        end;
      end;
      if not Assigned(Result) then
        raise ECanvasManagerException.CreateFMT(SNoImplementation, ['TTextLayout']);
      FDefaultLayoutClass := Result;
    end
    else
      raise ECanvasManagerException.CreateFMT(SNoImplementation, ['TTextLayout']);
  end
  else
    Result := FDefaultLayoutClass;
end;

class procedure TTextLayoutManager.RegisterTextLayout(
  const LayoutClass: TTextLayoutClass; const CanvasClass: TCanvasClass);
var
  Rec: TTextLayoutRecord;
begin
  if not Assigned(FLayoutList) then
    FLayoutList := TList<TTextLayoutRecord>.Create;
  Rec.LayoutClass := LayoutClass;
  Rec.CanvasClass := CanvasClass;
  FLayoutList.Add(Rec);
end;

class function TTextLayoutManager.TextLayoutByCanvas(
  const ACanvasClass: TClass): TTextLayoutClass;
var
  LayoutClassRec: TTextLayoutRecord;
begin
  Result := nil;
  if Assigned(FLayoutList) and (FLayoutList.Count > 0) then
  begin
    for LayoutClassRec in FLayoutList do
      if LayoutClassRec.CanvasClass = ACanvasClass then
      begin
        Result := LayoutClassRec.LayoutClass;
        Break;
      end;
    if not Assigned(Result) then
      raise ECanvasManagerException.CreateFMT(SNoImplementation, ['TTextLayout']);
  end
  else
    raise ECanvasManagerException.CreateFMT(SNoImplementation, ['TTextLayout']);
end;

class procedure TTextLayoutManager.UnInitialize;
begin
  FreeAndNil(FLayoutList);
end;

end.
