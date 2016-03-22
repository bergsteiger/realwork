unit evBlocksEliminator;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evBlocksEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevBlocksEliminator" MUID: (4CA311770238)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevBlocksEliminator = class(Tk2TagFilter)
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevBlocksEliminator

implementation

uses
 l3ImplUses
 , Block_Const
 , Document_Const
;

function TevBlocksEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4CA311770238_var*
//#UC END# *4CA3006302BC_4CA311770238_var*
begin
//#UC START# *4CA3006302BC_4CA311770238_impl*
 with CurrentType do
  Result := not IsKindOf(k2_typBlock) OR IsKindOf(k2_typDocument);
//#UC END# *4CA3006302BC_4CA311770238_impl*
end;//TevBlocksEliminator.NeedTranslateChildToNext

end.
