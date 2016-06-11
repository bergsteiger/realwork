{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Clipboard.Win;

interface

{$SCOPEDENUMS ON}

implementation

uses
  System.Rtti, System.Classes, System.Generics.Collections, System.Types, System.SysUtils,
  Winapi.Windows,
  FMX.Platform, FMX.Clipboard, FMX.Surfaces, FMX.Graphics, FMX.Utils, FMX.Types, FMX.Consts, FMX.Helpers.Win;


type
  TWindowsClipboardService = class(TInterfacedObject, IFMXClipboardService, IFMXExtendedClipboardService)
  private
    FClipboardFormats: TDictionary<string, Cardinal>;
    procedure CheckDictionary;
  public
    destructor Destroy; override;
    { IFMXClipboardService }
    function GetClipboard: TValue;
    procedure SetClipboard(Value: TValue);
    { IFMXExtendedClipboardService }
    function HasText: Boolean;
    function GetText: string;
    procedure SetText(const Value: string);
    function HasImage: Boolean;
    function GetImage: TBitmapSurface;
    procedure SetImage(const Value: TBitmapSurface);
    procedure RegisterCustomFormat(const AFormatName: string);
    function IsCustomFormatRegistered(const AFormatName: string): Boolean;
    procedure UnregisterCustomFormat(const AFormatName: string);
    function HasCustomFormat(const AFormatName: string): Boolean;
    function GetCustomFormat(const AFormatName: string; const AStream: TStream): Boolean;
    procedure SetCustomFormat(const AFormatName: string; const AStream: TStream);
  end;

var
  WindowsClipboard: TWindowsClipboardService;

procedure RegisterService;
begin
  WindowsClipboard := TWindowsClipboardService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXClipboardService, WindowsClipboard);
  TPlatformServices.Current.AddPlatformService(IFMXExtendedClipboardService, WindowsClipboard);
end;

procedure UnregisterService;
begin
  if TPlatformServices.Current <> nil then
  begin
    TPlatformServices.Current.RemovePlatformService(IFMXClipboardService);
    TPlatformServices.Current.RemovePlatformService(IFMXExtendedClipboardService);
  end;
end;

{ TWindowsClipbardService }

destructor TWindowsClipboardService.Destroy;
begin
  FClipboardFormats.Free;
  inherited;
end;

procedure TWindowsClipboardService.CheckDictionary;
begin
  if FClipboardFormats = nil then
    FClipboardFormats := TDictionary<string, Cardinal>.Create;
end;

function TWindowsClipboardService.GetClipboard: TValue;
begin
  Result := TValue.Empty;
  if HasText then
    Result := GetText
  else if HasImage then
    Result := GetImage;
end;

procedure TWindowsClipboardService.SetClipboard(Value: TValue);
var
  Data: THandle;
  DataPtr: Pointer;
  Bitmap: TBitmap;
  BitmapHeader: TBitmapInfoHeader;
  BitmapData: TBitmapData;
  I, J: Integer;
  DIBDataPtr: Pointer;
begin
  if Value.IsType<TBitmap> then
  begin
    OpenClipboard(0);
    EmptyClipboard;
    try
      FillChar(BitmapHeader, SizeOf(BitmapHeader), 0);
      BitmapHeader.biSize := SizeOf(TBitmapInfoHeader);
      BitmapHeader.biPlanes := 1;
      BitmapHeader.biBitCount := 32;
      BitmapHeader.biCompression := BI_RGB;

      Bitmap := Value.AsType<TBitmap>();
      BitmapHeader.biWidth := Bitmap.Width;
      BitmapHeader.biHeight := Bitmap.Height;
      BitmapHeader.biSizeImage := Bitmap.BytesPerPixel * Bitmap.Width * Bitmap.Height;

      if BitmapHeader.biWidth <= 0 then
        BitmapHeader.biWidth := 1;
      if BitmapHeader.biHeight <= 0 then
        BitmapHeader.biHeight := 1;

      Data := GlobalAlloc(GMEM_MOVEABLE, BitmapHeader.biWidth * Abs(BitmapHeader.biHeight) * 4 + SizeOf(BitmapHeader));
      try
        DataPtr := GlobalLock(Data);
        try
          Move(BitmapHeader, DataPtr^, SizeOf(BitmapHeader));
          DIBDataPtr := @(PByteArray(DataPtr)[SizeOf(BitmapHeader)]);

          if Bitmap.Map(TMapAccess.Read, BitmapData) then
          try
            if BitmapData.PixelFormat = TPixelFormat.BGRA then
              for I := 0 to Bitmap.Height - 1 do
                Move(PAlphaColorArray(BitmapData.Data)[I * (BitmapData.Pitch div 4)],
                  PAlphaColorArray(DIBDataPtr)[(Bitmap.Height - 1 - I) * Bitmap.Width], Bitmap.Width * 4)
            else
              for I := 0 to Bitmap.Height - 1 do
                for J := 0 to Bitmap.Width - 1 do
                  PAlphaColorArray(DIBDataPtr)[(Bitmap.Height - 1 - I) * Bitmap.Width + J] :=
                    BitmapData.GetPixel(J, I);
          finally
            Bitmap.Unmap(BitmapData);
          end;
        finally
          GlobalUnlock(Data);
        end;
        SetClipboardData(CF_DIB, Data);
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipboard;
    end;
  end
  else if Value.IsType<TBitmapSurface> then
    SetImage(Value.AsType<TBitmapSurface>)
  else if not Value.IsEmpty then
    SetText(Value.ToString);
end;

function TWindowsClipboardService.HasText: Boolean;
begin
  Result := IsClipboardFormatAvailable(CF_UNICODETEXT);
end;

function TWindowsClipboardService.GetText: string;
var
  Data: THandle;
  TextData: string;
begin
  Result := string.Empty;
  OpenClipboard(0);
  try
    Data := GetClipboardData(CF_UNICODETEXT);
    if Data <> 0 then
    begin
      TextData := PChar(GlobalLock(Data));
      try
        Result := TextData;
      finally
        GlobalUnlock(Data);
      end;
    end;
  finally
    CloseClipboard;
  end;
end;

procedure TWindowsClipboardService.SetText(const Value: string);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  OpenClipboard(0);
  EmptyClipboard;
  try
    Data := GlobalAlloc(GMEM_MOVEABLE, (Length(Value) + 1) * 2);
    try
      DataPtr := GlobalLock(Data);
      try
        Move(PChar(Value)^, DataPtr^, GlobalSize(Data));
        SetClipboardData(CF_UNICODETEXT, Data);
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    CloseClipboard;
  end;
end;

function TWindowsClipboardService.HasImage: Boolean;
begin
  Result := IsClipboardFormatAvailable(CF_DIB);
end;

function TWindowsClipboardService.GetImage: TBitmapSurface;
var
  Data: THandle;
  DataPtr: Pointer;
begin
  Result := nil;
  OpenClipboard(0);
  try
    Data := GetClipboardData(CF_DIB);
    if Data <> 0 then
    begin
      DataPtr := GlobalLock(Data);
      try
        Result := DIBDataToBitmapSurface(DataPtr);
      finally
        GlobalUnlock(Data);
      end;
    end;
  finally
    CloseClipboard;
  end;
end;

procedure TWindowsClipboardService.SetImage(const Value: TBitmapSurface);
var
  Data: THandle;
  DataPtr: Pointer;
  BitmapHeader: TBitmapInfoHeader;
  I, J: Integer;
  DIBDataPtr: Pointer;
begin
  OpenClipboard(0);
  EmptyClipboard;
  try
    FillChar(BitmapHeader, SizeOf(BitmapHeader), 0);
    BitmapHeader.biSize := SizeOf(TBitmapInfoHeader);
    BitmapHeader.biPlanes := 1;
    BitmapHeader.biBitCount := 32;
    BitmapHeader.biCompression := BI_RGB;

    BitmapHeader.biWidth := Value.Width;
    BitmapHeader.biHeight := Value.Height;
    BitmapHeader.biSizeImage := Value.BytesPerPixel * Value.Width * Value.Height;

    if BitmapHeader.biWidth <= 0 then
      BitmapHeader.biWidth := 1;
    if BitmapHeader.biHeight <= 0 then
      BitmapHeader.biHeight := 1;

    Data := GlobalAlloc(GMEM_MOVEABLE, BitmapHeader.biWidth * Abs(BitmapHeader.biHeight) * 4 + SizeOf(BitmapHeader));
    try
      DataPtr := GlobalLock(Data);
      try
        Move(BitmapHeader, DataPtr^, SizeOf(BitmapHeader));
        DIBDataPtr := @(PByteArray(DataPtr)[SizeOf(BitmapHeader)]);

        if Value.PixelFormat = TPixelFormat.BGRA then
          for I := 0 to Value.Height - 1 do
            Move(Value.Scanline[I]^,
              PAlphaColorArray(DIBDataPtr)[(Value.Height - 1 - I) * Value.Width], Value.Width * 4)
        else
          for I := 0 to Value.Height - 1 do
            for J := 0 to Value.Width - 1 do
              PAlphaColorArray(DIBDataPtr)[(Value.Height - 1 - I) * Value.Width + J] := Value.Pixels[J, I];
      finally
        GlobalUnlock(Data);
      end;
      SetClipboardData(CF_DIB, Data);
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    CloseClipboard;
  end;
end;

procedure TWindowsClipboardService.RegisterCustomFormat(const AFormatName: string);
var
  ID: Cardinal;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);

  CheckDictionary;
  if FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatRegisterError.Create(Format(SFormatAlreadyRegistered, [AFormatName]));

  ID := RegisterClipboardFormat(PChar(AFormatName));
  if ID > 0 then
    FClipboardFormats.Add(AFormatName, ID)
  else
    raise EClipboardFormatRegisterError.Create(SysErrorMessage(GetLastError));
end;

function TWindowsClipboardService.IsCustomFormatRegistered(const AFormatName: string): Boolean;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);

  CheckDictionary;
  Result := FClipboardFormats.ContainsKey(AFormatName);
end;

procedure TWindowsClipboardService.UnregisterCustomFormat(const AFormatName: string);
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);

  CheckDictionary;
  if FClipboardFormats.ContainsKey(AFormatName) then
    FClipboardFormats.Remove(AFormatName)
  else
    raise EClipboardFormatNotRegistered.Create(Format(SFormatWasNotRegistered, [AFormatName]));
end;

function TWindowsClipboardService.HasCustomFormat(const AFormatName: string): Boolean;
begin
  CheckDictionary;
  if not FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatNotRegistered.Create(AFormatName);

  Result := IsClipboardFormatAvailable(FClipboardFormats[AFormatName]);
end;

function TWindowsClipboardService.GetCustomFormat(const AFormatName: string; const AStream: TStream): Boolean;
var
  Data: THandle;
  DataPtr: Pointer;
  SourcePosition: Int64;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);
  if AStream = nil then
    raise EArgumentNilException.Create(SStreamCannotBeNil);

  CheckDictionary;
  if not FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatNotRegistered.Create(AFormatName);

  Result := False;
  if IsClipboardFormatAvailable(FClipboardFormats[AFormatName]) then
  begin
    OpenClipboard(0);
    try
      Data := GetClipboardData(FClipboardFormats[AFormatName]);
      if Data <> 0 then
      begin
        DataPtr := GlobalLock(Data);
        try
          SourcePosition := AStream.Position;
          AStream.Write(DataPtr^, GlobalSize(Data));
          AStream.Position := SourcePosition;
          Result := True;
        finally
          GlobalUnlock(Data);
        end;
      end;
    finally
      CloseClipboard;
    end;
  end;
end;

procedure TWindowsClipboardService.SetCustomFormat(const AFormatName: string; const AStream: TStream);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);
  if AStream = nil then
    raise EArgumentNilException.Create(SStreamCannotBeNil);

  CheckDictionary;
  if not FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatNotRegistered.Create(AFormatName);

  OpenClipboard(0);
  try
    EmptyClipboard;
    Data := GlobalAlloc(GMEM_MOVEABLE, AStream.Size - AStream.Position);
    try
      DataPtr := GlobalLock(Data);
      try
        AStream.Read(DataPtr^, AStream.Size - AStream.Position);
        SetClipboardData(FClipboardFormats[AFormatName], Data);
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    CloseClipboard;
  end;
end;


initialization
  RegisterService;
finalization
  UnregisterService;
end.
