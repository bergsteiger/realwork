unit ddAccGroupGenerator;
{ Добавляет в документ Группу Доступа, если в документе их нет }


interface

uses
  ddHeaderFilter, k2Interfaces, k2Prim, k2TagGen;

type
 TddAccGroupGenerator = class(TddHeaderFilter)
 private
  f_AccGroup: string;
 protected
  procedure AfterFlushHeader(aHeaderRoot: Tl3Variant); override;
 public
        {* - создает экземпляр класа и цепляет его к генератору. }
  class function SetTo(var theGenerator: Ik2TagGenerator; const aAccGroup:
      String): Ik2TagGenerator; overload;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; const aAccGroup:
      String): Pointer; overload;
  property AccGroup: string read f_AccGroup write f_AccGroup;
 end;

implementation

uses
  k2Tags, DictItem_Const, SysUtils, l3Base;

procedure TddAccGroupGenerator.AfterFlushHeader(aHeaderRoot: Tl3Variant);
begin
 if not aHeaderRoot.Attr[k2_tiAccGroups].IsValid and (f_AccGroup <> '') then
 begin
   Generator.StartTag(k2_tiAccGroups);
   try
    Generator.StartChild(k2_typDictItem);
    try
     Generator.AddStringAtom(k2_tiShortName, f_AccGroup);
    finally
     Generator.Finish;
    end;
   finally
    Generator.Finish;
   end;
 end;
end;

class function TddAccGroupGenerator.SetTo(var theGenerator: Ik2TagGenerator;
    const aAccGroup: String): Ik2TagGenerator;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
var
 l_Filter : TddAccGroupGenerator;
begin
 l_Filter := Create(nil);
 try
  l_Filter.AccGroup:= aAccGroup;
  l_Filter.Generator := theGenerator;
  theGenerator := l_Filter;
 finally
  FreeAndNil(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

class function TddAccGroupGenerator.SetTo(var theGenerator: Tk2TagGenerator;
    const aAccGroup: String): Pointer;
  {-}
var
 l_Filter : TddAccGroupGenerator;
begin
 l_Filter := Create(nil);
 try
  l_Filter.AccGroup:= aAccGroup;
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  FreeAndNIl(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
