{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{       WSDL constants                                  }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WSDLIntf;

interface

uses
  System.Generics.Collections, Xml.xmldom;

type
  //Flags for if the user specified which version of SOAP to use
  //  if unspecified, we will try to dynamically figure it out
  TSOAPVersion = (svUnspecified, svSOAP11, svSOAP12);

  TWebServiceBindingType = (btUnknown, btSoap, btHttp, btMime, btDIME);

  TWSDLElement = (weServiceIntf, weServiceImpl, weMessage, wePortType, weBinding,
                  weService, weTypes, WeImport, weOperation, wePart);
  TWSDLElements = set of TWSDLElement;


  TWString = record
    WString: DOMString;
  end;

  TDOMStrings = class
  private
    FDOMStringList: TList<DOMString>;
    function Get(Index: Integer): DOMString;
    procedure Put(Index: Integer; const S: DOMString);
  public
    constructor Create;
    destructor Destroy; override;
    function  Count: Integer;
    procedure Clear;
    function Add(const S: DOMString): Integer;
    function IndexOf(const S: DOMString): Integer;
    function IndexOfIgnoreCase(const S: DOMString): Integer;
    procedure Insert(Index: Integer; const S: DOMString);
    property Strings[Index: Integer]: DOMString read Get write Put; default;
  end;

const

  { WSDL Schema Tags and attribute names }

  SDefinitions = 'definitions';     { do not localize }
  SMessage     = 'message';         { do not localize }
  SPart        = 'part';            { do not localize }
  SType        = 'type';            { do not localize }
  STypes       = 'types';           { do not localize }
  SImport      = 'import';          { do not localize }
  SPort        = 'port';            { do not localize }
  SPortType    = 'portType';        { do not localize }
  SOperation   = 'operation';       { do not localize }
  SBinding     = 'binding';         { do not localize }
  SService     = 'service';         { do not localize }
  SSchema      = 'schema';          { do not localize }
  SName        = 'name';            { do not localize }
  STns         = 'targetNamespace'; { do not localize }
  SInput       = 'input';           { do not localize }
  SOutput      = 'output';          { do not localize }
  SInOut       = 'inout';           { do not localize }
  SRequest     = 'Request';         { do not localize }
  SResponse    = 'Response';        { do not localize }
  SReturn      = 'return';          { do not localize }
  SElement     = 'element';         { do not localize }
  SComplexType = 'complexType';     { do not localize }
  xsdns        = 'http:/'+'/www.w3.org/1999/XMLSchema';     { do not localize }
  tns          = 'http:/'+'/tempuri.org/';                  { do not localize }
  Wsdlns       = 'http:/'+'/schemas.xmlsoap.org/wsdl/';     { do not localize }
  Soapns       =  Wsdlns +'soap/';                          { do not localize }
  Soap12ns     =  Wsdlns +'soap12/';                        { do not localize }
  Httpns       =  Wsdlns +'http/';
  SOAPWSDLNamespaces: array[TSOAPVersion] of string = ('', Soapns, Soap12ns);

  SAddress     = 'address';             { do not localize }
  SBody        = 'body';                { do not localize }
  SHeader      = 'header';              { do not localize }
  SFault       = 'fault';               { do not localize }
  SVerb        = 'verb';                { do not localize }
  SStyle       = 'style';               { do not localize }
  STransport   = 'transport';           { do not localize }
  SLocation    = 'location';            { do not localize }
  SSoapAction  = 'soapAction';          { do not localize }
  SParts       = 'parts';               { do not localize }
  SUse         = 'use';                 { do not localize }
  SNameSpace   = 'namespace';           { do not localize }
  SEncodingStyle = 'encodingStyle';     { do not localize }
  SArrayOf     = 'ArrayOf';             { do not localize }
  SArray       = 'Array';               { do not localize }
  SArrayType   = 'arrayType';           { do not localize }

  SUnknown     = 'Unknown';             { do not localize }
  SDynArray    = 'array of ';           { do not localize }
  SAnySimpleType = 'anySimpleType';     { do not localize }
  SAnyType     = 'anyType';             { do not localize }
  SNsPrefix    = 'ns';                  { do not localize }

  ReservedWords: array[0..66] of string = ('and', 'array', 'as', 'asm', 'begin','case',
    'class','const','constructor','destructor', 'dispinterface', 'div', 'do','downto',
    'else', 'end', 'except', 'exports', 'file', 'finalization', 'finally', 'for','function',
    'goto', 'high', 'if', 'implementation', 'in','inherited','initialization', 'inline','interface',
    'is','label','library', 'low', 'mod','nil','not','object','of','or','out','packed','procedure',
    'program','property','raise','record','repeat', 'resourcestring', 'set','shl','shr', 'string',
    'then', 'threadvar', 'to','try','type','unit','until','uses','var','while','with','xor');

  Directives: array[0..43] of string = ('absolute','abstract','assembler','automated','cdecl','contains',
    'default','dispid', 'dynamic', 'export','external','far','forward','implements','index','message',
    'name','near','nodefault','overload','override','package','pascal','private','protected','public',
    'published','read','readonly','register','reintroduce','requires','resident','safecall','stdcall',
    'stored','virtual','write','writeonly','on','platform','deprecated','local','varargs');

  OtherReservedWords: array[0..0] of string = ('Application');

  Operators: array[0..12] of string = ('+','-','*','/','@','^','=','>','<','<>','<=','>=',':=');

  ScalarArrayTypes: array[0..12] of string = ('Integer','Cardinal','Word','SmallInt','Byte','ShortInt','Int64',
    'LongWord','Single','Double','Boolean','String','WideString');

  DynArrayTypes: array[0..12] of string = ('TIntegerDynArray','TCardinalDynArray','TWordDynArray',
    'TSmallIntDynArray','TByteDynArray','TShortIntDynArray','TInt64DynArray','TLongWordDynArray','TSingleDynArray',
    'TDoubleDynArray','TBooleanDynArray','TStringDynArray','TWideStringDynArray');

implementation

uses
  System.SysUtils, Soap.SOAPConst;

{ TDOMStrings implementation }
constructor TDOMStrings.Create;
begin
  FDOMStringList := TList<DomString>.Create;
end;

destructor TDOMStrings.Destroy;
//var
//  Index: Integer;
//  PWStr: ^TWString;
begin
                                                   
//  for Index := 0 to FDOMStringList.Count-1 do
//  begin
//    PWStr := FDOMStringList.Items[Index];
//    if PWStr <> nil then
//      Dispose(PWStr);
//  end;
  FDOMStringList.Clear;
  FDOMStringList.Free;
  inherited Destroy;
end;

function TDOMStrings.Get(Index: Integer): DOMString;
//var
//  PWStr: ^TWString;
begin
  Result := '';
  if ( (Index >= 0) and (Index < FDOMStringList.Count) ) then
  begin
//    PWStr := FDOMStringList.Items[Index];
//    if PWStr <> nil then
//      Result := PWStr^.WString;
    Result := FDOMStringList.Items[Index];
  end;
end;

procedure TDOMStrings.Put(Index: Integer; const S: DOMString);
begin
  Insert(Index,S);
end;

function TDOMStrings.Add(const S: DOMString): Integer;
//var
//  PWStr: ^TWString;
begin
//  New(PWStr);
//  PWStr^.WString := S;
//  Result := FDOMStringList.Add(PWStr);
  Result := FDOMStringList.Add(S);
end;

function TDOMStrings.IndexOfIgnoreCase(const S: DOMString): Integer;
var
  Index: Integer;
//  PWStr: ^TWString;
begin
  Result := -1;
  for Index := 0 to FDOMStringList.Count -1 do
  begin
//    PWStr := FDOMStringList.Items[Index];
//    if PWStr <> nil then
//    begin
//      if SameText(S, PWStr^.WString) then
//      begin
//        Result := Index;
//        break;
//      end;
//    end;
    if SameText(S, FDOMStringList.Items[Index]) then
    begin
      Result := Index;
      break;
    end;
  end;
end;

function TDOMStrings.IndexOf(const S: DOMString): Integer;
//var
//  Index: Integer;
//  PWStr: ^TWString;
begin
  Result := FDOMStringList.IndexOf(S);
end;

function TDOMStrings.Count: Integer;
begin
  Result := FDOMStringList.Count;
end;

procedure TDOMStrings.Clear;
//var
//  Index: Integer;
//  PWStr: ^TWString;
begin
//  for Index := 0 to FDOMStringList.Count-1 do
//  begin
//    PWStr := FDOMStringList.Items[Index];
//    if PWStr <> nil then
//      Dispose(PWStr);
//  end;
  FDOMStringList.Clear;
end;

procedure TDOMStrings.Insert(Index: Integer; const S: DOMString);
//var
//  PWStr: ^TWString;
begin
  FDOMStringList.Insert(Index, S);
//  if((Index < 0) or (Index > FDOMStringList.Count)) then
//    raise Exception.Create(SWideStringOutofBounds);
//  if Index < FDOMStringList.Count then
//  begin
//    PWStr := FDOMStringList.Items[Index];
//    if PWStr <> nil then
//      PWStr.WString := S;
//  end
//  else
//    Add(S);
end;

end.

