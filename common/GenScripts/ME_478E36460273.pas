unit afwValueMaps;
 {* Мапы для UI-строка <=> что-то }

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwValueMaps.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "afwValueMaps" MUID: (478E36460273)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwInterfaces
;

function afwIntegerMapManager: IafwIntegerValueMapManager;
function afwStringMapManager: IafwStringValueMapManager;

implementation

uses
 l3ImplUses
 , l3IntegerValueMapManager
 , l3StringValueMapManager
;

function afwIntegerMapManager: IafwIntegerValueMapManager;
//#UC START# *478E366E03B2_478E36460273_var*
//#UC END# *478E366E03B2_478E36460273_var*
begin
//#UC START# *478E366E03B2_478E36460273_impl*
 Result := l3IntegerMapManager;
//#UC END# *478E366E03B2_478E36460273_impl*
end;//afwIntegerMapManager

function afwStringMapManager: IafwStringValueMapManager;
//#UC START# *478E36800176_478E36460273_var*
//#UC END# *478E36800176_478E36460273_var*
begin
//#UC START# *478E36800176_478E36460273_impl*
 Result := l3StringMapManager;
//#UC END# *478E36800176_478E36460273_impl*
end;//afwStringMapManager

end.
