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

unit gtEMFEng;

interface
uses Classes, Graphics, SysUtils, gtMetafileEng, gtDocConsts, gtDocResStrs;

type
  TgtEMFEngine = class(TgtMetafileEngine)
  protected
    function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses gtEMFEngDlg;

{ TgtEMFEngine }

constructor TgtEMFEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileExtension := 'emf';
  FileDescription := SEMFDescription;
  Enhanced := True;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 117);
{$ENDIF}
end;

function TgtEMFEngine.ShowSetupModal: Word;
begin
  with TgtEMFEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
