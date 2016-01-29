unit alcuMdpDocImporter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuMdpDocImporter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Server::Server::TalcuMdpDocImporter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(MDPSyncIntegrated)}
uses
  l3ProtoObject,
  alcuTaskManager
  ;
{$IfEnd} //AppServerSide AND MDPSyncIntegrated

{$If defined(AppServerSide) AND defined(MDPSyncIntegrated)}
type
 TalcuMdpDocImporter = class(Tl3ProtoObject)
 private
 // private methods
   function HasToImport: Boolean;
 public
 // public methods
   procedure CheckRunImport(aTaskManager: TddServerTaskManager);
 end;//TalcuMdpDocImporter
{$IfEnd} //AppServerSide AND MDPSyncIntegrated

implementation

{$If defined(AppServerSide) AND defined(MDPSyncIntegrated)}
uses
  Classes
  {$If defined(ServerTasks)}
  ,
  alcuMdpImportDocs
  {$IfEnd} //ServerTasks
  ,
  SysUtils,
  daInterfaces,
  ddAppConfig,
  daTypes
  ;
{$IfEnd} //AppServerSide AND MDPSyncIntegrated

{$If defined(AppServerSide) AND defined(MDPSyncIntegrated)}

// start class TalcuMdpDocImporter

function TalcuMdpDocImporter.HasToImport: Boolean;
//#UC START# *55EEDEC7035D_55EED3CD0299_var*
//#UC END# *55EEDEC7035D_55EED3CD0299_var*
begin
//#UC START# *55EEDEC7035D_55EED3CD0299_impl*
 Result := True;
// !!! Needs to be implemented !!!
//#UC END# *55EEDEC7035D_55EED3CD0299_impl*
end;//TalcuMdpDocImporter.HasToImport

procedure TalcuMdpDocImporter.CheckRunImport(aTaskManager: TddServerTaskManager);
//#UC START# *55EED7F301B5_55EED3CD0299_var*
var
 l_Task: TalcuMdpImportDocs;
//#UC END# *55EED7F301B5_55EED3CD0299_var*
begin
//#UC START# *55EED7F301B5_55EED3CD0299_impl*
 if HasToImport then
 begin
  l_Task := TalcuMdpImportDocs.Create(TdaUserID(ddAppConfiguration.asInteger['mdpImportUser']));
  try
   l_Task.Description := 'Импорт документов из Гардока';
   if aTaskManager.ActiveTaskList.FindTask(l_Task.TaskType) = nil then
    aTaskManager.AddActiveTask(l_Task);
  finally
   FreeAndNil(l_Task);
  end;
 end;
//#UC END# *55EED7F301B5_55EED3CD0299_impl*
end;//TalcuMdpDocImporter.CheckRunImport

{$IfEnd} //AppServerSide AND MDPSyncIntegrated

end.