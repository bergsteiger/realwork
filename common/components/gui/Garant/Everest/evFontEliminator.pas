unit evFontEliminator;

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant,
  k2Interfaces
  ;

type
 TevFontEliminator = class(TevdLeafParaFilter)
 public
  DocID : Integer;
  NeedCorrect : Boolean; 
 protected 
   procedure LogDocID;
   procedure DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevFontEliminator

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
  vtDebug
  ;

// start class TevFontEliminator

procedure TevFontEliminator.LogDocID;
begin
 NeedCorrect := true;
 dbgAppendToLogLn(ChangeFileExt(ParamStr(0), '.num'), ClassName + ' ' + IntToStr(DocID));
end;

procedure TevFontEliminator.DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  case AtomIndex of
   k2_tiInternalHandle:
    if (Value.AsInteger > 0) then
     DocID := Value.AsInteger;
  end;//case AtomIndex
 end;//CurrentType.IsKindOf(k2_typDocument)
 inherited;
end;

function TevFontEliminator.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTextPara;
end;//TevFontEliminator.ParaTypeForFiltering

procedure TevFontEliminator.DoWritePara(aLeaf: Tl3Variant);
var
 l_Objects : Tl3Variant;
 l_Index : Integer;
 l_O : Tl3Variant;
begin
 aLeaf.AttrW[k2_tiFont, nil] := nil;
 //if evHasText(aLeaf) then
 begin
  l_Objects := aLeaf.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)]);
  if l_Objects.IsValid AND (l_Objects.ChildrenCount > 0) then
  begin
   l_Index := 0;
   while (l_Index < l_Objects.ChildrenCount) do
   begin
    l_O := l_Objects.Child[l_Index];
    if l_O.HasSubAtom(k2_tiFont) then
     LogDocID;
    l_O.AttrW[k2_tiFont, nil] := nil;
    Inc(l_Index);
   end;//while l_Index
  end;//l_Objects.IsValid
 end;//evHasText(aLeaf)
 inherited;
end;//TevFontEliminator.DoWritePara

end.