unit evDocumentPreviewInfoList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evDocumentPreviewInfoList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDocumentPreviewInfoList" MUID: (47ED10AF024F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IevDocumentPreviewInfo;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevDocumentPreviewInfoList = class(_l3InterfaceRefList_)
  public
   procedure StopAllPreviews;
    {* Остановить построение превью }
 end;//TevDocumentPreviewInfoList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47ED10AF024Fimpl_uses*
 //#UC END# *47ED10AF024Fimpl_uses*
;

type _Instance_R_ = TevDocumentPreviewInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

procedure TevDocumentPreviewInfoList.StopAllPreviews;
 {* Остановить построение превью }
//#UC START# *48046D0803DA_47ED10AF024F_var*
var
 l_IDX: Integer;
//#UC END# *48046D0803DA_47ED10AF024F_var*
begin
//#UC START# *48046D0803DA_47ED10AF024F_impl*
 for l_IDX := 0 to Count - 1 do
  Items[l_IDX].Preview.Stop;
//#UC END# *48046D0803DA_47ED10AF024F_impl*
end;//TevDocumentPreviewInfoList.StopAllPreviews

end.
