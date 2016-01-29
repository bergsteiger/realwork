{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

unit gtXHTMLEng;

interface

uses Classes, gtConsts3, gtHTMLEng, gtDocConsts, gtDocResStrs;

type
  TgtXHTMLEngine = class(TgtHTMLEngine)
  protected
    function AddXHTMLHeader: String; override;
    function AddXHTMLHeader2: String; override;
    function AddMetaClose: String; override;
    function AddHRClose: String; override;
    function AddImgClose: String; override;
    function AddBR: String; override;
    function AddShapeImgSrc(ImgWidth, ImgHeight: Integer): String; override;

    function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses gtXHTMLEngDlg, Windows;

{ TgtXHTMLEngine }

function TgtXHTMLEngine.AddBR: String;
begin
  Result := '<br />';
end;

function TgtXHTMLEngine.AddHRClose: String;
begin
  Result := ' />';
end;

function TgtXHTMLEngine.AddImgClose: String;
begin
  Result := ' />';
end;

function TgtXHTMLEngine.AddMetaClose: String;
begin
  Result := ' />';
end;

function TgtXHTMLEngine.AddShapeImgSrc(ImgWidth, ImgHeight: Integer): String;
begin
  Result := '" alt="" ' + AddImgClose + '</div>' + CRLF;
end;

function TgtXHTMLEngine.AddXHTMLHeader: String;
begin
  Result := '<?xml version="1.0" encoding="' + GetISOCharSet(GetACP) + '"?>' +
    CRLF + '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" ' +
    CRLF + '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';

end;

function TgtXHTMLEngine.AddXHTMLHeader2: String;
begin
  Result := '<html xmlns="http://www.w3.org/1999/xhtml">';
end;

constructor TgtXHTMLEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FileExtension := 'htm';
  FileDescription := SXHTMLDescription;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 104);
{$ENDIF}
end;

function TgtXHTMLEngine.ShowSetupModal: Word;
begin
  with TgtXHTMLEngineDlg.Create(nil) do
    try
      Engine := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;

end.
