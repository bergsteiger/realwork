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
 str_OpenOrDownloadQuestion: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OpenOrDownloadQuestion'; rValue : 'Вы хотите открыть или сохранить этот файл?');
  {* 'Вы хотите открыть или сохранить этот файл?' }
 str_FileName: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FileName'; rValue : 'Имя:');
  {* 'Имя:' }
 str_Type: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Type'; rValue : 'Тип:');
  {* 'Тип:' }
 str_From: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'From'; rValue : 'Из:');
  {* 'Из:' }
 str_Open: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Open'; rValue : 'Открыть');
  {* 'Открыть' }
 str_Download: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Download'; rValue : 'Сохранить');
  {* 'Сохранить' }
 str_Cancel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Cancel'; rValue : 'Отмена');
  {* 'Отмена' }
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
 str_OpenOrDownloadQuestion.Init;
 {* Инициализация str_OpenOrDownloadQuestion }
 str_FileName.Init;
 {* Инициализация str_FileName }
 str_Type.Init;
 {* Инициализация str_Type }
 str_From.Init;
 {* Инициализация str_From }
 str_Open.Init;
 {* Инициализация str_Open }
 str_Download.Init;
 {* Инициализация str_Download }
 str_Cancel.Init;
 {* Инициализация str_Cancel }
{$IfEnd} // Defined(Nemesis)

end.
