unit evContentsUtils;

// Модуль: "w:\common\components\gui\Garant\Everest\evContentsUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evContentsUtils" MUID: (532BFF3F00CA)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
;

const
 cnUndefLevel = High(LongInt) - 1;

function evGetContentLevel(aLevel: Integer;
 anIsDocument: Boolean): Integer;

implementation

uses
 l3ImplUses
 //#UC START# *532BFF3F00CAimpl_uses*
 //#UC END# *532BFF3F00CAimpl_uses*
;

function evGetContentLevel(aLevel: Integer;
 anIsDocument: Boolean): Integer;
//#UC START# *532BFF6403D5_532BFF3F00CA_var*
//#UC END# *532BFF6403D5_532BFF3F00CA_var*
begin
//#UC START# *532BFF6403D5_532BFF3F00CA_impl*
 Result := aLevel;
 if anIsDocument and (Result = cnUndefLevel) then
  Result := 2;
//#UC END# *532BFF6403D5_532BFF3F00CA_impl*
end;//evGetContentLevel

end.
