unit ZFCompress;

{DEFINE ENCRYPTION}
{$DEFINE ZLIB}
{DEFINE PPMD}
{DEFINE BZIP}

{$IFNDEF ZLIB}
{$IFNDEF PPMD}
{$IFNDEF BZIP}
	WARNING! You have switched off all compression algorithms!
  If you do not need them, comment these strings and continue.
{$ENDIF}
{$ENDIF}
{$ENDIF}

interface
uses sysutils, ZipForge
{$IFDEF ZLIB}
,ZFZlib
{$ENDIF}
{$IFDEF BZIP}
,ZFBZip2
{$ENDIF}
{$IFDEF ENCRYPTION}
,ZFCipher
{$ENDIF}
;
const
 // maximum block size for stream classes, LoadFromStream / SaveToStream
 DefaultMaxBlockSize = 1024 * 1024; // 1.0 Mb for eclNone
 BlockSizeForFastest = 512 * 1024; // 0.5 Mb for fastest modes
 BlockSizeForNormal = 1024 * 1024; // 1.0 Mb for normal modes
 BlockSizeForMax = 1536 * 1024; // 1.5 Mb for max modes

 PPM_MO: array [1..9] of Byte = (2,3,4, 5, 7, 8,10,13,16);
 PPM_SA: array [1..9] of Byte = (2,3,4,10,20,25,40,50,50);

type
 TZFFileHeader = packed record
       BlockSize:             Integer; // block size
       CompSize:              Integer; // compressed file size (excluding this header)
       UncompSize:            Integer; // uncompressed file size
       FileCrc32:             LongWord; // file check sum
       NumBlocks:             Integer; // number of blocks
       CompressionAlgorithm:  Byte; // compression algorithm
       CompressionMode:       Byte; // compression mode (0 - none, 9 - max)
       CryptoAlgorithm:       Word; // encryption algorithm
       ControlBlockCrc32:     LongWord; // check sum of control block
       ControlBlock:	        array [0..15] of char; // control for encryption
       extraLength:           Word; // extra data size (after header)
       reserved:              Integer; // for future expanding
 end; // 50 bytes

 TZFBlockHeader = packed record
      packedSize:    Cardinal; // packed block size
 end; // 4

// ZF
const
 ZFBlockHeaderSize = sizeof(TZFBlockHeader); // size in bytes (16)
 ZFFileHeaderSize = sizeof(TZFFileHeader); // size in bytes (128)
 CustomHeaderSizeOffset = 23;

// compresses buffer
// returns true if successful
// outBuf - pointer to compressed data
// outSize - size of compressed data
function ZFInternalCompressBuffer(
                          CompressionAlg:         TZFCompressionAlgorithm;
                          CompressionMode:        Byte;
                          inBuf:                  pChar;
                          inSize:                 Integer;
                          out outBuf:             pChar;
                          out outSize:            Integer
                          ): Boolean;

// decompresses buffer
// outsize must be set to uncompressed size
// returns true if successful
// outBuf - pointer to compressed data
// outSize - size of compressed data
function ZFInternalDecompressBuffer(
                          CompressionAlg:         TZFCompressionAlgorithm;
                          inBuf:                  pChar;
                          inSize:                 Integer;
                          out outBuf:             pChar;
                          out outSize:            Integer
                          ): Boolean;

// encrypts specified buffer
function ZFInternalEncryptBuffer(
                          CryptoAlg:              TZFCryptoAlgorithm;
                          inBuf:                  pChar;
                          Size:                   Integer;
                          Password:               string
                          ): Boolean;

// decrypts specified buffer
function ZFInternalDecryptBuffer(
                          CryptoAlg:              TZFCryptoAlgorithm;
                          inBuf:                  pChar;
                          Size:                   Integer;
                          Password:               string
                          ): Boolean;

// determines best block size for compression level
function InternalGetBlockSize(CompressionMode: Byte): Integer;

// returns compression level for this mode
function InternalGetCompressionLevel(CompressionMode: Byte): TZFCompressionLevel;

// returns compression mode for this level
function InternalGetCompressionMode(CompressionLevel: TZFCompressionLevel): Byte;

implementation

{$IFDEF PPMD}
{$L Ppmd.OBJ}
function PPMCompressBuffer(inBuf  : pChar;
                           inSize : Cardinal;
                           outBuf : pChar;
										       Max_Order:integer = 6;
                           SASize:integer = 10
                          ) : Cardinal; external;

function PPMDecompressBuffer(
                            inBuf  : pChar;
                            inSize : Cardinal;
                            outBuf : pChar
                            ) : Cardinal; external;
{$ENDIF}


//------------------------------------------------------------------------------
// determines best block size for compression level
//------------------------------------------------------------------------------
function InternalGetBlockSize(CompressionMode: Byte): Integer;
begin
 result := DefaultMaxBlockSize;
 if (CompressionMode = 0) then
  Exit;
 if (CompressionMode <= 3) then
   result := BlockSizeForFastest
 else
 if (CompressionMode <= 6) then
   result := BlockSizeForNormal
 else
 if (CompressionMode <= 9) then
   result := BlockSizeForMax;
end;


//------------------------------------------------------------------------------
// returns compression level for this mode
//------------------------------------------------------------------------------
function InternalGetCompressionLevel(CompressionMode: Byte): TZFCompressionLevel;
begin
 result := clNone;

 if (CompressionMode <= 0) then
   result := clNone
 else
 if (CompressionMode <= 3) then
   result := clFastest
 else
 if (CompressionMode <= 6) then
   result := clNormal
 else
 if (CompressionMode <= 9) then
   result := clMax;
end;


//------------------------------------------------------------------------------
// returns compression mode for this level
//------------------------------------------------------------------------------
function InternalGetCompressionMode(CompressionLevel: TZFCompressionLevel): Byte;
begin
 case CompressionLevel of
  clFastest: result := 1;
  clNormal: result := 6;
  clMax: result := 9;
 else
   result := 0;
 end;
end;


//------------------------------------------------------------------------------
// compresses buffer
// returns true if successful
// outBuf - pointer to compressed data
// outSize - size of compressed data
//------------------------------------------------------------------------------
function ZFInternalCompressBuffer(
                          CompressionAlg:         TZFCompressionAlgorithm;
                          CompressionMode:        Byte;
                          inBuf:                  pChar;
                          inSize:                 Integer;
                          out outBuf:             pChar;
                          out outSize:            Integer
                          ): Boolean;
begin
 result := false;
 if inSize = 0 then Exit;
 result := true;
 outSize := 0;
 case CompressionAlg of
{$IFDEF ZLIB}
  caZLIB:
   begin
    try
     ZLIBCompressBuf(inBuf,inSize,Pointer(outbuf),Integer(outSize),CompressionMode);
    except
     result := false;
    end;
    if (outSize <= 0) then
     result := false;
   end
{$ENDIF}
{$IFDEF BZIP}
  ;
  caBZIP:
   begin
    try
     bzCompressBuf(inBuf,inSize,Pointer(outbuf),Integer(outSize),CompressionMode)
    except
     result := false;
    end;
    if (outSize <= 0) then
     result := false;
   end
{$ENDIF}
{$IFDEF PPMD}
;
  caPPM:
   begin
    try
     // some memory reserve for none-compressible data
     outSize := inSize + inSize div 20 + 50;
     outBuf := AllocMem(outSize);
     outSize := PPMCompressBuffer(
                inBuf,inSize,outBuf,
                PPM_MO[CompressionMode],
                PPM_SA[CompressionMode]
                );
    except
     result := false;
    end;
    if (outSize <= 0) then
     result := false;
   end
{$ENDIF}
;
  else
   result := false;
 end; //case compression ôäïùêøåðü
end; // ZFInternalCompressBuffer;


//------------------------------------------------------------------------------
// decompresses buffer
// outsize must be set to uncompressed size
// returns true if successful
// outBuf - pointer to compressed data
// outSize - size of compressed data
//------------------------------------------------------------------------------
function ZFInternalDecompressBuffer(
                          CompressionAlg:         TZFCompressionAlgorithm;
                          inBuf:                  pChar;
                          inSize:                 Integer;
                          out outBuf:             pChar;
                          out outSize:            Integer
                          ): Boolean;
begin
 result := false;
 if inSize = 0 then Exit;
 result := true;
 case CompressionAlg of
{$IFDEF ZLIB}
  caZLIB:
   begin
    try
     ZLIBDecompressBuf(inBuf,inSize,OutSize,Pointer(outbuf),Integer(outSize));
    except
     result := false;
    end;
    if (outSize <= 0) then
     result := false;
   end
{$ENDIF}
{$IFDEF BZIP}
  ;
  caBZIP:
   begin
    try
     bzDecompressBuf(inBuf,inSize,OutSize,Pointer(outbuf),Integer(outSize));
    except
     result := false;
    end;
    if (outSize <= 0) then
     result := false;
   end
{$ENDIF}
{$IFDEF PPMD}
;
  caPPM:
   begin
    try
     outBuf := AllocMem(outSize);
     outSize := PPMDecompressBuffer(inBuf,inSize,outBuf);
    except
     result := false;
    end;
    if (outSize <= 0) then
     result := false;
   end
{$ENDIF}
;
  else
   result := false;
 end; //case compression algorithm
end; // ZFInternalÂóompressBuffer;

// encrypts specified buffer
function ZFInternalEncryptBuffer(
                          CryptoAlg:              TZFCryptoAlgorithm;
                          inBuf:                  pChar;
                          Size:                   Integer;
                          Password:               string
                          ): Boolean;
var crypto: TCipher;
begin
 {$IFDEF ENCRYPTION}
 try
  case CryptoAlg of
   caRijndael_128:
    begin
     crypto := TCipher_Rijndael.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caRijndael_256:
    begin
     crypto := TCipher_Rijndael.Create(Password,nil);
     crypto.HashClass := THash_RipeMD256;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caSquare:
    begin
     crypto := TCipher_Square.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caDES_Single:
    begin
     crypto := TCipher_1DES.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caDES_Triple:
    begin
     crypto := TCipher_3TDES.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caBlowfish:
    begin
     crypto := TCipher_Blowfish.Create(Password,nil);
     crypto.HashClass := THash_RipeMD256;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caTwofish_128:
    begin
     crypto := TCipher_Twofish.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caTwofish_256:
    begin
     crypto := TCipher_Twofish.Create(Password,nil);
     crypto.HashClass := THash_RipeMD256;
     crypto.InitKey(Password,crypto.Vector);
     crypto.EncodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
  end; // case
  result := true;
 except
  result := false; // encryption error
 end;
 {$ENDIF}
end; // ZFInternalEncryptBuffer


// decrypts specified buffer
function ZFInternalDecryptBuffer(
                          CryptoAlg:              TZFCryptoAlgorithm;
                          inBuf:                  pChar;
                          Size:                   Integer;
                          Password:               string
                          ): Boolean;
var crypto: TCipher;
begin
 {$IFDEF ENCRYPTION}
 try
  case CryptoAlg of
   caRijndael_128:
    begin
     crypto := TCipher_Rijndael.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caRijndael_256:
    begin
     crypto := TCipher_Rijndael.Create(Password,nil);
     crypto.HashClass := THash_RipeMD256;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caSquare:
    begin
     crypto := TCipher_Square.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caDES_Single:
    begin
     crypto := TCipher_1DES.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caDES_Triple:
    begin
     crypto := TCipher_3TDES.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caBlowfish:
    begin
     crypto := TCipher_Blowfish.Create(Password,nil);
     crypto.HashClass := THash_RipeMD256;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caTwofish_128:
    begin
     crypto := TCipher_Twofish.Create(Password,nil);
     crypto.HashClass := THash_RipeMD128;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
   caTwofish_256:
    begin
     crypto := TCipher_Twofish.Create(Password,nil);
     crypto.HashClass := THash_RipeMD256;
     crypto.InitKey(Password,crypto.Vector);
     crypto.DecodeBuffer(inBuf^,inBuf^,Size);
     crypto.Free;
    end;
  end; // case
  result := true;
 except
  result := false; // decryption error
 end;
 {$ENDIF}
end; // ZFInternalDecryptBuffer


procedure memset(P: Pointer; B: Byte; count: Integer); cdecl;
begin
  FillChar(P^, count, B);
end;

procedure memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;


function aa_malloc(count : integer) : pChar;cdecl;
begin
 result := AllocMem(count);
end;

procedure aa_free(buffer : pChar);cdecl;
begin
 FreeMem(buffer);
end;


end.


