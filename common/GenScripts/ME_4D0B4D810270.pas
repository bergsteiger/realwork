unit nsIFilterFromQueryList;
 {* Список ссылок на IFilterFromQuery }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\nsIFilterFromQueryList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , FiltersUnit
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IFilterFromQuery;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsIFilterFromQueryList = class(_l3InterfaceRefList_)
  {* Список ссылок на IFilterFromQuery }
 end;//TnsIFilterFromQueryList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TnsIFilterFromQueryList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
