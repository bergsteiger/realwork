{$IfNDef nevParaXTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevParaXTool.imp.pas"
// Начат: 04.04.2005 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevParaXTool
//
// Инструмент для параграфа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevParaXTool_imp}
 _nevParaXTool_ = {mixin} class(_nevParaXTool_Parent_)
  {* Инструмент для параграфа }
 private
 // private fields
   f_ParaX : _X_;
    {* Поле для свойства ParaX}
 protected
 // overridden protected methods
   procedure ClearTagCache; override;
 public
 // overridden public methods
   procedure SetTagQT(aTag: Tl3Variant); override;
 protected
 // protected properties
   property ParaX: _X_
     read f_ParaX
     write f_ParaX;
 end;//_nevParaXTool_

{$Else nevParaXTool_imp}

// start class _nevParaXTool_

procedure _nevParaXTool_.ClearTagCache;
//#UC START# *48CE74A10014_480F48F301B9_var*
//#UC END# *48CE74A10014_480F48F301B9_var*
begin
//#UC START# *48CE74A10014_480F48F301B9_impl*
 f_ParaX := nil;
 inherited;
//#UC END# *48CE74A10014_480F48F301B9_impl*
end;//_nevParaXTool_.ClearTagCache

procedure _nevParaXTool_.SetTagQT(aTag: Tl3Variant);
//#UC START# *49E75FA4010C_480F48F301B9_var*
//#UC END# *49E75FA4010C_480F48F301B9_var*
begin
//#UC START# *49E75FA4010C_480F48F301B9_impl*
 inherited;
 if (f_ParaX = nil) then
 begin
  if (aTag <> nil) AND aTag.IsValid then
   if not aTag.QT(_X_, f_ParaX) then
    Assert(false, Format('Не поддерживается интерфейс %s [%s]',
                         [GUIDToString(_X_),  ClassName]));
 end//f_ParaX = nil
 else
  Assert(f_ParaX.AsObject.IsSame(aTag));
//#UC END# *49E75FA4010C_480F48F301B9_impl*
end;//_nevParaXTool_.SetTagQT

{$EndIf nevParaXTool_imp}
