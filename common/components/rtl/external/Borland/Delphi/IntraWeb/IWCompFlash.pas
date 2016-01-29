unit IWCompFlash;

interface

uses
  Classes,
  IWControl, IWFileReference, IWTypes, IWHTMLTag;

type
  TIWFlashQuality = (fqLow, fqAutoLow, fqAutoHigh, fqMedium, fqHigh, fqBest);
  TIWFlashScale = (fsDefault, fsShowAll, fsNoBorder, fsExactFit);
  TIWFlashAlign = (faNone, faLeft, faTop, faRight, faBottom);
  TIWFlashSAlign = (fsNone, fsLeft, fsTop, fsRight, fsBottom, fsTopLeft, fsTopRight, fsBottomLeft
   , fsBottomRight);

  TIWCustomFlash = class(TIWControl)
  protected
    FAlign: TIWFlashAlign;
    FAutoPlay: Boolean;
    FBGColor: TIWColor;
    FEnableMenu: Boolean;
    FFlashFile: TIWFileReference;
    FLoop: Boolean;
    FQuality: TIWFlashQuality;
    FSAlign: TIWFlashSAlign;
    FScale: TIWFlashScale;
    FSWLiveConnect: Boolean;
    //
    procedure SetFlashFile(const AValue: TIWFileReference);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML: TIWHTMLTag; override;

    //@@ Specifies primary alignment.
    property Align: TIWFlashAlign read FAlign write FAlign;
    //@@ Specifies if the flash movie will begin playing automatically or not.
    property AutoPlay: Boolean read FAutoPlay write FAutoPlay;
    //@@ Specifies the background color for the flash plugin.
    property BGColor: TIWColor read FBGColor write FBGColor;
    //@@ Specifies whether or not the flash menu is enabled. Default is clNone.
    property EnableMenu: Boolean read FEnableMenu write FEnableMenu;
    //@@ Specifies the location of the flash file. This property is required.
    property FlashFile: TIWFileReference read FFlashFile write SetFlashFile;
    //@@ Specifies if the flash movie will repeat or not. Default is True.
    property Loop: Boolean read FLoop write FLoop;
    //@@ Specifies the quality used to play the flash movie. See Flash documentation for details.
    property Quality: TIWFlashQuality read FQuality write FQuality;
    //@@ Specifies secondary alignment.
    property SAlign: TIWFlashSAlign read FSAlign write FSAlign;
    //@@ Specifies scale.
    property Scale: TIWFlashScale read FScale write FScale;
    //@@ Specifies if the browser should automatically load Java. If you use JavaScript to interact
    //with Flashe, Java must be running for the FSCommand to work.
    property SWLiveConnect: Boolean read FSWLiveConnect write FSWLiveConnect;
  end;

  TIWFlash = class(TIWCustomFlash)
  published
    property Align;
    property AutoPlay;
    property BGColor;
    property EnableMenu;
    property FlashFile;
    property Loop;
    property Quality;
    property SAlign;
    property Scale;
    property SWLiveConnect;
  end;

implementation

uses
  {$IFDEF Linux}QGraphics,{$ELSE}Graphics,{$ENDIF}
  SysUtils, SWSystem;

{ TIWCustomFlash }

constructor TIWCustomFlash.Create(AOwner: TComponent);
begin
  inherited;
  FAutoPlay := True;
  FBGColor := clNone;
  FEnableMenu := True;
  FFlashFile := TIWFileReference.Create;
  FLoop := True;
  FQuality := fqHigh;
  Width := 468;
  Height := 60;
end;

destructor TIWCustomFlash.Destroy;
begin
  FreeAndNil(FFlashFile);
  inherited;
end;

function TIWCustomFlash.RenderHTML: TIWHTMLTag;

  function QualityText(const AQuality: TIWFlashQuality): string;
  begin
    case AQuality of
      fqLow: Result := 'Low';
      fqAutoLow: Result := 'AutoLow';
      fqAutoHigh: Result := 'AutoHigh';
      fqMedium: Result := 'Medium';
      fqHigh: Result := 'High';
      fqBest: Result := 'Best';
    end;
  end;

  function AlignText(AAlign: TIWFlashAlign): string;
  begin
    case AAlign of
      faNone: Result := 'None';
      faLeft: Result := 'Left';
      faTop: Result := 'Top';
      faRight: Result := 'Right';
      faBottom: Result := 'Bottom';
    end;
  end;

  function SAlignText(ASAlign: TIWFlashSAlign): string;
  begin
    case ASAlign of
      fsNone: Result := 'None';
      fsLeft: Result := 'Left';
      fsTop: Result := 'Top';
      fsRight: Result := 'Right';
      fsBottom: Result := 'Bottom';
      fsTopLeft: Result := 'TopLeft';
      fsTopRight: Result := 'TopRight';
      fsBottomLeft: Result := 'BottomLeft';
      fsBottomRight: Result := 'BottomRight';
    end;
  end;

  function ScaleText(AScale: TIWFlashScale): string;
  begin
    case AScale of
      fsDefault: Result := 'Default';
      fsShowAll: Result := 'ShowAll';
      fsNoBorder: Result := 'NoBorder';
      fsExactFit: Result := 'ExactFit';
    end;
  end;

begin
  if WebApplication.Browser = brIE then begin
    Result := TIWHTMLTag.CreateTag('OBJECT'); try
      Result.AddStringParam('ID', HTMLName);
      Result.AddStringParam('CLASSID', 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000');
      // Width and Height are required for flash.
      Result.AddIntegerParam('WIDTH', Width);
      Result.AddIntegerParam('HEIGHT', Height);
      Result.AddStringParam('CODEBASE', 'http://active.macromedia.com/flash5/cabs/swflash.cab#version=5,0,0,0');

      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'MOVIE');
        AddStringParam('VALUE', FlashFile.Location(WebApplication.URLBase));
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'PLAY');
        AddBoolParam('VALUE', AutoPlay);
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'LOOP');
        AddBoolParam('VALUE', Loop);
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'QUALITY');
        AddStringParam('VALUE', QualityText(Quality));
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'MENU');
        AddBoolParam('VALUE', EnableMenu);
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'BGCOLOR');
        AddColor('VALUE', BGColor);
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'ALIGN');
        AddStringParam('VALUE', AlignText(Align));
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'SALIGN');
        AddStringParam('VALUE', SAlignText(SAlign));
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'SCALE');
        AddStringParam('VALUE', ScaleText(Scale));
      end;
      with Result.Contents.AddTag('PARAM') do begin
        AddStringParam('NAME', 'SWLIVECONNECT');
        AddBoolParam('VALUE', SWLiveConnect);
      end;
    except FreeAndNil(Result); raise; end;
  end else begin
    Result := TIWHTMLTag.CreateTag('EMBED'); try
      Result.AddStringParam('NAME', HTMLName);
      Result.AddStringParam('SRC', FlashFile.Location(WebApplication.URLBase));
      Result.AddIntegerParam('WIDTH', Width);
      Result.AddIntegerParam('HEIGHT', Height);
      Result.AddBoolParam('PLAY', AutoPlay);
      Result.AddBoolParam('LOOP', Loop);
      Result.AddStringParam('QUALITY', QualityText(Quality));
      Result.AddBoolParam('MENU', EnableMenu);
      Result.AddColor('BGCOLOR', BGColor);
      Result.AddStringParam('ALIGN', AlignText(Align));
      Result.AddStringParam('SALIGN', SAlignText(SAlign));
      Result.AddStringParam('SCALE', ScaleText(Scale));
      Result.AddBoolParam('SWLIVECONNECT', SWLiveConnect);
      Result.AddStringParam('PLUGINSPAGE'
       , 'http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash');
      Result.Contents.AddText('');
    except FreeAndNil(Result); raise; end;
  end;
end;

procedure TIWCustomFlash.SetFlashFile(const AValue: TIWFileReference);
begin
  FFlashFile.Assign(AValue);
end;

end.
