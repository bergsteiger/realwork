unit dd_lcDocByTypeFilter;

interface

uses
 Classes,

 l3Types,
 l3Variant,
 l3StringList,
 evdBufferedFilter,
 k2Interfaces,
 k2TagGen,
 k2Types,

 dd_lcBaseDocFilter, k2Base, k2Prim;

type
 TlcDocByTypeFilter = class(Tdd_lcBaseDocFilter)
 private
  f_DocHandle: Integer;
  f_HasProperType: Boolean;
  f_ProperTypes: Tl3StringList;
  procedure LoadProperTypes(const aFilename: AnsiString);
 protected
  function ChildTypeForFiltering: Tk2Type; override;
  procedure Cleanup; override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket
      : Boolean); override;
 public
  procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
  procedure StartChild(TypeID: Tl3VariantDef); override;
  class function SetTo(var theGenerator: Tk2TagGenerator; const aTypesFilename: AnsiString): Pointer; overload;
 end;

implementation

uses
 SysUtils,

 l3Base, l3String, l3Interfaces, l3Filer,

 Table_Const, Block_Const, Document_Const, TextPara_Const, DictItem_Const,

 k2Tags, l3StringListPrim;

procedure TlcDocByTypeFilter.AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
var
 l_Name: Il3CString;
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  case AtomIndex of
   k2_tiExternalHandle: f_DocHandle:= Value.AsInteger;
   k2_tiInternalHandle: f_DocHandle:= -Value.AsInteger;
  end;
 if (f_ProperTypes <> nil) and (not f_HasProperType) and CurrentType.IsKindOf(k2_typDictItem) and
    TopObject[1].IsProp and (TopObject[1].AsProp.TagIndex = k2_tiTypes) and (AtomIndex = k2_tiName) and
    (Value.Kind = k2_vkString) then
 begin
  l_Name := l3Upper(Value.AsString.AsWStr);
  if f_ProperTypes.IndexOf(l_Name) >= 0 then
   f_HasProperType := True;
 end;
end;

function TlcDocByTypeFilter.ChildTypeForFiltering: Tk2Type;
begin
 Result := k2_typDocument;
end;

procedure TlcDocByTypeFilter.Cleanup;
begin
 inherited;
 FreeAndNil(f_ProperTypes);
end;

procedure TlcDocByTypeFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
begin
 if f_HasProperType then
  inherited;
end;

procedure TlcDocByTypeFilter.LoadProperTypes(const aFilename: AnsiString);
var
 l_Filer: Tl3DOSFiler;
 l_Str: Il3CString;
begin
 if f_ProperTypes <> nil then
  f_ProperTypes.Clear
 else
  f_ProperTypes := Tl3StringList.MakeSorted;
 l_Filer := Tl3DOSFiler.Make(aFilename);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Str := l3Upper(l3Trim(l_Filer.ReadLn));
   if not l3IsNil(l_Str) then
    f_ProperTypes.Add(l_Str);
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

class function TlcDocByTypeFilter.SetTo(var theGenerator: Tk2TagGenerator; const aTypesFilename: AnsiString): Pointer;
var
 l_Filter : TlcDocByTypeFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l_Filter.LoadProperTypes(aTypesFilename);
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure TlcDocByTypeFilter.StartChild(TypeID: Tl3VariantDef);
begin
 {
 if TypeTable[TypeID].IsKindOf([k2_typTextPara, k2_typTable, k2_typBlock]) and
    not TypeTable[TypeID].IsKindOf(k2_typDocument) and not (f_HasProperType) and (SkipLevel = 2) then
 begin
  f_HasProperType:= True;
  StopBufferingAndFlush(False, TopObject[0], False);
 end; //
 }
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  f_HasProperType:= False;
  f_DocHandle:= 0;
 end; // CurrentType.IsKindOf(k2_typDocument)
end;

end.
