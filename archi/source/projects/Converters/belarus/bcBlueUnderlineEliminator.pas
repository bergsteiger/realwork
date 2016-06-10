unit bcBlueUnderlineEliminator;

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant,
  k2Interfaces
  ;

type
 TbcBlueUnderlineEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TbcBlueUnderlineEliminator

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
  Graphics,
  l3String,
  Document_Const,
  TextSegment_Const,
  vtDebug
  ;

// start class TbcBlueUnderlineEliminator

function TbcBlueUnderlineEliminator.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTextSegment;
end;//TbcBlueUnderlineEliminator.ParaTypeForFiltering

procedure TbcBlueUnderlineEliminator.DoWritePara(aLeaf: Tl3Variant);
begin
 if aLeaf.HasSubAtom(k2_tiFont) then
 begin
  aLeaf.Attr[k2_tiFont].AttrW[k2_tiSize, nil] := nil;
  if aLeaf.Attr[k2_tiFont].HasSubAtom(k2_tiUnderline) and aLeaf.Attr[k2_tiFont].BoolA[k2_tiUnderline] and
     aLeaf.Attr[k2_tiFont].HasSubAtom(k2_tiForeColor) and (aLeaf.Attr[k2_tiFont].IntA[k2_tiForeColor] = clBlue) then
  begin
   aLeaf.Attr[k2_tiFont].AttrW[k2_tiUnderline, nil] := nil;
   aLeaf.Attr[k2_tiFont].AttrW[k2_tiForeColor, nil] := nil;
  end;
  if aLeaf.Attr[k2_tiFont].Empty then
   Exit;
 end;
 inherited;
end;//TbcBlueUnderlineEliminator.DoWritePara

end.