unit NOT_FINISHED_alcuImport;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\NOT_FINISHED_alcuImport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "alcuImport" MUID: (5305AFD5014D)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csImport
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuImport = class(TcsImportTaskItem)
  protected
   {$If NOT Defined(Nemesis)}
   procedure GetTaskResultClass : TcsClassResultClass; override;
   {$IfEnd} // NOT Defined(Nemesis)
 end;//TalcuImport
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
 , alcuImportTaskResult
;

{$If NOT Defined(Nemesis)}
procedure TalcuImport.GetTaskResultClass : TcsClassResultClass;
//#UC START# *53E1CB0C03C9_5305AFFB01F5_var*
//#UC END# *53E1CB0C03C9_5305AFFB01F5_var*
begin
//#UC START# *53E1CB0C03C9_5305AFFB01F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E1CB0C03C9_5305AFFB01F5_impl*
end;//TalcuImport.GetTaskResultClass : TcsClassResultClass
{$IfEnd} // NOT Defined(Nemesis)

{$IfEnd} // Defined(ServerTasks)
end.
