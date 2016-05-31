unit ddPicture;

// ������: "w:\common\components\rtl\Garant\dd\ddPicture.pas"
// ���������: "SimpleClass"
// ������� ������: "TddPicture" MUID: (51E8DC3E0361)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddTextParagraph
 , Classes
 , l3Base
 , l3MetafileHeader
 , l3Filer
 , ddParagraphProperty
 , ddDocumentAtom
 , ddCustomDestination
 , k2Interfaces
 , ddTypes
 , l3ProtoObject
;

type
 TddPicture = class(TddTextParagraph)
  private
   f_NeedWMFHeader: Boolean;
   f_WMFHeader: Tl3MetafileHeader;
   f_IsBinary: Boolean;
   f_BPP: Integer;
   f_CropL: Integer;
   f_CropR: Integer;
   f_CropB: Integer;
   f_CropT: Integer;
   f_ExternalHandle: Integer;
   f_ExternalPath: AnsiString;
   f_Format: Integer;
   f_GoalX: Integer;
   f_GoalY: Integer;
   f_Height: Integer;
   f_ScaleX: Integer;
   f_ScaleY: Integer;
   f_Width: Integer;
   f_Stream: TStream;
   f_Picture: Tl3String;
   f_WidthInPixels: Integer;
   f_HeightInPixels: Integer;
  private
   procedure CropPicture;
   function HexToBinEx(aText: Tl3String;
    Buffer: PAnsiChar;
    BufSize: Integer): Integer;
    {* �������������� �� 16-������ �������� ������ � �������� ������ � ��������� �������� �������� ����� � ��������� ��������� ����. }
   function Try2ReadEMF(const aFiler: Tl3CustomFiler): Tl3String;
    {* ������ ���������� 16-������� ������ EMF. }
   {$If Defined(InsiderTest)}
   procedure SavePicture2File(aSize: Integer);
   {$IfEnd} // Defined(InsiderTest)
   function Try2ReadWMF(const aFiler: Tl3CustomFiler): Tl3String;
    {* ������ ���������� 16-������� ������ WMF. }
   procedure Try2RecalcPictureProps;
  protected
   procedure pm_SetIsBinary(aValue: Boolean);
   function pm_GetFormat: Integer;
   function pm_GetStream: TStream;
   procedure pm_SetStream(aValue: TStream);
   procedure pm_SetWidthInPixels(aValue: Integer);
   procedure pm_SetHeightInPixels(aValue: Integer);
   procedure ConvertToBin;
   procedure ConvertToHex;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   function GetEmpty: Boolean; override;
   procedure ClearFields; override;
  public
   procedure AddHexData(aHexStream: Tl3String);
    {* ��������� ������ � 16-������� ���������. }
   function Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
    {* �������� �������� ��������� "�������" ��������. }
   function Clone(aPAP: TddParagraphProperty): TddPicture;
   class function CreateFromFile(const aPath: AnsiString): TddPicture;
   procedure Try2ReadBinaryData(const aFiler: Tl3CustomFiler;
    aSize: Integer);
   procedure Clear; override;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   constructor Create(aDetination: TddCustomDestination); override;
   function IsTextPara: Boolean; override;
   function IsPicture: Boolean; override;
   function GetLastPara: TddDocumentAtom; override;
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
   function CanWrite: Boolean; override;
    {* ��������� ����������� ������ �������. ��������, ���� � �������� ��� �������� ������ � ������, �� ��� �� ������������. }
  public
   property IsBinary: Boolean
    read f_IsBinary
    write pm_SetIsBinary;
   property BPP: Integer
    read f_BPP
    write f_BPP;
   property CropL: Integer
    read f_CropL
    write f_CropL;
   property CropR: Integer
    read f_CropR
    write f_CropR;
   property CropB: Integer
    read f_CropB
    write f_CropB;
   property CropT: Integer
    read f_CropT
    write f_CropT;
   property ExternalHandle: Integer
    read f_ExternalHandle
    write f_ExternalHandle;
   property ExternalPath: AnsiString
    read f_ExternalPath
    write f_ExternalPath;
   property Format: Integer
    read pm_GetFormat
    write f_Format;
   property GoalX: Integer
    read f_GoalX
    write f_GoalX;
   property GoalY: Integer
    read f_GoalY
    write f_GoalY;
   property Height: Integer
    read f_Height
    write f_Height;
   property ScaleX: Integer
    read f_ScaleX
    write f_ScaleX;
   property ScaleY: Integer
    read f_ScaleY
    write f_ScaleY;
   property Width: Integer
    read f_Width
    write f_Width;
   property Stream: TStream
    read pm_GetStream
    write pm_SetStream;
   property Picture: Tl3String
    read f_Picture;
   property WidthInPixels: Integer
    write pm_SetWidthInPixels;
   property HeightInPixels: Integer
    write pm_SetHeightInPixels;
 end;//TddPicture

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3Chars
 , l3Memory
 , SysUtils
 , ddRTFUnits
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , k2Tags
 , l3Math
 , evdTypes
 , ddEVDTypesSupport
 , ddConst
 , l3ImageUtils
 , l3Metafile
 , Graphics
 , ddHexCharReader
 , Windows
 , ddPicturePathListner
;

procedure TddPicture.pm_SetIsBinary(aValue: Boolean);
//#UC START# *521AE2E301F2_51E8DC3E0361set_var*
//#UC END# *521AE2E301F2_51E8DC3E0361set_var*
begin
//#UC START# *521AE2E301F2_51E8DC3E0361set_impl*
 if aValue <> f_IsBinary then
 begin
  f_IsBinary:= aValue;
  if f_IsBinary then
   ConvertToBin
  else
   ConvertToHex;
 end;
//#UC END# *521AE2E301F2_51E8DC3E0361set_impl*
end;//TddPicture.pm_SetIsBinary

function TddPicture.pm_GetFormat: Integer;
//#UC START# *521AE90802CC_51E8DC3E0361get_var*
var
 l_Format: Integer;
 l_Detector: TImageEnIO;
//#UC END# *521AE90802CC_51E8DC3E0361get_var*
begin
//#UC START# *521AE90802CC_51E8DC3E0361get_impl*
 if f_Format = -1 then
 begin
  if f_Stream.Size > 1 then
  begin
   f_Stream.Seek(0, 0);
   l_Detector:= TImageEnIO.Create(nil);
   try
    l_Detector.LoadFromStream(Stream);
    f_Format:= l_Detector.Params.FileType;
    if f_Format <> ioUnknown then
    begin
     { ����� ��������� �������� ������, ������, ��������� � �.�. }
     if f_Height = 0 then
      f_Height := l_Detector.Params.Height;
     if f_Width = 0 then
      f_Width := l_Detector.Params.Width;
     f_BPP := l_Detector.Params.BitsPerSample;
    end; // l_Format <> ioUnknown
   finally
    FreeAndNil(l_Detector);
   end;
  end; // f_Stream.Size > 1
  f_Stream.Seek(0, 0);
 end;
 Result := f_Format;
//#UC END# *521AE90802CC_51E8DC3E0361get_impl*
end;//TddPicture.pm_GetFormat

function TddPicture.pm_GetStream: TStream;
//#UC START# *521AEA490067_51E8DC3E0361get_var*
//#UC END# *521AEA490067_51E8DC3E0361get_var*
begin
//#UC START# *521AEA490067_51E8DC3E0361get_impl*
 if not f_IsBinary then
  ConvertToBin;
 Result:= f_Stream;
//#UC END# *521AEA490067_51E8DC3E0361get_impl*
end;//TddPicture.pm_GetStream

procedure TddPicture.pm_SetStream(aValue: TStream);
//#UC START# *521AEA490067_51E8DC3E0361set_var*
//#UC END# *521AEA490067_51E8DC3E0361set_var*
begin
//#UC START# *521AEA490067_51E8DC3E0361set_impl*
 f_IsBinary:= True;
 aValue.Seek(0, 0);
 f_Stream.CopyFrom(aValue, aValue.Size);
 f_Stream.Position := 0;
//#UC END# *521AEA490067_51E8DC3E0361set_impl*
end;//TddPicture.pm_SetStream

procedure TddPicture.pm_SetWidthInPixels(aValue: Integer);
//#UC START# *55EE870702AD_51E8DC3E0361set_var*
//#UC END# *55EE870702AD_51E8DC3E0361set_var*
begin
//#UC START# *55EE870702AD_51E8DC3E0361set_impl*
 f_WidthInPixels := aValue;
//#UC END# *55EE870702AD_51E8DC3E0361set_impl*
end;//TddPicture.pm_SetWidthInPixels

procedure TddPicture.pm_SetHeightInPixels(aValue: Integer);
//#UC START# *55EE872A0092_51E8DC3E0361set_var*
//#UC END# *55EE872A0092_51E8DC3E0361set_var*
begin
//#UC START# *55EE872A0092_51E8DC3E0361set_impl*
 f_HeightInPixels := aValue;
//#UC END# *55EE872A0092_51E8DC3E0361set_impl*
end;//TddPicture.pm_SetHeightInPixels

procedure TddPicture.CropPicture;
//#UC START# *521AEAB901C0_51E8DC3E0361_var*
var
 l_Pic: TImageEnView;
 x1, x2, y1, y2: Integer;
 l_DPIX, l_DPIY: Integer;
//#UC END# *521AEAB901C0_51E8DC3E0361_var*
begin
//#UC START# *521AEAB901C0_51E8DC3E0361_impl*
 if (CropL <> 0) or (CropR <> 0) or (CropT <> 0) or (CropB <> 0) then
 begin
  l_Pic := TImageEnView.Create(nil);
  try
   l_Pic.IO.LoadFromStream(f_Stream);
   l_DPIX := l_Pic.DpiX;
   l_DPIY := l_Pic.DpiY;
   if l_Pic.DpiX > 96 then
    l_Pic.DpiX := 96;
   if l_Pic.DpiY > 96 then
    l_Pic.DpiY := 96;
   x1 := Twip2Pixel(CropL, l_PIC.DpiX);
   x2 := Twip2Pixel(CropR, l_PIC.DpiX);
   y1 := Twip2Pixel(CropT, l_PIC.DpiY);
   y2 := Twip2Pixel(CropB, l_PIC.DpiY);
   Height := 0;
   Width := 0;
   l_Pic.SelectionBase := iesbBitmap;
   l_Pic.Select(x1, y1, l_Pic.IO.Params.Width - x2, l_Pic.IO.Params.Height - y2, iespReplace);
   l_Pic.Proc.CropSel;
   if l_Pic.IO.Params.DPI > 96 then
    l_Pic.IO.Params.DPI := 96;
   f_Stream.Seek(0, 0);
   f_Stream.Size := 0;
   l_Pic.IO.SaveToStreamPNG(f_Stream);
   f_Stream.Seek(0, 0);
  finally
   FreeAndNil(l_Pic);
  end;
 end; // (CropL <> 0) or (CropR <> 0) or (CropT <> 0) or (CropB <> 0)
//#UC END# *521AEAB901C0_51E8DC3E0361_impl*
end;//TddPicture.CropPicture

procedure TddPicture.ConvertToBin;
//#UC START# *521AEACF0234_51E8DC3E0361_var*
var
 l_Buf : PAnsiChar;
 l_Size: Integer;
//#UC END# *521AEACF0234_51E8DC3E0361_var*
begin
//#UC START# *521AEACF0234_51E8DC3E0361_impl*
 if not f_Picture.Empty then
 begin
  l_Size := f_Picture.Len * 2 + 1;
  l3System.GetLocalMem(l_Buf, l_Size);
  try
   l3FillChar(l_Buf^, l_Size, 0);
   HexToBinEx(f_Picture, l_Buf, l_Size);
   f_Stream.Write(l_Buf^, l_Size);
   f_Stream.Seek(0, soBeginning);
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
  f_Picture.Clear;
 end;
 f_IsBinary:= True;
//#UC END# *521AEACF0234_51E8DC3E0361_impl*
end;//TddPicture.ConvertToBin

procedure TddPicture.ConvertToHex;
//#UC START# *521AEAE60288_51E8DC3E0361_var*
const
 l_EOL : PAnsiChar = cc_EOL;
var
 l_Bin       : array [0..8 * 1024 - 1] of AnsiChar;
 l_Hex       : array [0..8 * 1024 * 2 - 1] of AnsiChar;
 l_Count     : Longint;
 l_BinStream : TStream;
 l_HexStream : Tl3StringStream;
//#UC END# *521AEAE60288_51E8DC3E0361_var*
begin
//#UC START# *521AEAE60288_51E8DC3E0361_impl*
 if f_Stream.Size > 0 then
 begin
  l_HexStream := Tl3StringStream.Create(f_Picture);
  try
   f_Stream.Seek(0, 0);
   l_BinStream := f_Stream;
   while true do begin
    l_Count := l_BinStream.Read(l_Bin, SizeOf(l_Bin));
    if (l_Count = 0) then break;
    BinToHex(l_Bin, l_Hex, l_Count);
    l_HexStream.Write(l_Hex, l_Count * 2);
   end;//while true
  finally
   FreeAndNil(l_HexStream);
  end;//try..finally
 end;
 f_IsBinary:= False;
//#UC END# *521AEAE60288_51E8DC3E0361_impl*
end;//TddPicture.ConvertToHex

procedure TddPicture.AddHexData(aHexStream: Tl3String);
 {* ��������� ������ � 16-������� ���������. }
//#UC START# *5343AC66009C_51E8DC3E0361_var*
var 
 l_WMF    : Tl3Metafile;
 l_Size   : Int64;
 l_BinBuf : PAnsiChar;
//#UC END# *5343AC66009C_51E8DC3E0361_var*
begin
//#UC START# *5343AC66009C_51E8DC3E0361_impl*
 if (aHexStream = nil) or (aHexStream.Len = 0) then Exit;
 l_Size := aHexStream.Len div 2;
 try
  l3System.GetLocalMem(l_BinBuf, l_Size);
  try
   l_Size := HexToBinEx(aHexStream, l_BinBuf, l_Size); // ����� ����� ����� ������...
   if f_NeedWMFHeader then
    f_Stream.Write(f_WMFHeader, SizeOf(f_WMFHeader));
   f_Stream.Write(l_BinBuf^, l_Size);
  finally
   l3System.FreeLocalMem(l_BinBuf);
  end;
  if f_Format = pictWMF then // ������ WMF, ������������ � EMF
  begin
   l_WMF := Tl3Metafile.Create;
   try
    f_Stream.Seek(0, soBeginning);
    if f_NeedWMFHeader then
    begin
     l_WMF.LoadWMFFromStream(Stream);
     f_NeedWMFHeader := False;
    end // if f_NeedWMFHeader then
    else
     l_WMF.LoadFromStream(f_Stream);
    l_WMF.Enhanced := True;
    f_Stream.Seek(0, soBeginning);
    f_Stream.Size := 0;
    l_WMF.SaveToStream(f_Stream);
    l_Size := f_Stream.Size;
   finally
    l3Free(l_WMF);
   end;
  end; // if f_NeedWMFHeader then
  f_IsBinary := True;
  {$IFDEF InsiderTest}
  if f_Format > pictNONE then
   SavePicture2File(l_Size);
  {$ENDIF InsiderTest}
 except
  on EInvalidGraphic do
   f_Format := pictNONE;
 end;
//#UC END# *5343AC66009C_51E8DC3E0361_impl*
end;//TddPicture.AddHexData

function TddPicture.HexToBinEx(aText: Tl3String;
 Buffer: PAnsiChar;
 BufSize: Integer): Integer;
 {* �������������� �� 16-������ �������� ������ � �������� ������ � ��������� �������� �������� ����� � ��������� ��������� ����. }
//#UC START# *5343AD9A009A_51E8DC3E0361_var*
const
 Convert: array['0'..'f'] of SmallInt =
   ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
    -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
    -1,10,11,12,13,14,15);
var
 I            : Integer;
 l_Char       : AnsiChar;
 l_Next       : AnsiChar;
 l_CharSkipper: TddHexCharReader;
//#UC END# *5343AD9A009A_51E8DC3E0361_var*
begin
//#UC START# *5343AD9A009A_51E8DC3E0361_impl*
 I := BufSize;
 Result := 0;
 l_CharSkipper := TddHexCharReader.Create;
 try
  l_CharSkipper.Init(aText);
  while I > 0 do
  begin
   l_Char := l_CharSkipper.GetChar;
   if l_Char = #0 then Break;
   l_Next := l_CharSkipper.GetChar;
   if l_Next = #0 then Break;
   Buffer[0] := AnsiChar((Convert[l_Char] shl 4) + Convert[l_Next]);
   Inc(Buffer);
   Dec(I);
  end; // while I > 0 do
  Result := BufSize - I;
 finally
  l3Free(l_CharSkipper);
 end;
//#UC END# *5343AD9A009A_51E8DC3E0361_impl*
end;//TddPicture.HexToBinEx

function TddPicture.Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
 {* �������� �������� ��������� "�������" ��������. }
//#UC START# *5346587A0043_51E8DC3E0361_var*
//#UC END# *5346587A0043_51E8DC3E0361_var*
begin
//#UC START# *5346587A0043_51E8DC3E0361_impl*
 if f_Format = pictEMF then
  Result := Try2ReadEMF(aFiler)
 else
 if f_Format = pictWMF then
   Result := Try2ReadWMF(aFiler)
 else
  Result := nil;
//#UC END# *5346587A0043_51E8DC3E0361_impl*
end;//TddPicture.Try2ReadKnownPicture

function TddPicture.Try2ReadEMF(const aFiler: Tl3CustomFiler): Tl3String;
 {* ������ ���������� 16-������� ������ EMF. }
//#UC START# *534658AC032F_51E8DC3E0361_var*
var
 l_BufSize   : Integer;
 l_EnhHeader : TEnhMetaheader;
 l_HeaderStr : Tl3String;
 l_HeaderSize: Integer;
//#UC END# *534658AC032F_51E8DC3E0361_var*
begin
//#UC START# *534658AC032F_51E8DC3E0361_impl*
 Result := nil;
 l_HeaderSize := SizeOf(l_EnhHeader);
 l_BufSize := l_HeaderSize * 2;
 l_HeaderStr := aFiler.MakeReadString(l_BufSize, CP_ANSI);
 try
  HexToBinEx(l_HeaderStr, @l_EnhHeader, l_HeaderSize);
 finally
  l3Free(l_HeaderStr)
 end;
 if l_EnhHeader.dSignature = ENHMETA_SIGNATURE then
 begin
  aFiler.UngetChars(l_BufSize);
  Result := aFiler.MakeReadString(l_EnhHeader.nBytes, CP_ANSI);
 end // if l_EnhHeader.dSignature = ENHMETA_SIGNATURE then
 else
 begin
  aFiler.UngetChars(l_BufSize);
  f_Format := -1; // // ����� ���������� ImageEn...
 end;
//#UC END# *534658AC032F_51E8DC3E0361_impl*
end;//TddPicture.Try2ReadEMF

{$If Defined(InsiderTest)}
procedure TddPicture.SavePicture2File(aSize: Integer);
//#UC START# *534BBC6B006F_51E8DC3E0361_var*
var
 l_Str        : AnsiString;
 l_FileStream : TFileStream;
//#UC END# *534BBC6B006F_51E8DC3E0361_var*
begin
//#UC START# *534BBC6B006F_51E8DC3E0361_impl*
 if TddPicturePathListner.Instance.EnableSave then
 begin
  f_Stream.Position := 0;
  l_Str := TddPicturePathListner.Instance.GetUniqPictureNameWithPath(f_Format, True);
  l_FileStream := TFileStream.Create(l_Str, fmCreate);
  try
   l_FileStream.CopyFrom(f_Stream, aSize);
  finally
   l3Free(l_FileStream);
  end;
  TddPicturePathListner.Instance.AddPicturePath(l_Str);
 end; // if TddPicturePathListner.Instance.EnableSave then
//#UC END# *534BBC6B006F_51E8DC3E0361_impl*
end;//TddPicture.SavePicture2File
{$IfEnd} // Defined(InsiderTest)

function TddPicture.Try2ReadWMF(const aFiler: Tl3CustomFiler): Tl3String;
 {* ������ ���������� 16-������� ������ WMF. }
//#UC START# *54B77D750163_51E8DC3E0361_var*
var
 l_WMFHeader  : Tl3MetafileHeader;
 l_ReverseSize: Integer;
 l_MetaHeader : TMetaHeader;

 function lp_ReadMETA_PLACEABLERecord: Boolean;
 var
  l_BufSize   : Integer;
  l_HeaderStr : Tl3String;
  l_HeaderSize: Integer;
 begin
  Result := False;
  l_HeaderSize := SizeOf(l_WMFHeader);
  l_BufSize := l_HeaderSize * 2;
  l_HeaderStr := aFiler.MakeReadString(l_BufSize, CP_ANSI);
  try
   HexToBinEx(l_HeaderStr, @l_WMFHeader, l_HeaderSize);
   if l3IsValidMetafileHeader(l_WMFHeader) then
   begin
    Result := True;
    l_ReverseSize := l_BufSize;
   end // if IsValidMetafileHeader(l_WMFHeader) then
   else
    aFiler.UngetChars(l_BufSize);
  finally
   l3Free(l_HeaderStr)
  end;
 end;

 function lp_ReadMETA_HEADERRecord: Boolean;
 var
  l_BufSize   : Integer;
  l_HeaderStr : Tl3String;
  l_HeaderSize: Integer;
 begin
  Result := False;
  l_HeaderSize := SizeOf(l_MetaHeader);
  l_BufSize := l_HeaderSize * 2;
  Inc(l_ReverseSize, l_BufSize);
  l_HeaderStr := aFiler.MakeReadString(l_BufSize, CP_ANSI);
  try
   HexToBinEx(l_HeaderStr, @l_MetaHeader, l_HeaderSize);
   Result := l3IsValidMETA_HEADERRecord(l_MetaHeader);
   l_ReverseSize := l_BufSize;
  finally
   l3Free(l_HeaderStr)
  end;
 end;

var
 l_StrData: Tl3String absolute Result;

 procedure lp_ReadData(aReverseSize: Integer);
 begin
  aFiler.UngetChars(l_ReverseSize);
  Result := aFiler.MakeReadString(l_MetaHeader.mtSize, CP_ANSI);
 end;

 procedure lp_InitMETA_PLACEABLER;
 begin
  if (f_Width >= High(SmallInt)) or (f_Height >= High(SmallInt)) then Exit;
  l3FillChar(f_WMFHeader, SizeOf(f_WMFHeader), 0);
  f_WMFHeader.Key := c_WMFKey;
  f_WMFHeader.Inch := l3DefaultWMFDPI;
  with f_WMFHeader.Box do
  begin
   Right := f_Width;
   Bottom := f_Height;
  end; // with f_WMFHeader.Box do
  f_WMFHeader.CheckSum := l3ComputeAldusChecksum(f_WMFHeader);
  f_NeedWMFHeader := True;
 end;

var
 l_MetaFileH : TMetaHeader;
//#UC END# *54B77D750163_51E8DC3E0361_var*
begin
//#UC START# *54B77D750163_51E8DC3E0361_impl*
 Result := nil;
 l_ReverseSize := 0;
 if not lp_ReadMETA_PLACEABLERecord then
  lp_InitMETA_PLACEABLER;
 if lp_ReadMETA_HEADERRecord then
  lp_ReadData(l_ReverseSize)
 else
 begin
  if Result = nil then
   aFiler.UngetChars(l_ReverseSize);
  f_NeedWMFHeader := False;
  f_Format := -1; // ����� ���������� ImageEn...
 end;
//#UC END# *54B77D750163_51E8DC3E0361_impl*
end;//TddPicture.Try2ReadWMF

function TddPicture.Clone(aPAP: TddParagraphProperty): TddPicture;
//#UC START# *54F71A0201D3_51E8DC3E0361_var*
//#UC END# *54F71A0201D3_51E8DC3E0361_var*
begin
//#UC START# *54F71A0201D3_51E8DC3E0361_impl*
 Result := TddPicture.Create(f_Destination);
 Result.Assign(Self);
 if aPAP <> nil then
  Result.PAP := aPAP; 
//#UC END# *54F71A0201D3_51E8DC3E0361_impl*
end;//TddPicture.Clone

class function TddPicture.CreateFromFile(const aPath: AnsiString): TddPicture;
//#UC START# *554C7AD301AD_51E8DC3E0361_var*
var
 l_Picture   : TddPicture;
 l_FileStream: TFileStream;
//#UC END# *554C7AD301AD_51E8DC3E0361_var*
begin
//#UC START# *554C7AD301AD_51E8DC3E0361_impl*
 Result := nil;
 if not FileExists(aPath) then Exit;
 l_FileStream := TFileStream.Create(aPath, fmOpenRead);
 try
  l_Picture := TddPicture.Create(nil);
  l_Picture.Stream.CopyFrom(l_FileStream, l_FileStream.Size);
  Result := l_Picture;
 finally
  l3Free(l_FileStream);
 end;
//#UC END# *554C7AD301AD_51E8DC3E0361_impl*
end;//TddPicture.CreateFromFile

procedure TddPicture.Try2ReadBinaryData(const aFiler: Tl3CustomFiler;
 aSize: Integer);
//#UC START# *55D6FFCC03AA_51E8DC3E0361_var*
var
 l_Size  : Integer;
 l_Buffer: PAnsiChar;
//#UC END# *55D6FFCC03AA_51E8DC3E0361_var*
begin
//#UC START# *55D6FFCC03AA_51E8DC3E0361_impl*
 l3System.GetLocalMem(l_Buffer, aSize);
 try
  aFiler.Read(l_Buffer, aSize);
  Stream.WriteBuffer(l_Buffer^, aSize);
 finally
  l3System.FreeLocalMem(l_Buffer);
 end;
 f_IsBinary := True;
//#UC END# *55D6FFCC03AA_51E8DC3E0361_impl*
end;//TddPicture.Try2ReadBinaryData

procedure TddPicture.Try2RecalcPictureProps;
//#UC START# *55EE87A90390_51E8DC3E0361_var*
var
 l_Pic     : TImageEnView;
 l_DPIX    : Integer;
 l_DPIY    : Integer;
 l_NeedSave: Boolean;
//#UC END# *55EE87A90390_51E8DC3E0361_var*
begin
//#UC START# *55EE87A90390_51E8DC3E0361_impl*
 l_Pic := TImageEnView.Create(nil);
 try
  l_Pic.IO.LoadFromStream(f_Stream);
  l_NeedSave := False;
  l_DPIX := l_Pic.DpiX;
  l_DPIY := l_Pic.DpiY;
  if (l_DPIY <> 0) and (l_DPIY <> 0) then
  begin
   f_Width := Pixel2Twip(l_Pic.Width);
   f_Height := Pixel2Twip(Trunc(l_Pic.Height * f_HeightInPixels / f_WidthInPixels));
   if l_DPIX > 96 then
   begin
    l_Pic.DpiX := 96;
    l_NeedSave := True;
   end; // if l_Pic.DpiX > 96 then
   if l_DPIY > 96 then
   begin
    l_Pic.DpiY := 96;
    l_NeedSave := True;
   end; // if l_Pic.DpiY > 96 then
   if l_NeedSave then
   begin
    f_Stream.Seek(0, 0);
    f_Stream.Size := 0;
    l_Pic.IO.SaveToStreamPNG(f_Stream);
    f_Stream.Seek(0, 0);
   end; // if l_NeedSave then
  end; // if (l_DPIY <> 0) and (l_DPIY <> 0) then
 finally
  FreeAndNil(l_Pic);
 end;
//#UC END# *55EE87A90390_51E8DC3E0361_impl*
end;//TddPicture.Try2RecalcPictureProps

procedure TddPicture.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_51E8DC3E0361_var*
//#UC END# *479731C50290_51E8DC3E0361_var*
begin
//#UC START# *479731C50290_51E8DC3E0361_impl*
 FreeAndNil(f_Picture);
 FreeAndNil(f_Stream);
 inherited;
//#UC END# *479731C50290_51E8DC3E0361_impl*
end;//TddPicture.Cleanup

function TddPicture.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_51E8DC3E0361_var*
//#UC END# *4A54E03B009A_51E8DC3E0361_var*
begin
//#UC START# *4A54E03B009A_51E8DC3E0361_impl*
 Result := f_Stream.Size = 0;
//#UC END# *4A54E03B009A_51E8DC3E0361_impl*
end;//TddPicture.GetEmpty

procedure TddPicture.Clear;
//#UC START# *518A48F500CF_51E8DC3E0361_var*
//#UC END# *518A48F500CF_51E8DC3E0361_var*
begin
//#UC START# *518A48F500CF_51E8DC3E0361_impl*
 inherited;
 f_Picture.Clear;
 f_Stream.Seek(0, 0);
 f_Stream.Size:= 0;
 f_Format := -1;
 f_Height := 0;
 f_Width  := 0;
 f_ScaleX := 100;
 f_ScaleY := 100;
 f_GoalX  := 0;
 f_GoalY  := 0;
 f_BPP    := 0;
 f_CropL  := 0;
 f_CropR  := 0;
 f_CropT  := 0;
 f_CropB  := 0;
 f_NeedWMFHeader := False;
//#UC END# *518A48F500CF_51E8DC3E0361_impl*
end;//TddPicture.Clear

procedure TddPicture.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_51E8DC3E0361_var*
var
 l_Width  : Integer;
 l_Height : Integer;
//#UC END# *518A504F00F5_51E8DC3E0361_var*
begin
//#UC START# *518A504F00F5_51E8DC3E0361_impl*
 if Width = 0 then
  l_Width := 0
 else
  l_Width := l3MulDiv(Width, ScaleX, 100);
 if Height = 0 then
  l_Height := 0
 else
  l_Height := l3MulDiv(Height, ScaleY, 100);
 if (l_Width = 0) and (l_Height = 0) then
  if (f_WidthInPixels > 0) and (f_HeightInPixels > 0) then
  begin
   Try2RecalcPictureProps;
   l_Height := Height;
   l_Width := Width;
  end; // if (f_WidthInPixel > 0) and (f_HeightInPixel > 0) then
 if (l_Width > 0) and (l_Height > 0) then
 begin
  CropPicture;
  if (l_Width >= f_Destination.GetMinPictureWidth) or (l_Height >= f_Destination.GetMinPictureHeight) then
  begin
   StartBitmapPara(Generator);
   try
    Generator.AddIntegerAtom(k2_tiExternalHandle, ExternalHandle);
    Generator.AddStringAtom(k2_tiExternalpath, ExternalPath);
    Generator.AddIntegerAtom(k2_tiWidth, l_Width);
    Generator.AddIntegerAtom(k2_tiHeight, l_Height);
    with PAP do
    begin
     case Just of
      justR: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
      justC: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itCenter));
      justF: Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itWidth));
     else
      Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
     end; { case Just}
     Border.Write2Generator(Generator);
    end; {  with }
    if not f_IsBinary then
     ConvertToBin;
    Generator.AddStreamAtom(k2_tiData, Stream);
   finally
    Generator.Finish;
   end;
  end; // if (l_Width > f_Destination.GetMinPictureWidth) and (l_Width < f_Destination.GetMinPictureWidth) then
 end; // if (l_Width >= 0) and (l_Height >= 0) then
//#UC END# *518A504F00F5_51E8DC3E0361_impl*
end;//TddPicture.Write2Generator

constructor TddPicture.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_51E8DC3E0361_var*
//#UC END# *51E91BA80051_51E8DC3E0361_var*
begin
//#UC START# *51E91BA80051_51E8DC3E0361_impl*
 inherited Create(aDetination);
 f_Picture := Tl3String.Create;
 f_Format := -1;
 f_Stream := Tl3MemoryStream.Make;
 f_IsBinary := False;
 f_ScaleX := 100;
 f_ScaleY := 100;
 f_NeedWMFHeader := False;
//#UC END# *51E91BA80051_51E8DC3E0361_impl*
end;//TddPicture.Create

function TddPicture.IsTextPara: Boolean;
//#UC START# *5268D5950076_51E8DC3E0361_var*
//#UC END# *5268D5950076_51E8DC3E0361_var*
begin
//#UC START# *5268D5950076_51E8DC3E0361_impl*
 Result := False;
//#UC END# *5268D5950076_51E8DC3E0361_impl*
end;//TddPicture.IsTextPara

function TddPicture.IsPicture: Boolean;
//#UC START# *5268D62B022C_51E8DC3E0361_var*
//#UC END# *5268D62B022C_51E8DC3E0361_var*
begin
//#UC START# *5268D62B022C_51E8DC3E0361_impl*
 Result := True;
//#UC END# *5268D62B022C_51E8DC3E0361_impl*
end;//TddPicture.IsPicture

function TddPicture.GetLastPara: TddDocumentAtom;
//#UC START# *5268DBC503E2_51E8DC3E0361_var*
//#UC END# *5268DBC503E2_51E8DC3E0361_var*
begin
//#UC START# *5268DBC503E2_51E8DC3E0361_impl*
 Result := nil;
//#UC END# *5268DBC503E2_51E8DC3E0361_impl*
end;//TddPicture.GetLastPara

procedure TddPicture.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_51E8DC3E0361_var*
var
 l_Count  : Integer;
 l_Picture: TddPicture;
//#UC END# *528C8C2F02D9_51E8DC3E0361_var*
begin
//#UC START# *528C8C2F02D9_51E8DC3E0361_impl*
 if aDocAtomObj is TddPicture then
 begin
  l_Picture := TddPicture(aDocAtomObj);
  if l_Picture.Picture.Empty then
  begin
   l_Count := f_Stream.CopyFrom(l_Picture.Stream, 0);
   f_Stream.Seek(0, 0);
   f_IsBinary := l_Picture.IsBinary;
  end // if TddPicture(aDocAtomObj).Picture.Empty then
  else
   f_Picture.Assign(l_Picture.Picture);
  f_Format := l_Picture.Format;
  f_Height := l_Picture.Height;
  f_Width  := l_Picture.Width;
  f_ScaleX := l_Picture.ScaleX;
  f_ScaleY := l_Picture.ScaleY;
  f_GoalX  := l_Picture.GoalX;
  f_GoalY  := l_Picture.GoalY;
  f_BPP    := l_Picture.BPP;
  f_CropL  := l_Picture.CropL;
  f_CropR  := l_Picture.CropR;
  f_CropT  := l_Picture.CropT;
  f_CropB  := l_Picture.CropB;
  f_HeightInPixels := l_Picture.f_HeightInPixels;
  f_WidthInPixels := l_Picture.f_WidthInPixels;
 end // if aDocAtomObj is TddPicture then
 else
  inherited;
//#UC END# *528C8C2F02D9_51E8DC3E0361_impl*
end;//TddPicture.Assign

function TddPicture.CanWrite: Boolean;
 {* ��������� ����������� ������ �������. ��������, ���� � �������� ��� �������� ������ � ������, �� ��� �� ������������. }
//#UC START# *55D71C0C0164_51E8DC3E0361_var*
//#UC END# *55D71C0C0164_51E8DC3E0361_var*
begin
//#UC START# *55D71C0C0164_51E8DC3E0361_impl*
 Result := (Width <> 0) and (Height <> 0)
//#UC END# *55D71C0C0164_51E8DC3E0361_impl*
end;//TddPicture.CanWrite

procedure TddPicture.ClearFields;
begin
 ExternalPath := '';
 inherited;
end;//TddPicture.ClearFields

end.
