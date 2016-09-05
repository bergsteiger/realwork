unit evdHyperlinkEliminator;
 {* Фильтр, удаляющий все гиперссылки в документе }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdHyperlinkEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdHyperlinkEliminator" MUID: (4E9FD8340247)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdHyperlinkEliminator = class(TevdLeafParaFilter)
  {* Фильтр, удаляющий все гиперссылки в документе }
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdHyperlinkEliminator

implementation

uses
 l3ImplUses
 , HyperLink_Const
 //#UC START# *4E9FD8340247impl_uses*
 //#UC END# *4E9FD8340247impl_uses*
;

function TevdHyperlinkEliminator.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4E9FD8340247_var*
//#UC END# *49E488070386_4E9FD8340247_var*
begin
//#UC START# *49E488070386_4E9FD8340247_impl*
 Result := k2_typHyperLink;
//#UC END# *49E488070386_4E9FD8340247_impl*
end;//TevdHyperlinkEliminator.ParaTypeForFiltering

function TevdHyperlinkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4E9FD8340247_var*
//#UC END# *49E48829016F_4E9FD8340247_var*
begin
//#UC START# *49E48829016F_4E9FD8340247_impl*
 Result := False;
//#UC END# *49E48829016F_4E9FD8340247_impl*
end;//TevdHyperlinkEliminator.NeedWritePara

end.
