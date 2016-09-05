unit nsDownloaderRes;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nsDownloaderRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsDownloaderRes" MUID: (57BD790600B0)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки nsDownloaderLocalConst }
 str_UnknownFile: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'UnknownFile'; rValue : 'Неизвестный');
  {* 'Неизвестный' }
 str_FileDownload: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FileDownload'; rValue : 'Загрузка файла');
  {* 'Загрузка файла' }
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *57BD790600B0impl_uses*
 //#UC END# *57BD790600B0impl_uses*
;

initialization
 str_UnknownFile.Init;
 {* Инициализация str_UnknownFile }
 str_FileDownload.Init;
 {* Инициализация str_FileDownload }
{$IfEnd} // Defined(Nemesis)

end.
