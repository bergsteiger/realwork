{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPHTTPDisp;

interface

uses
  System.Classes, Soap.WSDLIntf;

type

  IHTTPSoapDispatch = interface
  ['{9E733EDC-7639-4DAF-96FF-BCF141F7D8F2}']
{$IFDEF NEXTGEN}
    procedure DispatchSOAP(const Path, SoapAction: string; const Request: TStream;
                           Response: TStream; var BindingType: TWebServiceBindingType);
{$ELSE !NEXTGEN}
    procedure DispatchSOAP(const Path, SoapAction: AnsiString; const Request: TStream;
                           Response: TStream; var BindingType: TWebServiceBindingType);
{$ENDIF NEXTGEN}
  end;

  THTTPSoapDispatchNode = class(TComponent)
  private
    procedure SetSoapDispatcher(const Value: IHTTPSoapDispatch);
  protected
    FSoapDispatcher: IHTTPSoapDispatch;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
{$IFDEF NEXTGEN}
    procedure DispatchSOAP(const Path, SoapAction: string; const Request: TStream;
      Response: TStream); virtual;
{$ELSE !NEXTGEN}
    procedure DispatchSOAP(const Path, SoapAction: AnsiString; const Request: TStream;
      Response: TStream); virtual;
{$ENDIF NEXTGEN}
  published
    property Dispatcher: IHTTPSoapDispatch read FSoapDispatcher write SetSoapDispatcher;
  end;

implementation

procedure THTTPSoapDispatchNode.SetSoapDispatcher(const Value: IHTTPSoapDispatch);
begin
  ReferenceInterface(FSoapDispatcher, opRemove);
  FSoapDispatcher := Value;
  ReferenceInterface(FSoapDispatcher, opInsert);
end;

procedure THTTPSoapDispatchNode.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and AComponent.IsImplementorOf(FSoapDispatcher) then
    FSoapDispatcher := nil;
end;

{$IFDEF NEXTGEN}
procedure THTTPSoapDispatchNode.DispatchSOAP(const Path, SoapAction: string;
  const Request: TStream;  Response: TStream);
{$ELSE !NEXTGEN}
procedure THTTPSoapDispatchNode.DispatchSOAP(const Path, SoapAction: AnsiString;
  const Request: TStream;  Response: TStream);
{$ENDIF NEXTGEN}
begin
end;

end.
