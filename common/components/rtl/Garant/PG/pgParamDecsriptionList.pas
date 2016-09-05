unit pgParamDecsriptionList;

// Модуль: "w:\common\components\rtl\Garant\PG\pgParamDecsriptionList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgParamDecsriptionList" MUID: (56653E620110)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
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
 _ItemType_ = IdaParamDescription;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TpgParamDecsriptionList = class(_l3InterfaceRefList_)
 end;//TpgParamDecsriptionList
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *56653E620110impl_uses*
 //#UC END# *56653E620110impl_uses*
;

type _Instance_R_ = TpgParamDecsriptionList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // Defined(UsePostgres)

end.
