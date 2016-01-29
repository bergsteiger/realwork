unit evdCommentFilter;

interface

uses
  evdLeafParaFilter, k2Interfaces;

type
 TevdCommentFilter = class(TevdLeafParaFilter)
 protected
  function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
 end;

implementation

uses
  evdStyles, k2Tags, l3String, StrUtils;

function TevdCommentFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
begin
 if (aLeaf.IntA[k2_tiStyle] = ev_saTxtComment) then
 begin
  if AnsiContainsText(aLeaf.StrA[k2_tiText], 'См. данную форму в') or
     AnsiContainsText(aLeaf.StrA[k2_tiText], 'См. графический объект') or
     AnsiContainsText(aLeaf.StrA[k2_tiText], 'См. графическое изображение') or
     AnsiContainsText(aLeaf.StrA[k2_tiText], 'в справочной правовой системе не приводится') then
   Result:= True;
 end
 else
 if (aLeaf.IntA[k2_tiStyle] = ev_saTechComment) or //(aLeaf.IntA[k2_tiStyle] = ev_saVersionInfo) or
    (aLeaf.IntA[k2_tiStyle] = ev_saUserComment) or (aLeaf.IntA[k2_tiStyle] = ev_saContents) then
  Result:= False
 else
  Result := inherited NeedWritePara(aLeaf);
end;

end.
