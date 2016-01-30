unit evLeafParaDecorationsHolderEliminator;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evLeafParaDecorationsHolderEliminator.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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
