unit NOT_FINISHED_DictsSup;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_DictsSup.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DictsSup" MUID: (4E25307E022D)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , daTypes
;

function GetDictName(aDictID: TdaDictionaryType): AnsiString;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;

function GetDictName(aDictID: TdaDictionaryType): AnsiString;
//#UC START# *4E253095034C_4E25307E022D_var*
//#UC END# *4E253095034C_4E25307E022D_var*
begin
//#UC START# *4E253095034C_4E25307E022D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E253095034C_4E25307E022D_impl*
end;//GetDictName
{$IfEnd} // NOT Defined(Nemesis)

end.
