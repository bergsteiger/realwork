{$IfNDef nevParentPointFactory_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevParentPointFactory.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevParentPointFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParentPointFactory_imp}
{$If defined(evUseVisibleCursors)}
 _nevParentPointFactory_ = {mixin} class(_nevParentPointFactory_Parent_)
 protected
 // realized methods
   function pm_GetTopParentPoint: InevBasePoint;
 public
 // realized methods
   function PointToParent(const aThisTarget: InevObjectPrim = nil;
     aNeedShowCollapsed: Boolean = false): InevBasePoint;
 end;//_nevParentPointFactory_
{$Else}

 _nevParentPointFactory_ = _nevParentPointFactory_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevParentPointFactory_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevParentPointFactory_

function _nevParentPointFactory_.PointToParent(const aThisTarget: InevObjectPrim = nil;
  aNeedShowCollapsed: Boolean = false): InevBasePoint;
//#UC START# *49D218B9032C_49D251E600DA_var*
var
 l_ParentCursor  : InevBasePoint;
 l_CursorTarget  : InevObject;
 l_ThisTarget    : Tl3Tag;
//#UC END# *49D218B9032C_49D251E600DA_var*
begin
//#UC START# *49D218B9032C_49D251E600DA_impl*
 Result := _Instance_R_(Self);
 l_CursorTarget := _Instance_R_(Self).ParaX;
 if (aThisTarget = nil) OR aThisTarget.AsObject.IsNull then
  l_ThisTarget := l_CursorTarget.OwnerObj.AsObject
 else
  l_ThisTarget := aThisTarget.AsObject;
 while not l_CursorTarget.AsObject.IsSame(l_ThisTarget) do
 begin
  {-курсор нижнего уровня}
  l_ParentCursor := nil;
  try
   l_ParentCursor := Result.ParentPoint;
   if (l_ParentCursor = nil) OR not l_ParentCursor.Obj.AsObject.IsValid then
   begin
    l_ParentCursor := l_CursorTarget.OwnerObj.MakePoint;
    if (l_ParentCursor = nil) then
    begin
     Result := nil;
     break;
    end;//l_ParentCursor = nil
    l_ParentCursor.ShowCollapsed := aNeedShowCollapsed;
    l_ParentCursor.Inner := Result;
    // -  поднимаемся на уровень вверх.
   end;//l_ParentCursor = nil
   Result := l_ParentCursor;
   l_CursorTarget := Result.Obj^;
  finally
   l_ParentCursor := nil;
  end;//try..finally
 end;//while not CursorTarget.IsSame(l_ThisTarget)
//#UC END# *49D218B9032C_49D251E600DA_impl*
end;//_nevParentPointFactory_.PointToParent

function _nevParentPointFactory_.pm_GetTopParentPoint: InevBasePoint;
//#UC START# *49D24386014E_49D251E600DAget_var*
//#UC END# *49D24386014E_49D251E600DAget_var*
begin
//#UC START# *49D24386014E_49D251E600DAget_impl*
 Result := _Instance_R_(Self);
 while (Result.ParentPoint <> nil) do
  Result := Result.ParentPoint;
//#UC END# *49D24386014E_49D251E600DAget_impl*
end;//_nevParentPointFactory_.pm_GetTopParentPoint

{$IfEnd} //evUseVisibleCursors

{$EndIf nevParentPointFactory_imp}
