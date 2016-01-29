{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnDcxGr
|
| Description: TDibGraphic descendant for DCX files.
|
| History: Aug 07, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnDcxGr;

{$I Envision.Inc}

interface

uses
    Windows,  { for TRect, ColorRef, PMaxLogPalette }
    SysUtils, { for Exception, PByteArray }
    Classes,  { for TStream }
    EnMisc,   { for TImageFormat, DateToDateStr, TimeToTimeStr }
    EnPcxGr,  { for TPcxGraphic }
    EnDiGrph; { for TDibGraphic }


type

EDcxError = class(Exception);

TDcxGraphic = class(TPcxGraphic)
public
    constructor Create; override;
    destructor Destroy; override;

    function GetImageCount( const Stream : TStream ) : LongInt; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;

    procedure SaveToStream(Stream: TStream); override;

    procedure AppendToStream(Stream : TStream); override;

protected
    procedure CheckHeader( const Stream : TStream );

    procedure GetPcxStream( const DcxStream  : TStream;
                            const PcxStream  : TMemoryStream;
                            const ImageNo    : LongInt );

    procedure AddImageInHeader( const Stream : TStream );

end;

{--------------------------------------------------------------------------}

implementation

uses
    EnMsg,    { for EEnvisionError }
    Graphics; { for TPicture }

{--------------------------------------------------------------------------}

const

CDcxId = 987654321;

{--------------------------------------------------------------------------}

constructor TDcxGraphic.Create;
begin
    inherited Create;
end;

{--------------------------------------------------------------------------}

destructor TDcxGraphic.Destroy;
begin
    inherited Destroy;
end;

procedure TDcxGraphic.CheckHeader( const Stream : TStream );
var
    Id : LongInt;
begin
    Stream.ReadBuffer(Id, SizeOf(Id));

    if Id <> CDcxId then
        raise EDcxError.Create(msgInvalidDcxHeader);
end;

{--------------------------------------------------------------------------}

function TDcxGraphic.GetImageCount( const Stream : TStream ) : LongInt;
var
    Offset : LongInt;
begin
    CheckHeader(Stream);

    Result := 0;

    { read until the DCX terminator is reached. }
    repeat
         if Stream.Read(Offset, SizeOf(Offset)) <> SizeOf(Offset) then
             raise EDcxError.Create(msgInvalidDcxHeader);

         if Offset <> 0 then
             Inc(Result);

    until (Offset = 0);
end;

{--------------------------------------------------------------------------}

procedure TDcxGraphic.GetPcxStream(
                            const DcxStream  : TStream;
                            const PcxStream  : TMemoryStream;
                            const ImageNo    : LongInt );
var
    StartOffset  : LongInt;
    EndOffset    : LongInt;

    Len          : LongInt;
    CurImageNo   : LongInt;
begin

    CurImageNo := 0;
    repeat
         if DcxStream.Read(StartOffset, SizeOf(StartOffset)) <> SizeOf(StartOffset) then
             raise EDcxError.Create(msgInvalidDcxHeader);

         Inc(CurImageNo);

         if StartOffset = 0 then
             raise EDcxError.Create(msgInvalidDcxHeader);

    until (CurImageNo = ImageNo);

    if DcxStream.Read(EndOffset, SizeOf(EndOffset)) <> SizeOf(EndOffset) then
        raise EDcxError.Create(msgInvalidDcxHeader);

    if EndOffset = 0 then
        { last image in file }
        EndOffset := DcxStream.Size;

    Len := EndOffset - StartOffset;

    PcxStream.SetSize(Len);
    DcxStream.Seek(StartOffset, soFromBeginning);
    if PcxStream.CopyFrom(DcxStream, Len) <> Len then
        raise EDcxError.Create(msgInvalidDcxHeader);

end;

{--------------------------------------------------------------------------}

procedure TDcxGraphic.SingleLoadFromStream(
                                      const Stream      : TStream;
                                      const ImageToLoad : LongInt
                                    );
var
    PcxStream      : TMemoryStream;
begin
    CheckHeader(Stream);

    { Cal inherited SingleLoadFromStream with the PCX stream rather than
      the DCX streamed positioned and the start of the PCX stream, otherwise the
      TPcxGraphic will create a large memory stream causing a lot of
      disk swapping with large multi-image DCX files.  }
    PcxStream := TMemoryStream.Create;
    try
        GetPcxStream(Stream, PcxStream, ImageToLoad);

        PcxStream.Seek(0, soFromBeginning);
        inherited SingleLoadFromStream(PcxStream, 1);

    finally
        PcxStream.Free;
    end;

end;

{--------------------------------------------------------------------------}

procedure TDcxGraphic.SaveToStream(Stream: TStream);
const
    { maximum number of images in DCX header. Envision always writes the
      complete header (ie, 1023 images) for maximum expansion of the
      DCX file. The DCX specification does not allow more than 1023; never
      make this value larger than 1023. It may be less to reduce file size,
      but this makes the DCX file less expandable }
    CMaxImagesInHeader = 1023;
var
    TempLong : LongInt;
    Index    : Integer;
begin
    TempLong := CDcxId;
    Stream.WriteBuffer(TempLong, SizeOf(TempLong));

    TempLong := 8 + (CMaxImagesInHeader * 4);
    Stream.WriteBuffer(TempLong, SizeOf(TempLong));

    { set remaining pages to blank }
    TempLong := 0;
    for Index := 1 to (CMaxImagesInHeader-1) do
        Stream.WriteBuffer(TempLong, SizeOf(TempLong));

    { write terminator value explicitely for clairity }
    TempLong := 0;
    Stream.WriteBuffer(TempLong, SizeOf(TempLong));

    { write the PCX image stream }
    inherited SaveToStream(Stream);

end;

{--------------------------------------------------------------------------}

procedure TDcxGraphic.AddImageInHeader( const Stream : TStream );
var
    StartOffset : LongInt;
    FirstOffset : LongInt;
    Offset      : LongInt;
begin
    Stream.Seek(0, soFromEnd);
    StartOffset := Stream.Position;

    Stream.Seek(0, soFromBeginning);
    CheckHeader(Stream);

    if (Stream.Read(Offset, SizeOf(Offset)) <> SizeOf(Offset)) or
       (Offset = 0) then
         raise EDcxError.Create(msgInvalidDcxHeader);

    FirstOffset := Offset;

    { read until the DCX terminator is reached. }
    repeat
         if Stream.Read(Offset, SizeOf(Offset)) <> SizeOf(Offset) then
             raise EDcxError.Create(msgInvalidDcxHeader);

    until (Offset = 0);

    { assert: terminator has just been read }

    if Stream.Position >= FirstOffset then
        raise EDcxError.Create(msgDcxHeaderIsFull);

    Stream.Seek(-4, soFromCurrent);

    Stream.WriteBuffer(StartOffset, SizeOf(StartOffset));

    { write terminator }
    Offset := 0;
    Stream.WriteBuffer(Offset, SizeOf(Offset));
end;

{--------------------------------------------------------------------------}

procedure TDcxGraphic.AppendToStream(Stream : TStream);
begin
    if Stream.Size = 0 then
        { the stream is empty, this is not really an append operation. }
        SaveToStream(Stream)
    else
    begin
        AddImageInHeader(Stream);

        Stream.Seek(0, soFromEnd);

        { write the PCX image stream }
        inherited SaveToStream(Stream);
    end;
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionDcx}
    RegisterDibGraphic('DCX', 'DCX file', TDcxGraphic);
    {$endif}

finalization

end.

