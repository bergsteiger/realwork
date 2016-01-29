unit IWDynGrid;

interface

uses
  SysUtils, Classes,
{$IFDEF Linux}
  QControls, QGraphics,
{$ELSE}
  Controls, Graphics,
{$ENDIF}
  IWControl, IWGrids, IWFont, IWTypes, IWClientSideDatasetBase, IWForm, IWServer, swsystem,
  IWHTMLTag, IWLayoutMgr;

type
  TIWCustomDynGrid = class;

  TIWDynGridBorderColors = class(TIWGridBorderColors)
  public
    procedure Assign(ASource: TPersistent); override;
  end;

  TIWDefaultDynGridCell = class(TPersistent)
  private
    FBackgroundColor: TIWColor;
    FColor: TIWColor;
    FFont: TIWFont;
    FOwner: TIWCustomDynGrid;
    FBorderSize: Integer;
    FBorderColors: TIWDynGridBorderColors;

    procedure SetBackgroundColor(const Value: TIWColor);
    procedure SetColor(const Value: TIWColor);
    procedure SetFont(const Value: TIWFont);
    function GetCellView: string;
    function GetInternalView: string;
  public
    constructor Create(AOwner: TIWCustomDynGrid);
    destructor Destroy; override;

    procedure Assign(ASource: TPersistent); override;
  published
    property BorderColors: TIWDynGridBorderColors read FBorderColors write FBorderColors;
    property Color: TIWColor read FColor write SetColor;
    property BorderSize: Integer read FBorderSize write FBorderSize;
    property BackgroundColor: TIWColor read FBackgroundColor write SetBackgroundColor;
    property Font: TIWFont read FFont write SetFont;
    property CellView: string read GetCellView;
    property InternalView: string read GetInternalView;
  end;

  TIWCustomDynGrid = class(TIWControl)
  private
    FBorderColors: TIWDynGridBorderColors;
    FBackgroundColor: TIWColor;
    FData: TIWClientSideDatasetBase;
    FDataCellProperties: TIWDefaultDynGridCell;
    FFilterCellProperties: TIWDefaultDynGridCell;
    FTitleCellProperties: TIWDefaultDynGridCell;
    FBorderSize: Integer;
    procedure SetBackgroundColor(const Value: TIWColor);
    procedure SetData(const Value: TIWClientSideDatasetBase);
    procedure SetBorderColors(const Value: TIWDynGridBorderColors);
    procedure SetDataCellProperties(const Value: TIWDefaultDynGridCell);
    procedure SetFilterCellProperties(
      const Value: TIWDefaultDynGridCell);
    procedure SetTitelCellProperties(const Value: TIWDefaultDynGridCell);
    { Private declarations }
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function RenderHTML: TIWHTMLTag; override;

    property BorderColors: TIWDynGridBorderColors read FBorderColors write SetBorderColors;
    property BackgroundColor: TIWColor read FBackgroundColor write SetBackgroundColor;
    property TitleCell: TIWDefaultDynGridCell read FTitleCellProperties write SetTitelCellProperties;
    property FilterCell: TIWDefaultDynGridCell read FFilterCellProperties write SetFilterCellProperties;
    property DataCell: TIWDefaultDynGridCell read FDataCellProperties write SetDataCellProperties;
    property Data: TIWClientSideDatasetBase read FData write SetData;
    property BorderSize: Integer read FBorderSize write FBorderSize;
  end;

  TIWDynGrid = class(TIWCustomDynGrid)
  published
    property BorderColors;
    property BackgroundColor;
    property TitleCell;
    property FilterCell;
    property DataCell;
    property Data;
    property BorderSize;
    property Height;
    property Left;
    property Width;
    property Top;
    property Visible;
  end;

implementation

uses
  IWGlobal, IWResourceStrings, 
  IWServerControllerBase, IWAppForm, IWApplication;

function AddStyleDefinition(AStyle, ANewStyle: string): string;
begin
  if Length(AStyle) > 0 then
    result := AStyle + '; ' + ANewStyle
  else
    result := ANewStyle;
end;

{ TIWDefaultDynGridCell }

procedure TIWDefaultDynGridCell.Assign(ASource: TPersistent);
begin
  if ASource is TIWDefaultDynGridCell then begin
    FFont.Assign((ASource as TIWDefaultDynGridCell).FFont);
    FBackgroundColor := (ASource as TIWDefaultDynGridCell).FBackgroundColor;
    FColor := (ASource as TIWDefaultDynGridCell).FColor;
    FOwner := (ASource as TIWDefaultDynGridCell).FOwner;
    FBorderColors.Assign((ASource as TIWDefaultDynGridCell).FBorderColors);
    FBorderSize := (ASource as TIWDefaultDynGridCell).FBorderSize;
  end
  else
    inherited Assign(ASource);
end;

constructor TIWDefaultDynGridCell.Create(AOwner: TIWCustomDynGrid);
begin
  inherited Create;
  FOwner := AOwner;
  FFont := TIWFont.Create;
  BackgroundColor := clNone;
  BorderColors := TIWDynGridBorderColors.Create;
  Color := clNone;
end;

destructor TIWDefaultDynGridCell.Destroy;
begin
  BorderColors.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TIWDefaultDynGridCell.SetBackgroundColor(const Value: TIWColor);
begin
  FBackgroundColor := Value;
end;

procedure TIWDefaultDynGridCell.SetColor(const Value: TIWColor);
begin
  FColor := Value;
end;

procedure TIWDefaultDynGridCell.SetFont(const Value: TIWFont);
begin
  FFont := Value;
end;

procedure TIWCustomDynGrid.SetBorderColors(
  const Value: TIWDynGridBorderColors);
begin
  FBorderColors.Assign(Value);
end;

function TIWDefaultDynGridCell.GetCellView: string;
begin
  Result := '<TABLE'
    + iif(BorderSize > 0, ' Border=' + IntToStr(BorderSize))
    + TIWControl.HTMLColor(BackgroundColor, 'BGCOLOR')
    + iif(BorderSize > 0, TIWControl.HTMLColor(BorderColors.Color, 'BORDERCOLOR')
      + TIWControl.HTMLColor(BorderColors.Light, 'BORDERCOLORLIGHT')
      + TIWControl.HTMLColor(BorderColors.Dark, 'BORDERCOLORDARK'))
    + ' CELLPADDING="0"'
    + ' CELLSPACING="0"'
    + ' WIDTH="100%"'
    + ' style="border-collapse: collapse">';
end;

function TIWDefaultDynGridCell.GetInternalView: string;
begin
  result := '>';
end;

{ TIWCustomDynGrid }

constructor TIWCustomDynGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not (laDynGrid in GLicense.Abilities) then begin
    if (GLicense.License = ltPackagedPage) then begin
      if GServerType = stPage then begin
        raise Exception.Create(RSDynGridNotAvailable);
      end;
    end else begin
      raise Exception.Create(RSDynGridNotAvailable);
    end;
  end;
  FTitleCellProperties := TIWDefaultDynGridCell.Create(Self);
  FDataCellProperties := TIWDefaultDynGridCell.Create(Self);
  FFilterCellProperties := TIWDefaultDynGridCell.Create(Self);
  FBorderColors := TIWDynGridBorderColors.Create;

  FRenderSize := true;

  if not (csDesigning in ComponentState) then begin
    GIWServer.AddInternalFile('IW_JS_IWDynGrid');
  end;

  FBackgroundColor := clNone;
end;

destructor TIWCustomDynGrid.Destroy;
begin
  FTitleCellProperties.Free;
  FDataCellProperties.Free;
  FFilterCellProperties.Free;
  FBorderColors.Free;
  inherited Destroy;
end;

procedure TIWCustomDynGrid.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if AComponent = FData then begin
      FData := nil;
    end;
  end;
end;

procedure TIWCustomDynGrid.SetBackgroundColor(const Value: TIWColor);
begin
  FBackgroundColor := Value;
end;

procedure TIWCustomDynGrid.SetData(const Value: TIWClientSideDatasetBase);
begin
  if Assigned(FData) then begin
    FData.RemoveFreeNotification(Self);
  end;
  FData := Value;
  if Assigned(FData) then begin
    FData.FreeNotification(Self);
  end;
end;

procedure TIWCustomDynGrid.SetDataCellProperties(
  const Value: TIWDefaultDynGridCell);
begin
  FDataCellProperties := Value;
end;

procedure TIWCustomDynGrid.SetFilterCellProperties(
  const Value: TIWDefaultDynGridCell);
begin
  FFilterCellProperties := Value;
end;

procedure TIWCustomDynGrid.SetTitelCellProperties(
  const Value: TIWDefaultDynGridCell);
begin
  FTitleCellProperties := Value;
end;

function TIWCustomDynGrid.RenderHTML: TIWHTMLTag;
var
  S: string;
  LScript: string;
begin
  if Assigned(FData) then begin
    S := '<TABLE'
      + iif(BorderSize > 0, ' Border=' + IntToStr(BorderSize))
      + TIWControl.HTMLColor(BackgroundColor, 'BGCOLOR')
        + iif(BorderSize > 0, TIWControl.HTMLColor(BorderColors.Color, 'BORDERCOLOR')
        + TIWControl.HTMLColor(BorderColors.Light, 'BORDERCOLORLIGHT')
        + TIWControl.HTMLColor(BorderColors.Dark, 'BORDERCOLORDARK'))
      + ' CELLPADDING="0"'
      + ' CELLSPACING="0"'
      + ' WIDTH="100%"'
      + ' style="border-collapse: collapse">';

    LScript := 'var ' + HTMLName + '_TitleCaptions = ' + FData.RenderColNames + ';' + EOL +
      FData.RenderData(HTMLName + '_CellValues') + EOL +
      'var ' + HTMLName + '_TableLook = ''' + S + ''';' + EOL +
      'var ' + HTMLName + '_DataLook = ''' + FDataCellProperties.CellView + ''';' + EOL +
      'var ' + HTMLName + '_TitleLook = ''' + FTitleCellProperties.CellView + ''';' + EOL +
      'var ' + HTMLName + '_TitleView = ''' + FTitleCellProperties.InternalView + ''';' + EOL +
      'var ' + HTMLName + '_FilterLook = ''' + FFilterCellProperties.CellView + ''';' + EOL +
//      'var ' + HTMLName + '_FilterLook = ''' + FFilterCellProperties.CellView + ''';' + EOL +
      'var ' + HTMLName + ';';

    with (Owner as TIWForm) do begin
      JavascriptOnce := JavaScriptOnce + LScript;
    end;

    with Owner as TIWAppForm do begin

      CacheImage(Self.HTMLName + '_ImgUp', WebApplication.URLBase + '/gfx/SB_VUP2.gif');
      CacheImage(Self.HTMLName + '_ImgDown', WebApplication.URLBase + '/gfx/SB_VDOWN2.gif');
      CacheImage(Self.HTMLName + '_ImgBlank', WebApplication.URLBase + '/gfx/Tp.gif');
    end;
    AddScriptFile('/js/IWDynGrid.js');
    AddToInitProc(HTMLName + ' = new DefineDynGrid("' + HTMLName + '", "' + HTMLName + '", ' +
      HTMLName + '_TableLook, ' + HTMLName + '_DataLook, ' + HTMLName + '_TitleLook, ' +
      HTMLName + '_FilterLook, ' + HTMLName + '_TitleCaptions, ' + HTMLName + '_CellValues)' + EOL +
      HTMLName + '.ImgUp = "' + WebApplication.URLBase + '/gfx/SB_VUP2.gif";' + EOL +
      HTMLName + '.ImgDown = "' + WebApplication.URLBase + '/gfx/SB_VDOWN2.gif";' + EOL +
      HTMLName + '.ImgBlank = "' + WebApplication.URLBase + '/gfx/Tp.gif";' + EOL +
      HTMLName + '.InitTable();' + EOL + HTMLName + '.RenderTable();');
  end;
  Result := TIWHTMLTag.CreateTag('DIV'); try
    Result.AddStringParam('NAME', HTMLName);
    Result.Contents.AddText('&nbsp;');
  except FreeAndNil(Result); raise; end;
end;

{ TIWDynGridBorderColors }

procedure TIWDynGridBorderColors.Assign(ASource: TPersistent);
begin
  if ASource is TIWDynGridBorderColors then begin
    Color := (ASource as TIWDynGridBorderColors).Color;
    Light := (ASource as TIWDynGridBorderColors).Light;
    Dark := (ASource as TIWDynGridBorderColors).Dark;
  end
  else
    inherited Assign(ASource);
end;

end.

