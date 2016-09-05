unit evNestedCommentsEliminator;

// Модуль: "w:\common\components\gui\Garant\Everest\evNestedCommentsEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevNestedCommentsEliminator" MUID: (4E15CCEC0256)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevNestedCommentsEliminator = class(Tk2TagFilter)
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevNestedCommentsEliminator

implementation

uses
 l3ImplUses
 , CommentPara_Const
 //#UC START# *4E15CCEC0256impl_uses*
 //#UC END# *4E15CCEC0256impl_uses*
;

function TevNestedCommentsEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4E15CCEC0256_var*
//#UC END# *4CA3006302BC_4E15CCEC0256_var*
begin
//#UC START# *4CA3006302BC_4E15CCEC0256_impl*
 if CurrentType.IsKindOf(k2_typCommentPara) then
  Result:= (TopType[1] = nil)
 else
  Result:= True;
//#UC END# *4CA3006302BC_4E15CCEC0256_impl*
end;//TevNestedCommentsEliminator.NeedTranslateChildToNext

end.
