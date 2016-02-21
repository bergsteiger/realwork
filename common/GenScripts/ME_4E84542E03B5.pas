unit evdChildrenCountEliminator;
 {* Выкидавает ChildrenCount из потока генерации, чтобы не распределялась лишняя память при буферизации на проходе }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdChildrenCountEliminator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdChildrenCountEliminator = class(Tk2TagFilter)
  {* Выкидавает ChildrenCount из потока генерации, чтобы не распределялась лишняя память при буферизации на проходе }
  protected
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdChildrenCountEliminator

implementation

uses
 l3ImplUses
 , k2Tags
;

procedure TevdChildrenCountEliminator.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4E84542E03B5_var*
//#UC END# *4A2D1634025B_4E84542E03B5_var*
begin
//#UC START# *4A2D1634025B_4E84542E03B5_impl*
 if (AtomIndex = k2_tiChildren) then
  Exit;
 inherited;
//#UC END# *4A2D1634025B_4E84542E03B5_impl*
end;//TevdChildrenCountEliminator.DoAddAtomEx

end.
