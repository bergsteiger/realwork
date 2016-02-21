unit NOT_FINISHED_m3NewStorage;

// Модуль: "w:\common\components\rtl\Garant\m3\NOT_FINISHED_m3NewStorage.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3CustomNewStorage
;

type
 Tm3NewStorage = class(Tm3CustomNewStorage)
 end;//Tm3NewStorage

implementation

uses
 l3ImplUses
 , m3RootStream
 , m3StoreHeaderData
 , m3RootStreamNew
 , m3StoreHeaderDataNew
 , m3StoreHeader
 , m3StorageBlock
 , m3NewRootStreamManager
 , m3TOCHandle
 , m3ReadOnlyRootStreamManager
 , m3NewStorageStream
 , m3StorageIndexStream
 , m3StorageTableOfContentsStream
 , m3StorageIndexStreamForIterate
 , m3TempEnumStatStg
;

end.
