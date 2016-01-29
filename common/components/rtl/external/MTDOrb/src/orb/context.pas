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
unit context;

interface

uses
  SysUtils,orbtypes,env_int,Classes,code_int;

type
{$IFDEF VER130}
  {$DEFINE IMPL_STRINGLIST}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE IMPL_STRINGLIST}
{$ENDIF}


{$IFDEF IMPL_STRINGLIST}
  TContextProperties = class(TStringList)
  private
    function GetValueFromIndex(Index: Integer): string;
    procedure SetValueFromIndex(Index: Integer; const Value: string);
  public
    property ValueFromIndex[Index: Integer]: string read GetValueFromIndex write SetValueFromIndex;
  end;
{$ELSE}
  TContextProperties = class(TStringList);
{$ENDIF}


  TContext = class(TInterfacedObject,IContext)
  private
    FName: Identifier;
    FParent : IContext;
    FChildren : IInterfaceList;
    FProperties : TContextProperties;
    function match(const value, pattern: string): Boolean;
  protected
    procedure set_one_value(const prop_name: Identifier; const value: AnsiString);
    procedure set_values(const values : NVList);
    procedure get_values(const start_scope: Identifier; const op_flags: Flags; const prop_name: Identifier; out values: NVList); overload;
    procedure get_values(const start_scope: Identifier; const op_flags: Flags; const ctx_list: IContextList; out values: NVList); overload;
    procedure delete_values(const prop_name: Identifier);
    procedure create_child(const ctx_name: Identifier; out child_ctx: IContext);
    procedure delete(const del_flags: Flags);
    // DORB extension
    procedure encode(const enc: IEncoder; const ctxlist: IContextList);
    function decode(const dec: IDecoder): Boolean;
    function context_name(): Identifier;
    function parent(): IContext;
  public
    constructor Create(const name: Identifier; const parent: IContext = nil); overload;
    constructor Create(const dec: IDecoder); overload;
    destructor Destroy(); override;
  end;

implementation

uses
  throw,orb,exceptions,env,any,tcode;

//*********************************************************************
//  TContext
//*********************************************************************
constructor TContext.Create(const name: Identifier; const parent: IContext);
begin
  inherited Create();
  FName := name;
  FParent := parent;
  FProperties := nil;
end;

constructor TContext.Create(const dec: IDecoder);
begin
  decode(dec);
end;

destructor TContext.Destroy;
begin
  FProperties.Free;
  inherited;
end;

function TContext.context_name: Identifier;
begin
  result := FName
end;

procedure TContext.create_child(const ctx_name: Identifier;
  out child_ctx: IContext);
begin
  if FChildren = nil then FChildren := TInterfaceList.Create;
  child_ctx := TContext.Create(ctx_name,Self);
  FChildren.Add(child_ctx);
end;

function TContext.decode(const dec: IDecoder): Boolean;
var
  len, i: _ulong;
  str, str2: AnsiString;
  a: IAny;
begin
  result := false;
  FProperties.Clear;
  len := 0;
  if not dec.seq_begin(len) or ((len and 1) <> 0) then Exit;
  i := 0;
  while i < len do begin
    if not dec.get_string(str) then Exit;
    a := CreateAny();
    if not a.demarshal(_tc_string, dec) or not a.to_string(str2) then Exit;
    set_one_value(str, str2);
    Inc(i, 2);
  end;
  if not dec.seq_end then Exit;
  result := true;
end;

procedure TContext.delete(const del_flags: Flags);
var
  i : integer;
begin
  if ((del_flags and CTX_DELETE_DESCENDENTS) = 0) and Assigned(FChildren) and (FChildren.Count > 0) then
    dorb_throw(BAD_PARAM.Create());
  FProperties.Clear;
  if ((del_flags and CTX_DELETE_DESCENDENTS) <> 0) and Assigned(FChildren) then
    for i := 0 to Pred(FChildren.Count) do
      (FChildren[i] as IContext).delete(del_flags);
end;

procedure TContext.delete_values(const prop_name: Identifier);
var
  i : integer;
begin
  if (FProperties = nil) or (FProperties.Count = 0) then
    dorb_throw(BAD_CONTEXT.Create());
  if prop_name = '*' then
    FProperties.Clear
  else
    begin
      i := FProperties.IndexOfName(String(prop_name));
      if i = -1 then
        dorb_throw(BAD_CONTEXT.Create());
      FProperties.Delete(i);
    end;
end;

procedure TContext.encode(const enc: IEncoder;
  const ctxlist: IContextList);
var
  o: NVList;
  i: Integer;
begin
  if ctxlist <> nil then
    get_values('', 0, ctxlist, o)
  else
    get_values('', 0, '*', o);
  enc.seq_begin(2 * Length(o));
  for i := 0 to Length(o) - 1 do begin
    enc.put_string(o[i].name);
    o[i].argument.marshal(enc);
  end;
  enc.seq_end;
end;

procedure TContext.get_values(const start_scope: Identifier;
  const op_flags: Flags; const prop_name: Identifier; out values: NVList);
begin
  assert(false,'not implemented');
end;

function TContext.parent: IContext;
begin
  result := FParent
end;

procedure TContext.set_one_value(const prop_name: Identifier;
  const value: AnsiString);
begin
  if (prop_name = '') or (value = '') then
    dorb_throw(BAD_PARAM.Create());
  if FProperties = nil then FProperties := TContextProperties.Create;
  FProperties.Values[String(prop_name)] := String(value);
end;

procedure TContext.set_values(const values: NVList);
var
  i : integer;
  name,value: AnsiString;
begin
  for i := 0 to Pred(Length(values)) do
    begin
      name := values[i].name;
      if not values[i].argument.to_string(value) then
        dorb_throw(BAD_PARAM.Create());
      set_one_value(name,value);
    end;
end;

procedure TContext.get_values(const start_scope: Identifier;
  const op_flags: Flags; const ctx_list: IContextList; out values: NVList);
var
  i, j, k: Integer;
  str: AnsiString;
begin
  if (Length(start_scope) <> 0) and (start_scope <> FName) then begin
    if FParent = nil then
      dorb_throw(BAD_CONTEXT.Create());
    FParent.get_values(start_scope, op_flags, ctx_list, values);
    Exit;
  end;
  if ((op_flags and CTX_RESTRICT_SCOPE) = 0) and (FParent <> nil) then
    FParent.get_values('', op_flags, ctx_list, values);
  for i := 0 to FProperties.Count - 1 do
    for k := 0 to ctx_list.count - 1 do
      if match(FProperties.Names[i], ctx_list.item(k)) then begin
        j := 0;
        while j < Length(values) do begin
          if SameText(FProperties.Names[i], String(values[j].name)) then begin
            if not values[i].argument.to_string(str) then
              dorb_throw(BAD_PARAM.Create());
            FProperties.ValueFromIndex[i] := String(str);
            Break;
          end;
          Inc(j);
        end;
        if j = Length(values) then begin
          SetLength(values, j + 1);
          values[j].name := AnsiString(FProperties.Names[i]);
          values[j].argument.put_string(AnsiString(FProperties.ValueFromIndex[i]));
        end;
      end;
end;

function TContext.match(const value, pattern: string): Boolean;
var
  l: Integer;
begin
  l := Length(pattern);
  if (l > 0) and (pattern[l] = '*') then
    result := StrLIComp(PChar(value), PChar(pattern), l - 1) = 0
  else
    result := SameText(value, pattern);
end;

{ TContextProperties }

{$IFDEF IMPL_STRINGLIST}
function TContextProperties.GetValueFromIndex(Index: Integer): string;
begin
  if Index >= 0 then
    Result := Copy(Get(Index), Length(Names[Index]) + 2, MaxInt) else
    Result := '';
end;

procedure TContextProperties.SetValueFromIndex(Index: Integer;
  const Value: string);
begin
  if Value <> '' then
  begin
    if Index < 0 then Index := Add('');
    Put(Index, Names[Index] + '=' + Value);
  end
  else
    if Index >= 0 then Delete(Index);
end;
{$ENDIF}

end.
