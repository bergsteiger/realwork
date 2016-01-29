// **********************************************************************
//
// Copyright (c) 2001 - 2002 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit idldb;

interface

uses
  classes,parser,ir_int,ir,sysutils;

type
  TPseudoRepoId = class
  private
    FFullId: AnsiString;
    FSuffix: AnsiString;
    FPrefix: AnsiString;
    FContainedId: AnsiString;
    function GetFullId: AnsiString;
    procedure SetFullId(const Value: AnsiString);
    procedure SetContainedId(const Value: AnsiString);
    procedure SetPrefix(const Value: AnsiString);
    procedure SetSuffix(const Value: AnsiString);
  public
    property ContainedId: AnsiString read FContainedId write SetContainedId;
    property Prefix: AnsiString read FPrefix write SetPrefix;
    property Suffix: AnsiString read FSuffix write SetSuffix;
    property FullId: AnsiString read GetFullId write SetFullId;
  end;

   TDB = class
   private
     FRepoidFilesnames : TStringList;
     FCurrentPrefixes : TStringList;
     FPrefixes : TStringList;
     FPrefixeNames : TStringList;
     FVersions : TStringList;
     FVersionNames : TStringList;
     FIDs : TStringList;
     FIDNames : TStringList;
     FScopeNames : TStringList;
     FIdToPseudoIdMap: TStringList;
   public
     constructor Create();
     destructor Destroy(); override;
     procedure register_repoid(node: TNode; id: AnsiString);
     function repoid_defined(id: AnsiString): Boolean;
     function repoid_file_name(id: AnsiString): AnsiString;
     procedure register_anonymous(node: TNode; t : IIDLType);
     function pseudo_repoid(t: IIDLType): AnsiString;
     procedure enter_scope(name: AnsiString);
     procedure leave_scope();
     procedure switch_prefix(val: AnsiString);
     procedure set_prefix(const name, val: AnsiString);
     function get_prefix(const absolute_name: AnsiString): AnsiString;
     function get_id_prefix: AnsiString;
     procedure set_version(name: AnsiString; val: AnsiString);
     procedure enter_include();
     procedure leave_include();
     procedure set_repoids(rep: IRepository);
     procedure set_repo_id(name,id: AnsiString);
     function get_current_scope(): AnsiString;
     procedure gen_pseudo_repoid(t: IIDLType; pseudo_id: TPseudoRepoId);
   end;

implementation

{ TDB }
uses
  orb_int;

constructor TDB.Create;
begin
  FRepoidFilesnames := TStringList.Create;
  FCurrentPrefixes := TStringList.Create;
  FPrefixes := TStringList.Create;
  FPrefixeNames := TStringList.Create;
  FVersions := TStringList.Create;
  FVersionNames := TStringList.Create;
  FIDs := TStringList.Create;
  FIDNames := TStringList.Create;
  FScopeNames := TStringList.Create;
  FIdToPseudoIdMap := TStringList.Create;
  FCurrentPrefixes.Add('');
end;

destructor TDB.Destroy;
var
  i: Integer;
begin
  FRepoidFilesnames.free;
  FVersions.Free;
  FVersionNames.Free;
  FIDs.Free;
  FIDNames.Free;
  FCurrentPrefixes.Free;
  FPrefixes.Free;
  FPrefixeNames.Free;
  FScopeNames.Free;
  for i := 0 to FIdToPseudoIdMap.Count - 1 do
    FIdToPseudoIdMap.Objects[i].Free;
  FIdToPseudoIdMap.Free;
  inherited;
end;

procedure TDB.enter_include;
begin
  FScopeNames.Add('');
  FCurrentPrefixes.Add('');
end;

procedure TDB.enter_scope(name: AnsiString);
begin
  FScopeNames.Add(String(name));
  FCurrentPrefixes.Add(FCurrentPrefixes[FCurrentPrefixes.count-1]);
end;

function TDB.get_id_prefix: AnsiString;
var
  i : integer;
begin
  result := AnsiString(FCurrentPrefixes[FCurrentPrefixes.Count-1]);
  for i := 0 to pred(FScopeNames.count) do
    begin
      if result <> '' then result := result + '_';
      result := result + AnsiString(FScopeNames[i]);
    end;
  if result <> '' then result := result + '_';
end;

function TDB.get_prefix(const absolute_name: AnsiString): AnsiString;
var
  i, longest_match, len: integer;
begin
  longest_match := 0;
  result := '';
  for i := 0 to FPrefixeNames.Count - 1 do begin
    len := Length(FPrefixeNames[i]);
    if ((StrLComp(PAnsiChar(AnsiString(FPrefixeNames[i])), PAnsiChar(absolute_name), len) = 0) and
	    ((Length(absolute_name) = len) or
	    (absolute_name[len + 1] = ':') or
	    ((len = 2) and (absolute_name[1] = ':') and (absolute_name[2] = ':')) and
	    (len > longest_match))) then begin
      longest_match := len;
      result := AnsiString(FPrefixes[i]);
    end;
  end;
  if longest_match = 0 then
    result := AnsiString(FCurrentPrefixes[FCurrentPrefixes.Count-1]);
  for i := 0 to pred(FScopeNames.count) do begin
    if FScopeNames[i] = '' then continue;
    if result <> '' then
      result := result + '/';
    result := result {+ '/'} + AnsiString(FScopeNames[i]);
    //result := FScopeNames[i] + '/' + result;
  end;
  if result <> '' then
    result := result + '/';
  //if FCurrentPrefixes[FCurrentPrefixes.Count-1] <> '' then
    //result := FCurrentPrefixes[FCurrentPrefixes.Count-1] + '/' + result;
end;

procedure TDB.leave_include;
begin
  FScopeNames.Delete(FScopeNames.Count-1);
  FCurrentPrefixes.Delete(FCurrentPrefixes.Count-1);
end;

procedure TDB.leave_scope;
begin
  FScopeNames.Delete(FScopeNames.Count-1);
  FCurrentPrefixes.Delete(FCurrentPrefixes.Count-1);
end;

function TDB.pseudo_repoid(t: IIDLType): AnsiString;
var
  pseudo_id: TPseudoRepoId;
begin
  pseudo_id := TPseudoRepoId.Create;
  try
    gen_pseudo_repoid(t, pseudo_id);
    result := pseudo_id.FullId;
  finally
    pseudo_id.Free;
  end;
end;

procedure TDB.register_anonymous(node: TNode; t: IIDLType);
var
  pseudo_id: TPseudoRepoId;
begin
  if node.top_level then exit;
  pseudo_id := TPseudoRepoId.Create;
  gen_pseudo_repoid(t, pseudo_id);

  FRepoidFilesnames.Values[String(pseudo_id.FullId)] := String(node.file_name);

  if pseudo_id.ContainedId <> '' then
    FIdToPseudoIdMap.AddObject(String(pseudo_id.ContainedId), pseudo_id)
  else
    pseudo_id.Free;
end;

procedure TDB.register_repoid(node: TNode; id: AnsiString);
begin
  if not node.top_level then
    FRepoidFilesnames.Values[String(id)] := String(node.file_name);
end;

function TDB.repoid_defined(id: AnsiString): Boolean;
begin
  result := FRepoidFilesnames.Values[String(id)] <> '';
end;

function TDB.repoid_file_name(id: AnsiString): AnsiString;
begin
  result := AnsiString(FRepoidFilesnames.Values[String(id)]);
end;

procedure TDB.switch_prefix(val: AnsiString);
begin
  FCurrentPrefixes[FCurrentPrefixes.Count-1] := String(val);
end;

procedure TDB.set_repoids(rep: IRepository);
var
  i, j : integer;
  c: IContained;
  pseudoId: TPseudoRepoId;
  oldId, fname, newId, newPseudoId: AnsiString;
begin
  for i := 0 to Pred(FVersions.count) do begin
    c := rep.lookup(AnsiString(FVersionNames[i]));
    if c <> nil then begin
      c._version(AnsiString(FVersions[i]));
      oldId := c._id();
      fname := repoid_file_name(oldId);
      if fname <> '' then begin
        //this is a total hack
        //replace last 3 character!!! we can get problematic with version of next format 6.66
        newId := AnsiString(Copy(String(oldId), 1, Length(oldId) - 3) + FVersionNames[i]);
        FRepoidFilesnames.Values[String(newId)] := String(fname);
      end;
    end;
  end;
  for i := 0 to Pred(FIDs.count) do begin
    c := rep.lookup(AnsiString(FIDNames[i]));
    if c <> nil then begin
      oldId := c._id();
      fname := repoid_file_name(oldId);
      if fname <> '' then
        FRepoidFilesnames.Values[FIDs[i]] := String(fname);
      c._id(AnsiString(FIDs[i]));
    end;

    // Update pseudo_ids of anonymous types that depend on the updated id
    for j := 0 to FIdToPseudoIdMap.Count - 1 do
      if FIdToPseudoIdMap[j] = String(oldId) then begin
        pseudoId := TPseudoRepoId(FIdToPseudoIdMap.Objects[j]);
        newPseudoId := pseudoId.Prefix + AnsiString(FIDs[0]) + pseudoId.Suffix;
        if not repoid_defined(newPseudoId) then
          FRepoidFilesnames.Values[String(newPseudoId)] := String(repoid_file_name(pseudoId.FullId));
      end;
  end;
end;

procedure TDB.set_repo_id(name, id: AnsiString);
begin
  FIDs.add(String(id));
  FIDNames.Add(String(name));
end;

procedure TDB.set_version(name, val: AnsiString);
begin
  FVersionNames.Add(String(name));
  FVersions.Add(String(val));
end;

procedure TDB.set_prefix(const name, val: AnsiString);
begin
  FPrefixeNames.Add(String(name));
  FPrefixes.Add(String(val));
end;

function TDB.get_current_scope: AnsiString;
var
  i: Integer;
begin
  result := '::';
  for i := 0 to FScopeNames.Count - 1 do
    if FScopeNames[i] <> '' then
      result := result + AnsiString(FScopeNames[i]) + '::';
end;

procedure TDB.gen_pseudo_repoid(t: IIDLType; pseudo_id: TPseudoRepoId);
var
  con: IContained;
  seq: ISequenceDef;
  arr : IArrayDef;
  pr : IPrimitiveDef;
begin
  con := TContained._narrow(t as IORBObject);
  if con <> nil then
    begin
      pseudo_id.ContainedId := con._id;
      exit;
    end;
  seq := TSequenceDef._narrow(t as IORBObject);
  if seq <> nil then
    begin
      gen_pseudo_repoid(seq.element_type_def, pseudo_id);
      pseudo_id.Prefix := 'sequence_';
      pseudo_id.Suffix := AnsiString('_' + inttostr(seq.bound));
      //result := 'sequence_'+pseudo_repoid(seq.element_type_def)+'_'+inttostr(seq.bound) ;
      exit;
    end;
  arr := TArrayDef._narrow(t as IORBObject);
  if arr <> nil then
    begin
      gen_pseudo_repoid(arr.element_type_def, pseudo_id);
      pseudo_id.Prefix := 'array_';
      pseudo_id.Suffix := AnsiString('_' + inttostr(arr.length));
      //result := 'array_'+pseudo_repoid(arr.element_type_def)+'_'+inttostr(arr.length) ;
      exit;
    end;
  pr := TPrimitiveDef._narrow(t as IORBObject);
  if pr <> nil then
    begin
      pseudo_id.FullId := AnsiString('primitive_'+inttostr(ord(pr.kind)));
      exit;
    end;
  Assert(False, 'Not implemented');
  // IFixedDef
  // IStringDef
  // IWStringDef
end;

{ TPseudoRepoId }

function TPseudoRepoId.GetFullId: AnsiString;
begin
  Result := FFullId;
end;

procedure TPseudoRepoId.SetContainedId(const Value: AnsiString);
begin
  FContainedId := Value;
  FFullId := Value;
end;

procedure TPseudoRepoId.SetFullId(const Value: AnsiString);
begin
  FFullId := Value;
end;

procedure TPseudoRepoId.SetPrefix(const Value: AnsiString);
begin
  FPrefix := Value;
  FFullId := FPrefix + FFullId;
end;

procedure TPseudoRepoId.SetSuffix(const Value: AnsiString);
begin
  FSuffix := Value;
  FFullId := FFullId + FSuffix;
end;

end.
