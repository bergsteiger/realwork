{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ExtDlgs;

{$R-,H+,X+}

interface

uses Winapi.Messages, Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Dialogs, Vcl.Consts;

(*$HPPEMIT '// Alias records for C++ code that cannot compile in STRICT mode yet.' *)
(*$HPPEMIT '#if defined(_VCL_ALIAS_RECORDS)' *)
(*$HPPEMIT '#if !defined(STRICT)' *)
(*$HPPEMIT '  #pragma alias "@Vcl@Extdlgs@TOpenPictureDialog@Execute$qqrpv"="@Vcl@Extdlgs@TOpenPictureDialog@Execute$qqrp6HWND__"' *)
(*$HPPEMIT '  #pragma alias "@Vcl@Extdlgs@TSavePictureDialog@Execute$qqrpv"="@Vcl@Extdlgs@TSavePictureDialog@Execute$qqrp6HWND__"' *)
(*$HPPEMIT '  #pragma alias "@Vcl@Extdlgs@TOpenTextFileDialog@Execute$qqrpv"="@Vcl@Extdlgs@TOpenTextFileDialog@Execute$qqrp6HWND__"' *)
(*$HPPEMIT '  #pragma alias "@Vcl@Extdlgs@TSaveTextFileDialog@Execute$qqrpv"="@Vcl@Extdlgs@TSaveTextFileDialog@Execute$qqrp6HWND__"' *)
(*$HPPEMIT '#endif' *)
(*$HPPEMIT '#endif' *)

type

{ TOpenPictureDialog }

  TOpenPictureDialog = class(TOpenDialog)
  private
    FPicturePanel: TPanel;
    FPictureLabel: TLabel;
    FPreviewButton: TSpeedButton;
    FPaintPanel: TPanel;
    FImageCtrl: TImage;
    FSavedFilename: string;
    function  IsFilterStored: Boolean;
    procedure PreviewKeyPress(Sender: TObject; var Key: Char);
  protected
    procedure PreviewClick(Sender: TObject); virtual;
    procedure DoClose; override;
    procedure DoSelectionChange; override;
    procedure DoShow; override;
    property ImageCtrl: TImage read FImageCtrl;
    property PictureLabel: TLabel read FPictureLabel;
  published
    property Filter stored IsFilterStored;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute(ParentWnd: HWND): Boolean; override;
  end;

{ TSavePictureDialog }

  TSavePictureDialog = class(TOpenPictureDialog)
{$IF DEFINED(CLR)}
  protected
    function LaunchDialog(DialogData: IntPtr): Bool; override;
{$ELSE}
  public
    function Execute: Boolean; override;
    function Execute(ParentWnd: HWND): Boolean; override;
{$ENDIF}
  end;

{ TOpenTextFileDialog }

  TOpenTextFileDialog = class(TOpenDialog)
  private
    FComboBox: TComboBox;
    FEncodings: TStrings;
    FEncodingIndex: Integer;
    FLabel: TLabel;
    FPanel: TPanel;
    function IsEncodingStored: Boolean;
    function GetDlgItemRect(Item: Integer): TRect;
    procedure SetEncodings(const Value: TStrings);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure DoClose; override;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(ParentWnd: HWND): Boolean; override;
  published
    property Encodings: TStrings read FEncodings write SetEncodings stored IsEncodingStored;
    property EncodingIndex: Integer read FEncodingIndex write FEncodingIndex default 0;
  end;

{ TSaveTextFileDialog }

  TSaveTextFileDialog = class(TOpenTextFileDialog)
{$IF DEFINED(CLR)}
  protected
    function LaunchDialog(DialogData: IntPtr): Bool; override;
{$ELSE}
  public
    function Execute: Boolean; override;
    function Execute(ParentWnd: HWND): Boolean; override;
{$ENDIF}
  end;

const
  DefaultEncodingNames: array[0..5] of string =
    (SANSIEncoding, SASCIIEncoding, SUnicodeEncoding,
     SBigEndianEncoding, SUTF8Encoding, SUTF7Encoding);

// Returns the standard encoding referenced by Name, or
// nil if Name isn't one of the encodings in DefaultEncodingNames.
function StandardEncodingFromName(const Name: string): TEncoding;

implementation

{$IF DEFINED(CLR)}
{$R Borland.Vcl.ExtDlgs.res}
{$R Borland.Vcl.ExtDlgs.resources}
{$ELSE}
{$R ExtDlgs.res}
{$ENDIF}

uses 
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.Reflection, System.Security.Permissions, System.IO,
{$ENDIF}
  System.Math, Vcl.Forms, Winapi.CommDlg, Winapi.Dlgs, System.Types, Winapi.ShlObj, Winapi.ActiveX;
  

{$IF DEFINED(CLR)}
const
  ResourceBaseName = 'Borland.Vcl.ExtDlgs'; { Do not localize }
{$ENDIF}

type
  TSilentPaintPanel = class(TPanel)
  public
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
  end;

procedure TSilentPaintPanel.WMPaint(var Msg: TWMPaint);
begin
  try
    inherited;
  except
    Caption := SInvalidImage;
  end;
end;

{ TOpenPictureDialog }

constructor TOpenPictureDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Filter := GraphicFilter(TGraphic);
  FPicturePanel := TPanel.Create(Self);
  with FPicturePanel do
  begin
    Name := 'PicturePanel';
    Caption := '';
    SetBounds(204, 5, 169, 200);
    BevelOuter := bvNone;
    BorderWidth := 6;
    TabOrder := 1;
    FPictureLabel := TLabel.Create(Self);
    with FPictureLabel do
    begin
      Name := 'PictureLabel';
      Caption := '';
      SetBounds(6, 6, 157, 23);
      Align := alTop;
      AutoSize := False;
      Parent := FPicturePanel;
    end;
    FPreviewButton := TSpeedButton.Create(Self);
    with FPreviewButton do
    begin
      Name := 'PreviewButton';
      SetBounds(77, 1, 23, 22);
      Enabled := False;
{$IF DEFINED(CLR)}
      Glyph.LoadFromResourceName('PREVIEWGLYPH',
        ResourceBaseName, Assembly.GetExecutingAssembly); { Do not localize }
{$ELSE}
      Glyph.LoadFromResourceName(HInstance, 'PREVIEWGLYPH');
{$ENDIF}
      Hint := SPreviewLabel;
      ParentShowHint := False;
      ShowHint := True;
      OnClick := PreviewClick;
      Parent := FPicturePanel;
    end;
    FPaintPanel := TSilentPaintPanel.Create(Self);
    with FPaintPanel do
    begin
      Name := 'PaintPanel';
      Caption := '';
      SetBounds(6, 29, 157, 145);
      Align := alClient;
      BevelInner := bvRaised;
      BevelOuter := bvLowered;
      TabOrder := 0;
      FImageCtrl := TImage.Create(Self);
      Parent := FPicturePanel;
      with FImageCtrl do
      begin
        Name := 'PaintBox';
        Align := alClient;
        OnDblClick := PreviewClick;
        Parent := FPaintPanel;
        Proportional := True;
        Stretch := True;
        Center := True;
        IncrementalDisplay := True;
      end;
    end;
  end;
end;

{$IF DEFINED(CLR)}
function GetFileNameFromLink(ParentWnd: HWND; const LinkFileName: string;
  var FileName: string): Boolean;
begin
                           
  Result := False;
end;
{$ELSE}
function GetFileNameFromLink(ParentWnd: HWND; const LinkFileName: string;
  var FileName: string): Boolean;
const
  IID_IPersistFile: TGUID = '{0000010B-0000-0000-C000-000000000046}';
var
  LResult: HRESULT;
  LSHellLink: IShellLink;
  LPersistFile: IPersistFile;
  LFindData: TWin32FindData;
begin
  Result := False;
  LResult := CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER,
    IID_IShellLinkW, LShellLink);

  if LResult = S_OK then
    if Supports(LShellLink, IID_IPersistFile, LPersistFile) then
    begin
      LResult := LPersistFile.Load(PChar(LinkFileName), STGM_READ);
      if LResult = S_OK then
      begin
        LResult := LShellLink.Resolve(ParentWnd, 0);
        if LResult = S_OK then
        begin
          SetLength(FileName, MAX_PATH);
          LResult := LSHellLink.GetPath(PChar(FileName), MAX_PATH, LFindData, SLGP_UNCPRIORITY);
          Result := LResult = S_OK;
          if Result then
            FileName := Trim(FileName);
        end;
      end;
    end;
end;
{$ENDIF}

procedure TOpenPictureDialog.DoSelectionChange;
var
  FullName, LFileName: string;
  ValidPicture: Boolean;

  function ValidFile(const FileName: string): Boolean;
  begin
    Result := FileGetAttr(FileName) <> -1;
  end;

begin
  FullName := FileName;
  if FullName <> FSavedFilename then
  begin
    FSavedFilename := FullName;
    ValidPicture := FileExists(FullName) and ValidFile(FullName);
    if ValidPicture and (CompareText(ExtractFileExt(FullName), '.lnk') = 0) then  // Do not localize
    begin
      ValidPicture := GetFileNameFromLink(Handle, FullName, LFileName);
      if ValidPicture then
        FullName := LFileName;
    end;
    if ValidPicture then
    try
      FImageCtrl.Picture.LoadFromFile(FullName);
      FPictureLabel.Caption := Format(SPictureDesc,
        [FImageCtrl.Picture.Width, FImageCtrl.Picture.Height]);
      FPreviewButton.Enabled := True;
      FPaintPanel.Caption := '';
    except
      ValidPicture := False;
    end;
    if not ValidPicture then
    begin
      FPictureLabel.Caption := SPictureLabel;
      FPreviewButton.Enabled := False;
      FImageCtrl.Picture := nil;
      FPaintPanel.Caption := srNone;
    end;
  end;
  inherited DoSelectionChange;
end;

procedure TOpenPictureDialog.DoClose;
begin
  inherited DoClose;
  { Hide any hint windows left behind }
  Application.HideHint;
end;

procedure TOpenPictureDialog.DoShow;
var
  PreviewRect, StaticRect: TRect;
begin
  { Set preview area to entire dialog }
  GetClientRect(Handle, PreviewRect);
  StaticRect := GetStaticRect;
  { Move preview area to right of static area }
  PreviewRect.Left := StaticRect.Left + (StaticRect.Right - StaticRect.Left);
  Inc(PreviewRect.Top, 4);
  FPicturePanel.BoundsRect := PreviewRect;
  FPreviewButton.Left := FPaintPanel.BoundsRect.Right - FPreviewButton.Width - 2;
  FImageCtrl.Picture := nil;
  FSavedFilename := '';
  FPaintPanel.Caption := srNone;
  FPicturePanel.ParentWindow := Handle;
  inherited DoShow;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.SafeSubWindows)]
function TOpenPictureDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) and not
     ((Win32MajorVersion >= 6) and UseLatestCommonDialogs) then
    Template := 'DLGTEMPLATE'
  else
{$IF DEFINED(CLR)}
    Template := '';
{$ELSE}
    Template := nil;
{$ENDIF}
  Result := inherited Execute(ParentWnd);
end;

procedure TOpenPictureDialog.PreviewClick(Sender: TObject);
var
  PreviewForm: TForm;
  Panel: TPanel;
begin
  PreviewForm := TForm.Create(Self);
  with PreviewForm do
  try
    Name := 'PreviewForm';
    Visible := False;
    Caption := SPreviewLabel;
    BorderStyle := bsSizeToolWin;
    KeyPreview := True;
    Position := poScreenCenter;
    OnKeyPress := PreviewKeyPress;
    Panel := TPanel.Create(PreviewForm);
    with Panel do
    begin
      Name := 'Panel';
      Caption := '';
      Align := alClient;
      BevelOuter := bvNone;
      BorderStyle := bsSingle;
      BorderWidth := 5;
      Color := clWindow;
      Parent := PreviewForm;
      DoubleBuffered := True;
      with TImage.Create(PreviewForm) do
      begin
        Name := 'Image';
        Align := alClient;
        Stretch := True;
        Proportional := True;
        Center := True;
        Picture.Assign(FImageCtrl.Picture);
        Parent := Panel;
      end;
    end;
    if FImageCtrl.Picture.Width > 0 then
    begin
      ClientWidth := Min(Monitor.Width * 3 div 4,
        FImageCtrl.Picture.Width + (ClientWidth - Panel.ClientWidth)+ 10);
      ClientHeight := Min(Monitor.Height * 3 div 4,
        FImageCtrl.Picture.Height + (ClientHeight - Panel.ClientHeight) + 10);
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TOpenPictureDialog.PreviewKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then TForm(Sender).Close;
end;

function TOpenPictureDialog.IsFilterStored: Boolean;
begin
  Result := not (Filter = GraphicFilter(TGraphic));
end;

{ TSavePictureDialog }

{$IF DEFINED(CLR)}
function TSavePictureDialog.LaunchDialog(DialogData: IntPtr): Bool;
begin
  Result := GetSaveFileName(DialogData);
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
function TSavePictureDialog.Execute: Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) and not
     ((Win32MajorVersion >= 6) and UseLatestCommonDialogs) then
    Template := 'DLGTEMPLATE'
  else
    Template := nil;
  Result := DoExecute(@GetSaveFileName);
end;

function TSavePictureDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) and not
     ((Win32MajorVersion >= 6) and UseLatestCommonDialogs) then
    Template := 'DLGTEMPLATE'
  else
    Template := nil;
  Result := DoExecute(@GetSaveFileName, ParentWnd);
end;
{$ENDIF}

{ TOpenTextFileDialog }

constructor TOpenTextFileDialog.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited Create(AOwner);
  FEncodings := TStringList.Create;
  for I := 0 to Length(DefaultEncodingNames) - 1 do
    FEncodings.Add(DefaultEncodingNames[I]);
  FEncodingIndex := 0;

  FPanel := TPanel.Create(Self);
  with FPanel do
  begin
    Name := 'PicturePanel'; // Do not localize
    Caption := '';
    SetBounds(0, 0, 300, 22);
    BevelOuter := bvNone;
    FullRepaint := False;
    TabOrder := 1;
    TabStop := True;
    FLabel := TLabel.Create(Self);
    with FLabel do
    begin
      Name := 'EncodingLabel'; // Do not localize
      Caption := SEncodingLabel;
      SetBounds(0, 2, 90, 21);
      Parent := FPanel;
    end;
    FComboBox := TComboBox.Create(Self);
    with FComboBox do
    begin
      Name := 'EncodingCombo'; // Do not localize
      SetBounds(73, 0, 246, 21);
      Style := csDropDownList;
      Parent := FPanel;
    end;
  end;
end;

destructor TOpenTextFileDialog.Destroy;
begin
  FEncodings.Free;
  inherited;
end;

procedure TOpenTextFileDialog.DoClose;
begin
  inherited DoClose;
  FEncodingIndex := FComboBox.ItemIndex;
end;

procedure TOpenTextFileDialog.DoShow;
var
  I: Integer;
  R, Rect, StaticRect: TRect;
begin
  GetClientRect(Handle, Rect);
  StaticRect := GetStaticRect;

  // Move panel to bottom of static area aligned with "Files of type" label
  Inc(Rect.Top, StaticRect.Bottom - StaticRect.Top - 1);
  R := GetDlgItemRect(stc2); // "Files of type" label
  Rect.Left := R.Left;

  // Adjust position of panel if Help or Read-only buttons visible
  if (ofShowHelp in Options) or (not (ofhideReadOnly in Options)) then
  begin
    R := GetDlgItemRect(psh15); // Help button
    Dec(Rect.Top, R.Bottom - R.Top + 6);
  end;

  // Move Read-only checkbox below encodings combobox if it's visible
  if not (ofhideReadOnly in Options) then
  begin
    R := GetDlgItemRect(chx1); // Read-only checkbox
    Inc(R.Top, FComboBox.Height + 6);
    SetWindowPos(GetDlgItem(GetParent(Handle), chx1), 0, R.Left, R.Top,
      0, 0, SWP_NOSIZE or SWP_NOZORDER);
  end;

  // Adjust Encodings combobox size/position to match file types combobox
  R := GetDlgItemRect(cmb1); // "Files of type" comboxbox
  FComboBox.Width := R.Right - R.Left;
  FComboBox.Left := R.Left - Rect.Left;

  // Adjust panel size to match Encodings combobox
  Rect.Right := R.Right;
  Rect.Bottom := Rect.Top + FComboBox.Height;
  FPanel.BoundsRect := Rect;
  FPanel.ParentWindow := Handle;

  // Populate Encodings combobox
  FComboBox.Items.Clear;
  for I := 0 to FEncodings.Count - 1 do
    FComboBox.Items.Add(FEncodings[I]);
  FComboBox.ItemIndex := FEncodingIndex;
  inherited DoShow;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.SafeSubWindows)]
function TOpenTextFileDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'TEXTFILEDLG' else // Do not localize
{$IF DEFINED(CLR)}
    Template := '';
{$ELSE}
    Template := nil;
{$ENDIF}
  Result := inherited Execute(ParentWnd);
end;

function TOpenTextFileDialog.GetDlgItemRect(Item: Integer): TRect;
begin
  if Handle <> 0 then
  begin
    if not (ofOldStyleDialog in Options) then
    begin
      GetWindowRect(GetDlgItem(GetParent(Handle), Item), Result);
      MapWindowPoints(0, Handle, Result, 2);
    end
    else Result := Rect(0, 0, 0, 0);
  end
  else Result := Rect(0, 0, 0, 0);
end;

function TOpenTextFileDialog.IsEncodingStored: Boolean;
var
  I: Integer;
begin
  Result := FEncodings.Count <> Length(DefaultEncodingNames);
  if not Result then
    for I := 0 to FEncodings.Count - 1 do
      if AnsiCompareText(FEncodings[I], DefaultEncodingNames[I]) <> 0 then
      begin
        Result := True;
        Break;
      end;
end;

procedure TOpenTextFileDialog.SetEncodings(const Value: TStrings);
begin
  FEncodings.Assign(Value)
end;

procedure TOpenTextFileDialog.WMSize(var Message: TWMSize);
var
  LRect: TRect;
begin
  inherited;
  LRect := GetDlgItemRect(cmb1); // "Files of type" combobox
  FComboBox.Width := LRect.Right - LRect.Left;
  FPanel.Width := FComboBox.Width + FComboBox.Left;
end;

{ TSaveTextFileDialog }

{$IF DEFINED(CLR)}
function TSaveTextFileDialog.LaunchDialog(DialogData: IntPtr): Bool;
begin
  Result := GetSaveFileName(DialogData);
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
function TSaveTextFileDialog.Execute: Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'TEXTFILEDLG' else // Do not localize
    Template := nil;
  Result := DoExecute(@GetSaveFileName);
end;

function TSaveTextFileDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'TEXTFILEDLG'
  else
    Template := nil;
  Result := DoExecute(@GetSaveFileName, ParentWnd);
end;
{$ENDIF}

function StandardEncodingFromName(const Name: string): TEncoding;
begin
  Result := nil;
  if Name = SANSIEncoding then
    Result := TEncoding.Default
  else if Name = SASCIIEncoding then
    Result := TEncoding.ASCII
  else if Name = SUnicodeEncoding then
    Result := TEncoding.Unicode
  else if Name = SBigEndianEncoding then
    Result := TEncoding.BigEndianUnicode
  else if Name = SUTF7Encoding then
    Result := TEncoding.UTF7
  else if Name = SUTF8Encoding then
    Result := TEncoding.UTF8;
end;

end.
