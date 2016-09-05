unit NOT_FINISHED_nsDownloaderInterfaces;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nsDownloaderInterfaces.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsDownloaderInterfaces" MUID: (57BD366C02FD)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 InsDownloader = interface
  ['{31074443-54E2-4739-B155-CFB5EC326ADF}']
 end;//InsDownloader

 InsDownloadParams = interface
  ['{15C71366-9DB6-4324-BFF9-9D28A182ADDF}']
 end;//InsDownloadParams

 InsDownloaderEventSink = interface
  ['{8F80A480-46CA-45FB-95DC-526DEF2FDC4C}']
 end;//InsDownloaderEventSink

 TnsDownloaderState = record
 end;//TnsDownloaderState

 TnsDownloadFileAction = (
 );//TnsDownloadFileAction
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *57BD366C02FDimpl_uses*
 //#UC END# *57BD366C02FDimpl_uses*
;
{$IfEnd} // Defined(Nemesis)

end.
