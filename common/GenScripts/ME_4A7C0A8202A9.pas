unit Base_Operations_View_Controls;
 {* Операции влияющие на визальное представление объектов системы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_View_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "View" MUID: (4A7C0A8202A9)

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
 en_Document = 'Document';
 en_capDocument = 'Документ';
 op_ShowJurorComments = 'ShowJurorComments';
 op_capShowJurorComments = 'Показать/скрыть комментарии ГАРАНТа';
 op_ShowUserComments = 'ShowUserComments';
 op_capShowUserComments = 'Показать/скрыть мои комментарии';
 op_ShowTechComments = 'ShowTechComments';
 op_capShowTechComments = 'Показывать технические комментарии';
 op_ShowVersionComments = 'ShowVersionComments';
 op_capShowVersionComments = 'Включить/выключить информацию об изменениях документа';
 op_ShowCommentsGroup = 'ShowCommentsGroup';
 op_capShowCommentsGroup = 'Комментарии';

var st_user_Document_ShowJurorComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Показать/скрыть комментарии ГАРАНТа <-> Скрыть комментарии ГАРАНТа }
var st_user_Document_ShowJurorComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Показать/скрыть комментарии ГАРАНТа <-> Показать комментарии ГАРАНТа }
var st_user_Document_ShowUserComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Показать/скрыть мои комментарии <-> Скрыть мои комментарии }
var st_user_Document_ShowUserComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Показать/скрыть мои комментарии <-> Показать мои комментарии }
var st_user_Document_ShowTechComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Показывать технические комментарии <->  }
var st_user_Document_ShowTechComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Показывать технические комментарии <->  }
var st_user_Document_ShowVersionComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Включить/выключить информацию об изменениях документа <-> Выключить информацию об изменениях документа }
var st_user_Document_ShowVersionComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* Документ -> Включить/выключить информацию об изменениях документа <-> Включить информацию об изменениях документа }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
