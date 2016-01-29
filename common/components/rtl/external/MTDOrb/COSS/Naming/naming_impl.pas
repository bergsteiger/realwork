{***********************************************************}
{   This file is part of the DORB project.                  }
{                                                           }
{   See the file License, included in this distribution,    }
{   for details about the copyright.                        }
{                                                           }
{   Send comments and/or bug reports to: vic@inec.ru        }
{***********************************************************}
unit naming_impl;

interface

uses  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,orbtypes,
  exceptions,stdstat,std_seq,classes,cosnaming_int, cosnaming, poa_int, osthread;

type
  TLocalBinding = record
    FBindingType : TBindingType;
    FObject: IORBObject;
  end;

  TBindingTable = class
  private
    FFirst,
    FSecond: TList;
    function GetBinding(Index: TNameComponent): TLocalBinding;
    procedure SetBinding(Index: TNameComponent; const Value: TLocalBinding);
    function GetItems(Index: Integer): TLocalBinding;
    procedure SetItems(Index: Integer; const Value: TLocalBinding);
    function GetNames(Index: Integer): TNameComponent;
    procedure SetNames(Index: Integer; const Value: TNameComponent);
  public
    constructor Create;
    destructor Destroy; override;
    function Find(const ANameComponent: TNameComponent): Integer;
    procedure Delete(AIndex: Integer);
    function Count: Integer;
    property Binding[Index: TNameComponent]: TLocalBinding read GetBinding write SetBinding;
    property Items[Index: Integer]: TLocalBinding read GetItems write SetItems;
    property Names[Index: Integer]: TNameComponent read GetNames write SetNames;
  end;

  TNamingContext_impl = class(TNamingContext_serv)
  private
    FTable: TBindingTable;
    FMutex: TMutex;
  protected
    procedure bind(const n: TName; const obj: IORBObject); override;
    procedure rebind(const n: TName; const obj: IORBObject); override;
    procedure bind_context(const n: TName; const nc: INamingContext); override;
    procedure rebind_context(const n: TName; const nc: INamingContext); override;
    function resolve(const n: TName): IORBObject; override;
    procedure unbind(const n: TName); override;
    function new_context: INamingContext; override;
    function bind_new_context(const n: TName): INamingContext; override;
    procedure _destroy; override;
    procedure list(const how_many: _ulong; out bl: TBindingList; out bi: IBindingIterator); override;
  public
    constructor Create(const orb: IORB; const poa: IPOA); overload;
    constructor Create(); overload;
    destructor Destroy; override;
    procedure do_bind(const n: TName; const obj: IORBObject; t: TBindingType; rebind: Boolean);
  end;

  TBindingIterator_impl = class(TBindingIterator_serv)
  private
    FORB: IORB;
    FList: TBindingList;
    FIndex: integer;
    FMutex: TMutex;
  protected
    function next_one(out b: TBinding): boolean; override;
    function next_n(const how_many: _ulong; out bl: TBindingList): boolean; override;
    procedure _destroy; override;
  public
    constructor Create(const orb: IORB; lst: TBindingList);
    destructor Destroy; override;
  end;

  TNamingContextExt_impl = class(TNamingContextExt_serv)
  private
    FNamingContext: TNamingContext_impl;
  protected
    procedure activated_in(const poa : IPOA); override;
    procedure bind(const n: TName; const obj: IORBObject); override;
    procedure rebind(const n: TName; const obj: IORBObject); override;
    procedure bind_context(const n: TName; const nc: INamingContext); override;
    procedure rebind_context(const n: TName; const nc: INamingContext); override;
    function resolve(const n: TName): IORBObject; override;
    procedure unbind(const n: TName); override;
    function new_context: INamingContext; override;
    function bind_new_context(const n: TName): INamingContext; override;
    procedure _destroy; override;
    procedure list(const how_many: _ulong; out bl: TBindingList; out bi: IBindingIterator); override;
    function to_string(const n: TName): TStringName; override;
    function to_name(const sn: TStringName): TName; override;
    function to_url(const addr: TAddress; const sn: TStringName): TURLString; override;
    function resolve_str(const n: TStringName): IORBObject; override;
  public
    constructor Create(const orb: IORB; const poa: IPOA);
    destructor Destroy(); override;
  end;

implementation

uses
  SysUtils,poa,utils,throw;

type
  PLocalBinding = ^TLocalBinding;
  PNameComponent = ^TNameComponent;

var
  Contexts : IInterfaceList;
  _poa : IPOA;
  _orb : IORB;
  root : INamingContext;

//***********************************************************
// NamingContext_impl
//***********************************************************
constructor TNamingContext_impl.Create(const orb: IORB; const poa: IPOA);
begin
  inherited Create();
  _orb := orb;
  _poa := poa;
  root := self;
  FTable := TBindingTable.Create;
  FMutex := TMutex.Create;
end;

constructor TNamingContext_impl.Create();
begin
  inherited;
  FTable := TBindingTable.Create;
  FMutex := TMutex.Create;
end;

destructor TNamingContext_impl.Destroy;
begin
  FTable.Free;
  if root = (self as INamingContext) then
    begin
      root := nil;
      _poa := nil;
      _orb := nil;
    end;
  FMutex.Free;
  inherited Destroy;
end;

procedure TNamingContext_impl.do_bind(const n: TName; const obj: IORBObject; t: TBindingType; rebind: Boolean);
var
  i : integer;
  b : TLocalBinding;
  nc,nextnc : INamingContext;
  name: TName;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  name := nil;
  if Length(n) = 0 then
    raise TInvalidName.Create();
  i := FTable.Find(n[0]);
  if length(n) = 1 then
    begin
      if (i >= 0) and not rebind then
        raise TAlreadyBound.Create()
      else
        begin
          b.FBindingType := t;
          b.FObject := obj;
          FTable.Binding[n[0]] := b;
        end;
    end
  else
    begin
      if i < 0 then   // not found
        raise TNotFound.Create(missing_node,n);
      b := FTable.Items[i];
      if b.FBindingType <> ncontext then // context required
        raise TCannotProceed.Create;
      nc := TNamingContext._narrow(b.FObject);
      assert(nc<>nil);
      name := copy(n,1,Length(n)-1);
      case t of
        nobject : if rebind then
            nc.rebind(name,obj)
          else
            nc.bind(name,obj);
        ncontext : begin
            nextnc := TNamingContext._narrow(obj);
            assert(nextnc <> nil);
            if rebind then
              nc.rebind_context(name,nextnc)
            else
              nc.bind_context(name,nextnc);
          end;
      end;
    end;
end;

procedure TNamingContext_impl.bind(const n: TName; const obj: IORBObject);
begin
  do_bind(n,obj,nobject,false);
end;

procedure TNamingContext_impl.rebind(const n: TName; const obj: IORBObject);
begin
  do_bind(n,obj,nobject,true);
end;

procedure TNamingContext_impl.bind_context(const n: TName; const nc: INamingContext);
begin
  do_bind(n,nc as IORBObject,ncontext,false);
end;

procedure TNamingContext_impl.rebind_context(const n: TName; const nc: INamingContext);
begin
  do_bind(n,nc as IORBObject,ncontext,true);
end;

function TNamingContext_impl.resolve(const n: TName): IORBObject;
var
  i : integer;
  b: TLocalBinding;
  nc : INamingContext;
  name: TName;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  name := nil;
  if Length(n) = 0 then
    raise TInvalidName.Create();
  i := FTable.Find(n[0]);
  if i < 0 then   // not found
    raise TNotFound.Create(missing_node,n);
  b := FTable.Items[i];
  if Length(n) = 1 then
    result := b.FObject
  else
    begin
      if b.FBindingType <> ncontext then // context required
        raise TCannotProceed.Create;
      nc := TNamingContext._narrow(b.FObject);
      assert(nc<>nil);
      name := copy(n,1,Length(n)-1);
      result := nc.resolve(name);
    end;
end;

procedure TNamingContext_impl.unbind(const n: TName);
var
  i : integer;
  b: TLocalBinding;
  nc : INamingContext;
  name: TName;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  name := nil;
  if Length(n) = 0 then
    raise TInvalidName.Create();
  i := FTable.Find(n[0]);
  if i < 0 then   // not found
    raise TNotFound.Create(missing_node,n);
  b := FTable.Items[i];
  if Length(n) = 1 then
    begin
      FTable.Delete(i);
    end
  else
    begin
      if b.FBindingType <> ncontext then // context required
        raise TCannotProceed.Create;
      nc := TNamingContext._narrow(b.FObject);
      assert(nc<>nil);
      name := copy(n,1,Length(n)-1);
      nc.unbind(name);
    end;
end;

function TNamingContext_impl.new_context: INamingContext;
var
  nnc : TNamingContext_impl;
  oid: AnsiString;
  obj : IORBObject;
begin
  nnc := TNamingContext_impl.Create();
  oid := FPOA.activate_object(nnc);
  obj := FPOA.id_to_reference(oid);
  Contexts.Add(nnc);
  result := TNamingContext._narrow(obj);
end;

function TNamingContext_impl.bind_new_context(const n: TName): INamingContext;
begin
  result := new_context;
  bind_context(n,result);
end;

procedure TNamingContext_impl._destroy;
var
  pc: IPOACurrent;
  obj: IORBObject;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  if FTable.Count > 0 then
    raise TNotEmpty.Create();
  obj := _orb.resolve_initial_reference('POACurrent');
  pc := POACurrent_narrow(obj);
  pc.get_POA.deactivate_object(pc.get_object_id);
  Contexts.Remove(self);
end;

procedure TNamingContext_impl.list(const how_many: _ulong; out bl: TBindingList; out bi: IBindingIterator);
var
  num: integer;
  i,j,last: integer;
  rest_items: TBindingList;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  num := how_many;
  if num > FTable.Count then num := FTable.Count;
  setLength(bl,num);
  for i := 0 to Pred(num) do
    begin
      SetLength(bl[i].binding_name, 1);
      bl[i].binding_name[0] := FTable.Names[i];
      bl[i].binding_type := FTable.Items[i].FBindingType;
    end;
  if integer(how_many) < FTable.Count then
    begin
      last := num;
      num := FTable.Count - integer(how_many);
      setLength(rest_items,num);
      for j := last to Pred(num) do
        begin
          SetLength(rest_items[j].binding_name, 1);
          rest_items[j].binding_name[0] := FTable.Names[j];
          rest_items[j].binding_type := FTable.Items[j].FBindingType;
        end;
      bi := TBindingIterator_impl.Create(_orb,rest_items)._this;
    end;
end;

//***********************************************************
// BindingIterator_impl
//***********************************************************
constructor TBindingIterator_impl.Create(const orb: IORB;
  lst: TBindingList);
begin
  inherited Create();
  FIndex := 0;
  FORB := orb;
  FList := lst;
  FMutex := TMutex.Create;
end;

destructor TBindingIterator_impl.Destroy;
begin
  FMutex.Free;
  inherited;
end;

function TBindingIterator_impl.next_one(out b: TBinding): boolean;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  result := false;
  if FIndex < Length(FList) then
    begin
      result := true;
      b := FList[FIndex];
      inc(FIndex);
    end;
end;

function TBindingIterator_impl.next_n(const how_many: _ulong; out bl: TBindingList): boolean;
var
  num : integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  result := false;
  if FIndex < Length(FList) then
    begin
      num := how_many;
      if Length(FList) < (FIndex+num) then num := Length(FList) - FIndex;
      result := true;
      bl := copy(FList,FIndex,num);
      inc(FIndex,num);
    end
  else
    setLength(bl,0);
end;

procedure TBindingIterator_impl._destroy;
var
  pc: IPOACurrent;
begin
  pc := POACurrent_narrow(_orb.resolve_initial_reference('POACurrent'));
  pc.get_POA.deactivate_object(pc.get_object_id);
end;

//*********************************************************************
//  TNamingContextExt_impl
//*********************************************************************
constructor TNamingContextExt_impl.Create(const orb: IORB; const poa: IPOA);
begin
  inherited Create();
  FNamingContext := TNamingContext_impl.Create(orb,poa);
  FNamingContext.FPOA := FPOA;
  FNamingContext._AddRef;
  root := self;
end;

destructor TNamingContextExt_impl.Destroy;
begin
  FNamingContext._Release;
  inherited;
end;

procedure TNamingContextExt_impl._destroy;
var
  pc: IPOACurrent;
  obj: IORBObject;
begin
  if FNamingContext.FTable.Count > 0 then
    raise TNotEmpty.Create();
  obj := _orb.resolve_initial_reference('POACurrent');
  pc := POACurrent_narrow(obj);
  pc.get_POA.deactivate_object(pc.get_object_id);
  Contexts.Remove(self);
end;


procedure TNamingContextExt_impl.bind(const n: TName;
  const obj: IORBObject);
begin
  FNamingContext.bind(n,obj)
end;

procedure TNamingContextExt_impl.bind_context(const n: TName;
  const nc: INamingContext);
begin
  FNamingContext.bind_context(n,nc)
end;

function TNamingContextExt_impl.bind_new_context(
  const n: TName): INamingContext;
begin
  result := FNamingContext.bind_new_context(n)
end;

procedure TNamingContextExt_impl.list(const how_many: _ulong;
  out bl: TBindingList; out bi: IBindingIterator);
begin
  FNamingContext.list(how_many,bl,bi)
end;

function TNamingContextExt_impl.new_context: INamingContext;
begin
  result := FNamingContext.new_context
end;

procedure TNamingContextExt_impl.rebind(const n: TName;
  const obj: IORBObject);
begin
  FNamingContext.rebind(n,obj)
end;

procedure TNamingContextExt_impl.rebind_context(const n: TName;
  const nc: INamingContext);
begin
  FNamingContext.rebind_context(n,nc)
end;

function TNamingContextExt_impl.resolve(const n: TName): IORBObject;
begin
  result := FNamingContext.resolve(n)
end;

function string_to_name(var str: PAnsiChar; const name : PNameComponent): Boolean;
var
  escaped, id_parsed : Boolean;
  current : AnsiString;
begin
  result := false;
  escaped := false;
  id_parsed := false;
  current := '';
  while true do
    begin
      if escaped then
        begin
          if str^ = #0 then exit;
          escaped := false;
          current := current + str^;
          inc(str);
          continue;
        end;
      if str^ = '\' then
        begin
          escaped := true;
          inc(str);
          continue;
        end;
      if (str^ = '.') and id_parsed then exit;
      // boundary reached
      if (str^ = #0) or (str^ = '.') or (str^ = '/') then
        begin
          if id_parsed then
            begin
              name^.kind := current;
              break;
            end
          else
            begin
              name^.id := current;
              if str^ = '.' then
                begin
                  inc(str);
                  current := '';
                  id_parsed := true;
                  continue;
                end
              // end of name
              else if (str^ = #0) or (str^ = '/') then
                begin
                  name^.kind := '';
                  break;
                end;
            end;
        end
      else
        begin
          current := current + str^;
          inc(str);
        end;
    end;
  result := true;
end;

function _escape(const str: AnsiString) : AnsiString;
var
  i : integer;
begin
  result := '';
  for i := 1 to Length(str) do
    begin
      if CharInSet(str[i], ['.','/','\']) then  result := result +  '\';
      result := result + str[i];
    end;
end;

function TNamingContextExt_impl.resolve_str(
  const n: TStringName): IORBObject;
var
  name: TName;
begin
  name := to_name(n);
  result := FNamingContext.resolve(name);
end;

function TNamingContextExt_impl.to_name(const sn: TStringName): TName;
var
  l : integer;
  str: PAnsiChar;
begin
  str := PAnsiChar(sn);
  l := 0;
  while str^ <> #0 do
    begin
      setLength(result,l+1);
      if not string_to_name(str,@result[l]) then
        dorb_throw(TInvalidName.Create);
      if (str^ <> #0) and (str^ <> '/') then
        dorb_throw(TInvalidName.Create);
      if str^ = '/' then
        inc(str);
      inc(l);
    end;
end;

function TNamingContextExt_impl.to_string(
  const n: TName): TStringName;
var
  i : integer;
begin
  result := '';
  for i := 0 to Pred(Length(n)) do
    begin
      if i > 0 then result := result + '/';
      result := result + _escape(n[i].id);
      if (n[i].id = '') or (n[i].kind <> '') then
        result := result + '.' + _escape(n[i].kind);
    end;
end;

function TNamingContextExt_impl.to_url(
  const addr: TAddress;
  const sn: TStringName): TURLString;
begin
  result := 'corbaname:'+addr+'#'+url_encode(sn)
end;

procedure TNamingContextExt_impl.unbind(const n: TName);
begin
  FNamingContext.unbind(n);
end;

procedure TNamingContextExt_impl.activated_in(const poa : IPOA);
begin
  FPOA := poa;
  FNamingContext.FPOA := poa;
end;

{ TBindingTable }

function TBindingTable.Count: Integer;
begin
  Result := FFirst.Count;
end;

constructor TBindingTable.Create;
begin
  FFirst := TList.Create;
  FSecond := TList.Create;
end;

procedure TBindingTable.Delete(AIndex: Integer);
begin
  Finalize(PNameComponent(FFirst[AIndex])^);
  FreeMem(FFirst[AIndex], SizeOf(TNameComponent));
  Finalize(PLocalBinding(FSecond[AIndex])^);
  FreeMem(FSecond[AIndex], SizeOf(TLocalBinding));
  FFirst.Delete(AIndex);
  FSecond.Delete(AIndex);
end;

destructor TBindingTable.Destroy;
var
  i: Integer;
begin
  for i := 0 to FFirst.Count - 1 do begin
    Finalize(PNameComponent(FFirst[i])^);
    FreeMem(FFirst[i], SizeOf(TNameComponent));
    Finalize(PLocalBinding(FSecond[i])^);
    FreeMem(FSecond[i], SizeOf(TLocalBinding));
  end;
  FFirst.Free;
  FSecond.Free;
  inherited;
end;

function TBindingTable.Find(const ANameComponent: TNameComponent): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FFirst.Count - 1 do begin
    with PNameComponent(FFirst[i])^ do
      if (id = ANameComponent.id) and (kind = ANameComponent.kind) then begin
        Result := i;
        Break;
      end;
  end;
end;

function TBindingTable.GetBinding(Index: TNameComponent): TLocalBinding;
var
  idx: Integer;
begin
  idx := Find(Index);
  if idx <> -1 then
    Result := PLocalBinding(FSecond[idx])^
  else begin
    FFirst.Add(AllocMem(SizeOf(TNameComponent)));
    idx := FSecond.Add(AllocMem(SizeOf(TLocalBinding)));
    Result := PLocalBinding(FSecond[idx])^;
  end;
end;

function TBindingTable.GetItems(Index: Integer): TLocalBinding;
begin
  Result := PLocalBinding(FSecond[Index])^;
end;

function TBindingTable.GetNames(Index: Integer): TNameComponent;
begin
  Result := PNameComponent(FFirst[Index])^;
end;

procedure TBindingTable.SetBinding(Index: TNameComponent;
  const Value: TLocalBinding);
var
  idx: Integer;
begin
  idx := Find(Index);
  if idx <> -1 then
    PLocalBinding(FSecond[idx])^ := Value
  else begin
    idx := FFirst.Add(AllocMem(SizeOf(TNameComponent)));
    PNameComponent(FFirst[Idx])^ := Index;
    idx := FSecond.Add(AllocMem(SizeOf(TLocalBinding)));
    PLocalBinding(FSecond[Idx])^ := Value;
  end;
end;

procedure TBindingTable.SetItems(Index: Integer; const Value: TLocalBinding);
begin
  PLocalBinding(FSecond[Index])^ := Value;
end;

procedure TBindingTable.SetNames(Index: Integer; const Value: TNameComponent);
begin
  PNameComponent(FFirst[Index])^ := Value;
end;

initialization
  Contexts := TInterfaceList.Create;
end.
