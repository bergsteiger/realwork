unit caInterfaces;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "caInterfaces" MUID: (56C2DE8D033F)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , daInterfaces
 , htInterfaces
 , pgInterfaces
 , daTypes
;

type
 IcaDataConverter = interface(IdaDataConverter)
  ['{FADCE1E5-6997-478B-A413-7A8B0074DD9C}']
  function Get_HTConverter: IhtDataConverter;
  function Get_PGConverter: IpgDataConverter;
  property HTConverter: IhtDataConverter
   read Get_HTConverter;
  property PGConverter: IpgDataConverter
   read Get_PGConverter;
 end;//IcaDataConverter
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
