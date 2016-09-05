unit NOT_FINISHED_nsDownloader;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nsDownloader.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsDownloader" MUID: (57BC06F603E1)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nsDownloaderRes
 , nsDownloaderInterfaces
 , nsDownloaderGUIService
 , nsDownloaderThreadList
 , nsDownloaderThread
 //#UC START# *57BC06F603E1impl_uses*
 //#UC END# *57BC06F603E1impl_uses*
;
{$IfEnd} // Defined(Nemesis)

end.
