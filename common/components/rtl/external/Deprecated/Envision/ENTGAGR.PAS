{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnTgaGr
|
| Description: TDibGraphic descendant for TGA files. TGA files do not
|              support image resolution.
|
| History: Feb 28, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnTgaGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    SysUtils, { for Exception }
    EnDiGrph; { for TDibGraphic }

type

TTgaGraphic = class(TDibGraphic)
public
    constructor Create; override;

    procedure LoadFromStream(Stream: TStream); override;

    procedure SaveToStream(Stream: TStream); override;
end;

ETgaError = class(Exception);

{--------------------------------------------------------------------------}

implementation

uses
    EnMsg,    { for msgXXXX }
    EnGbm,    { for LoadGraphicWithGbm, SaveGraphicWithGbm }
    EnMisc;   { for ifGray256, ... }

const

CSampleTgaFileName = 'File.tga';


{--------------------------------------------------------------------------}

constructor TTgaGraphic.Create;
begin
    inherited Create;

end;

{--------------------------------------------------------------------------}

procedure TTgaGraphic.LoadFromStream(Stream: TStream);
var
    Position    : LongInt;
    ImageStream : TStream;

begin
    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when loading images from DFM files, the image
              stream is included when a larger stream. The GBM
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;

            TMemoryStream(ImageStream).SetSize(Stream.Size-Stream.Position);
            ImageStream.CopyFrom(Stream, Stream.Size-Stream.Position)
        end
        else
            ImageStream := Stream;

        ImageStream.Seek(0, soFromBeginning);

        LoadGraphicWithGbm( ImageStream, Self, CSampleTgaFileName, '' );

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TTgaGraphic.SaveToStream(Stream: TStream);
begin
    if not (Self.ImageFormat in [ifGray256, ifColor256, ifTrueColor]) then
        raise ETgaError.Create(msgTGAMustBeTrueColorOr8Bit);

    SaveGraphicWithGbm( Stream, Self, CSampleTgaFileName );
end;

{--------------------------------------------------------------------------}


initialization
    {$ifdef __RegisterEnvisionTga}
    RegisterDibGraphic('TGA', 'Truevision Targa', TTgaGraphic);
    RegisterDibGraphic('VST', 'Truevision Vista', TTgaGraphic);
    RegisterDibGraphic('AFI', 'Truevision Targa', TTgaGraphic);
    {$endif}

finalization

end.

