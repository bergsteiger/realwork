unit vcmMenuForChromeLikeItemWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCMTest"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmMenuForChromeLikeItemWrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi TestComplete Wrappers::VCMTest::Wrap::TvcmMenuForChromeLikeItemWrap
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmMainMenuForChromeLikeTypes
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  RectWrap
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
type
//#UC START# *5477971800CEci*
 //#UC END# *5477971800CEci*
//#UC START# *5477971800CEcit*
 //#UC END# *5477971800CEcit*
 TvcmMenuForChromeLikeItemWrap = class(TPersistent)
 private
 // private fields
   f_Item : TvcmMenuForChromeLikeItem;
 protected
 // property methods
   function pm_GetRRectStub: TRectWrap; virtual;
   function pm_GetRItemStub: TMenuItem; virtual;
 public
 // public methods
   constructor Create(anItem: TvcmMenuForChromeLikeItem); reintroduce;
 public
 // public properties
   property rRectStub: TRectWrap
     read pm_GetRRectStub;
   property rItemStub: TMenuItem
     read pm_GetRItemStub;
//#UC START# *5477971800CEpubl*
 published
   property rItem : TMenuItem
    read f_Item.rItem;
   property rRect : TRectWrap
    read pm_GetRRectStub;
 //#UC END# *5477971800CEpubl*
 end;//TvcmMenuForChromeLikeItemWrap
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}

// start class TvcmMenuForChromeLikeItemWrap

function TvcmMenuForChromeLikeItemWrap.pm_GetRRectStub: TRectWrap;
//#UC START# *5477ADBA02BC_5477971800CEget_var*
//#UC END# *5477ADBA02BC_5477971800CEget_var*
begin
//#UC START# *5477ADBA02BC_5477971800CEget_impl*
  Result := TRectWrap.Create(f_Item.rRect);
//#UC END# *5477ADBA02BC_5477971800CEget_impl*
end;//TvcmMenuForChromeLikeItemWrap.pm_GetRRectStub

function TvcmMenuForChromeLikeItemWrap.pm_GetRItemStub: TMenuItem;
//#UC START# *5478712A0083_5477971800CEget_var*
//#UC END# *5478712A0083_5477971800CEget_var*
begin
//#UC START# *5478712A0083_5477971800CEget_impl*
  Result := f_Item.rItem;
//#UC END# *5478712A0083_5477971800CEget_impl*
end;//TvcmMenuForChromeLikeItemWrap.pm_GetRItemStub

constructor TvcmMenuForChromeLikeItemWrap.Create(anItem: TvcmMenuForChromeLikeItem);
//#UC START# *5477A63901A9_5477971800CE_var*
//#UC END# *5477A63901A9_5477971800CE_var*
begin
//#UC START# *5477A63901A9_5477971800CE_impl*
  inherited Create;
  f_Item := anItem;
//#UC END# *5477A63901A9_5477971800CE_impl*
end;//TvcmMenuForChromeLikeItemWrap.Create

//#UC START# *5477971800CEimpl*
//#UC END# *5477971800CEimpl*

{$IfEnd} //not NoTabs AND not NoVCM AND not XE

end.