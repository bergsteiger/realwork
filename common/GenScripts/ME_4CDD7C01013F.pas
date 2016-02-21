unit evdTextToFirstParaAdder;
 {* Фильтр, добавляющий текст к первому параграфу }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTextToFirstParaAdder.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Interfaces
 , k2Interfaces
 , l3Variant
;

type
 TevdTextToFirstParaAdder = class(TevdLeafParaFilter)
  {* Фильтр, добавляющий текст к первому параграфу }
  private
   f_Text: Il3CString;
   f_WasAdd: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
   procedure ClearFields; override;
  public
   class function SetTo(var theGenerator: Ik2TagGenerator;
    const aText: Il3CString): Ik2TagGenerator;
   constructor Create(const aText: Il3CString); reintroduce;
 end;//TevdTextToFirstParaAdder

implementation

uses
 l3ImplUses
 , k2Tags
 , l3CustomString
 , HyperLink_Const
 , evdTypes
 , l3String
 , l3Types
 , SysUtils
;

class function TevdTextToFirstParaAdder.SetTo(var theGenerator: Ik2TagGenerator;
 const aText: Il3CString): Ik2TagGenerator;
//#UC START# *4CDD7CC5001A_4CDD7C01013F_var*
var
 l_Filter : TevdTextToFirstParaAdder;
//#UC END# *4CDD7CC5001A_4CDD7C01013F_var*
begin
//#UC START# *4CDD7CC5001A_4CDD7C01013F_impl*
 if l3IsNil(aText) then
  Result := theGenerator
 else
 begin
  l_Filter := Create(aText);
  try
   l_Filter.Generator := theGenerator;
   theGenerator := l_Filter;
  finally
   FreeAndNil(l_Filter);
  end;//try..finally
  Result := theGenerator;
 end;//l3IsNil(aText)
//#UC END# *4CDD7CC5001A_4CDD7C01013F_impl*
end;//TevdTextToFirstParaAdder.SetTo

constructor TevdTextToFirstParaAdder.Create(const aText: Il3CString);
//#UC START# *4CDD7CFF03C8_4CDD7C01013F_var*
//#UC END# *4CDD7CFF03C8_4CDD7C01013F_var*
begin
//#UC START# *4CDD7CFF03C8_4CDD7C01013F_impl*
 inherited Create;
 f_Text := aText;
//#UC END# *4CDD7CFF03C8_4CDD7C01013F_impl*
end;//TevdTextToFirstParaAdder.Create

procedure TevdTextToFirstParaAdder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CDD7C01013F_var*
//#UC END# *479731C50290_4CDD7C01013F_var*
begin
//#UC START# *479731C50290_4CDD7C01013F_impl*
 f_WasAdd := false;
 inherited;
//#UC END# *479731C50290_4CDD7C01013F_impl*
end;//TevdTextToFirstParaAdder.Cleanup

procedure TevdTextToFirstParaAdder.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_4CDD7C01013F_var*
var
 l_S   : Tl3CustomString;
 l_Len : Integer;
 l_H   : Tl3Variant;
//#UC END# *49E4883E0176_4CDD7C01013F_var*
begin
//#UC START# *49E4883E0176_4CDD7C01013F_impl*
 if not f_WasAdd then
 begin
  if aLeaf.HasSubAtom(k2_tiText) then
  begin
   l_S := (aLeaf.Attr[k2_tiText] As Tl3CustomString);
   if (l_S <> nil) AND not l_S.Empty then
   begin
    f_WasAdd := true;
    l_Len := l_S.Len;
    l_S.Append(l3PCharLen(f_Text));
    with aLeaf.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)]) do
     if IsValid then
     begin
      l_H := rAtomEx([k2_tiChildren, l3_siNative, l_Len]);
      if l_H.IsValid then
       if (l_H.IntA[k2_tiFinish] = l_Len) then
        l_H.IntA[k2_tiFinish] := l_S.Len;
     end;//IsValid
   end;//l_S <> nil
  end;//aLeaf.HasSubAtom(k2_tiText)
 end;//not f_WasAdd
 inherited;
//#UC END# *49E4883E0176_4CDD7C01013F_impl*
end;//TevdTextToFirstParaAdder.DoWritePara

procedure TevdTextToFirstParaAdder.ClearFields;
begin
 f_Text := nil;
 inherited;
end;//TevdTextToFirstParaAdder.ClearFields

end.
