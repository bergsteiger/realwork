unit htFromTable;

interface

uses
 l3IntfUses
 , daFromTable
 , htInterfaces
 , HT_Const
;

type
 ThtFromTable = class(TdaFromTable, IhtFromTable)
  function Handle: ThtTblHandle;
  procedure Prepare(const aHelper: IhtDataSchemeHelper;
   RequireNewHandle: Boolean);
  procedure Unprepare(const aHelper: IhtDataSchemeHelper);
 end;//ThtFromTable
 
implementation

uses
 l3ImplUses
 , HT_DLL
 , dt_Serv
 , dt_Err
;

end.
