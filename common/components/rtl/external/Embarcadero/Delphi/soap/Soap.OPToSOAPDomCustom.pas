{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.OPToSOAPDomCustom;

interface

uses
  System.TypInfo, Soap.IntfInfo, Soap.InvokeRegistry, Xml.XMLIntf;

type

  ICustomConvert = interface
  ['{96832CB3-BC12-4C45-B482-26F7160EDE51}']
    procedure ConvertSoapParamToNative(MethMD: PIntfMethEntry;
      InvContext: TInvContext; ArgCount: Integer; Node: IXMLNode);
    procedure ConvertNativeParamToSoap(Node: IXMLNode;
          Name: string; Info: PTypeInfo; P: Pointer);
  end;

  TConverterEntry = record
    Converter: ICustomConvert;
    AClass: TClass;
  end;

  TOPToSoapDomCustomRegistry = class
  private
    FConverters: array of TConverterEntry;
  public
    procedure RegisterCustomConverter(AClass: TClass; URI, TypeName: string; Converter: ICustomConvert);
    function GetConverter(AClass: TClass): ICustomConvert;
  end;

var
  ConverterRegistry: TOPToSoapDomCustomRegistry;

implementation

{ TOPToSoapDomCustomtRegistry }

function TOPToSoapDomCustomRegistry.GetConverter(
  AClass: TClass): ICustomConvert;
var
  I: Integer;
begin
  for I := 0 to Length(FConverters) - 1 do
    if FConverters[I].AClass = AClass then
      Result :=  FConverters[I].Converter;
end;

procedure TOPToSoapDomCustomRegistry.RegisterCustomConverter(
  AClass: TClass; URI, TypeName: string; Converter: ICustomConvert);
var
  Index: Integer;
begin
  Index := Length(FConverters);
  SetLength(FConverters, Index + 1);
  FConverters[Index].Converter := Converter;
  FConverters[Index].AClass := AClass;
end;

initialization
   ConverterRegistry := TOPToSoapDomCustomRegistry.Create;
finalization
   ConverterRegistry.Free;
end.
