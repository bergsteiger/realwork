unit evCommentsEliminator;

// Модуль: "w:\common\components\gui\Garant\Everest\evCommentsEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCommentsEliminator" MUID: (4D6CD66C0391)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevFullCommentsEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevFullCommentsEliminator

 TevCommentsEliminator = class(Tk2TagFilter)
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevCommentsEliminator

implementation

uses
 l3ImplUses
 , CommentPara_Const
;

function TevFullCommentsEliminator.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4D6CD6890200_var*
//#UC END# *49E488070386_4D6CD6890200_var*
begin
//#UC START# *49E488070386_4D6CD6890200_impl*
 Result := k2_typCommentPara;
//#UC END# *49E488070386_4D6CD6890200_impl*
end;//TevFullCommentsEliminator.ParaTypeForFiltering

function TevFullCommentsEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4D6CD6890200_var*
//#UC END# *49E48829016F_4D6CD6890200_var*
begin
//#UC START# *49E48829016F_4D6CD6890200_impl*
 Result := false;
//#UC END# *49E48829016F_4D6CD6890200_impl*
end;//TevFullCommentsEliminator.NeedWritePara

function TevCommentsEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4D6CD66C0391_var*
//#UC END# *4CA3006302BC_4D6CD66C0391_var*
begin
//#UC START# *4CA3006302BC_4D6CD66C0391_impl*
 with CurrentType do
  Result := not IsKindOf(k2_typCommentPara);
//#UC END# *4CA3006302BC_4D6CD66C0391_impl*
end;//TevCommentsEliminator.NeedTranslateChildToNext

end.
