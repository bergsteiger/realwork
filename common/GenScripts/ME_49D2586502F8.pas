{$IfNDef nevParentPointFactoryExVOID_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevParentPointFactoryExVOID.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevParentPointFactoryExVOID" MUID: (49D2586502F8)
// Имя типа: "_nevParentPointFactoryExVOID_"

{$Define nevParentPointFactoryExVOID_imp}

{$If Defined(evUseVisibleCursors)}
 _nevParentPointFactoryExVOID_ = class(_nevParentPointFactoryExVOID_Parent_)
  {* Абстрактная реализация MnevParentPointFactoryEx }
  public
   function PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
   function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//_nevParentPointFactoryExVOID_

{$Else Defined(evUseVisibleCursors)}

_nevParentPointFactoryExVOID_ = _nevParentPointFactoryExVOID_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevParentPointFactoryExVOID_imp}

{$IfNDef nevParentPointFactoryExVOID_imp_impl}

{$Define nevParentPointFactoryExVOID_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevParentPointFactoryExVOID_.PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
//#UC START# *49D243600057_49D2586502F8_var*
//#UC END# *49D243600057_49D2586502F8_var*
begin
//#UC START# *49D243600057_49D2586502F8_impl*
 Result := nil;
 Assert(false);
//#UC END# *49D243600057_49D2586502F8_impl*
end;//_nevParentPointFactoryExVOID_.PointToParentByLevel

function _nevParentPointFactoryExVOID_.PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
//#UC START# *49D2437302B2_49D2586502F8_var*
//#UC END# *49D2437302B2_49D2586502F8_var*
begin
//#UC START# *49D2437302B2_49D2586502F8_impl*
 Result := nil;
 Assert(false);
//#UC END# *49D2437302B2_49D2586502F8_impl*
end;//_nevParentPointFactoryExVOID_.PointToTypedParent
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevParentPointFactoryExVOID_imp_impl}

{$EndIf nevParentPointFactoryExVOID_imp}

