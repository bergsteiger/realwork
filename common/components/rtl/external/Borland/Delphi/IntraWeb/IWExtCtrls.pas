unit IWExtCtrls;
{PUBDIST}

interface

uses
{$IFDEF Linux}QGraphics, {$ELSE}Graphics, {$ENDIF}
  Classes,
  IWControl, IWTypes, IWFileReference, IWHTMLTag,
  SysUtils;

type
  TIWRadioGroupLayout = (glVertical, glHorizontal);

  TIWCustomRadioGroup = class(TIWControl)
  protected
    FItemIndex: Integer;
    FItems: TStrings;
    FLayout: TIWRadioGroupLayout;
    //
    procedure SetItems(AValue: TStrings);
    procedure SetLayout(const AValue: TIWRadioGroupLayout);
    procedure SetValue(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;

    //@@ Specifies currently selected item.
    property ItemIndex: integer read FItemIndex write FItemIndex;
    //@@ Specifies items to be listed as radio buttons in the group box.
    property Items: TStrings read FItems write SetItems;
    //@@ Specifies if radio buttons will be arranged vertically in a column or horizontally in a
    //row.
    property Layout: TIWRadioGroupLayout read FLayout write SetLayout;
  end;

  TIWRadioGroup = class(TIWCustomRadioGroup)
  published
    property Font;
    //@@ Specifies currently selected item.
    property ItemIndex;
    //@@ Specifies items to be listed as radio buttons in the group box.
    property Items;
    //@@ Specifies if radio buttons will be arranged vertically in a column or horizontally in a
    //row.
    property Layout;
  end;

  TIWImageOnMouseDown = procedure(ASender: TObject; const AX: Integer; const AY: Integer) of object;

  TIWCustomImage = class(TIWControl)
  protected
    FAltText: string;
    FOnMouseDown: TIWImageOnMouseDown;
    FPicture: TPicture;
    FUseBorder: Boolean;
    FUseSize: Boolean;
    //
    function CanAutoSize(var VNewWidth: Integer;
      var VNewHeight: Integer): Boolean; {$IFNDEF Linux} override; {$ENDIF}
    procedure CreatePicture;
    // Necessary because Borland made FOnClick protected
    function GetOnClick: TNotifyEvent;
    function ImageHTML(const ASrc: string): TIWHTMLTag;
    procedure PictureChanged(ASender: TObject);
    procedure SetOnClick(const AValue: TNotifyEvent);
    procedure SetOnMouseDown(const AValue: TIWImageOnMouseDown);
    procedure SetPicture(AValue: TPicture);
    procedure Submit(const AValue: string); override;
    procedure SetUseSize(const AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    //@@ Specifies the picture to display. This picture can be dynamic and changed at run time.
    property Picture: TPicture read FPicture write SetPicture;
  published
    //@@ Alternate text to display in the browser.
    property AltText: string read FAltText write FAltText;
{$IFNDEF Linux}
    // Necessary as Delphi defaults to False and causes streaming problems
    //@@ This indicates if you wish the TIWCustomImage to automatically determine the size of the
    // image.
    property AutoSize default True;
{$ENDIF}
    property Confirmation;
    property DoSubmitValidation;
    property ExtraTagParams;
    // property ScriptEvents_old;
    property ScriptEvents;
    //@@ UseBorder controls whether or not the image has a border in the browser.
    property UseBorder: Boolean read FUseBorder write FUseBorder;
    //@@ UseSize controls whether or not the width and height are written out in the HTML. This
    //can be used to control scaling of the image.
    property UseSize: Boolean read FUseSize write SetUseSize;
    //
    // Events
    //
    //@@ OnClick occurs when the user clicks on the image. OnClick and OnMouseDown are mutually
    //exclusive.
    //
    //SeeAlso: OnMouseDown
    property OnClick: TNotifyEvent read GetOnClick write SetOnClick;
    //@@ OnMouseDown occurs when the user clicks on the image. OnMouseDown passes in the X and Y
    //coordinates that the user clicked. OnMouseDown and OnClick are mutually exclusive.
    //
    //SeeAlso: OnClick
    property OnMouseDown: TIWImageOnMouseDown read FOnMouseDown write SetOnMouseDown;
  end;

  TIWDynamicImage = class(TIWCustomImage)
  protected
    FJpegOptions: TIWJpegOptions;
    //
    procedure SetJpegOptions(const AValue: TIWJpegOptions);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    property JpegOptions: TIWJpegOptions read FJpegOptions write SetJpegOptions;
  end;

  TIWImage = class(TIWDynamicImage)
  published
    property Picture;
  end;

  TIWImageFile = class(TIWCustomImage)
  protected
    FImageFile: TIWFileReference;
    //
    procedure ReferenceChanged(ASender: TObject);
    procedure SetImageFile(const AValue: TIWFileReference);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ Specifies the file to display. Filename contains a path and filename to an image file.
    // While the property editor allows you to select any file on the local computer, for the image
    // to display properly in the users browser at run time the file must reside in the "Files"
    // subdirectory of the application directory. If you do not have a "Files" sub directory,
    // simply create one in your application directory.
    //
    // Intraweb contains support for JPG files. To support GIF files, GIF support such as GIFImage
    // must be installed into Delphi. The GIF support does not need to be compiled into the program
    // at runtime, but must be loaded into Delphi so that TImageFile can properly display the GIF at
    // design time.
    //
    // For more information on GIF support, please see the IntraWeb FAQ.
    property ImageFile: TIWFileReference read FImageFile write SetImageFile;
  end;

  TIWTimer = class(TIWControl)
  protected
    FEnabled: Boolean;
    FInterval: Integer;
    FOnTimer: TNotifyEvent;
    //
    procedure Submit(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Interval: Integer read FInterval write FInterval;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
  end;

implementation

uses
{$IFDEF Linux}
  QControls,
{$ELSE}
  Controls,
{$ENDIF}
  IWServerControllerBase, IWScriptEvents, 
  SWSystem, SWStrings;

{ TIWRadioGroup }

constructor TIWCustomRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
  FNeedsFormTag := True;
  FSupportsInput := True;
  Width := 89;
  Height := 112;
end;

destructor TIWCustomRadioGroup.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TIWCustomRadioGroup.RenderHTML: TIWHTMLTag;
var
  i: Integer;
begin
  // To identify them as a group, HTML requires they all have the same name
  Result := TIWHTMLTag.CreateTag('DIV'); try
    for i := 0 to Items.Count - 1 do begin
      with Result.Contents.AddTag('INPUT') do begin
        AddStringParam('TYPE', 'RADIO');
        Add(IIF(ItemIndex = i, ' CHECKED'));
        AddStringParam('NAME', HTMLName);
        AddStringParam('VALUE', IntToStr(i));
      end;
      Result.Contents.AddText(Items[i]);
      Result.Contents.AddText(iif(Layout = glVertical, '<BR>', ' '));
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWCustomRadioGroup.SetItems(AValue: TStrings);
begin
  FItems.Assign(AValue);
  Invalidate;
end;

procedure TIWCustomRadioGroup.SetLayout(const AValue: TIWRadioGroupLayout);
begin
  FLayout := AValue;
  Invalidate;
end;

procedure TIWCustomRadioGroup.SetValue(const AValue: string);
begin
  ItemIndex := StrToIntDef(AValue, -1);
  Invalidate;
end;

{ TIWCustomImage }

function TIWCustomImage.CanAutoSize(var VNewWidth, VNewHeight: Integer): Boolean;
begin
  Result := False;
  // FPicture is nil during initial create at design time for TIWImageFile (inherited Create)
  // Seems wierd to check AutoSize esp during streaming, but its required otehrwise during
  // AutoSize = False and streaming at runtime we get witdh and height of 0.
  if (FPicture <> nil) and (DesignMode = False) and (AutoSize = True) then begin
    if (FPicture.Width > 0) and (FPicture.Height > 0) then begin
      Result := True;
      if Align in [alNone, alLeft, alRight] then begin
        VNewWidth := FPicture.Width;
      end;
      if Align in [alNone, alTop, alBottom] then begin
        VNewHeight := FPicture.Height;
      end;
    end;
  end;
end;

constructor TIWCustomImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoSize := True;
  FSupportsSubmit := True;
  FSupportedScriptEvents := 'OnAbort,OnError,OnKeyDown,OnKeyPress,OnKeyUp,OnLoad';
  FUseSize := True;
  Width := 89;
  Height := 112;
end;

procedure TIWCustomImage.CreatePicture;
begin
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
end;

destructor TIWCustomImage.Destroy;
begin
  FreeAndNil(FPicture);
  inherited;
end;

function TIWCustomImage.GetOnClick: TNotifyEvent;
begin
  Result := (inherited OnClick);
end;

function TIWCustomImage.ImageHTML(const ASrc: string): TIWHTMLTag;
var
  LTag: TIWHTMLTag;
begin
  Result := TIWHTMLTag.CreateTag('IMG'); try
    Result.AddStringParam('SRC', ASrc);
    Result.AddStringParam('NAME', HTMLName);
    Result.AddIntegerParam('BORDER', iif(UseBorder, 1, 0));
    Result.AddStringParam('ALT', AltText);
    if UseSize then begin
      Result.AddIntegerParam('WIDTH', Width);
      Result.AddIntegerParam('HEIGHT', Height);
    end;

    if Assigned(OnMouseDown) then begin
      case WebApplication.Browser of
        brIE: begin
          Result.AddStringParam('OnMouseDown', 'return ImageClick(this.name,event,'
            + iif(DoSubmitValidation, 'true', 'false') + ', ''' + Confirmation + ''');');
        end;
        brNetscape6: begin
          LTag := TIWHTMLTag.CreateTag('A'); try
            LTag.AddStringParam('HREF', '#');
            LTag.AddStringParam('OnMouseOver', 'return ImageSetEvent(this,''' + HTMLName + ''''
              + ',' + iif(DoSubmitValidation, 'true', 'false')
              + ',' + '''' + Confirmation + ''''
              + ');"');
            LTag.Contents.AddText(Result.Render);
          except FreeAndNil(LTag); raise; end;  
          FreeAndNil(Result);
          Result := LTag;
        end;
      end;
    end;
    // OnMouseDown and OnClick are mutually exclusive, no need to check
    if Assigned(OnClick) then begin
      LTag := Result;
      Result := SubmitLink(Result.Render, '', Length(ScriptEvents.Values['OnClick']) > 0);
      LTag.Free;
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWCustomImage.PictureChanged(ASender: TObject);
begin
  if AutoSize and (FPicture.Width > 0) and (FPicture.Height > 0) then begin
    SetBounds(Left, Top, FPicture.Width, FPicture.Height);
  end;
  Invalidate;
end;

procedure TIWCustomImage.SetOnClick(const AValue: TNotifyEvent);
begin
  FOnMouseDown := nil;
  inherited OnClick := AValue;
end;

procedure TIWCustomImage.SetOnMouseDown(const AValue: TIWImageOnMouseDown);
begin
  inherited OnClick := nil;
  FOnMouseDown := AValue;
end;

procedure TIWCustomImage.Submit(const AValue: string);
var
  s: string;
  LX: Integer;
  LY: Integer;
begin
  if Assigned(OnMouseDown) then begin
    s := AValue;
    LX := StrToInt(Fetch(s, ','));
    LY := StrToInt(s);
    OnMouseDown(Self, LX, LY);
  end else begin
    DoClick;
  end;
end;

procedure TIWCustomImage.SetUseSize(const AValue: Boolean);
begin
  FRenderSize := AValue;
  FUseSize := AValue;
end;

{ TIWImage }

constructor TIWDynamicImage.Create(AOwner: TComponent);
begin
  inherited;
  CreatePicture;
  FJpegOptions := TIWJpegOptions.Create;
end;

destructor TIWDynamicImage.Destroy;
begin
  FreeAndNil(FJpegOptions);
  inherited;
end;

function TIWDynamicImage.RenderHTML: TIWHTMLTag;
var
  LPathname: string;
begin
  Result := nil;
  LPathname := TIWServerControllerBase.NewCacheFile('jpg');
  // Is nil if no picture. Ex: Drop a TIWImage on form, dont load an image, run.
  if FPicture.Graphic <> nil then begin
    if not FPicture.Graphic.Empty then begin
      ToJPegFile(FPicture.Graphic, LPathname);
      Result := ImageHTML(WebApplication.URLBase + '/cache/' + ExtractFilename(LPathname));
    end;
  end;
end;

procedure TIWCustomImage.SetPicture(AValue: TPicture);
begin
  FPicture.Assign(AValue);
  // No need for Invalidate, Picture.OnChange will catch it
end;

{ TIWImageFile }

constructor TIWImageFile.Create(AOwner: TComponent);
begin
  inherited;
  FImageFile := TIWFileReference.Create;
  if DesignMode then begin
    CreatePicture;
  end;
  FImageFile.OnChange := ReferenceChanged;
end;

destructor TIWImageFile.Destroy;
begin
  FreeAndNil(FImageFile);
  inherited;
end;

procedure TIWImageFile.ReferenceChanged(ASender: TObject);
begin
  if DesignMode then begin
    if FileExists(ImageFile.Filename) then begin
      FPicture.LoadFromFile(ImageFile.Filename);
    end else begin
      FPicture.Graphic := nil;
    end;
    Invalidate;
  end else begin
    if AutoSize and (FPicture <> nil) then begin
      if (FPicture.Graphic.Width > 0) and (FPicture.Graphic.Height > 0) then begin
        Width := FPicture.Graphic.Width;
        Height := FPicture.Graphic.Height;
      end;
    end;
  end;
end;

function TIWImageFile.RenderHTML: TIWHTMLTag;
begin
  Result := ImageHTML(ImageFile.Location(WebApplication.URLBase));
end;

procedure TIWImageFile.SetImageFile(const AValue: TIWFileReference);
begin
  // Assign calls DoChange
  FImageFile.Assign(AValue);
end;
{ TIWTimer }

constructor TIWTimer.Create(AOwner: TComponent);
begin
  inherited;
  FSupportsSubmit := True;
  FEnabled := True;
end;

function TIWTimer.RenderHTML: TIWHTMLTag;
begin
  Result := nil;
  if Enabled and (Interval > 0) then begin
    AddToInitProc(HTMLName + '=setTimeout(''SubmitClick("' + HTMLName
      + '","", false)'',' + IntToStr(Interval) + ');' + EOL);
  end;
end;

procedure TIWTimer.Submit(const AValue: string);
begin
  if Assigned(OnTimer) then begin
    OnTimer(Self);
  end;
end;

procedure TIWDynamicImage.SetJpegOptions(const AValue: TIWJpegOptions);
begin
  FJpegOptions.Assign(AValue);
end;

end.

