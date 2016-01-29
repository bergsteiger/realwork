unit dd_lcFASSourceCorrector;

{ $Id: dd_lcFASSourceCorrector.pas,v 1.1 2014/08/13 11:11:34 fireton Exp $ }

// См. К 561547565
// Хотелось бы при заливке документов ФАСов, принятых до 6 августа, в случае если у них стоит орган "АС ... округа",
// чтобы он заменялся на соответствующий ФАС этого же округа.

interface
uses
 l3Variant,
 k2Interfaces,
 ddSearchTree,
 dd_lcBaseHeaderFilter, k2TagGen;

type
 Tdd_lcFASSourceCorrector = class(Tdd_lcBaseHeaderFilter)
 private
  f_Tree: TddSearchTree;
  procedure LoadSources(aFileName: AnsiString);
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
  procedure Cleanup; override;
 public
  constructor Create;
  class function SetTo(var theGenerator: Tk2TagGenerator; aFileName: AnsiString): Pointer; overload;
 end;

implementation
uses
 SysUtils,
 l3Interfaces,
 l3Const,
 l3Chars,
 l3String,
 l3Date,
 l3Base,
 l3Filer,
 k2Tags,
 DT_Types;

const
 cDate6Aug2014 = 151428; // 6 августа 2014

constructor Tdd_lcFASSourceCorrector.Create;
begin
 inherited Create(nil);
 f_Tree := TddSearchTree.Create;
end;

procedure Tdd_lcFASSourceCorrector.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 I: Integer;
 l_DocSource: Tl3WString;
 l_DocPubDate: TStDate;
 l_Res: IInterface;
 l_SourceTag: Tl3Variant;
 l_Tag: Tl3Variant;
begin
 l_DocSource := cc_EmptyStr;
 l_DocPubDate := 0;
 l_Tag:= aHeaderRoot.Attr[k2_tiSources];
 if l_Tag.IsValid then
 begin
  l_SourceTag := l_Tag.Child[0];
  l_DocSource := l_SourceTag.PCharLenA[k2_tiName];
 end;
 l_Tag:= aHeaderRoot.Attr[k2_tiNumANDDates];
 if l_Tag.IsValid then
  for I := 0 to Pred(l_Tag.ChildrenCount) do
  begin
   if l_Tag.Child[I].IntA[k2_tiType] = Ord(dnPublish) then
   begin
    l_DocPubDate:= l_Tag.Child[i].IntA[k2_tiStart];
    Break;
   end
  end; // for i
 if (not l3IsNil(l_DocSource)) and (l_DocPubDate <> 0) then
  if l_DocPubDate < cDate6Aug2014 then
   if f_Tree.SearchStr(l_DocSource, l_Res) then
   begin
    l_SourceTag.PCharLenW[k2_tiName, nil] := Il3CString(l_Res).AsWStr;
    l3System.Msg2Log('АС заменён на ФАС');
   end;
end;

procedure Tdd_lcFASSourceCorrector.Cleanup;
begin
 FreeAndNil(f_Tree);
 inherited;
end;

procedure Tdd_lcFASSourceCorrector.LoadSources(aFileName: AnsiString);
var
 l_Filer: Tl3DOSFiler;
 l_Idx: Integer;
 l_Str, l_AS, l_FAS: Tl3WString;
begin
 l_Filer := Tl3DOSFiler.Make(aFileName);
 try
  l_Filer.Open;
  while not l_Filer.EOF do
  begin
   l_Str := l_Filer.ReadLn;
   l_Idx := ev_lpCharIndex(';', l_Str);
   if l_Idx <> l3NotFound then
   begin
    l_AS := l3Copy(l_Str, 0, l_Idx);
    l_FAS := l3Copy(l_Str, l_Idx+1);
    f_Tree.AddString(l3CStr(l_AS), l3CStr(l_FAS));
   end;
  end;
 finally
  FreeAndNil(l_Filer);
 end;
end;

class function Tdd_lcFASSourceCorrector.SetTo(var theGenerator: Tk2TagGenerator; aFileName: AnsiString): Pointer;
var
 l_Filter: Tdd_lcFASSourceCorrector;
begin
 l_Filter := Tdd_lcFASSourceCorrector.Create;
 try
  l_Filter.LoadSources(aFileName);
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.