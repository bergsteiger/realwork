unit evContentsUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evContentsUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::ContentsTree::evContentsUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

const
  { Common }
 cnUndefLevel = High(LongInt) - 1;
function EvGetContentLevel(aLevel: Integer;
  anIsDocument: Boolean): Integer;

implementation

// unit methods

function EvGetContentLevel(aLevel: Integer;
  anIsDocument: Boolean): Integer;
//#UC START# *532BFF6403D5_532BFF3F00CA_var*
//#UC END# *532BFF6403D5_532BFF3F00CA_var*
begin
//#UC START# *532BFF6403D5_532BFF3F00CA_impl*
 Result := aLevel;
 if anIsDocument and (Result = cnUndefLevel) then
  Result := 2;
//#UC END# *532BFF6403D5_532BFF3F00CA_impl*
end;//EvGetContentLevel

end.