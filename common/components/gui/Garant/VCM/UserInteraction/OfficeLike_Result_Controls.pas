unit OfficeLike_Result_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UserInteraction"
// Модуль: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLike_Result_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::Result
//
// Результат диалога
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces {a}
  ;

(* Result = operations
  {* Результат диалога }
   ['{54EBD98C-A36C-4EFB-8242-023AB9626D17}']
   operation Cancel; has states;
     {* Отмена }
   operation Cancel;
     {* Отмена }
 end;//Result*)

(* Result = operations
  {* Результат диалога }
   ['{887D93F4-2EBD-4EED-B006-EB9EC85FBD5D}']
   operation Ok; has states;
     {* OK }
      Search = state
       { Искать }
       { Провести поиск по выбранным параметрам }
      end;//Search
      Print = state
       { Печать }
      end;//Print
      AttributesSelect = state
       { Подтвердить выбор элементов }
      end;//AttributesSelect
      ConsultationMark = state
       { Оценить }
      end;//ConsultationMark
      Analize = state
       { Построить }
      end;//Analize
   operation Ok; has states;
     {* OK }
 end;//Result*)

(* Result = operations
  {* Результат диалога }
   ['{8AEF6AF4-847D-492A-9358-0461CA633384}']
   operation Cancel; has states;
     {* Отмена }
      Close = state
       { Закрыть }
      end;//Close
   operation Cancel; has states;
     {* Отмена }
 end;//Result*)
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
const
 en_Result = 'Result';
 en_capResult = 'Результат диалога';
 op_Cancel = 'Cancel';
 op_capCancel = 'Отмена';
 op_Ok = 'Ok';
 op_capOk = 'OK';

// Состояния операций:
var st_user_Result_Ok_Search : TvcmOperationStateIndex = (rID : -1);
  // Результат диалога -> OK <-> Искать
var st_user_Result_Ok_Print : TvcmOperationStateIndex = (rID : -1);
  // Результат диалога -> OK <-> Печать
var st_user_Result_Ok_AttributesSelect : TvcmOperationStateIndex = (rID : -1);
  // Результат диалога -> OK <-> Подтвердить выбор элементов
var st_user_Result_Ok_ConsultationMark : TvcmOperationStateIndex = (rID : -1);
  // Результат диалога -> OK <-> Оценить
var st_user_Result_Ok_Analize : TvcmOperationStateIndex = (rID : -1);
  // Результат диалога -> OK <-> Построить
var st_user_Result_Cancel_Close : TvcmOperationStateIndex = (rID : -1);
  // Результат диалога -> Отмена <-> Закрыть
{$IfEnd} //not NoVCM

implementation

end.