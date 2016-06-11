{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.TextLayout;

{$MINENUMSIZE 4}

interface

{$SCOPEDENUMS ON}

uses
  System.Types, System.UITypes, System.SysUtils, System.Generics.Collections, FMX.Types, FMX.Graphics;

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
    destructor Destroy; override;
  end;

  TTextLayout = class abstract
  public const
    ///<summary>Maximum size for TTextLayout</summary>
    MaxLayoutSize: TPointF = (X: $FFFF; Y: $FFFF);
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
    [weak] FCanvas: TCanvas;
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
    ///<summary>Setting internal flag that informs that layout properties were changed
    ///and layout should be recalculated</summary>
    procedure SetNeedUpdate;
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

  /// <summary>Class for exceptions related to the FMX.TextLayout
  /// unit.</summary>
  ETextLayoutException = class(Exception);

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
    // Class static method for C++ access
    class function TextLayoutForClass(C: TTextLayoutClass): TTextLayout; static;
  end;

function IsPointInRect(const APoint: TPointF; const ARect: TRectF): Boolean;

implementation

uses
  System.Math, System.Messaging, System.Math.Vectors, FMX.Consts, FMX.Text, FMX.Platform;

type
  TCanvasDestroyListenerProxy = class
  private
    [Weak] FTextLayout: TTextLayout;
  protected
    constructor Create(const TextLayout: TTextLayout);
    destructor Destroy; override;
    procedure CanvasDestroyListener(const Sender : TObject; const M : TMessage);
  end;

var
  DestroyListenerProxyMap: TDictionary<Integer, TCanvasDestroyListenerProxy>;

constructor TCanvasDestroyListenerProxy.Create(const TextLayout: TTextLayout);
begin
  FTextLayout := TextLayout;
end;

destructor TCanvasDestroyListenerProxy.Destroy;
begin
  inherited;
end;

procedure TCanvasDestroyListenerProxy.CanvasDestroyListener(const Sender: TObject; const M: TMessage);
begin
  FTextLayout.FCanvas := nil;
end;

function IsPointInRect(const APoint: TPointF; const ARect: TRectF): Boolean;
begin
  Result := ((APoint.X > ARect.Left) or SameValue(APoint.X, ARect.Left, TEpsilon.Position)) and
    ((APoint.X < ARect.Right) or SameValue(APoint.X, ARect.Right, TEpsilon.Position)) and
    ((APoint.Y > ARect.Top) or SameValue(APoint.Y, ARect.Top, TEpsilon.Position)) and
    ((APoint.Y < ARect.Bottom) or SameValue(APoint.Y, ARect.Bottom, TEpsilon.Position));
end;

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

destructor TTextAttributedRange.Destroy;
begin
  if Attribute.Font <> nil then
    Attribute.Font.Free;
  inherited;
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
var
  LProxy: TCanvasDestroyListenerProxy;
begin
  LProxy := TCanvasDestroyListenerProxy.Create(Self);
  FMessageId := TMessageManager.DefaultManager.SubscribeToMessage(TCanvasDestroyMessage,
    LProxy.CanvasDestroyListener);
  DestroyListenerProxyMap.AddOrSetValue(FMessageId, LProxy);

  FCanvas := ACanvas;
  FAttributes := TList<TTextAttributedRange>.Create;
  FAttributes.OnNotify := AttributesChanged;
  FFont := TFont.Create;
  FFont.OnChanged := ChangedHandler;
  FColor := TAlphaColorRec.Black;
  FMaxSize := MaxLayoutSize;
  FOpacity := 1;
  FWordWrap := False;
  FHorizontalAlign := TTextAlign.Leading;
  FVerticalAlign := TTextAlign.Leading;
  FPadding := TBounds.Create(RectF(0, 0, 0, 0));
  FPadding.OnChange := ChangedHandler;
  FTopLeft := PointF(0, 0);
  FUpdating := 0;
  FTrimming := TTextTrimming.None;
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
var
  LProxy: TCanvasDestroyListenerProxy;
{$IFNDEF AUTOREFCOUNT}
  I: Integer;
{$ENDIF}
begin
  if FMessageId > 0 then
  begin
    TMessageManager.DefaultManager.Unsubscribe(TCanvasDestroyMessage, FMessageId);
    if DestroyListenerProxyMap.TryGetValue(FMessageId, LProxy) then
      FreeAndNil(LProxy);
    DestroyListenerProxyMap.Remove(FMessageId);
    FMessageId := 0;
  end;
  FCanvas := nil;
  if FAttributes <> nil then
  begin
    FAttributes.OnNotify := nil;
{$IFNDEF AUTOREFCOUNT}
    for I := 0 to FAttributes.Count - 1 do
      FAttributes.List[I].Free;
{$ENDIF}
    FreeAndNil(FAttributes);
  end;
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

procedure TTextLayout.SetNeedUpdate;
begin
  FNeedUpdate := True;
end;

procedure TTextLayout.NeedUpdate;
begin
  SetNeedUpdate;
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
{$IFNDEF AUTOREFCOUNT}
  if Action = TCollectionNotification.cnRemoved then
    Item.Free;
{$ENDIF}
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
  if FHorizontalAlign <> Value then
  begin
    FHorizontalAlign := Value;
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetCanvas(const Value: TCanvas);
begin
  if FCanvas <> Value then
  begin
    FCanvas := Value;
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetFont(const Value: TFont);
begin
  if not FFont.Equals(Value) then
    FFont.Assign(Value);
end;

procedure TTextLayout.SetPadding(const Value: TBounds);
begin
  if not FPadding.Equals(Value) then
  begin
    FPadding.Assign(Value);
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetMaxSize(const Value: TPointF);
begin
  if FMaxSize <> Value then
  begin
    FMaxSize := Value;
    if WordWrap or (Trimming <> TTextTrimming.None) or (FHorizontalAlign <> TTextAlign.Leading) or
      (FVerticalAlign <> TTextAlign.Leading) or FRightToLeft or not SameValue(Value.X, Self.Width, TEpsilon.Position) or
      not SameValue(Value.Y, Self.Height, TEpsilon.Position) then
      //Recreating layout if text is not in top-left corner or new size is different
      //than layout size or text is wrapping or trimming
      NeedUpdate;
  end;
end;

procedure TTextLayout.SetRightToLeft(const Value: Boolean);
begin
  if FRightToLeft <> Value then
  begin
    FRightToLeft := Value;
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetTrimming(const Value: TTextTrimming);
begin
  if FTrimming <> Value then
  begin
    FTrimming := Value;
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetVerticalAlign(const Value: TTextAlign);
begin
  if FVerticalAlign <> Value then
  begin
    FVerticalAlign := Value;
    NeedUpdate;
  end;
end;

procedure TTextLayout.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    NeedUpdate;
  end;
end;

{ TTextLayoutManager }

class function TTextLayoutManager.GetDefaultLayout: TTextLayoutClass;
var
  CanvasSrv: IFMXCanvasService;
  LayoutClassRec: TTextLayoutRecord;
begin
  if FDefaultLayoutClass = nil then
  begin
    Result := nil;
    if FLayoutList = nil then
      if TPlatformServices.Current.SupportsPlatformService(IFMXCanvasService, CanvasSrv) then
        CanvasSrv.RegisterCanvasClasses;
    if (FLayoutList <> nil) and (FLayoutList.Count > 0) then
    begin
      for LayoutClassRec in FLayoutList do
      begin
        if LayoutClassRec.CanvasClass = TCanvasManager.DefaultCanvas then
        begin
          Result := LayoutClassRec.LayoutClass;
          Break;
        end;
      end;
      if Result = nil then
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
  if FLayoutList = nil then
    FLayoutList := TList<TTextLayoutRecord>.Create;
  Rec.LayoutClass := LayoutClass;
  Rec.CanvasClass := CanvasClass;
  FLayoutList.Add(Rec);
end;

class function TTextLayoutManager.TextLayoutByCanvas(
  const ACanvasClass: TClass): TTextLayoutClass;
var
  CanvasSrv: IFMXCanvasService;
  LayoutClassRec: TTextLayoutRecord;
begin
  Result := nil;
  if FLayoutList = nil then
    if TPlatformServices.Current.SupportsPlatformService(IFMXCanvasService, CanvasSrv) then
      CanvasSrv.RegisterCanvasClasses;
  if (FLayoutList <> nil) and (FLayoutList.Count > 0) then
  begin
    for LayoutClassRec in FLayoutList do
      if LayoutClassRec.CanvasClass = ACanvasClass then
      begin
        Result := LayoutClassRec.LayoutClass;
        Break;
      end;
    if Result = nil then
      raise ECanvasManagerException.CreateFMT(SNoImplementation, ['TTextLayout']);
  end
  else
    raise ECanvasManagerException.CreateFMT(SNoImplementation, ['TTextLayout']);
end;

class function TTextLayoutManager.TextLayoutForClass(C: TTextLayoutClass): TTextLayout;
begin
  Result := C.Create;
end;

class procedure TTextLayoutManager.UnInitialize;
begin
  FreeAndNil(FLayoutList);
end;

initialization
  DestroyListenerProxyMap := TDictionary<Integer, TCanvasDestroyListenerProxy>.Create;
finalization
  FreeAndNil(DestroyListenerProxyMap);
end.
