unit evStrictContentsElementEliminator;
 {* Фильтр, удаляющий "элементы оглавления" (k2_idContentsElement). Но не блоки, и никаких других наследников }

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evStrictContentsElementEliminator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevStrictContentsElementEliminator = class(Tk2TagFilter)
  {* Фильтр, удаляющий "элементы оглавления" (k2_idContentsElement). Но не блоки, и никаких других наследников }
  protected
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevStrictContentsElementEliminator

implementation

uses
 l3ImplUses
 , ContentsElement_Const
;

function TevStrictContentsElementEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4CA2FFC10275_var*
//#UC END# *4CA3006302BC_4CA2FFC10275_var*
begin
//#UC START# *4CA3006302BC_4CA2FFC10275_impl*
 Result := (CurrentType.ID <> k2_idContentsElement);
//#UC END# *4CA3006302BC_4CA2FFC10275_impl*
end;//TevStrictContentsElementEliminator.NeedTranslateChildToNext

end.
