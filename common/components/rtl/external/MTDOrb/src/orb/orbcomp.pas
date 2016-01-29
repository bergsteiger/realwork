// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit orbcomp;

interface

uses
  Classes,decoder,orbtypes,orb,orb_int,comp_int,code_int,mcomp_int,
  SysUtils;

{$IFNDEF USELIB}

type

  TORBComponentDecoder = class;

  TORBComponent = class(TORBObject,IORBComponent)
  private
    FID : ComponentID;
  protected
    procedure encode(const enc: IEncoder); virtual; abstract;
    function _id(): ComponentID;
    procedure set_id(id:ComponentID);
    procedure print(s: TStream); virtual; abstract;
  public
    class function decode(dec: IDecoder): IORBComponent;
    class function decode_body(dec: IDecoder;cid : _ulong;len: _ulong): IORBComponent;
    class procedure register_decoder(tcd : Pointer);
    class procedure unregister_decoder(tcd : Pointer);
  end;

  TMultiComponent = class(TORBComponent,IMultiComponent,IUnknown)
  private
    FComponents: IInterfaceList;
  protected
    function decode(const dec: IDecoder): Boolean;
    procedure encode(const enc: IEncoder); override;
    procedure add_component(const comp : IORBComponent);
    function get_component(id: ComponentID): IORBComponent;
    procedure Clear();
    function size: _ulong;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure print(s: TStream); override;
  end;

  TORBComponentDecoder = class(TORBObject,IORBComponentDecoder)
  private
    FId : ComponentID;
  public
    constructor Create(id: ComponentID);
    destructor Destroy(); override;
    function has_id(id: ComponentID): Boolean;
    function decode(dec: IDecoder; cid: ComponentID; len: _ulong): IORBComponent; virtual; abstract;
  end;

  TUnknownComponent = class(TORBComponent,IORBComponent)
  private
    FTag : TOctetSeq;
  protected
    procedure encode(const enc: IEncoder); override;
    procedure print(s: TStream); override;
  public
    constructor Create(id: ComponentID);
    destructor Destroy(); override;
    class function decode_tags(dec: IDecoder; cid: ComponentID; len: _ulong): IORBComponent;
  end;


implementation

uses
  codeset,pstream;

var
  Decoders : TList;
  CodesetComponentDecoder : IORBComponentDecoder;

{**********************************************************************
 TORBComponent
**********************************************************************}
class function TORBComponent.decode(dec: IDecoder): IORBComponent;
var
  pid,len,next_pos : _ulong;
  state : TEncapsState;
  comp : IORBComponent;
begin
  result := nil;
  if not dec.get_ulong(pid) then exit;
  if not dec.encaps_begin(state,len) then exit;
  next_pos := dec._Buffer.RPosition + len;
  comp := TORBComponent.decode_body(dec,pid,len);
  dec._Buffer.RseekFromBegin(next_pos);
  if comp = nil then exit;
  if not dec.encaps_end(state) then
    comp := nil;
  result := comp;
end;

function TORBComponent._id(): ComponentID;
begin
  result := FID;
end;

class function TORBComponent.decode_body(dec: IDecoder;cid : ComponentID;
  len: _ulong): IORBComponent;
var
  i : integer;
  temp : IORBComponentDecoder;
begin
  result := nil;
  temp := nil;
  for i := 0 to Decoders.Count -1 do
    begin
      temp := IORBComponentDecoder(Decoders.Items[i]);
      if temp.has_id(cid) then
        break
      else
        temp := nil;
    end;
  if temp <> nil then
    result := IORBComponentDecoder(Decoders[i]).decode(dec,cid,len)
  else
    result := TUnknownComponent.decode_tags(dec,cid,len);
end;

class procedure TORBComponent.register_decoder(tcd : Pointer);
begin
  Decoders.add(tcd)
end;

class procedure TORBComponent.unregister_decoder(tcd : Pointer);
begin
  Decoders.Remove(tcd);
end;

procedure TORBComponent.set_id(id:ComponentID);
begin
  FID := id;
end;


{**********************************************************************
 TMultiComponent
**********************************************************************}
constructor TMultiComponent.Create();
begin
  FComponents := TInterfaceList.Create;
end;

destructor TMultiComponent.Destroy();
begin
  FComponents := nil;
  inherited;
end;

function TMultiComponent.size: _ulong;
begin
  result := FComponents.Count
end;

procedure TMultiComponent.encode(const enc: IEncoder);
var
  i : integer;
  state: TEncapsState;
begin
  enc.seq_begin(FComponents.Count);
  for i := 0 to Pred(FComponents.Count) do
    begin
      enc.put_ulong(IORBComponent(FComponents[i])._id);
      enc.encaps_begin(state);
      IORBComponent(FComponents[i]).encode(enc);
      enc.encaps_end(state);
    end;
  enc.seq_end;
end;

procedure TMultiComponent.Clear();
begin
  FComponents.Clear;
end;

procedure TMultiComponent.add_component(const comp : IORBComponent);
begin
  FComponents.add(comp);
end;

function TMultiComponent.get_component(id: ComponentID): IORBComponent;
var
  i : integer;
begin
  result := nil;
  for i := 0 to FComponents.Count-1 do
    if IORBComponent(FComponents[i])._id = id then
      begin
        result := IORBComponent(FComponents[i]);
        break;
      end;
end;

function TMultiComponent.decode(const dec: IDecoder): Boolean;
var
  len : _ulong;
  comp : IORBComponent;
begin
  decode := false;
  Clear;
  if not dec.seq_begin(len) then  exit;
  while len > 0 do
    begin
      comp := TORBComponent.decode(dec);
      if comp = nil then exit;
      add_component(comp);
      len := len -  1;
    end;
  decode :=  true;
end;

procedure TMultiComponent.print(s: TStream);
var
  i : integer;
begin
  if FComponents.count > 0 then
    begin
      TPrintStream(s).writestr('Components:');
      for i := 0 to Pred(FComponents.Count) do
        begin
          if i > 0 then
            TPrintStream(s).writestr('           ');
          IORBComponent(FComponents[i]).print(s);
        end;
    end;
end;

{**********************************************************************
 TORBComponentDecoder
**********************************************************************}
constructor TORBComponentDecoder.Create(id : ComponentID);
begin
  FId := id;
  TORBComponent.register_decoder(Pointer(IORBComponentDecoder(self)));
end;

destructor TORBComponentDecoder.Destroy();
begin
  TORBComponent.unregister_decoder(Pointer(IORBComponentDecoder(self)));
end;

function TORBComponentDecoder.has_id(id: ComponentID): Boolean;
begin
  result := FId = id;
end;

//*************************************************************************
// TUnknownComponent
//*************************************************************************
constructor TUnknownComponent.Create(id: ComponentID);
begin
  inherited Create();
  FID := id;
  FTag := nil;
end;

destructor TUnknownComponent.Destroy();
begin
  if FTag <> nil then
    FTag := nil;
  inherited Destroy();
end;

procedure TUnknownComponent.encode(const enc: IEncoder);
begin
  enc.buffer.WseekFromCurrent(-1);
  enc.put_octets(Pointer(FTag)^, Length(FTag));
end;

procedure TUnknownComponent.print(s: TStream);
begin

end;

class function TUnknownComponent.decode_tags(dec: IDecoder; cid: ComponentID; len: _ulong): IORBComponent;
var
  uk : TUnknownComponent;
begin
  result := nil;
  if len > 10000 then exit;
  if dec._Buffer.Length < len then exit;
  uk := TUnknownComponent.Create(cid);
  SetLength(uk.FTag, 1 + len);
  Move(Pointer(Integer(dec._Buffer.data)-1)^,Pointer(uk.FTag)^, 1 + len);
  dec._Buffer.RseekFromCurrent(len);
  result := uk;
end;

initialization
  Decoders := TList.Create();
  CodesetComponentDecoder := TCodesetComponentDecoder.Create(TAG_CODE_SETS);
finalization
  CodesetComponentDecoder := nil;
  FreeAndNil(Decoders);
{$ELSE}
implementation
{$ENDIF}
end.
