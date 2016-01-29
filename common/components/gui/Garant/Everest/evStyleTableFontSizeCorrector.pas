unit evStyleTableFontSizeCorrector;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStyleTableFontSizeCorrector.pas"
// Начат: 29.07.2011 16:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevStyleTableFontSizeCorrector
//
// {RequestLink:209585097}.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant
  ;

type
 TevStyleTableFontSizeCorrector = class(TevdLeafParaFilter)
  {* [RequestLink:209585097]. }
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevStyleTableFontSizeCorrector

implementation

uses
  evDefaultStylesFontSizes,
  evdTextStyle_Const,
  k2Tags
  ;

// start class TevStyleTableFontSizeCorrector

function TevStyleTableFontSizeCorrector.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4E32AB1401C0_var*
//#UC END# *49E488070386_4E32AB1401C0_var*
begin
//#UC START# *49E488070386_4E32AB1401C0_impl*
 Result := k2_typTextStyle;
//#UC END# *49E488070386_4E32AB1401C0_impl*
end;//TevStyleTableFontSizeCorrector.ParaTypeForFiltering

procedure TevStyleTableFontSizeCorrector.DoWritePara(aLeaf: Tl3Variant);
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