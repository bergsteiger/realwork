{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WSDLSOAP;

interface

uses Soap.InvokeRegistry, System.Types;

type

  TWSDLSOAPPort = class(TRemotable)
  private
    FPortName: OleStr;
{$IFDEF NEXTGEN}
    FAddresses: TStringDynArray;
{$ELSE !NEXTGEN}
    FAddresses: TWideStringDynArray;
{$ENDIF NEXTGEN}
  published
    property PortName: OleStr read FPortName write FPortName;
{$IFDEF NEXTGEN}
    property Addresses: TStringDynArray read FAddresses write FAddresses;
{$ELSE !NEXTGEN}
    property Addresses: TWideStringDynArray read FAddresses write FAddresses;
{$ENDIF NEXTGEN}
  end;

  TWSDLSOAPPortArray = array of TWSDLSOAPPort;

implementation

uses Soap.SOAPConst;

initialization
  RemClassRegistry.RegisterXSClass(TWSDLSOAPPort, SBorlandTypeNamespace);
end.
