unit evdAllParaEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdAllParaEliminator.pas"
// Стереотип: "SimpleClass"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdAllParaEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdAllParaEliminator

implementation

uses
 l3ImplUses
 , Para_Const
;

function TevdAllParaEliminator.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4E1C278402E2_var*
//#UC END# *49E488070386_4E1C278402E2_var*
begin
//#UC START# *49E488070386_4E1C278402E2_impl*
 Result := k2_typPara;
//#UC END# *49E488070386_4E1C278402E2_impl*
end;//TevdAllParaEliminator.ParaTypeForFiltering

function TevdAllParaEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4E1C278402E2_var*
//#UC END# *49E48829016F_4E1C278402E2_var*
begin
//#UC START# *49E48829016F_4E1C278402E2_impl*
 Result := false;
//#UC END# *49E48829016F_4E1C278402E2_impl*
end;//TevdAllParaEliminator.NeedWritePara

end.
