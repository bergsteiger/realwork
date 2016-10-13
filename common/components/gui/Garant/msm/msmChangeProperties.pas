unit msmChangeProperties;

// Модуль: "w:\common\components\gui\Garant\msm\msmChangeProperties.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmChangeProperties" MUID: (57FC269F03B2)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListLikeOperation
 , msmModelElementSelectService
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , msmModelElements
 , msmOperations
;

type
 TmsmChangeProperties = class(TmsmListLikeOperation, ImsmElementSelector)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure SelectElement(const anElementName: AnsiString;
    const anElementStereotype: ImsmModelElement;
    const aKeyValues: ItfwArray);
   function SelectFormCaption: AnsiString;
   function KeyValues: ItfwArray;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmChangeProperties

implementation

uses
 l3ImplUses
 //#UC START# *57FC269F03B2impl_uses*
 //#UC END# *57FC269F03B2impl_uses*
;

procedure TmsmChangeProperties.DoDoIt;
//#UC START# *57CEB1F602D1_57FC269F03B2_var*
//#UC END# *57CEB1F602D1_57FC269F03B2_var*
begin
//#UC START# *57CEB1F602D1_57FC269F03B2_impl*
 TmsmModelElementSelectService.Instance.SelectElement(Self);
//#UC END# *57CEB1F602D1_57FC269F03B2_impl*
end;//TmsmChangeProperties.DoDoIt

function TmsmChangeProperties.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57FC269F03B2_var*
//#UC END# *57EB6D020381_57FC269F03B2_var*
begin
//#UC START# *57EB6D020381_57FC269F03B2_impl*
 Result := Model.CanChangeProperties;
//#UC END# *57EB6D020381_57FC269F03B2_impl*
end;//TmsmChangeProperties.GetEnabled

procedure TmsmChangeProperties.SelectElement(const anElementName: AnsiString;
 const anElementStereotype: ImsmModelElement;
 const aKeyValues: ItfwArray);
//#UC START# *57F509AC007F_57FC269F03B2_var*
//#UC END# *57F509AC007F_57FC269F03B2_var*
begin
//#UC START# *57F509AC007F_57FC269F03B2_impl*
 Model.ChangeProperties(aKeyValues);
//#UC END# *57F509AC007F_57FC269F03B2_impl*
end;//TmsmChangeProperties.SelectElement

function TmsmChangeProperties.SelectFormCaption: AnsiString;
//#UC START# *57FB8665023E_57FC269F03B2_var*
//#UC END# *57FB8665023E_57FC269F03B2_var*
begin
//#UC START# *57FB8665023E_57FC269F03B2_impl*
 Result := 'Properties';
//#UC END# *57FB8665023E_57FC269F03B2_impl*
end;//TmsmChangeProperties.SelectFormCaption

function TmsmChangeProperties.KeyValues: ItfwArray;
//#UC START# *57FB86B0027E_57FC269F03B2_var*
//#UC END# *57FB86B0027E_57FC269F03B2_var*
begin
//#UC START# *57FB86B0027E_57FC269F03B2_impl*
 Result := Model.Properties;
//#UC END# *57FB86B0027E_57FC269F03B2_impl*
end;//TmsmChangeProperties.KeyValues

procedure TmsmChangeProperties.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57FC269F03B2_var*
//#UC END# *57EBADA9033E_57FC269F03B2_var*
begin
//#UC START# *57EBADA9033E_57FC269F03B2_impl*
 inherited;
//#UC END# *57EBADA9033E_57FC269F03B2_impl*
end;//TmsmChangeProperties.InitOperationParams

end.
