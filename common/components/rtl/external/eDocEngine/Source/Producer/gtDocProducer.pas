{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                              }
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

{$I ..\gtDefines.inc}
{$I ..\gtDocDefines.inc}

unit gtDocProducer;

interface

uses
  Classes, HTTPApp, gtCstDocEng, gtXportIntf;

type

  TgtDocProducer = class;

	TgtOnCreateContent = procedure(Sender: TgtDocProducer) of object;

  TgtDocProducer = class(TCustomContentProducer)
  private
    FStream: TStream;
    FEngine: TgtCustomDocumentEngine;
    FExportInterface: TgtExportInterface;
    FOnCreateContent: TgtOnCreateContent;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetExportInterface(const Value: TgtExportInterface);
    procedure SetOnCreateContent(const Value: TgtOnCreateContent);

    function GetContentType: string;
  public
    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;

    function Content: string; override;
  published
    property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;
    property ExportInterface: TgtExportInterface read FExportInterface
      write SetExportInterface;

    property OnCreateContent: TgtOnCreateContent read FOnCreateContent
      write SetOnCreateContent;
  end;


implementation
uses

  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng,
  gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng
{$IFDEF gtPro}
  , gtTIFFEng, gtPNGEng, gtSVGEng
{$ENDIF};

constructor TgtDocProducer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStream := TMemoryStream.Create;
  FEngine := nil;
  FExportInterface := nil;
end;

function TgtDocProducer.Content: string;
var
  WebResponse: TWebResponse;
  LEngine: TgtCustomDocumentEngine;
begin
  WebResponse := Dispatcher.Response;

  LEngine := FEngine;
  if FExportInterface <> nil then
    LEngine := FExportInterface.Engine;
  if LEngine <> nil then
  begin
    IgtDocumentEngine(LEngine).Preferences.OutputToUserStream := True;
    LEngine.UserStream := FStream;
  end;

  if Assigned(FOnCreateContent) then
    OnCreateContent(Self);

  WebResponse.ContentType := GetContentType;
  Result := '';
  FStream.Position := 0;
  SetLength(Result, FStream.Size - 1);
  FStream.Read(Pointer(Result)^, FStream.Size);
end;

destructor TgtDocProducer.Destroy;
begin
  inherited;
  FStream.Free;
end;

procedure TgtDocProducer.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
  IgtDocumentEngine(FEngine).Preferences.OutputToUserStream := True;
  FEngine.UserStream := FStream;

  if (FEngine <> nil) and (FExportInterface <> nil) then
    FExportInterface := nil;
end;

procedure TgtDocProducer.SetExportInterface(const Value: TgtExportInterface);
begin
  FExportInterface := Value;
  with FExportInterface do
  begin
    IgtDocumentEngine(Engine).Preferences.OutputToUserStream := True;
    Engine.UserStream := FStream;
  end;

  if (FEngine <> nil) and (FExportInterface <> nil) then
    FEngine := nil
end;

procedure TgtDocProducer.SetOnCreateContent(const Value: TgtOnCreateContent);
begin
  FOnCreateContent := Value;
end;

function TgtDocProducer.GetContentType: string;
var
  LEngine: TgtCustomDocumentEngine;
begin
  if Engine <> nil then
    LEngine := Engine
  else
    LEngine := FExportInterface.Engine;
    
  Result := '';
  if LEngine is TgtPDFEngine then
    Result := 'application/pdf'
  else
  if LEngine is TgtRTFEngine then
    Result := 'application/rtf'
  else
  if LEngine is TgtHTMLEngine then
    Result := 'text/html'
  else
  if LEngine is TgtXHTMLEngine then
    Result := 'text/html'
  else
{$IFDEF gtPro}
  if LEngine is TgtSVGEngine then
    Result := 'image/svg+xml'
  else
  if LEngine is TgtTIFFEngine then
    Result := 'image/tiff'
  else
  if LEngine is TgtPNGEngine then
    Result := 'image/png'
  else
{$ENDIF}
  if LEngine is TgtJPEGEngine then
    Result := 'image/jpeg'
  else
  if LEngine is TgtGIFEngine then
    Result := 'image/gif'
  else
  if LEngine is TgtEMFEngine then
    Result := 'windows/metafile'
  else
  if LEngine is TgtWMFEngine then
    Result := 'windows/metafile'
  else
  if LEngine is TgtBMPEngine then
    Result := 'image/bmp'
  else
  if LEngine is TgtExcelEngine then
    Result := 'application/excel'
  else
  if LEngine is TgtQuattroProEngine then
    Result := 'application/x-qpro'
  else
  if LEngine is TgtLotusEngine then
    Result := 'application/x-123'
  else
  if LEngine is TgtDIFEngine then
    Result := 'Not Registered'
  else
  if LEngine is TgtSYLKEngine then
    Result := 'text/spreadsheet'
  else
  if LEngine is TgtTextEngine then
    Result := 'text/plain';
end;

end.
 