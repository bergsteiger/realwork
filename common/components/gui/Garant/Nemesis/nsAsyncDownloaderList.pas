unit nsAsyncDownloaderList;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nsAsyncDownloaderList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsAsyncDownloaderList" MUID: (57BADBE901FD)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , nsDownloaderInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsAsyncDownloader;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsAsyncDownloaderList = class(_l3InterfaceRefList_)
 end;//TnsAsyncDownloaderList
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57BADBE901FDimpl_uses*
 //#UC END# *57BADBE901FDimpl_uses*
;

type _Instance_R_ = TnsAsyncDownloaderList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // Defined(Nemesis)

end.
