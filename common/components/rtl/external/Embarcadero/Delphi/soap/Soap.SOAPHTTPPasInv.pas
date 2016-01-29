{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPHTTPPasInv;

interface

uses
  System.Classes, Soap.SOAPPasInv, Soap.SOAPHTTPDisp, Soap.WSDLIntf;

type
  THTTPSoapPascalInvoker = class(TSoapPascalInvoker, IHTTPSoapDispatch)
  public
{$IFDEF NEXTGEN}
    procedure DispatchSOAP(const Path, SoapAction: string; const Request: TStream;
                           Response: TStream; var BindingType: TWebServiceBindingType); virtual;
{$ELSE !NEXTGEN}
    procedure DispatchSOAP(const Path, SoapAction: AnsiString; const Request: TStream;
                           Response: TStream; var BindingType: TWebServiceBindingType); virtual;
{$ENDIF NEXTGEN}
  end;
  { A new typename to be more C++ friendly }
  THTTPSoapCppInvoker = class(THTTPSoapPascalInvoker)
  end;

implementation

uses
  System.SysUtils, System.TypInfo, Soap.HTTPSOAPToPasBind, Soap.IntfInfo, Soap.SOAPConst;

{$IFDEF NEXTGEN}
procedure THTTPSoapPascalInvoker.DispatchSOAP(const Path, SoapAction: string; const Request: TStream;
                                              Response: TStream; var BindingType: TWebServiceBindingType);
{$ELSE !NEXTGEN}
procedure THTTPSoapPascalInvoker.DispatchSOAP(const Path, SoapAction: AnsiString; const Request: TStream;
                                              Response: TStream; var BindingType: TWebServiceBindingType);
{$ENDIF NEXTGEN}
var
  IntfInfo: PTypeInfo;
  PascalBind: IHTTPSOAPToPasBind;
  InvClassType: TClass;
  ActionMeth: String;
  MD: TIntfMetaData;

{$IFDEF NEXTGEN}
  procedure RaiseNoIntfException(const str: string);
{$ELSE !NEXTGEN}
  procedure RaiseNoIntfException(const str: AnsiString);
{$ENDIF NEXTGEN}
  var
   IntfName: string;
  begin
    IntfName := SUnknownInterface;
    try
     GetIntfMetaData(IntfInfo, MD);
     IntfName := MD.UnitName + '.' + MD.Name;
    except
    { Ignore }
    end;
    raise Exception.CreateFmt(SInvClassNotRegistered,  [IntfName, str]);
  end;

begin
  PascalBind := THTTPSOAPToPasBind.Create as IHTTPSOAPToPasBind;
  if (SoapAction <> '') and (SoapAction <> '""') then
  begin
    if not PascalBind.BindToPascalByAction(SoapAction, InvClassType, IntfInfo, ActionMeth) or (InvClassType = nil) then
    begin
      if IntfInfo = nil then
        raise Exception.CreateFmt(SInvInterfaceNotReg, [SoapAction])
      else if InvClassType = nil then
        RaiseNoIntfException(SoapAction)
      else
        raise Exception.CreateFmt(SUnknownSoapAction, [SoapAction]);
    end;
  end else
  begin
    if not PascalBind.BindToPascalByPath(Path, InvClassType, IntfInfo, ActionMeth)  or (InvClassType = nil) then
    begin
      if IntfInfo = nil then
        raise Exception.CreateFmt(SInvInterfaceNotRegURL, [Path])
      else if InvClassType = nil then
        RaiseNoIntfException(Path)
      else
        raise Exception.CreateFmt(SNoServiceForURL, [Path]);
    end;
  end;
  { Here we've found the interface/method to invoke }
  Invoke(InvClassType, IntfInfo, ActionMeth, Request, Response, BindingType);
end;

end.
