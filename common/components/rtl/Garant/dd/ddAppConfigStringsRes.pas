unit ddAppConfigStringsRes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddAppConfigStringsRes" MUID: (4B9E62C2001A)

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
 //#UC START# *4B9E62C2001Aimpl_uses*
 //#UC END# *4B9E62C2001Aimpl_uses*
;

initialization
 str_ddcmCheckButton.Init;
 {* Инициализация str_ddcmCheckButton }
 str_ddcmSoundFiles.Init;
 {* Инициализация str_ddcmSoundFiles }

end.
