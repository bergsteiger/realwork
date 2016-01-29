unit vcmUserTypesCollectionItemPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Components/vcmUserTypesCollectionItemPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::UserTypes::TvcmUserTypesCollectionItemPrim
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
  vcmBaseCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmUserTypesCollectionItemPrim = class(TvcmBaseCollectionItem)
 private
 // private fields
   f_CanHaveToolbars : Boolean;
    {* Поле для свойства CanHaveToolbars}
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public properties
   property CanHaveToolbars: Boolean
     read f_CanHaveToolbars
     write f_CanHaveToolbars;
 end;//TvcmUserTypesCollectionItemPrim
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmUserTypesCollectionItemPrim

procedure TvcmUserTypesCollectionItemPrim.InitFields;
//#UC START# *47A042E100E2_5006A4A6003D_var*
//#UC END# *47A042E100E2_5006A4A6003D_var*
begin
//#UC START# *47A042E100E2_5006A4A6003D_impl*
 inherited;
 f_CanHaveToolbars := true;
//#UC END# *47A042E100E2_5006A4A6003D_impl*
end;//TvcmUserTypesCollectionItemPrim.InitFields

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmUserTypesCollectionItemPrim
 TtfwClassRef.Register(TvcmUserTypesCollectionItemPrim);
{$IfEnd} //not NoScripts AND not NoVCM

end.