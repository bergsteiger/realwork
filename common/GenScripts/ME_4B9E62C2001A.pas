unit ddAppConfigStringsRes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_ddcmCheckButton: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmCheckButton'; rValue : 'Проверка');
  {* 'Проверка' }
 str_ddcmSoundFiles: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSoundFiles'; rValue : 'Звуковые файлы (*.wav)|*.wav');
  {* 'Звуковые файлы (*.wav)|*.wav' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_ddcmCheckButton.Init;
 {* Инициализация str_ddcmCheckButton }
 str_ddcmSoundFiles.Init;
 {* Инициализация str_ddcmSoundFiles }

end.
