{$IfNDef nevParentPointFactoryEx_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas"
// Стереотип: "Impurity"

{$Define nevParentPointFactoryEx_imp}

{$If Defined(evUseVisibleCursors)}
 _nevParentPointFactoryEx_ = class(_nevParentPointFactoryEx_Parent_)
  public
   function PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
   function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//_nevParentPointFactoryEx_

{$Else Defined(evUseVisibleCursors)}

_nevParentPointFactoryEx_ = _nevParentPointFactoryEx_Parent_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevParentPointFactoryEx_imp}

{$IfNDef nevParentPointFactoryEx_imp_impl}

{$Define nevParentPointFactoryEx_imp_impl}

{$If Defined(evUseVisibleCursors)}
function _nevParentPointFactoryEx_.PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
//#UC START# *49D243600057_49D25A310104_var*
var
 l_Tag : InevObject;
//#UC END# *49D243600057_49D25A310104_var*
begin
//#UC START# *49D243600057_49D25A310104_impl*
 Result := _Instance_R_(Self);
 l_Tag := _Instance_R_(Self).ParaX.OwnerObj;
 while l_Tag.AsObject.IsValid AND (aLevel >= 0) do
 begin
  Result := Result.PointToParent(l_Tag);
  l_Tag := l_Tag.OwnerObj;
  Dec(aLevel);
 end;//while l_Tag.IsValid
//#UC END# *49D243600057_49D25A310104_impl*
end;//_nevParentPointFactoryEx_.PointToParentByLevel

function _nevParentPointFactoryEx_.PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
//#UC START# *49D2437302B2_49D25A310104_var*
var
 l_Tag : InevObject;
//#UC END# *49D2437302B2_49D25A310104_var*
begin
//#UC START# *49D2437302B2_49D25A310104_impl*
 Result := nil;
 l_Tag := _Instance_R_(Self).ParaX;
 while l_Tag.AsObject.IsValid do
 begin
  if l_Tag.AsObject.IsKindOf(aParentType) then
  begin
   Result := PointToParent(l_Tag);
   break;
  end;//l_Parent.IsKindOf(aParentType)
  l_Tag := l_Tag.OwnerObj;
 end;//while l_Tag.IsValid
//#UC END# *49D2437302B2_49D25A310104_impl*
end;//_nevParentPointFactoryEx_.PointToTypedParent
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevParentPointFactoryEx_imp_impl}

{$EndIf nevParentPointFactoryEx_imp}

