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
unit codec;

interface

{$IFNDEF USELIB}

uses
  orb_int,orb,Classes,orbtypes,SysUtils,giop_int,addr_int,mcomp_int,
  code_int,comp_int,iiop_int,disp_int,req_int;


type

  TGIOPCodec = class(TORBObject,IGIOPCodec)
  private
    FDecoder : IDecoder;
    FEncoder : IEncoder;
    FVersion : _ushort;
    FSizeOffset : _ulong;
    FHeaderLen : _ulong;
    FCodesetId: CodesetID;
    FWCodesetId: CodesetID;
    FCodesetsSent: boolean;
    FCodesetConverter: ICodesetCoder;
  protected
    function get_encoder(): IEncoder;
    function get_decoder(): IDecoder;
    function put_header(const outc : IGIOPOutContext;mt: TMessageType): _ulong;
    function put_invoke_request(const outc : IGIOPOutContext;mid: MessageID;
      resp:Boolean;const obj: IORBObject;const req: IORBRequest; pr: IPrincipal): Boolean;
    procedure put_contextlist(const outc : IGIOPOutContext; const ctx: ServiceContextList; codesets: Boolean = false);
    function get_contextlist(con: IGIOPInContext; var ctx: ServiceContextList; const codesets: Boolean = false): Boolean;
    procedure put_target(const outc : IGIOPOutContext;const obj : IORBObject);
    procedure put_size(const outc : IGIOPOutContext;start: _ulong);
    function put_args(const outc : IGIOPOutContext;const req: IORBRequest;input: Boolean): Boolean;
    function get_invoke_reply1(const incon: IGIOPInContext; var reqid: _ulong;var status: TReplyStatusType;var ctx: ServiceContextList): Boolean;
    function get_invoke_reply2(const incon: IGIOPInContext; reqid: _ulong;
      status: TReplyStatusType; var obj: IORBObject; req: IORBRequest; var ad: AddressingDisposition; const ctx: ServiceContextList): Boolean;
    function check_header(ctx: IGIOPInContext; var mt: TMessageType; var size: _ulong; var flags: byte ): Boolean;
    function get_header(ctx: IGIOPInContext; var mt: TMessageType; var size: _ulong; var flags: byte ): Boolean;
    function header_len: _ulong;
    function put_bind_request(const outc: IGIOPOutContext;reqid: _ulong; const repoid: RepositoryId;
      const tag: IObjectTag): Boolean;
    function get_bind_reply(const ctx: IGIOPInContext; out status: TLocateStatusType; out obj: IORBObject): Boolean;
    function get_invoke_request(const cin: IGIOPInContext; out reqid: _ulong; out flags: byte; const obj: IORBObject;
      out req: IORBRequest; const pr: IPrincipal): Boolean;
    function get_target(const inc: IGIOPInContext; const obj : IORBObject): Boolean;
    function put_invoke_reply(const outc: IGIOPOutContext; req_id: _ulong; stat: TReplyStatusType;
      obj: IORBObject; req: IORBRequest; ad: AddressingDisposition): Boolean;
    function version(): _ulong;
    function put_invoke_reply_offset(const outc: IGIOPOutContext;const req: IORBRequest): Boolean;
    function put_close_msg(const ctx: IGIOPOutContext): Boolean;
    function put_cancel_request(const ctx: IGIOPOutContext; mid: MessageID): Boolean;
    function put_locate_request(const ctx: IGIOPOutContext; req_id: MessageID; const obj: IORBObject): Boolean;
    function put_locate_reply(const ctx: IGIOPOutContext; req_id: MessageID; stat: TLocateStatusType; const obj: IORBObject; ad: AddressingDisposition): Boolean;
    function get_locate_request(const ctx: IGIOPInContext; out req_id: MessageID; const obj: IORBObject): Boolean;
    function get_locate_reply(const ctx: IGIOPInContext; out req_id: MessageID; out stat: TLocateStatusType; out obj: IORBObject; out ad: AddressingDisposition): Boolean;
    function get_close_msg(const inc: IGIOPInContext): Boolean;
    function put_error_msg(const ctx: IGIOPOutContext): Boolean;
    function get_error_msg(const inc: IGIOPInContext): Boolean;
    function get_bind_request(const ctx: IGIOPInContext; out repoid: RepositoryId; out tag: IObjectTag): Boolean;
    function put_bind_reply(const outc: IGIOPOutContext; reqid: _ulong; stat: TLocateStatusType; const obj: IORBObject): Boolean;
    function get_cancel_request(const ctx: IGIOPInContext; out req_id: MessageID): Boolean;
    function setup_codeset_ids(const obj: IORBObject): boolean;
    function converter(): ICodesetCoder;
  public
    constructor Create(dec: IDecoder;enc: IEncoder; version: _ushort = $0100);
  end;

implementation

uses
  iop,iior_int,codeset_ref,ior,transp,intercept,env_int,env,codeset;

{************************************************************
  TGIOPCodec
************************************************************}
constructor TGIOPCodec.Create(dec: IDecoder;enc: IEncoder; version: _ushort);
var
  outc : IGIOPOutContext;
begin
  FVersion := version;
  if FVersion > $0102 then
    FVersion := $0102;

  FDecoder := dec;
  Fencoder := enc;
  outc := TGIOPOutContext.Create(self,nil);
  FSizeOffset := put_header(outc,Request);
  FHeaderLen := outc.encoder.buffer.WPosition;
end;

function TGIOPCodec.get_bind_request(const ctx: IGIOPInContext; out repoid: RepositoryId; out tag: IObjectTag): Boolean;
var
  dec: IDecoder;
  l: _ulong;
  str: AnsiString;
begin
  result := false;
  dec := ctx.decoder;
  if not dec.get_string(repoid) then exit;
  if not dec.seq_begin(l) then exit;
  if l > 0 then
    begin
      SetLength(str,l);
      if not dec.get_octets(PAnsiChar(str)^,l) then exit;
      tag := TObjectTag.Create(str);
    end
  else
    tag := TObjectTag.Create('');
  if not dec.seq_end then exit;
  result := true;
end;

function TGIOPCodec.put_error_msg(const ctx: IGIOPOutContext): Boolean;
var
  enc: IEncoder;
  l : _ulong;
begin
  enc := ctx.encoder;
  l := put_header(ctx,MessageError);
  put_size(ctx,l);
  result := true;
end;

function TGIOPCodec.get_error_msg(const inc: IGIOPInContext): Boolean;
begin
  FDecoder := inc.decoder;
  result := true;
end;

function TGIOPCodec.get_close_msg(const inc: IGIOPInContext): Boolean;
begin
  FDecoder := inc.decoder;
  result := true;
end;

function TGIOPCodec.get_header(ctx: IGIOPInContext; var mt: TMessageType; var size: _ulong; var flags: byte ): Boolean;
var
  dec: IDecoder;
  magic : array[0..4] of AnsiChar;
  ver : _ushort;
  min,maj,order : byte;

begin
  result := false;
  dec := ctx.decoder;
  magic[4] := AnsiChar(0);
  if dec.get_octets(magic,4) and (StrComp(@magic,AnsiString('GIOP'))= 0) then begin
    if not dec.get_octet(Octet(maj)) then exit;
    if not dec.get_octet(Octet(min)) then exit;
    ver := ((maj shl 8) or min);
    if ver <= $0102 then begin
      FVersion := ver;
      if FVersion = $0100 then begin
        if not dec.get_octet(Octet(order)) then exit;
        if order <> 0 then
          dec.byteorder(orbtypes.LittleEndian)
        else
          dec.byteorder(orbtypes.BigEndian);
        if order <> 0 then flags := 1 else flags := 0;
      end
      else begin
        if not dec.get_octet(Octet(flags)) then exit;
        if (flags and GIOP_BYTEORDER_BIT) <> 0 then
          dec.byteorder(orbtypes.LittleEndian)
        else
          dec.byteorder(orbtypes.BigEndian);
      end;
      if not dec.get_octet(Octet(order)) then exit;
      mt := TMessageType(order);
      result := dec.get_ulong(size);
    end;
  end;
end;

function TGIOPCodec.check_header(ctx: IGIOPInContext; var mt: TMessageType; var size: _ulong; var flags: byte ): Boolean;
var
  pos : _ulong;
begin
  pos := ctx.decoder._Buffer.RPosition;
  result := get_header(ctx,mt,size,flags);
  ctx.decoder._Buffer.RseekFromBegin(pos);
end;

function TGIOPCodec.get_decoder(): IDecoder;
begin
  result := FDecoder;
end;

function TGIOPCodec.get_target(const inc: IGIOPInContext; const obj : IORBObject): Boolean;
var
  dec: IDecoder;
  objkey: PByteArray;
  keyval : AnsiString;
  keylen, index: _ulong;
  kind: AddressingDisposition;
  prof: IIORProfile;
begin
  result := false;
  dec := inc.decoder;
  if FVersion < $0102 then begin
    obj._IOR.add_profile(TGIOPSimpleProfile.Create('',0) as IIORProfile);
    if not dec.seq_begin(keylen) then exit;
    objkey := PByteArray(dec._Buffer.Data);
    if not dec._Buffer.RseekFromCurrent(keylen) then exit;
    if not dec.seq_end then exit;
    SetLength(keyval,keylen);
    move(objkey^,PAnsiChar(keyval)^,keylen);
    obj._IOR.set_objectkey(keyval,keylen);
  end
  else begin
    if not dec.get_short(kind) then Exit;
    case kind of
      GIOP_KEYADDR: begin
        obj._IOR.add_profile(TGIOPSimpleProfile.Create('',0) as IIORProfile);
        if not dec.seq_begin(keylen) then Exit;
        objkey := PByteArray(dec._buffer.data);
        if not dec._Buffer.RseekFromCurrent(keylen) then exit;
        if not dec.seq_end then exit;
        SetLength(keyval,keylen);
        move(objkey^,PAnsiChar(keyval)^,keylen);
        obj._IOR.set_objectkey(keyval,keylen);
      end;
      GIOP_PROFILEADDR: begin
        prof := TIORProfile.decode(dec);
        if prof = nil then Exit;
        obj._ior.add_profile(prof);
      end;
      GIOP_REFERENCEADDR: begin
        if not dec.get_ulong(index) then Exit;
        if not obj._ior.decode(dec) then Exit;
      end;
    end;
  end;
  result := true;
end;

function TGIOPCodec.get_invoke_request(const cin: IGIOPInContext; out reqid: _ulong; out flags: byte; const obj: IORBObject;
      out req: IORBRequest; const pr: IPrincipal): Boolean;
var
  dec: IDecoder;
  tmp : array[0..2] of byte;
  opname: AnsiString;
  env: IEnvironment;
  ctx: ServiceContextList;
begin
  result := false;
  dec := cin.decoder;
  //ServerInterceptor
  if not TServerInterceptor._idle() then begin
    env := TEnvironment.Create(pr);
    if not TServerInterceptor._exec_input_message(dec._buffer(), env) then begin
      result := false;
      Exit;
    end;
  end;
  if FVersion < $0102 then begin
    if not get_contextlist(cin, ctx, true) then exit;
    if not dec.get_ulong(reqid) then exit;
    if not dec.get_octet(Octet(flags)) then exit;
    if (FVersion <> $0100) and not dec.get_octets(tmp,3) then exit;
    if not get_target(cin,obj) then exit;
    if not dec.get_string(opname) then exit;
    if not dec.get_principal(pr) then exit;
  end
  else begin
    if not dec.get_ulong(reqid) then exit;
    if not dec.get_octet(Octet(flags)) then exit;
    {if (flags and $02) <> 0 then
      flags := 1
    else
      flags := 0;}
    if (FVersion <> $0100) and not dec.get_octets(tmp,3) then exit;
    if not get_target(cin,obj) then exit;
    if not dec.get_string(opname) then exit;
    if not get_contextlist(cin, ctx, true) then exit;
  end;
  if FVersion >= $0102 then
    // if there are no arguments aligning might fail ...
    dec._buffer.setRAlign(dec.max_alignment());
  req := TGIOPRequest.Create(opname,dec,self);
  req.set_context(@ctx);
  result := true;
end;

function TGIOPCodec.get_invoke_reply1(const incon: IGIOPInContext; var reqid: _ulong;
  var status: TReplyStatusType; var ctx: ServiceContextList): Boolean;
var
  dec : IDecoder;
  enum : _ulong;
  env: IEnvironment;
begin
  result := false;
  dec := incon.decoder;
  //ClientInterceptor
  if not TClientInterceptor._idle() then begin
    env := TEnvironment.Create();
    if not TClientInterceptor._exec_input_message(dec._buffer(), env) then begin
      result := false;
      Exit;
    end;
  end;
  if FVersion < $0102 then
    begin
      if not get_contextlist(incon, ctx) then exit;
      if not dec.get_ulong(reqid) then exit;
      if not dec.get_ulong(enum) then exit;
      status := TReplyStatusType(enum);
    end
  else
    begin
      if not dec.get_ulong(reqid) then exit;
      if not dec.get_ulong(enum) then exit;
      status := TReplyStatusType(enum);
      if not get_contextlist(incon, ctx) then exit;
    end;

  case status of
    NO_EXCEPTION, USER_EXCEPTION, SYSTEM_EXCEPTION, LOCATION_FORWARD: ;
    LOCATION_FORWARD_PERM:
      if FVersion < $0102 then begin
        { TODO -oOVS -cLogger : Warning }
        Exit;
      end;
    NEEDS_ADDRESSING_MODE:
      if FVersion < $0102 then begin
        { TODO -oOVS -cLogger : Warning }
        Exit;
      end;
    else begin
      { TODO -oOVS -cLogger : Warning }
      Exit;
    end;
  end;

  if FVersion >= $0102 then  // if there are no arguments aligning might fail ...
    dec._buffer().setRAlign(dec.max_alignment());
  result := true;
end;

function TGIOPCodec.get_invoke_reply2(const incon: IGIOPInContext; reqid: _ulong;
  status: TReplyStatusType; var obj: IORBObject; req: IORBRequest; var ad: AddressingDisposition; const ctx: ServiceContextList): Boolean;
var
  dec : IDecoder;
  ior: IIOR;
begin
  result := false;
  dec := incon.decoder;
  obj := nil;
  case status of
    orbtypes.NO_EXCEPTION:
      if req <> nil then begin
        // may be NULL for a bind()
        req.set_context(@ctx);
        result := req.set_out_args(dec, false);
      end;
    orbtypes.USER_EXCEPTION,orbtypes.SYSTEM_EXCEPTION:
      if req <> nil then begin
        // may be NULL for a bind()
        req.set_context(@ctx);
        result := req.set_out_args(dec, true);
      end;
    orbtypes.LOCATION_FORWARD, orbtypes.LOCATION_FORWARD_PERM: begin
      ior := TIOR.Create();
      if not ior.decode(dec) then Exit;
      obj := ORB_Instance.ior_to_object(ior);
      result := true;
    end;
    orbtypes.NEEDS_ADDRESSING_MODE: begin
      if not dec.get_short(ad) then Exit;
      result := true;
    end;
    else
      result := false;
  end;
end;

function TGIOPCodec.get_bind_reply(const ctx: IGIOPInContext; out status: TLocateStatusType; out obj: IORBObject): Boolean;
var
  dec: IDecoder;
  ior: IIOR;
  enum: _ulong;
begin
  result := false;
  dec := ctx.decoder;
  obj := nil;
  if not dec.get_ulong(enum) then exit;
  status := TLocateStatusType(enum);
  ior := TIOR.Create;
  if not ior.decode(dec) then exit;

  case status of
    UNKNOWN_OBJECT,
    OBJECT_HERE,
    OBJECT_FORWARD,
    OBJECT_FORWARD_PERM,
    LOC_NEEDS_ADDRESSING_MODE: ;
    LOC_SYSTEM_EXCEPTION: Exit;
    else
      Exit;
  end;
  
  obj := ORB_Instance.ior_to_object(ior);
  result := true;
end;

function TGIOPCodec.header_len: _ulong;
begin
  result := FHeaderLen
end;

function TGIOPCodec.put_header(const outc : IGIOPOutContext;mt: TMessageType): _ulong;
var
  enc : IEncoder;
begin
  enc := outc.encoder;
  enc.put_octets(AnsiString('GIOP'),4);
  enc.put_octet(Octet(FVersion shr 8));
  enc.put_octet(Octet(FVersion xor $FF00));
  enc.put_octet(Octet(enc.byteorder = LittleEndian));
  enc.put_Octet(Octet(Ord(mt)));
  result := enc.buffer.WPosition;
  enc.put_ulong(0);
end;

function TGIOPCodec.get_encoder(): IEncoder;
begin
  result := FEncoder;
end;

procedure TGIOPCodec.put_size(const outc : IGIOPOutContext;start: _ulong);
var
  enc : IEncoder;
  endpos : _ulong;
begin
  enc := outc.encoder;
  endpos := enc.buffer.WPosition;
  enc.buffer.WseekFromBegin(start);
  enc.put_ulong(endpos - enc.buffer.getRAlignBase - FHeaderLen);
  enc.buffer.WseekFromBegin(endpos);
end;

function TGIOPCodec.put_bind_request(const outc: IGIOPOutContext;reqid: _ulong; const repoid: RepositoryId;
      const tag: IObjectTag): Boolean;
var
  enc : IEncoder;
  key : _ulong;
  val : longint;
  env: IEnvironment;
begin
  val := 0;
  enc := outc.encoder;
  key := put_header(outc,Request);
  if FVersion < $0102 then
    begin
      put_contextlist(outc,nil,false);
      enc.put_ulong(reqid);
      enc.put_boolean(true); // response flags
      if FVersion <> $0100 then
        enc.put_octets(val,3);
      enc.put_ulong(0);//object key
      enc.put_string('_bind');
      enc.put_principal(TPrincipal.Create() as IPrincipal);
      enc.seq_end;
    end
  else
    begin
      enc.put_ulong(reqid);
      enc.put_octet($3);
      enc.put_octets(val,3);
      enc.put_short(GIOP_KEYADDR);
      enc.put_ulong(0);//object key
      enc.put_string('_bind');
      put_contextlist(outc,nil,false);
    end;
  if FVersion >= $0102 then
    enc.buffer.setWAlign(enc.max_alignment());
  enc.put_string(repoid);
  enc.seq_begin(tag.get_length);
  if tag.get_length > 0 then
    enc.put_octets(PAnsiChar(tag.get_bytes)^,tag.get_length);
  enc.seq_end;
  //ClientInterceptor
  if not TClientInterceptor._idle() then begin
    env := TEnvironment.Create();
    enc.buffer().RseekFromCurrent(header_len());
    if not TClientInterceptor._exec_output_message(enc.buffer(), env) then begin
      result := false;
      Exit;
    end;
    enc.buffer().RseekFromCurrent(-header_len());
  end;
  put_size(outc,key);
  result := true;
end;

function TGIOPCodec.version(): _ulong;
begin
  result := FVersion;
end;

function TGIOPCodec.put_invoke_request(const outc : IGIOPOutContext;mid: MessageID;
      resp: Boolean;const obj: IORBObject;const req: IORBRequest; pr: IPrincipal): Boolean;
var
  enc : IEncoder;
  key : _ulong;
  val : longint;
  //bo : TByteOrder;
  env: IEnvironment;
  sentCodesets: boolean;
begin
  val := 0;
  enc := outc.encoder;
  //bo := enc.byteorder;
  if req.req_type = 'giop' then
    enc.byteorder((req as IGIOPRequest).input_byteorder);
  key := put_header(outc,Request);

  if not FCodesetsSent and (FCodesetConverter <> nil) and (FVersion >= $0101) then begin
    sentCodesets := true;
    FCodesetsSent := true;
  end
  else
    sentCodesets := false;

  if FVersion < $0102 then
    begin
      put_contextlist(outc,req.context()^,sentCodesets);
      enc.put_ulong(mid);
      enc.put_boolean(resp); // response flags
      if FVersion <> $0100 then
        enc.put_octets(val,3);
      put_target(outc,obj);
      enc.put_string(req.op_name);
      if pr <> nil then
        enc.put_principal(pr)
      else
        enc.put_principal(TPrincipal.Create() as IPrincipal);
    end
  else
    begin
      enc.put_ulong(mid);
      // response flags
      if (integer(resp) and $01) <> 0 then
        enc.put_octet(Octet($03))
      else
        enc.put_octet(Octet($00));
      enc.put_octets(val,3);
      put_target(outc,obj);
      enc.put_string(req.op_name);
      put_contextlist(outc,req.context()^,sentCodesets);
    end;
  if FVersion >= $0102 then
    enc.buffer.setWAlign(enc.max_alignment());
  result := put_args(outc,req,true);
  //ClientInterceptor
  if not TClientInterceptor._idle() then begin
    env := TEnvironment.Create();
    enc.buffer().RseekFromCurrent(header_len());
    if not TClientInterceptor._exec_output_message(enc.buffer(), env) then begin
      result := false;
      Exit;
    end;
    enc.buffer().RseekFromCurrent(-header_len());
  end;
  put_size(outc,key);
end;

{**
  Puts argument into request arg`s list
**}
function TGIOPCodec.put_args(const outc : IGIOPOutContext;const req: IORBRequest;input: Boolean): Boolean;
var
  enc : IEncoder;
  is_except: Boolean;
begin
  enc := outc.encoder;
  if input then
    result := req.get_in_args(enc)
  else
    result := req.get_out_args(enc,is_except);
end;

procedure TGIOPCodec.put_target(const outc : IGIOPOutContext;const obj : IORBObject);
var
  enc : IEncoder;
  prof : IIORProfile;
  objkey : AnsiString;
  ok_len : _ulong;
  activeIndex: _ulong;
  kind: AddressingDisposition;
begin
  enc := outc.encoder;
  prof := obj.fwd_ior.active_profile(activeIndex);
  objkey := prof.objkey(ok_len);
  if FVersion < $0102 then
    begin
      enc.seq_begin(ok_len);
      enc.put_octets(PAnsiChar(objkey)^,ok_len);
      enc.seq_end;
    end
  else
    begin
      kind := obj.fwd_ior.addressing_disposition();
      case kind of
        GIOP_KEYADDR: begin
          enc.put_short(kind);
          enc.seq_begin(ok_len);
          enc.put_octets(PAnsiChar(objkey)^,ok_len);
          enc.seq_end;
        end;
        GIOP_PROFILEADDR: begin
          enc.put_short(kind);
          prof.encode(enc);
        end;
        GIOP_REFERENCEADDR: begin
          enc.put_short(kind);
          enc.put_ulong(activeIndex);
          obj.fwd_ior.encode(enc);
        end;
        else
          Assert(false);
      end;
    end;
end;

{**
  Stores context list in request
**}
procedure TGIOPCodec.put_contextlist(const outc : IGIOPOutContext; const ctx: ServiceContextList;
  codesets : Boolean);
var
  enc : IEncoder;
  //cs,wcs : CodesetID;
  state : TEncapsState;
  i : integer;
begin
  if TCodeSet.disabled then
    codesets := false;
  enc := outc.encoder;
  enc.seq_begin(Length(ctx) + long(codesets));
  for i := 0 to Pred(Length(ctx)) do begin
    enc.put_ulong(ctx[i].context_id);
    // no encapsulation done here, the user has to supply
    // an encapsulated sequence in the interceptor ...
    enc.seq_begin(Length(ctx[i].context_data));
    if Length(ctx[i].context_data) > 0 then
      enc.put_octets(Pointer(ctx[i].context_data)^, Length(ctx[i].context_data));
    enc.seq_end();
  end;
  if codesets then
    begin
      enc.put_ulong(IOP_CodeSets);
      enc.encaps_begin(state);
      enc.put_ulong({TCodeset.special_cs(NativeCS).id}FCodesetId);
      enc.put_ulong({TCodeset.special_cs(NativeWCS).id}FWCodesetId);
      enc.encaps_end(state);
    end;
  enc.seq_end;
end;

function TGIOPCodec.get_contextlist(con: IGIOPInContext; var ctx: ServiceContextList;
  const codesets: Boolean): Boolean;
var
  dec: IDecoder;
  len,size,context_id: _ulong;
  i, idx : integer;
  state: TEncapsState;
  csid,wcsid : CodesetID;
  gotCodesetContext: boolean;
begin
  result := false; csid := 0; wcsid := 0; gotCodesetContext := false;
  dec := con.decoder;
  if not dec.seq_begin(len) then exit;
  if len > 0 then
    begin
      idx := 0;
      for i := 0 to len - 1 do
        begin
          if not dec.get_ulong(context_id) then exit;
          if context_id = IOP_CodeSets then
            begin
              if not dec.encaps_begin(state, size) then Exit;
              // code set service ...
              if not dec.get_ulong(csid) then exit;
              if not dec.get_ulong(wcsid) then exit;
              if not dec.encaps_end(state) then Exit;
              gotCodesetContext := true;
            end
          else
            begin
              // other service ...
              if not dec.seq_begin(size) then Exit;
              SetLength(ctx, idx + 1);
              ctx[idx].context_id := context_id;
              if size > 0 then begin
                SetLength(ctx[idx].context_data, size);
                dec.get_octets(Pointer(ctx[idx].context_data)^, size);
              end;
              idx := Succ(idx);
              if not dec.seq_end then Exit;
            end;
        end;
    end;
  if not dec.seq_end then exit;
  // set up code sets ...
  if codesets and ((csid <> 0) or (wcsid <> 0)) then begin
    if gotCodesetContext then begin
      (*
       * We got a code set context
       *)
      if FCodesetConverter = nil then begin
        if TCodeset.disabled then begin
        end
        else if FVersion = $0100 then begin
          FCodesetConverter := TGIOP_1_0_CodesetCoder.Create;
          con.set_converter(FCodesetConverter);
          FDecoder.set_converter(FCodesetConverter);
          FEncoder.set_converter(FCodesetConverter);
        end
        else begin
          if FVersion = $0101 then
            FCodesetConverter := TGIOP_1_1_CodesetCoder.Create(csid)
          else if FVersion >= $102 then
            FCodesetConverter := TGIOP_1_2_CodesetCoder.Create(csid, wcsid);

          if not FCodesetConverter.isok then begin
            result := false;
            Exit;
          end;
          
          FCodesetId := csid;
          FWCodesetId := wcsid;
          con.set_converter(FCodesetConverter);
          FDecoder.set_converter(FCodesetConverter);
          FEncoder.set_converter(FCodesetConverter);
        end;
      end;
    end
    else begin
      (*
       * We should setup codesets, but didn't receive a code set context
       * This is OK if codesets are already setup or if this is a GIOP
       * 1.0 conn
       *)
      if FCodesetConverter = nil then begin
        if FVersion = $0100 then begin
          if not TCodeset.disabled then begin
            FCodesetConverter := TGIOP_1_0_CodesetCoder.Create;
            con.set_converter(FCodesetConverter);
            FDecoder.set_converter(FCodesetConverter);
            FEncoder.set_converter(FCodesetConverter);
          end;
        end
        else begin
          { TODO -oOVS -cLogger : Warning }
          if not TCodeset.disabled then begin
            FCodesetConverter := TGIOP_1_0_CodesetCoder.Create;
            con.set_converter(FCodesetConverter);
            FDecoder.set_converter(FCodesetConverter);
            FEncoder.set_converter(FCodesetConverter);
          end;
        end;
      end;
    end;
  end;
  result := true;
end;

function TGIOPCodec.put_bind_reply(const outc: IGIOPOutContext; reqid: _ulong; stat: TLocateStatusType; const obj: IORBObject): Boolean;
var
  enc: IEncoder;
  key: _ulong;
  env: IEnvironment;
  ii : IIOR;
begin
  enc := outc.encoder;
  key := put_header(outc,Reply);
  if FVersion < $0102 then
    begin
      put_contextlist(outc,nil,false);
      enc.put_ulong(reqid);
      enc.put_ulong(Ord(NO_EXCEPTION));
    end
  else
    begin
      enc.put_ulong(reqid);
      enc.put_ulong(Ord(NO_EXCEPTION));
      put_contextlist(outc,nil,false);
    end;
  if FVersion >= $0102 then
    enc.buffer.setWAlign(enc.max_alignment());
  enc.put_ulong(ord(stat));
  if stat = OBJECT_HERE then
    obj._ior.encode(enc)
  else
    begin
      ii := TIOR.Create() as  IIOR;
      ii.encode(enc);
    end;
  //ServerInterceptor
  if not TServerInterceptor._idle() then begin
    env := TEnvironment.Create();
    enc.buffer().RseekFromCurrent(header_len());
    if not TServerInterceptor._exec_output_message(enc.buffer(), env) then begin
      result := false;
      Exit;
    end;
    enc.buffer().RseekFromCurrent(-header_len());
  end;
  put_size(outc,key);
  result := true;
end;

function TGIOPCodec.put_invoke_reply(const outc: IGIOPOutContext; req_id: _ulong; stat: TReplyStatusType;
      obj: IORBObject; req: IORBRequest; ad: AddressingDisposition): Boolean;
var
  enc: IEncoder;
  key : _ulong;
  env: IEnvironment;
begin
  result := false;
  enc := outc.encoder;
  key := put_header(outc,orbtypes.Reply);
  if FVersion < $0102 then
    begin
      put_contextlist(outc,req.context()^,false);
      enc.put_ulong(req_id);
      enc.put_ulong(Ord(stat));
    end
  else
    begin
      enc.put_ulong(req_id);
      enc.put_ulong(Ord(stat));
      put_contextlist(outc,req.context()^,false);
    end;
  case stat of
    NO_EXCEPTION, USER_EXCEPTION, SYSTEM_EXCEPTION: begin
        if FVersion >= $0102 then
          enc.buffer.setWAlign(enc.max_alignment());
        if not put_args(outc,req,false) then
          exit;
      end;
    LOCATION_FORWARD, LOCATION_FORWARD_PERM: obj._ior.encode(enc);
    NEEDS_ADDRESSING_MODE: enc.put_short(ad);
    else
      assert(false);
  end;
  //ServerInterceptor
  if not TServerInterceptor._idle() then begin
    env := TEnvironment.Create();
    enc.buffer().RseekFromCurrent(header_len());
    if not TServerInterceptor._exec_output_message(enc.buffer(), env) then begin
      result := false;
      Exit;
    end;
    enc.buffer().RseekFromCurrent(-header_len());
  end;
  put_size(outc,key);
  result := true;
end;

function TGIOPCodec.put_invoke_reply_offset(const outc: IGIOPOutContext;const req: IORBRequest): Boolean;
var
  enc: IEncoder;
begin
  result := false;
  enc := outc.encoder;
  enc.buffer.WseekFromCurrent(FHeaderLen); //?????
  put_contextlist(outc,req.context()^,false);
  enc.put_ulong(0);
  enc.put_ulong(0);
end;

function TGIOPCodec.put_close_msg(const ctx: IGIOPOutContext): Boolean;
var
  l : _ulong;
begin
  l := put_header(ctx,CloseConnection);
  put_size(ctx,l);
  result := true;
end;

function TGIOPCodec.put_cancel_request(const ctx: IGIOPOutContext; mid: MessageID): Boolean;
var
  enc: IEncoder;
  l : _ulong;
begin
  enc := ctx.encoder;
  l := put_header(ctx,CancelRequest);
  enc.put_ulong(mid);
  put_size (ctx,l);
  result := true;
end;

function TGIOPCodec.setup_codeset_ids(const obj: IORBObject): boolean;
var
  csc : ICodesetComponent;
  prof : IIORProfile;
  comps : IMultiComponent;
  comp : IORBComponent;
  prof_idx: _ulong;
begin
  (*
   * code set support disabled?
   *)
  if TCodeset.disabled() then begin
    result := true;
    Exit;
  end; 

  (*
   * No code set support in GIOP 1.0
   *)
  if FVersion = $0100 then begin
    FCodesetId := 0;
    FWCodesetId := 0;
    FCodesetConverter := TGIOP_1_0_CodesetCoder.Create();
    result := true;
    Exit;
  end;

  (*
   * Try to find Code Sets component in active profile first
   *)
  prof_idx := 0;
  prof := obj.fwd_ior.active_profile(prof_idx);
  if (prof <> nil) then begin
    comps := IMultiComponent(prof.get_components());
    if (comps <> nil) then begin
      comp := comps.get_component(TAG_CODE_SETS);
      if comp <> nil then
        csc := ICodesetComponent(comp);
    end;
  end;

  (*
   * Next, try to find it in a global MultipleComponents profile
   *)
  prof := obj.fwd_ior.get_profile(TAG_MULTIPLE_COMPONENTS, true);
  if (prof <> nil) then begin
    comps := IMultiComponent(prof.get_components());
    if (comps <> nil) then begin
      comp := comps.get_component(TAG_CODE_SETS);
      if comp <> nil then
        csc := ICodesetComponent(comp);
    end;
  end;

  if csc <> nil then
    begin
      FCodesetId := csc.selected_cs;
      FWCodesetId := csc.selected_wcs;
    end
  else
    begin
      // no code set info, use defaults ...
      FCodesetId := TCodeset.special_cs(DefaultCS).id;
      FWCodesetId := TCodeset.special_cs(DefaultWCS).id;
    end;
  if FVersion = $0100 then
    FCodesetConverter := TGIOP_1_0_CodesetCoder.Create()
  else if FVersion = $0101 then
    FCodesetConverter := TGIOP_1_1_CodesetCoder.Create(FCodesetId)
  else if FVersion >= $0102 then
    FCodesetConverter := TGIOP_1_2_CodesetCoder.Create(FCodesetId, FWCodesetId);
  FDecoder.set_converter(FCodesetConverter);
  FEncoder.set_converter(FCodesetConverter);
  result := FCodesetConverter.isok();
end;

function TGIOPCodec.converter: ICodesetCoder;
begin
  result := FCodesetConverter;
end;

function TGIOPCodec.put_locate_request(const ctx: IGIOPOutContext; req_id: MessageID; const obj: IORBObject): Boolean;
var
  enc: IEncoder;
  key: _ulong;
begin
  enc := ctx.encoder();

  key := put_header(ctx, LocateRequest);

  enc.put_ulong(req_id);
  put_target(ctx, obj);

  put_size(ctx, key);
  result := true;
end;

function TGIOPCodec.put_locate_reply(const ctx: IGIOPOutContext; req_id: MessageID; stat: TLocateStatusType; const obj: IORBObject; ad: AddressingDisposition): Boolean;
var
  enc: IEncoder;
  key: _ulong;
begin
  enc := ctx.encoder();

  key := put_header(ctx, LocateReply);

  enc.put_ulong(req_id);
  enc.put_ulong(Ord(stat));

  case stat of
    OBJECT_FORWARD, OBJECT_FORWARD_PERM: obj._ior.encode(enc);
    LOC_NEEDS_ADDRESSING_MODE: enc.put_short(ad);
  end;
  put_size(ctx, key);
  result := true;
end;

function TGIOPCodec.get_locate_reply(const ctx: IGIOPInContext;
  out req_id: MessageID; out stat: TLocateStatusType; out obj: IORBObject;
  out ad: AddressingDisposition): Boolean;
var
  dec: IDecoder;
  k: _ulong;
  ior: IIOR;
begin
  dec := ctx.decoder();
  result := false;

  if not dec.get_ulong(req_id) then
    Exit;
  if not dec.get_ulong(k) then
    Exit;
  stat := TLocateStatusType(k);

  case stat of
    UNKNOWN_OBJECT, OBJECT_HERE: obj := nil;
    OBJECT_FORWARD, OBJECT_FORWARD_PERM: begin
      ior := TIOR.Create;
      if not ior.decode(dec) then
        Exit;
      obj := ORB_instance.ior_to_object(ior);
    end;
    LOC_NEEDS_ADDRESSING_MODE: begin
      if not dec.get_short(ad) then
        Exit;
      obj := nil;
    end;
  else
    Exit;
  end;
  result := true;
end;

function TGIOPCodec.get_locate_request(const ctx: IGIOPInContext;
  out req_id: MessageID; const obj: IORBObject): Boolean;
var
  dec: IDecoder;
begin
  dec := ctx.decoder();
  result := false;

  if not dec.get_ulong(req_id) then
    Exit;
  if not get_target(ctx, obj) then
    Exit;
  result := true;
end;

function TGIOPCodec.get_cancel_request(const ctx: IGIOPInContext; out req_id: MessageID): Boolean;
var
  dec: IDecoder;
begin
  dec := ctx.decoder();
  result := false;

  if not dec.get_ulong(req_id) then
    Exit;

  result := true;
end;

{$ELSE}
implementation
{$ENDIF}
end.
