unit evDocumentEliminator;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentEliminator.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevDocumentEliminator = class(Tk2TagFilter)
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevDocumentEliminator

implementation

uses
 l3ImplUses
 , Document_Const
;

function TevDocumentEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4E2836190160_var*
//#UC END# *4CA3006302BC_4E2836190160_var*
begin
//#UC START# *4CA3006302BC_4E2836190160_impl*
 Result := not CurrentType.IsKindOf(k2_typDocument);
//#UC END# *4CA3006302BC_4E2836190160_impl*
end;//TevDocumentEliminator.NeedTranslateChildToNext

end.
