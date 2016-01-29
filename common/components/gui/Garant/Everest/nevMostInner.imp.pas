{$IfNDef nevMostInner_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevMostInner.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevMostInner
//
// Самая внутренняя точка объекта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevMostInner_imp}
{$If defined(evUseVisibleCursors)}
 _nevMostInner_ = {mixin} class(_nevMostInner_Parent_)
  {* Самая внутренняя точка объекта }
 protected
 // realized methods
   function pm_GetMostInner: InevBasePoint;
 end;//_nevMostInner_
{$Else}

 _nevMostInner_ = _nevMostInner_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevMostInner_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevMostInner_

function _nevMostInner_.pm_GetMostInner: InevBasePoint;
//#UC START# *49DE123A031F_49DE14FB022Bget_var*
//#UC END# *49DE123A031F_49DE14FB022Bget_var*
begin
//#UC START# *49DE123A031F_49DE14FB022Bget_impl*
 Result := _Instance_R_(Self);
 while Result.HasInner do
  Result := Result.Inner;
//#UC END# *49DE123A031F_49DE14FB022Bget_impl*
end;//_nevMostInner_.pm_GetMostInner

{$IfEnd} //evUseVisibleCursors

{$EndIf nevMostInner_imp}
