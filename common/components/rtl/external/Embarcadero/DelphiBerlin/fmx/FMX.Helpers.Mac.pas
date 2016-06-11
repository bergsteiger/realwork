{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Helpers.Mac;

interface

{$SCOPEDENUMS ON}

uses
  Macapi.Foundation, Macapi.AppKit, Macapi.CocoaTypes, System.UITypes, System.Classes, System.Messaging, FMX.Graphics,
  FMX.ImgList, FMX.Surfaces;


{ Date Time }

function GetTimeZone: Integer;
function DateTimeToNSDate(const ADateTime: TDateTime): NSDate;
function NSDateToDateTime(const ADateTime: NSDate): TDateTime;
function GetGMTDateTime(const ADateTime: TDateTime): TDateTime;
function IsZoomed(const NSWin: NSWindow): Boolean; inline;

function ShiftStateFromModFlags(M: NSUInteger): TShiftState;
procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
procedure ShortCutToMacKey(ShortCut: TShortCut; var Key: Char; var ModifierMask: NSUInteger);
function ShortCutToText(ShortCut: TShortCut): string;
function TextToShortCut(Text: string): Integer;
procedure HandleException(const SenderOfException: TObject);

function BitmapToMacBitmap(const Bitmap: TBitmap): NSImage;
function BitmapToMenuBitmap(const Bitmap: TBitmap; const MaxBitmapSize: Integer = 24): NSImage;
function ImageListToMenuBitmap(const Images: TCustomImageList; const Index: Integer): NSImage;
function NativeViewToSurface(const ANativeView: NSView; const ASurface: TBitmapSurface): Boolean;

type
  TOSXMessageObject = class
  private
    FReturnValue: NSObject;
    FNSSender: NSObject;
  public
    constructor Create(ASender: NSObject);
    property Sender: NSObject read FNSSender;
    property ReturnValue: NSObject read FReturnValue write FReturnValue;
  end;

  TOSXMessage = class(TObjectMessage<TOSXMessageObject>);
  TApplicationDockMenuMessage = class(TOSXMessage);
  TApplicationWillTerminateMessage = class(TOSXMessage);
  TApplicationMenuClickedMessage = class(TOSXMessage);
  TApplicationDidFinishLaunchingMessage = class(TOSXMessage);
  TOSXMessageClass = class of TOSXMessage;

implementation

uses
  System.RTLConsts, System.SysUtils, System.Types, System.Math, System.Math.Vectors, FMX.Consts, FMX.Forms,
  Macapi.CoreGraphics, FMX.Types;

function GetTimeZone: Integer;
begin
  Result := TNSTimeZone.Wrap(TNSTimeZone.OCClass.localTimeZone).secondsFromGMT div SecsPerHour;
end;

function DateTimeToNSDate(const ADateTime: TDateTime): NSDate;
var
  IntervalInterval: NSTimeInterval;
begin
  IntervalInterval := (ADateTime - EncodeDate(2001, 1, 1)) * SecsPerDay;
  Result := TNSDate.Wrap(TNSDate.OCClass.dateWithTimeIntervalSinceReferenceDate(IntervalInterval));
end;

function NSDateToDateTime(const ADateTime: NSDate): TDateTime;
begin
  Result := (ADateTime.TimeIntervalSince1970 + GetTimeZone) / SecsPerDay + EncodeDate(1970, 1, 1);
end;

function GetGMTDateTime(const ADateTime: TDateTime): TDateTime;
begin
  if GetTimeZone > 0 then
    Result := ADateTime - EncodeTime(GetTimeZone, 0, 0, 0)
  else
    Result := ADateTime + EncodeTime(Abs(GetTimeZone), 0, 0, 0);
end;

function IsZoomed(const NSWin: NSWindow): Boolean;
var
  Frame, WorkFrame: NsRect;
  LScreen: NSScreen;
begin
  Result := (NSWin.styleMask and NSFullScreenWindowMask) <> 0;
  if not Result then
  begin
    Result := NSWin.isZoomed;
    if Result then
    begin
      LScreen := NSWin.screen;
      if LScreen <> nil then
      begin
        Frame := NSWin.frame;
        WorkFrame := LScreen.visibleFrame;
        Result := SameValue(Frame.size.width, WorkFrame.size.width, TEpsilon.FontSize) and
          SameValue(Frame.size.height, WorkFrame.size.height, TEpsilon.FontSize);
      end
      else
        Result := False;
    end;
  end;
end;

function ShiftStateFromModFlags(M: NSUInteger): TShiftState;
begin
  Result := [];
  if M and NSShiftKeyMask = NSShiftKeyMask then
  begin
    Include(Result, ssShift);
    M := M and not NSShiftKeyMask;
  end;
  if M and NSControlKeyMask = NSControlKeyMask then
  begin
    Include(Result, ssCtrl);
    M := M and not NSControlKeyMask;
  end;
  if M and NSAlternateKeyMask = NSAlternateKeyMask then
  begin
    Include(Result, ssAlt);
    M := M and not NSAlternateKeyMask;
  end;
  if M and NSCommandKeyMask = NSCommandKeyMask then
  begin
    Include(Result, ssCommand);
  end;
end;

procedure ShortCutToKey(ShortCut: TShortCut; var Key: Word; var Shift: TShiftState);
var
  K: Char;
  KByte: byte;
  ModifierMask: NSUInteger;
begin
  KByte := Lo(ShortCut);
  ModifierMask := 0;

  K := Chr(KByte);
  Key := Word(K);
  if ShortCut and scCommand <> 0 then
    ModifierMask := ModifierMask or NSCommandKeyMask;
  if ShortCut and scShift <> 0 then
    ModifierMask := ModifierMask or NSShiftKeyMask;
  if ShortCut and scCtrl <> 0 then
    ModifierMask := ModifierMask or NSControlKeyMask;
  if ShortCut and scAlt <> 0 then
    ModifierMask := ModifierMask or NSAlternateKeyMask;

  Shift := ShiftStateFromModFlags(ModifierMask);
end;

function VirtualKeyToText(ShortCut: TShortCut): string;
var
  Key: byte;
begin
  Result := '';
  Key := Lo(Word(ShortCut));
  if Key > 0 then
    case Key of
      vkBack:
        Result := SmkcBkSp; // (NSBackspaceCharacter);
      vkTab:
        Result := SmkcTab; // (NSTabCharacter);
      vkEscape:
        Result := SmkcEsc;
      vkReturn:
        Result := SmkcEnter; // (NSCarriageReturnCharacter);
      vkPrior:
        Result := SmkcPgUp; // (NSPageUpFunctionKey);
      vkNext:
        Result := SmkcPgDn; // (NSPageDownFunctionKey);
      vkEnd:
        Result := SmkcEnd; // (NSEndFunctionKey);
      vkHome:
        Result := SmkcHome; // (NSHomeFunctionKey);
      vkLeft:
        Result := SmkcLeft; // (NSLeftArrowFunctionKey);
      vkUp:
        Result := SmkcUp; // (NSUpArrowFunctionKey);
      vkRight:
        Result := SmkcRight; // (NSRightArrowFunctionKey);
      vkDown:
        Result := SmkcDown; // (NSDownArrowFunctionKey);
      vkDelete:
        Result := SmkcDel; // (NSDeleteCharacter);
      vkNumLock:
        Result := SmkcNumLock;
      vkSemicolon:
        Result := ';';
      vkEqual:
        Result := '=';
      vkComma:
        Result := ',';
      vkMinus:
        Result := '-';
      vkPeriod:
        Result := '.';
      vkSlash:
        Result := '/';
      vkTilde:
        Result := '~';
      vkLeftBracket:
        Result := '[';
      vkBackslash:
        Result := '\';
      vkRightBracket:
        Result := ']';
      vkQuote:
        Result := '''';
      vkPara:
        Result := SmkcPara;
      vkCamera:
        Result := SmkcCamera;
      vkBrowserBack:
        Result := SmkcBrowserBack;
      vkHardwareBack:
        Result := SmkcHardwareBack;
      vkPause:
        Result := SmkcPause;
      vkSpace:
        Result := SmkcSpace;
      vkOem102:
        Result := SmkcOem102;
      vkNumpad0 .. vkDivide:
        case Key of
          vkNumpad0 .. vkNumpad9:
            Result := Format(SmkcNum, [Chr(Ord('0') + Key - vkNumpad0)]);
          vkMultiply:
            Result := Format(SmkcNum, ['*']);
          vkAdd:
            Result := Format(SmkcNum, ['+']);
          vkSeparator:
            Result := Format(SmkcNum, [',']);
          vkSubtract:
            Result := Format(SmkcNum, ['-']);
          vkDecimal:
            Result := Format(SmkcNum, ['.']);
          vkDivide:
            Result := Format(SmkcNum, ['/']);
        end;
      vk0 .. vk9:
        Result := Chr(Key);
      vkA .. vkZ:
        Result := Chr(Key);
      vkF1 .. vkF24:
        Result := 'F' + IntToStr(Key - vkF1 + 1); // (NSF1FunctionKey+Ord(Key)-$70);
    else
      if Key < $21 then
        Result := Chr($2400 + Key)
      else
        Result := '(' + Inttostr(Key) + ')';
    end;
end;

procedure ShortCutToMacKey(ShortCut: TShortCut; var Key: Char; var ModifierMask: NSUInteger);
var
  K: byte;
  S: string;
begin
  K := Lo(ShortCut);
  ModifierMask := 0;
  case K of
    vkBack:
      Key := Char(NSBackspaceCharacter);
    vkTab:
      Key := Char(NSTabCharacter);
    vkReturn:
      Key := Char(NSCarriageReturnCharacter);
    vkPrior:
      Key := Char(NSPageUpFunctionKey);
    vkNext:
      Key := Char(NSPageDownFunctionKey);
    vkEnd:
      Key := Char(NSEndFunctionKey);
    vkHome:
      Key := Char(NSHomeFunctionKey);
    vkLeft:
      Key := Char(NSLeftArrowFunctionKey);
    vkUp:
      Key := Char(NSUpArrowFunctionKey);
    vkRight:
      Key := Char(NSRightArrowFunctionKey);
    vkDown:
      Key := Char(NSDownArrowFunctionKey);
    vkDelete:
      Key := Char(NSDeleteCharacter);
    vkF1 .. vkF24:
      Key := Char(NSF1FunctionKey + (K - vkF1));
    vkA .. vkZ:
      if ShortCut and scShift <> 0 then
        Key := Chr(K)
      else
      begin
        S := Chr(K);
        S := LowerCase(S);
        Key := S[1];
      end;
    vkMultiply:
      Key := '*';
    vkAdd:
      Key := '+';
    vkSeparator:
      Key := ',';
    vkSubtract:
      Key := '-';
    vkDecimal:
      Key := '.';
    vkDivide:
      Key := '/';
    vkNumpad0 .. vkNumpad9:
      Key := Char(Ord('0') + K - vkNumpad0);
  else
    if CharInSet(Chr(K), ['A' .. 'Z']) then
    begin
      S := Chr(K);
      if ShortCut and scShift <> 0 then
        S := UpperCase(S)
      else
        S := LowerCase(S);
      Key := S[1];
    end
    else
    begin
      S := VirtualKeyToText(ShortCut);
      if Length(S) = 1 then
        Key := S[1]
      else
        Key := Chr(K);
    end;
  end;
  if ShortCut and scCtrl <> 0 then
    ModifierMask := ModifierMask or NSControlKeyMask;
  if ShortCut and scAlt <> 0 then
    ModifierMask := ModifierMask or NSAlternateKeyMask;
  if ShortCut and scShift <> 0 then
    ModifierMask := ModifierMask or NSShiftKeyMask;
  if ShortCut and scCommand <> 0 then
    ModifierMask := ModifierMask or NSCommandKeyMask;
end;

type
  TMenuMacKeyCap = (mkcShift, mkcCtrl, mkcAlt, mkcCmd);
var
  MenuMACKeyCaps: array [TMenuMacKeyCap] of string = (SmkcShift, SmkcCtrl, SmkcAlt, SmkcCmd);

function ShortCutToText(ShortCut: TShortCut): string;
var
  Key: string;
begin
  Result := '';
  Key := VirtualKeyToText(ShortCut);
  if Key <> '' then
  begin
    if ShortCut and scCtrl <> 0 then
      Result := Result + MenuMACKeyCaps[TMenuMacKeyCap.mkcCtrl];
    if ShortCut and scAlt <> 0 then
      Result := Result + MenuMACKeyCaps[TMenuMacKeyCap.mkcAlt];
    if ShortCut and scShift <> 0 then
      Result := Result + MenuMACKeyCaps[TMenuMacKeyCap.mkcShift];
    if ShortCut and scCommand <> 0 then
      Result := Result + MenuMACKeyCaps[TMenuMacKeyCap.mkcCmd];
    Result := Result + Key;
  end;
end;


function TextToShortCut(Text: string): Integer;
{ If the front of Text is equal to Front then remove the matching piece
  from Text and return True, otherwise return False }

  function CompareFront(var Text: string; const Front: string): Boolean;
  begin
    Result := False;
    if (Length(Text) >= Length(Front)) and (AnsiStrLIComp(PChar(Text), PChar(Front), Length(Front)) = 0) then
    begin
      Result := True;
      Delete(Text, 1, Length(Front));
    end;
  end;

var
  Key: TShortCut;
  Shift: TShortCut;
begin
  Result := 0;
  Shift := 0;
  while True do
  begin
    if CompareFront(Text, MenuMACKeyCaps[TMenuMacKeyCap.mkcShift]) then
      Shift := Shift or scShift
    else if CompareFront(Text, '^') then
      Shift := Shift or scCtrl
    else if CompareFront(Text, MenuMACKeyCaps[TMenuMacKeyCap.mkcCtrl]) then
      Shift := Shift or scCtrl
    else if CompareFront(Text, MenuMACKeyCaps[TMenuMacKeyCap.mkcAlt]) then
      Shift := Shift or scAlt
    else if CompareFront(Text, MenuMACKeyCaps[TMenuMacKeyCap.mkcCmd]) then
      Shift := Shift or scCommand
    else
      Break;
  end;
  if Text = '' then
    Exit;
  for Key := 1 to 255 do { Copy range from table in ShortCutToText }
    if AnsiCompareText(Text, ShortCutToText(Key)) = 0 then
      Exit(Key or Shift);
end;

procedure HandleException(const SenderOfException: TObject);
begin
  if Application <> nil then
    Application.HandleException(SenderOfException)
  else if ExceptObject is Exception then
    System.SysUtils.ShowException(ExceptObject, ExceptAddr);
  { Otherwise (no error), do nothing }
end;

function BitmapToMacBitmap(const Bitmap: TBitmap): NSImage;
var
  mem: TMemoryStream;
  Data: NSData;
  TmpImage: NSImage;
  AutoreleasePool: NSAutoreleasePool;
begin
  if Bitmap <> nil then
  begin
    Data := nil;
    TmpImage := nil;
    AutoreleasePool := TNSAutoreleasePool.Create;
    try
      mem := TMemoryStream.Create;
      try
        Bitmap.SaveToStream(mem);
        Data := TNSData.Wrap(TNSData.OCClass.dataWithBytes(mem.Memory, mem.size));
        TmpImage := TNSImage.Alloc;
        Result := TNSImage.Wrap(TmpImage.initWithData(Data));
      finally
        mem.Free;
      end;
    finally
      AutoreleasePool.release;
    end;
  end
  else
    raise EArgumentNilException.Create(SArgumentNil);
end;

function NativeViewToSurface(const ANativeView: NSView; const ASurface: TBitmapSurface): Boolean;
var
  Size: NSSize;
  ContRef: CGContextRef;
  ColorSpace: CGColorSpaceRef;
  SaveWants: Boolean;
begin
  SaveWants := ANativeView.wantsLayer;
  try
    ANativeView.setWantsLayer(True);
    Size := ANativeView.frame.size;
    ColorSpace := CGColorSpaceCreateDeviceRGB;
    ASurface.SetSize(Trunc(Size.width), Trunc(Size.height));
    ContRef := CGBitmapContextCreate(ASurface.Bits, ASurface.Width, ASurface.Height, 8, 4 * ASurface.Width, ColorSpace,
      kCGImageAlphaPremultipliedLast);
    try
      if ANativeView.layer <> nil then
        ANativeView.layer.renderInContext(ContRef);
    finally
      CGContextRelease(ContRef);
    end;
  finally
    ANativeView.setWantsLayer(SaveWants);
  end;
  Result := True;
end;

procedure InitSrcDstRects(const SourceSize, DestinationSize: TSizeF; var SourceRect, DestinationRect: TRectF);

  function ScaleOfBitmap(const SourceSize, DestinationSize: TSizeF): Single;
  var
    HScale, VScale: Single;
  begin
    if SourceSize.cx > 0 then
      HScale := DestinationSize.cx / SourceSize.cx
    else
      HScale := 1;
    if SourceSize.cy > 0 then
      VScale := DestinationSize.cy / SourceSize.cy
    else
      VScale := 1;
    Result := Min(HScale, VScale);
  end;

var
  Scale: Single;
begin
  Scale := Min(1, ScaleOfBitmap(SourceSize, DestinationSize));
  SourceRect := TRectF.Create(0, 0, SourceSize.cx, SourceSize.cy);
  DestinationRect.Left := Round((DestinationSize.cx - SourceSize.cx * Scale) / 2);
  DestinationRect.Top := Round((DestinationSize.cy - SourceSize.cy * Scale) / 2);
  DestinationRect.width := Round(SourceSize.cx * Scale);
  DestinationRect.height := Round(SourceSize.cy * Scale);
end;

function MultipleOf(const Value, Denominator: Integer; const Greater: Boolean = True): Integer;
begin
  if Greater then
    Result := ((Value + Denominator - 1) div Denominator) * Denominator
  else
    Result := ((Value + (Denominator div 2)) div Denominator) * Denominator;
end;

function BitmapToMenuBitmap(const Bitmap: TBitmap; const MaxBitmapSize: Integer = 24): NSImage;
var
  W, H: Integer;
  TempBitmap: TBitmap;
  Src, Dst: TRectF;
begin
  Result := nil;
  if (Bitmap <> nil) and (not Bitmap.IsEmpty) then
  begin
    H := MultipleOf(Min(Max(Bitmap.width, Bitmap.height), MaxBitmapSize), 2, False);
    W := H;
    if (Bitmap.width <> W) or (Bitmap.height <> H) then
    begin
      TempBitmap := TBitmap.Create(W, H);
      try
        if TempBitmap.Canvas.BeginScene then
        begin
          try
            InitSrcDstRects(TSizeF.Create(Bitmap.width, Bitmap.height), TSizeF.Create(W, H), Src, Dst);
            TempBitmap.Canvas.DrawBitmap(Bitmap, Src, Dst, 1, False);
          finally
            TempBitmap.Canvas.EndScene;
          end;
          Result := BitmapToMacBitmap(TempBitmap);
        end;
      finally
        TempBitmap.Free;
      end;
    end
    else
      Result := BitmapToMacBitmap(Bitmap);
  end;
end;

function ImageListToMenuBitmap(const Images: TCustomImageList; const Index: Integer): NSImage;
begin
  if (Images <> nil) and (Index >= 0) then
                                                                                         
    Result := BitmapToMenuBitmap(Images.Bitmap(TSizeF.Create(16, 16), Index))
  else
    Result := nil;
end;

{ TNSMessageObject }

constructor TOSXMessageObject.Create(ASender: NSObject);
begin
  inherited Create;
  FNSSender := ASender;
end;

end.
