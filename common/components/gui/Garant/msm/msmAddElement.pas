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
 , msmModelElements
 , msmOperations
;

type
 TmsmAddElement = class(TmsmListLikeOperation, ImsmElementSelector)
  protected
   procedure DoDoIt; override;
   function GetEnabled: Boolean; override;
   procedure SelectElement(const anElementName: AnsiString;
    const anElementStereotype: ImsmModelElement);
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
var
 l_AllowedElements : ImsmListModel;
 l_ListContext : TmsmListViewtInitContext;
//#UC END# *57CEB1F602D1_57F50186039F_var*
begin
//#UC START# *57CEB1F602D1_57F50186039F_impl*
 l_AllowedElements := TmsmListModel.MakeList(TmsmModelElementView_C(Model.List.Owner, 'AllowedElements'));
 l_ListContext := TmsmListViewtInitContext_C;
 l_ListContext.rImageNameProp := 'msm:View:StereotypeImageFileName';
 TmsmModelElementSelectService.Instance.SelectElement(l_AllowedElements, l_ListContext, Self);
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
 const anElementStereotype: ImsmModelElement);
//#UC START# *57F509AC007F_57F50186039F_var*
//#UC END# *57F509AC007F_57F50186039F_var*
begin
//#UC START# *57F509AC007F_57F50186039F_impl*
 Model.AddNewElement(anElementName, anElementStereotype);
//#UC END# *57F509AC007F_57F50186039F_impl*
end;//TmsmAddElement.SelectElement

procedure TmsmAddElement.InitOperationParams(var theParams: TmsmOperationParams);
//#UC START# *57EBADA9033E_57F50186039F_var*
//#UC END# *57EBADA9033E_57F50186039F_var*
begin
//#UC START# *57EBADA9033E_57F50186039F_impl*
 inherited;
//#UC END# *57EBADA9033E_57F50186039F_impl*
end;//TmsmAddElement.InitOperationParams

end.
