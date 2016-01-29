{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DIFFMAKE;

interface
{$I dc.inc}
Uses
  Windows , SysUtils, Classes, dialogs,dcsystem,dcconsts,dcdreamlib;

{----------------------------------------------------------------------}

{ Finishes calculation of CRC. If you don't need compartability with PKZIP's
  CRC algorythm you may not call this function.}
function  CRC32Finish(CRC:Integer):Integer;

{ Returns initialized CRC variable (Assigns value $FFFFFFFF to it). CRC variable
  must be initialized before calculating CRC.}
function  CRC32Start:DWord;

{ Calculates CRC for a given memory buffer.

  @param Buf memory buffer
  @param CRC initial CRC value (result of previuos call to CRC32Calc or $FFFFFFFF).
  @BufSize buffer size.

  @result new CRC value}
function  CRC32Calc(Var Buf;CRC:DWord;BufSize:Integer):Integer;

{ Calculates CRC value for a given buffer. This function calls CRC32Start,
  CRC32Calc,CRC32finish internally and returns calculated CRC value.}
Function  CalculateCRC32(VAR Buf;Count:Integer):Integer;

{ Low level difference making routine.

  @param InStream stream that need to be compressed (for example new version of a file)
  @param UseStream stream that will be used (for example old version of a file)
  @param OutStream output stream (delta file)
  @param MaxLev compression level (10..1000, 10 - maximal speed, minimal compression ratio,
      1000 - minimal speed, maximal compression ratio)

  @see DiffStreamExtract
}
procedure DiffStreamCompress(InStream,UseStream,OutStream:TStream;MaxLev:Integer);

{ Low level routine for applying delta (previously created with DiffStreamCompress procedure)
  to the old data

  @param InStream  stream with delta
  @param UseStream stream that will be used (old version of a file)
  @param OutStream output stream (new version of a file)

  @see DiffStreamCompress
}
procedure DiffStreamExtract(InStream,UseStream,OutStream:TStream);

{-------------------------------------------------}

type
{
Suppose that you must send to smb. a 5mb file via e-mail (or other way) each
two or three days. Suppose that only 8% of this file is changed and 92% of
its contents remains the same. First time you send whole 5MB file. But
after that you don't need to send all 5MB. You should use program which
will "find" these 8%,"cut" them from the file and send only this small
portion. And later on receiving side combine received 8% with old
version of the file.

TDiffMaker component compresses file taking into account previous file version.
Data integrity is checked with CRC32 algorithm.

For example we use TDiffMaker for compressing database dumps. Also TDiffMaker
can be used for creating installation packages when newer version of program
wasn't changed too much from older version.

Now compressed with diffmaker files can be compressed with ordinary
compression program (RAR,PKZIP,etc.). 
}
  TDiffMaker=class(TComponent)
  private
    FInFile:String;
    FOutFile:String;
    FUseFile:String;
    FCompLevel:Integer;
    FVersion : TDCVersion;
    procedure SetCompLevel(V:Integer);
    procedure InternalProcess(ACompress:boolean);
  protected
  public
    { Call this method to create delta file (OutFile) from new version of file (InFile)
      using information in old version of file (UseFile).

      @see DiffStreamCompress, DiffStreamExtract
    }
    procedure Compress;

    { Call this method to apply delta file (InFile) to old file (UseFile) and create
      new file (OutFile)

      @see DiffStreamCompress, DiffStreamExtract
    }
    procedure Extract;
    constructor Create(AOwner:TComponent);override;
  published

    { Input file name. When compressing input file is new version of file.
      When extracting input file is delta file.
    }
    property InFile:String Read FInFile Write FInFile;

    { Output file name. When compressing output file is delta file which will
      be created. When extracting output file is new version of file (old file plus
      applied delta) which will be created.
    }
    property OutFile:String Read FOutFile Write FOutFile;

    { Use file name. This file will be used for compression/extraction. Specify
      old file version here.
    }
    property UseFile:String Read FUseFile Write FUseFile;

    { This property specifies compression level. Compression level can be from 10
      (quickest compression, minimal compression ration) to 1000 (slowest
       compression, maximal compression ratio). Default value is 25.
    }
    property CompLevel:Integer Read FCompLevel Write SetCompLevel;
    property Version : TDCVersion read FVersion  write FVersion stored false;
  end;

{-------------------------------------------------}

{ Call this procedure to register filename property editor for
  properties InFile,OutFile and UseFile of TDiffMake component.

  This procedure is used by \DEMO\DIFFGUI\diffgui.dpr demo project.
}

implementation

Const
  BufSize=1024*1024;

type
  PInteger=^Integer;
  TByteArray=Array[1..MaxInt] of byte;
  PByteArray=^TByteArray;

     TDiffCompData=record
       InBuf      : PByteArray;      {pointer to input buffer}
       UseBuf     : PByteArray;      {pointer to use buffer}
       InBufSize  : integer;         {input buffer size}
       UseBufSize : integer;         {use buffer size}
       MaxLevel   : integer;         {max search level}
       MaxLength  : integer;         {max string length}
       MinLength  : integer;         {min string length}
       OutBuf     : PByteArray;
       OutSpBuf   : PByteArray;
       OutBufSize : PInteger;
       OutSpBufSize:PInteger;
       EnoughLen   :integer;
     end;

{----------------------------------------------------------------}

procedure DiffCompress(D:TDiffCompData);forward;

{----------------------------------------------------------------}

function comp(var a,b;len:integer):integer; assembler;
asm
    PUSH ESI
    PUSH EDI
    mov esi,a
    mov edi,b
    cld
    mov eax,len
    mov ecx,eax
    rep cmpsb
    inc ecx
    sub eax,ecx
    POP EDI
    POP ESI
end;

{-------------------------------------------------}

Const
  MaxHashValue=131071;
  cMaxFastData=6;

type
  t3word=record
    len:word;
    useofs:integer;
    bufofs:integer;
  end;
  p3word=^t3word;

  arrayt3word=array[0..Maxint div 20] of t3word;
  parrayt3word=^arrayt3word;

  THashTable=Array[0..MaxHashValue] of Integer;
  PHashTable=^THashTable;
  THashList=Array[1..MaxInt div 4] of integer;
  PHashList=^THashList;


{--------------------------------------------------------}

procedure DiffCompress(D:TDiffCompData);
Var
  HTab:PHashTable;
  HList:PHashList;
  i:integer;
  a,b,c:integer;
  h:integer;
  curofs:integer;
  curlen:integer;
  curlevel:integer;
  templen:integer;
  tempOFs:Integer;
  oldh:integer;
  x:integer;
  t3:t3word;
  curpos,cursppos:integer;

Label
  l3,l2,l1;
begin
  With D do
  begin

  If (InBufSize<4) or (UseBufSize<4) then
    raise Exception.Create(SErrSmallBuffer);
  CurOfs:=0;
  CurPos:=1;
  CurSpPos:=1;
  New(HTab);
  GetMem(HList,UseBufSize*4);
  try
    FillChar(HTab^,Sizeof(THashTable),0);
    a:=UseBuf[1];
    b:=UseBuf[2];
    c:=UseBuf[3];
    oldh:=maxint;
    For i:=1 to UseBufSize-4 do
    begin
      h:=(a shl 9) xor (b shl 5) xor c;
       If h<>oldh then
       begin
        HList^[i]:=HTab^[h];
        HTab^[h]:=i;
        oldh:=h;
       end;
      a:=b;b:=c;c:=UseBuf[i+3];
    end;
    {-------}
    i:=1;
    While i<=InBufSize do
    begin
      a:=InBuf[i];
      if i>inbufsize-3 then goto l1;
      h:=(a shl 9) xor (InBuf[i+1] shl 5) xor InBuf[i+2];
      curlen:=minlength-1;
      TempOFs:=HTab^[h];
      curlevel:=0;
      While (tempofs<>0) and (CurLevel<MaxLevel) do
      begin
        x:=Min(InBufSize-i,UseBufSize-TempOFs);
        templen:=Comp(InBuf[i],UseBuf[TempOfs],x) and $0000ffff;
        If TempLen>CurLen then
        begin
          CurLen:=TempLen;
          CurOfs:=TempOfs;
        end;
     l3:
        TempOfs:=HList^[TempOfs];
        inc(CurLevel);
      end;
      If CurLen<MinLength then
      begin
      l1:
        OutBuf[CurPos]:=a;
        inc(CurPos);
        Inc(i);
      end else
      begin
    l2:
       t3.len:=CurLen;
       t3.useofs:=CurOfs;
       t3.bufofs:=i;
       Move(t3,OutSpBuf[CurSpPos],SizeOf(t3));
       inc(CurSpPos,SizeOf(t3));
       Inc(i,CurLen);
      end;
    end;
    {-------}
    t3.len:=0;
    t3.useofs:=0;
    t3.bufofs:=InBufSize+1;
    Move(t3,OutSpBuf[CurSpPos],SizeOf(t3));
    inc(CurSpPos,SizeOf(t3));
    OutBufSize^:=CurPos-1;
    OutSpBufSize^:=CurSpPos-1;
  finally
    Dispose(HTab);
    FreeMem(HList,UseBufSize*4);
  end;
  end;
end;

{-------------------------------------------------}

procedure DiffStreamCompress(InStream,UseStream,OutStream:TStream;MaxLev:Integer);
Var
   Buf,Temp,OutBuf,OutSpBuf:PByteArray;
   BufRead,TempRead:Integer;
{----}

procedure WriteByte(A:Byte);
begin
  OutStream.Write(A,1);
end;

{----}

procedure WriteInt(A:Integer);
begin
  OutStream.Write(A,SizeOF(Integer));
end;

{----}

procedure CompressBuf(Var aInBuf,aUseBuf;BufSize,UseSize,MaxLev:Integer);
Var
  dat:TDiffCompData;
  obufsize,ospbufsize:integer;
begin
    Dat.OutBuf     :=OutBuf;
    Dat.OutSpBuf   :=OutSpBuf;
    With dat do
    begin
       InBuf      :=@TByteArray(aInBuf);
       UseBuf     :=@TByteArray(aUseBuf);
       InBufSize  :=BufSize;
       UseBufSize :=UseSize;
       MaxLevel   :=MaxLev;
       MaxLength  :=65535;
       MinLength  :=20;
       OutBufSize :=@obufsize;
       OutSpBufSize:=@ospbufsize;
       EnoughLen:=1024;
    end;
    obufsize:=0;
    ospbufsize:=0;
    DiffCompress(Dat);

    WriteInt(OBufSize);
    WriteInt(OSpBufSize);
    OutStream.Write(OutBuf^,OBufSize);

    OutStream.Write(OutSpBuf^,OSpBufSize);
end;

label l1;

{----}

begin
  GetMem(Buf,BufSize);
  GetMem(Temp,BufSize);
  GetMem(OutBuf,BufSize);
  GetMem(OutSpBuf,BufSize);
  try
    BufRead:=1;
    While BufRead<>0 do
    begin
      BufRead:=InStream.Read(Buf^,BufSize);
      TempRead:=UseStream.Read(Temp^,BufSize);
      {--}
      WriteInt(TempRead);
      If (BufRead<4) or (TempRead<4) or (BufRead div 4>TempRead) then
      begin
        WriteByte(0); {block copied flag}
        WriteInt(BufRead);
        if bufread=0 then goto l1;
        WriteInt(CalculateCRC32(Buf^,Bufread));
        OutStream.Write(Buf^,BufRead);
      end else
      begin
        WriteByte(1);{block compressed flag}
        WriteInt(CalculateCRC32(Buf^,Bufread));
        WriteInt(CalculateCRC32(Temp^,Tempread));
        CompressBuf(Buf^,Temp^,BufRead,TempRead,MaxLev);
      end;
      l1:
    end;
  finally
    FreeMem(OutBuf,BufSize);
    FreeMem(OutSpBuf,BufSize);
    FreeMem(Buf,BufSize);
    FreeMem(Temp,BufSize);
  end;
end;

{-------------------------------------------------}

procedure DiffStreamExtract(InStream,UseStream,OutStream:TStream);
Var
   Buf,Temp,OutBuf,OutSpBuf:PByteArray;
   curoutpos,BufRead,TempRead:Integer;

{----}

Function ReadByte:Byte;
begin
  InStream.Read(Result,1);
end;

{----}

Function ReadInt:Integer;
begin
  InStream.Read(Result,SizeOF(Integer));
end;

{----}

procedure ExtractBuf;
Var
  obufsize,ospbufsize:integer;
  p:parrayt3word;
  d,er,len,useofs,bufofs,i,psize:integer;
begin
    OBufSize:=ReadInt;
    OSpBufSize:=ReadInt;

    InStream.Read(Buf^,OBufSize);
    InStream.Read(OutSpBuf^,OSpBufSize);
    p:=pointer(OutSpBuf);
    psize:=OSpBufSize div sizeof(t3word);
    er:=1;
    curoutpos:=1;
    For i:=0 to PSize-1 do
    begin
      len:=p^[i].len;
      useofs:=p^[i].useofs;
      bufofs:=p^[i].bufofs;

      d:=BufOfs-CurOutPos;
      If d<>0 then
      begin
        Move(Buf[er],OutBuf[CurOutPos],d);
        inc(er,d);
        inc(CurOutPos,d);
      end;
      Move(Temp[UseOFs],OutBuf[CurOutPos],Len);
      inc(CurOutPos,len);
    end;
end;
{----}

Var CRC,BufCRC:Integer;
label l1;
begin
  try
    GetMem(Buf,BufSize);
    GetMem(Temp,BufSize);
    GetMem(OutBuf,BufSize);
    GetMem(OutSpBuf,BufSize);
    BufRead:=1;
    While BufRead<>0 do
    begin
       TempRead:=ReadInt;
       UseStream.Read(Temp^,Tempread);
       Case ReadByte of
         0: begin //copy
              BufRead:=ReadInt;
              If bufread=0 then goto l1;
              CRC:=ReadInt;
              InStream.Read(Buf^,Bufread);
              If CRC<>CalculateCRC32(Buf^,Bufread) then
                raise Exception.Create(SErrCRC);
              OutStream.Write(Buf^,BufRead);
            end;
         1: begin //extract
              BufCRC:=ReadInt;
              CRC:=ReadInt;{tempcrc}
              if CRC<>CalculateCRC32(Temp^,Tempread) then
                raise Exception.Create(SErrCRC);
              ExtractBuf;
              If BufCRC<>CalculateCRC32(OutBuf^,CurOutPos-1) then
                raise Exception.Create(SErrCRC);
              OutStream.Write(OutBuf^,CurOutPos-1);
            end;
         else raise Exception.Create(SErrCRC);
       end;
    l1:
    end;
  finally
    FreeMem(OutBuf,BufSize);
    FreeMem(OutSpBuf,BufSize);
    FreeMem(Buf,BufSize);
    FreeMem(Temp,BufSize);
  end;
end;

{----------------------------------------------------------------------}

Function CalculateCRC32(VAR Buf;Count:Integer):Integer;
begin
  Result:=not CRC32Calc(Buf,$FFFFFFFF,Count);
end;

{----------------------------------------------------------------------}

//const
//  TestString: String[31] = 'Testing CRC32 routine ... ';
//  PKZIP_CRC = $6759C95B;

{----------------------------------------------------------------------}

Const
aTableCRC32:Array[0..255] of dword = (
{;           $}
            $00000000, $77073096, $ee0e612c, $990951ba,
            $076dc419, $706af48f, $e963a535, $9e6495a3,
            $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,
            $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91,
{;            1}
            $1db71064, $6ab020f2, $f3b97148, $84be41de,
            $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
            $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec,
            $14015c4f, $63066cd9, $fa0f3d63, $8d080df5,
{;            2}
            $3b6e20c8, $4c69105e, $d56041e4, $a2677172,
            $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b,
            $35b5a8fa, $42b2986c, $dbbbc9d6, $acbcf940,
            $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
{;            3}
            $26d930ac, $51de003a, $c8d75180, $bfd06116,
            $21b4f4b5, $56b3c423, $cfba9599, $b8bda50f,
            $2802b89e, $5f058808, $c60cd9b2, $b10be924,
            $2f6f7c87, $58684c11, $c1611dab, $b6662d3d,
{;            4}
            $76dc4190, $01db7106, $98d220bc, $efd5102a,
            $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
            $7807c9a2, $0f00f934, $9609a88e, $e10e9818,
            $7f6a0dbb, $086d3d2d, $91646c97, $e6635c01,
{;            5}
            $6b6b51f4, $1c6c6162, $856530d8, $f262004e,
            $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457,
            $65b0d9c6, $12b7e950, $8bbeb8ea, $fcb9887c,
            $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
{;            6}
            $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2,
            $4adfa541, $3dd895d7, $a4d1c46d, $d3d6f4fb,
            $4369e96a, $346ed9fc, $ad678846, $da60b8d0,
            $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9,
{;            7}
            $5005713c, $270241aa, $be0b1010, $c90c2086,
            $5768b525, $206f85b3, $b966d409, $ce61e49f,
            $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4,
            $59b33d17, $2eb40d81, $b7bd5c3b, $c0ba6cad,
{;            8}
            $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,
            $ead54739, $9dd277af, $04db2615, $73dc1683,
            $e3630b12, $94643b84, $0d6d6a3e, $7a6a5aa8,
            $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
{;            9}
            $f00f9344, $8708a3d2, $1e01f268, $6906c2fe,
            $f762575d, $806567cb, $196c3671, $6e6b06e7,
            $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,
            $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5,
{;            A}
            $d6d6a3e8, $a1d1937e, $38d8c2c4, $4fdff252,
            $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
            $d80d2bda, $af0a1b4c, $36034af6, $41047a60,
            $df60efc3, $a867df55, $316e8eef, $4669be79,
{;            B}
            $cb61b38c, $bc66831a, $256fd2a0, $5268e236,
            $cc0c7795, $bb0b4703, $220216b9, $5505262f,
            $c5ba3bbe, $b2bd0b28, $2bb45a92, $5cb36a04,
            $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
{;            C}
            $9b64c2b0, $ec63f226, $756aa39c, $026d930a,
            $9c0906a9, $eb0e363f, $72076785, $05005713,
            $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,
            $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21,
{;            D}
            $86d3d2d4, $f1d4e242, $68ddb3f8, $1fda836e,
            $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
            $88085ae6, $ff0f6a70, $66063bca, $11010b5c,
            $8f659eff, $f862ae69, $616bffd3, $166ccf45,
{;            E}
            $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,
            $a7672661, $d06016f7, $4969474d, $3e6e77db,
            $aed16a4a, $d9d65adc, $40df0b66, $37d83bf0,
            $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
{;            F}
            $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6,
            $bad03605, $cdd70693, $54de5729, $23d967bf,
            $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,
            $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d
);

{----------------------------------------------------------------------}
function CRC32Calc(Var Buf;CRC:DWord;BufSize:Integer):Integer;assembler;
asm
  push esi
  mov esi,Buf
@1:
  movzx eax,byte ptr [esi]
  inc ESI
  xor al,dl
  shr edx,8
  xor edx,dword ptr [atablecrc32+eax*4]
  Loop @1
  mov eax,edx
  pop esi
end;

{----------------------------------------------------------------------}
{ Tests CRC algorythm. Returns true if Ok. This function is for testing
  purposes only and you don't need to call it.}

{Function TestCRC:Boolean;
Var
  CRC:Integer;
begin
  CRC:=not CRC32Calc(TestString[1],$ffffffff,Length(TestString));
  Result:=CRC=PKZIP_CRC;
end;}

{----------------------------------------------------------------------}

function CRC32Finish(CRC:Integer):Integer;
begin
  Result := not CRC;
end;

{----------------------------------------------------------------------}

function CRC32Start:DWord;
begin
  Result := $FFFFFFFF;
end;

{-------------------------------------------------}

procedure TDiffMaker.SetCompLevel(V:Integer);
begin
  If (V<>FCompLevel) and (V>9) and (V<1001) then
    FCompLevel:=V;
end;

{-------------------------------------------------}

constructor TDiffMaker.Create(AOwner:TComponent);
begin
  inherited;
  FCompLevel:=25;
end;

{-------------------------------------------------}

procedure TDiffMaker.InternalProcess(ACompress:boolean);
Var
 InStream,OutStream,UseStream:TFileStream;
begin
  InStream:=nil;
  OutStream:=nil;
  UseStream:=nil;
  try
    InStream:=TFileStream.Create(FInFile, DefaultOpenMode);
    OutStream:=TFileStream.Create(FOutFile,fmcreate);
    UseStream:=TFileStream.Create(FUseFile, DefaultOpenMode);
    If ACompress
    then
      DiffStreamCompress(InStream,UseStream,OutStream,FCompLevel)
    else
      DiffStreamExtract(InStream,UseStream,OutStream);
  finally
    InStream.Free;
    OutStream.Free;
    UseStream.Free;
  end;

end;

{-------------------------------------------------}

procedure TDiffMaker.Compress;
begin
  InternalProcess(True);
end;

{-------------------------------------------------}

procedure TDiffMaker.Extract;
begin
  InternalProcess(False);
end;

{------------------------------------------------------------------}

procedure _Register;
begin
end;

{-------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------}

initialization
  RunRegister;
end.
