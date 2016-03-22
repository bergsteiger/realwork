unit evdHypelinkDocIDEliminator;
 {* Обнуляет DocID у ссылок. Создан для тестов. }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdHypelinkDocIDEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdHypelinkDocIDEliminator" MUID: (4F33BAE302FA)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdHypelinkDocIDEliminator = class(Tk2TagFilter)
  {* Обнуляет DocID у ссылок. Создан для тестов. }
  protected
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdHypelinkDocIDEliminator

implementation

uses
 l3ImplUses
 , k2Tags
 , Address_Const
;

procedure TevdHypelinkDocIDEliminator.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4F33BAE302FA_var*
//#UC END# *4A2D1634025B_4F33BAE302FA_var*
begin
//#UC START# *4A2D1634025B_4F33BAE302FA_impl*
 if AtomIndex = k2_tiInternalHandle then Exit;
 if CurrentType.IsKindOf(k2_typAddress) and (AtomIndex = k2_tiDocID) then
  Exit;
 inherited;
//#UC END# *4A2D1634025B_4F33BAE302FA_impl*
end;//TevdHypelinkDocIDEliminator.DoAddAtomEx

end.
