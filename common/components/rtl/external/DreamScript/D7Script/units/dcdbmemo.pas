{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdbmemo;

interface
{$I dc.inc}

uses
  windows, classes, sysutils, controls, messages, db, dbctrls, dcsystem, dcstring,
  dcmemo,  dcdreamlib, dcconsts
  {$IFNDEF D3}
  {$IFDEF USEBDE},dbtables{$ENDIF} 
  {$ENDIF}
  ;
type

 TCustomDBMemoSource = class(TCustomMemoSource)
  private
    FDataLink    : TFieldDataLink;
    FAutoDisplay : boolean;
    FFocused     : boolean;
    FMemoLoaded  : boolean;
    FCanEditFlag : boolean;
    FCanLoadFlag : boolean;
    FInRtfLoad   : boolean;
    procedure DataChange(Sender : TObject);
    procedure EditingChange(Sender : TObject);
    function  GetDataField : string;
    function  GetDataSource : TDataSource;
    function  GetField : TField;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);
    procedure SetAutoDisplay(Value : Boolean);
    procedure UpdateData(Sender : TObject);
    procedure CMGetDataLink(var Message : TMessage); message CM_GETDATALINK;
    procedure CheckMemo(Value : boolean);
    procedure SetMemoLines(Text : string);
    function  CanEdit : boolean;
    procedure BeforeChange;
    procedure AfterChange;
    function  GetMemo : TCustomDCMemo;
  protected
    function  GetReadOnly : Boolean; override;
    procedure Loaded; override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    function  MemoNotify(Sender : TObject; var Msg : TMessage):boolean;override;
    procedure SelAttributesUpdated; override;
    procedure DoLoadFromFile(const AFileName : string); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure LoadMemo;
    procedure BreakLine; override;
    procedure JoinLines; override;
    function  Insert(const S : String) : boolean; override;
    procedure ProcessEscape; override;
    procedure PressEnter; override;
    procedure DeleteRight(Number : integer);override;
    property  Field : TField read GetField;
    property  AutoDisplay : Boolean read FAutoDisplay write SetAutoDisplay default true;
    property  DataField : string read GetDataField write SetDataField;
    property  DataSource : TDataSource read GetDataSource write SetDataSource;
    property  ReadOnly;
  end;

  TDBMemoSource = class (TCustomDBMemoSource)
  published
//    property MaxLineCount;
    property AutoDisplay;
    property DataField;
    property DataSource;
    property Options;
    property SyntaxParser;
    property TabStops;
    property Delimeters;
    property ReadOnly;
    property BlockIndent;
    property SpacesInTab;
    property CodeTemplates;
    property TemplatesType;
    property HighlightUrls;
    property OnGetBackupName;
    property OnSearchException;
    property OnPasteFromClipboard;
    property OnCreateDialog;
    property UseGlobalOptions;//This must be the last property
  end;

  TCustomDCDBMemo = class(TCustomDCMemo)
  private
    function  GetAutoDisplay : boolean;
    procedure SetAutoDisplay(Value : boolean);
    function  GetDataField : string;
    procedure SetDataField(Value : string);
    function  GetDataSource : TDataSource;
    procedure SetDataSource(Value : TDataSource);
  protected
    function  CreateDefaultMemoSource : TCustomMemoSource; override;
  public
    property AutoDisplay : Boolean read GetAutoDisplay write SetAutoDisplay;
    property DataField : string read GetDataField write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
  end;

  TDCDBMemo = class(TCustomDCDBMemo)
  published
    property DisabledColor;
    property ReadOnlyColor;
    property PrintOptions;
    property WantReturns;
    property WantTabs;
    property LineNumColor;
    property LineNumAlign;
    property StringsOptions;
    property SyntaxParser;
    property TabStops;
    property Delimeters;
    property KeyMapping;

    property UseMonoFont;
    property WordSelectionType;
    property AllowUndo;
    property UndoLimit;

    property SelColor;
    property SelBackColor;
    property MatchColor;
    property MatchBackColor;
    property LineBookmarkColor;

    property GutterBackColor;
    property HorzMaxPos;
    property HideSelection;
    property HideScrollBars;
    property BorderStyle;
    property ScrollBars;
    property Options;
    property MarginPos;
    property GutterBrush;
    property MarginPen;
    property GutterLineColor;
    property GutterWidth;
    property GutterImgs;
    property GutterImgsAlign;
    property LeftIndent;
    property PrintIndent;

    property BlockOption;
    property WordWrap;
    property OutFormat;
    property BkgndOption;
    property Background;
    property MemoBackground;
    property GutterBackground;
    property LineSeparator;
    property LineHighlight;
    property SpecialSymbols;
    property LineNumBackColor;
    property GutterLineIndent;
    property UseDefaultMenu;
    property ClipboardType;
    property PlainText;
    property OemConvert;

    property OnStateChange;
    property OnSelectionChange;
    property OnJumpToUrl;
    property OnClickGutter;
    property OnHintPopup;
    property OnTemplateInsert;
    property OnHintInsert;
    property OnCreateDialog;
    property OnMemoScroll;
    property OnVerticalScroll;

    property OnCustomString;
    property OnCustomDraw;

    property OnCollapseStateChanging;
    property OnCollapseStateChanged;
    property OnExportString;
    property OnFindStringInPopup;
    property OnGetLineNumber;

    property ReadOnly;
    property Font;
    property TextStyles;
    property PrinterFont;
    property UsePrinterFont;
    property TemplateFont;
    property AutoDisplay;
    property DataField;
    property DataSource;
    property BlockIndent;
    property SpacesInTab;                                                                           
                                                                                                    
    {----------}                                                                                    
    {$IFNDEF CLX}
    property Ctl3D;                                                                                 
    property ParentCtl3D;                                                                           
    {$ENDIF}
    property Align;                                                                                 
    property ShowHint;                                                                              
    property Visible;                                                                               
    property Enabled;                                                                               
    property ParentColor Default False;                                                             
    property Color;                                                                                 
    {$IFNDEF CLX}
    property DragCursor;                                                                            
    {$ENDIF}
    property DragMode;                                                                              
    property ParentShowHint;                                                                        
    property PopupMenu;                                                                             

    {$IFDEF D4}
    property Anchors;                                                                               
    {$IFNDEF CLX}  
    property AutoSize;
    property BiDiMode;                                                                              
    {$ENDIF} 
    property Constraints;                                                                           
    {$IFNDEF CLX}
    property UseDockManager default true;                                                           
    property DockSite;                                                                              
    property DragKind;                                                                              
    property ParentBiDiMode;                                                                        
    {$ENDIF}
    {$ENDIF}                                                                                        

    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}

    property OnClick;                                                                                 
    property OnDblClick;                                                                              
    property OnDragDrop;                                                                              
    property OnDragOver;                                                                              
    property OnEndDrag;                                                                               
    property OnMouseDown;                                                                             
    property OnMouseMove;                                                                             
    property OnMouseUp;                                                                               
                                                                                                      
    property OnStartDrag;                                                                             
    property OnEnter;                                                                                 
    property OnExit;                                                                                  
    property OnKeyDown;                                                                               
    property OnKeyPress;                                                                              
    property OnKeyUp;                                                                                 
    property TabOrder;                                                                                
    property TabStop;                                                                                 
    {$IFDEF D4}                                                                                       
    property OnCanResize;                                                                             
    {$IFNDEF CLX}
    property OnConstrainedResize;                                                                     
    {$ENDIF}
    {$IFNDEF CLX}
    property OnDockDrop;                                                                              
    property OnDockOver;                                                                              
    property OnEndDock;                                                                               
    property OnGetSiteInfo;                                                                           
    property OnStartDock;                                                                             
    property OnUnDock;
    {$ENDIF}
    {$ENDIF}                                                                                         
    property OnChange;
    property CodeTemplates;
    property TemplatesType;
    property HideCaret;
    property HighlightUrls;
    property UseGlobalOptions ;//This must be the last property
  end;

procedure Register;

implementation

{------------------------------------------------------------------}
                                                                                                    
procedure ImportRtfLines(Memo : TCustomDCMemo; Source : TCustomDBMemoSource; const s : string);     
var                                                                                                 
  Stream : TStream;                                                                                 
begin                                                                                               
  Stream := TStringStream.Create(s);                                                                
  Source.FInRtfLoad  := true;
  try
    Memo.LoadFromRtfStream(Stream);
  finally
    Source.FInRtfLoad  := false;
    Stream.Free;
  end;                                                                                                 
end;                                                                                                   
                                                                                                       
{------------------------------------------------------------------}                                   
                                                                                                       
function  ExportRtfLines(Memo : TCustomDCMemo) : string;                                               
var                                                                                                    
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Memo.ExportToRtfStream(Stream);
    with Stream do
      SetString(result, Pchar(Memory), Size);
  finally
    Stream.Free;
  end;
end;


{------------------------------------------------------------------}

constructor TCustomDBMemoSource.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FAutoDisplay := true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{------------------------------------------------------------------}

destructor TCustomDBMemoSource.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then
    DataChange(Self);
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FDataLink <> nil) and(AComponent = DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------}

function TCustomDBMemoSource.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

{------------------------------------------------------------------}

function TCustomDBMemoSource.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
end;

{------------------------------------------------------------------}

function TCustomDBMemoSource.GetReadOnly : Boolean;
begin
  Result := not FInRtfLoad  and (inherited GetReadOnly or FDataLink.ReadOnly or {FReadOnly or} not (FDataLink.Editing and FMemoLoaded));
end;

{------------------------------------------------------------------}

function TCustomDBMemoSource.GetField : TField;
begin
  Result := FDataLink.Field;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.SetMemoLines(Text : string);
begin
  FCanEditFlag  := true;
  try
    Lines.Text := Text;
  finally
    FCanEditFlag  := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.LoadMemo;
var
  Memo : TCustomDCMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and (FDataLink.Field is TBlobField) then
  begin
    Memo := GetMemo;
    if (Memo = nil) or Memo.PlainText then
      SetMemoLines(FDataLink.Field.AsString)
    else
      ImportRtfLines(Memo, Self, FDataLink.Field.AsString);
    FMemoLoaded := true;
    EditingChange(Self);
  end;
end;

{------------------------------------------------------------------}

function  TCustomDBMemoSource.CanEdit : boolean;
begin
  result := (FMemoLoaded) and not
  (FCanEditFlag {or FReadOnly} or FDataLink.ReadOnly or ReadOnly);
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.BeforeChange;
begin
  if CanEdit then
  begin
    FCanLoadFlag := true;
    try
      FDataLink.Edit;
    finally
      FCanLoadFlag := false;
    end;
  end;
end;

{------------------------------------------------------------------}

function  TCustomDBMemoSource.GetMemo : TCustomDCMemo;
begin
  result := GetConnectedMemo(Self);
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.AfterChange;
begin
  if CanEdit then
  begin
    FDataLink.Modified;
    FMemoLoaded := True;
  end
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.BreakLine;
begin
  if FInRtfLoad or FMemoLoaded then
  begin
    BeforeChange;
    inherited;
    AfterChange;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.JoinLines;
begin
  if FInRtfLoad or FMemoLoaded then
  begin
    BeforeChange;
    inherited;
    AfterChange;
  end;
end;

{------------------------------------------------------------------}

function TCustomDBMemoSource.Insert(const S : string) : boolean;
var
  Key : char;

  procedure _Change;
  begin
    BeforeChange;
    result := inherited Insert(S);
    AfterChange;
  end;

begin
  result := false;
  if FInRtfLoad or (length(S) <> 1) then
  begin
    _Change;
    exit;
  end;
  Key := S[1];
  if FMemoLoaded then
  begin
    if (FDataLink.Field <> nil) and  not FDataLink.Field.IsValidChar(Key) then
      MessageBeep(0)
    else
    if Key  in [#9 , #32..#255] then
      _Change;
  end
  else
  if Key = #13 then
    LoadMemo;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.DeleteRight(Number:Integer);
begin
  if FInRtfLoad or FMemoLoaded then
  begin
    BeforeChange;
    inherited;
    AfterChange;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.PressEnter;
begin
  if FMemoLoaded then
    inherited
  else
    LoadMemo;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.ProcessEscape;
begin
  inherited;
  if Modified then
    FDataLink.Reset;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.CheckMemo(Value : boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not (FDataLink.Field is TBlobField) then
      FDataLink.Reset;
  end;
end;

{------------------------------------------------------------------}

function TCustomDBMemoSource.MemoNotify(Sender : TObject; var Msg : TMessage) : boolean;
begin
  case Msg.Msg of
    CM_ENTER :
       CheckMemo(true);
    CM_EXIT :
    begin
      FDataLink.UpdateRecord;
      CheckMemo(false);
    end;
    WM_LBUTTONDBLCLK:
    if  not FMemoLoaded then
      begin
        LoadMemo;
        result := false;
        exit;
      end;
  end;
  result := inherited MemoNotify(Sender, Msg);
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.SelAttributesUpdated;
begin
  if FMemoLoaded and not FInRtfLoad then
  begin
    BeforeChange;
    AfterChange;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.DoLoadFromFile(const AFileName : string);
begin
  if CanEdit then
  begin
    BeforeChange;
    inherited;
    Modified := true;
    AfterChange;
  end;
end;


{------------------------------------------------------------------}

procedure TCustomDBMemoSource.DataChange(Sender : TObject);
begin
  if FCanLoadFlag then
    exit;
  if FDataLink.Field <> nil then
    if FDataLink.Field is (TBlobField) then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        FMemoLoaded := false;
        LoadMemo;
      end
      else
      begin
        SetMemoLines(Format('(%s)', [FDataLink.Field.DisplayLabel])); //don't resource
        FMemoLoaded := false;
      end;
    end
    else
    begin
      if FFocused and FDataLink.CanModify then
        SetMemoLines(FDataLink.Field.Text)
      else
        SetMemoLines(FDataLink.Field.DisplayText);
      FMemoLoaded := true;
    end
  else
  begin
    if csDesigning in ComponentState then
      SetMemoLines(Name)
    else
      SetMemoLines('');
    FMemoLoaded := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.UpdateData(Sender: TObject);
var
  Memo : TCustomDCMemo;
begin
  if (Modified) and  Assigned(FDataLink.DataSet) and (FDataLink.DataSet.State in [dsInsert, dsEdit]) then
  begin
    Memo := GetMemo;
    if (Memo = nil) or Memo.PlainText then
      FDataLink.Field.AsString := Lines.Text
    else
      FDataLink.Field.AsString := ExportRtfLines(Memo);
    Modified := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.SetAutoDisplay(Value : boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then
      LoadMemo;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDBMemoSource.CMGetDataLink(var Message : TMessage);
begin
  Message.Result := integer(FDataLink);
end;

{-------------TCustomDCDBMemo-----------------------------------------}

function TCustomDCDBMemo.CreateDefaultMemoSource : TCustomMemoSource;
begin
  result := TDBMemoSource.Create(nil);
  TDBMemoSource(result).OnNavigate := GetNavigation;
end;

{------------------------------------------------------------------}

function TCustomDCDBMemo.GetAutoDisplay : boolean;
begin
  result := TDBMemoSource(GetSource).AutoDisplay;
end;

{------------------------------------------------------------------}

procedure TCustomDCDBMemo.SetAutoDisplay(Value : boolean);
begin
  TDBMemoSource(GetSource).AutoDisplay := Value;
end;

{------------------------------------------------------------------}

function TCustomDCDBMemo.GetDataField : string;
begin
  result := TDBMemoSource(GetSource).DataField;
end;

{------------------------------------------------------------------}

procedure TCustomDCDBMemo.SetDataField(Value : string);
begin
  TDBMemoSource(GetSource).DataField := Value;
end;

{------------------------------------------------------------------}

function TCustomDCDBMemo.GetDataSource : TDataSource;
begin
  result := TDBMemoSource(GetSource).DataSource;
end;

{------------------------------------------------------------------}

procedure TCustomDCDBMemo.SetDataSource(Value : TDataSource);
begin
  TDBMemoSource(GetSource).DataSource := Value;
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamMemo, [TDCDBMemo, TDBMemoSource]);
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin

end;

{------------------------------------------------------------------}

initialization
  RunRegister;
end.
