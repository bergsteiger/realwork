unit Folders_Result_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders_Result_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Основные прецеденты::Folders::View::Result
//
// Результат диалога
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

(* Result = operations
  {* Результат диалога }
   ['{BA265A1A-E004-410C-8A4B-337F64ACE2F3}']
   operation Append;
     {* Добавить }
 end;//Result*)

(* ResultExt = operations
   ['{3C815B0A-A80C-4971-83EC-1606AD876BBA}']
   operation Ok; has states;
     {* OK }
      None = state
       { Подтвердить выбор }
      end;//None
      NewFolder = state
       { Создать папку }
      end;//NewFolder
      Edit = state
       { Сохранить отредактированные параметры }
      end;//Edit
      Load = state
       { Загрузить }
       { Загрузить выбранный элемент }
      end;//Load
      Select = state
       { Подтвердить выбор элемента }
      end;//Select
      FolderSave = state
       { Сохранить }
       { Сохранить элемент в текущую папку }
      end;//FolderSave
   operation Append; has states;
     {* Добавить }
      Bookmark = state
       { Добавить новую закладку к содержанию сохраненного ранее объекта }
      end;//Bookmark
      List = state
       { Добавить новый список к содержанию сохраненного ранее объекта }
      end;//List
      Query = state
       { Добавить новый запрос к содержанию сохраненного ранее объекта }
      end;//Query
   operation Cancel;
     {* Отмена }
 end;//ResultExt*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Result = 'Result';
 en_capResult = 'Результат диалога';
 op_Append = 'Append';
 op_capAppend = 'Добавить';
 en_ResultExt = 'ResultExt';
 en_capResultExt = '';
 op_Ok = 'Ok';
 op_capOk = 'OK';
 op_Cancel = 'Cancel';
 op_capCancel = 'Отмена';

// Состояния операций:
var st_user_ResultExt_Ok_None : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> None
var st_user_ResultExt_Ok_NewFolder : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> NewFolder
var st_user_ResultExt_Ok_Edit : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> Edit
var st_user_ResultExt_Ok_Load : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> Загрузить
var st_user_ResultExt_Ok_Select : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> Select
var st_user_ResultExt_Ok_FolderSave : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> OK <-> Сохранить
var st_user_ResultExt_Append_Bookmark : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> Добавить <-> Bookmark
var st_user_ResultExt_Append_List : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> Добавить <-> List
var st_user_ResultExt_Append_Query : TvcmOperationStateIndex = (rID : -1);
  // ResultExt -> Добавить <-> Query
{$IfEnd} //not Admin AND not Monitorings

implementation

end.