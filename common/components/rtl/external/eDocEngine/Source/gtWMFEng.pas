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

unit gtWMFEng;

interface
uses Classes, Graphics, SysUtils, gtMetafileEng, gtDocConsts, gtDocResStrs;

type
  TgtWMFEngine = class(TgtMetafileEngine)
	protected
    function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses gtWMFEngDlg;

{ TgtWMFEngine }

constructor TgtWMFEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileExtension := 'wmf';
  FileDescription := SWMFDescription;
  Enhanced := False;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 118);
{$ENDIF}
end;

function TgtWMFEngine.ShowSetupModal: Word;
begin
  with TgtWMFEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
