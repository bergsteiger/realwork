unit msmChangePropertiesBinding;

// Модуль: "w:\common\components\gui\Garant\msm\msmChangePropertiesBinding.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmChangePropertiesBinding" MUID: (5804D4CC00E3)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListController
 , msmModelElementSelectService
 , msmEvents
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmModelElements
;

type
 TmsmChangePropertiesBinding = class(TmsmListController, ImsmElementSelector)
  protected
   procedure DoActionElementEvent(anEvent: TmsmEvent);
   procedure SelectElement(const anElementName: AnsiString;
    const anElementStereotype: ImsmModelElement;
    const aKeyValues: ItfwArray);
   function SelectFormCaption: AnsiString;
   function KeyValues: ItfwArray;
   procedure LinkEventHandlers; override;
 end;//TmsmChangePropertiesBinding

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 //#UC START# *5804D4CC00E3impl_uses*
 //#UC END# *5804D4CC00E3impl_uses*
;

procedure TmsmChangePropertiesBinding.DoActionElementEvent(anEvent: TmsmEvent);
//#UC START# *5804D4CC00E3_57B2B0C602DF_5804D4CC00E3_var*
//#UC END# *5804D4CC00E3_57B2B0C602DF_5804D4CC00E3_var*
begin
//#UC START# *5804D4CC00E3_57B2B0C602DF_5804D4CC00E3_impl*
 TmsmModelElementSelectService.Instance.SelectElement(Self);
//#UC END# *5804D4CC00E3_57B2B0C602DF_5804D4CC00E3_impl*
end;//TmsmChangePropertiesBinding.DoActionElementEvent

procedure TmsmChangePropertiesBinding.SelectElement(const anElementName: AnsiString;
 const anElementStereotype: ImsmModelElement;
 const aKeyValues: ItfwArray);
//#UC START# *57F509AC007F_5804D4CC00E3_var*
//#UC END# *57F509AC007F_5804D4CC00E3_var*
begin
//#UC START# *57F509AC007F_5804D4CC00E3_impl*
 Model.ChangeProperties(aKeyValues);
//#UC END# *57F509AC007F_5804D4CC00E3_impl*
end;//TmsmChangePropertiesBinding.SelectElement

function TmsmChangePropertiesBinding.SelectFormCaption: AnsiString;
//#UC START# *57FB8665023E_5804D4CC00E3_var*
//#UC END# *57FB8665023E_5804D4CC00E3_var*
begin
//#UC START# *57FB8665023E_5804D4CC00E3_impl*
 Result := 'Properties';
//#UC END# *57FB8665023E_5804D4CC00E3_impl*
end;//TmsmChangePropertiesBinding.SelectFormCaption

function TmsmChangePropertiesBinding.KeyValues: ItfwArray;
//#UC START# *57FB86B0027E_5804D4CC00E3_var*
//#UC END# *57FB86B0027E_5804D4CC00E3_var*
begin
//#UC START# *57FB86B0027E_5804D4CC00E3_impl*
 Result := Model.Properties;
//#UC END# *57FB86B0027E_5804D4CC00E3_impl*
end;//TmsmChangePropertiesBinding.KeyValues

procedure TmsmChangePropertiesBinding.LinkEventHandlers;
begin
 inherited;
 Self.LinkEventHandler(ActionElementEvent.Instance, DoActionElementEvent);
end;//TmsmChangePropertiesBinding.LinkEventHandlers

end.
