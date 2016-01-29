unit vcmPrimCollectionItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Components/vcmPrimCollectionItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Collections::TvcmPrimCollectionItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  Classes,
  l3PureMixIns
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
 {$Define _UnknownNeedsQI}

type

{$If not defined(NoVCM) AND not defined(vcmNeedL3)}
 {$Define _UnknownNotNeedL3}
{$IfEnd} //not NoVCM AND not vcmNeedL3

 _l3Unknown_Parent_ = TCollectionItem;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmPrimCollectionItem = class(_l3Unknown_)
 protected
 // property methods
   function pm_GetDispatcher: IvcmDispatcher;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public properties
   property Dispatcher: IvcmDispatcher
     read pm_GetDispatcher;
 end;//TvcmPrimCollectionItem
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmBase
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvcmPrimCollectionItem

function TvcmPrimCollectionItem.pm_GetDispatcher: IvcmDispatcher;
//#UC START# *55CCAB2C0353_4FFC335A011Fget_var*
//#UC END# *55CCAB2C0353_4FFC335A011Fget_var*
begin
//#UC START# *55CCAB2C0353_4FFC335A011Fget_impl*
 {$If Declared(vcmDispatcher)}
 Result := vcmDispatcher;
 {$Else}
 Result := nil;
 {$IfEnd}
//#UC END# *55CCAB2C0353_4FFC335A011Fget_impl*
end;//TvcmPrimCollectionItem.pm_GetDispatcher

{$If not defined(DesignTimeLibrary)}
class function TvcmPrimCollectionItem.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4FFC335A011F_var*
//#UC END# *47A6FEE600FC_4FFC335A011F_var*
begin
//#UC START# *47A6FEE600FC_4FFC335A011F_impl*
 Result := True;
//#UC END# *47A6FEE600FC_4FFC335A011F_impl*
end;//TvcmPrimCollectionItem.IsCacheable
{$IfEnd} //not DesignTimeLibrary

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmPrimCollectionItem
 TtfwClassRef.Register(TvcmPrimCollectionItem);
{$IfEnd} //not NoScripts AND not NoVCM

end.