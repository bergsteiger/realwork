unit ddSectionWithSub2Para;
{ Удаляет разрывы разделов, преобразует разрывы разлеов с метками в абзацы }
interface

uses
 evdLeafParaFilter, k2Interfaces, L3Types,

 k2Base
 ;

type
 TddSectionWithSub2ParaFilter = class(TevdLeafParaFilter)
 protected
        {* Summary
          Определяет нужно ли фильтровать переданный абзац.  }
  procedure DoWritePara(aLeaf: Tl3Variant); override;
        {-}
  function ParaTypeForFiltering: Tk2Type; override;
 end;

implementation

uses
 SectionBreak_Const, k2Tags, TextPara_Const, k2BaseTypes;

procedure TddSectionWithSub2ParaFilter.DoWritePara(aLeaf: Tl3Variant);
  //virtual;
  {-}
begin
 if aLeaf.Attr[k2_tiSubs].IsValid then
 begin
  Generator.StartChild(k2_typTextPara);
  try
   aLeaf.AsObject.WriteTag(Generator, l3_spfInner, [k2_tiParas]);
  finally
   Generator.Finish;
  end;//try..finally
 end
end;

function TddSectionWithSub2ParaFilter.ParaTypeForFiltering: Tk2Type;
  //virtual;
  {-}
begin
 Result := k2_typSectionBreak;
end;

end.
