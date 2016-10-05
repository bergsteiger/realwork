unit arCustomMultiClearAttributesHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arCustomMultiClearAttributesHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarCustomMultiClearAttributesHelper" MUID: (57EA22400306)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3DatLst
;

type
 TarCustomMultiClearAttributesHelper = class(Tl3ProtoObject)
  public
   procedure ClearAttributes; virtual; abstract;
   function HasRejectedDocs: Boolean; virtual; abstract;
   procedure FillRejectedList(aList: Tl3StringDataList); virtual; abstract;
 end;//TarCustomMultiClearAttributesHelper

implementation

uses
 l3ImplUses
 //#UC START# *57EA22400306impl_uses*
 //#UC END# *57EA22400306impl_uses*
;

end.
