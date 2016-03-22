unit NOT_FINISHED_m3StgMgr;
 {* Классы-менеджеры для работы с IStorage }

// Модуль: "w:\common\components\rtl\Garant\m3\NOT_FINISHED_m3StgMgr.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "m3StgMgr" MUID: (49B9535B0235)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tm3StorageManager = class
 end;//Tm3StorageManager

 Tm3FullModeStorageManager = class(Tm3StorageManager)
 end;//Tm3FullModeStorageManager

 Tm3ReadModeStorageManager = class(Tm3StorageManager)
 end;//Tm3ReadModeStorageManager

implementation

uses
 l3ImplUses
 , m3ArchiveStorage
 , m3StorageService
 , m3FileStream
 , m3SplittedFileStream
;

end.
