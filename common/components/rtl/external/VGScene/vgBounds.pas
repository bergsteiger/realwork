unit vgBounds;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgBounds.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgBounds
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$IfNDef NoVGScene}

uses
  Classes,

  vgTypes,
  vgPersistent
  ;

type
{$IfDef Nemesis}
 {$Define vgNoDefaults}
{$EndIf Nemesis}

  TvgBounds = class(TvgPersistent)
  private
    FRight: single;
    FBottom: single;
    FTop: single;
    FLeft: single;
    FOnChange: TNotifyEvent;
    {$IfNDef vgNoDefaults}
    FDefaultValue: TvgRect;
    {$EndIf  vgNoDefaults}
    function GetRect: TvgRect;
    procedure SetRect(const Value: TvgRect);
    procedure SetBottom(const Value: single);
    procedure SetLeft(const Value: single);
    procedure SetRight(const Value: single);
    procedure SetTop(const Value: single);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadRect(Reader: TReader);
    procedure WriteRect(Writer: TWriter);
    {$IfNDef DesignTimeLibrary}
    class function IsCacheable : Boolean; override;
    {$EndIf  DesignTimeLibrary}
  public
    constructor Create(const ADefaultValue: TvgRect); virtual;
    procedure Cleanup; override;
    procedure Assign(Source: TPersistent); override;
    function MarginRect(const R: TvgRect): TvgRect;
    function PaddinRect(const R: TvgRect): TvgRect;
    function Width: single;
    function Height: single;
    property Rect: TvgRect read GetRect write SetRect;
    {$IfNDef vgNoDefaults}
    property DefaultValue: TvgRect read FDefaultValue write FDefaultValue;
    {$EndIf  vgNoDefaults}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function Empty: boolean;
    function MarginEmpty: boolean;
  published
    property Left: single read FLeft write SetLeft stored false;
    property Top: single read FTop write SetTop stored false;
    property Right: single read FRight write SetRight stored false;
    property Bottom: single read FBottom write SetBottom stored false;
  end;

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

uses
  vg_Scene
  ;

{ TvgBounds }

constructor TvgBounds.Create(const ADefaultValue: TvgRect);
begin
  inherited Create;
  {$IfNDef vgNoDefaults}
  FDefaultValue := ADefaultValue;
  {$EndIf  vgNoDefaults}
  Rect := ADefaultValue;
end;

procedure TvgBounds.Cleanup;
begin
 FOnChange := nil;
 inherited;
end;

procedure TvgBounds.Assign(Source: TPersistent);
begin
  if Source is TvgBounds then
  begin
    Rect := TvgBounds(Source).Rect;
  end
  else
    inherited
end;

function TvgBounds.GetRect: TvgRect;
begin
  Result := vgRect(FLeft, FTop, FRight, FBottom);
end;

function TvgBounds.MarginRect(const R: TvgRect): TvgRect;
begin
  Result := vgRect(R.Left + FLeft, R.Top + FTop, R.Right - FRight, R.Bottom - FBottom);
end;

function TvgBounds.PaddinRect(const R: TvgRect): TvgRect;
begin
  Result := vgRect(R.Left - FLeft, R.Top - FTop, R.Right + FRight, R.Bottom + FBottom);
end;

function TvgBounds.Width: single;
begin
  Result := vgRectWidth(Rect);
end;

function TvgBounds.Height: single;
begin
  Result := vgRectHeight(Rect);
end;

function TvgBounds.MarginEmpty: boolean;
begin
  Result := (FLeft = 0) and (FTop = 0) and (FRight = 0) and (FBottom = 0);
end;

function TvgBounds.Empty: boolean;
begin
  Result := vgIsRectEmpty(Rect)
end;

procedure TvgBounds.SetBottom(const Value: single);
begin
  if FBottom <> Value then
  begin
    FBottom := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TvgBounds.SetLeft(const Value: single);
begin
  if FLeft <> Value then
  begin
    FLeft := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TvgBounds.SetRight(const Value: single);
begin
  if FRight <> Value then
  begin
    FRight := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TvgBounds.SetTop(const Value: single);
begin
  if FTop <> Value then
  begin
    FTop := Value;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TvgBounds.SetRect(const Value: TvgRect);
begin
  if (FLeft <> Value.Left) or (FTop <> Value.Top) or (FRight <> Value.Right) or (FBottom <> Value.Bottom) then
  begin
    FLeft := Value.Left;
    FTop := Value.Top;
    FRight := Value.Right;
    FBottom := Value.Bottom;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;

procedure TvgBounds.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Rect', ReadRect, WriteRect,
   {$IfNDef vgNoDefaults}
   (FLeft <> DefaultValue.Left) or (FTop <> DefaultValue.Top) or
   (FRight <> DefaultValue.Right) or (FBottom <> DefaultValue.Bottom)
   {$Else  vgNoDefaults}
   true
   {$EndIf vgNoDefaults}
   );
end;

procedure TvgBounds.ReadRect(Reader: TReader);
begin
  Rect := vgStringToRect(Reader.ReadString);
end;

procedure TvgBounds.WriteRect(Writer: TWriter);
begin
  Writer.WriteString(vgRectToString(Rect));
end;

{$IfNDef DesignTimeLibrary}
class function TvgBounds.IsCacheable : Boolean;
begin
 Result := true;
end;
{$EndIf  DesignTimeLibrary}

{$EndIf  NoVGScene}

end.