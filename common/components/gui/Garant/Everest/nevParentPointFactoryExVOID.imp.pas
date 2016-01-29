{$IfNDef nevParentPointFactoryExVOID_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevParentPointFactoryExVOID.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevParentPointFactoryExVOID
//
// Абстрактная реализация MnevParentPointFactoryEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParentPointFactoryExVOID_imp}
{$If defined(evUseVisibleCursors)}
 _nevParentPointFactoryExVOID_ = {mixin} class(_nevParentPointFactoryExVOID_Parent_)
  {* Абстрактная реализация MnevParentPointFactoryEx }
 public
 // realized methods
   function PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
   function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//_nevParentPointFactoryExVOID_
{$Else}

 _nevParentPointFactoryExVOID_ = _nevParentPointFactoryExVOID_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevParentPointFactoryExVOID_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevParentPointFactoryExVOID_

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

{$IfEnd} //evUseVisibleCursors

{$EndIf nevParentPointFactoryExVOID_imp}
