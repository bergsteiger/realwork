unit IWDBStdCtrls;
{PUBDIST}

interface

uses
  {$IFDEF Linux}QDBCtrls,{$ELSE}DBCtrls,{$ENDIF}
  {$IFDEF Linux}QControls,{$ELSE}Controls,{$ENDIF}
  Classes, DB,
  IWControl, IWCompCheckbox, IWCompEdit, IWCompLabel, IWCompListbox, IWCompMemo,
  IWCompText, IWHTMLTag, IWFileReference;

type
  TIWDBCheckBox = class(TIWCustomCheckBox)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    FValueChecked: string;
    FValueUnchecked: string;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetDataField(const AValue: string);
    procedure SetValue(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to true when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write SetDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property ValueChecked: string read FValueChecked write FValueChecked;
    property ValueUnchecked: string read FValueUnchecked write FValueUnchecked;
  end;

  TIWDBComboBox = class(TIWCustomCombobox)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to truw when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property Items;
    property Sorted;
  end;

  TIWDBEdit = class(TIWCustomEdit)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Paint; override;
    procedure SetValue(const AValue: string); override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to truw when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    //@@ If True, this indicates that this field is to be used for password or other masked entry.
    // When True, the field will not show the text the user is typing. Instead of the actual
    // characters a single mask character such as * will be displayed. The actual character that is
    // displayed is determined by the browser. This only affects display, and not the actual data
    // that is available for use at run time.
    //
    // This is usually done to prevent people from obtaining a password simply by looking over the
    // user's shoulder.
    property PasswordPrompt: boolean read FPasswordPrompt write SetPasswordPrompt;
  end;

  TIWDBFile = class(TIWCustomFile)
  protected
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  published
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
  end;

  TIWDBLabel = class(TIWCustomLabel)
  protected
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Paint; override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    property AutoSize;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
  end;

  TIWDBListbox = class(TIWCustomListbox)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to truw when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property Items;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property Sorted;
  end;

  TIWDBLookupComboBox = class(TIWCustomCombobox)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    FKeyField: string;
    FKeyItems: TStrings;
    FListField: string;
    FListSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to truw when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property KeyField: string read FKeyField write FKeyField;
    property ListField: string read FListField write FListField;
    property ListSource: TDataSource read FListSource write FListSource;
  end;

  TIWDBLookupListBox = class(TIWCustomListbox)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    FKeyField: string;
    FKeyItems: TStrings;
    FListField: string;
    FListSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to truw when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property KeyField: string read FKeyField write FKeyField;
    property ListField: string read FListField write FListField;
    property ListSource: TDataSource read FListSource write FListSource;
  end;

  TIWDBMemo = class(TIWCustomMemo)
  protected
    FAutoEditable: Boolean;
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetValue(const AValue: string); override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ AutoEditable if True will automatically set the Editable property to truw when the dataset
    //is in an editable mode (Edit, Insert) and set Editable to False when it is not in an editable
    //mode.
    property AutoEditable: Boolean read FAutoEditable write FAutoEditable;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
  end;

  TIWDBNavigator = class;

  TIWDBNavImages = class(TPersistent)
  protected
    FDelete: TIWFileReference;
    FPost: TIWFileReference;
    FCancel: TIWFileReference;
    FFirst: TIWFileReference;
    FNext: TIWFileReference;
    FInsert: TIWFileReference;
    FEdit: TIWFileReference;
    FRefresh: TIWFileReference;
    FLast: TIWFileReference;
    FPrior: TIWFileReference;
    //
    FDelete_Disabled: TIWFileReference;
    FPost_Disabled: TIWFileReference;
    FCancel_Disabled: TIWFileReference;
    FFirst_Disabled: TIWFileReference;
    FNext_Disabled: TIWFileReference;
    FInsert_Disabled: TIWFileReference;
    FEdit_Disabled: TIWFileReference;
    FRefresh_Disabled: TIWFileReference;
    FLast_Disabled: TIWFileReference;
    FPrior_Disabled: TIWFileReference;
    //
    FParentDBNavigator: TIWDBNavigator;
    procedure SetCancel(const Value: TIWFileReference);
    procedure SetDelete(const Value: TIWFileReference);
    procedure SetEdit(const Value: TIWFileReference);
    procedure SetFirst(const Value: TIWFileReference);
    procedure SetInsert(const Value: TIWFileReference);
    procedure SetLast(const Value: TIWFileReference);
    procedure SetNext(const Value: TIWFileReference);
    procedure SetPost(const Value: TIWFileReference);
    procedure SetPrior(const Value: TIWFileReference);
    procedure SetRefresh(const Value: TIWFileReference);
    procedure SetCancel_Disabled(const Value: TIWFileReference);
    procedure SetDelete_Disabled(const Value: TIWFileReference);
    procedure SetEdit_Disabled(const Value: TIWFileReference);
    procedure SetFirst_Disabled(const Value: TIWFileReference);
    procedure SetInsert_Disabled(const Value: TIWFileReference);
    procedure SetLast_Disabled(const Value: TIWFileReference);
    procedure SetNext_Disabled(const Value: TIWFileReference);
    procedure SetPost_Disabled(const Value: TIWFileReference);
    procedure SetPrior_Disabled(const Value: TIWFileReference);
    procedure SetRefresh_Disabled(const Value: TIWFileReference);
  public
    constructor Create(const AParenDBNav: TIWDBNavigator);
    destructor Destroy; override;
  published
    property First_Enabled: TIWFileReference read FFirst write SetFirst;
    property First_Disabled: TIWFileReference read FFirst_Disabled write SetFirst_Disabled;
    property Prior_Enabled: TIWFileReference read FPrior write SetPrior;
    property Prior_Disabled: TIWFileReference read FPrior_Disabled write SetPrior_Disabled;
    property Next_Enabled: TIWFileReference read FNext write SetNext;
    property Next_Disabled: TIWFileReference read FNext_Disabled write SetNext_Disabled;
    property Last_Enabled: TIWFileReference read FLast write SetLast;
    property Last_Disabled: TIWFileReference read FLast_Disabled write SetLast_Disabled;
    property Edit_Enabled: TIWFileReference read FEdit write SetEdit;
    property Edit_Disabled: TIWFileReference read FEdit_Disabled write SetEdit_Disabled;
    property Insert_Enabled: TIWFileReference read FInsert write SetInsert;
    property Insert_Disabled: TIWFileReference read FInsert_Disabled write SetInsert_Disabled;
    property Delete_Enabled: TIWFileReference read FDelete write SetDelete;
    property Delete_Disabled: TIWFileReference read FDelete_Disabled write SetDelete_Disabled;
    property Post_Enabled: TIWFileReference read FPost write SetPost;
    property Post_Disabled: TIWFileReference read FPost_Disabled write SetPost_Disabled;
    property Cancel_Enabled: TIWFileReference read FCancel write SetCancel;
    property Cancel_Disabled: TIWFileReference read FCancel_Disabled write SetCancel_Disabled;
    property Refresh_Enabled: TIWFileReference read FRefresh write SetRefresh;
    property Refresh_Disabled: TIWFileReference read FRefresh_Disabled write SetRefresh_Disabled;
  end;

  TIWDBNavConfirmations = class(TPersistent)
  protected
    FFirst: string;
    FPrior: string;
    FNext: string;
    FLast: string;
    FEdit: string;
    FInsert: string;
    FDelete: string;
    FPost: string;
    FCancel: string;
    FRefresh: string;
  public
    constructor Create(const ADesignMode: Boolean);
  published
    property First: string read FFirst write FFirst;
    property Prior: string read FPrior write FPrior;
    property Next: string read FNext write FNext;
    property Last: string read FLast write FLast;
    property Edit: string read FEdit write FEdit;
    property Insert: string read FInsert write FInsert;
    property Delete: string read FDelete write FDelete;
    property Post: string read FPost write FPost;
    property Cancel: string read FCancel write FCancel;
    property Refresh: string read FRefresh write FRefresh;
  end;

  TIWOrientation = (orHorizontal, orVertical);

  TIWDBNavigator = class(TIWControl)
  protected
    FConfirmations: TIWDBNavConfirmations;
    FDataSource: TDataSource;
    FImageWidth: Integer;
    FImageHeight: Integer;
    FOnFirst: TNotifyEvent;
    FOnPrior: TNotifyEvent;
    FOnNext: TNotifyEvent;
    FOnLast: TNotifyEvent;
    FOnEdit: TNotifyEvent;
    FOnInsert: TNotifyEvent;
    FOnDelete: TNotifyEvent;
    FOnPost: TNotifyEvent;
    FOnCancel: TNotifyEvent;
    FOnRefresh: TNotifyEvent;
    FVisibleButtons: TButtonSet;
    FDBNavImages: TIWDBNavImages;
    FOrientation: TIWOrientation;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetVisibleButtons(Value: TButtonSet);
    procedure SetDBNavImages(const Value: TIWDBNavImages);
    procedure SetOrientation(const Value: TIWOrientation);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;
    procedure Submit(const AValue: string); override;
  published
    //@@ Confirmations contains text messages to use to confirm a users actions. To disable an
    //individual confirmation simply set it to ''.
    property Confirmations: TIWDBNavConfirmations read FConfirmations write FConfirmations;
    //@@ Datasource to manipulate.
    property DataSource: TDataSource read FDataSource write FDataSource;
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
    //
    property OnFirst: TNotifyEvent read FOnFirst write FOnFirst;
    property OnPrior: TNotifyEvent read FOnPrior write FOnPrior;
    property OnNext: TNotifyEvent read FOnNext write FOnNext;
    property OnLast: TNotifyEvent read FOnLast write FOnLast;
    property OnEdit: TNotifyEvent read FOnEdit write FOnEdit;
    property OnInsert: TNotifyEvent read FOnInsert write FOnInsert;
    property OnDelete: TNotifyEvent read FOnDelete write FOnDelete;
    property OnPost: TNotifyEvent read FOnPost write FOnPost;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
    property OnRefresh: TNotifyEvent read FOnRefresh write FOnRefresh;
  end;

  TIWDBText = class(TIWCustomText)
  protected
    FDataField: string;
    FDataSource: TDataSource;
    //
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    function RenderHTML: TIWHTMLTag; override;
  published
    //@@ Datafield to retreive data from.
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property Font;
    property RawText;
    property UseFrame;
    property WantReturns;
  end;

// Procs
  function InEditMode(ADataset: TDataset): Boolean;
  function CheckDataSource(ADataSource: TDataSource): Boolean; overload;
  function CheckDataSource(ADataSource: TDataSource; const AFieldName: string; var VField: TField)
   : boolean; overload;

implementation

// TODO: (for 5.1 or 6): to check all Combo and list box controls so they use ItemsHasValues

{$R IWDB.res}

uses
  {$IFDEF Linux}
  Types,
  QButtons,
  QGraphics,
  {$ELSE}
  Windows,
  Buttons,
  Graphics,
  {$ENDIF}
  IWResourceStrings,
  SWSystem, SysUtils;

function InEditMode(ADataset: TDataset): Boolean;
begin
  Result := ADataset.State in [dsEdit, dsInsert];
end;

function CheckDataSource(ADataSource: TDataSource): boolean; overload;
begin
  Result := False;
  if ADataSource <> nil then begin
    if ADataSource.Dataset <> nil then begin
      Result := ADataSource.Dataset.Active;
    end;
  end;
end;

function CheckDataSource(ADataSource: TDataSource; const AFieldName: string; var VField: TField)
 : boolean;
begin
  Result := CheckDataSource(ADataSource) and (Length(AFieldName) > 0);
  if Result then begin
    VField := ADataSource.Dataset.FieldByName(AFieldName);
  end;
end;

function GetFieldText(AField: TField): String;
begin
  if AField.IsBlob then begin
    if Assigned(AField.OnGetText) then begin
      result := AField.Text;
    end else begin
      result := AField.AsString;
    end;
  end
  else begin
    result := AField.Text;
  end;
end;

procedure SetFieldText(AField: TField; AText: String);
begin
end;

{ TIWDBEdit }

procedure TIWDBEdit.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

procedure TIWDBEdit.Paint;
begin
  Text := DataField;
  inherited Paint;
end;

function TIWDBEdit.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
    if Editable then begin
      Text := GetFieldText(LField);
    end else begin
      Text := LField.DisplayText;
    end;

    if (LField.DataType = ftString) then begin
      MaxLength := LField.Size;
    end;
  end else begin
    Text := '';
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBEdit.SetValue(const AValue: string);
var
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    if (GetFieldText(LField) <> Text) then begin
      Datasource.Edit;
      LField.Text := Text;
    end;
  end;
end;

{ TIWDBLabel }

procedure TIWDBLabel.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

procedure TIWDBLabel.Paint;
begin
  if Length(DataField) = 0 then begin
    Caption := Name;
  end else begin
    Caption := DataField;
  end;
  inherited Paint;
end;

function TIWDBLabel.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    // Still need this check for TDateTimeField with .DisplayText?
    if LField is TDateTimeField then begin
      Caption := FormatDateTime(TDateTimeField(LField).DisplayFormat, LField.AsDateTime);
    end else begin
      Caption := LField.DisplayText;
    end;
  end else begin
    Caption := '';
  end;
  Result := inherited RenderHTML;
end;

{ TIWDBMemo }

procedure TIWDBMemo.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBMemo.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    FLines.Text := GetFieldText(LField);
    FEndsWithCRLF := FLines.Text = GetFieldText(LField);
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
  end else begin
    FLines.Clear;
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBMemo.SetValue(const AValue: string);
var
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    // After SetValue Text holds the real value
    // When AValue does not end with CR-LF FLisnes automatically adds CRLF
    if (GetFieldText(LField) <> Text) then begin
      Datasource.Edit;
      LField.AsString := Text; 
    end;
  end;
end;

{ TIWDBNavigator }

constructor TIWDBNavigator.Create(AOwner: TComponent);
var
  LUseDefaults: Boolean;
begin
  inherited Create(AOwner);
  FSupportsSubmit := True;
  //
  LUseDefaults := False;
  if Owner <> nil then begin
    LUseDefaults :=  (Owner.ComponentState * [csReading, csDesigning]) = [csDesigning];
  end;
  FConfirmations := TIWDBNavConfirmations.Create(LUseDefaults);
  FDBNavImages := TIWDBNavImages.Create(Self);
  //
  VisibleButtons := [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel
   , nbRefresh];
  Height := 25;
  Width := 250;
  ImageHeight := 21;
  ImageWidth := 21;
end;

destructor TIWDBNavigator.Destroy;
begin
  FreeAndNil(FConfirmations);
  FreeAndNil(FDBNavImages);
  inherited Destroy;
end;

procedure TIWDBNavigator.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBNavigator.RenderHTML: TIWHTMLTag;
var
  LBOF: Boolean;
  LCanModify: Boolean;
  LEOF: Boolean;
  LEditMode: Boolean;
  LValidDataset: Boolean;

Const
  DBNavButtonNames: array [TNavigateBtn] of String =
    (RSbtnNameFirst, RSbtnNamePrior, RSbtnNameNext, RSbtnNameLast, RSbtnNameInsert,
    RSbtnNameDelete, RSbtnNameEdit, RSbtnNamePost, RSbtnNameCancel, RSbtnNameRefresh);
  // Don't remove. Will need this for one more thing.
  DBNavButtonImages: array [TNavigateBtn] of String =
    ('First', 'Prior', 'Next', 'Last', 'Insert', 'Delete', 'Edit', { do not localize }
    'Post', 'Cancel', 'Refresh');                                  { do not localize }

  function DBNavImage(const AName: string; const AButton: TNavigateBtn; const AConfirmation: string;
    const AEnabled: Boolean = True; const ADoValidation: Boolean = True): TIWHTMLTag;
  Var
    LImgTag: TIWHTMLTag;
    LImageSrc: String;
    LFReference: TIWFileReference;
  begin
    //No EOL, it causes Whitespace in Netscape
    //TODO: Use PageImage

    // To avoid warining messages
    LFReference := nil;
    //
    if AEnabled then begin
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
    end
    else begin
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
    end;

    LImageSrc := LFReference.Location(WebApplication.URLBase);

    if LImageSrc = '' then
      LImageSrc := WebApplication.URLBase + '/gfx/DBNav_' + DBNavButtonImages[AButton] + iif(not (AEnabled and LValidDataset), 'Disabled') + '.gif';

    LImgTag := TIWHTMLTag.CreateTag('IMG');
    with LImgTag do try
      AddStringParam('SRC', LImageSrc);
      AddStringParam('ALT', DBNavButtonNames[AButton]);
      AddIntegerParam('BORDER', 0);
      AddIntegerParam('width', FImageWidth);
      AddIntegerParam('height', FImageHeight);
    except FreeAndNil(LImgTag); raise; end;

    Result := LImgTag;

    if AEnabled then begin
      Result := TIWHTMLTag.CreateTag('A'); try
        Result.AddStringParam('OnClick', 'return SubmitClickConfirm(''' + AName + ''','''
           + DBNavButtonNames[AButton] + ''''
           + ', ' + iif(ADoValidation, 'true', 'false')
           + ', ''' + AConfirmation + ''''
           + ')');
        Result.Contents.AddTagAsObject(LImgTag);
      except FreeAndNil(Result); raise; end;
    end;
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
    LValidDataset := CheckDatasource(DataSource);
    LBOF := False;
    LEOF := False;
    LCanModify := False;
    LEditMode := False;
    if LValidDataset then begin
      LBOF := DataSource.Dataset.BOF;
      LEOF := DataSource.Dataset.EOF;
      LCanModify := DataSource.Dataset.CanModify;
      LEditMode := InEditMode(DataSource.Dataset);
    end;
    LTable.AddIntegerParam('cellspacing', 0);
    LTable.AddIntegerParam('border', 0);
    LTable.AddIntegerParam('cellpadding', 0);

    LineTag := nil;

    if nbFirst in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbFirst, Confirmations.First
        , (LBOF = False) and LValidDataset));
    end;
    if nbPrior in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbPrior, Confirmations.Prior
        , (LBOF = False) and LValidDataset));
    end;
    if nbNext in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbNext, Confirmations.Next
        , (LEOF = False) and LValidDataset));
    end;
    if nbLast in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbLast, Confirmations.Last
        , (LEOF = False) and LValidDataset));
    end;
    if nbEdit in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbEdit, Confirmations.Edit
        , (LEditMode = False) and LCanModify and LValidDataset));
    end;
    if nbInsert in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbInsert, Confirmations.Insert
        , (LEditMode = False) and LCanModify and LValidDataset));
    end;
    if nbDelete in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbDelete, Confirmations.Delete
        , (LEditMode = False) and LCanModify and LValidDataset, False));
    end;
    if nbPost in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbPost, Confirmations.Post
        , LEditMode and LCanModify and LValidDataset));
    end;
    if nbCancel in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbCancel, Confirmations.Cancel
        , LEditMode and LCanModify and LValidDataset, False));
    end;
    if nbRefresh in VisibleButtons then begin
      AddImageTag(DBNavImage(HTMLName, nbRefresh, Confirmations.Refresh
        , (LEditMode = False) and LCanModify and LValidDataset, False));
    end;
    if LTable.Contents.Count = 0 then begin
      FreeAndNil(Result);
    end;
  except FreeAndNil(Result); raise; end;
end;

procedure TIWDBNavigator.SetDBNavImages(const Value: TIWDBNavImages);
begin
  FDBNavImages.Assign(Value);
end;

procedure TIWDBNavigator.SetOrientation(const Value: TIWOrientation);
begin
  FOrientation := Value;
  Invalidate;
end;

procedure TIWDBNavigator.SetVisibleButtons(Value: TButtonSet);
begin
  FVisibleButtons := Value;
  Invalidate;
end;

procedure TIWDBNavigator.Submit(const AValue: string);

  procedure DoEvent(AEvent: TNotifyEvent);
  begin
    if Assigned(AEvent) then begin
      AEvent(Self);
    end;
  end;

begin
  if CheckDatasource(DataSource) then begin
    if SameText(AValue, RSbtnNameFirst) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Post;
      Datasource.Dataset.First;
      DoEvent(OnFirst);
    end else if SameText(AValue, RSbtnNamePrior) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Post;
      Datasource.Dataset.Prior;
      DoEvent(OnPrior);
    end else if SameText(AValue, RSbtnNameNext) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Post;
      Datasource.Dataset.Next;
      DoEvent(OnNext);
    end else if SameText(AValue, RSbtnNameLast) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Post;
      Datasource.Dataset.Last;
      DoEvent(OnLast);
    end else if SameText(AValue, RSbtnNameEdit) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Post;
      Datasource.Dataset.Edit;
      DoEvent(OnEdit);
    end else if SameText(AValue, RSbtnNameInsert) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Post;
      Datasource.Dataset.Insert;
      DoEvent(OnInsert);
    end else if SameText(AValue, RSbtnNameDelete) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Cancel;
      Datasource.Dataset.Delete;
      DoEvent(OnDelete);
    end else if SameText(AValue, RSbtnNamePost) then begin
      Datasource.Dataset.Post;
      DoEvent(OnPost);
    end else if SameText(AValue, RSbtnNameCancel) then begin
      Datasource.Dataset.Cancel;
      DoEvent(OnCancel);
    end else if SameText(AValue, RSbtnNameRefresh) then begin
      if InEditMode(Datasource.Dataset) then
        Datasource.Dataset.Cancel;
      Datasource.Dataset.Refresh;
      DoEvent(OnRefresh);
    end else begin
      raise Exception.Create(Format(RSInvalidResponse, [AValue]));
    end;
  end;
end;

{ TIWDBText }

procedure TIWDBText.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBText.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    FLines.Text := GetFieldText(LField);
  end else begin
    FLines.Clear;
  end;
  Result := inherited RenderHTML;
end;

{ TIWDBCheckBox }

constructor TIWDBCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ValueChecked := 'true';
  ValueUnchecked := 'false';
end;

procedure TIWDBCheckBox.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBCheckBox.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    FChecked := AnsiSameText(ValueChecked, GetFieldText(LField));
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
  end else begin
    FChecked := False;
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBCheckBox.SetDataField(const AValue: string);
begin
  FDataField := AValue;
  Invalidate;
end;

procedure TIWDBCheckBox.SetValue(const AValue: string);
var
  s: string;
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    s := iif(FChecked, ValueChecked, ValueUnChecked);
    if not AnsiSameText(GetFieldText(LField), s) then begin
      DataSource.Edit;
      LField.Text := s;
    end;
  end;
end;

{ TIWDBComboBox }

procedure TIWDBComboBox.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBComboBox.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    FItemIndex := FItems.IndexOf(GetFieldText(LField));
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
  end else begin
    FItemIndex := -1;
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBComboBox.SetValue(const AValue: string);
var
  s: string;
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    if FItemIndex > -1 then begin
      with FItems do begin
        if ItemsHaveValues then begin
          s := Values[Names[FItemIndex]];
        end
        else begin
          s := FItems[FItemIndex];
        end;
      end;
    end else begin
      s := '';
    end;
    if (GetFieldText(LField) <> s) then begin
      DataSource.Edit;
      LField.Text := s;
    end;
  end;
end;

{ TIWDBListbox }

procedure TIWDBListbox.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;

function TIWDBListbox.RenderHTML: TIWHTMLTag;
var
  LField: TField;
begin
  if CheckDataSource(DataSource, DataField, LField) then begin
    FItemIndex := FItems.IndexOf(GetFieldText(LField));
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
  end else begin
    FItemIndex := -1;
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBListbox.SetValue(const AValue: string);
var
  s: string;
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    if FItemIndex > -1 then begin
      with FItems do begin
        if ItemsHaveValues then begin
          s := Values[Names[FItemIndex]];
        end
        else begin
          s := FItems[FItemIndex];
        end;
      end;
    end else begin
      s := '';
    end;
    if (GetFieldText(LField) <> s) then begin
      DataSource.Edit;
      LField.Text := s;
    end;
  end;
end;

{ TIWDBLookupComboBox }

constructor TIWDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FKeyItems := TStringList.Create;
  FItemIndex := -1;
end;

destructor TIWDBLookupComboBox.Destroy;
begin
  FreeAndNil(FKeyItems);
  inherited Destroy;
end;

procedure TIWDBLookupComboBox.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
    if FListSource = AComponent then begin
      FListSource := nil;
    end;
  end;
end;

function TIWDBLookupComboBox.RenderHTML: TIWHTMLTag;
var
  LField: TField;
  LKeyField: TField;
begin
  FItems.Clear;
  FKeyItems.Clear;
  if CheckDataSource(ListSource, ListField, LField)
   and CheckDataSource(ListSource, KeyField, LKeyField) then begin
    ListSource.DataSet.First;
    while not ListSource.Dataset.EOF do begin
      FItems.Add(GetFieldText(LField));
      FKeyItems.Add(GetFieldText(LKeyField));
      ListSource.DataSet.Next;
    end;
  end;
  if CheckDataSource(DataSource, DataField, LField) then begin
    if LField.IsNull then begin
      FItemIndex := -1;
    end else begin
      FItemIndex := FKeyItems.IndexOf(GetFieldText(LField));
    end;
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
  end else begin
    FItemIndex := -1;
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBLookupComboBox.SetValue(const AValue: string);
var
  s: string;
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    if ItemIndex = -1 then begin
      s := #0;
    end else begin
      s := FKeyItems[ItemIndex];
    end;
    if ((LField.IsNull) and (S <> #0)) or (GetFieldText(LField) <> s) then begin
      DataSource.Edit;
      if s = #0 then begin
        LField.Clear;
      end else begin
        LField.Text := s;
      end;
    end;
  end;
end;

{ TIWDBLookupListBox }

constructor TIWDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FKeyItems := TStringList.Create;
end;

destructor TIWDBLookupListBox.Destroy;
begin
  FreeAndNil(FKeyItems);
  inherited Destroy;
end;

procedure TIWDBLookupListBox.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
    if FListSource = AComponent then begin
      FListSource := nil;
    end;
  end;
end;

function TIWDBLookupListBox.RenderHTML: TIWHTMLTag;
var
  LField: TField;
  LKeyField: TField;
begin
  FItems.Clear;
  FKeyItems.Clear;
  if CheckDataSource(ListSource, ListField, LField)
   and CheckDataSource(ListSource, KeyField, LKeyField) then begin
    ListSource.DataSet.First;
    while not ListSource.Dataset.EOF do begin
      FItems.Add(GetFieldText(LField));
      FKeyItems.Add(GetFieldText(LKeyField));
      ListSource.DataSet.Next;
    end;
  end;
  if CheckDataSource(DataSource, DataField, LField) then begin
    if LField.IsNull then begin
      FItemIndex := -1;
    end else begin
      FItemIndex := FKeyItems.IndexOf(GetFieldText(LField));
    end;
    if AutoEditable then begin
      Editable := InEditMode(DataSource.Dataset);
    end;
  end else begin
    FItemIndex := -1;
    if AutoEditable then begin
      Editable := False;
    end;
  end;
  Result := inherited RenderHTML;
end;

procedure TIWDBLookupListBox.SetValue(const AValue: string);
var
  s: string;
  LField: TField;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    if FItemIndex = -1 then begin
      s := #0;
    end else begin
      s := FKeyItems[FItemIndex];
    end;
    if ((LField.IsNull) and (S <> #0)) or (GetFieldText(LField) <> s) then begin
      DataSource.Edit;
      if s = #0 then begin
        LField.Clear;
      end else begin
        LField.Text := s;
      end;
    end;
  end;
end;

{ TIWDBNavConfirmations }

constructor TIWDBNavConfirmations.Create(const ADesignMode: Boolean);
begin
  inherited Create;
  // Since Delphi does not write out empty strings, only default at design time so that
  // the user can set them to empty strings to disable them.
  // This does have a side effect of not defaulting if the user dynamically creates a DBNav.
  if ADesignMode then begin
    Delete := RSDeleteMessage;
    Post := RSUpdateMessage;
    Cancel := RSCancelMessage;
  end;
end;

{ TIWDBNavImages }

constructor TIWDBNavImages.Create(const AParenDBNav: TIWDBNavigator);
begin
  inherited Create;
  FParentDBNavigator := AParenDBNav;
  FDelete := TIWFileReference.Create;
  FPost := TIWFileReference.Create;
  FCancel := TIWFileReference.Create;
  FFirst := TIWFileReference.Create;
  FNext := TIWFileReference.Create;
  FInsert := TIWFileReference.Create;
  FEdit := TIWFileReference.Create;
  FRefresh := TIWFileReference.Create;
  FLast := TIWFileReference.Create;
  FPrior := TIWFileReference.Create;

  FDelete_Disabled := TIWFileReference.Create;
  FPost_Disabled := TIWFileReference.Create;
  FCancel_Disabled := TIWFileReference.Create;
  FFirst_Disabled := TIWFileReference.Create;
  FNext_Disabled := TIWFileReference.Create;
  FInsert_Disabled := TIWFileReference.Create;
  FEdit_Disabled := TIWFileReference.Create;
  FRefresh_Disabled := TIWFileReference.Create;
  FLast_Disabled := TIWFileReference.Create;
  FPrior_Disabled := TIWFileReference.Create;
end;

destructor TIWDBNavImages.Destroy;
begin
  FreeAndNil(FDelete);
  FreeAndNil(FPost);
  FreeAndNil(FCancel);
  FreeAndNil(FFirst);
  FreeAndNil(FNext);
  FreeAndNil(FInsert);
  FreeAndNil(FEdit);
  FreeAndNil(FRefresh);
  FreeAndNil(FLast);
  FreeAndNil(FPrior);

  FreeAndNil(FDelete_Disabled);
  FreeAndNil(FPost_Disabled);
  FreeAndNil(FCancel_Disabled);
  FreeAndNil(FFirst_Disabled);
  FreeAndNil(FNext_Disabled);
  FreeAndNil(FInsert_Disabled);
  FreeAndNil(FEdit_Disabled);
  FreeAndNil(FRefresh_Disabled);
  FreeAndNil(FLast_Disabled);
  FreeAndNil(FPrior_Disabled);
  inherited Destroy;
end;

procedure TIWDBNavImages.SetCancel(const Value: TIWFileReference);
begin
  FCancel.Assign(Value);
end;

procedure TIWDBNavImages.SetCancel_Disabled(const Value: TIWFileReference);
begin
  FCancel_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetDelete(const Value: TIWFileReference);
begin
  FDelete.Assign(Value);
end;

procedure TIWDBNavImages.SetDelete_Disabled(const Value: TIWFileReference);
begin
  FDelete_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetEdit(const Value: TIWFileReference);
begin
  FEdit.Assign(Value);
end;

procedure TIWDBNavImages.SetEdit_Disabled(const Value: TIWFileReference);
begin
  FEdit_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetFirst(const Value: TIWFileReference);
begin
  FFirst.Assign(Value);
end;

procedure TIWDBNavImages.SetFirst_Disabled(const Value: TIWFileReference);
begin
  FFirst_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetInsert(const Value: TIWFileReference);
begin
  FInsert.Assign(Value);
end;

procedure TIWDBNavImages.SetInsert_Disabled(const Value: TIWFileReference);
begin
  FInsert_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetLast(const Value: TIWFileReference);
begin
  FLast.Assign(Value);
end;

procedure TIWDBNavImages.SetLast_Disabled(const Value: TIWFileReference);
begin
  FLast_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetNext(const Value: TIWFileReference);
begin
  FNext.Assign(Value);
end;

procedure TIWDBNavImages.SetNext_Disabled(const Value: TIWFileReference);
begin
  FNext_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetPost(const Value: TIWFileReference);
begin
  FPost.Assign(Value);
end;

procedure TIWDBNavImages.SetPost_Disabled(const Value: TIWFileReference);
begin
  FPost_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetPrior(const Value: TIWFileReference);
begin
  FPrior.Assign(Value);
end;

procedure TIWDBNavImages.SetPrior_Disabled(const Value: TIWFileReference);
begin
  FPrior_Disabled.Assign(Value);
end;

procedure TIWDBNavImages.SetRefresh(const Value: TIWFileReference);
begin
  FRefresh.Assign(Value);
end;

procedure TIWDBNavImages.SetRefresh_Disabled(
  const Value: TIWFileReference);
begin
  FRefresh_Disabled.Assign(Value);
end;

{ TIWDBFile }

procedure TIWDBFile.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if AOperation = opRemove then begin
    if FDatasource = AComponent then begin
      FDatasource := nil;
    end;
  end;
end;


procedure TIWDBFile.SetValue(const AValue: string);
var
  LField: TField;
  LStream: TStream;
begin
  inherited SetValue(AValue);
  if CheckDataSource(DataSource, DataField, LField) then begin
    if Assigned(FileData) then begin
      Datasource.Edit;
      LStream := LField.DataSet.CreateBlobStream(LField.DataSet.FieldByName(DataField), bmWrite);
      try
        SaveToStream(LStream);
      finally
        FreeAndNil(LStream);
      end;
    end;
  end;
end;

end.