unit evdMarkEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdMarkEliminator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdMarkEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdMarkEliminator

implementation

uses
 l3ImplUses
 , Mark_Const
;

function TevdMarkEliminator.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4DDE3E97005C_var*
//#UC END# *49E488070386_4DDE3E97005C_var*
begin
//#UC START# *49E488070386_4DDE3E97005C_impl*
 Result := k2_typMark;
//#UC END# *49E488070386_4DDE3E97005C_impl*
end;//TevdMarkEliminator.ParaTypeForFiltering

function TevdMarkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4DDE3E97005C_var*
//#UC END# *49E48829016F_4DDE3E97005C_var*
begin
//#UC START# *49E48829016F_4DDE3E97005C_impl*
 Result := false;
//#UC END# *49E48829016F_4DDE3E97005C_impl*
end;//TevdMarkEliminator.NeedWritePara

end.
