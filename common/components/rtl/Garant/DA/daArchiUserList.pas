unit daArchiUserList;

// Модуль: "w:\common\components\rtl\Garant\DA\daArchiUserList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaArchiUserList" MUID: (52FBA7D00393)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaArchiUser;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TdaArchiUserList = class(_l3InterfaceRefList_)
 end;//TdaArchiUserList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TdaArchiUserList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
