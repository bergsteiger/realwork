{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtJPEGEng;

interface
uses
	Classes, Graphics, SysUtils, JPEG, gtCstGfxEng, gtDocConsts, gtDocResStrs;

type
  TgtJPEGEngine = class(TgtCustomGraphicsEngine)
  private
		FProgressiveEncoding: Boolean;
		FQuality: TJPEGQualityRange;
    procedure SetProgressiveEncoding(const Value: Boolean);
    procedure SetQuality(const Value: TJPEGQualityRange);
  public
    constructor Create(AOwner: TComponent); override;
  protected
  	procedure EndPage; override;
    function ShowSetupModal: Word; override;
  published
		property ProgressiveEncoding: Boolean read FProgressiveEncoding
			write SetProgressiveEncoding default False;
		property Quality: TJPEGQualityRange read FQuality
			write SetQuality default High(TJPEGQualityRange);
    property Monochrome;
    property PixelFormat;
  end;

implementation

uses gtCstDocEng, gtJPEGEngDlg, gtDocUtils;

{ TgtJPEGEngine }

constructor TgtJPEGEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Monochrome := False;
  PixelFormat := pf24bit;
  ProgressiveEncoding := False;
  Quality := High(TJPEGQualityRange);
  FileExtension := 'jpg';
  FileDescription := SJPEGDescription;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 114);
{$ENDIF}
end;

procedure TgtJPEGEngine.EndPage;
var
  LJPG: TJPEGImage;
  LBMP: TBitmap;
  LFileName: String;
begin
  inherited;
  LJPG := TJPEGImage.Create;
  LBMP := TBitmap.Create;
  try
    LBMP.Width := Round(FMetafile.Width * ScaleX);
    LBMP.Height := Round(FMetafile.Height * ScaleY);
    LBMP.Monochrome := Monochrome;
    if Monochrome then
      LBMP.PixelFormat := pf1bit
    else
      LBMP.PixelFormat := PixelFormat;

    with LBMP do
      Canvas.StretchDraw(Rect(0, 0, Width, Height), FMetafile);

    LJPG.CompressionQuality := Quality;
    LJPG.ProgressiveEncoding := ProgressiveEncoding;
    LJPG.Assign(LBMP);
    LJPG.Compress;
    if Preferences.OutputToUserStream then
      LJPG.SaveToStream(UserStream)
    else
    begin
    	LFileName := FileName + IntToStr(CurrentPage);
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      try
        LJPG.SaveToFile(LFileName + '.' + FileExtension);
      except
        CancelCreate;
        raise EFileCreateError.Create(SFileCreateError);
      end;
      EngineFileNames.Add(LFileName + '.' + FileExtension);
    end;
  finally
    LBMP.Free;
    LJPG.Free;
  end;
end;

procedure TgtJPEGEngine.SetProgressiveEncoding(const Value: Boolean);
begin
  FProgressiveEncoding := Value;
end;

procedure TgtJPEGEngine.SetQuality(const Value: TJPEGQualityRange);
begin
  FQuality := Value;
end;

function TgtJPEGEngine.ShowSetupModal: Word;
begin
  with TgtJPEGEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
