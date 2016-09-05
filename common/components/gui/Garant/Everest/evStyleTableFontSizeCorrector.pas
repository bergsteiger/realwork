unit evStyleTableFontSizeCorrector;
 {* [RequestLink:209585097]. }

// Модуль: "w:\common\components\gui\Garant\Everest\evStyleTableFontSizeCorrector.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevStyleTableFontSizeCorrector" MUID: (4E32AB1401C0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevStyleTableFontSizeCorrector = class(TevdLeafParaFilter)
  {* [RequestLink:209585097]. }
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevStyleTableFontSizeCorrector

implementation

uses
 l3ImplUses
 , evDefaultStylesFontSizes
 , evdTextStyle_Const
 , k2Tags
 //#UC START# *4E32AB1401C0impl_uses*
 //#UC END# *4E32AB1401C0impl_uses*
;

function TevStyleTableFontSizeCorrector.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4E32AB1401C0_var*
//#UC END# *49E488070386_4E32AB1401C0_var*
begin
//#UC START# *49E488070386_4E32AB1401C0_impl*
 Result := k2_typTextStyle;
//#UC END# *49E488070386_4E32AB1401C0_impl*
end;//TevStyleTableFontSizeCorrector.ParaTypeForFiltering

procedure TevStyleTableFontSizeCorrector.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_4E32AB1401C0_var*
//#UC END# *49E4883E0176_4E32AB1401C0_var*
begin
//#UC START# *49E4883E0176_4E32AB1401C0_impl*
 if aLeaf.HasSubAtom(k2_tiFont) then
  if aLeaf.Attr[k2_tiFont].HasSubAtom(k2_tiSize) and not aLeaf.Attr[k2_tiFont].Attr[k2_tiSize].IsTransparent then
   aLeaf.Attr[k2_tiFont].IntA[k2_tiSize] :=
    TevDefaultStylesFontSizes.Instance.FontSizeForStyle(aLeaf.IntA[k2_tiHandle]); 
 inherited;
//#UC END# *49E4883E0176_4E32AB1401C0_impl*
end;//TevStyleTableFontSizeCorrector.DoWritePara

end.
