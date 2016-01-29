{$IfNDef nevTinyParaXTool_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTinyParaXTool.imp.pas"
// Начат: 16.04.2009 20:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::nevUtils::nevTinyParaXTool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevTinyParaXTool_imp}
 _nevTinyParaXTool_ = {mixin} class(Tl3ProtoObject)
 private
 // private fields
   f_ParaX : _X_;
    {* Поле для свойства ParaX}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   constructor Create(aTag: Tl3Variant); reintroduce;
 protected
 // protected properties
   property ParaX: _X_
     read f_ParaX;
 end;//_nevTinyParaXTool_

{$Else nevTinyParaXTool_imp}

// start class _nevTinyParaXTool_

constructor _nevTinyParaXTool_.Create(aTag: Tl3Variant);
//#UC START# *49E7692B0058_49E7612601CC_var*
//#UC END# *49E7692B0058_49E7612601CC_var*
begin
//#UC START# *49E7692B0058_49E7612601CC_impl*
 inherited Create;
 //if aTag.IsValid then
 // - эта идиотская проверка для Painter'ов и FontTool
  if not aTag.QT(_X_, f_ParaX) then
   Assert(false, Format('Не поддерживается интерфейс %s [%s]',
                        [GUIDToString(_X_),  ClassName]));
//#UC END# *49E7692B0058_49E7612601CC_impl*
end;//_nevTinyParaXTool_.Create

procedure _nevTinyParaXTool_.Cleanup;
//#UC START# *479731C50290_49E7612601CC_var*
//#UC END# *479731C50290_49E7612601CC_var*
begin
//#UC START# *479731C50290_49E7612601CC_impl*
 f_ParaX := nil;
 inherited;
//#UC END# *479731C50290_49E7612601CC_impl*
end;//_nevTinyParaXTool_.Cleanup

{$If not defined(DesignTimeLibrary)}
class function _nevTinyParaXTool_.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_49E7612601CC_var*
//#UC END# *47A6FEE600FC_49E7612601CC_var*
begin
//#UC START# *47A6FEE600FC_49E7612601CC_impl*
 Result := true;
//#UC END# *47A6FEE600FC_49E7612601CC_impl*
end;//_nevTinyParaXTool_.IsCacheable
{$IfEnd} //not DesignTimeLibrary

{$EndIf nevTinyParaXTool_imp}
