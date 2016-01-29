unit npbHyperlinkFilter;

interface

uses
  evdLeafParaFilter, k2Interfaces;

type
 TnpbHyperlinkFilter = class(TevdLeafParaFilter)
 protected
        {* Summary
          ���������� ����� �� ����������� ���������� �����.  }
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 end;

implementation

uses
  evSegLst, evdTypes, StrUtils, k2Tags;

procedure TnpbHyperlinkFilter.DoWritePara(aLeaf: Tl3Variant);
var
 l_Layer: Tl3Variant;
 i: Integer;
begin
 if not (AnsiContainsText(aLeaf.StrA[k2_tiText], '��. ������ ����� �') or AnsiContainsText(aLeaf.StrA[k2_tiText], '��. ����������� ������')) then
 begin
  l_Layer := aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], nil);
  if l_Layer.IsValid then
   l_Layer.AsObject.DeleteChildren;
 end;
 inherited DoWritePara(aLeaf);
end;

end.
