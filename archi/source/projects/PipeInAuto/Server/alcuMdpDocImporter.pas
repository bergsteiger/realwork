unit alcuMdpDocImporter;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuMdpDocImporter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpDocImporter" MUID: (55EED3CD0299)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(MDPSyncIntegrated)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuMdpDocImporter = class(Tl3ProtoObject)
  private
   function HasToImport: Boolean;
  public
   function MakeTask: TddProcessTask;
 end;//TalcuMdpDocImporter
{$IfEnd} // Defined(AppServerSide) AND Defined(MDPSyncIntegrated)

implementation

{$If Defined(AppServerSide) AND Defined(MDPSyncIntegrated)}
uses
 l3ImplUses
 , ddAppConfig
 , daTypes
 , daInterfaces
 {$If Defined(ServerTasks)}
 , alcuMdpImportDocs
 {$IfEnd} // Defined(ServerTasks)
 //#UC START# *55EED3CD0299impl_uses*
 //#UC END# *55EED3CD0299impl_uses*
;

function TalcuMdpDocImporter.HasToImport: Boolean;
//#UC START# *55EEDEC7035D_55EED3CD0299_var*
//#UC END# *55EEDEC7035D_55EED3CD0299_var*
begin
//#UC START# *55EEDEC7035D_55EED3CD0299_impl*
 Result := True;
// По хорошему нужен ответ от Гардока о наличии документов для импорта. 
// !!! Needs to be implemented !!!
//#UC END# *55EEDEC7035D_55EED3CD0299_impl*
end;//TalcuMdpDocImporter.HasToImport

function TalcuMdpDocImporter.MakeTask: TddProcessTask;
//#UC START# *57061FA6032E_55EED3CD0299_var*
//#UC END# *57061FA6032E_55EED3CD0299_var*
begin
//#UC START# *57061FA6032E_55EED3CD0299_impl*
 Result := nil;
 if HasToImport then
 begin
  Result := TalcuMdpImportDocs.Create(TdaUserID(ddAppConfiguration.asInteger['mdpImportUser']));
  Result.Description := 'Импорт документов из Гардока';
 end;
//#UC END# *57061FA6032E_55EED3CD0299_impl*
end;//TalcuMdpDocImporter.MakeTask
{$IfEnd} // Defined(AppServerSide) AND Defined(MDPSyncIntegrated)

end.
