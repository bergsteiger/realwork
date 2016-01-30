unit ncsServerTransporterPtrList;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServerTransporterPtrList.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessageInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IncsServerTransporter;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TncsServerTransporterPtrList = class(_l3InterfacePtrList_)
 end;//TncsServerTransporterPtrList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TncsServerTransporterPtrList;

{$Include l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
