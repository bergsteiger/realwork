unit nsOwnedDocumentTagNodePrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsOwnedDocumentTagNodePrim.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsDocumentTagNodePrim
 , l3Variant
;

type
 _k2OwnedTagObject_Parent_ = TnsDocumentTagNodePrim;
 {$Include k2OwnedTagObject.imp.pas}
 TnsOwnedDocumentTagNodePrim = class(_k2OwnedTagObject_)
 end;//TnsOwnedDocumentTagNodePrim

implementation

uses
 l3ImplUses
 , k2Base
 , SysUtils
 , k2NullTagImpl
;

{$Include k2OwnedTagObject.imp.pas}

end.
