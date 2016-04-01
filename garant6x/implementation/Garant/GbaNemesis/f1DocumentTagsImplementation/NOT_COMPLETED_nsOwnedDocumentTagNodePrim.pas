unit NOT_COMPLETED_nsOwnedDocumentTagNodePrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\NOT_COMPLETED_nsOwnedDocumentTagNodePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsOwnedDocumentTagNodePrim" MUID: (4C724FC1029F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsDocumentTagNodePrim
 , l3Variant
;

type
 _k2OwnedTagObject_Parent_ = TnsDocumentTagNodePrim;
 {$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}
 TnsOwnedDocumentTagNodePrim = class(_k2OwnedTagObject_)
 end;//TnsOwnedDocumentTagNodePrim

implementation

uses
 l3ImplUses
 , k2Base
 , SysUtils
 , k2NullTagImpl
 , l3BitArr
;

{$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}

end.
