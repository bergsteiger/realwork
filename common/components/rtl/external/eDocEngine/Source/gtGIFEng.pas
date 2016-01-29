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

{$I gtDocDefines.inc}
unit gtGIFEng;

interface
uses
	Classes, Graphics, SysUtils, JPEG, gtCstGfxEng, gtDocConsts, gtDocResStrs
	{$IFDEF GIFByRx}
		, RxGIF
	{$ELSE}
  {$IFDEF GIFByAM}
    , GIFImage
  {$ELSE}
  {$IFDEF GIFIMG}
  , GIFImg
  {$ENDIF}
  {$ENDIF}
	{$ENDIF}
  ;

type
  TgtGIFEngine = class(TgtCustomGraphicsEngine)
  private
  public
    constructor Create(AOwner: TComponent); override;
  protected
    function ShowSetupModal: Word; override;
  	procedure EndPage; override;
  published
    property Monochrome;
    property PixelFormat;
  end;

implementation

uses gtCstDocEng, gtGIFEngDlg, gtDocUtils;

{ TgtGIFEngine }

constructor TgtGIFEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Monochrome := False;
  PixelFormat := pf24bit;
{$IFDEF GIFSupport}
  FileExtension := 'gif';
(*
{$ELSE}
  FileExtension := 'jpg';
{$ENDIF}
*)
  FileDescription := SGIFDescription;
{$ENDIF}
end;

procedure TgtGIFEngine.EndPage;
{$IFDEF GIFSupport}
var
  LGIF: TGraphic;
  LBMP: TBitmap;
  LFileName: String;
{$ENDIF}
begin
  inherited;
{$IFDEF GIFSupport}
  LGIF := TGIFImage.Create;
(*
{$ELSE}
  LGIF := TJPEGImage.Create;
{$ENDIF}
*)
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

    LGIF.Assign(LBMP);
    if Preferences.OutputToUserStream then
      LGIF.SaveToStream(UserStream)
    else
    begin
    	LFileName := FileName + IntToStr(CurrentPage);
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      try
        LGIF.SaveToFile(LFileName + '.' + FileExtension);
      except
        CancelCreate;
        raise EFileCreateError.Create(SFileCreateError);
      end;
      EngineFileNames.Add(LFileName + '.' + FileExtension);
    end;
  finally
    LBMP.Free;
    LGIF.Free;
  end;
{$ENDIF}
end;

function TgtGIFEngine.ShowSetupModal: Word;
begin
  with TgtGIFEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
