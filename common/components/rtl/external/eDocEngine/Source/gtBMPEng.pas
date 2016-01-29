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

unit gtBMPEng;

interface
uses Classes, Graphics, SysUtils, gtCstGfxEng, gtDocConsts, gtDocResStrs;

type
  TgtBMPEngine = class(TgtCustomGraphicsEngine)
  private
  public
    constructor Create(AOwner: TComponent); override;
  protected
  	procedure EndPage; override;
    function ShowSetupModal: Word; override;
  published
		property PixelFormat;
    property Monochrome;
  end;

implementation

uses gtDocUtils, gtBMPEngDlg;

{ TgtBMPEngine }

constructor TgtBMPEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileExtension := 'bmp';
  FileDescription := SBMPDescription;
  PixelFormat := pf24bit;
  Monochrome := False;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 116);
{$ENDIF}
end;

procedure TgtBMPEngine.EndPage;
var
  LBMP: TBitmap;
  LFileName: String;
begin
  inherited;
  LBMP := TBitmap.Create;
  try
    LBMP.Width := Round(FMetafile.Width * ScaleX);
    LBMP.Height := Round(FMetafile.Height * ScaleY);
    LBMP.PixelFormat := PixelFormat;
    LBMP.Monochrome := Monochrome;
    with LBMP do
      Canvas.StretchDraw(Rect(0, 0, Width, Height), FMetafile);

    if Preferences.OutputToUserStream then
      LBMP.SaveToStream(UserStream)
    else
    begin
    	LFileName := FileName + IntToStr(CurrentPage);
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      try
        LBMP.SaveToFile(LFileName + '.' + FileExtension);
      except
        CancelCreate;
        raise EFileCreateError.Create(SFileCreateError);
      end;
      EngineFileNames.Add(LFileName + '.' + FileExtension);
    end;
  finally
    LBMP.Free;
  end;
end;

function TgtBMPEngine.ShowSetupModal: Word;
begin
  with TgtBMPEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
