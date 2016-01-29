
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1999 Inprise Corporation          }
{                                                       }
{*******************************************************}

unit CorbaStd;

interface

{$H+,X+}

uses Classes, ActiveX, Midas, Forms, CorbaObj, OrbPas;

type

  { TAppServerSkeleton }

  TAppServerSkeleton = class(TCorbaSkeleton)
  private
    FIntf: IAppServer;
  public
    constructor Create(const InstanceName: string; const Impl: IUnknown); override;
    procedure GetImplementation(out Impl: IUnknown); override; stdcall;
  published
    procedure AS_ApplyUpdates(const InBuf: IMarshalInBuffer; Cookie: Pointer);
    procedure AS_GetRecords(const InBuf: IMarshalInBuffer; Cookie: Pointer);
    procedure AS_DataRequest(const InBuf: IMarshalInBuffer; Cookie: Pointer);
    procedure AS_GetProviderNames(const InBuf: IMarshalInBuffer; Cookie: Pointer);
    procedure AS_GetParams(const InBuf: IMarshalInBuffer; Cookie: Pointer);
    procedure AS_RowRequest(const InBuf: IMarshalInBuffer; Cookie: Pointer);
    procedure AS_Execute(const InBuf: IMarshalInBuffer; Cookie: Pointer);
  end;

  { TAppServerStub }

  TAppServerStub = class(TCorbaDispatchStub, IAppServer)
  public
    function AS_ApplyUpdates {SC:Y, (5/6) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                Delta: {VT:12:0}(*VT_12:0*)OleVariant;
                                                                MaxErrors: {VT:3:0}(*VT_3:0*)Integer;
                                                                out ErrorCount: {VT:3:1}(*VT_3:0*)Integer;
                                                                var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant; safecall;
    function AS_GetRecords {SC:Y, (6/7) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                              Count: {VT:3:0}(*VT_3:0*)Integer;
                                                              out RecsOut: {VT:3:1}(*VT_3:0*)Integer;
                                                              Options: {VT:3:0}(*VT_3:0*)Integer;
                                                              const CommandText: {VT:8:0}(*VT_8:0*)WideString;
                                                              var Params: {VT:12:1}(*VT_12:0*)OleVariant;
                                                              var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant; safecall;
    function AS_DataRequest {SC:Y, (2/3) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                               Data: {VT:12:0}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant; safecall;
    function AS_GetProviderNames {SC:Y, (0/1) CALL:0, INV:1, DBG:7}: (*VT_12:0*)OleVariant; safecall;
    function AS_GetParams {SC:Y, (2/3) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                             var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant; safecall;
    function AS_RowRequest {SC:Y, (4/5) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                              Row: {VT:12:0}(*VT_12:0*)OleVariant;
                                                              RequestType: {VT:3:0}(*VT_3:0*)Integer;
                                                              var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant; safecall;
    procedure AS_Execute {SC:Y, (3/3) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                            const CommandText: {VT:8:0}(*VT_8:0*)WideString;
                                                            var Params: {VT:12:1}(*VT_12:0*)OleVariant;
                                                            var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant); safecall;
  end;


implementation


{ TAppServerSkeleton }

constructor TAppServerSkeleton.Create(const InstanceName: string; const Impl: IUnknown);
begin
  inherited;
  inherited InitSkeleton('AppServer', InstanceName, 'IDL:Project1/IAppServer:1.0', tmMultiThreaded, True);
  FIntf := Impl as IAppServer;
end;

procedure TAppServerSkeleton.GetImplementation(out Impl: IUnknown);
begin
  Impl := FIntf;
end;

procedure TAppServerSkeleton.AS_ApplyUpdates(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  Retval: (*VT_12:0*)OleVariant;
  ProviderName: (*VT_8:0*)WideString;
  Delta: (*VT_12:0*)OleVariant;
  MaxErrors: (*VT_3:0*)Integer;
  ErrorCount: (*VT_3:0*)Integer;
  OwnerData: (*VT_12:0*)OleVariant;
begin
  ProviderName := UnmarshalWideText(InBuf);
  Delta := UnmarshalAny(InBuf);
  MaxErrors := InBuf.GetLong;
  OwnerData := UnmarshalAny(InBuf);
  Retval := FIntf.AS_ApplyUpdates(ProviderName, Delta, MaxErrors, ErrorCount, OwnerData);
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Retval);
  OutBuf.PutLong(ErrorCount);
  MarshalAny(OutBuf, OwnerData);
end;

procedure TAppServerSkeleton.AS_GetRecords(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  Retval: (*VT_12:0*)OleVariant;
  ProviderName: (*VT_8:0*)WideString;
  Count: (*VT_3:0*)Integer;
  RecsOut: (*VT_3:0*)Integer;
  Options: (*VT_3:0*)Integer;
  CommandText: (*VT_8:0*)WideString;
  Params: (*VT_12:0*)OleVariant;
  OwnerData: (*VT_12:0*)OleVariant;
begin
  ProviderName := UnmarshalWideText(InBuf);
  Count := InBuf.GetLong;
  Options := InBuf.GetLong;
  CommandText := UnmarshalWideText(InBuf);
  Params := UnmarshalAny(InBuf);
  OwnerData := UnmarshalAny(InBuf);
  Retval := FIntf.AS_GetRecords(ProviderName, Count, RecsOut, Options, CommandText, Params, OwnerData);
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Retval);
  OutBuf.PutLong(RecsOut);
  MarshalAny(OutBuf, Params);
  MarshalAny(OutBuf, OwnerData);
end;

procedure TAppServerSkeleton.AS_DataRequest(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  Retval: (*VT_12:0*)OleVariant;
  ProviderName: (*VT_8:0*)WideString;
  Data: (*VT_12:0*)OleVariant;
begin
  ProviderName := UnmarshalWideText(InBuf);
  Data := UnmarshalAny(InBuf);
  Retval := FIntf.AS_DataRequest(ProviderName, Data);
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Retval);
end;

procedure TAppServerSkeleton.AS_GetProviderNames(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  Retval: (*VT_12:0*)OleVariant;
begin
  Retval := FIntf.AS_GetProviderNames;
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Retval);
end;

procedure TAppServerSkeleton.AS_GetParams(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  Retval: (*VT_12:0*)OleVariant;
  ProviderName: (*VT_8:0*)WideString;
  OwnerData: (*VT_12:0*)OleVariant;
begin
  ProviderName := UnmarshalWideText(InBuf);
  OwnerData := UnmarshalAny(InBuf);
  Retval := FIntf.AS_GetParams(ProviderName, OwnerData);
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Retval);
  MarshalAny(OutBuf, OwnerData);
end;

procedure TAppServerSkeleton.AS_RowRequest(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  Retval: (*VT_12:0*)OleVariant;
  ProviderName: (*VT_8:0*)WideString;
  Row: (*VT_12:0*)OleVariant;
  RequestType: (*VT_3:0*)Integer;
  OwnerData: (*VT_12:0*)OleVariant;
begin
  ProviderName := UnmarshalWideText(InBuf);
  Row := UnmarshalAny(InBuf);
  RequestType := InBuf.GetLong;
  OwnerData := UnmarshalAny(InBuf);
  Retval := FIntf.AS_RowRequest(ProviderName, Row, RequestType, OwnerData);
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Retval);
  MarshalAny(OutBuf, OwnerData);
end;

procedure TAppServerSkeleton.AS_Execute(const InBuf: IMarshalInBuffer; Cookie: Pointer);
var
  OutBuf: IMarshalOutBuffer;
  ProviderName: (*VT_8:0*)WideString;
  CommandText: (*VT_8:0*)WideString;
  Params: (*VT_12:0*)OleVariant;
  OwnerData: (*VT_12:0*)OleVariant;
begin
  ProviderName := UnmarshalWideText(InBuf);
  CommandText := UnmarshalWideText(InBuf);
  Params := UnmarshalAny(InBuf);
  OwnerData := UnmarshalAny(InBuf);
  FIntf.AS_Execute(ProviderName, CommandText, Params, OwnerData);
  FSkeleton.GetReplyBuffer(Cookie, OutBuf);
  MarshalAny(OutBuf, Params);
  MarshalAny(OutBuf, OwnerData);
end;

{ TAppServerStub }

function TAppServerStub.AS_ApplyUpdates {SC:Y, (5/6) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                           Delta: {VT:12:0}(*VT_12:0*)OleVariant;
                                                                           MaxErrors: {VT:3:0}(*VT_3:0*)Integer;
                                                                           out ErrorCount: {VT:3:1}(*VT_3:0*)Integer;
                                                                           var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant;
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_ApplyUpdates', True, OutBuf);
  OutBuf.PutWideText(PWideChar(Pointer(ProviderName)));
  MarshalAny(OutBuf, Delta);
  OutBuf.PutLong(MaxErrors);
  MarshalAny(OutBuf, OwnerData);
  FStub.Invoke(OutBuf, InBuf);
  Result := UnmarshalAny(InBuf);
  ErrorCount := InBuf.GetLong;
  OwnerData := UnmarshalAny(InBuf);
end;

function TAppServerStub.AS_GetRecords {SC:Y, (6/7) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                         Count: {VT:3:0}(*VT_3:0*)Integer;
                                                                         out RecsOut: {VT:3:1}(*VT_3:0*)Integer;
                                                                         Options: {VT:3:0}(*VT_3:0*)Integer;
                                                                         const CommandText: {VT:8:0}(*VT_8:0*)WideString;
                                                                         var Params: {VT:12:1}(*VT_12:0*)OleVariant;
                                                                         var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant;
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_GetRecords', True, OutBuf);
  OutBuf.PutWideText(PWideChar(Pointer(ProviderName)));
  OutBuf.PutLong(Count);
  OutBuf.PutLong(Options);
  OutBuf.PutWideText(PWideChar(Pointer(CommandText)));
  MarshalAny(OutBuf, Params);
  MarshalAny(OutBuf, OwnerData);
  FStub.Invoke(OutBuf, InBuf);
  Result := UnmarshalAny(InBuf);
  RecsOut := InBuf.GetLong;
  Params := UnmarshalAny(InBuf);
  OwnerData := UnmarshalAny(InBuf);
end;

function TAppServerStub.AS_DataRequest {SC:Y, (2/3) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                          Data: {VT:12:0}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant;
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_DataRequest', True, OutBuf);
  OutBuf.PutWideText(PWideChar(Pointer(ProviderName)));
  MarshalAny(OutBuf, Data);
  FStub.Invoke(OutBuf, InBuf);
  Result := UnmarshalAny(InBuf);
end;

function TAppServerStub.AS_GetProviderNames {SC:Y, (0/1) CALL:0, INV:1, DBG:7}: (*VT_12:0*)OleVariant;
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_GetProviderNames', True, OutBuf);
  FStub.Invoke(OutBuf, InBuf);
  Result := UnmarshalAny(InBuf);
end;

function TAppServerStub.AS_GetParams {SC:Y, (2/3) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                        var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant;
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_GetParams', True, OutBuf);
  OutBuf.PutWideText(PWideChar(Pointer(ProviderName)));
  MarshalAny(OutBuf, OwnerData);
  FStub.Invoke(OutBuf, InBuf);
  Result := UnmarshalAny(InBuf);
  OwnerData := UnmarshalAny(InBuf);
end;

function TAppServerStub.AS_RowRequest {SC:Y, (4/5) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                         Row: {VT:12:0}(*VT_12:0*)OleVariant;
                                                                         RequestType: {VT:3:0}(*VT_3:0*)Integer;
                                                                         var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant): (*VT_12:0*)OleVariant;
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_RowRequest', True, OutBuf);
  OutBuf.PutWideText(PWideChar(Pointer(ProviderName)));
  MarshalAny(OutBuf, Row);
  OutBuf.PutLong(RequestType);
  MarshalAny(OutBuf, OwnerData);
  FStub.Invoke(OutBuf, InBuf);
  Result := UnmarshalAny(InBuf);
  OwnerData := UnmarshalAny(InBuf);
end;

procedure TAppServerStub.AS_Execute {SC:Y, (3/3) CALL:0, INV:1, DBG:7}(const ProviderName: {VT:8:0}(*VT_8:0*)WideString;
                                                                       const CommandText: {VT:8:0}(*VT_8:0*)WideString;
                                                                       var Params: {VT:12:1}(*VT_12:0*)OleVariant;
                                                                       var OwnerData: {VT:12:1}(*VT_12:0*)OleVariant);
var
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
begin
  FStub.CreateRequest('AS_Execute', True, OutBuf);
  OutBuf.PutWideText(PWideChar(Pointer(ProviderName)));
  OutBuf.PutWideText(PWideChar(Pointer(CommandText)));
  MarshalAny(OutBuf, Params);
  MarshalAny(OutBuf, OwnerData);
  FStub.Invoke(OutBuf, InBuf);
  Params := UnmarshalAny(InBuf);
  OwnerData := UnmarshalAny(InBuf);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Vcl\corbastd.pas initialization enter'); {$EndIf}
  CORBASkeletonManager.RegisterSkeleton(IAppServer, TAppServerSkeleton);
  CORBAStubManager.RegisterStub(IAppServer, TAppServerStub);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Vcl\corbastd.pas initialization leave'); {$EndIf}
end.
