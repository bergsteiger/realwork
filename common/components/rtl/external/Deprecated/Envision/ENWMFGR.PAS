{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnWmfGr
|
| Description: TDibGraphic descendant for WMF/EMF files.
|
| History: Dec 24, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnWmfGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    EnDiGrph; { for TDibGraphic }

type

TMetaFileGraphic = class(TDibGraphic)
public
    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;
    procedure SaveToStream(Stream: TStream); override;
end;

{--------------------------------------------------------------------------}

implementation

uses
    Windows,  { for TRect }
    Graphics, { for TMetaFile }
    EnMisc;   { for ifTrueColor }

{--------------------------------------------------------------------------}

type

TProtectedMetaFile = class(TMetaFile);

procedure TMetaFileGraphic.SingleLoadFromStream(
                                   const Stream      : TStream;
                                   const ImageToLoad : LongInt
                                  );

var
    MetaFile : TMetaFile;
    Rect     : TRect;
begin
    MetaFile := TMetaFile.Create;
    try
        MetaFile.LoadFromStream(Stream);

        Self.NewImage( MetaFile.Width, MetaFile.Height,
                       ifTrueColor, nil, 0, 0 );

        { set the background white }
        FillChar(Bits^, BitmapInfo.BmpHeader.biSizeImage, $FF);

        Rect.Left   := 0;
        Rect.Top    := 0;
        Rect.Right  := MetaFile.Width;
        Rect.Bottom := MetaFile.Height;

        TProtectedMetaFile(MetaFile).Draw(Self.Canvas, Rect);
    finally
        MetaFile.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TMetaFileGraphic.SaveToStream(Stream: TStream);
var
    MetaFile : TMetaFile;
    Canvas   : TMetaFileCanvas;
begin
    MetaFile := TMetaFile.Create;
    try
        MetaFile.Width  := Self.Width;
        MetaFile.Height := Self.Height;
        Canvas := TMetafileCanvas.Create(Metafile, 0);
        try
            Canvas.Draw(0, 0, Self);
        finally
            Canvas.Free;
        end;

        MetaFile.SaveToStream(Stream);
    finally
        MetaFile.Free;
    end;
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionWmf}
    RegisterDibGraphic('WMF', 'Windows meta file', TMetaFileGraphic);
    RegisterDibGraphic('EMF', 'Enhanced meta file', TMetaFileGraphic);
    {$endif}

finalization

end.

