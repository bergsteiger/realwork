unit msmAddElement;

// Модуль: "w:\common\components\gui\Garant\msm\msmAddElement.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmAddElement" MUID: (57F50186039F)

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
 TmsmAddElement = class(TmsmListLikeOperation, ImsmElementSelector)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure SelectElement(const anElementName: AnsiString;
    const anElementStereotype: ImsmModelElement;
    const aKeyValues: ItfwArray);
   function SelectFormCaption: AnsiString;
   function KeyValues: ItfwArray;
   procedure InitOperationParams(var theParams: TmsmOperationParams); override;
 end;//TmsmAddElement

implementation

uses
 l3ImplUses
 //#UC START# *57F50186039Fimpl_uses*
 , msmConcreteModels
 , msmListAndTreeViewUtils
 , msmListModel
 , msmElementViews
 //#UC END# *57F50186039Fimpl_uses*
;

procedure TmsmAddElement.DoDoIt;
//#UC START# *57CEB1F602D1_57F50186039F_var*
//#UC END# *57CEB1F602D1_57F50186039F_var*
begin
//#UC START# *57CEB1F602D1_57F50186039F_impl*
 TmsmModelElementSelectService.Instance.SelectElement(Self);
//#UC END# *57CEB1F602D1_57F50186039F_impl*
end;//TmsmAddElement.DoDoIt

function TmsmAddElement.GetEnabled: Boolean;
//#UC START# *57EB6D020381_57F50186039F_var*
//#UC END# *57EB6D020381_57F50186039F_var*
begin
//#UC START# *57EB6D020381_57F50186039F_impl*
 Result := Model.CanAddNewElement;
//#UC END# *57EB6D020381_57F50186039F_impl*
end;//TmsmAddElement.GetEnabled

procedure TmsmAddElement.SelectElement(const anElementName: AnsiString;
 const anElementStereotype: ImsmModelElement;
 const aKeyValues: ItfwArray);
//#UC START# *57F509AC007F_57F50186039F_var*
//#UC END# *57F509AC007F_57F50186039F_var*
begin
//#UC START# *57F509AC007F_57F50186039F_impl*
 Model.AddNewElement(anElementName, anElementStereotype, aKeyValues);
//#UC END# *57F509AC007F_57F50186039F_impl*
end;//TmsmAddElement.SelectElement

function TmsmAddElement.SelectFormCaption: AnsiString;
//#UC START# *57FB8665023E_57F50186039F_var*
//#UC END# *57FB8665023E_57F50186039F_var*
begin
//#UC START# *57FB8665023E_57F50186039F_impl*
 Result := 'New element';
//#UC END# *57FB8665023E_57F50186039F_impl*
end;//TmsmAddElement.SelectFormCaption

function TmsmAddElement.KeyValues: ItfwArray;
//#UC START# *57FB86B0027E_57F50186039F_var*
//#UC END# *57FB86B0027E_57F50186039F_var*
begin
//#UC START# *57FB86B0027E_57F50186039F_impl*
 Result := Model.PropertiesForNewElement;
//#UC END# *57FB86B0027E_57F50186039F_impl*
end;//TmsmAddElement.KeyValues

procedure TmsmAddElement.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57F50186039F_var*
//#UC END# *57EBADA9033E_57F50186039F_var*
begin
//#UC START# *57EBADA9033E_57F50186039F_impl*
 inherited;
//#UC END# *57EBADA9033E_57F50186039F_impl*
end;//TmsmAddElement.InitOperationParams

end.
