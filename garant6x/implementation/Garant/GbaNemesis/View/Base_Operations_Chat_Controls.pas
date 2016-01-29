unit Base_Operations_Chat_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_Chat_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::Chat
//
// Чат
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

(* Chat = operations
  {* Чат }
   ['{DAFC70C1-6932-4BB8-83CC-8355BA2E216B}']
   operation ClearHistory;
     {* Очистить историю }
 end;//Chat*)

(* Chat = operations
   ['{6FA3EFB6-3CC9-427F-BF85-BDFEA8CDD20D}']
   operation History;
   operation UserFilter;
   operation OpenChatWindow;
   operation Add;
 end;//Chat*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Chat = 'Chat';
 en_capChat = 'Чат';
 op_ClearHistory = 'ClearHistory';
 op_capClearHistory = 'Очистить историю';
 op_History = 'History';
 op_capHistory = '';
 op_UserFilter = 'UserFilter';
 op_capUserFilter = '';
 op_OpenChatWindow = 'OpenChatWindow';
 op_capOpenChatWindow = '';
 op_Add = 'Add';
 op_capAdd = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.