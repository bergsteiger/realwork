unit IWCSStdCtrls;

interface

Uses Classes, SysUtils,
  {$IFDEF Linux} QDBCtrls,{$ELSE} DBCtrls,{$ENDIF}
  IWControl, IWCompLabel, IWClientSideDatasetBase, IWHTMLTag, IWDBStdCtrls;

Type
  TIWCustomCSLabel = class(TIWCustomLabel)
  protected
    FCSDataSet: TIWClientSideDatasetBase;
    FFieldName: String;
    //
    procedure SetCSDataSet(const Value: TIWClientSideDatasetBase);
    procedure SetFieldName(const Value: String);
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Paint; override;
    //
    property ClientSideDataSet: TIWClientSideDatasetBase read FCSDataSet write SetCSDataSet;
    property FieldName: String read FFieldName write SetFieldName;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
  end;

  TIWCSLabel = class(TIWCustomCSLabel)
  published
    property ClientSideDataSet;
    property FieldName;
  end;

  TIWCSCustomNavigator = class(TIWControl)
  protected
    FConfirmations: TIWDBNavConfirmations;
    FCSDataSet: TIWClientSideDatasetBase;
    FImageWidth: Integer;
    FImageHeight: Integer;
    FOnApplay: TNotifyEvent;
    FOnDiscard: TNotifyEvent;
    FVisibleButtons: TButtonSet;
    FDBNavImages: TIWDBNavImages;
    FOrientation: TIWOrientation;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetVisibleButtons(Value: TButtonSet);
    procedure SetDBNavImages(const Value: TIWDBNavImages);
    procedure SetOrientation(const Value: TIWOrientation);
    procedure SetCSDataSet(const Value: TIWClientSideDatasetBase);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
    procedure Submit(const AValue: string); override;
    //
    //@@ Confirmations contains text messages to use to confirm a users actions. To disable an
    //individual confirmation simply set it to ''.
    property Confirmations: TIWDBNavConfirmations read FConfirmations write FConfirmations;
    //@@ Datasource to manipulate.
    property ClientSideDataSet: TIWClientSideDatasetBase read FCSDataSet write SetCSDataSet;
    //@@ Defines image height
    property ImageHeight: Integer read FImageHeight write FImageHeight;
    //@@ Defines image width
    property ImageWidth: Integer read FImageWidth write FImageWidth;
    //@@ Controls which buttons are displayed to the user.
    property VisibleButtons: TButtonSet read FVisibleButtons write SetVisibleButtons;
    //@@ Custom images for DBNavigator
    property CustomImages: TIWDBNavImages read FDBNavImages write SetDBNavImages;
    //@@ DBNavigator orientation
    property Orientation: TIWOrientation read FOrientation write SetOrientation;
  end;

  TIWCSNavigator = class(TIWCSCustomNavigator)
  published
    property Confirmations;
    property ClientSideDataSet;
    property ImageHeight;
    property ImageWidth;
    property VisibleButtons;
    property CustomImages;
    property Orientation;
  end;

implementation

uses {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  {$IFDEF Linux}Types,{$ELSE}Windows,{$ENDIF}
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  IWForm, IWFileReference, IWResourceStrings, SWSystem;

{ TIWCustomCSLable }

constructor TIWCustomCSLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCSDataSet := nil;
  AutoSize := false;
end;

procedure TIWCustomCSLabel.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if AComponent = FCSDataSet then begin
      FCSDataSet := nil;
    end;
  end;
end;

procedure TIWCustomCSLabel.Paint;
begin
  if FFieldName <> '' then begin
    Caption := FFieldName;
  end
  else begin
    Caption := Name;
  end;
  
  inherited Paint;
end;

function TIWCustomCSLabel.RenderHTML: TIWHTMLTag;
begin
  result := nil;
  if (FieldName <> '') and Assigned(FCSDataSet) then begin
    result := TIWHTMLTag.CreateTag('SPAN'); try
      result.Contents.AddTagAsObject(FCSDataSet.RenderIWComponent(TIWForm(Form)));
      if result.Contents.Count = 0 then begin
        result.Contents.AddText('');
      end;

      AddToInitProc(HTMLName + 'IWCL.SetIWCLType(iwclLabel);' + EOL
        + HTMLName + 'IWCL.SetFieldName("' + FFieldName + '");' + EOL
        + HTMLName + 'IWCL.SetDataSet(CSDS' + FCSDataSet.Name + ');' + EOL
        );
    except FreeAndNil(Result); raise; end;
  end;
end;

procedure TIWCustomCSLabel.SetCSDataSet(const Value: TIWClientSideDatasetBase);
begin
  FCSDataSet := Value;

  if FCSDataSet <> nil then begin
    FCSDataSet.FreeNotification(Self);
  end;
end;

procedure TIWCustomCSLabel.SetFieldName(const Value: String);
begin
  FFieldName := Value;
  Invalidate;
end;

{ TIWDBCustomNavigator }

constructor TIWCSCustomNavigator.Create(AOwner: TComponent);
var
  LUseDefaults: Boolean;
begin
  inherited Create(AOwner);
  LUseDefaults := False;
  if Owner <> nil then begin
    LUseDefaults :=  (Owner.ComponentState * [csReading, csDesigning]) = [csDesigning];
  end;
  FConfirmations := TIWDBNavConfirmations.Create(LUseDefaults);
  FDBNavImages := TIWDBNavImages.Create(nil);
  //
  VisibleButtons := [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel
   , nbRefresh];
  Height := 25;
  Width := 250;
  ImageHeight := 21;
  ImageWidth := 21;
end;

destructor TIWCSCustomNavigator.Destroy;
begin
  FreeAndNil(FDBNavImages);
  FreeAndNil(FConfirmations);
  inherited Destroy;
end;

procedure TIWCSCustomNavigator.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if AComponent = FCSDataSet then begin
      FCSDataSet := nil;
    end;
  end;
end;

function TIWCSCustomNavigator.RenderHTML: TIWHTMLTag;
Const
  DBNavButtonNames: array [TNavigateBtn] of String =
    (RSbtnNameFirst, RSbtnNamePrior, RSbtnNameNext, RSbtnNameLast, RSbtnNameInsert,
    RSbtnNameDelete, RSbtnNameEdit, RSbtnNamePost, RSbtnNameCancel, RSbtnNameRefresh);

  procedure ImageLocations(AButton: TNavigateBtn; var VEnabled, VDisabled: String);
  Var
    LFReference: TIWFileReference;
  begin
    LFReference := nil;
    case AButton of
      nbFirst: LFReference := FDBNavImages.First_Enabled;
      nbPrior: LFReference := FDBNavImages.Prior_Enabled;
      nbNext: LFReference := FDBNavImages.Next_Enabled;
      nbLast: LFReference := FDBNavImages.Last_Enabled;
      nbInsert: LFReference := FDBNavImages.Insert_Enabled;
      nbDelete: LFReference := FDBNavImages.Delete_Enabled;
      nbEdit: LFReference := FDBNavImages.Edit_Enabled;
      nbPost: LFReference := FDBNavImages.Post_Enabled;
      nbCancel: LFReference := FDBNavImages.Cancel_Enabled;
      nbRefresh: LFReference := FDBNavImages.Refresh_Enabled;
    end;

    VEnabled := LFReference.Location(WebApplication.URLBase);
    if VEnabled = '' then
      VEnabled := WebApplication.URLBase + '/gfx/DBNav_' + DBNavButtonNames[AButton] + '.gif';

    case AButton of
      nbFirst: LFReference := FDBNavImages.First_Disabled;
      nbPrior: LFReference := FDBNavImages.Prior_Disabled;
      nbNext: LFReference := FDBNavImages.Next_Disabled;
      nbLast: LFReference := FDBNavImages.Last_Disabled;
      nbInsert: LFReference := FDBNavImages.Insert_Disabled;
      nbDelete: LFReference := FDBNavImages.Delete_Disabled;
      nbEdit: LFReference := FDBNavImages.Edit_Disabled;
      nbPost: LFReference := FDBNavImages.Post_Disabled;
      nbCancel: LFReference := FDBNavImages.Cancel_Disabled;
      nbRefresh: LFReference := FDBNavImages.Refresh_Disabled;
    end;

    VDisabled := LFReference.Location(WebApplication.URLBase);
    if VDisabled = '' then
      VDisabled := WebApplication.URLBase + '/gfx/DBNav_' + DBNavButtonNames[AButton] + 'Disabled.gif';
  end;

  function DBNavImage(const AName: string; const AButton: TNavigateBtn; const AConfirmation: string;
    const ADoValidation: Boolean = True): TIWHTMLTag;
  Var
    LEnabledImage, LDisabledImage: String;

  begin
    ImageLocations(AButton, LEnabledImage, LDisabledImage);
    with Form as TIWForm do begin
      CacheImage(Self.HTMLName + '_' + DBNavButtonNames[AButton] + '_Enabled', LEnabledImage);
      CacheImage(Self.HTMLName + '_' + DBNavButtonNames[AButton] + '_Disabled', LDisabledImage);
    end;
    AddToInitProc(
      HTMLName + 'IWCL.' + DBNavButtonNames[AButton] + '_Enabled = "' + LEnabledImage + '";' + EOL +
      HTMLName + 'IWCL.' + DBNavButtonNames[AButton] + '_Disabled = "' + LDisabledImage + '";' + EOL);
    //No EOL, it causes Whitespace in Netscape
    //TODO: Use PageImage
    //
    Result := TIWHTMLTag.CreateTag('IMG');
    with Result do try
      AddStringParam('SRC', '');
      AddStringParam('ID', HTMLName + 'IWCL_' + DBNavButtonNames[AButton]);
      AddStringParam('ALT', DBNavButtonNames[AButton]);
      AddIntegerParam('BORDER', 0);
      AddIntegerParam('width', FImageWidth);
      AddIntegerParam('height', FImageHeight);
      AddStringParam('STYLE', 'cursor:hand;');
      AddStringParam('OnClick', HTMLName + 'IWCL.DataSet.' + DBNavButtonNames[AButton] + '();');
    except FreeAndNil(Result); raise; end;

    {if AEnabled then begin
      Result := TIWHTMLTag.Create('A');
      Result.Add('OnClick', '');
      Result.Contents.AddTag(LImgTag);
    end;}
    HintEvents(Result, DBNavButtonNames[AButton]);
  end;

Var
  LineTag: TIWHTMLTag;
  LTable: TIWHTMLTag;

  procedure AddImageTag(ATag: TIWHTMLTag);
  begin
    if LineTag = nil then begin
      LineTag := LTable.Contents.AddTag('TR');
    end
    else
      if Orientation = orVertical then begin
        LineTag := LTable.Contents.AddTag('TR');
      end;

    with LineTag.Contents.AddTag('TD') do begin
      AddIntegerParam('width', ImageWidth);
      AddIntegerParam('height', ImageHeight);
      Contents.AddTagAsObject(ATag);
    end;
  end;

begin
  Result := TIWHTMLTag.CreateTag('SPAN'); try
    LTable := Result.Contents.AddTag('TABLE');
    LTable.AddIntegerParam('cellspacing', 0);
    LTable.AddIntegerParam('border', 0);
    LTable.AddIntegerParam('cellpadding', 0);

    LineTag := nil;

    if nbFirst in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbFirst, Confirmations.First));
    end;
    if nbPrior in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbPrior, Confirmations.Prior));
    end;
    if nbNext in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbNext, Confirmations.Next));
    end;
    if nbLast in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbLast, Confirmations.Last));
    end;
    if nbEdit in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbEdit, Confirmations.Edit));
    end;
    if nbInsert in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbInsert, Confirmations.Insert));
    end;
    if nbDelete in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbDelete, Confirmations.Delete));
    end;
    if nbPost in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbPost, Confirmations.Post));
    end;
    if nbCancel in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbCancel, Confirmations.Cancel));
    end;
    if nbRefresh in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbRefresh, Confirmations.Refresh));
    end;
    if LTable.Contents.Count = 0 then begin
      FreeAndNil(Result);
    end;

    if Assigned(FCSDataSet) then begin
      result.Contents.AddTagAsObject(FCSDataSet.RenderIWComponent(TIWForm(Form)));
    end;
    AddToInitProc(HTMLName + 'IWCL.SetIWCLType(iwclDBNav);' + EOL);
    if Assigned(FCSDataSet) then begin
      AddToInitProc(HTMLName + 'IWCL.SetDataSet(CSDS' + FCSDataSet.Name + ');' + EOL);
    end else begin
      AddToInitProc(HTMLName + 'IWCL.SetDataSet(null);' + EOL);
    end;


  except FreeAndNil(Result); raise; end;
end;

procedure TIWCSCustomNavigator.SetCSDataSet(
  const Value: TIWClientSideDatasetBase);
begin
  FCSDataSet := Value;

  if FCSDataSet <> nil then begin
    FCSDataSet.FreeNotification(Self);
  end;
end;

procedure TIWCSCustomNavigator.SetDBNavImages(const Value: TIWDBNavImages);
begin
  FDBNavImages.Assign(Value);
end;

procedure TIWCSCustomNavigator.SetOrientation(const Value: TIWOrientation);
begin
  FOrientation := Value;
  Invalidate;
end;

procedure TIWCSCustomNavigator.SetVisibleButtons(Value: TButtonSet);
begin
  FVisibleButtons := Value;

  // This to avid the usge of Edit db navigator buttons ;-)
  if nbInsert in FVisibleButtons then begin
    FVisibleButtons := FVisibleButtons - [nbInsert];
  end;

  if nbDelete in FVisibleButtons then begin
    FVisibleButtons := FVisibleButtons - [nbDelete];
  end;

  if nbEdit in FVisibleButtons then begin
    FVisibleButtons := FVisibleButtons - [nbEdit];
  end;

  if nbPost in FVisibleButtons then begin
    FVisibleButtons := FVisibleButtons - [nbPost];
  end;

  if nbCancel in FVisibleButtons then begin
    FVisibleButtons := FVisibleButtons - [nbCancel];
  end;

  if nbRefresh in FVisibleButtons then begin
    FVisibleButtons := FVisibleButtons - [nbRefresh];
  end;

  Invalidate;
end;

procedure TIWCSCustomNavigator.Submit(const AValue: string);
begin
  inherited Submit(AValue);
end;

end.


