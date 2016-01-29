{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Clipbrd;

{$R-,T-,H+,X+}

interface

uses 
{$IF DEFINED(CLR)}
  WinUtils, System.Runtime.InteropServices, System.Security.Permissions,
{$ENDIF}
{$IF DEFINED(LINUX)}
  WinUtils, 
{$ENDIF}
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Graphics;

var
  CF_PICTURE: Word;
  CF_COMPONENT: Word;

{ TClipboard }

{ The clipboard object encapsulates the Windows clipboard.

  Assign - Assigns the given object to the clipboard.  If the object is
    a TPicture or TGraphic desendent it will be placed on the clipboard
    in the corresponding format (e.g. TBitmap will be placed on the
    clipboard as a CF_BITMAP). Picture.Assign(Clipboard) and
    Bitmap.Assign(Clipboard) are also supported to retrieve the contents
    of the clipboard.
  Clear - Clears the contents of the clipboard.  This is done automatically
    when the clipboard object adds data to the clipboard.
  Close - Closes the clipboard if it is open.  Open and close maintain a
    count of the number of times the clipboard has been opened.  It will
    not actually close the clipboard until it has been closed the same
    number of times it has been opened.
  Open - Open the clipboard and prevents all other applications from changeing
    the clipboard.  This is call is not necessary if you are adding just one
    item to the clipboard.  If you need to add more than one format to
    the clipboard, call Open.  After all the formats have been added. Call
    close.
  HasFormat - Returns true if the given format is available on the clipboard.
  GetAsHandle - Returns the data from the clipboard in a raw Windows handled
    for the specified format.  The handle is not owned by the application and
    the data should be copied.
  SetAsHandle - Places the handle on the clipboard in the given format.  Once
    a handle has been given to the clipboard it should *not* be deleted.  It
    will be deleted by the clipboard.
  GetTextBuf - Retrieves
  AsText - Allows placing and retrieving text from the clipboard.  This property
    is valid to retrieve if the CF_UNICODETEXT format is available.
  FormatCount - The number of formats in the Formats array.
  Formats - A list of all the formats available on the clipboard. }

type
  [UIPermission(SecurityAction.LinkDemand, Clipboard=UIPermissionClipboard.AllClipboard)]
  TClipboard = class(TPersistent)
  private
    FOpenRefCount: Integer;
    FClipboardWindow: HWND;
    FAllocated: Boolean;
    FEmptied: Boolean;
    procedure Adding;
    procedure AssignGraphic(Source: TGraphic);
    procedure AssignPicture(Source: TPicture);
    procedure AssignToBitmap(Dest: TBitmap);
    procedure AssignToMetafile(Dest: TMetafile);
    procedure AssignToPicture(Dest: TPicture);
    function GetAsText: string;
    function GetClipboardWindow: HWND;
    function GetFormatCount: Integer;
    function GetFormats(Index: Integer): Word;
    procedure SetAsText(const Value: string);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure WndProc(var Message: TMessage); virtual;
    procedure MainWndProc(var Message: TMessage);
{$IF DEFINED(CLR)}
    procedure SetBuffer(Format: Word; Buffer: TBytes; Size: Integer);
{$ELSE}
    procedure SetBuffer(Format: Word; var Buffer; Size: Integer);
{$ENDIF}
    property Handle: HWND read GetClipboardWindow;
    property OpenRefCount: Integer read FOpenRefCount;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    procedure Close; virtual;
    function GetComponent(Owner, Parent: TComponent): TComponent;
    function GetAsHandle(Format: Word): THandle;
    function HasFormat(Format: Word): Boolean;
    procedure Open; virtual;
    procedure SetComponent(Component: TComponent);
    procedure SetAsHandle(Format: Word; Value: THandle);
{$IF DEFINED(CLR)}
    function GetTextBuf(var Buffer: string; BufSize: Integer): Integer;
    procedure SetTextBuf(const Buffer: string);
{$ELSE}
    function GetTextBuf(Buffer: PChar; BufSize: Integer): Integer;
    procedure SetTextBuf(Buffer: PChar);
{$ENDIF}
    property AsText: string read GetAsText write SetAsText;
    property FormatCount: Integer read GetFormatCount;
    property Formats[Index: Integer]: Word read GetFormats;
  end;

  EClipboardException = class(Exception);

function Clipboard: TClipboard;
function SetClipboard(NewClipboard: TClipboard): TClipboard;

implementation

uses
  Vcl.Forms, Vcl.Consts;

const
{$IF DEFINED(UNICODE)}
  CTextFormat = CF_UNICODETEXT;
{$ELSE}
  CTextFormat = CF_TEXT;
{$ENDIF}

procedure TClipboard.Clear;
begin
  Open;
  try
    EmptyClipboard;
  finally
    Close;
  end;
end;

procedure TClipboard.Adding;
begin
  if (FOpenRefCount <> 0) and not FEmptied then
  begin
    Clear;
    FEmptied := True;
  end;
end;

procedure TClipboard.Close;
begin
  if FOpenRefCount = 0 then
    Exit;
  Dec(FOpenRefCount);
  if FOpenRefCount = 0 then
  begin
    CloseClipboard;
    if FAllocated then
      DeallocateHWnd(FClipboardWindow);
    FClipboardWindow := 0;
  end;
end;

procedure TClipboard.Open;
begin
  if FOpenRefCount = 0 then
  begin
    FClipboardWindow := Application.Handle;
    if FClipboardWindow = 0 then
    begin
      FClipboardWindow := AllocateHWnd(MainWndProc);
      FAllocated := True;
    end;
    if not OpenClipboard(FClipboardWindow) then
      raise EClipboardException.CreateResFmt({$IFNDEF CLR}@{$ENDIF}SCannotOpenClipboard,
        [SysErrorMessage(GetLastError)]);
    FEmptied := False;
  end;
  Inc(FOpenRefCount);
end;

[SecurityPermission(SecurityAction.InheritanceDemand, UnmanagedCode=True)]
procedure TClipboard.WndProc(var Message: TMessage);
begin
  with Message do
    Result := DefWindowProc(FClipboardWindow, Msg, wParam, lParam);
end;

function TClipboard.GetComponent(Owner, Parent: TComponent): TComponent;
var
  Data: THandle;
  MemStream: TMemoryStream;
  Reader: TReader;
{$IF DEFINED(CLR)}
  DataPtr: IntPtr;
  Buffer: TBytes;
{$ELSE}
  DataPtr: Pointer;
{$ENDIF}
begin
  Result := nil;
  Open;
  try
    Data := GetClipboardData(CF_COMPONENT);
    if Data = 0 then
      Exit;
    DataPtr := GlobalLock(Data);
    if DataPtr = nil then
      Exit;
    try
      MemStream := TMemoryStream.Create;
      try
{$IF DEFINED(CLR)}
        SetLength(Buffer, GlobalSize(Data));
        Marshal.Copy(DataPtr, Buffer, 0, Length(Buffer));
        MemStream.WriteBuffer(Buffer, Length(Buffer));
{$ELSE}
        MemStream.WriteBuffer(DataPtr^, GlobalSize(Data));
{$ENDIF}
        MemStream.Position := 0;
        Reader := TReader.Create(MemStream, 256);
        try
          Reader.Parent := Parent;
          Result := Reader.ReadRootComponent(nil);
          try
            if Owner <> nil then
              Owner.InsertComponent(Result);
          except
            Result.Free;
            raise;
          end;
        finally
          Reader.Free;
        end;
      finally
        MemStream.Free;
      end;
    finally
      GlobalUnlock(Data);
    end;
  finally
    Close;
  end;
end;

{$IF DEFINED(CLR)}
procedure TClipboard.SetBuffer(Format: Word; Buffer: TBytes; Size: Integer);
var
  DataPtr: IntPtr;
{$ELSE}
procedure TClipboard.SetBuffer(Format: Word; var Buffer; Size: Integer);
var
  DataPtr: Pointer;
{$ENDIF}
  Data: THandle;
begin
  Open;
  try
    Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Size);
    try
      DataPtr := GlobalLock(Data);
      try
{$IF DEFINED(CLR)}
        Marshal.Copy(Buffer, 0, DataPtr, Size);
{$ELSE}
        Move(Buffer, DataPtr^, Size);
{$ENDIF}
        Adding;
        if SetClipboardData(Format, Data) = 0 then
          {$IF DEFINED(CLR)}
		  raise OutOfMemoryException.Create(SOutOfResources);
		  {$ELSE}
		  raise EOutOfResources.CreateRes(@SOutOfResources);
		  {$ENDIF}
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    Close;
  end;
end;

procedure TClipboard.SetComponent(Component: TComponent);
var
  MemStream: TMemoryStream;
begin
  MemStream := TMemoryStream.Create;
  try
    MemStream.WriteComponent(Component);
    SetBuffer(CF_COMPONENT, MemStream.Memory{$IFNDEF CLR}^{$ENDIF}, MemStream.Size);
  finally
    MemStream.Free;
  end;
end;

{$IF DEFINED(CLR)}
function TClipboard.GetTextBuf(var Buffer: string; BufSize: Integer): Integer;
begin
  Buffer := GetAsText;
  if Length(Buffer) > BufSize then
    SetLength(Buffer, BufSize);
  Result := Length(Buffer);
end;
{$ELSE}
function TClipboard.GetTextBuf(Buffer: PChar; BufSize: Integer): Integer;
var
  Data: THandle;
begin
  Open;
  try
    Data := GetClipboardData(CTextFormat);
    if Data = 0 then
      Result := 0
    else
    begin
      Result := StrLen(StrLCopy(Buffer, GlobalLock(Data), BufSize - 1));
      GlobalUnlock(Data);
    end;
  finally
    Close;
  end;
end;
{$ENDIF}

{$IF DEFINED(CLR)}
procedure TClipboard.SetTextBuf(const Buffer: string);
begin
  SetAsText(Buffer);
end;
{$ELSE}
procedure TClipboard.SetTextBuf(Buffer: PChar);
begin
  SetBuffer(CTextFormat, Buffer^, (StrLen(Buffer) * SizeOf(Char)) + SizeOf(Char));
end;
{$ENDIF}

function TClipboard.GetAsText: string;
var
  Data: THandle;
begin
  Open;
  Data := GetClipboardData(CTextFormat);
  try
    if Data <> 0 then
{$IF DEFINED(CLR)}
      Result := Marshal.PtrToStringUni(GlobalLock(Data))
{$ELSE}
      Result := PChar(GlobalLock(Data))
{$ENDIF}
    else
      Result := '';
  finally
    if Data <> 0 then
      GlobalUnlock(Data);
    Close;
  end;
end;

function TClipboard.GetClipboardWindow: HWND;
begin
  if FClipboardWindow = 0 then
    Open;
  Result := FClipboardWindow;
end;

procedure TClipboard.SetAsText(const Value: string);
{$IF NOT DEFINED(CLR)}
begin
  SetBuffer(CTextFormat, PChar(Value)^, ByteLength(Value) + SizeOf(Char));
{$ELSE}
var
  Buffer: TBytes;
begin
  Buffer := WideBytesOf(Value + #0);
  SetBuffer(CTextFormat, Buffer, Length(Buffer))
{$ENDIF}
end;

procedure TClipboard.AssignToPicture(Dest: TPicture);
var
  Data: THandle;
  Format: Word;
  Palette: HPALETTE;
begin
  Open;
  try
    Format := EnumClipboardFormats(0);
    while Format <> 0 do
    begin
      if TPicture.SupportsClipboardFormat(Format) then
      begin
        Data := GetClipboardData(Format);
        Palette := GetClipboardData(CF_PALETTE);
        Dest.LoadFromClipboardFormat(Format, Data, Palette);
        Exit;
      end;
      Format := EnumClipboardFormats(Format);
    end;
    raise EClipboardException.CreateRes({$IFNDEF CLR}@{$ENDIF}SInvalidClipFmt);
  finally
    Close;
  end;
end;

procedure TClipboard.AssignToBitmap(Dest: TBitmap);
var
  Data: THandle;
  Palette: HPALETTE;
begin
  Open;
  try
    Data := GetClipboardData(CF_BITMAP);
    Palette := GetClipboardData(CF_PALETTE);
    Dest.LoadFromClipboardFormat(CF_BITMAP, Data, Palette);
  finally
    Close;
  end;
end;

procedure TClipboard.AssignToMetafile(Dest: TMetafile);
var
  Data: THandle;
  Palette: HPALETTE;
begin
  Open;
  try
    Data := GetClipboardData(CF_METAFILEPICT);
    Palette := GetClipboardData(CF_PALETTE);
    Dest.LoadFromClipboardFormat(CF_METAFILEPICT, Data, Palette);
  finally
    Close;
  end;
end;

procedure TClipboard.AssignTo(Dest: TPersistent);
begin
  if Dest is TPicture then
    AssignToPicture(TPicture(Dest))
  else if Dest is TBitmap then
    AssignToBitmap(TBitmap(Dest))
  else if Dest is TMetafile then
    AssignToMetafile(TMetafile(Dest))
  else inherited AssignTo(Dest);
end;

procedure TClipboard.AssignPicture(Source: TPicture);
var
  Data: THandle;
  Format: Word;
  Palette: HPALETTE;
begin
  Open;
  try
    Adding;
    Palette := 0;
    Source.SaveToClipboardFormat(Format, Data, Palette);
    SetClipboardData(Format, Data);
    if Palette <> 0 then
      SetClipboardData(CF_PALETTE, Palette);
  finally
    Close;
  end;
end;

procedure TClipboard.AssignGraphic(Source: TGraphic);
var
  Data: THandle;
  Format: Word;
  Palette: HPALETTE;
begin
  Open;
  try
    Adding;
    Palette := 0;
    Source.SaveToClipboardFormat(Format, Data, Palette);
    SetClipboardData(Format, Data);
    if Palette <> 0 then SetClipboardData(CF_PALETTE, Palette);
  finally
    Close;
  end;
end;

procedure TClipboard.Assign(Source: TPersistent);
begin
  if Source is TPicture then
    AssignPicture(TPicture(Source))
  else if Source is TGraphic then
    AssignGraphic(TGraphic(Source))
  else inherited Assign(Source);
end;

function TClipboard.GetAsHandle(Format: Word): THandle;
begin
  Open;
  try
    Result := GetClipboardData(Format);
  finally
    Close;
  end;
end;

procedure TClipboard.SetAsHandle(Format: Word; Value: THandle);
begin
  Open;
  try
    Adding;
    SetClipboardData(Format, Value);
  finally
    Close;
  end;
end;

function TClipboard.GetFormatCount: Integer;
begin
  Result := CountClipboardFormats;
end;

function TClipboard.GetFormats(Index: Integer): Word;
begin
  Open;
  try
    Result := EnumClipboardFormats(0);
    while Index > 0 do
    begin
      Dec(Index);
      Result := EnumClipboardFormats(Result);
    end;
  finally
    Close;
  end;
end;

function TClipboard.HasFormat(Format: Word): Boolean;

  function HasAPicture: Boolean;
  var
    Format: Word;
  begin
    Open;
    try
      Result := False;
      Format := EnumClipboardFormats(0);
      while Format <> 0 do
        if TPicture.SupportsClipboardFormat(Format) then
        begin
          Result := True;
          Break;
        end
        else Format := EnumClipboardFormats(Format);
    finally
      Close;
    end;
  end;

begin
  Result := IsClipboardFormatAvailable(Format) or ((Format = CF_PICTURE) and HasAPicture);
end;


var
  FClipboard: TClipboard;

[UIPermission(SecurityAction.LinkDemand, Clipboard=UIPermissionClipboard.AllClipboard)]
function Clipboard: TClipboard;
begin
  if FClipboard = nil then
    FClipboard := TClipboard.Create;
  Result := FClipboard;
end;

[UIPermission(SecurityAction.LinkDemand, Clipboard=UIPermissionClipboard.AllClipboard)]
function SetClipboard(NewClipboard: TClipboard): TClipboard;
begin
  Result := FClipboard;
  FClipboard := NewClipboard;
end;

procedure TClipboard.MainWndProc(var Message: TMessage);
begin
  try
    WndProc(Message);
  except
    if Assigned(ApplicationHandleException) then
      ApplicationHandleException(Self)
    else
      raise;
  end;
end;

destructor TClipboard.Destroy;
begin
  if (FClipboard = Self) then
    FClipboard := nil;
  inherited Destroy;
end;

initialization
  CF_PICTURE := RegisterClipboardFormat('Delphi Picture'); { Do not localize }
  CF_COMPONENT := RegisterClipboardFormat('Delphi Component'); { Do not localize }
  FClipboard := nil;

{$IF NOT DEFINED(CLR)}
finalization
  FClipboard.Free;
{$ENDIF}
end.



