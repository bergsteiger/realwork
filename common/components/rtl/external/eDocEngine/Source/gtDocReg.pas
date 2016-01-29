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

{$I gtDefines.Inc}
{$I gtDocDefines.inc}

unit gtDocReg;

interface

procedure Register;

implementation

{$IFDEF gtDelphi2005}
  {$R gtDocRegD2005.DCR}
{$ELSE}
  {$R gtDocReg.DCR}
{$ENDIF}


uses
	Classes, TypInfo,
  {$IFDEF gtDelphi6Up}
		DesignIntf, DesignEditors,
  {$ELSE}
		DsgnIntf,
  {$ENDIF}
  gtclasses3, gtDocConsts, gtCstDocEng,
  gtPDFEng, gtRTFEng, gtHTMLEng, gtXHTMLEng, gtTXTEng,
  gtXLSEng, gtQProEng, gtSLKEng, gtDIFEng, gtLotusEng, gtXLS95Eng,
  gtBMPEng, gtJPEGEng, gtGIFEng, gtEMFEng, gtWMFEng,
  {$IFDEF gtPro}
  gtSVGEng, gtTIFFEng, gtPNGEng,
  {$ENDIF}
  gtClipboard;

type

  TgtAboutProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

  TgtVersionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

procedure Register;
begin
	RegisterComponents('eDocEngine', [TgtDocSettings, TgtPDFEngine, TgtRTFEngine,
  TgtHTMLEngine, TgtXHTMLEngine, TgtExcelEngine, TgtTextEngine,
  TgtQuattroProEngine, TgtLotusEngine, TgtDIFEngine, TgtSYLKEngine,TgtXLSEngine,
  {$IFDEF gtPro}
    TgtTIFFEngine, TgtPNGEngine, TgtSVGEngine,
  {$ENDIF}
  TgtJPEGEngine, TgtGIFEngine, TgtBMPEngine, TgtEMFEngine, TgtWMFEngine,
  TgtClipBoard
  ]);
  RegisterPropertyEditor(TypeInfo(String), TgtBaseComponent, 'About',
    TgtAboutProperty);
  RegisterPropertyEditor(TypeInfo(String), TgtBaseComponent, 'Version',
    TgtVersionProperty);
end;

{ TgtAboutProperty }

procedure TgtAboutProperty.Edit;
begin
  inherited;

end;

function TgtAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly];
end;

function TgtAboutProperty.GetValue: string;
begin
  Result := 'Gnostice eDocEngine (www.gnostice.com)';
end;

{ TgtVersionProperty }

procedure TgtVersionProperty.Edit;
begin
  inherited;
end;

function TgtVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly];
end;

function TgtVersionProperty.GetValue: string;
begin
  Result := CVersion;
end;

end.
