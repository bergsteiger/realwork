unit F1_Without_Usecases_DocumentsCacheOperations_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/F1_Without_Usecases_DocumentsCacheOperations_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::DocumentsCacheOperations
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

(* DocumentsCache = operations
   ['{EB218A51-86E0-4545-852F-B89B0EEF7952}']
   query Clear;
     {* Очистить кэш документов }
   operation Disable; has states;
     {* Запретить кэш документов }
      Disable = state
      end;//Disable
      Enable = state
      end;//Enable
 end;//DocumentsCache*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_DocumentsCache = 'DocumentsCache';
 en_capDocumentsCache = '';
 op_Clear = 'Clear';
 op_capClear = 'Очистить кэш документов';
 op_Disable = 'Disable';
 op_capDisable = 'Запретить кэш документов';

// Состояния операций:
var st_user_DocumentsCache_Disable_Disable : TvcmOperationStateIndex = (rID : -1);
  // DocumentsCache -> Запретить кэш документов <-> Disable
var st_user_DocumentsCache_Disable_Enable : TvcmOperationStateIndex = (rID : -1);
  // DocumentsCache -> Запретить кэш документов <-> Enable
{$IfEnd} //not Admin AND not Monitorings

implementation

end.