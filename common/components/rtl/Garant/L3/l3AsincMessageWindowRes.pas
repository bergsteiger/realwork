unit l3AsincMessageWindowRes;

// Модуль: "w:\common\components\rtl\Garant\L3\l3AsincMessageWindowRes.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_l3mmLongOperation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmLongOperation'; rValue : 'Выполняется длительная операция...');
  {* 'Выполняется длительная операция...' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_l3mmLongOperation.Init;
 {* Инициализация str_l3mmLongOperation }

end.
