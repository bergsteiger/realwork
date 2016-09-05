unit evLeafParaDecorationsHolderEliminator;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evLeafParaDecorationsHolderEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevLeafParaDecorationsHolderEliminator" MUID: (4D9343CE038C)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevLeafParaDecorationsHolderEliminator = class(Tk2TagFilter)
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevLeafParaDecorationsHolderEliminator

implementation

uses
 l3ImplUses
 , LeafParaDecorationsHolder_Const
 //#UC START# *4D9343CE038Cimpl_uses*
 //#UC END# *4D9343CE038Cimpl_uses*
;

function TevLeafParaDecorationsHolderEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4D9343CE038C_var*
//#UC END# *4CA3006302BC_4D9343CE038C_var*
begin
//#UC START# *4CA3006302BC_4D9343CE038C_impl*
 Result := not CurrentType.IsKindOf(k2_typLeafParaDecorationsHolder);
//#UC END# *4CA3006302BC_4D9343CE038C_impl*
end;//TevLeafParaDecorationsHolderEliminator.NeedTranslateChildToNext

end.
