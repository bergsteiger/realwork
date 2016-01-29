 {Author:  Poul Bak}
 {Copyright © 1999-2000 : BakSoft-Denmark (Poul Bak). All rights reserved.}
 {http://home11.inet.tele.dk/BakSoft/}
 {Mailto: baksoft-denmark@dk2net.dk}

{Component Version: 1.60.00.00}

{PBFolderDialog is SHBrowseForFolder dialog with capability of creating new folders when browsing for a folder.}
{It can show path above the window.}
{The 'New folder'-button caption and a 'Label'-caption (shown above the path) are automatic localized (national language) detected every time the application runs.}
{The component is based on Todd Fast's TBrowseFolder component.}

 {Thanks to Gaetano Giunta for great bug-fixing in version 1.20.00.00}
 {Thanks to Daniel Deycard for reporting a problem with using large fonts in Windows.}
 {Thanks to Peter Aschbacher for great translation and bug-reporting.}
 {Thanks to Taine G. for fixing a network-folder problem.}
 {Thanks to Oliver Sturm for fixing a bug changing captions at runtime.}

 //-----------------------------------------------------//
 //                                                     //
 //  Modified by ComponentAce, 2003                     //
 //                                                     //
 //-----------------------------------------------------//

unit ZFFolderDialog;

{$I ZFVer.Inc}

interface

uses
  Windows, Messages, Classes, Forms, Dialogs, SysUtils, ActiveX, Shlobj,
  FileCtrl, Controls, Graphics, Registry;

type
  {Decides what foldertypes to accept and whether to show path.}
  TBrowseInfoFlags = (OnlyComputers, OnlyPrinters, OnlyDomains, OnlyAncestors,
    OnlyFileSystem, ShowPath);
  {Decides what foldertypes to accept and whether to show path.}
  TBrowseInfoFlagSet = set of TBrowseInfoFlags;
  {List of Foldernames used as the root-folder. Users can not browse to a folder above that level.}
  TSHFolders = (foDesktop, foDesktopExpanded, foPrograms, foControlPanel,
    foPrinters, foPersonal, foFavorites, foStartup, foRecent,
    foSendto, foRecycleBin, foStartMenu, foDesktopFolder, foMyComputer,
    foNetwork, foNetworkNeighborhood,
    foFonts, foTemplates);

  TPBFolderDialog = class;
  {The event that is triggered when the dialog has initialized.}
  TBrowserInitializedEvent = procedure(Sender: TPBFolderDialog;
    DialogHandle: HWND) of object;
  {The event that is triggered whenever a folder is selected.}
  TSelectionChangedEvent = procedure(Sender: TPBFolderDialog; DialogHandle: HWND;
    const ItemIDList: PItemIDList; const Folder: string) of object;

  {Author:  Poul Bak}
  {Copyright © 1999-2000 : BakSoft-Denmark (Poul Bak). All rights reserved.}
  {http://home11.inet.tele.dk/BakSoft/}
  {Mailto: baksoft-denmark@dk2net.dk}

  {Component Version: 1.60.00.00}

  {PBFolderDialog is SHBrowseForFolder dialog with capability of creating new folders when browsing for a folder.}
  {It can show path above the window.}
  {The 'New folder'-button caption and a 'Label'-caption (shown above the path) are automatic localized (national language) detected every time the application runs.}
  TPBFolderDialog = class(TComponent)
  private
    FDialogHandle: HWnd;
    FNewFolderHandle: HWnd;
    FLabelCaption: string;
    FParentHandle: HWnd;
    FDisplayName: string;
    FImageIndex: integer;
    FFolder:     string;
    FSelectedFolder: string;
    FFlags:      TBrowseInfoFlagSet;
    FRootFolder: TSHFolders;
    FNewFolderVisible: boolean;
    FNewFolderEnabled: boolean;
    FNewFolderCaption: string;
    FNewFolderWidth: integer;
    FRestart:    boolean;
    FValidPath:  boolean;
    FVersion, FLocale: string;
    FNewFolderCaptions: TStringList;
    FLabelCaptions: TStringList;
    FOnInitialized: TBrowserInitializedEvent;
    FOnSelectionChanged: TSelectionChangedEvent;
    function LocaleText(List: TStringList): string;
    function MakeDisplayPath(Path: string; MaxL: integer): string;
    procedure Dummy(Value: string);
    procedure SetNewFolderCaption(Value: string);
    procedure SetNewFolderEnabled(Value: boolean);
    procedure SetNewFolderVisible(Value: boolean);
    procedure SetNewFolderWidth(Value: integer);
    procedure SetNewFolderCaptions(Value: TStringList);
    procedure SetSelectedFolder(Value: string);
    procedure SetFlags(Value: TBrowseInfoFlagSet);
    procedure SetLabelCaptions(Value: TStringList);
    procedure LabelCaptionsChange(Sender: TObject);
    procedure NewFolderCaptionsChange(Sender: TObject);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure Loaded; override;
    destructor Destroy; override;
    {Use the Execute function to browse for a folder. if the user presses 'Ok' the Folder-property will contain the path to the selected folder.}
    {If the user presses 'Cancel' the Folder-property will not change.}
    function Execute: boolean;
    {Use this procedure to set the selected folder to an ItemIDList.}
    {Use it from an event.}
    procedure SetSelectionPIDL(const Hwnd: HWND; const ItemIDList: PItemIDList);
    {Use this procedure to set the selected folder to a path.}
    {Use it from an event.}
    procedure SetSelectionPath(const Hwnd: HWND; const Path: string);
    {Use this procedure to Enable/Disable the 'Ok'-button.}
    {Use it from an event.}
    procedure EnableOK(const Hwnd: HWND; const Value: boolean);
    {Use this procedure to get an ItemIDList, when you know the path.}
    procedure GetIDListFromPath(Path: string; var ItemIDList: PItemIDList);
    {This property gives the Window-title (when you open a folder in Explorer).}
    {The DisplayName is normally the short foldername.}
    property DisplayName: string Read FDisplayName;
    {A system index to the image for the folder.}
    property ImageIndex: integer Read FImageIndex;
    {The handle of the parent window (the form that called the dialog.}
    property ParentHandle: HWnd Read FParentHandle Write FParentHandle;
    {The handle of the dialog.}
    property DialogHandle: HWnd Read FDialogHandle Write FDialogHandle;
    {The handle of the 'New folder' button.}
    property NewFolderHandle: HWnd Read FNewFolderHandle Write FNewFolderHandle;
    {The currently selected folder. You can access and set this path in one of the events.}
    property SelectedFolder: string Read FSelectedFolder Write SetSelectedFolder;
  published
    {The Folder that is selected when the dialog opens and, when returned, contains the path to the folder the user selected.}
    property Folder: string Read FFolder Write FFolder;
    {Decides what foldertypes to accept and whether to show path.}
    property Flags: TBrowseInfoFlagSet Read FFlags Write SetFlags;
    {The root-folder. Users can not browse to a folder above that level.}
    property RootFolder: TSHFolders Read FRootFolder Write FRootFolder default
      foDesktopExpanded;
    {Decides if the 'New folder' button shall be visible.}
    property NewFolderVisible: boolean Read FNewFolderVisible
      Write SetNewFolderVisible {default FALSE};
    {Decides if the 'New folder' button shall be enabled.}
    property NewFolderEnabled: boolean Read FNewFolderEnabled
      Write SetNewFolderEnabled {default TRUE};
    {Sets the with of the 'New folder' button. Change it if it isn't large enough for your language.}
    property NewFolderWidth: integer
      Read FNewFolderWidth Write SetNewFolderWidth default 75;
    {The event that is triggered when the dialog has initialized.}
    property OnInitialized: TBrowserInitializedEvent
      Read FOnInitialized Write FOnInitialized;
    {The event that is triggered whenever a folder is selected.}
    property OnSelectionChanged: TSelectionChangedEvent
      Read FOnSelectionChanged Write FOnSelectionChanged;
    {LabelCaptions is the localized caption-list for the caption above the browsewindow.}
    {See the 'International codes.txt'-file to find the codes.}
    {At runtime the text that fits the Windows-language is used.}
    {If the Windows-localeversion is not found in the list the 'Default'-value is used.}
    property LabelCaptions: TStringList Read FLabelCaptions Write SetLabelCaptions;
    {NewFolderCaptions is the localized caption-list for the caption of the 'New folder' button.}
    {See the 'International codes.txt'-file to find the codes.}
    {At runtime the text that fits the Windows-language is used.}
    {If the Windows-localeversion is not found in the list the 'Default'-value is used.}
    property NewFolderCaptions: TStringList Read FNewFolderCaptions
      Write SetNewFolderCaptions;
    //ReadOnly property.
    property Version: string Read FVersion Write Dummy stored False;
  end;

//procedure Register;

implementation

const
  _BUTTON_ID = 255;
  MAX_PATH_DISPLAY_LENGTH = 50;
  NUMBER_OF_BROWSE_INFO_FLAGS = 6;
  BROWSE_FLAG_ARRAY: array[TBrowseInfoFlags] of integer = (BIF_BROWSEFORCOMPUTER,
    BIF_BROWSEFORPRINTER, BIF_DONTGOBELOWDOMAIN, BIF_RETURNFSANCESTORS,
    BIF_RETURNONLYFSDIRS, BIF_STATUSTEXT);
  SH_FOLDERS_ARRAY: array[TSHFolders] of integer =
    (CSIDL_DESKTOP, -1,
    CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS, CSIDL_PERSONAL, CSIDL_FAVORITES,
    CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_BITBUCKET, CSIDL_STARTMENU,
    CSIDL_DESKTOPDIRECTORY,
    CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_NETHOOD, CSIDL_FONTS, CSIDL_TEMPLATES);


procedure CenterWindow(HWindow: HWND);
var
  Rect0: TRect;
begin
  GetWindowRect(HWindow, Rect0);
  SetWindowPos(HWindow, 0,
    (Screen.Width div 2) - ((Rect0.Right - Rect0.Left) div 2),
    (Screen.Height div 2) - ((Rect0.Bottom - Rect0.Top) div 2),
    0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

function WndProc(HWindow: HWND; Msg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT; stdcall;
var
  Instance:  TPBFolderDialog;
  NewFolder: string;
begin
  Instance := TPBFolderDialog(GetWindowLong(HWindow, GWL_USERDATA));
  if (Msg = WM_COMMAND) and (Lo(wParam) = _BUTTON_ID) then
  begin
    NewFolder := InputBox(Instance.FNewFolderCaption, '', '');
    if NewFolder <> '' then
    begin
      Instance.FRestart := True;
      if (NewFolder[1] <> '\') and
        (Instance.FSelectedFolder[Length(Instance.FSelectedFolder)] <> '\') then
        NewFolder := '\' + NewFolder;
      Instance.FSelectedFolder := Instance.FSelectedFolder + NewFolder;
      ForceDirectories(Instance.FSelectedFolder);
      Keybd_Event(VK_ESCAPE, 0, 0, 0);
      Keybd_Event(VK_ESCAPE, 0, KEYEVENTF_KEYUP, 0);
    end;
    Result := 0;
  end
  else
    Result := DefDlgProc(HWindow, Msg, wParam, lParam);
end;

procedure AddControls(HWindow: HWND; Instance: TPBFolderDialog);
var
  NewFolderWindowHandle: HWND;
  TempFont: TFont;
  ControlCreateStyles: integer;
  Height0:  integer;
  Rect0:    TRect;
begin
  ControlCreateStyles := WS_CHILD or WS_CLIPSIBLINGS or WS_VISIBLE or
    WS_TABSTOP or BS_PUSHBUTTON;
  GetClientRect(HWindow, Rect0);
  Height0 := Rect0.Bottom - Rect0.Top;
  case Screen.PixelsPerInch of
    72, 96: NewFolderWindowHandle :=
        CreateWindow('Button', PChar(Instance.FNewFolderCaption), ControlCreateStyles,
        12, Height0 - 36, Instance.FNewFolderWidth, 23, HWindow, _BUTTON_ID, HInstance, nil);
    120: NewFolderWindowHandle    :=
        CreateWindow('Button', PChar(Instance.FNewFolderCaption), ControlCreateStyles,
        15, Height0 - 45, Instance.FNewFolderWidth * 5 div 4, 28, HWindow,
        _BUTTON_ID, HInstance, nil);
    144: NewFolderWindowHandle    :=
        CreateWindow('Button', PChar(Instance.FNewFolderCaption), ControlCreateStyles,
        17, Height0 - 56, Instance.FNewFolderWidth * 3 div 2, 35, HWindow,
        _BUTTON_ID, HInstance, nil);
    192: NewFolderWindowHandle    :=
        CreateWindow('Button', PChar(Instance.FNewFolderCaption), ControlCreateStyles,
        20, Height0 - 66, Instance.FNewFolderWidth * Screen.PixelsPerInch div 96,
        41, HWindow, _BUTTON_ID, HInstance, nil);
    else
      NewFolderWindowHandle := CreateWindow('Button', PChar(Instance.FNewFolderCaption),
        ControlCreateStyles, 12 * Screen.PixelsPerInch div 96, Height0 -
        GetSystemMetrics(SM_CYCAPTION) - 17, Instance.FNewFolderWidth *
        Screen.PixelsPerInch div 96, 23 * Screen.PixelsPerInch div 96,
        HWindow, _BUTTON_ID, HInstance, nil);
  end;
  TempFont := nil;
  try
    TempFont := TFont.Create;
    PostMessage(NewFolderWindowHandle, WM_SETFONT, longint(TempFont.Handle), MAKELPARAM(1, 0));
  finally
    TempFont.Free;
  end;
  EnableWindow(NewFolderWindowHandle, Instance.FNewFolderEnabled);
  SetWindowLong(HWindow, GWL_WNDPROC, longint(@WndProc));
  Instance.FNewFolderHandle := NewFolderWindowHandle;
end;

procedure BrowserCallbackProc(HWindow: HWND; uMsg: integer; lParameter: LPARAM;
  lpPBFolderDialog: LPARAM); stdcall;
var
  Instance:  TPBFolderDialog;
  Path:      string;
  TempPath:  array[0..MAX_PATH] of char;
  SHFolderI: IShellFolder;
  lpDisplay: TStrRet;
begin
  Instance := TPBFolderDialog(lpPBFolderDialog);
  case uMsg of
    BFFM_INITIALIZED:
    begin
      Instance.DialogHandle := HWindow;
      CenterWindow(HWindow);
      SetWindowLong(HWindow, GWL_USERDATA, lpPBFolderDialog);
      AddControls(HWindow, Instance);
      if IsWindow(Instance.FNewFolderHandle) then
      begin
        EnableWindow(Instance.FNewFolderHandle, Instance.FValidPath and
          Instance.FNewFolderEnabled);
        //G. Giunta 2000.03.24: enable button if path is valid and property is set
        ShowWindow(Instance.FNewFolderHandle,
          (SW_HIDE and variant(not Instance.FNewFolderVisible)) or
          (SW_SHOW and variant(Instance.FNewFolderVisible)));
        //G. Giunta 2000.03.24: show/hide new directory button
      end;
      if DirectoryExists(Instance.FFolder) then
        Instance.SetSelectionPath(HWindow, Instance.FFolder);
      if Assigned(Instance.OnInitialized) then
        Instance.OnInitialized(Instance, HWindow);
    end;
    BFFM_SELCHANGED:
    begin
      SHGetPathFromIDList(PItemIDList(lParameter), TempPath);
      Instance.FSelectedFolder := StrPas(TempPath);
      if (ShowPath in Instance.FFlags) then
      begin
        SetLength(Path, MAX_PATH);
        Path := Instance.MakeDisplayPath(StrPas(TempPath), MAX_PATH_DISPLAY_LENGTH);
        if Path = '' then
        begin
          if SHGetDeskTopFolder(SHFolderI) = NOERROR then
          begin
            SHFolderI.GetDisplayNameOf(PItemIDList(lParameter), SHGDN_FORPARSING, lpDisplay);
            if lpDisplay.uType = STRRET_CSTR then
              Path := String(StrPas(lpDisplay.cStr));
          end;
        end;
        SendMessage(HWindow, BFFM_SETSTATUSTEXT, 0, longint(PChar(Path)));
      end;
      Instance.FValidPath := (Instance.FSelectedFolder <> '');
      if (OnlyFileSystem in Instance.FFlags) then
        Instance.EnableOK(HWindow, Instance.FValidPath)
      else
        Instance.EnableOK(HWindow, True);
      if IsWindow(Instance.FNewFolderHandle) then
        EnableWindow(Instance.FNewFolderHandle, Instance.FValidPath and
          Instance.FNewFolderEnabled);
      //G. Giunta 2000.03.24: enable button if path is valid and property is set
      if Assigned(Instance.OnSelectionChanged) then
        Instance.OnSelectionChanged(Instance, HWindow, PItemIDList(lParameter),
          Instance.SelectedFolder);
    end;
  end;
end;

constructor TPBFolderDialog.Create(AOwner: TComponent);
var
  FReg: TRegistry;
begin
  inherited Create(AOwner);
  SetLength(FDisplayName, MAX_PATH);
  SetLength(FFolder, MAX_PATH);
  FParentHandle := 0;
  FRootFolder := foDesktopExpanded;
  FNewFolderVisible := True;
  FNewFolderEnabled := True;
  FNewFolderWidth := 75;
  FFlags := [ShowPath];
  FFolder := '';
  FSelectedFolder := '';
  FValidPath := True;
  FVersion := '1.60.00.00';
  FReg := TRegistry.Create;
  with FReg do
  begin
    if OpenKey('\Control Panel\Desktop\ResourceLocale', False) then
    begin {Windows 9x installation language}
      FLocale := ReadString('');
      FLocale := UpperCase(Copy(FLocale, length(FLocale) - 3, 4));
    end
    else
    begin {Windows NT installation language}
      RootKey := HKEY_USERS;
      if OpenKey('\.DEFAULT\Control Panel\International', False) then
      begin
        FLocale := ReadString('Locale');
        FLocale := UpperCase(Copy(FLocale, length(FLocale) - 3, 4));
      end;
    end;
  end;
  FReg.Free;
  FNewFolderCaptions := TStringList.Create;
  FNewFolderCaptions.OnChange := NewFolderCaptionsChange;
  FNewFolderCaptions.CommaText :=
    '"Default=New folder", "0009=New folder",' +
    ' "0406=Ny mappe", "0407=Neuer Ordner", "0409=New folder",' +
    ' "0410=Nuova Cartella", "0413=Nieuwe map", "0416=Nova Pasta", "0807=Neuer Ordner",' +
    ' "0809=New folder", "0810=Nuova Cartella", "0C07=Neuer Ordner",' +
    ' "0C09=New folder", "1007=Neuer Ordner", "1009=New folder",' +
    ' "1407=Neuer Ordner", "1409=New folder", "1809=New folder",' +
    ' "1C09=New folder", "2009=New folder", "2809=New folder",' + ' "2C09=New folder"';
  FLabelCaptions     := TStringList.Create;
  FLabelCaptions.OnChange := LabelCaptionsChange;
  FLabelCaptions.CommaText := '"Default=Current folder:", "0009=Current folder:",' +
    ' "0406=Valgt mappe:", "0407=Ausgewählter Ordner:", "0409=Current folder:",' +
    ' "0410=Cartella selezionata:", "0413=Huidige map", "0416=Pasta Atual:", "0807=Ausgewählter Ordner:",'
    +
    ' "0809=Current folder:", "0810=Cartella selezionata:", "0C07=Ausgewählter Ordner:",' +
    ' "0C09=Current folder:", "1007=Ausgewählter Ordner:", "1009=Current folder:",' +
    ' "1407=Ausgewählter Ordner:", "1409=Current folder:", "1809=Current folder:",' +
    ' "1C09=Current folder:", "2009=Current folder:", "2809=Current folder:",' +
    ' "2C09=Current folder:"';
end;

procedure TPBFolderDialog.Loaded;
begin
  SetNewFolderCaption(LocaleText(FNewFolderCaptions));
  FLabelCaption := LocaleText(FLabelCaptions);
end;

destructor TPBFolderDialog.Destroy;
begin
  FNewFolderCaptions.Free;
  FLabelCaptions.Free;
  inherited Destroy;
end;

procedure TPBFolderDialog.GetIDListFromPath(Path: string; var ItemIDList: PItemIDList);
var
  ShellFolderInterface: IShellFolder;
  CharsParsed: ULONG;
  Attributes:  ULONG;
begin
  if SHGetDesktopFolder(ShellFolderInterface) = NOERROR then
  begin
    if DirectoryExists(Path) then
      ShellFolderInterface.ParseDisplayName(0, nil, StringToOleStr(Path),
        CharsParsed, ItemIDList, Attributes);
  end;
end;

procedure TPBFolderDialog.SetSelectionPIDL(const Hwnd: HWND;
  const ItemIDList: PItemIDList);
begin
  SendMessage(Hwnd, BFFM_SETSELECTION, Ord(False), longint(ItemIDList));
end;

procedure TPBFolderDialog.SetSelectionPath(const Hwnd: HWND; const Path: string);
var
  ItemIDList: PItemIDList;
begin
  GetIDListFromPath(Path, ItemIDList);
  SendMessage(Hwnd, BFFM_SETSELECTION, Ord(False), longint(ItemIDList));
end;

procedure TPBFolderDialog.EnableOK(const Hwnd: HWND; const Value: boolean);
begin
  SendMessage(Hwnd, BFFM_ENABLEOK, 0, Ord(Value));
end;

procedure TPBFolderDialog.SetNewFolderVisible(Value: boolean);
begin
  //G. Giunta 2000.03.24: set visibility of new folder button:
  // set property filed + send msg to button's window
  if FNewFolderVisible <> Value then
  begin
    FNewFolderVisible := Value;
    if IsWindow(FNewFolderHandle) then
      ShowWindow(FNewFolderHandle, (SW_HIDE and not variant(Value)) or
        (SW_SHOW and variant(Value)));
  end;
end;

procedure TPBFolderDialog.SetNewFolderEnabled(Value: boolean);
begin
  FNewFolderEnabled := Value;
  if (IsWindow(FNewFolderHandle)) then
    EnableWindow(FNewFolderHandle, Value and FValidPath);
  //G. Giunta 2000.03.24: enable button if path is valid and property is set
end;

procedure TPBFolderDialog.SetNewFolderCaption(Value: string);
begin
  FNewFolderCaption := Value;
  if (IsWindow(FNewFolderHandle)) then
    SetWindowText(FNewFolderHandle, PChar(Value));
end;

procedure TPBFolderDialog.SetNewFolderWidth(Value: integer);
begin
  if Value <= 0 then
    FNewFolderWidth := 75
  else
    FNewFolderWidth := Value;
end;

procedure TPBFolderDialog.SetSelectedFolder(Value: string);
begin
  SetSelectionPath(DialogHandle, Value);
end;

procedure TPBFolderDialog.SetFlags(Value: TBrowseInfoFlagSet);
begin
  FFlags := Value;
end;

procedure TPBFolderDialog.SetLabelCaptions(Value: TStringList);
begin
  if FLabelCaptions.Text <> Value.Text then
  begin
    FLabelCaptions.Assign(Value);
  end;
end;

procedure TPBFolderDialog.SetNewFolderCaptions(Value: TStringList);
begin
  if FNewFolderCaptions.Text <> Value.Text then
  begin
    FNewFolderCaptions.Assign(Value);
  end;
end;

procedure TPBFolderDialog.LabelCaptionsChange(Sender: TObject);
begin
  FLabelCaption := LocaleText(FLabelCaptions);
end;

procedure TPBFolderDialog.NewFolderCaptionsChange(Sender: TObject);
begin
  SetNewFolderCaption(LocaleText(FNewFolderCaptions));
end;

procedure TPBFolderDialog.Dummy(Value: string);
begin
  //  Read only !
end;

function TPBFolderDialog.LocaleText(List: TStringList): string;
begin
  if List.Count = 0 then
    Result := ''
  else
  begin
    if List.IndexOfName(FLocale) <> -1 then
      Result := List.Values[FLocale]
    else if List.IndexOfName('Default') <> -1 then
      Result := List.Values['Default']
    else
      Result := List.Values[List.Names[0]];
  end;
end;

function TPBFolderDialog.MakeDisplayPath(Path: string; MaxL: integer): string;
var
  t, Pos0, NumBack: integer;
begin
  Result := '';
  if (Length(Path) <= MaxL) or (MaxL < 6) or (Pos('\', Path) = 0) then
    Result := Copy(Path, 1, MaxL)
  else
  begin
    NumBack := 0;
    for t := 3 to Length(Path) do
      if (Path[t] = '\') then
        Inc(NumBack);
    if NumBack < 2 then
      Result := Copy(Path, 1, MaxL)
    else
    begin
      Pos0 := Pos('\', Path);
      if Pos0 < 3 then
      begin
        Result := '\\';
        Path   := Copy(Path, 3, Length(Path) - 2);
      end;
      Pos0   := Pos('\', Path);
      Result := Result + Copy(Path, 1, Pos0) + '...';
      repeat
        Path := Copy(Path, Pos0 + 1, Length(Path) - Pos0);
        Pos0 := Pos('\', Path);
      until ((Length(Result + Path) + 1) <= MaxL) or (Pos0 = 0);
      if ((Length(Result + Path) + 1) <= MaxL) then
        Result := Result + '\' + Path
      else
        Result := Copy(Result + '\' + Path, 1, MaxL - 3) + '...';
    end;
  end;
end;

function TPBFolderDialog.Execute: boolean;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  i: integer;
  TempPath: array[0..MAX_PATH] of char;
begin
  FSelectedFolder := FFolder;
  ItemIDList      := nil;
  try
    if IsWindow(FParentHandle) then
      BrowseInfo.hwndOwner := FParentHandle
    else if (Owner is TWinControl) then
      BrowseInfo.hwndOwner := TWinControl(Owner).Handle
    else
      BrowseInfo.hwndOwner := Application.MainForm.Handle;
    if FRootFolder = foDesktopExpanded then
      BrowseInfo.pidlRoot := nil
    else
      SHGetSpecialFolderLocation(Application.Handle, SH_FOLDERS_ARRAY[FRootFolder],
        BrowseInfo.pidlRoot);
    BrowseInfo.pszDisplayName := PChar(FDisplayName);
    BrowseInfo.lpszTitle := PChar(FLabelCaption);
    BrowseInfo.ulFlags := 0;
    for i := 0 to NUMBER_OF_BROWSE_INFO_FLAGS - 1 do
    begin
      if (TBrowseInfoFlags(i) in FFlags) then
        BrowseInfo.ulFlags := integer(BrowseInfo.ulFlags) or
          integer(BROWSE_FLAG_ARRAY[TBrowseInfoFlags(i)]);
    end;
    BrowseInfo.lpfn   := @BrowserCallbackProc;
    BrowseInfo.lParam := longint(Self);
    BrowseInfo.iImage := 0;
    FSelectedFolder   := FFolder;
    repeat
      FRestart   := False;
      FFolder    := FSelectedFolder;
      {SHBrowseForFolder; return is nil if user cancels}
      ItemIDList := SHBrowseForFolder(BrowseInfo);
    until not FRestart;

    Result := (ItemIDList <> nil);
    if Result then
    begin
      SHGetPathFromIDList(ItemIDList, TempPath);
      FFolder     := StrPas(TempPath);
      FSelectedFolder := FFolder;
      FImageIndex := BrowseInfo.iImage;
    end;
  finally
    CoTaskMemFree(ItemIDList);
    CoTaskMemFree(BrowseInfo.pidlRoot);
  end;
end;

{
procedure Register;
begin
  RegisterComponents('PB', [TPBFolderDialog]);
end;
}
end.
