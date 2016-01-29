{*******************************************************}
{                                                       }
{ Borland Delphi Visual Component Library               }
{                SOAP Support                           }
{                                                       }
{ Copyright (c) 2001 Borland Software Corporation       }
{                                                       }
{*******************************************************}

unit WSDLSOAP;

interface

uses InvokeRegistry, Types;

type

  TWSDLSOAPPort = class(TRemotable)
  private
    FPortName: WideString;
    FAddresses: TWideStringDynArray;
  published
    property PortName: WideString read FPortName write FPortName;
    property Addresses: TWideStringDynArray read FAddresses write FAddresses;
  end;

  TWSDLSOAPPortArray = array of TWSDLSOAPPort;

implementation

uses SOAPConst;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Soap\WSDLSoap.pas initialization enter'); {$EndIf}
  RemClassRegistry.RegisterXSClass(TWSDLSOAPPort, SBorlandTypeNamespace);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Soap\WSDLSoap.pas initialization leave'); {$EndIf}
end.
