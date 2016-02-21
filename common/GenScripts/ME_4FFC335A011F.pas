unit vcmPrimCollectionItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmPrimCollectionItem.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 , vcmInterfaces
 , l3PureMixIns
;

 {$Define _UnknownNeedsQI}

 {$If NOT Defined(vcmNeedL3)}
 {$Define _UnknownNotNeedL3}
 {$IfEnd} // NOT Defined(vcmNeedL3)

type
 _l3Unknown_Parent_ = TCollectionItem;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmPrimCollectionItem = class(_l3Unknown_)
  protected
   function pm_GetDispatcher: IvcmDispatcher;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   property Dispatcher: IvcmDispatcher
    read pm_GetDispatcher;
 end;//TvcmPrimCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBase
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

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

{$If NOT Defined(DesignTimeLibrary)}
class function TvcmPrimCollectionItem.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4FFC335A011F_var*
//#UC END# *47A6FEE600FC_4FFC335A011F_var*
begin
//#UC START# *47A6FEE600FC_4FFC335A011F_impl*
 Result := True;
//#UC END# *47A6FEE600FC_4FFC335A011F_impl*
end;//TvcmPrimCollectionItem.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmPrimCollectionItem);
 {* Регистрация TvcmPrimCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
