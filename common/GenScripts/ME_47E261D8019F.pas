unit nevDocumentContainerListPrim;
 {* Список контейнеров документов. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevDocumentContainerListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevDocumentContainerListPrim" MUID: (47E261D8019F)

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
 _ItemType_ = InevDocumentContainer;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevDocumentContainerListPrim = class(_l3InterfaceRefList_)
  {* Список контейнеров документов. }
 end;//TnevDocumentContainerListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnevDocumentContainerListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
