{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnIcoGr
|
| Description: TDibGraphic descendant for ICO files.
|
| History: Dec 24, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnIcoGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    EnDiGrph; { for TDibGraphic }

type

TIconGraphic = class(TDibGraphic)
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
    Graphics, { for TIcon }
    EnMisc;   { for TImageFormat }

{--------------------------------------------------------------------------}

type

TProtectedIcon = class(TIcon);

procedure TIconGraphic.SingleLoadFromStream(
                                    const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  );

var
    Icon : TIcon;
    Rect : TRect;
begin
    Icon := TIcon.Create;
    try
        Icon.LoadFromStream(Stream);

        Self.NewImage( Icon.Width, Icon.Height,
                       ifTrueColor, nil, 0, 0 );
        Rect.Left   := 0;
        Rect.Top    := 0;
        Rect.Right  := Icon.Width;
        Rect.Bottom := Icon.Height;

        FillChar( Self.Bits^, Icon.Height * Self.ScanLineSize, 0);

        TProtectedIcon(Icon).Draw(Self.Canvas, Rect);
    finally
        Icon.Free;
    end;
end;

{--------------------------------------------------------------------------}

{ original Icon conversion code from internet newsgroup by:
  George H. Silva 1997 snappy@global2000.net }
procedure TIconGraphic.SaveToStream(Stream: TStream);
var
    Mask     : Graphics.TBitmap;
    Color    : Graphics.TBitmap;
    IconInfo : TIconInfo;
    Icon     : Graphics.TIcon;
begin
    Icon   := nil;
    Mask   := nil;
    Color  := nil;
    try
        FillChar(IconInfo,SizeOf(TIconInfo),0);
        IconInfo.fIcon := True;
        Color          := Graphics.TBitmap.Create;
        Mask           := Graphics.TBitmap.Create;
        Icon           := Graphics.TIcon.Create;
        Color.Height   := GetSystemMetrics(SM_CYICON);
        Color.Width    := GetSystemMetrics(SM_CXICON);
        Mask.Height    := Color.Height;
        Mask.Width     := Color.Width;
        Mask.Canvas.Brush.Color := clBlack;
        Mask.Canvas.FillRect(Bounds(0,0,Mask.Width,Mask.Height));
        IconInfo.hbmMask  := Mask.Handle;
        { using StretchDraw the entire original is stretched
        Color.Canvas.StretchDraw(Bounds(0,0,Color.Width,Color.Height),Self);
        }
        Color.Canvas.Draw(0, 0, Self);

        IconInfo.hbmColor := Color.Handle;
        Icon.Handle := CreateIconIndirect(IconInfo);

        Icon.SaveToStream(Stream);
    finally
        Mask.Free;
        Color.Free;
        Icon.Free;
    end;
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionIco}
    RegisterDibGraphic('ICO', 'Windows icon', TIconGraphic);
    {$endif}

finalization

end.

