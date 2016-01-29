{==============================================================================|
| Project : Delphree - Synapse                                   | 002.005.000 |
|==============================================================================|
| Content: SNMP client                                                         |
|==============================================================================|
| Copyright (c)1999-2002, Lukas Gebauer                                        |
| All rights reserved.                                                         |
|                                                                              |
| Redistribution and use in source and binary forms, with or without           |
| modification, are permitted provided that the following conditions are met:  |
|                                                                              |
| Redistributions of source code must retain the above copyright notice, this  |
| list of conditions and the following disclaimer.                             |
|                                                                              |
| Redistributions in binary form must reproduce the above copyright notice,    |
| this list of conditions and the following disclaimer in the documentation    |
| and/or other materials provided with the distribution.                       |
|                                                                              |
| Neither the name of Lukas Gebauer nor the names of its contributors may      |
| be used to endorse or promote products derived from this software without    |
| specific prior written permission.                                           |
|                                                                              |
| THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"  |
| AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE    |
| IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE   |
| ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR  |
| ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL       |
| DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR   |
| SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER   |
| CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT           |
| LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY    |
| OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH  |
| DAMAGE.                                                                      |
|==============================================================================|
| The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
| Portions created by Lukas Gebauer are Copyright (c)2000,2001.                |
| All Rights Reserved.                                                         |
|==============================================================================|
| Contributor(s):                                                              |
|   Jean-Fabien Connault (cycocrew@worldnet.fr)                                |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================}

{$Q-}
{$WEAKPACKAGEUNIT ON}

unit SNMPSend;

interface

uses
  Classes, SysUtils,
  blckSock, SynaUtil, ASN1Util;

const
  cSnmpProtocol = '161';

  //PDU type
  PDUGetRequest = $A0;
  PDUGetNextRequest = $A1;
  PDUGetResponse = $A2;
  PDUSetRequest = $A3;
  PDUTrap = $A4;

  //errors
  ENoError = 0;
  ETooBig = 1;
  ENoSuchName = 2;
  EBadValue = 3;
  EReadOnly = 4;
  EGenErr = 5;

type
  TSNMPMib = class(TObject)
  private
    FOID: string;
    FValue: string;
    FValueType: Integer;
  published
    property OID: string read FOID write FOID;
    property Value: string read FValue write FValue;
    property ValueType: Integer read FValueType write FValueType;
  end;

  TSNMPRec = class(TObject)
  private
    FVersion: Integer;
    FCommunity: string;
    FPDUType: Integer;
    FID: Integer;
    FErrorStatus: Integer;
    FErrorIndex: Integer;
    FSNMPMibList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function DecodeBuf(const Buffer: string): Boolean;
    function EncodeBuf: string;
    procedure Clear;
    procedure MIBAdd(const MIB, Value: string; ValueType: Integer);
    procedure MIBDelete(Index: Integer);
    function MIBGet(const MIB: string): string;
  published
    property Version: Integer read FVersion write FVersion;
    property Community: string read FCommunity write FCommunity;
    property PDUType: Integer read FPDUType write FPDUType;
    property ID: Integer read FID write FID;
    property ErrorStatus: Integer read FErrorStatus write FErrorStatus;
    property ErrorIndex: Integer read FErrorIndex write FErrorIndex;
    property SNMPMibList: TList read FSNMPMibList;
  end;

  TSNMPSend = class(TSynaClient)
  private
    FSock: TUDPBlockSocket;
    FBuffer: string;
    FHostIP: string;
    FQuery: TSNMPRec;
    FReply: TSNMPRec;
  public
    constructor Create;
    destructor Destroy; override;
    function DoIt: Boolean;
  published
    property HostIP: string read FHostIP;
    property Query: TSNMPRec read FQuery;
    property Reply: TSNMPRec read FReply;
    property Sock: TUDPBlockSocket read FSock;
  end;

function SNMPGet(const OID, Community, SNMPHost: string; var Value: string): Boolean;
function SNMPSet(const OID, Community, SNMPHost, Value: string; ValueType: Integer): Boolean;
function SNMPGetNext(var OID: string; const Community, SNMPHost: string; var Value: string): Boolean;
function SNMPGetTable(const BaseOID, Community, SNMPHost: string; const Value: TStrings): Boolean;
function SNMPGetTableElement(const BaseOID, RowID, ColID, Community, SNMPHost: string; var Value: String): Boolean;

implementation

{==============================================================================}

constructor TSNMPRec.Create;
begin
  inherited Create;
  FSNMPMibList := TList.Create;
  FID := 1;
end;

destructor TSNMPRec.Destroy;
var
  i: Integer;
begin
  for i := 0 to FSNMPMibList.Count - 1 do
    TSNMPMib(FSNMPMibList[i]).Free;
  FSNMPMibList.Clear;
  FSNMPMibList.Free;
  inherited Destroy;
end;

function TSNMPRec.DecodeBuf(const Buffer: string): Boolean;
var
  Pos: Integer;
  EndPos: Integer;
  sm, sv: string;
  Svt: Integer;
begin
  Result := False;
  if Length(Buffer) < 2 then
    Exit;
  if (Ord(Buffer[1]) and $20) = 0 then
    Exit;
  Pos := 2;
  EndPos := ASNDecLen(Pos, Buffer);
  if Length(Buffer) < (EndPos + 2) then
    Exit;
  Self.FVersion := StrToIntDef(ASNItem(Pos, Buffer, Svt), 0);
  Self.FCommunity := ASNItem(Pos, Buffer, Svt);
  Self.FPDUType := StrToIntDef(ASNItem(Pos, Buffer, Svt), 0);
  Self.FID := StrToIntDef(ASNItem(Pos, Buffer, Svt), 0);
  Self.FErrorStatus := StrToIntDef(ASNItem(Pos, Buffer, Svt), 0);
  Self.FErrorIndex := StrToIntDef(ASNItem(Pos, Buffer, Svt), 0);
  ASNItem(Pos, Buffer, Svt);
  while Pos < EndPos do
  begin
    ASNItem(Pos, Buffer, Svt);
    Sm := ASNItem(Pos, Buffer, Svt);
    Sv := ASNItem(Pos, Buffer, Svt);
    Self.MIBAdd(sm, sv, Svt);
  end;
  Result := True;
end;

function TSNMPRec.EncodeBuf: string;
var
  data, s: string;
  SNMPMib: TSNMPMib;
  n: Integer;
begin
  data := '';
  for n := 0 to FSNMPMibList.Count - 1 do
  begin
    SNMPMib := FSNMPMibList[n];
    case SNMPMib.ValueType of
      ASN1_INT:
        s := ASNObject(MibToID(SNMPMib.OID), ASN1_OBJID) +
          ASNObject(ASNEncInt(StrToIntDef(SNMPMib.Value, 0)), SNMPMib.ValueType);
      ASN1_COUNTER, ASN1_GAUGE, ASN1_TIMETICKS:
        s := ASNObject(MibToID(SNMPMib.OID), ASN1_OBJID) +
          ASNObject(ASNEncUInt(StrToIntDef(SNMPMib.Value, 0)), SNMPMib.ValueType);
      ASN1_OBJID:
        s := ASNObject(MibToID(SNMPMib.OID), ASN1_OBJID) +
          ASNObject(MibToID(SNMPMib.Value), SNMPMib.ValueType);
      ASN1_IPADDR:
        s := ASNObject(MibToID(SNMPMib.OID), ASN1_OBJID) +
          ASNObject(IPToID(SNMPMib.Value), SNMPMib.ValueType);
      ASN1_NULL:
        s := ASNObject(MibToID(SNMPMib.OID), ASN1_OBJID) +
          ASNObject('', ASN1_NULL);
    else
      s := ASNObject(MibToID(SNMPMib.OID), ASN1_OBJID) +
        ASNObject(SNMPMib.Value, SNMPMib.ValueType);
    end;
    data := data + ASNObject(s, ASN1_SEQ);
  end;
  data := ASNObject(data, ASN1_SEQ);
  data := ASNObject(ASNEncInt(Self.FID), ASN1_INT) +
    ASNObject(ASNEncInt(Self.FErrorStatus), ASN1_INT) +
    ASNObject(ASNEncInt(Self.FErrorIndex), ASN1_INT) +
    data;
  data := ASNObject(ASNEncInt(Self.FVersion), ASN1_INT) +
    ASNObject(Self.FCommunity, ASN1_OCTSTR) +
    ASNObject(data, Self.FPDUType);
  data := ASNObject(data, ASN1_SEQ);
  Result := data;
end;

procedure TSNMPRec.Clear;
var
  i: Integer;
begin
  FVersion := 0;
  FCommunity := '';
  FPDUType := 0;
  FErrorStatus := 0;
  FErrorIndex := 0;
  for i := 0 to FSNMPMibList.Count - 1 do
    TSNMPMib(FSNMPMibList[i]).Free;
  FSNMPMibList.Clear;
end;

procedure TSNMPRec.MIBAdd(const MIB, Value: string; ValueType: Integer);
var
  SNMPMib: TSNMPMib;
begin
  SNMPMib := TSNMPMib.Create;
  SNMPMib.OID := MIB;
  SNMPMib.Value := Value;
  SNMPMib.ValueType := ValueType;
  FSNMPMibList.Add(SNMPMib);
end;

procedure TSNMPRec.MIBDelete(Index: Integer);
begin
  if (Index >= 0) and (Index < FSNMPMibList.Count) then
  begin
    TSNMPMib(FSNMPMibList[Index]).Free;
    FSNMPMibList.Delete(Index);
  end;
end;

function TSNMPRec.MIBGet(const MIB: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FSNMPMibList.Count - 1 do
  begin
    if ((TSNMPMib(FSNMPMibList[i])).OID = MIB) then
    begin
      Result := (TSNMPMib(FSNMPMibList[i])).Value;
      Break;
    end;
  end;
end;

{==============================================================================}

constructor TSNMPSend.Create;
begin
  inherited Create;
  FQuery := TSNMPRec.Create;
  FReply := TSNMPRec.Create;
  FQuery.Clear;
  FReply.Clear;
  FSock := TUDPBlockSocket.Create;
  FSock.CreateSocket;
  FTimeout := 5000;
  FTargetPort := cSnmpProtocol;
  FHostIP := '';
end;

destructor TSNMPSend.Destroy;
begin
  FSock.Free;
  FReply.Free;
  FQuery.Free;
  inherited Destroy;
end;

function TSNMPSend.DoIt: Boolean;
begin
  FReply.Clear;
  FBuffer := FQuery.EncodeBuf;
  FSock.Bind(FIPInterface, cAnyPort);
  FSock.Connect(FTargetHost, FTargetPort);
  FHostIP := cAnyHost;
  FSock.SendString(FBuffer);
  FBuffer := FSock.RecvPacket(FTimeout);
  if FSock.LastError = 0 then
  begin
    FHostIP := FSock.GetRemoteSinIP;
    Result := FReply.DecodeBuf(FBuffer);
  end
  else
    Result := False;
end;

{==============================================================================}

function SNMPGet(const OID, Community, SNMPHost: string; var Value: string): Boolean;
var
  SNMPSend: TSNMPSend;
begin
  SNMPSend := TSNMPSend.Create;
  try
    SNMPSend.Query.Clear;
    SNMPSend.Query.Community := Community;
    SNMPSend.Query.PDUType := PDUGetRequest;
    SNMPSend.Query.MIBAdd(OID, '', ASN1_NULL);
    SNMPSend.TargetHost := SNMPHost;
    Result := SNMPSend.DoIt;
    Value := '';
    if Result then
      Value := SNMPSend.Reply.MIBGet(OID);
  finally
    SNMPSend.Free;
  end;
end;

function SNMPSet(const OID, Community, SNMPHost, Value: string; ValueType: Integer): Boolean;
var
  SNMPSend: TSNMPSend;
begin
  SNMPSend := TSNMPSend.Create;
  try
    SNMPSend.Query.Clear;
    SNMPSend.Query.Community := Community;
    SNMPSend.Query.PDUType := PDUSetRequest;
    SNMPSend.Query.MIBAdd(OID, Value, ValueType);
    SNMPSend.TargetHost := SNMPHost;
    Result := SNMPSend.DoIt = True;
  finally
    SNMPSend.Free;
  end;
end;

function SNMPGetNext(var OID: string; const Community, SNMPHost: string; var Value: string): Boolean;
var
  SNMPSend: TSNMPSend;
begin
  SNMPSend := TSNMPSend.Create;
  try
    SNMPSend.Query.Clear;
    SNMPSend.Query.Community := Community;
    SNMPSend.Query.PDUType := PDUGetNextRequest;
    SNMPSend.Query.MIBAdd(OID, '', ASN1_NULL);
    SNMPSend.TargetHost := SNMPHost;
    Result := SNMPSend.DoIt;
    Value := '';
    if Result then
      if SNMPSend.Reply.SNMPMibList.Count > 0 then
      begin
        OID := TSNMPMib(SNMPSend.Reply.SNMPMibList[0]).OID;
        Value := TSNMPMib(SNMPSend.Reply.SNMPMibList[0]).Value;
      end;
  finally
    SNMPSend.Free;
  end;
end;

function SNMPGetTable(const BaseOID, Community, SNMPHost: string; const Value: TStrings): Boolean;
var
  OID: string;
  s: string;
  col,row: string;
  lastcol: string;
  x, n: integer;
begin
  Value.Clear;
  OID := BaseOID;
  lastcol := '';
  x := 0;
  repeat
    Result := SNMPGetNext(OID, Community, SNMPHost, s);
    if Pos(BaseOID, OID) <> 1 then
        break;
    row := separateright(oid, baseoid + '.');
    col := fetch(row, '.');
    if col = lastcol then
      inc(x)
    else
      x:=0;
    lastcol := col;
    if value.count <= x then
      for n := value.Count - 1 to x do
        value.add('');
    if value[x] <> '' then
      value[x] := value[x] + ',';
    if IsBinaryString(s) then
      s := StrToHex(s);
    value[x] := value[x] + AnsiQuotedStr(s, '"');
  until not result;
end;

function SNMPGetTableElement(const BaseOID, RowID, ColID, Community, SNMPHost: string; var Value: String): Boolean;
var
  s: string;
begin
  s := BaseOID + '.' + ColID + '.' + RowID;
  Result := SnmpGet(s, Community, SNMPHost, Value);
end;

end.


