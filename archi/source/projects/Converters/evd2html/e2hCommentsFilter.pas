unit e2hCommentsFilter;

interface

uses
 evdLeafParaFilter, l3Variant;

type
 Te2hCommentsFilter = class(TevdLeafParaFilter)
 protected
  function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
 end;

implementation

uses
 evdStyles, k2Tags;

function Te2hCommentsFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
begin
 if (aLeaf.IntA[k2_tiStyle] = ev_saTechComment) then
  Result:= False
 else
  Result := inherited NeedWritePara(aLeaf);
end;

end.
