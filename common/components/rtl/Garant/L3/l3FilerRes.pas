unit l3FilerRes;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FilerRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3FilerRes" MUID: (4BA206A400AC)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

{$If NOT Defined(Nemesis)}
const
 {* Локализуемые строки Local }
 str_l3mmFileOp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : 'Файловая операция');
  {* 'Файловая операция' }
 str_l3mmFileOpFmt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : 'Файловая операция [%s]');
  {* 'Файловая операция [%s]' }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
const
 {* Локализуемые строки LocalNemesis }
 str_l3mmFileOp: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : 'Загрузка документа');
  {* 'Загрузка документа' }
 str_l3mmFileOpFmt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : 'Загрузка документа [%s]');
  {* 'Загрузка документа [%s]' }
{$IfEnd} // Defined(Nemesis)

implementation

uses
 l3ImplUses
;

initialization
{$If NOT Defined(Nemesis)}
 str_l3mmFileOp.Init;
 {* Инициализация str_l3mmFileOp }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_l3mmFileOpFmt.Init;
 {* Инициализация str_l3mmFileOpFmt }
{$IfEnd} // NOT Defined(Nemesis)
{$If Defined(Nemesis)}
 str_l3mmFileOp.Init;
 {* Инициализация str_l3mmFileOp }
{$IfEnd} // Defined(Nemesis)
{$If Defined(Nemesis)}
 str_l3mmFileOpFmt.Init;
 {* Инициализация str_l3mmFileOpFmt }
{$IfEnd} // Defined(Nemesis)

end.
