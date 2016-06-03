unit Document_F1Lite_Controls;
 {* Урезанные "сущности" для таких форм как документ-схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_F1Lite_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "F1Lite" MUID: (49885BF10395)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Edit = 'Edit';
 en_capEdit = 'Правка';
 op_ToggleFoundWords = 'ToggleFoundWords';
 op_capToggleFoundWords = 'Подсвечивать найденный контекст';
 en_Text = 'Text';
 en_capText = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = 'Поставить на контроль';
 en_Selection = 'Selection';
 en_capSelection = '';
 op_ShowCorrespondentListToPart = 'ShowCorrespondentListToPart';
 op_capShowCorrespondentListToPart = '';
 op_ShowRespondentListToPart = 'ShowRespondentListToPart';
 op_capShowRespondentListToPart = '';

var st_user_Text_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {*  -> Поставить на контроль <-> Снять с контроля }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
