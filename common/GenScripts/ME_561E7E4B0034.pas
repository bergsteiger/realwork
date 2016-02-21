unit evUnicodeFormulasToUnicodeConverter;

// Модуль: "w:\common\components\gui\Garant\Everest\evUnicodeFormulasToUnicodeConverter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevUnicodeFormulasToUnicodeConverter = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevUnicodeFormulasToUnicodeConverter

implementation

uses
 l3ImplUses
 , TextPara_Const
 , k2Tags
 , Formula_Const
 , evdTypes
 , l3_String
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , l3Base
 , l3String
 , ObjectSegment_Const
 , SysUtils
 , StrUtils
;

function TevUnicodeFormulasToUnicodeConverter.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_561E7E4B0034_var*
//#UC END# *49E488070386_561E7E4B0034_var*
begin
//#UC START# *49E488070386_561E7E4B0034_impl*
 Result := k2_typTextPara;
//#UC END# *49E488070386_561E7E4B0034_impl*
end;//TevUnicodeFormulasToUnicodeConverter.ParaTypeForFiltering

procedure TevUnicodeFormulasToUnicodeConverter.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_561E7E4B0034_var*
const
 cSig = 'String(#@';
var
 l_Objects : Tl3Variant;
 l_S : Tl3_String;
 l_Index : Integer;
 l_O : Tl3Variant;
 l_F : Tl3Variant;
 l_FS : AnsiString;
 l_Pos : Integer;
 l_Code : Integer;
 l_WideChar : WideChar;
//#UC END# *49E4883E0176_561E7E4B0034_var*
begin
//#UC START# *49E4883E0176_561E7E4B0034_impl*
 if evHasText(aLeaf) then
 begin
  l_Objects := aLeaf.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slObjects)]);
  if l_Objects.IsValid AND (l_Objects.ChildrenCount > 0) then
  begin
   l_S := aLeaf.Attr[k2_tiText].AsObject As Tl3_String;
   l_Index := 0;
   while (l_Index < l_Objects.ChildrenCount) do
   begin
    l_O := l_Objects.Child[l_Index];
    if l_O.IsKindOf(k2_typObjectSegment) AND (l_O.ChildrenCount = 1) then
    begin
     l_F := l_O.Child[0];
     if l_F.IsKindOf(k2_typFormula) then
     begin
      l_Pos := l_O.IntA[k2_tiStart];
      l_FS := (l_F.Attr[k2_tiText].AsObject As Tl3CustomString).AsString;
      if AnsiStartsStr(cSig, l_FS) then
       if AnsiEndsStr(')', l_FS) then
       begin
        Delete(l_FS, 1, Length(cSig));
        Delete(l_FS, Length(l_FS), 1);
        if TryStrToInt(l_FS, l_Code) then
        begin
         l_WideChar := WideChar(l_Code);
         Dec(l_Pos);
         l_S.Delete(l_Pos, 1);
         l_S.Insert(l3PCharLen(PWideChar(@l_WideChar), 1), l_Pos);
         l_Objects.DeleteChild(l_Index);
         continue;
        end;//TryStrToInt(l_FS, l_Code)
       end;//AnsiStartStr('String(#@', l_FS)
     end;//l_F.IsKindOf(k2_typFormula)
    end;//l_O.ChildrenCount = 1
    Inc(l_Index);
   end;//while l_Index
  end;//l_Objects.IsValid
 end;//evParaTools(aLeaf)
 inherited;
//#UC END# *49E4883E0176_561E7E4B0034_impl*
end;//TevUnicodeFormulasToUnicodeConverter.DoWritePara

end.
