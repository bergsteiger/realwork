unit alcuMdpDocImporter;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuMdpDocImporter.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(MDPSyncIntegrated)}
uses
 l3IntfUses
 , l3ProtoObject
 , alcuTaskManager
;

type
 TalcuMdpDocImporter = class(Tl3ProtoObject)
  private
   function HasToImport: Boolean;
  public
   procedure CheckRunImport(aTaskManager: TddServerTaskManager);
 end;//TalcuMdpDocImporter
{$IfEnd} // Defined(AppServerSide) AND Defined(MDPSyncIntegrated)

implementation

{$If Defined(AppServerSide) AND Defined(MDPSyncIntegrated)}
uses
 l3ImplUses
 , ddAppConfig
 , daTypes
 {$If Defined(ServerTasks)}
 , alcuMdpImportDocs
 {$IfEnd} // Defined(ServerTasks)
 , SysUtils
 , daInterfaces
;

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

function TalcuMdpDocImporter.HasToImport: Boolean;
//#UC START# *55EEDEC7035D_55EED3CD0299_var*
//#UC END# *55EEDEC7035D_55EED3CD0299_var*
begin
//#UC START# *55EEDEC7035D_55EED3CD0299_impl*
 Result := True;
// !!! Needs to be implemented !!!
//#UC END# *55EEDEC7035D_55EED3CD0299_impl*
end;//TalcuMdpDocImporter.HasToImport
{$IfEnd} // Defined(AppServerSide) AND Defined(MDPSyncIntegrated)

end.
