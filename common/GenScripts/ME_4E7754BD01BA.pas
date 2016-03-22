unit evDocumentSubsChildrenCountEliminator;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evDocumentSubsChildrenCountEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDocumentSubsChildrenCountEliminator" MUID: (4E7754BD01BA)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevDocumentSubsChildrenCountEliminator = class(Tk2TagFilter)
  protected
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevDocumentSubsChildrenCountEliminator

implementation

uses
 l3ImplUses
 , Document_Const
 , k2Tags
;

procedure TevDocumentSubsChildrenCountEliminator.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4E7754BD01BA_var*
//#UC END# *4A2D1634025B_4E7754BD01BA_var*
begin
//#UC START# *4A2D1634025B_4E7754BD01BA_impl*
 if (AtomIndex = k2_tiChildren) then
  if CurrentType.IsKindOf(k2_typDocument_Subs) then
   Exit;
 inherited;
//#UC END# *4A2D1634025B_4E7754BD01BA_impl*
end;//TevDocumentSubsChildrenCountEliminator.DoAddAtomEx

end.
