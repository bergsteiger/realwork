unit ChromeLikeBaseVisualObjectList;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseVisualObjectList.pas"
// Стереотип: "SimpleClass"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ChromeLikeBaseVisualObjectPrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TChromeLikeBaseVisualObjectPrim;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3ObjectPtrList.imp.pas}
 TChromeLikeBaseVisualObjectList = class(_l3ObjectPtrList_)
 end;//TChromeLikeBaseVisualObjectList
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TChromeLikeBaseVisualObjectList;

{$Include l3ObjectPtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
