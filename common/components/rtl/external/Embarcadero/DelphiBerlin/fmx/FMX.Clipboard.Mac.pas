{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Clipboard.Mac;

interface

{$SCOPEDENUMS ON}

implementation

uses
  System.Rtti, System.Classes, System.Generics.Collections, System.SysUtils,
  Macapi.Foundation, Macapi.ObjectiveC, Macapi.AppKit, Macapi.Helpers,
  FMX.Platform, FMX.Clipboard, FMX.Surfaces, FMX.Graphics, FMX.Consts;

type
  TOSXClipboardService = class(TInterfacedObject, IFMXClipboardService, IFMXExtendedClipboardService)
  private
    FClipboardFormats: TDictionary<string, NSString>;
    procedure SetPNGClipboard(const AMemory: Pointer; const ASize: Cardinal);
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

  TPointerStream = class(TCustomMemoryStream)
  public
    constructor Create(Ptr: Pointer; Size: NativeInt); overload;
  end;


var
  OSXClipboard: TOSXClipboardService;

procedure RegisterService;
begin
  OSXClipboard := TOSXClipboardService.Create;
  TPlatformServices.Current.AddPlatformService(IFMXClipboardService, OSXClipboard);
  TPlatformServices.Current.AddPlatformService(IFMXExtendedClipboardService, OSXClipboard);
end;

procedure UnregisterService;
begin
  if TPlatformServices.Current <> nil then
  begin
    TPlatformServices.Current.RemovePlatformService(IFMXClipboardService);
    TPlatformServices.Current.RemovePlatformService(IFMXExtendedClipboardService);
  end;
end;


{ TPointerStream }

constructor TPointerStream.Create(Ptr: Pointer; Size: NativeInt);
begin
  inherited Create;
  SetPointer(Ptr, Size);
end;

{ TOSXClipboardService }

procedure TOSXClipboardService.SetPNGClipboard(const AMemory: Pointer; const ASize: Cardinal);
var
  AutoReleasePool: NSAutoReleasePool;
  Pasteboard: NSPasteboard;
  types: NSArray;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    Pasteboard.clearContents;
    types := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject((NSPasteboardTypePNG as ILocalObject).GetObjectID));
    Pasteboard.declareTypes(types, (Pasteboard as ILocalObject).GetObjectID);
    Pasteboard.setData(TNSData.Wrap(TNSData.OCClass.dataWithBytes(AMemory, ASize)), NSPasteboardTypePNG);
  finally
    AutoReleasePool.release;
  end;
end;

procedure TOSXClipboardService.CheckDictionary;
begin
  if FClipboardFormats = nil then
    FClipboardFormats := TDictionary<string, NSString>.Create;
end;

destructor TOSXClipboardService.Destroy;
begin
  FClipboardFormats.Free;
  inherited;
end;

function TOSXClipboardService.GetClipboard: TValue;
begin
  Result := TValue.Empty;
  if HasText then
    Result := GetText
  else if HasImage then
    Result := GetImage;
end;

procedure TOSXClipboardService.SetClipboard(Value: TValue);
var
  PNGStream: TMemoryStream;
begin
  if Value.IsType<TBitmap> then
  begin
    PNGStream := TMemoryStream.Create;
    try
      //Saving to stream without converting it to PNG SaveToStream doing it
      Value.AsType<TBitmap>.SaveToStream(PNGStream);
      SetPNGClipboard(PNGStream.Memory, PNGStream.Size);
    finally
      PNGStream.Free;
    end;
  end
  else if Value.IsType<TBitmapSurface> then
    SetImage(Value.AsType<TBitmapSurface>)
  else if not Value.IsEmpty then
    SetText(Value.ToString);
end;

function TOSXClipboardService.HasText: Boolean;
var
  AutoReleasePool: NSAutoreleasePool;
  Pasteboard: NSPasteboard;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    Result := Pasteboard.stringForType(NSPasteboardTypeString) <> nil;
  finally
    AutoReleasePool.release;
  end;
end;

function TOSXClipboardService.GetText: string;
var
  TextData: string;
  Pasteboard: NSPasteboard;
  StrData: NSString;
  AutoReleasePool: NSAutoreleasePool;
begin
  Result := string.Empty;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    StrData := Pasteboard.stringForType(NSPasteboardTypeString);
    if StrData <> nil then
    begin
      TextData := NSStrToStr(StrData);
      Result := TextData;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TOSXClipboardService.SetText(const Value: string);
var
  AutoReleasePool: NSAutoReleasePool;
  Pasteboard: NSPasteboard;
  types: NSArray;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    Pasteboard.clearContents;
    types := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject((NSPasteboardTypeString as ILocalObject).GetObjectID));
    Pasteboard.declareTypes(types, (Pasteboard as ILocalObject).GetObjectID);
    Pasteboard.setString(StrToNSStr(Value), NSPasteboardTypeString);
  finally
    AutoReleasePool.release;
  end;
end;

function TOSXClipboardService.HasImage: Boolean;
var
  AutoReleasePool: NSAutoreleasePool;
  Pasteboard: NSPasteboard;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    Result := (Pasteboard.dataForType(NSPasteboardTypePNG) <> nil) or (Pasteboard.dataForType(NSPasteboardTypeTIFF) <> nil);
  finally
    AutoReleasePool.release;
  end;
end;

function TOSXClipboardService.GetImage: TBitmapSurface;
var
  Pasteboard: NSPasteboard;
  AutoReleasePool: NSAutoreleasePool;
  ImageData: NSData;
  ImageStream: TPointerStream;
  BitmapSurface: TBitmapSurface;
begin
  Result := nil;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    ImageData := Pasteboard.dataForType(NSPasteboardTypePNG);
    if ImageData = nil then
      ImageData := Pasteboard.dataForType(NSPasteboardTypeTIFF);
    if ImageData <> nil then
    begin
      ImageStream := TPointerStream.Create(ImageData.bytes, ImageData.length);
      try
        BitmapSurface := TBitmapSurface.Create;
        try
          if TBitmapCodecManager.LoadFromStream(ImageStream, BitmapSurface) then
            Result := BitmapSurface
          else
            BitmapSurface.Free;
        except
          BitmapSurface.Free;
        end;
      finally
        ImageStream.Free;
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TOSXClipboardService.SetImage(const Value: TBitmapSurface);
var
  PNGStream: TMemoryStream;
begin
  PNGStream := TMemoryStream.Create;
  try
    TBitmapCodecManager.SaveToStream(PNGStream, Value, SPNGImageExtension);
    SetPNGClipboard(PNGStream.Memory, PNGStream.Size);
  finally
    PNGStream.Free;
  end;
end;

procedure TOSXClipboardService.RegisterCustomFormat(const AFormatName: string);
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);

  CheckDictionary;
  if FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatRegisterError.Create(Format(SFormatAlreadyRegistered, [AFormatName]));

  FClipboardFormats.Add(AFormatName, StrToNSStr(AFormatName));
end;

function TOSXClipboardService.IsCustomFormatRegistered(const AFormatName: string): Boolean;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);

  CheckDictionary;
  Result := FClipboardFormats.ContainsKey(AFormatName);
end;

procedure TOSXClipboardService.UnregisterCustomFormat(const AFormatName: string);
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);

  CheckDictionary;
  if FClipboardFormats.ContainsKey(AFormatName) then
    FClipboardFormats.Remove(AFormatName)
  else
    raise EClipboardFormatNotRegistered.Create(Format(SFormatWasNotRegistered, [AFormatName]));
end;

function TOSXClipboardService.HasCustomFormat(const AFormatName: string): Boolean;
var
  AutoReleasePool: NSAutoreleasePool;
  Pasteboard: NSPasteboard;
begin
  CheckDictionary;
  if not FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatNotRegistered.Create(AFormatName);

  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    Result := Pasteboard.dataForType(FClipboardFormats[AFormatName]) <> nil;
  finally
    AutoReleasePool.release;
  end;
end;

function TOSXClipboardService.GetCustomFormat(const AFormatName: string; const AStream: TStream): Boolean;
var
  AutoReleasePool: NSAutoreleasePool;
  Pasteboard: NSPasteboard;
  CustomData: NSData;
  DataStream: TPointerStream;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);
  if AStream = nil then
    raise EArgumentNilException.Create(SStreamCannotBeNil);

  CheckDictionary;
  if not FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatNotRegistered.Create(AFormatName);

  Result := False;
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    CustomData := Pasteboard.dataForType(FClipboardFormats[AFormatName]);
    if CustomData <> nil then
    begin
      DataStream := TPointerStream.Create(CustomData.bytes, CustomData.length);
      try
        AStream.CopyFrom(DataStream, DataStream.Size);
        Result := True;
      finally
        DataStream.Free;
      end;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TOSXClipboardService.SetCustomFormat(const AFormatName: string; const AStream: TStream);
var
  AutoReleasePool: NSAutoreleasePool;
  Pasteboard: NSPasteboard;
  types: NSArray;
  MemoryStream: TMemoryStream;
begin
  if AFormatName.IsEmpty then
    raise EArgumentException.Create(SFormatNameCannotBeEmpty);
  if AStream = nil then
    raise EArgumentNilException.Create(SStreamCannotBeNil);

  CheckDictionary;
  if not FClipboardFormats.ContainsKey(AFormatName) then
    raise EClipboardFormatNotRegistered.Create(AFormatName);

  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Pasteboard := TNSPasteboard.Wrap(TNSPasteboard.OCClass.generalPasteboard);
    Pasteboard.clearContents;
    types := TNSArray.Wrap(TNSArray.OCClass.arrayWithObject((FClipboardFormats[AFormatName] as ILocalObject).GetObjectID));
    Pasteboard.declareTypes(types, (Pasteboard as ILocalObject).GetObjectID);
    MemoryStream := TMemoryStream.Create;
    try
      MemoryStream.CopyFrom(AStream, AStream.Size - AStream.Position);
      MemoryStream.Position := 0;
      Pasteboard.setData(TNSData.Wrap(TNSData.OCClass.dataWithBytes(MemoryStream.Memory, MemoryStream.Size)), FClipboardFormats[AFormatName]);
    finally
      MemoryStream.Free;
    end;
  finally
    AutoReleasePool.release;
  end;
end;

initialization
  RegisterService;
finalization
  UnregisterService;
end.

