unit nsOwnedDocumentTagNodePrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsOwnedDocumentTagNodePrim.pas"
// Стереотип: "SimpleClass"

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

{$If not Declared(_HashType_)}type _HashType_ = Tl3PtrHash;{$IfEnd}

{$Include w:\common\components\rtl\Garant\K2\k2OwnedTagObject.imp.pas}

end.
