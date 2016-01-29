{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPDomConv;

interface

uses
  System.Classes, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Soap.OPConvert;

type

  IDOMHeaderProcessor = interface
  ['{27F23F8F-23A2-4257-95A8-0204EEFF937B}']
    procedure ProcessHeader(HeaderNode: IXMLNode; var Handled, AbortRequest: Boolean);
    function  CreateHeader(HeaderNode: IXMLNode): IXMLNode;
  end;

  TDOMHeaderProcessorEntry = record
    Processor: IDOMHeaderProcessor;
{$IFDEF NEXTGEN}
    NameSpace: string;
    HeaderName: string;
    TypeName: string;
{$ELSE !NEXTGEN}
    NameSpace: WideString;
    HeaderName: WideString;
    TypeName: WideString;
{$ENDIF NEXTGEN}
  end;

  TDOMHeaderProcessorArray = array of TDOMHeaderProcessorEntry;

  TSOAPDOMProcessor = class(TComponent, IInterface)
  private
{$IFNDEF AUTOREFCOUNT}
    FRefCount: Integer;
    FOwnerIsComponent: Boolean;
{$ENDIF !AUTOREFCOUNT}
  protected
    FHeaderProcessors:  TDOMHeaderProcessorArray;
{$IFDEF NEXTGEN}
    function  FindHeaderProcessor(Namespace, HeaderName, TypeName: string): IDOMHeaderProcessor; virtual;
{$ELSE !NEXTGEN}
    function  FindHeaderProcessor(Namespace, HeaderName, TypeName: WideString): IDOMHeaderProcessor; virtual;
{$ENDIF NEXTGEN}
    function  MakeHeaderNodes(HeaderNode: IXMLNode): IXMLNode;
{$IFNDEF AUTOREFCOUNT}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF !AUTOREFCOUNT}
  public
{$IFDEF NEXTGEN}
    procedure AddHeaderProcessor(Namespace, HeaderName, TypeName: string; Processor: IDOMHeaderProcessor); virtual;
{$ELSE !NEXTGEN}
    procedure AddHeaderProcessor(Namespace, HeaderName, TypeName: WideString; Processor: IDOMHeaderProcessor); virtual;
{$ENDIF NEXTGEN}
    procedure DefaultProcessHeader(HeaderNode: IXMLNode; var Handled, AbortRequest: Boolean); virtual;

{$IFNDEF AUTOREFCOUNT}
    class function NewInstance: TObject; override;
    procedure AfterConstruction; override;
{$ENDIF !AUTOREFCOUNT}
    destructor Destroy; override;
  end;

implementation

uses
  System.Variants, System.SyncObjs, System.SysUtils, Soap.SOAPConst, Soap.InvokeRegistry;

{ TSOAPDOMProcessor }

destructor TSOAPDOMProcessor.Destroy;
begin
  inherited;
end;

{$IFNDEF AUTOREFCOUNT}
class function TSOAPDOMProcessor.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TSOAPDOMProcessor(Result).FRefCount := 1;
end;

procedure TSOAPDOMProcessor.AfterConstruction;
begin
  inherited;
  FOwnerIsComponent := Assigned(Owner) and (Owner is TComponent);
  TInterlocked.Decrement(FRefCount);
end;
{$ENDIF !AUTOREFCOUNT}

{ IInterface }

{$IFNDEF AUTOREFCOUNT}
function TSOAPDOMProcessor._AddRef: Integer;
begin
  Result := TInterlocked.Increment(FRefCount)
end;

function TSOAPDOMProcessor._Release: Integer;
begin
  Result := TInterlocked.Decrement(FRefCount);
  { If we are not being used as a TComponent, then use refcount to manage our
    lifetime as with TInterfacedObject. }
  if (Result = 0) and not FOwnerIsComponent then
    Destroy;
end;
{$ENDIF !AUTOREFCOUNT}

{$IFDEF NEXTGEN}
procedure TSOAPDOMProcessor.AddHeaderProcessor(Namespace, HeaderName, TypeName: string;
  Processor: IDOMHeaderProcessor);
{$ELSE !NEXTGEN}
procedure TSOAPDOMProcessor.AddHeaderProcessor(Namespace, HeaderName, TypeName: WideString;
  Processor: IDOMHeaderProcessor);
{$ENDIF NEXTGEN}
var
  I: Integer;
begin
  I := Length(FHeaderProcessors);
  SetLength(FHeaderProcessors, I + 1);
  FHeaderProcessors[I].NameSpace := NameSpace;
  FHeaderProcessors[I].HeaderName := HeaderName;
  FHeaderProcessors[I].TypeName := TypeName;
  FHeaderProcessors[I].Processor := Processor;
end;

procedure TSOAPDOMProcessor.DefaultProcessHeader(HeaderNode: IXMLNode;
  var Handled, AbortRequest: Boolean);
var
  V: Variant;
begin
  V := HeaderNode.Attributes[SHeaderMustUnderstand];
  if not VarIsNull(V) then
  begin
    if (V = '1') or SameText(V, 'true') then
      raise ERemotableException.Create(Format(SHeaderAttributeError, [ExtractLocalName(HeaderNode.NodeName)]),
                                       SFaultCodeMustUnderstand);
  end;
end;

{$IFDEF NEXTGEN}
function TSOAPDOMProcessor.FindHeaderProcessor(Namespace, HeaderName,
  TypeName: string): IDOMHeaderProcessor;
{$ELSE !NEXTGEN}
function TSOAPDOMProcessor.FindHeaderProcessor(Namespace, HeaderName,
  TypeName: WideString): IDOMHeaderProcessor;
{$ENDIF NEXTGEN}
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Length(FHeaderProcessors) - 1 do
  begin
    if (FHeaderProcessors[I].NameSpace = NameSpace) and
       (FHeaderProcessors[I].HeaderName = HeaderName) and
       (FHeaderProcessors[I].TypeName = TypeName) then
    begin
      Result :=  FHeaderProcessors[I].Processor;
      Exit;
    end;
  end;
end;

function TSOAPDOMProcessor.MakeHeaderNodes(HeaderNode: IXMLNode): IXMLNode;
var
  I: Integer;
  Node: IXMLNode;
begin
  for I := 0 to Length(FHeaderProcessors) - 1 do
    if Assigned(FHeaderProcessors[I].Processor) then
    begin
      Node := FHeaderProcessors[I].Processor.CreateHeader(HeaderNode);
      if Node <> nil then
        HeaderNode.ChildNodes.Add(Node);
    end;
end;

end.
