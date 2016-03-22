unit nsDocumentTagNodeBase;
 {* Базовая нода документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsDocumentTagNodeBase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentTagNodeBase" MUID: (4C72633902D0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsOwnedDocumentTagNodePrim
 , F1TagDataProviderInterface
;

type
 TnsDocumentTagNodeBase = class(TnsOwnedDocumentTagNodePrim)
  {* Базовая нода документа }
  public
   constructor CreatePrim(const aNode: If1TagDataProvider); reintroduce;
 end;//TnsDocumentTagNodeBase

implementation

uses
 l3ImplUses
 , k2Facade
;

constructor TnsDocumentTagNodeBase.CreatePrim(const aNode: If1TagDataProvider);
//#UC START# *4C72528B0170_4C72633902D0_var*
//#UC END# *4C72528B0170_4C72633902D0_var*
begin
//#UC START# *4C72528B0170_4C72633902D0_impl*
 inherited Create(aNode.TypeID, aNode, nil, []);
//#UC END# *4C72528B0170_4C72633902D0_impl*
end;//TnsDocumentTagNodeBase.CreatePrim

end.
