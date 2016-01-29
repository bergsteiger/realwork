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

unit gtMetafileEng;

interface
uses Classes, Graphics, SysUtils, gtCstGfxEng, gtDocResStrs;

type
  TgtMetafileEngine = class(TgtCustomGraphicsEngine)
  private
    FEnhanced: Boolean;
    procedure SetEnhanced(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
  protected
  	procedure EndPage; override;
    property Enhanced: Boolean read FEnhanced write SetEnhanced;
  published

  end;

implementation

uses gtCstDocEng, gtDocUtils, gtDocConsts;

{ TgtMetafileEngine }

constructor TgtMetafileEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TgtMetafileEngine.EndPage;
var
	LFileName: String;
  LMetafile: TMetafile;
  LMCanvas: TMetafileCanvas;
begin
  inherited;

  LMetafile := TMetafile.Create;
  LMetafile.Width := Round(FMetafile.Width * ScaleX);
  LMetafile.Height := Round(FMetafile.Height * ScaleY);

  if (ScaleX = 1) and (ScaleY = 1) then
    LMetafile.Assign(FMetafile)
  else
  begin
    LMCanvas := TMetafileCanvas.Create(LMetafile, 0);
    with LMetafile do
      LMCanvas.StretchDraw(Rect(0,0, Width, Height), FMetafile);
    LMCanvas.Free;
  end;

  if Preferences.OutputToUserStream then
    LMetafile.SaveToStream(UserStream)
  else
  begin
  	LFileName := FileName + IntToStr(CurrentPage);
    if Assigned(OnNeedFileName) then
    	OnNeedFileName(Self, LFileName, CurrentPage);
    try
      LMetafile.SaveToFile(LFileName + '.' + FileExtension);
    except
      CancelCreate;
      raise EFileCreateError.Create(SFileCreateError);
    end;
    EngineFileNames.Add(LFileName + '.' + FileExtension);
  end;
  LMetafile.Free;
end;

procedure TgtMetafileEngine.SetEnhanced(const Value: Boolean);
begin
	FEnhanced := Value;
end;

end.
