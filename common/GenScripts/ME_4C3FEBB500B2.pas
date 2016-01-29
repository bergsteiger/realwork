unit OldNSRCFlagCnahge;

interface

uses
 l3IntfUses
 , ChangeAllTablesTest
 , evCustomEditor
;

type
 TOldNSRCFlagCnahge = class(TChangeAllTablesTest)
  {* Изменить флаг "Выливать в псевдографику" во всех таблицах в документе. }
  procedure ApplyEditorTool(aEditor: TevCustomEditor);
   {* Вызов инструмента из редактора }
 end;//TOldNSRCFlagCnahge
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
