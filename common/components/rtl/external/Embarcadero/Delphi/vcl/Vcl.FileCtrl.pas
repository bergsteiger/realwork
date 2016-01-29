{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.FileCtrl platform;

{$R-,T-,H+,X+}

interface

uses 
{$IF DEFINED(CLR)}
  System.Security.Permissions,
{$ENDIF}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics,
  Vcl.Forms, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons;


type
  TFileAttr = (ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory,
    ftArchive, ftNormal);
  TFileType = set of TFileAttr;

  TDriveType = (dtUnknown, dtNoDrive, dtFloppy, dtFixed, dtNetwork, dtCDROM,
    dtRAM);

  TDirectoryListBox = class;
  TFilterComboBox = class;
  TDriveComboBox = class;

{ TFileListBox }

  [SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
  TFileListBox = class(TCustomListBox)
  private
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    function GetDirectory: string;
    function GetDrive: char;
    function GetFileName: string;
    function IsMaskStored: Boolean;
    procedure SetDrive(Value: char);
    procedure SetFileEdit(Value: TEdit);
    procedure SetDirectory(const NewDirectory: string);
    procedure SetFileType(NewFileType: TFileType);
    procedure SetMask(const NewMask: string);
    procedure SetFileName(const NewFile: string);
    procedure SetShowGlyphs (Value: Boolean);
    procedure ResetItemHeight;
  protected
    FDirectory: string;
    FMask: string;
    FFileType: TFileType;
    FFileEdit: TEdit;
    FDirList: TDirectoryListBox;
    FFilterCombo: TFilterComboBox;
    ExeBMP, DirBMP, UnknownBMP: TBitmap;
    FOnChange: TNotifyEvent;
    FLastSel: Integer;
    FShowGlyphs: Boolean;
    procedure CreateWnd; override;
    procedure ReadBitmaps; virtual;
    procedure Click; override;
    procedure Change; virtual;
    procedure ReadFileNames; virtual;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);  override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetFilePath: string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; reintroduce;
    procedure ApplyFilePath (const EditText: string); virtual;
    property Drive: char read GetDrive write SetDrive;
    property Directory: string read GetDirectory write ApplyFilePath;
    property FileName: string read GetFilePath write ApplyFilePath;
  published
    property Align;
    property Anchors;
    property AutoComplete;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property FileEdit: TEdit read FFileEdit write SetFileEdit;
    property FileType: TFileType read FFileType write SetFileType default [ftNormal];
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Mask: string read FMask write SetMask stored IsMaskStored;
    property MultiSelect;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowGlyphs: Boolean read FShowGlyphs write SetShowGlyphs default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{ TDirectoryListBox }

  [SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
  TDirectoryListBox = class(TCustomListBox)
  private
    FFileList: TFileListBox;
    FDriveCombo: TDriveComboBox;
    FDirLabel: TLabel;
    FInSetDir: Boolean;
    FPreserveCase: Boolean;
    FCaseSensitive: Boolean;
    function GetDirectory: string;
    function GetDrive: char;
    procedure SetFileListBox(Value: TFileListBox);
    procedure SetDirLabel(Value: TLabel);
    procedure SetDirLabelCaption;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetDrive(Value: char);
    procedure DriveChange(NewDrive: Char);
    procedure SetDir(const NewDirectory: string);
    procedure SetDirectory(const NewDirectory: string); virtual;
    procedure ResetItemHeight;
  protected
    ClosedBMP, OpenedBMP, CurrentBMP: TBitmap;
    FDirectory: string;
    FOnChange: TNotifyEvent;
    procedure Change; virtual;
    procedure DblClick; override;
    procedure ReadBitmaps; virtual;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    function  ReadDirectoryNames(const ParentDirectory: string;
      DirectoryList: TStringList): Integer;
    procedure BuildList; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  DisplayCase(const S: String): String;
    function  FileCompareText(const A, B: String): Integer;
    function GetItemPath(Index: Integer): string;
    procedure OpenCurrent;
    procedure Update; reintroduce;
    property Drive: Char read GetDrive write SetDrive;
    property Directory: string read GetDirectory write SetDirectory;
    property PreserveCase: Boolean read FPreserveCase;
    property CaseSensitive: Boolean read FCaseSensitive;
  published
    property Align;
    property Anchors;
    property AutoComplete;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DirLabel: TLabel read FDirLabel write SetDirLabel;
    property DoubleBuffered;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FileList: TFileListBox read FFileList write SetFileListBox;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

{ TDriveComboBox }

  TTextCase = (tcLowerCase, tcUpperCase);

  [SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
  TDriveComboBox = class(TCustomComboBox)
  private
    FDirList: TDirectoryListBox;
    FDrive: Char;
    FTextCase: TTextCase;
    function GetDrive: Char;
    procedure SetDirListBox (Value: TDirectoryListBox);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetDrive(NewDrive: Char);
    procedure SetTextCase(NewTextCase: TTextCase);
    procedure ReadBitmaps;
    procedure ResetItemHeight;
  protected
    FloppyBMP, FixedBMP, NetworkBMP, CDROMBMP, RAMBMP: TBitmap;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure Click; override;
    procedure BuildList; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text;
    property Drive: Char read GetDrive write SetDrive;
  published
    property Align;
    property Anchors;
    property AutoComplete;
    property AutoDropDown;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property Color;
    property Constraints;
    property Ctl3D;
    property DirList: TDirectoryListBox read FDirList write SetDirListBox;
    property DoubleBuffered;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TextCase: TTextCase read FTextCase write SetTextCase default tcLowerCase;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDrag;
  end;

{ TFilterComboBox }

  [SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
  TFilterComboBox = class(TCustomComboBox)
  private
    FFilter: string;
    FFileList: TFileListBox;
    MaskList: TStringList;
    function IsFilterStored: Boolean;
    function GetMask: string;
    procedure SetFilter(const NewFilter: string);
    procedure SetFileListBox (Value: TFileListBox);
  protected
    procedure Change; override;
    procedure CreateWnd; override;
    procedure Click; override;
    procedure BuildList;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Mask: string read GetMask;
    property Text;
  published
    property Align;
    property Anchors;
    property AutoComplete;
    property AutoDropDown;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragMode;
    property DragCursor;
    property Enabled;
    property FileList: TFileListBox read FFileList write SetFileListBox;
    property Filter: string read FFilter write SetFilter stored IsFilterStored;
    property Font;
    property ImeName;
    property ImeMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDrag;
  end;

procedure ProcessPath (const EditText: string; var Drive: Char;
  var DirPart: string; var FilePart: string);

function MinimizeName(const Filename: TFileName; Canvas: TCanvas;
  MaxLen: Integer): TFileName;

const
  WNTYPE_DRIVE = 1;  { from WINNET.H, WFW 3.1 SDK }

type
  TSelectDirOpt = (sdAllowCreate, sdPerformCreate, sdPrompt);
  TSelectDirOpts = set of TSelectDirOpt;

  TSelectDirExtOpt = (sdNewFolder, sdShowEdit, sdShowShares, sdNewUI, sdShowFiles,
    sdValidateDir);
  TSelectDirExtOpts = set of TSelectDirExtOpt;

function SelectDirectory(var Directory: string;
  Options: TSelectDirOpts; HelpCtx: Longint): Boolean; overload;
function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Options: TSelectDirExtOpts = [sdNewUI]; Parent: TWinControl = nil): Boolean; overload;
function DirectoryExists(const Name: string): Boolean; deprecated 'Use SysUtils.DirectoryExists instead';
{$EXTERNALSYM DirectoryExists}
function ForceDirectories(const Dir: string): Boolean; deprecated 'Use SysUtils.ForceDirectories instead';
{$EXTERNALSYM ForceDirectories}

implementation

uses 
{$IF DEFINED(CLR)}
  System.Text, System.Runtime.InteropServices, System.Reflection.Emit,
  System.Reflection, System.Threading, System.IO, 
  Types, WinUtils, StrUtils,
{$ENDIF}
  System.Types, System.UITypes, Vcl.Consts, System.RTLConsts, Vcl.Dialogs, Winapi.ShlObj, Winapi.ActiveX;

{$IF DEFINED(CLR)}

{$R Borland.Vcl.FileCtrl.resources}

const
  ResouceBaseName = 'Borland.Vcl.FileCtrl';

{$ELSE}

{$R FileCtrl.res}

{$ENDIF}

type

  TPathLabel = class(TCustomLabel)
  protected
    procedure Paint; override;
  public
    constructor Create(AnOwner: TComponent); override;
  published
    property Alignment;
    property Transparent;
  end;

  TWNetConnectDialog = function (WndParent: HWND; IType: Longint): Longint;

{ TSelectDirDlg }

  TSelectDirDlg = class(TForm)
    DirList: TDirectoryListBox;
    DirEdit: TEdit;
    DriveList: TDriveComboBox;
    DirLabel: TPathLabel;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    NetButton: TButton;
    FileList: TFileListBox;
    procedure DirListChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DriveListChange(Sender: TObject);
    procedure NetClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    { Private declarations }
    FAllowCreate: Boolean;
    FPrompt: Boolean;
    WNetConnectDialog: TWNetConnectDialog;
    procedure SetAllowCreate(Value: Boolean);
    procedure SetDirectory(const Value: string);
    function GetDirectory: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Directory: string read GetDirectory write SetDirectory;
    property AllowCreate: Boolean read FAllowCreate write SetAllowCreate default False;
    property Prompt: Boolean read FPrompt write FPrompt default False;
  end;

function SlashSep(const Path, S: String): String;
begin
{$IF DEFINED(CLR)}
  if Path[Length(Path)] <> '\' then
{$ELSE}
  if AnsiLastChar(Path)^ <> '\' then
{$ENDIF}
    Result := Path + '\' + S
  else
    Result := Path + S;
end;

{ TPathLabel }

constructor TPathLabel.Create(AnOwner: TComponent);
begin
  inherited Create(AnOwner);
  WordWrap := False;
  AutoSize := False;
  ShowAccelChar := False;
end;

procedure TPathLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  Temp: String;
begin
  with Canvas do
  begin
    Rect := ClientRect;
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(Rect);
    end;
    Brush.Style := bsClear;
    Temp := MinimizeName(Caption, Canvas, Rect.Right - Rect.Left);
    DrawText(Canvas.Handle, Temp, Length(Temp), Rect,
      DT_NOPREFIX or Alignments[Alignment]);
  end;
end;

{ TDriveComboBox }

procedure CutFirstDirectory(var S: TFileName);
var
  Root: Boolean;
  P: Integer;
begin
  if S = '\' then
    S := ''
  else
  begin
    if S[1] = '\' then
    begin
      Root := True;
      Delete(S, 1, 1);
    end
    else
      Root := False;
    if S[1] = '.' then
      Delete(S, 1, 4);
    P := AnsiPos('\',S);
    if P <> 0 then
    begin
      Delete(S, 1, P);
      S := '...\' + S;
    end
    else
      S := '';
    if Root then
      S := '\' + S;
  end;
end;

function MinimizeName(const Filename: TFileName; Canvas: TCanvas;
  MaxLen: Integer): TFileName;
var
  Drive: TFileName;
  Dir: TFileName;
  Name: TFileName;
begin
  Result := FileName;
  Dir := ExtractFilePath(Result);
  Name := ExtractFileName(Result);

  if (Length(Dir) >= 2) and (Dir[2] = ':') then
  begin
    Drive := Copy(Dir, 1, 2);
    Delete(Dir, 1, 2);
  end
  else
    Drive := '';
  while ((Dir <> '') or (Drive <> '')) and (Canvas.TextWidth(Result) > MaxLen) do
  begin
    if Dir = '\...\' then
    begin
      Drive := '';
      Dir := '...\';
    end
    else if Dir = '' then
      Drive := ''
    else
      CutFirstDirectory(Dir);
    Result := Drive + Dir + Name;
  end;
end;

function VolumeID(DriveChar: Char): string;
var
  OldErrorMode: Integer;
  NotUsed, VolFlags: DWORD;
{$IF DEFINED(CLR)}
  Buf: StringBuilder;
{$ELSE}
  Buf: array [0..MAX_PATH] of Char;
{$ENDIF}
begin
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
{$IF DEFINED(CLR)}
    Buf := StringBuilder.Create(MAX_PATH);
    if GetVolumeInformation(DriveChar + ':\', Buf, DWORD(Buf.Capacity),
      nil, NotUsed, VolFlags, nil, 0) then
      Result := Buf.ToString
{$ELSE}
    Buf[0] := #$00;
    if GetVolumeInformation(PChar(DriveChar + ':\'), Buf, DWORD(Length(Buf)),
      nil, NotUsed, VolFlags, nil, 0) then
      SetString(Result, Buf, StrLen(Buf))
{$ENDIF}
    else Result := '';
    if DriveChar < 'a' then
      Result := AnsiUpperCaseFileName(Result)
    else
      Result := AnsiLowerCaseFileName(Result);
    Result := Format('[%s]',[Result]);
  finally
    SetErrorMode(OldErrorMode);
  end;
end;

function NetworkVolume(DriveChar: Char): string;
var
  BufferSize: DWORD;
  ErrorCode: DWORD;
{$IF DEFINED(CLR)}
  Buf, NewBuf: StringBuilder;
  DriveStr: string;
{$ELSE}
  Buf: Array [0..MAX_PATH] of Char;
  DriveStr: array [0..3] of Char;
  NewBuf: PChar;
{$ENDIF}
begin
{$IF DEFINED(CLR)}
  Buf := StringBuilder.Create(MAX_PATH);
  BufferSize := Buf.Capacity;
  SetLength(DriveStr, 3);
  DriveStr[1] := UpCase(DriveChar);
  DriveStr[2] := ':';
  DriveStr[3] := #0;
{$ELSE}
  BufferSize := Length(Buf);
  DriveStr[0] := UpCase(DriveChar);
  DriveStr[1] := ':';
  DriveStr[2] := #0;
{$ENDIF}

  NewBuf := Buf;
  ErrorCode := WNetGetConnection(DriveStr, NewBuf, BufferSize);
  if ErrorCode = ERROR_MORE_DATA then// need to enlarge buffer
  begin
    {$IFDEF CLR}
    NewBuf.Length := BufferSize;
    NewBuf := Buf;
    {$ELSE}
    SetLength(Result, BufferSize);
    NewBuf := PChar(Result);
    {$ENDIF}

    ErrorCode := WNetGetConnection(DriveStr, NewBuf, BufferSize);
  end;

  if ErrorCode = WN_SUCCESS then // volume name has been returned successfully
  begin
{$IF DEFINED(CLR)}
    Result := NewBuf.ToString;
{$ELSE}
    SetString(Result, NewBuf, BufferSize);
{$ENDIF}

    if DriveChar < 'a' then
      Result := AnsiUpperCaseFileName(Result)
    else
      Result := AnsiLowerCaseFileName(Result);
  end
  else
    Result := VolumeID(DriveChar);
end;

procedure ProcessPath (const EditText: string; var Drive: Char;
  var DirPart: string; var FilePart: string);
var
  SaveDir, Root: string;
begin
  GetDir(0, SaveDir);
  Drive := SaveDir[1];
  DirPart := EditText;
{$IF DEFINED(CLR)}
  if (DirPart[1] = '[') and (DirPart[Length(DirPart)] = ']') then
{$ELSE}
  if (DirPart[1] = '[') and (AnsiLastChar(DirPart)^ = ']') then
{$ENDIF}
    DirPart := Copy(DirPart, 2, Length(DirPart) - 2)
  else
  begin
    Root := ExtractFileDrive(DirPart);
    if Length(Root) = 0 then
      Root := ExtractFileDrive(SaveDir)
    else
      Delete(DirPart, 1, Length(Root));
    if (Length(Root) >= 2) and (Root[2] = ':') then
      Drive := Root[1]
    else
      Drive := #0;
  end;

  try
    if DirectoryExists(Root) then
      ChDir(Root);
    FilePart := ExtractFileName (DirPart);
    if Length(DirPart) = (Length(FilePart) + 1) then
      DirPart := '\'
    else if Length(DirPart) > Length(FilePart) then
      SetLength(DirPart, Length(DirPart) - Length(FilePart) - 1)
    else
    begin
      GetDir(0, DirPart);
      Delete(DirPart, 1, Length(ExtractFileDrive(DirPart)));
      if Length(DirPart) = 0 then
        DirPart := '\';
    end;
    if Length(DirPart) > 0 then
      ChDir (DirPart);  {first go to our new directory}
    if (Length(FilePart) > 0) and not
       (((Pos('*', FilePart) > 0) or (Pos('?', FilePart) > 0)) or
       FileExists(FilePart)) then
    begin
      ChDir(FilePart);
      if Length(DirPart) = 1 then
        DirPart := '\' + FilePart
      else
        DirPart := DirPart + '\' + FilePart;
      FilePart := '';
    end;
    if Drive = #0 then
      DirPart := Root + DirPart;
  finally
    if DirectoryExists(SaveDir) then
      ChDir(SaveDir);  { restore original directory }
  end;
end;

function GetItemHeight(Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

{ TDriveComboBox }

constructor TDriveComboBox.Create(AOwner: TComponent);
var
  Temp: string;
begin
  inherited Create(AOwner);
  Style := csOwnerDrawFixed;
  ReadBitmaps;
  GetDir(0, Temp);
  FDrive := Temp[1]; { make default drive selected }
  if FDrive = '\' then FDrive := #0;
  ResetItemHeight;
end;

destructor TDriveComboBox.Destroy;
begin
  FloppyBMP.Free;
  FixedBMP.Free;
  NetworkBMP.Free;
  CDROMBMP.Free;
  RAMBMP.Free;
  inherited Destroy;
end;

procedure TDriveComboBox.BuildList;
var
  DriveNum: Integer;
  DriveChar: Char;
  DriveType: TDriveType;
{$IF DEFINED(CLR)}
  DriveBits: DWORD;
  DriveMask: DWORD;
{$ELSE}
  DriveBits: set of 0..25;
{$ENDIF}

  procedure AddDrive(const VolName: string; Obj: TObject);
  begin
    Items.AddObject(Format('%s: %s',[DriveChar, VolName]), Obj);
  end;

begin
  { fill list }
  Clear;
{$IF DEFINED(CLR)}
  DriveBits := GetLogicalDrives;
  DriveMask := 1;
{$ELSE}
  Integer(DriveBits) := GetLogicalDrives;
{$ENDIF}
  for DriveNum := 0 to 25 do
  begin
{$IF DEFINED(CLR)}
    if (DriveMask and DriveBits) = 0 then
    begin
      DriveMask := DriveMask shl 1;
      Continue;
    end;
    DriveMask := DriveMask shl 1;
    DriveChar := Char(DriveNum + Ord('a'));
    DriveType := TDriveType(GetDriveType(DriveChar + ':\')); 
{$ELSE}
    if not (DriveNum in DriveBits) then Continue;
    DriveChar := Char(DriveNum + Ord('a'));
    DriveType := TDriveType(GetDriveType(PChar(DriveChar + ':\')));
{$ENDIF}
    if TextCase = tcUpperCase then
      DriveChar := Upcase(DriveChar);

    case DriveType of
      dtFloppy:   Items.AddObject(DriveChar + ':', FloppyBMP);
      dtFixed:    AddDrive(VolumeID(DriveChar), FixedBMP);
      dtNetwork:  AddDrive(NetworkVolume(DriveChar), NetworkBMP);
      dtCDROM:    AddDrive(VolumeID(DriveChar), CDROMBMP);
      dtRAM:      AddDrive(VolumeID(DriveChar), RAMBMP);
    end;
  end;
end;

function TDriveComboBox.GetDrive: Char;
begin
  Result := FDrive;
end;

procedure TDriveComboBox.SetDrive(NewDrive: Char);
var
  Item: Integer;
  drv: string;
begin
  if (ItemIndex < 0) or (UpCase(NewDrive) <> UpCase(FDrive)) then
  begin
    if NewDrive = #0 then
    begin
      FDrive := NewDrive;
      ItemIndex := -1;
    end
    else
    begin
      if TextCase = tcUpperCase then
        FDrive := UpCase(NewDrive)
      else
        FDrive := Chr(ord(UpCase(NewDrive)) + 32);

      { change selected item }
      for Item := 0 to Items.Count - 1 do
      begin
        drv := Items[Item];
        if (UpCase(drv[1]) = UpCase(FDrive)) and (drv[2] = ':') then
        begin
          ItemIndex := Item;
          break;
        end;
      end;
    end;
    if FDirList <> nil then FDirList.DriveChange(Drive);
    Change;
  end;
end;

procedure TDriveComboBox.SetTextCase(NewTextCase: TTextCase);
var
  OldDrive: Char;
begin
  FTextCase := NewTextCase;
  OldDrive := FDrive;
  BuildList;
  SetDrive (OldDrive);
end;

procedure TDriveComboBox.SetDirListBox (Value: TDirectoryListBox);
begin
  if FDirList <> nil then FDirList.FDriveCombo := nil;
  FDirList := Value;
  if FDirList <> nil then
  begin
    FDirList.FDriveCombo := Self;
    FDirList.FreeNotification(Self);
  end;
end;

procedure TDriveComboBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
  SetDrive (FDrive);
end;

procedure TDriveComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  bmpWidth: Integer;
begin
  with Canvas do
  begin
    FillRect(Rect);
    bmpWidth  := 16;
    Bitmap := TBitmap(Items.Objects[Index]);
    if Bitmap <> nil then
    begin
      bmpWidth := Bitmap.Width;
      BrushCopy(Bounds(Rect.Left + 2,
               (Rect.Top + Rect.Bottom - Bitmap.Height) div 2,
               Bitmap.Width, Bitmap.Height),
               Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
               Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
    end;
     { uses DrawText instead of TextOut in order to get clipping against
       the combo box button   }
    Rect.Left := Rect.Left + bmpWidth + 6;
    DrawText(Canvas.Handle, Items[Index], -1, Rect,
             DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
  end;
end;

procedure TDriveComboBox.Click;
begin
  inherited Click;
  if ItemIndex >= 0 then
    Drive := Items[ItemIndex][1];
end;

procedure TDriveComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

procedure TDriveComboBox.ResetItemHeight;
var
  nuHeight: Integer;
begin
  nuHeight :=  GetItemHeight(Font);
  if nuHeight < (FloppyBMP.Height) then nuHeight := FloppyBmp.Height;
  ItemHeight := nuHeight;
end;

procedure TDriveComboBox.ReadBitmaps;
{$IF DEFINED(CLR)}
var
  BaseAssembly: System.Reflection.Assembly;
{$ENDIF}
begin
  { assign bitmap glyphs }
  FloppyBMP := TBitmap.Create;
  FixedBMP := TBitmap.Create;
  NetworkBMP := TBitmap.Create;
  CDROMBMP := TBitmap.Create;
  RAMBMP := TBitmap.Create;
{$IF DEFINED(CLR)}
  BaseAssembly := Assembly.GetExecutingAssembly;
  FloppyBMP.LoadFromResourceName('FLOPPY', ResouceBaseName, BaseAssembly); { Do not localize }
  FixedBMP.LoadFromResourceName('HARD', ResouceBaseName, BaseAssembly); { Do not localize }
  NetworkBMP.LoadFromResourceName('NETWORK', ResouceBaseName, BaseAssembly); { Do not localize }
  CDROMBMP.LoadFromResourceName('CDROM', ResouceBaseName, BaseAssembly); { Do not localize }
  RAMBMP.LoadFromResourceName('RAM', ResouceBaseName, BaseAssembly); { Do not localize }
{$ELSE}
  FloppyBMP.Handle := LoadBitmap(HInstance, 'FLOPPY');
  FixedBMP.Handle := LoadBitmap(HInstance, 'HARD');
  NetworkBMP.Handle := LoadBitmap(HInstance, 'NETWORK');
  CDROMBMP.Handle := LoadBitmap(HInstance, 'CDROM');
  RAMBMP.Handle := LoadBitmap(HInstance, 'RAM');
{$ENDIF}
end;

procedure TDriveComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDirList) then
    FDirList := nil;
end;

{ TDirectoryListBox }

function DirLevel(const PathName: string): Integer;  { counts '\' in path }
{$IF DEFINED(CLR)}
var
  CurPos, PathLen : Integer;
begin
  Result := 0;
  PathLen := Length(PathName);
  CurPos := Pos('\', PathName) - 1;
  while CurPos >= 0 do
  begin
    Inc(Result);
    if CurPos < PathLen - 1 then
      CurPos := PosEx('\', PathName, CurPos + 2) - 1
    else
      CurPos := -1;
  end;
{$ELSE}
var
  P: PChar;
begin
  Result := 0;
  P := AnsiStrScan(PChar(PathName), '\');
  while P <> nil do
  begin
    Inc(Result);
    Inc(P);
    P := AnsiStrScan(P, '\');
  end;
{$ENDIF}
end;

constructor TDirectoryListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 145;
  Style := lbOwnerDrawFixed;
  Sorted := False;
  ReadBitmaps;
  GetDir(0, FDirectory); { initially use current dir on default drive }
  ResetItemHeight;
end;

destructor TDirectoryListBox.Destroy;
begin
  FreeAndNil(ClosedBMP);
  FreeAndNil(OpenedBMP);
  FreeAndNil(CurrentBMP);
  inherited Destroy;
end;

procedure TDirectoryListBox.DriveChange(NewDrive: Char);
begin
  if (UpCase(NewDrive) <> UpCase(Drive)) then
  begin
    if NewDrive <> #0 then
    begin
      ChDir(NewDrive + ':');
      GetDir(0, FDirectory);  { store correct directory name }
    end;
    if not FInSetDir then
    begin
      BuildList;
      Change;
    end;
  end;
end;

procedure TDirectoryListBox.SetFileListBox (Value: TFileListBox);
begin
  if FFileList <> nil then FFileList.FDirList := nil;
  FFileList := Value;
  if FFileList <> nil then
  begin
    FFileList.FDirList := Self;
    FFileList.FreeNotification(Self);
  end;
end;

procedure TDirectoryListBox.SetDirLabel (Value: TLabel);
begin
  FDirLabel := Value;
  if Value <> nil then Value.FreeNotification(Self);
  SetDirLabelCaption;
end;

procedure TDirectoryListBox.SetDir(const NewDirectory: string);
begin
     { go to old directory first, in case of incomplete pathname
       and curdir changed - probably not necessary }
  if DirectoryExists(FDirectory) then
    ChDir(FDirectory);
  ChDir(NewDirectory);     { exception raised if invalid dir }
  GetDir(0, FDirectory);   { store correct directory name }
  BuildList;
  Change;
end;

procedure TDirectoryListBox.OpenCurrent;
begin
  Directory := GetItemPath(ItemIndex);
end;

procedure TDirectoryListBox.Update;
begin
  BuildList;
  Change;
end;

function TDirectoryListBox.DisplayCase(const S: String): String;
begin
  if FPreserveCase or FCaseSensitive then
    Result := S
  else
    Result := AnsiLowerCase(S);
end;

function TDirectoryListBox.FileCompareText(const A,B: String): Integer;
begin
  if FCaseSensitive then
    Result := AnsiCompareStr(A,B)
  else
    Result := AnsiCompareFileName(A,B);
end;

  {
    Reads all directories in ParentDirectory, adds their paths to
    DirectoryList,and returns the number added
  }
function TDirectoryListbox.ReadDirectoryNames(const ParentDirectory: string;
  DirectoryList: TStringList): Integer;
var
  Status: Integer;
  SearchRec: TSearchRec;
begin
  Result := 0;
  Status := FindFirst(SlashSep(ParentDirectory, '*.*'), faDirectory, SearchRec);
  try
    while Status = 0 do
    begin
      if (SearchRec.Attr and faDirectory = faDirectory) then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          DirectoryList.Add(SearchRec.Name);
          Inc(Result);
        end;
      end;
      Status := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
end;

procedure TDirectoryListBox.BuildList;
var
  TempPath: string;
  DirName: string;
  IndentLevel, BackSlashPos: Integer;
  VolFlags, Len: DWORD;
  I: Integer;
  Siblings: TStringList;
  NewSelect: Integer;
  Root: string;
begin
  try
    Items.BeginUpdate;
    Items.Clear;
    IndentLevel := 0;
    Root := ExtractFileDrive(Directory)+'\';
{$IF DEFINED(CLR)}
    GetVolumeInformation(Root, nil, 0, nil, Len, VolFlags, nil, 0);
{$ELSE}
    GetVolumeInformation(PChar(Root), nil, 0, nil, Len, VolFlags, nil, 0);
{$ENDIF}
    FPreserveCase := VolFlags and (FS_CASE_IS_PRESERVED or FS_CASE_SENSITIVE) <> 0;
    FCaseSensitive := (VolFlags and FS_CASE_SENSITIVE) <> 0;
    if (Length(Root) >= 2) and (Root[2] = '\') then
    begin
      Items.AddObject(Root, OpenedBMP);
      Inc(IndentLevel);
      TempPath := Copy(Directory, Length(Root)+1, Length(Directory));
    end
    else
      TempPath := Directory;
    if (Length(TempPath) > 0) then
    begin
{$IF DEFINED(CLR)}
      if TempPath[Length(TempPath)] <> '\' then
{$ELSE}
      if AnsiLastChar(TempPath)^ <> '\' then
{$ENDIF}
      begin
        BackSlashPos := AnsiPos('\', TempPath);
        while BackSlashPos <> 0 do
        begin
          DirName := Copy(TempPath, 1, BackSlashPos - 1);
          if IndentLevel = 0 then DirName := DirName + '\';
          Delete(TempPath, 1, BackSlashPos);
          Items.AddObject(DirName, OpenedBMP);
          Inc(IndentLevel);
          BackSlashPos := AnsiPos('\', TempPath);
        end;
      end;
      Items.AddObject(TempPath, CurrentBMP);
    end;
    NewSelect := Items.Count - 1;
    Siblings := TStringList.Create;
    try
      Siblings.Sorted := True;
        { read all the dir names into Siblings }
      ReadDirectoryNames(Directory, Siblings);
      for I := 0 to Siblings.Count - 1 do
        Items.AddObject(Siblings[I], ClosedBMP);
    finally
      Siblings.Free;
    end;
  finally
    Items.EndUpdate;
  end;
  if HandleAllocated then
    ItemIndex := NewSelect;
end;

procedure TDirectoryListBox.ReadBitmaps;
{$IF DEFINED(CLR)}
var
  BaseAssembly: System.Reflection.Assembly;
{$ENDIF}
begin
  OpenedBMP := TBitmap.Create;
  ClosedBMP := TBitmap.Create;
  CurrentBMP := TBitmap.Create;
{$IF DEFINED(CLR)}
  BaseAssembly := Assembly.GetExecutingAssembly;
  OpenedBMP.LoadFromResourceName('OPENFOLDER', ResouceBaseName, BaseAssembly); { Do not localize }
  ClosedBMP.LoadFromResourceName('CLOSEDFOLDER', ResouceBaseName, BaseAssembly); { Do not localize }
  CurrentBMP.LoadFromResourceName('CURRENTFOLDER', ResouceBaseName, BaseAssembly); { Do not localize }
{$ELSE}
  OpenedBMP.LoadFromResourceName(HInstance, 'OPENFOLDER');
  ClosedBMP.LoadFromResourceName(HInstance, 'CLOSEDFOLDER');
  CurrentBMP.LoadFromResourceName(HInstance, 'CURRENTFOLDER');
{$ENDIF}
end;

procedure TDirectoryListBox.DblClick;
begin
  inherited DblClick;
  OpenCurrent;
end;

procedure TDirectoryListBox.Change;
begin
  if FFileList <> nil then FFileList.SetDirectory(Directory);
  SetDirLabelCaption;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TDirectoryListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  bmpWidth: Integer;
  dirOffset: Integer;
begin
  with Canvas do
  begin
    FillRect(Rect);
    bmpWidth  := 16;
    dirOffset := Index * 4 + 2;    {add 2 for spacing}

    Bitmap := TBitmap(Items.Objects[Index]);
    if Bitmap <> nil then
    begin
      if Bitmap = ClosedBMP then
        dirOffset := (DirLevel (Directory) + 1) * 4 + 2;

      bmpWidth := Bitmap.Width;
      BrushCopy(Bounds(Rect.Left + dirOffset,
               (Rect.Top + Rect.Bottom - Bitmap.Height) div 2,
               Bitmap.Width, Bitmap.Height),
               Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
               Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
    end;
    TextOut(Rect.Left + bmpWidth + dirOffset + 4, Rect.Top, DisplayCase(Items[Index]))
  end;
end;

function TDirectoryListBox.GetItemPath (Index: Integer): string;
var
  CurDir: string;
  i, j: Integer;
  Bitmap: TBitmap;
begin
  Result := '';
  if Index < Items.Count then
  begin
    CurDir := Directory;
    Bitmap := TBitmap(Items.Objects[Index]);
    if Index = 0 then
      Result := ExtractFileDrive(CurDir)+'\'
    else if Bitmap = ClosedBMP then
      Result := SlashSep(CurDir,Items[Index])
    else if Bitmap = CurrentBMP then
      Result := CurDir
    else
    begin
      i   := 0;
      j   := 0;
      Delete(CurDir, 1, Length(ExtractFileDrive(CurDir)));
      while j <> (Index + 1) do
      begin
        Inc(i);
        if i > Length (CurDir) then
{$IF DEFINED(CLR)}
          break
{$ELSE}
          break;
        if IsLeadChar(CurDir[i]) then
          Inc(i)
{$ENDIF}
        else if CurDir[i] = '\' then
          Inc(j);
      end;
      Result := ExtractFileDrive(Directory) + Copy(CurDir, 1, i - 1);
    end;
  end;
end;

procedure TDirectoryListBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
  ItemIndex := DirLevel (Directory);
end;

procedure TDirectoryListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

procedure TDirectoryListBox.ResetItemHeight;
var
  nuHeight: Integer;
begin
  nuHeight :=  GetItemHeight(Font);
  if nuHeight < (OpenedBMP.Height + 1) then
    nuHeight := OpenedBmp.Height + 1;
  ItemHeight := nuHeight;
end;

function TDirectoryListBox.GetDirectory: string;
begin
  Result := FDirectory;
end;


function TDirectoryListBox.GetDrive: char;
begin
  Result := FDirectory[1];
end;

procedure TDirectoryListBox.SetDrive(Value: char);
begin
  if (UpCase(Value) <> UpCase(Drive)) then
    SetDirectory (Format ('%s:', [Value]));
end;

procedure TDirectoryListBox.SetDirectory(const NewDirectory: string);
var
  DirPart: string;
  FilePart: string;
  NewDrive: Char;
begin
  if Length (NewDirectory) = 0 then Exit;
  if (FileCompareText(NewDirectory, Directory) = 0) then Exit;
  ProcessPath (NewDirectory, NewDrive, DirPart, FilePart);
  try
    if Drive <> NewDrive then
    begin
      FInSetDir := True;
      if (FDriveCombo <> nil) then
        FDriveCombo.Drive := NewDrive
      else
        DriveChange(NewDrive);
    end;
  finally
    FInSetDir := False;
  end;
  SetDir(DirPart);
end;

procedure TDirectoryListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Word(Key) = VK_RETURN) then
    OpenCurrent;
end;

procedure TDirectoryListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FFileList) then FFileList := nil
    else if (AComponent = FDriveCombo) then FDriveCombo := nil
    else if (AComponent = FDirLabel) then FDirLabel := nil;
  end;
end;

procedure TDirectoryListBox.SetDirLabelCaption;
var
  DirWidth: Integer;
begin
  if FDirLabel <> nil then
  begin
    DirWidth := Width;
    if not FDirLabel.AutoSize then
      DirWidth := FDirLabel.Width;
    FDirLabel.Caption := MinimizeName(Directory, FDirLabel.Canvas, DirWidth);
  end;
end;

{ TFileListBox }

const
  DefaultMask = '*.*';

constructor TFileListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 145;
{  IntegralHeight := True; }
  FFileType := [ftNormal]; { show only normal files by default }
  GetDir(0, FDirectory); { initially use current dir on default drive }

  FMask := DefaultMask;  { default file mask is all }
  MultiSelect := False;    { default is not multi-select }
  FLastSel := -1;
  ReadBitmaps;
  Sorted := True;
  Style := lbOwnerDrawFixed;
  ResetItemHeight;
end;

destructor TFileListBox.Destroy;
begin
  FreeAndNil(ExeBMP);
  FreeAndNil(DirBMP);
  FreeAndNil(UnknownBMP);
  inherited Destroy;
end;

procedure TFileListBox.Update;
begin
  ReadFileNames;
end;

procedure TFileListBox.CreateWnd;
begin
  inherited CreateWnd;
  ReadFileNames;
end;

function TFileListBox.IsMaskStored: Boolean;
begin
  Result := DefaultMask <> FMask;
end;

function TFileListBox.GetDrive: char;
begin
  Result := FDirectory[1];
end;

procedure TFileListBox.ReadBitmaps;
begin
  ExeBMP := TBitmap.Create;
  ExeBMP.Handle := LoadBitmap(HInstance, 'EXECUTABLE');
  DirBMP := TBitmap.Create;
  DirBMP.Handle := LoadBitmap(HInstance, 'CLOSEDFOLDER');
  UnknownBMP := TBitmap.Create;
  UnknownBMP.Handle := LoadBitmap(HInstance, 'UNKNOWNFILE');
end;

const
   Attributes: array[TFileAttr] of Word = (faReadOnly, faHidden, faSysFile,
     faVolumeID, faDirectory, faArchive, 0);

procedure TFileListBox.ReadFileNames;
var
  AttrIndex: TFileAttr;
  I: Integer;
  FileExt: string;
  AttrWord: Word;
  FileInfo: TSearchRec;
  SaveCursor: TCursor;
  Glyph: TBitmap;
{$IF DEFINED(CLR)}
  MaskPos, SepPos, MaskLen: Integer;
  SearchStr: string;
{$ELSE}
  MaskPtr: PChar;
  Ptr: PChar;
{$ENDIF}
begin
      { if no handle allocated yet, this call will force
        one to be allocated incorrectly (i.e. at the wrong time.
        In due time, one will be allocated appropriately.  }
  AttrWord := DDL_READWRITE;
  if HandleAllocated then
  begin
    { Set attribute flags based on values in FileType }
    for AttrIndex := ftReadOnly to ftArchive do
      if AttrIndex in FileType then
        AttrWord := AttrWord or Attributes[AttrIndex];

    ChDir(FDirectory); { go to the directory we want }
    Clear; { clear the list }

    I := 0;
    SaveCursor := Screen.Cursor;
    try
{$IF DEFINED(CLR)}
      MaskLen := Length(FMask);
      MaskPos := 0;
      while MaskPos >= 0 do
      begin
        SepPos := PosEx(';', FMask, MaskPos + 1) - 1;
        if SepPos >= 0 then
          SearchStr := Copy(FMask, MaskPos + 1, SepPos - MaskPos)
        else
          SearchStr := Copy(FMask, MaskPos + 1, MaskLen);
        if FindFirst(SearchStr, AttrWord, FileInfo) = 0 then
{$ELSE}
      MaskPtr := PChar(FMask);
      while MaskPtr <> nil do
      begin
        Ptr := StrScan (MaskPtr, ';');
        if Ptr <> nil then
          Ptr^ := #0;
        if FindFirst(MaskPtr, AttrWord, FileInfo) = 0 then
{$ENDIF}
        begin
          repeat            { exclude normal files if ftNormal not set }
            if (ftNormal in FileType) or (FileInfo.Attr and AttrWord <> 0) then
              if FileInfo.Attr and faDirectory <> 0 then
              begin
                I := Items.Add(Format('[%s]',[FileInfo.Name]));
                if ShowGlyphs then
                  Items.Objects[I] := DirBMP;
              end
              else
              begin
                FileExt := AnsiLowerCase(ExtractFileExt(FileInfo.Name));
                Glyph := UnknownBMP;
                if (FileExt = '.exe') or (FileExt = '.com') or
                  (FileExt = '.bat') or (FileExt = '.pif') then
                  Glyph := ExeBMP;
                I := Items.AddObject(FileInfo.Name, Glyph);
              end;
            if I = 100 then
              Screen.Cursor := crHourGlass;
          until FindNext(FileInfo) <> 0;
          FindClose(FileInfo);
        end;
{$IF DEFINED(CLR)}
        if SepPos >= 0 then
        begin
          Inc (SepPos);
          if SepPos >= MaskLen then
            SepPos := -1;
        end;
        MaskPos := SepPos;
{$ELSE}
        if Ptr <> nil then
        begin
          Ptr^ := ';';
          Inc (Ptr);
        end;
        MaskPtr := Ptr;
{$ENDIF}
      end;
    finally
      Screen.Cursor := SaveCursor;
    end;
    Change;
  end;
end;

procedure TFileListBox.Click;
begin
  inherited Click;
  if FLastSel <> ItemIndex then
     Change;
end;

procedure TFileListBox.Change;
begin
  FLastSel := ItemIndex;
  if FFileEdit <> nil then
  begin
    if Length(GetFileName) = 0 then
      FileEdit.Text := Mask
    else
      FileEdit.Text := GetFileName;
    FileEdit.SelectAll;
  end;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TFileListBox.SetShowGlyphs(Value: Boolean);
begin
  if FShowGlyphs <> Value then
  begin
    FShowGlyphs := Value;
    if (FShowGlyphs = True) and (ItemHeight < (ExeBMP.Height + 1)) then
      ResetItemHeight;
    Invalidate;
  end;
end;

function TFileListBox.GetFileName: string;
var
  idx: Integer;
begin
      { if multi-select is turned on, then using ItemIndex
        returns a bogus value if nothing is selected   }
  idx  := ItemIndex;
  if (idx < 0)  or  (Items.Count = 0)  or  (Selected[idx] = FALSE)  then
    Result  := ''
  else
    Result  := Items[idx];
end;

procedure TFileListBox.SetFileName(const NewFile: string);
begin
  if AnsiCompareFileName(NewFile, GetFileName) <> 0 then
  begin
    ItemIndex := SendTextMessage(Handle, LB_FindStringExact, 0, NewFile);
    Change;
  end;
end;

procedure TFileListBox.SetFileEdit(Value: TEdit);
begin
  FFileEdit := Value;
  if FFileEdit <> nil then
  begin
    FFileEdit.FreeNotification(Self);
    if GetFileName <> '' then
      FFileEdit.Text := GetFileName
    else
      FFileEdit.Text := Mask;
  end;
end;

procedure TFileListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  offset: Integer;
begin
  with Canvas do
  begin
    FillRect(Rect);
    offset := 2;
    if ShowGlyphs then
    begin
      Bitmap := TBitmap(Items.Objects[Index]);
      if Assigned(Bitmap) then
      begin
        BrushCopy(Bounds(Rect.Left + 2,
                  (Rect.Top + Rect.Bottom - Bitmap.Height) div 2,
                  Bitmap.Width, Bitmap.Height),
                  Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                  Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
        offset := Bitmap.width + 6;
      end;
    end;
    TextOut(Rect.Left + offset, Rect.Top, Items[Index])
  end;
end;

procedure TFileListBox.SetDrive(Value: char);
begin
  if (UpCase(Value) <> UpCase(FDirectory[1])) then
    ApplyFilePath (Format ('%s:', [Value]));
end;

procedure TFileListBox.SetDirectory(const NewDirectory: string);
begin
  if AnsiCompareFileName(NewDirectory, FDirectory) <> 0 then
  begin
       { go to old directory first, in case not complete pathname
         and curdir changed - probably not necessary }
    if DirectoryExists(FDirectory) then
      ChDir(FDirectory);
    ChDir(NewDirectory);     { exception raised if invalid dir }
    GetDir(0, FDirectory);   { store correct directory name }
    ReadFileNames;
  end;
end;

procedure TFileListBox.SetFileType(NewFileType: TFileType);
begin
  if NewFileType <> FFileType then
  begin
    FFileType := NewFileType;
    ReadFileNames;
  end;
end;

procedure TFileListBox.SetMask(const NewMask: string);
begin
  if FMask <> NewMask then
  begin
    FMask := NewMask;
    ReadFileNames;
  end;
end;

procedure TFileListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

procedure TFileListBox.ResetItemHeight;
var
  nuHeight: Integer;
begin
  nuHeight :=  GetItemHeight(Font);
  if (FShowGlyphs = True) and (nuHeight < (ExeBMP.Height + 1)) then
    nuHeight := ExeBmp.Height + 1;
  ItemHeight := nuHeight;
end;

procedure TFileListBox.ApplyFilePath(const EditText: string);
var
  DirPart: string;
  FilePart: string;
  NewDrive: Char;
begin
  if AnsiCompareFileName(FileName, EditText) = 0 then Exit;
  if Length (EditText) = 0 then Exit;
  ProcessPath (EditText, NewDrive, DirPart, FilePart);
  if FDirList <> nil then
    FDirList.Directory := EditText
  else
    if NewDrive <> #0 then
      SetDirectory(Format('%s:%s', [NewDrive, DirPart]))
    else
      SetDirectory(DirPart);
  if (Pos('*', FilePart) > 0) or (Pos('?', FilePart) > 0) then
    SetMask (FilePart)
  else if Length(FilePart) > 0 then
  begin
    SetFileName (FilePart);
    if FileExists (FilePart) then
    begin
      if GetFileName = '' then
      begin
        SetMask(FilePart);
        SetFileName (FilePart);
      end;
    end
    else
      raise EInvalidOperation.CreateFmt(SInvalidFileName, [EditText]);
  end;
end;

function TFileListBox.GetDirectory: string;
begin
  Result := FDirectory;
end;

function TFileListBox.GetFilePath: string;
begin
  Result := '';
  if GetFileName <> '' then
    Result := SlashSep(FDirectory, GetFileName);
end;

procedure TFileListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FFileEdit) then FFileEdit := nil
    else if (AComponent = FDirList) then FDirList := nil
    else if (AComponent = FFilterCombo) then FFilterCombo := nil;
  end;
end;

{ TFilterComboBox }

constructor TFilterComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDownList;
  FFilter := SDefaultFilter;
  MaskList := TStringList.Create;
end;

destructor TFilterComboBox.Destroy;
begin
  MaskList.Free;
  inherited Destroy;
end;

procedure TFilterComboBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
end;

function TFilterComboBox.IsFilterStored: Boolean;
begin
  Result := SDefaultFilter <> FFilter;
end;

procedure TFilterComboBox.SetFilter(const NewFilter: string);
begin
  if AnsiCompareFileName(NewFilter, FFilter) <> 0 then
  begin
    FFilter := NewFilter;
    if HandleAllocated then BuildList;
    Change;
  end;
end;

procedure TFilterComboBox.SetFileListBox (Value: TFileListBox);
begin
  if FFileList <> nil then FFileList.FFilterCombo := nil;
  FFileList := Value;
  if FFileList <> nil then
  begin
    FFileList.FreeNotification(Self);
    FFileList.FFilterCombo := Self;
  end;
end;

procedure TFilterComboBox.Click;
begin
  inherited Click;
  Change;
end;

function TFilterComboBox.GetMask: string;
begin
  if ItemIndex < 0 then
    ItemIndex := Items.Count - 1;

  if ItemIndex >= 0 then
  begin
     Result := MaskList[ItemIndex];
  end
  else
     Result := '*.*';
end;

procedure TFilterComboBox.BuildList;
var
  AFilter, MaskName, Mask: string;
  BarPos: Integer;
begin
  Clear;
  MaskList.Clear;
  AFilter := Filter;
  BarPos := AnsiPos('|', AFilter);
  while BarPos <> 0 do
  begin
    MaskName := Copy(AFilter, 1, BarPos - 1);
    Delete(AFilter, 1, BarPos);
    BarPos := AnsiPos('|', AFilter);
    if BarPos > 0 then
    begin
      Mask := Copy(AFilter, 1, BarPos - 1);
      Delete(AFilter, 1, BarPos);
    end
    else
    begin
      Mask := AFilter;
      AFilter := '';
    end;
    Items.Add(MaskName);
    MaskList.Add(Mask);
    BarPos := AnsiPos('|', AFilter);
  end;
  ItemIndex := 0;
end;

procedure TFilterComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFileList) then
    FFileList := nil;
end;

procedure TFilterComboBox.Change;
begin
  if FFileList <> nil then FFileList.Mask := Mask;
  inherited Change;
end;

{ TSelectDirDlg }
constructor TSelectDirDlg.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  Caption := SSelectDirCap;
  BorderStyle := bsDialog;
  ClientWidth := 424;
  ClientHeight := 255;
  Position := poScreenCenter;

  DirEdit := TEdit.Create(Self);
  with DirEdit do
  begin
    Parent := Self;
    SetBounds(8, 24, 313, 20);
    Visible := False;
    TabOrder := 1;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(8, 8, 92, 13);
    FocusControl := DirEdit;
    Caption := SDirNameCap;
  end;

  DriveList := TDriveComboBox.Create(Self);
  with DriveList do
  begin
    Parent := Self;
    SetBounds(232, 192, 185, 19);
    TabOrder := 2;
    OnChange := DriveListChange;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(232, 176, 41, 13);
    Caption := SDrivesCap;
    FocusControl := DriveList;
  end;

  DirLabel := TPathLabel.Create(Self);
  with DirLabel do
  begin
    Parent := Self;
    SetBounds(120, 8, 213, 13);
  end;

  DirList := TDirectoryListBox.Create(Self);
  with DirList do
  begin
    Parent := Self;
    SetBounds(8, 72, 213, 138);
    TabOrder := 0;
    TabStop := True;
    ItemHeight := 17;
    IntegralHeight := True;
    OnChange := DirListChange;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(8, 56, 66, 13);
    Caption := SDirsCap;
    FocusControl := DirList;
  end;

  FileList := TFileListBox.Create(Self);
  with FileList do
  begin
    Parent := Self;
    SetBounds(232, 72, 185, 93);
    TabOrder := 6;
    TabStop := True;
    FileType := [ftNormal];
    Mask := '*.*';
    Font.Color := clGrayText;
    ItemHeight := 13;
  end;

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    SetBounds(232, 56, 57, 13);
    Caption := SFilesCap;
    FocusControl := FileList;
  end;

  NetButton := TButton.Create(Self);
  with NetButton do
  begin
    Parent := Self;
    SetBounds(8, 224, 77, 27);
    Visible := False;
    TabOrder := 3;
    Caption := SNetworkCap;
    OnClick := NetClick;
  end;

  OKButton := TButton.Create(Self);
  with OKButton do
  begin
    Parent := Self;
    SetBounds(172, 224, 77, 27);
    TabOrder := 4;
    OnClick := OKClick;
    Caption := SOKButton;
    ModalResult := 1;
    Default := True;
  end;

  CancelButton := TButton.Create(Self);
  with CancelButton do
  begin
    Parent := Self;
    SetBounds(256, 224, 77, 27);
    TabOrder := 5;
    Cancel := True;
    Caption := SCancelButton;
    ModalResult := 2;
  end;

  HelpButton := TButton.Create(Self);
  with HelpButton do
  begin
    Parent := Self;
    SetBounds(340, 224, 77, 27);
    TabOrder := 7;
    Caption := SHelpButton;
    OnClick := HelpButtonClick;
  end;

  FormCreate(Self);
  ActiveControl := DirList;
end;

procedure TSelectDirDlg.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSelectDirDlg.DirListChange(Sender: TObject);
begin
  DirLabel.Caption := DirList.Directory;
  FileList.Directory := DirList.Directory;
  DirEdit.Text := DirLabel.Caption;
  DirEdit.SelectAll;
end;

procedure TSelectDirDlg.FormCreate(Sender: TObject);
{$IF NOT DEFINED(CLR)}
var
  UserHandle: THandle;
  NetDriver: THandle;
  WNetGetCaps: function (Flags: Word): Word;
{$ENDIF}
begin
{$IF DEFINED(CLR)}
  NetButton.Visible := False; // assume there is no network connect
                                                                          
                                                    
{$ELSE}
  { is network access enabled? }
  UserHandle := GetModuleHandle(User32);
  @WNetGetCaps := GetProcAddress(UserHandle, 'WNETGETCAPS');
  if @WNetGetCaps <> nil then
  begin
    NetDriver := WNetGetCaps(Word(-1));
    if NetDriver <> 0 then
    begin
      @WNetConnectDialog := GetProcAddress(NetDriver, 'WNETCONNECTDIALOG');
      NetButton.Visible := @WNetConnectDialog <> nil;
    end;
  end;
{$ENDIF}

  FAllowCreate := False;
  DirLabel.BoundsRect := DirEdit.BoundsRect;
  DirListChange(Self);
end;

procedure TSelectDirDlg.DriveListChange(Sender: TObject);
begin
  DirList.Drive := DriveList.Drive;
end;

procedure TSelectDirDlg.SetAllowCreate(Value: Boolean);
begin
  if Value <> FAllowCreate then
  begin
    FAllowCreate := Value;
    DirLabel.Visible := not FAllowCreate;
    DirEdit.Visible := FAllowCreate;
  end;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
procedure TSelectDirDlg.SetDirectory(const Value: string);
var
  Temp: string;
begin
  if Value <> '' then
  begin
    Temp := SlashSep(ExpandFileName(Value), '*.*');
    if (Length(Temp) >= 3) and (Temp[2] = ':') then
    begin
      DriveList.Drive := Temp[1];
      Temp := ExtractFilePath(Temp);
      try
        DirList.Directory := Copy(Temp, 1, Length(Temp) - 1);
      except
{$IF NOT DEFINED(CLR)}
        on EInOutError do
{$ENDIF}
        begin
          GetDir(0, Temp);
          DriveList.Drive := Temp[1];
          DirList.Directory := Temp;
        end;
      end;
    end;
  end;
end;

[FileIOPermission(SecurityAction.Demand, Unrestricted=True)]
function TSelectDirDlg.GetDirectory: string;
begin
  if FAllowCreate then
    Result := DirEdit.Text
  else
    Result := DirLabel.Caption;
end;

procedure TSelectDirDlg.NetClick(Sender: TObject);
begin
  if Assigned(WNetConnectDialog) then
    WNetConnectDialog(Handle, WNTYPE_DRIVE);
end;

procedure TSelectDirDlg.OKClick(Sender: TObject);
begin
  if AllowCreate and Prompt and (not DirectoryExists(Directory)) and
    (MessageDlg(SConfirmCreateDir, mtConfirmation, [mbYes, mbNo],
      0) <> mrYes) then
    ModalResult := 0;
end;

[SecurityPermission(SecurityAction.Demand, Unrestricted=True)]
function SelectDirectory(var Directory: string;
  Options: TSelectDirOpts; HelpCtx: Longint): Boolean;
var
  D: TSelectDirDlg;
begin
  D := TSelectDirDlg.Create(Application);
  try
    D.Directory := Directory;
    D.AllowCreate := sdAllowCreate in Options;
    D.Prompt := sdPrompt in Options;

    { scale to screen res }
    if Screen.PixelsPerInch <> 96 then
    begin
      D.ScaleBy(Screen.PixelsPerInch, 96);
      D.FileList.ParentFont := True;
      D.Left := (Screen.Width div 2) - (D.Width div 2);
      D.Top := (Screen.Height div 2) - (D.Height div 2);
      D.FileList.Font.Color := clGrayText;
    end;

    if HelpCtx = 0 then
    begin
      D.HelpButton.Visible := False;
      D.OKButton.Left := D.CancelButton.Left;
      D.CancelButton.Left := D.HelpButton.Left;
    end
    else D.HelpContext := HelpCtx;

    Result := D.ShowModal = mrOK;
    if Result then
    begin
      Directory := D.Directory;
      if sdPerformCreate in Options then
        ForceDirectories(Directory);
    end;
  finally
    D.Free;
  end;
end;

type
  TSelectDirCallback = class(TObject)
  private
    FDirectory: string;
  protected
    function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer;
  public
    constructor Create(const ADirectory: string);
  end;

{$IF NOT DEFINED(CLR)}
function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer stdcall;
begin
  Result := TSelectDirCallback(lpData).SelectDirCB(Wnd, uMsg, lParam, lpData);
end;
{$ENDIF}

[SecurityPermission(SecurityAction.Demand, UnmanagedCode=True)]
function SelectDirectory(const Caption: string; const Root: WideString;
  var Directory: string; Options: TSelectDirExtOpts; Parent: TWinControl): Boolean;
var
  BrowseInfo: TBrowseInfo;
  OldErrorMode: Cardinal;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
  SelectDirCallback: TSelectDirCallback;
{$IF DEFINED(CLR)}
  WindowList: TObject;
  Buffer: IntPtr;
  RootItemIDList, ItemIDList: IntPtr;
{$ELSE}
  WindowList: Pointer;
  Buffer: PChar;
  RootItemIDList, ItemIDList: PItemIDList;
{$ENDIF}
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
{$IF NOT DEFINED(CLR)}
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
{$ENDIF}
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
{$IF DEFINED(CLR)}
    Buffer := Marshal.AllocHGlobal(MAX_PATH);
    try
      RootItemIDList := nil;
      if Length(Root) <> 0 then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          Root, Eaten, RootItemIDList, Flags);
      end;
{$ELSE}
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
          POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
{$ENDIF}
      with BrowseInfo do
      begin
        if (Parent = nil) or not Parent.HandleAllocated then
          hwndOwner := Application.Handle
        else
          hwndOwner := Parent.Handle;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
{$IF DEFINED(CLR)}
        lpszTitle := Caption;
{$ELSE}
        lpszTitle := PChar(Caption);
        lpfn := SelectDirCB;
{$ENDIF}
        ulFlags := BIF_RETURNONLYFSDIRS;
        if sdNewUI in Options then
          ulFlags := ulFlags or BIF_NEWDIALOGSTYLE;
        if not (sdNewFolder in Options) then
          ulFlags := ulFlags or BIF_NONEWFOLDERBUTTON;
        if sdShowEdit in Options then
          ulFlags := ulFlags or BIF_EDITBOX;
        if not (sdNewUI in Options) and (sdShowShares in Options) then
          ulFlags := ulFlags or BIF_SHAREABLE;
        if sdShowFiles in Options then
          ulFlags := ulFlags or BIF_BROWSEINCLUDEFILES;
        if sdValidateDir in Options then
          ulFlags := ulFlags or BIF_VALIDATE;
      end;
      SelectDirCallback := TSelectDirCallback.Create(Directory);
      try
{$IF DEFINED(CLR)}
        BrowseInfo.lpfn := @SelectDirCallBack.SelectDirCB;
        BrowseInfo.lParam := 0;
{$ELSE}
        BrowseInfo.lParam := LPARAM(SelectDirCallback);
{$ENDIF}
        try
          WindowList := DisableTaskWindows(0);
          OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
          try
            ItemIDList := ShBrowseForFolder(BrowseInfo);
          finally
            SetErrorMode(OldErrorMode);
            EnableTaskWindows(WindowList);
          end;
        finally
{$IF DEFINED(CLR)}
          if (sdNewUI in Options) and
          (Thread.CurrentThread.ApartmentState = ApartmentState.STA) then
{$ELSE}
          if sdNewUI in Options then
{$ENDIF}
        end;
      finally
        SelectDirCallback.Free;
      end;
      Result :=  ItemIDList <> nil;
      if Result then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
{$IF DEFINED(CLR)}
        Directory := Marshal.PtrToStringAuto(Buffer);
      end;
    finally
      Marshal.FreeHGlobal(Buffer);
    end;
{$ELSE}
        Directory := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
{$ENDIF}
  end;
end;

function DirectoryExists(const Name: string): Boolean;
begin
  Result := System.SysUtils.DirectoryExists(Name);
end;

function ForceDirectories(const Dir: string): Boolean;
begin
  Result := System.SysUtils.ForceDirectories(Dir);
end;

{ TSelectDirCallback }

constructor TSelectDirCallback.Create(const ADirectory: string);
begin
  inherited Create;
  FDirectory := ADirectory;
end;

function TSelectDirCallback.SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer;
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  Result := 0;
  if uMsg = BFFM_INITIALIZED then
  begin
    if Assigned(Application.MainForm) then
      Monitor := Screen.MonitorFromWindow(Application.MainForm.Handle)
    else
      Monitor := Screen.MonitorFromWindow(0);
    GetWindowRect(Wnd, Rect);
    SetWindowPos(Wnd, 0, Monitor.Left + (Monitor.Width - (Rect.Right - Rect.Left)) div 2,
      Monitor.Top + (Monitor.Height - (Rect.Bottom - Rect.Top)) div 2, 0, 0, SWP_NOSIZE or SWP_NOZORDER);
    if FDirectory <> '' then
{$IF DEFINED(CLR)}
    begin
      if Marshal.SystemDefaultCharSize = 2 then
        SendTextMessage(Wnd, BFFM_SETSELECTIONW, Winapi.Windows.WPARAM(Ord(True)), FDirectory)
      else
        SendTextMessage(Wnd, BFFM_SETSELECTIONA, Winapi.Windows.WPARAM(Ord(True)), FDirectory)
    end
{$ELSE}
      SendMessage(Wnd, BFFM_SETSELECTION, Winapi.Windows.WPARAM(True), Winapi.Windows.LPARAM(PChar(FDirectory)));
{$ENDIF}
  end else if (uMsg = BFFM_VALIDATEFAILEDW) or (uMsg = BFFM_VALIDATEFAILEDA) then
  begin
{$IF DEFINED(CLR)}
    MessageDlg(Format(SInvalidPath, [Marshal.PtrToStringAuto(IntPtr(lParam))]), mtError, [mbOK], 0);
{$ELSE}
    MessageDlg(Format(SInvalidPath, [PChar(lParam)]), mtError, [mbOK], 0);
{$ENDIF}
    Result := 1;
  end;
end;

end.
