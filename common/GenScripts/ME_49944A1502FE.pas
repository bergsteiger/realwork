unit vcmInternalConst;
 {* Внутренние константы }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmInternalConst.pas"
// Стереотип: "Interfaces"
// Элемент модели: "vcmInternalConst" MUID: (49944A1502FE)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmUserControls
 , vcmBaseTypes
;

const
 {* Идентификаторы форм }
 fm_Any: TvcmFormID = (rName : ''; rID : 0);

const
 vcmToolbarOpTypes = [vcm_otButton, vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup, vcm_otTextButton, vcm_otCheck, vcm_otRadio, vcm_otEdit, vcm_otTyper, vcm_otCombo, vcm_otEditCombo, vcm_otDate];
 vcm_AllOperationOptions = [Low(TvcmOperationOption) .. High(TvcmOperationOption)];
 vcm_ComboOperations = [vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup];
 vcm_ComboBoxOperations = [vcm_otCombo, vcm_otEditCombo];
 {* Типы операций, у которых, при создании пункта меню, Caption нужно брать
     из операции, а не Action. При открытии в новом окне, Action.Caption
     может содержать текущее выбранное значение (например, для операции
     "Сортировать" и Caption может содержать значения "по юр. силе; дате
     издания и т.д."), поэтому название нужно брать из операции }
 vcm_UseCaptionFromOperation = [vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup, vcm_otCombo];
 vcmOperationsWithIcon = [vcm_otButton, vcm_otCheck, vcm_otTextButton, vcm_otButtonPopup];
 vcm_InternalOperations = [vcm_otInternal];
 vcm_HiddenOperations = [vcm_otHidden];
 vcm_SimpleOperations = [vcm_otEdit, vcm_otTyper, vcm_otFontName, vcm_otFontSize, vcm_otDate];
 vcmVisualOperations = [vcm_otButton, vcm_otCheck, vcm_otMenuButtonCombo, vcm_otButtonCombo, vcm_otTextButton, vcm_otCombo, vcm_otTyper, vcm_otEditCombo, vcm_otEdit, vcm_otDate, vcm_otButtonPopup];
 vcm_NotContainedForm = [vcm_ztFloating, vcm_ztModal, vcm_ztManualModal, vcm_ztSimpleFloat];
 vcm_omExecutes = [vcm_omExecute, vcm_omAggregateExecute];
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
