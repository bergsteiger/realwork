unit evFilterReplacer;

{ $Id: evFilterReplacer.pas,v 1.1 2016/08/24 09:11:47 fireton Exp $ }

interface
uses
 l3Types,
 evTypes,
 evSearch,
 nevBase,
 nevTools;

type
 // реплейсер, который всё полученное прогоняет через фильтр, а потом вставляет
 TevFilterReplacer = class(TevBaseReplacer)
 private
  f_Filters: InevTagGenerator;
  f_TextSource: InevTagReader;
 protected
        {-}
  function ReplaceFunc(const aView : InevView; const Container : InevOp; const aBlock : InevRange): Bool; override;
 public
  class function Make(const aTextSource: InevTagReader;
                      const aFilters: InevTagGenerator;
                            anOptions : TevSearchOptionSet = []): IevReplacer; reintroduce;
 end;

implementation
uses
 SysUtils,
 l3Memory,
 evdInterfaces;

class function TevFilterReplacer.Make(const aTextSource: InevTagReader; const aFilters: InevTagGenerator; anOptions :
 TevSearchOptionSet = []): IevReplacer;
  //overload;
  {-}
var
 l_Replacer : TevFilterReplacer;
begin
 l_Replacer := Create;
 try
  l_Replacer.Options := anOptions;
  l_Replacer.f_TextSource := aTextSource;
  l_Replacer.f_Filters := aFilters;
  Result := l_Replacer;
 finally
  FreeAndNil(l_Replacer);
 end;//try..finally
end;

function TevFilterReplacer.ReplaceFunc(const aView : InevView; const Container : InevOp; const aBlock : InevRange): Bool;
var
 l_MemoryPool: Tl3MemoryPool;
begin
 Result := True;

 l_MemoryPool := Tl3MemoryPool.Create;
 try
  f_TextSource.ReadTag(cf_EverestBin, l_MemoryPool as IStream, f_Filters, aBlock.AsStorable,
    evDefaultStoreFlags {+ [evd_sfInternal]} - [evd_sfStoreParaEnd]);
  aBlock.Text.Modify.InsertStream(aView, l_MemoryPool as IStream, cf_EverestBin, Container);
 finally
  FreeAndNil(l_MemoryPool);
 end;

end;

end.