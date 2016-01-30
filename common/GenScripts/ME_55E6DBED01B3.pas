unit NOT_FINISHED_dt_Dict;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_Dict.pas"
// Стереотип: "UtilityPack"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , daTypes
;

type
 TDictionaryServer = class
 end;//TDictionaryServer

function DictServer(aFamily: TdaFamilyID): TDictionaryServer;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function DictServer(aFamily: TdaFamilyID): TDictionaryServer;
//#UC START# *55E6DC0802A7_55E6DBED01B3_var*
//#UC END# *55E6DC0802A7_55E6DBED01B3_var*
begin
//#UC START# *55E6DC0802A7_55E6DBED01B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *55E6DC0802A7_55E6DBED01B3_impl*
end;//DictServer
{$IfEnd} // NOT Defined(Nemesis)

end.
