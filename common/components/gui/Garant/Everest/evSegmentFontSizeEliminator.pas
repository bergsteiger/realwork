unit evSegmentFontSizeEliminator;

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant,
  k2Interfaces
  ;

type
 TevSegmentFontSizeEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevSegmentFontSizeEliminator

implementation

uses
  TextPara_Const,
  k2Tags,
  Formula_Const,
  evdTypes,
  l3_String
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  l3Base,
  Segment_Const,
  StrUtils,
  SysUtils,
  l3String,
  Document_Const,
  TextSegment_Const,
  vtDebug
  ;

// start class TevSegmentFontSizeEliminator

function TevSegmentFontSizeEliminator.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTextSegment;
end;//TevSegmentFontSizeEliminator.ParaTypeForFiltering

procedure TevSegmentFontSizeEliminator.DoWritePara(aLeaf: Tl3Variant);
var
 l_N : String;
begin
 if aLeaf.HasSubAtom(k2_tiFont) then
 begin
  aLeaf.Attr[k2_tiFont].AttrW[k2_tiSize, nil] := nil;
  if aLeaf.Attr[k2_tiFont].HasSubAtom(k2_tiName) then
  begin
   l_N := aLeaf.Attr[k2_tiFont].StrA[k2_tiName];
   if (l_N = 'Times New Roman')
      OR (l_N = 'Arial') then
    aLeaf.Attr[k2_tiFont].AttrW[k2_tiName, nil] := nil;
  end;//aLeaf.Attr[k2_tiFont].HasSubAtom(k2_tiName)
  if aLeaf.Attr[k2_tiFont].Empty then
   aLeaf.AttrW[k2_tiFont, nil] := nil;
 end;//aLeaf.HasSubAtom(k2_tiFont)
 inherited;
end;//TevSegmentFontSizeEliminator.DoWritePara

end.