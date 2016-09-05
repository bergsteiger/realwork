unit daLongProcessSubscriberList;

// Модуль: "w:\common\components\rtl\Garant\DA\daLongProcessSubscriberList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaLongProcessSubscriberList" MUID: (5524D27A00D3)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , daTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaLongProcessSubscriber;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TdaLongProcessSubscriberList = class(_l3InterfacePtrList_)
  public
   function LongProcessNotify(aState: TdaProcessState): Boolean;
 end;//TdaLongProcessSubscriberList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5524D27A00D3impl_uses*
 //#UC END# *5524D27A00D3impl_uses*
;

type _Instance_R_ = TdaLongProcessSubscriberList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

function TdaLongProcessSubscriberList.LongProcessNotify(aState: TdaProcessState): Boolean;
//#UC START# *565DA60503D9_5524D27A00D3_var*
var
 l_Result: Boolean;

 function lp_Notify(aNotifier: PIdaLongProcessSubscriber; Index: Long): Bool;
 begin
  if aNotifier^.DoLongProcessNotify(aState) then
   l_Result := True;
  Result := True;
 end;

//#UC END# *565DA60503D9_5524D27A00D3_var*
begin
//#UC START# *565DA60503D9_5524D27A00D3_impl*
 l_Result := False;
 IterateAllF(l3L2IA(@lp_Notify));
 Result := l_Result;
//#UC END# *565DA60503D9_5524D27A00D3_impl*
end;//TdaLongProcessSubscriberList.LongProcessNotify

end.
