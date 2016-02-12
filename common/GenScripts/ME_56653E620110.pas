unit pgParamDecsriptionList;

// Модуль: "w:\common\components\rtl\Garant\PG\pgParamDecsriptionList.pas"
// Стереотип: "SimpleClass"

{$Include pgDefine.inc}

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
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TpgParamDecsriptionList = class(_l3InterfacePtrList_)
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
;

type _Instance_R_ = TpgParamDecsriptionList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // Defined(UsePostgres)

end.
