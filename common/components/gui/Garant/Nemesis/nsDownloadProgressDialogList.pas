unit nsDownloadProgressDialogList;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nsDownloadProgressDialogList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDownloadProgressDialogList" MUID: (57BADBD103BF)

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
 _ItemType_ = InsDownloadProgressDialog;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsDownloadProgressDialogList = class(_l3InterfaceRefList_)
 end;//TnsDownloadProgressDialogList
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57BADBD103BFimpl_uses*
 //#UC END# *57BADBD103BFimpl_uses*
;

type _Instance_R_ = TnsDownloadProgressDialogList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // Defined(Nemesis)

end.
