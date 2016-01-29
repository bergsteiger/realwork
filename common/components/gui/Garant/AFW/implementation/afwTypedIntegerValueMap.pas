unit afwTypedIntegerValueMap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Модуль: "w:/common/components/gui/Garant/AFW/implementation/afwTypedIntegerValueMap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::AFW::Standard::afwTypedIntegerValueMap
//
// реализация мапы "строка"-"число" для чистой замены array [TSomeType] of string.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwInterfaces,
  l3TypedIntegerValueMap
  ;

type
 TafwSimpleTypedIntegerValueMap = class(Tl3SimpleTypedIntegerValueMap, IafwStringsSource)
 protected
 // realized methods
   procedure FillStrings(const aStrings: IafwStrings);
 end;//TafwSimpleTypedIntegerValueMap

implementation

uses
  l3Base
  ;

// start class TafwSimpleTypedIntegerValueMap

procedure TafwSimpleTypedIntegerValueMap.FillStrings(const aStrings: IafwStrings);
//#UC START# *473D93290004_478E31250074_var*
var
 l_Index: Integer;
//#UC END# *473D93290004_478E31250074_var*
begin
//#UC START# *473D93290004_478E31250074_impl*
 Assert(false, 'По-моему этот метод уже не нужен');
 aStrings.Clear;
 for l_Index := Low(f_Values) To High(f_Values) Do
  aStrings.Add(f_values[l_Index]);
//#UC END# *473D93290004_478E31250074_impl*
end;//TafwSimpleTypedIntegerValueMap.FillStrings

end.