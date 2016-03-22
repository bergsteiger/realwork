unit vcmMenuForChromeLikeItemWrap;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmMenuForChromeLikeItemWrap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmMenuForChromeLikeItemWrap" MUID: (5477971800CE)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , Classes
 {$If NOT Defined(NoVGScene)}
 , vcmMainMenuForChromeLikeTypes
 {$IfEnd} // NOT Defined(NoVGScene)
 , RectWrap
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 //#UC START# *5477971800CEci*
 //#UC END# *5477971800CEci*
 //#UC START# *5477971800CEcit*
 //#UC END# *5477971800CEcit*
 TvcmMenuForChromeLikeItemWrap = class(TPersistent)
  private
   f_Item: TvcmMenuForChromeLikeItem;
  protected
   function pm_GetrRectStub: TRectWrap; virtual;
   function pm_GetrItemStub: TMenuItem; virtual;
  public
   constructor Create(const anItem: TvcmMenuForChromeLikeItem); reintroduce;
  public
   property rRectStub: TRectWrap
    read pm_GetrRectStub;
   property rItemStub: TMenuItem
    read pm_GetrItemStub;
 //#UC START# *5477971800CEpubl*
 published
   property rItem : TMenuItem
    read f_Item.rItem;
   property rRect : TRectWrap
    read pm_GetRRectStub;
 //#UC END# *5477971800CEpubl*
 end;//TvcmMenuForChromeLikeItemWrap
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
;

function TvcmMenuForChromeLikeItemWrap.pm_GetrRectStub: TRectWrap;
//#UC START# *5477ADBA02BC_5477971800CEget_var*
//#UC END# *5477ADBA02BC_5477971800CEget_var*
begin
//#UC START# *5477ADBA02BC_5477971800CEget_impl*
  Result := TRectWrap.Create(f_Item.rRect);
//#UC END# *5477ADBA02BC_5477971800CEget_impl*
end;//TvcmMenuForChromeLikeItemWrap.pm_GetrRectStub

function TvcmMenuForChromeLikeItemWrap.pm_GetrItemStub: TMenuItem;
//#UC START# *5478712A0083_5477971800CEget_var*
//#UC END# *5478712A0083_5477971800CEget_var*
begin
//#UC START# *5478712A0083_5477971800CEget_impl*
  Result := f_Item.rItem;
//#UC END# *5478712A0083_5477971800CEget_impl*
end;//TvcmMenuForChromeLikeItemWrap.pm_GetrItemStub

constructor TvcmMenuForChromeLikeItemWrap.Create(const anItem: TvcmMenuForChromeLikeItem);
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
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
