unit K200902351;

interface

uses
 l3IntfUses
 , TableSelectTest
 , nevTools
 , PrimTextLoad_Form
;

type
 TK200902351 = class(TTableSelectTest)
  {* [$200902351] }
  function GetTablePara(const aDocument: InevParaList): InevParaList;
   {* Возвращает параграф с таблицей }
 end;//TK200902351
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
