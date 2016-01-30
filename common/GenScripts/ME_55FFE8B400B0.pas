unit pgFromTable;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFromTable.pas"
// Стереотип: "SimpleClass"

{$Include pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daFromTable
;

type
 TpgFromTable = class(TdaFromTable)
 end;//TpgFromTable
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(UsePostgres)

end.
