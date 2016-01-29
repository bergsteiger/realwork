unit MPGifImg;

{$I MPC.INC}
{$WriteableConst On}

interface

uses
  WinTypes, WinProcs, SysUtils, Classes, Controls, ExtCtrls, Forms, Graphics,
  MPList, MPTimer;

type
  TGIFTriple = packed record
    Red: byte;
    Green: byte;
    Blue: byte;
  end;

  PColorTableArray = ^TColorTableArray;
  TColorTableArray = array[0..255] of TGIFTriple;
  TColorTable = class
    private
      FCount: integer;
      FColors: PColorTableArray;

      function GetColor(Index: integer): TColor;
      function GetTriple(Index: integer): TGIFTriple;
      
    public
      constructor CreateFromStream(aSize: Cardinal; Stream: TStream);
      destructor Destroy; override;
      function CreatePalette: HPalette;
      property Count: integer read FCount;
      property Colors: PColorTableArray read FColors;
      property Color[Index: integer]: TColor read GetColor;
      property Triple[Index: integer]: TGIFTriple read GetTriple;
  end;

  TRasterData = class;
  TImageDescriptor = class;

  TGIFData = class
    private
      FRefCount: longint;
      FData: TMemoryStream;               { actual data of GIF stream }
      FFrames: TMPOwnedObjectList;        { list of all TGIFFrames }

      { these values are filled when decoded }
      FGlobalColorTable: TColorTable;     { global color table if present }
      FLogicalScreenWidth: word;          { logical screen width of image }
      FLogicalScreenHeight: word;         { logical screen height of image }
      FPackedFields: byte;                { packed fields of image }
      FBackgroundColorIndex: byte;        { background transparent color index }
      FPixelAspectRatio: byte;            { pixel aspect ratio }

      { helper functions that act on the data stream }
      procedure LoadBlock(var BlockVars; Size: Cardinal);         { data block from FData to BlockVars EXCLUDING block size }
      procedure LoadBlockAndSize(var BlockVars; Size: Cardinal);  { data block from FData to BlockVars INCLUDING block size }
      procedure LoadBlocksToStrings(s: TStrings);                 { data block into a string list - lengths are block sizes }
      procedure LoadBlocksToStream(Stream: TStream);              { data block into a stream, excluding block sizes }
      function LoadBlockToString: string;                         { block into a string - blocksize is string length }
      function SkipBlock: byte;                                   { skips a block }
      procedure SkipBlocks;                                       { skips all blocks until block terminator }

      { decoder procedure }
      procedure DecodeFrame(RasterData: TRasterData; Extensions: TList; ImageDescriptor: TImageDescriptor; Bitmap: TBitmap);

      { internal }
      procedure CheckFrameIndex(Value: integer);

      function GetFrameCount: integer;
      function GetInterval(Index: integer): Cardinal;
      procedure SetInterval(Index: integer; Value: Cardinal);
      procedure SetIntervals(Value: Cardinal);
      function GetSignature: string;
      function GetVersion: string;
      function GetHasGlobalColorTable: boolean;
      function GetColorResolution: byte;
      function GetHasSortedGlobalColorTable: boolean;
      function GetGlobalColorTableSize: Cardinal;

    public
      destructor Destroy; override;
      procedure AddRef;
      procedure Release;
      procedure Decode;
      function GetFrame(Index: integer): TBitmap;
      property RefCount: longint read FRefCount;
      property FrameCount: integer read GetFrameCount;
      property Interval[Index: integer]: Cardinal read GetInterval write SetInterval;
      property Intervals: Cardinal write SetIntervals;
      property Signature: string read GetSignature;
      property Version: string read GetVersion;
      property LogicalScreenWidth: word read FLogicalScreenWidth;
      property LogicalScreenHeight: word read FLogicalScreenHeight;
      property PackedFields: byte read FPackedFields;
      property BackgroundColorIndex: byte read FBackgroundColorIndex;
      property PixelAspectRatio: byte read FPixelAspectRatio;
      property HasGlobalColorTable: boolean read GetHasGlobalColorTable;
      property ColorResolution: byte read GetColorResolution;
      property HasSortedGlobalColorTable: boolean read GetHasSortedGlobalColorTable;
      property GlobalColorTableSize: Cardinal read GetGlobalColorTableSize;
      property Frame[Index: integer]: TBitmap read GetFrame;
      property Data: TMemoryStream read FData;
  end;

  TGIFFrame = class
    private
      FGifData: TGIFData;
      FBitmap: TBitmap;
      FInterval: Cardinal;    { in approx. 1/100 second }

      procedure BitmapChange(Sender: TObject);
      constructor Create(GIFData: TGIFData);
      destructor Destroy; override;
      procedure Load;
  end;

  TRasterData = class
    private
      FLZWCodeSize: byte;
      FImageData: TMemoryStream;

    public
      constructor Create(GIFData: TGIFData);
      destructor Destroy; override;
  end;

  TImageDescriptor = class
    private
      FImageLeftPos: word;    { Column in pixels in respect to left edge of logical screen }
      FImageTopPos: word;     { row in pixels in respect to top of logical screen }
      FImageWidth: word;      { width of image in pixels }
      FImageHeight: word;     { height of image in pixels }
      FPackedFields: byte;
      FLocalColorTable: TColorTable;

      function GetHasColorTable: boolean;
      function GetInterlaced: boolean;
      function GetSorted: boolean;
      function GetColorTableSize: Cardinal;

    public
      constructor Create(GIFData: TGIFData);
      destructor Destroy; override;
      property HasColorTable: boolean read GetHasColorTable;
      property Interlaced: boolean read GetInterlaced;
      property Sorted: boolean read GetSorted;
      property ColorTableSize: Cardinal read GetColorTableSize;
      property ImageLeftPos: word read FImageLeftPos;
      property ImageTopPos: word read FImageTopPos;
      property ImageWidth: word read FImageWidth;
      property ImageHeight: word read FImageHeight;
      property PackedFields: byte read FPackedFields;
      property LocalColorTable: TColorTable read FLocalColorTable;
  end;

  TGIFExtension = class
    public
      constructor Create(GIFData: TGIFData); virtual; abstract;
  end;

  TCommentExtension = class(TGIFExtension)
    public
      Comments: TStringList;

      constructor Create(GIFData: TGIFData); override;
      destructor Destroy; override;
  end;

  TGraphicControlExtension = class(TGIFExtension)
    public
      PackedFields: byte;
      DelayTime: word;
      TransparentColorIndex: byte;
      
      constructor Create(GIFData: TGIFData); override;
  end;

  TPlainTextExtension = class(TGIFExtension)
    public
      Left: word;
      Top: word;
      Width: word;
      Height: word;
      CellWidth: byte;
      CellHeight: byte;
      TextFGColorIndex: byte;
      TextBGColorIndex: byte;
      PlainTextData: TStringList;

      constructor Create(GIFData: TGIFData); override;
      destructor Destroy; override;
  end;

  TApplicationExtension = class(TGIFExtension)
    public
      ApplicationIdentifier: array[1..8] of byte;
      AppAuthenticationCode: array[1..3] of byte;
      AppData: TMemoryStream;

      constructor Create(GIFData: TGIFData); override;
      destructor Destroy; override;
  end;

  TGIFImage = class(TGraphic)
    private
      FImage: TGIFData;         { raw GIF stream data }
      FFrame: integer;          { current frame }
      FWidth: integer;          { width wanted - not what is actually in GIF data }
      FHeight: integer;         { height wanted - not what is actually in GIF data }
      FTimerHandle: integer;    { timer handle in timer pool }
      
      function GetBitmap: TBitmap;
      procedure SetFrame(Value: integer);
      function GetFrameCount: integer;
      function GetAnimating: boolean;
      procedure SetAnimating(Value: Boolean);
      procedure SetInterval(Value: Cardinal);
      procedure NextImageEvent(Sender: TObject; Handle: integer; IntervalTicks, ElapsedTicks: longint);

    protected
      procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
      function GetEmpty: boolean; override;
      function GetHeight: integer; override;
      function GetWidth: integer; override;
      procedure NewImage;
      procedure ReadData(Stream: TStream); override;
      procedure ReadStream(Size: longint; Stream: TStream);
      procedure SetHeight(Value: integer); override;
      procedure SetWidth(Value: integer); override;
      procedure WriteData(Stream: TStream); override;

    public
      constructor Create; override;
      destructor Destroy; override;
      procedure Assign(Source: TPersistent); override;
      procedure LoadFromStream(Stream: TStream); override;
      procedure SaveToStream(Stream: TStream); override;
      procedure LoadFromClipboardFormat(aFormat: word; aData: THandle; aPalette: HPalette); override;
      procedure SaveToClipboardFormat(var aFormat: word; var aData: THandle; var aPalette: hPalette); override;
      procedure IncrementFrame;
      procedure DecrementFrame;
      procedure AnimateOnce;
      property Frame: integer read FFrame write SetFrame;
      property FrameCount: integer read GetFrameCount;
      property Bitmap: TBitmap read GetBitmap;
      property Animating: boolean read GetAnimating write SetAnimating;
      property Interval: Cardinal write SetInterval;
  end;

implementation

const
  DefInterval = 10;
  TimerPool: TMPTimerPool = nil;

function MinLong(A, B: longint): longint;
begin
  if A < B then
    Result:= A
  else
    Result:= B;
end;

constructor TColorTable.CreateFromStream(aSize: Cardinal; Stream: TStream);
begin
  inherited Create;
  if aSize > 0 then
  begin
    GetMem(FColors, aSize);
    Stream.Read(FColors^, aSize);
    FCount:= aSize div SizeOf(TGIFTriple);
  end; {if}
end;

destructor TColorTable.Destroy;
begin
  if assigned(FColors) then
    FreeMem(FColors{$IFNDEF Win32}, FCount * SizeOf(TRGBTriple) {$ENDIF});
  inherited Destroy;
end;

function TColorTable.GetColor(Index: integer): TColor;
begin
  with GetTriple(Index) do
    Result:= RGB(Red, Green, Blue);
end;

function TColorTable.GetTriple(Index: integer): TGIFTriple;
begin
  if (Index >= Count) or (Index < 0) then
    raise EListError.CreateFmt('Index %d out of range [0..%d]', [Index, Count -1]);
  Result:= FColors^[Index];
end;

function TColorTable.CreatePalette: HPALETTE;

var
  x: integer;
  DstPal: PLogPalette;
  SysPalSize: integer;
  PalSize: Cardinal;
  DC: HDC;
  Focus: HWND;

begin
  if FCount > 0 then
  begin
    PalSize:= SizeOf(TLogPalette) + (pred(FCount) * SizeOf(TPaletteEntry));
    DstPal:= AllocMem(PalSize);
    try
      with DstPal^ do
      begin
        palVersion:= $300;
        palNumEntries:= FCount;
        Focus:= GetFocus;
        DC:= GetDC(Focus);
        try
          SysPalSize:= GetDeviceCaps(DC, SIZEPALETTE);
          if (FCount = 16) and (SysPalSize >= 16) then
          begin
            { Ignore the disk image of the palette for 16 color bitmaps use instead the first 8
              and last 8 of the current system palette }
            GetSystemPaletteEntries(DC, 0, 8, palPalEntry);
            x:= 8;
            GetSystemPaletteEntries(DC, SysPalSize - x, x, palPalEntry[x]);
          end
          else
            { Copy the palette for all others (i.e. 256 colors) }
            for x:= 0 to FCount -1 do
              with Triple[x], palPalEntry[x] do
              begin
                peRed:= Red;
                peGreen:= Green;
                peBlue:= Blue;
              end; {for-with}
        finally
          ReleaseDC(Focus, DC);
        end;
      end;
      Result:= WinProcs.CreatePalette(DstPal^);
    finally
      FreeMem(DstPal, PalSize);
    end;
  end
  else
    Result:= 0;
end;

constructor TGraphicControlExtension.Create(GIFData: TGIFData);
begin
  GIFData.LoadBlock(PackedFields,
    SizeOf(PackedFields) + SizeOf(DelayTime) + SizeOf(TransparentColorIndex));
  GIFData.SkipBlocks;
end;

constructor TPlainTextExtension.Create(GIFData: TGIFData);
begin
  GIFData.LoadBlock(Left,
    SizeOf(Left) + SizeOf(Top) + SizeOf(Width) + SizeOf(Height) + SizeOf(CellWidth) + SizeOf(CellHeight) +
    SizeOf(TextFGColorIndex) + SizeOf(TextBGColorIndex));
  PlainTextData:= TStringList.Create;
  GIFData.LoadBlocksToStrings(PlainTextData);
end;

destructor TPlainTextExtension.Destroy;
begin
  PlainTextData.Free;
  inherited Destroy;
end;

constructor TApplicationExtension.Create(GIFData: TGIFData);
begin
  GIFData.LoadBlock(ApplicationIdentifier,
    SizeOf(ApplicationIdentifier) + SizeOf(AppAuthenticationCode));
  AppData:= TMemoryStream.Create;
  GIFData.LoadBlocksToStream(AppData);
end;

destructor TApplicationExtension.Destroy;
begin
  AppData.Free;
  inherited Destroy;
end;

constructor TCommentExtension.Create(GIFData: TGIFData);
begin
  Comments:= TStringList.Create;
  GIFData.LoadBlocksToStrings(Comments);
end;

destructor TCommentExtension.Destroy;
begin
  Comments.Free;
  inherited Destroy;
end;

constructor TImageDescriptor.Create(GIFData: TGIFData);
begin
  inherited Create;
  GIFData.FData.Read(FImageLeftPos, SizeOf(FImageLeftPos));
  GIFData.FData.Read(FImageTopPos, SizeOf(FImageTopPos));
  GIFData.FData.Read(FImageWidth, SizeOf(FImageWidth));
  GIFData.FData.Read(FImageHeight, SizeOf(FImageHeight));
  GIFData.FData.Read(FPackedFields, SizeOf(FPackedFields));
  if HasColorTable then
    FLocalColorTable:= TColorTable.CreateFromStream(ColorTableSize, GIFData.FData)
  else
    FLocalColorTable:= GIFData.FGlobalColorTable;
end;

destructor TImageDescriptor.Destroy;
begin
  if HasColorTable then
    FLocalColorTable.Free;
  inherited Destroy;
end;

function TImageDescriptor.GetHasColorTable: boolean;
begin
  Result:= ((PackedFields and $80) <> 0);
end;

function TImageDescriptor.GetInterlaced: boolean;
begin
  Result:= ((PackedFields and $40) <> 0);
end;

function TImageDescriptor.GetSorted: boolean;
begin
  Result:= ((PackedFields and $20) <> 0);
end;

function TImageDescriptor.GetColorTableSize: Cardinal;
begin
  if HasColorTable then
    Result:= 3 * (2 shl (PackedFields and $07))
  else
    Result:= 0;
end;

constructor TRasterData.Create(GIFData: TGIFData);
begin
  inherited Create;
  GIFData.FData.Read(FLZWCodeSize, SizeOf(FLZWCodeSize));
  FImageData:= TMemoryStream.Create;
  GIFData.LoadBlocksToStream(FImageData);
end;

destructor TRasterData.Destroy;
begin
  FImageData.Free;
  inherited Destroy;
end;

constructor TGIFFrame.Create(GIFData: TGIFData);
begin
  inherited Create;
  FBitmap:= TBitmap.Create;
  FGIFData:= GIFData;
end;

destructor TGIFFrame.Destroy;
begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TGIFFrame.BitmapChange(Sender: TObject);
begin
  raise EInvalidGraphicOperation.CreateFmt('Cannot modify %s bitmap', [ClassName]);
end;

procedure TGIFFrame.Load;

var
  x: integer;
  SaveMode: integer;
  SaveColor: TColorRef;
  ImageDescriptor: TImageDescriptor;
  RasterData: TRasterData;
  Extensions: TMPOwnedObjectList;
  aExtension: TGIFExtension;
  ExtensionLabel: byte;
  SepChar: char;

begin
  Extensions:= nil;
  RasterData:= nil;
  ImageDescriptor:= nil;
  try
    FGIFData.FData.Seek(-1, 1);   { back up one and read the character }
    repeat
      FGIFData.FData.Read(SepChar, SizeOf(SepChar));
      case SepChar of
        ';':  begin   { terminator - shouldn't be here, but if it is, break out of the loop }
                FGIFData.FData.Seek(-1, 1);
                break;
              end;
        '!':  begin   { extension block }
                FGIFData.FData.Read(ExtensionLabel, SizeOf(ExtensionLabel));
                case ExtensionLabel of
                  $01: aExtension:= TPlainTextExtension.Create(FGIFData);
                  $F9: aExtension:= TGraphicControlExtension.Create(FGIFData);
                  $FE: aExtension:= TCommentExtension.Create(FGIFData);
                  $FF: aExtension:= TApplicationExtension.Create(FGIFData);
                  else
                    begin
                      aExtension:= nil;
                      FGIFData.SkipBlocks;
                    end;
                end; {case}
                if assigned(aExtension) then
                  try
                    if not assigned(Extensions) then
                      Extensions:= TMPOwnedObjectList.Create;
                    Extensions.Add(aExtension);
                  except
                    aExtension.Free;
                    raise;
                  end;
              end;
        ',':  begin   { image block }
                ImageDescriptor:= TImageDescriptor.Create(FGIFData);
                RasterData:= TRasterData.Create(FGIFData);
                FGIFData.DecodeFrame(RasterData, Extensions, ImageDescriptor, FBitmap);
                { extensions }
                if assigned(Extensions) then
                  for x:= 0 to Extensions.Count -1 do
                    try
                      aExtension:= TGIFExtension(Extensions[x]);
                      if aExtension is TGraphicControlExtension then
                        FInterval:= MinLong(TGraphicControlExtension(aExtension).DelayTime div 10, 30)
                      else if aExtension is TPlainTextExtension then
                        with TPlainTextExtension(aExtension) do
                        begin
                          FBitmap.Canvas.Font.Height:= CellHeight;
                          if assigned(ImageDescriptor.FLocalColorTable) then
                          begin
                            FBitmap.Canvas.Font.Color:= ImageDescriptor.FLocalColorTable.Color[TextFGColorIndex];
                            SaveMode:= SetBkMode(FBitmap.Canvas.Handle, Opaque);
                            SaveColor:= SetBkColor(FBitmap.Canvas.Handle,
                              ColorToRGB(ImageDescriptor.FLocalColorTable.Color[TextBGColorIndex]));
                          end; {if}
                          { only going to show the first line }
                          if PlainTextData.Count > 0 then
                            FBitmap.Canvas.TextRect(Rect(Left, Top, Width, Height), Left, Top, PlainTextData[0]);
                          if assigned(ImageDescriptor.FLocalColorTable) then
                          begin
                            SetBkColor(FBitmap.Canvas.Handle, SaveColor);
                            SetBkMode(FBitmap.Canvas.Handle, SaveMode);
                          end; {if}
                        end; {if-with}
                    except
                      on EAbort do;
                      on E:Exception do
                        Application.ShowException(E);
                    end; {if-for-try}
                FBitmap.OnChange:= BitmapChange; { no more changes allowed }
                break;
              end;
        else          { unknown block }
          raise EInvalidGraphicOperation.CreateFmt('Invalid GIF format seperator: $%x', [ord(SepChar)]);
      end; {case}
    until false;
  finally
    RasterData.Free;
    ImageDescriptor.Free;
    Extensions.Free;
  end;
end;

procedure TGIFData.AddRef;
begin
  inc(FRefCount);
end;

procedure TGIFData.Release;
begin
  if not assigned(Self) then exit;
  dec(FRefCount);
  if FRefCount <= 0 then
    Free;
end;

procedure TGIFData.CheckFrameIndex(Value: integer);
begin
  if Value >= FrameCount then
    raise EInvalidGraphicOperation.CreateFmt('Invalid frame number %d (0..%d)', [Value, FrameCount -1]);
end;

function TGIFData.GetFrameCount: integer;
begin
  Decode;
  Result:= FFrames.Count;
end;

function TGIFData.GetInterval(Index: integer): Cardinal;
begin
  Decode;
  CheckFrameIndex(Index);
  Result:= TGIFFrame(FFrames[Index]).FInterval;
end;

procedure TGIFData.SetInterval(Index: integer; Value: Cardinal);
begin
  Decode;
  CheckFrameIndex(Index);
  TGIFFRame(FFrames[Index]).FInterval:= Value;  
end;

procedure TGIFData.SetIntervals(Value: Cardinal);

var
  x: integer;

begin
  for x:= 0 to FrameCount -1 do
    SetInterval(x, Value);
end;

destructor TGIFData.Destroy;
begin
  FGlobalColorTable.Free;
  FFrames.Free;
  FData.Free;
  inherited Destroy;
end;

type
  TDecoder = class
    private
      BitsLeft: integer;
      CurrByte: byte;
      LZWCodeSize: integer;
      CurrCodeSize: integer;
      ClearCode: integer;
      EndingCode: integer;
      HighCode: integer;
      CurrentY: integer;
      InterlacePass: integer;
      CompStream: TStream;

      constructor Create(aLZWCodeSize: byte; aCompStream: TStream);
      function NextCode: word;
      procedure DecodeTo(Bitmap: TBitmap; Interlaced: boolean);
  end;

constructor TDecoder.Create(aLZWCodeSize: byte; aCompStream: TStream);
begin
  inherited Create;
  if not (aLZWCodeSize in [2..9]) then   { valid code sizes 2-9 bits }
    raise EInvalidGraphicOperation.CreateFmt('Invalid LZW Code Size: %d', [aLZWCodeSize]);
    
  LZWCodeSize:= aLZWCodeSize;
  CurrCodeSize:= succ(LZWCodeSize);
  ClearCode:= 1 shl LZWCodeSize;
  EndingCode:= succ(ClearCode);
  HighCode:= pred(ClearCode);
  {BitsLeft:= 0;}
  {CurrentY:= 0;}
  {InterlacePass:= 0;}
  CompStream:= aCompStream;
  CompStream.Position:= 0;
end;

function TDecoder.NextCode: word;
{ returns a code of the proper bit size }
const
  CodeMask: array[0..12] of word =
    (0, $0001, $0003, $0007, $000F, $001F, $003F, $007F, $00FF, $01FF, $03FF, $07FF, $0FFF);

begin
  if BitsLeft = 0 then
  begin
    CompStream.Read(CurrByte, SizeOf(CurrByte));
    BitsLeft:= SizeOf(CurrByte) * 8;
  end; {if}
  
  Result:= CurrByte shr (8 - BitsLeft);
  while CurrCodeSize > BitsLeft do     
  begin
    CompStream.Read(CurrByte, SizeOf(CurrByte));
    Result:= Result or (CurrByte shl BitsLeft);
    inc(BitsLeft, SizeOf(CurrByte) * 8);
  end; {while}
  dec(BitsLeft, CurrCodeSize);               
  Result:= Result and CodeMask[CurrCodeSize];
end;

procedure TDecoder.DecodeTo(Bitmap: TBitmap; Interlaced: boolean);

const
  CodeTableSize = 4096;

type
  PCodeIntegers = ^TCodeIntegers;
  TCodeIntegers = array[0..CodeTableSize-1] of integer;
  PDecodeStack = ^TDecodeStack;
  TDecodeStack = array[0..CodeTableSize-1] of byte;

var
  StackPtr: integer;
  CurrBuf: word;
  DecodeStack: PDecodeStack;
  Prefixes: PCodeIntegers;
  Suffixes: PCodeIntegers;
  {$IFDEF Win32}  { 32 bit has a large stack so use it for speed }
  DStack: TDecodeStack;
  Prefix: TCodeIntegers;
  Suffix: TCodeIntegers;
  {$ENDIF}

procedure DecodeCode(var Code: word);
begin
  while Code > HighCode do
  begin
    DecodeStack^[StackPtr]:= Suffixes^[Code];
    inc(StackPtr);
    Code:= Prefixes^[Code];
  end; {while}
  DecodeStack^[StackPtr]:= Code;
  inc(StackPtr);                               
end;

procedure PopStack;

function IncrementLineNumber(LineNo, ImageHeight: integer; var InterlacePass: integer): integer;

const
  IInc: array[0..3] of integer = (8, 8, 4, 2);
  HInc: array[1..3] of integer = (4, 2, 1);

begin
  if InterlacePass in [low(IInc)..high(IInc)] then
    Result:= LineNo + IInc[InterlacePass]
  else
    Result:= LineNo;

  if Result >= ImageHeight then
  begin
    inc(InterLacePass);
    if InterlacePass in [low(HInc)..high(HInc)] then
      Result:= HInc[InterlacePass];
  end; {if}
end;

begin
  while StackPtr > 0 do
  begin
    dec(StackPtr);
    Bitmap.Canvas.Pixels[CurrBuf, CurrentY]:= DecodeStack^[StackPtr] or $01000000;
    inc(CurrBuf);
    if CurrBuf >= Bitmap.Width then
    begin
      if not InterLaced then
        inc(CurrentY)
      else
        CurrentY:= IncrementLineNumber(CurrentY, Bitmap.Height, InterlacePass);
      CurrBuf:= 0;
    end; {if}
  end; {while}
end;

procedure CheckSlotValue(var Slot, TopSlot: Word; var MaxVal: Boolean);
begin
  if Slot >= TopSlot then
  begin
    if CurrCodeSize < 12 then
    begin
      TopSlot:= TopSlot shl 1;
      inc(CurrCodeSize);
    end
    else
      MaxVal:= true;       
  end; {if}
end;

var
  C, Code,
  OldCode,
  TempOldCode: word;
  Slot,
  TopSlot: word;
  MaxVal: boolean;

begin
  OldCode:= 0;
  StackPtr:= 0;
  CurrBuf:= 0;
  MaxVal:= false;
  {$IFDEF Win32}
  DecodeStack:= @DStack;
  Prefixes:= @Prefix;
  Suffixes:= @Suffix;
  {$ELSE}
  DecodeStack:= nil;
  Prefixes:= nil;
  Suffixes:= nil;
  try
    New(DecodeStack);
    New(Prefixes);
    New(Suffixes);
    {$ENDIF}    
    C:= NextCode;
    while C <> EndingCode do
    begin
      if C = ClearCode then  
      begin
        CurrCodeSize:= succ(LZWCodeSize);
        Slot:= succ(EndingCode);
        TopSlot:= 1 shl CurrCodeSize;
        while C = ClearCode do
          C:= NextCode;
        if C = EndingCode then
          raise EStreamError.Create('Invalid stream format');
        if C >= Slot then
          C:= 0;
        OldCode:= C;
        DecodeStack^[StackPtr]:= C;
        inc(StackPtr);
      end
      else
      begin
        Code:= C;
        if Code < Slot then
        begin
          DecodeCode(Code);
          if Slot <= TopSlot then
          begin
            Suffixes^[Slot]:= Code;
            Prefixes^[Slot]:= OldCode;
            inc(Slot);
            CheckSlotValue(Slot, TopSlot, MaxVal);
            OldCode:= C;
          end; {if}
        end
        else
        begin
          if Code <> Slot then
            raise EStreamError.Create('Invalid stream format');
          TempOldCode:= OldCode;
          while OldCode > HighCode do
          begin
            DecodeStack^[StackPtr]:= Suffixes^[OldCode];
            OldCode:= Prefixes^[OldCode];
          end; {while}
          DecodeStack^[StackPtr]:= OldCode;
          if Slot <= TopSlot then
          begin
            Suffixes^[Slot]:= OldCode;
            Prefixes^[Slot]:= TempOldCode;
            inc(Slot);                     
            CheckSlotValue(Slot, TopSlot, MaxVal);
          end; {if}
          DecodeCode(Code);
          OldCode:= C;
        end; {else}
      end; { else (if code < slot) }
      PopStack;
      C:= NextCode;
      if (MaxVal = True) and (C <> ClearCode) then
        raise Exception.Create('Code size overflow');
      MaxVal:= false;
    end; { while C <> EndingCode }
  {$IFNDEF Win32}
  finally
    if assigned(DecodeStack) then
      Dispose(DecodeStack);
    if assigned(Prefixes) then
      Dispose(Prefixes);
    if assigned(Suffixes) then
      Dispose(Suffixes);
  end;
  {$ENDIF}
end;

procedure TGIFData.DecodeFrame(RasterData: TRasterData; Extensions: TList; ImageDescriptor: TImageDescriptor; Bitmap: TBitmap);

var
  Decoder: TDecoder;

begin
  Bitmap.Width:= ImageDescriptor.ImageWidth;
  Bitmap.Height:= ImageDescriptor.ImageHeight;
  if assigned(ImageDescriptor.FLocalColorTable) then
    Bitmap.Palette:= ImageDescriptor.FLocalColorTable.CreatePalette;
  Decoder:= TDecoder.Create(RasterData.FLZWCodeSize, RasterData.FImageData);
  try
    Decoder.DecodeTo(Bitmap, ImageDescriptor.Interlaced);
  finally
    Decoder.Free;
  end;
end;

procedure TGIFData.LoadBlock(var BlockVars; Size: Cardinal);
{ load a data block from FData into BlockVars EXCLUDING the block size }
var
  BlockSize: byte;

begin
  FData.Read(BlockSize, SizeOf(BlockSize));
  if BlockSize > 0 then
  begin
    if Size = 0 then
      Size:= BlockSize;
    FData.Read(BlockVars, MinLong(BlockSize, Size));
  end; {if}
end;

procedure TGIFData.LoadBlockAndSize(var BlockVars; Size: Cardinal);
{ load a data block from FData into BlockVars INCLUDING the block size }
var
  BlockSize: byte;
  Bytes: TByteArray absolute BlockVars;

begin
  FData.Read(BlockSize, SizeOf(BlockSize));
  Bytes[0]:= BlockSize;
  if BlockSize > 0 then
  begin
    if Size = 0 then
      Size:= BlockSize;
    FData.Read(Bytes[1], MinLong(BlockSize, Size));
  end; {if}
end;

procedure TGIFData.LoadBlocksToStrings(s: TStrings);
{ load a data block into a string list - string lengths are block sizes }
var
  aString: string;

begin
  aString:= LoadBlockToString;
  while aString <> '' do
  begin
    s.Add(aString);
    aString:= LoadBlockToString;
  end; {while}
end;

procedure TGIFData.LoadBlocksToStream(Stream: TStream);
{ load a data block into a stream, excluding block sizes }
var
  BlockSize: byte;

begin
  repeat
    FData.Read(BlockSize, SizeOf(BlockSize));
    if BlockSize <> 0 then
      Stream.CopyFrom(FData, BlockSize);
  until BlockSize = 0;
end;

function TGIFData.LoadBlockToString: string;
{ load a block into a string - blocksize is string length }
var
  BlockSize: byte {$IFNDEF Win32} absolute Result {$ENDIF};

begin
  FData.Read(BlockSize, SizeOf(BlockSize));
  {$IFDEF Win32}
  SetLength(Result, BlockSize);
  {$ENDIF}
  FData.Read(Result[1], BlockSize);
end;

function TGIFData.SkipBlock: byte;
{ skips a block }
begin
  FData.Read(Result, SizeOf(Result));
  FData.Seek(Result, 1);
end;

procedure TGIFData.SkipBlocks;
{ skips all blocks until block terminator }
begin
  while SkipBlock <> 0 do;
end;

procedure TGIFData.Decode;
{ FData must be valid - this routine destroys the position of FData }
var
  aFrame: TGIFFrame;
  SepChar: char;
  TSize: Cardinal;

begin
  if not assigned(FFrames) then   { will be assigned if already decoded }
  begin
    { fields }
    FData.Position:= 6;
    FData.Read(FLogicalScreenWidth, SizeOf(FLogicalScreenWidth));
    FData.Read(FLogicalScreenHeight, SizeOf(FLogicalScreenHeight));
    FData.Read(FPackedFields, SizeOf(FPackedFields));
    FData.Read(FBackgroundColorIndex, SizeOf(FBackgroundColorIndex));
    FData.Read(FPixelAspectRatio, SizeOf(FPixelAspectRatio));

    { global color table }
    FGlobalColorTable.Free;
    FGlobalColorTable:= nil;
    TSize:= GlobalColorTableSize;
    if TSize > 0 then
      FGlobalColorTable:= TColorTable.CreateFromStream(TSize, FData);

    { frame list - then load all subframes }
    FFrames:= TMPOwnedObjectList.Create;
    aFrame:= nil;
    try
      FData.Read(SepChar, SizeOf(SepChar));
      while SepChar <> ';' do { detect trailer }
      begin
        aFrame:= TGIFFrame.Create(Self);
        aFrame.Load;
        FFrames.Add(aFrame);
        aFrame:= nil;
        FData.Read(SepChar, SizeOf(SepChar));
      end; {while}
    except
      aFrame.Free;
      raise;
    end; {try}
  end; {if}
end;

function TGIFData.GetSignature: string;

var
  OldPos: longint;
  
begin
  {$IFDEF Win32}
  SetLength(Result, 3);
  {$ELSE}
  Result[0]:= #3;
  {$ENDIF}
  OldPos:= FData.Position;
  try
    FData.Position:= 0;
    FData.Read(Result[1], 3);
  finally
    FData.Position:= OldPos;
  end;
end;

function TGIFData.GetVersion: string;

var
  OldPos: longint;
  
begin
  {$IFDEF Win32}
  SetLength(Result, 3);
  {$ELSE}
  Result[0]:= #3;
  {$ENDIF}
  OldPos:= FData.Position;
  try
    FData.Position:= 3;
    FData.Read(Result[1], 3);
  finally
    FData.Position:= OldPos;
  end;
end;

function TGIFData.GetHasGlobalColorTable: boolean;
begin
  Result:= ((PackedFields and $80) <> 0);
end;

function TGIFData.GetColorResolution: byte;
begin
  Result:= (PackedFields shr 4) and $07;
end;

function TGIFData.GetHasSortedGlobalColorTable: boolean;
begin
  Result:= ((PackedFields and $08) <> 0);
end;

function TGIFData.GetGlobalColorTableSize: Cardinal;
begin
  if HasGlobalColorTable then
    Result:= 3 * (2 shl (PackedFields and $07))
  else
    Result:= 0;
end;

function TGIFData.GetFrame(Index: integer): TBitmap;
begin
  Decode;
  CheckFrameIndex(Index);
  Result:= TGIFFrame(FFrames[Index]).FBitmap;
end;

constructor TGIFImage.Create;
begin
  FTimerHandle:= -1;
  inherited Create;
  FImage:= TGIFData.Create;
  FImage.AddRef;
  if not assigned(TimerPool) then
  begin
    TimerPool:= TMPTimerPool.Create(nil);
    TimerPool.DefEnabled:= false;
  end; {if}
  FTimerHandle:= TimerPool.Add(NextImageEvent, DefInterval);
end;

destructor TGIFImage.Destroy;
begin
  FImage.Release;
  if assigned(TimerPool) and (FTimerHandle <> -1) then
  begin
    TimerPool.Remove(FTimerHandle);
    if TimerPool.Count = 0 then
    begin
      TimerPool.Free;
      TimerPool:= nil;
    end; {if}
  end; {if}
  inherited Destroy;
end;

procedure TGIFImage.Assign(Source: TPersistent);
begin
  if (not assigned(Source)) or (Source is ClassType) then
  begin
    if assigned(Source) then
      with Source as ClassType do
      begin
        Self.FImage.Release;
        Self.FImage:= FImage;
        Self.FImage.AddRef;
        Self.FFrame:= FFrame;
      end
    else
      NewImage;
    Changed(Self);
  end
  else
    if Source is TGraphic then
      raise EInvalidGraphicOperation.CreateFmt('Cannot assign to %s', [ClassName])
  else
    inherited Assign(Source);
end;

procedure TGIFImage.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  ACanvas.StretchDraw(Rect, Bitmap);
end;

function TGIFImage.GetFrameCount: integer;
begin
  if assigned(FImage) then
    Result:= FImage.FrameCount
  else
    Result:= 0;
end;

procedure TGIFImage.SetFrame(Value: integer);
begin
  if assigned(FImage) then
  begin
    if Value >= FrameCount then
      Value:= FrameCount -1
    else if Value < 0 then
      Value:= 0;

    if FFrame <> Value then
    begin
      FFrame:= Value;
      TimerPool.Interval[FTimerHandle]:= FImage.Interval[FFrame] * 10;
      Changed(Self);
    end; {if}
  end; {if}
end;

procedure TGIFImage.IncrementFrame;
begin
  if Frame < FrameCount -1 then
    Frame:= Frame + 1
  else
    Frame:= 0;
end;

procedure TGIFImage.DecrementFrame;
begin
  if Frame > 0 then
    Frame:= Frame - 1
  else
    Frame:= FrameCount -1;
end;

function TGIFImage.GetBitmap: TBitmap;
begin
  Result:= FImage.Frame[FFrame];
end;

function TGIFImage.GetEmpty: Boolean;
begin
  Result:= (not assigned(FImage.FData)) or (FImage.FData.Size = 0);
end;

function TGIFImage.GetHeight: integer;
begin
  if assigned(FImage) then
    Result:= FImage.LogicalScreenHeight
  else
    Result:= 0;
end;

function TGIFImage.GetWidth: integer;
begin
  if assigned(FImage) then
    Result:= FImage.LogicalScreenWidth
  else
    Result:= 0;
end;

procedure TGIFImage.LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE);
begin
end;

procedure TGIFImage.LoadFromStream(Stream: TStream);
begin
  ReadStream(Stream.Size - Stream.Position, Stream);
end;

procedure TGIFImage.NewImage;
begin
  FFrame:= -1;
  FImage.Release;
  FImage:= TGIFData.Create;
  FImage.AddRef;
end;

procedure TGIFImage.ReadData(Stream: TStream);

var
  Size: longint;

begin
  Stream.Read(Size, SizeOf(Size));
  ReadStream(Size, Stream);
end;

procedure TGIFImage.ReadStream(Size: longint; Stream: TStream);
begin
  NewImage;
  with FImage do
  begin
    FData:= TMemoryStream.Create;
    TMemoryStream(FData).SetSize(Size);
    Stream.ReadBuffer(FData.Memory^, Size);
  end; {with}
  Frame:= 0; { will call Changed and Decode }
end;

procedure TGIFImage.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
begin
  Bitmap.SaveToClipboardFormat(AFormat, AData, APalette);
end;

procedure TGIFImage.SaveToStream(Stream: TStream);
begin
  if not assigned(FImage.FData) then
    raise EInvalidGraphicOperation.Create('No GIF data');
  with FImage.FData do
    Stream.Write(Memory^, Size);
end;

procedure TGIFImage.SetHeight(Value: integer);
begin
  if assigned(FImage) then
    Value:= MinLong(FImage.LogicalScreenHeight, Value);
  if Value <> FHeight then
  begin
    FHeight:= Value;
    Changed(Self);
  end; {if}
end;

procedure TGIFImage.SetWidth(Value: integer);
begin
  if assigned(FImage) then
    Value:= MinLong(FImage.LogicalScreenWidth, Value);
  if Value <> FWidth then
  begin
    FWidth:= Value;
    Changed(Self);
  end; {if}
end;

procedure TGIFImage.WriteData(Stream: TStream);

var
  Size: longint;
  
begin
  Size:= 0;
  if assigned(FImage.FData) then
    Size:= FImage.FData.Size;
  Stream.Write(Size, Sizeof(Size));
  if Size > 0 then
    Stream.Write(FImage.FData.Memory^, Size);
end;

procedure TGifImage.SetInterval(Value: Cardinal);
begin
  { sets the interval of all images }
  FImage.Intervals:= Value;
end;

procedure TGifImage.AnimateOnce;
begin
  if not Animating then
  begin
    TimerPool.Times[FTimerHandle]:= FrameCount;
    TimerPool.Enabled[FTimerHandle]:= true;
  end; {if}
end;

procedure TGifImage.NextImageEvent(Sender: TObject; Handle: integer; IntervalTicks, ElapsedTicks: longint);
begin
  IncrementFrame;
end;

function TGifImage.GetAnimating: Boolean;
begin
  Result:= TimerPool.Enabled[FTimerHandle];
end;

procedure TGifImage.SetAnimating(Value: Boolean);
begin
  TimerPool.Enabled[FTimerHandle]:= Value;
end;

{$IFNDEF Win32}
procedure ExitProc; far;
begin
  TimerPool.Free;
end;
{$ENDIF}



initialization
  TPicture.RegisterFileFormat('GIF', 'Graphics Interchange Format', TGIFImage);
  {$IFNDEF Win32}
  AddExitProc(ExitProc);
  {$ELSE}
finalization
  TimerPool.Free;
  TPicture.UnregisterGraphicClass(TGIFImage);
  {$ENDIF}

end.
