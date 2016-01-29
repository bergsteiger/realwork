unit Base_Operations_View_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_View_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::View
//
// Операции влияющие на визальное представление объектов системы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vcmExternalInterfaces {a}
  ;

(* Document = operations
  {* Документ }
   ['{2A657798-A7B2-4ED4-8520-D5E05BBADA44}']
   operation ShowJurorComments; has states;
     {* Показать/скрыть комментарии ГАРАНТа }
      Hide = state
       { Скрыть комментарии ГАРАНТа }
      end;//Hide
      Show = state
       { Показать комментарии ГАРАНТа }
      end;//Show
   operation ShowUserComments; has states;
     {* Показать/скрыть мои комментарии }
      Hide = state
       { Скрыть мои комментарии }
      end;//Hide
      Show = state
       { Показать мои комментарии }
      end;//Show
   operation ShowTechComments; has states;
     {* Показывать технические комментарии }
      Hide = state
      end;//Hide
      Show = state
      end;//Show
   operation ShowVersionComments; has states;
     {* Включить/выключить информацию об изменениях документа }
      Hide = state
       { Выключить информацию об изменениях документа }
      end;//Hide
      Show = state
       { Включить информацию об изменениях документа }
      end;//Show
   operation ShowJurorComments; has states;
     {* Показать юридические комментарии }
   operation ShowUserComments; has states;
     {* Показать комментарии пользователя }
   operation ShowVersionComments; has states;
     {* Показать информацию о версии }
   operation ShowCommentsGroup;
     {* Комментарии }
   operation ShowTechComments; has states;
     {* Показать технические комментарии }
 end;//Document*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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

// Состояния операций:
var st_user_Document_ShowJurorComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Показать/скрыть комментарии ГАРАНТа <-> Скрыть комментарии ГАРАНТа
var st_user_Document_ShowJurorComments_Show : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Показать/скрыть комментарии ГАРАНТа <-> Показать комментарии ГАРАНТа
var st_user_Document_ShowUserComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Показать/скрыть мои комментарии <-> Скрыть мои комментарии
var st_user_Document_ShowUserComments_Show : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Показать/скрыть мои комментарии <-> Показать мои комментарии
var st_user_Document_ShowTechComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Показывать технические комментарии <-> Hide
var st_user_Document_ShowTechComments_Show : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Показывать технические комментарии <-> Show
var st_user_Document_ShowVersionComments_Hide : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Включить/выключить информацию об изменениях документа <-> Выключить информацию об изменениях документа
var st_user_Document_ShowVersionComments_Show : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Включить/выключить информацию об изменениях документа <-> Включить информацию об изменениях документа
{$IfEnd} //not Admin AND not Monitorings

implementation

end.