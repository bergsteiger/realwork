unit arCustomMultiChangeHyperLinksHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arCustomMultiChangeHyperLinksHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarCustomMultiChangeHyperLinksHelper" MUID: (5800CDB10211)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TarCustomMultiChangeHyperLinksHelper = class(Tl3ProtoObject)
  public
   procedure ModifyDocs; virtual; abstract;
 end;//TarCustomMultiChangeHyperLinksHelper

implementation

uses
 l3ImplUses
 //#UC START# *5800CDB10211impl_uses*
 //#UC END# *5800CDB10211impl_uses*
;

end.
