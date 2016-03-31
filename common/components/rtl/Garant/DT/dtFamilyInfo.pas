unit dtFamilyInfo;

// Модуль: "w:\common\components\rtl\Garant\DT\dtFamilyInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdtFamilyInfo" MUID: (537F78410340)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TdtFamilyInfo = class(Tl3ProtoObject)
  public
   Number: Integer;
   Name: AnsiString;
   Path: AnsiString;
   DocGroup: Integer;
   Attributes: Integer;
 end;//TdtFamilyInfo
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
