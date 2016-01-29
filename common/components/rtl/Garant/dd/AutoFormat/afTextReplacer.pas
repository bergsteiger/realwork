unit afTextReplacer;

interface

uses
  evdLeafParaFilter, k2Interfaces, k2TagGen;

type
 TafTextReplacer = class(TevdLeafParaFilter)
 private
  f_ReplaceText: string;
  f_SearchText: string;
 protected
  procedure DoWritePara(aLeaf: Tl3Tag); override;
 public
  class function SetTo(var theGenerator: Tk2TagGenerator; const aSearchText, aReplaceText: String):
      Tk2TagGenerator; overload;
 published
  property ReplaceText: string read f_ReplaceText write f_ReplaceText;
  property SearchText: string read f_SearchText write f_SearchText;
 end;

implementation

uses
  evSearch, evTypes, NevTools, k2Tags, evParaTools;

procedure TafTextReplacer.DoWritePara(aLeaf: Tl3Tag);
const
 cOpt = [ev_soNoException, ev_soNoProgress, ev_soReplaceAll];
var
 l_nevPara: InevPara;
 l_Searcher: IevSearcher;
 l_Replacer: IevReplacer;
begin
 if aLeaf.Attr[k2_tiText].IsValid then
 begin
  if aLeaf.QT(InevPara, l_nevPara) then
  try
   l_Searcher:= TevBMTextSearcher.Make(SearchText, cOpt);
   try
    l_Replacer:= TevTextReplacer.Make(ReplaceText, cOpt);
    try
     EvReplaceInPara(l_nevPara, l_Searcher, l_Replacer);
    finally
     l_Replacer:= nil;
    end;//try..finally
   finally
    l_Searcher:= nil;
   end;//try..finally
  finally
   l_Nevpara:= nil;
  end;//try..finally
 end;//aLeaf.Attr[k2_tiText].IsValid
 inherited;
end;

class function TafTextReplacer.SetTo(var theGenerator: Tk2TagGenerator; const aSearchText,
    aReplaceText: String): Tk2TagGenerator;
begin
 Result:= SetTo(theGenerator);
 TafTextReplacer(theGenerator).SearchText:= aSearchText;
 TafTextReplacer(theGenerator).ReplaceText:= aReplaceText;
end;

end.
