unit afwValueMaps;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Автор: Лукьянец Р. В.
// Модуль: "w:/common/components/gui/Garant/AFW/implementation/afwValueMaps.pas"
// Начат: 12.04.2006 13:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::AFW::Standard::afwValueMaps
//
// Мапы для UI-строка <=> что-то
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwInterfaces
  ;

function AfwIntegerMapManager: IafwIntegerValueMapManager;
function AfwStringMapManager: IafwStringValueMapManager;

implementation

uses
  l3IntegerValueMapManager,
  l3StringValueMapManager
  ;

// unit methods

function AfwIntegerMapManager: IafwIntegerValueMapManager;
//#UC START# *478E366E03B2_478E36460273_var*
//#UC END# *478E366E03B2_478E36460273_var*
begin
//#UC START# *478E366E03B2_478E36460273_impl*
 Result := l3IntegerMapManager;
//#UC END# *478E366E03B2_478E36460273_impl*
end;//AfwIntegerMapManager

function AfwStringMapManager: IafwStringValueMapManager;
//#UC START# *478E36800176_478E36460273_var*
//#UC END# *478E36800176_478E36460273_var*
begin
//#UC START# *478E36800176_478E36460273_impl*
 Result := l3StringMapManager;
//#UC END# *478E36800176_478E36460273_impl*
end;//AfwStringMapManager

end.