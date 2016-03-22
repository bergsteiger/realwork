unit daLongProcessSubscriberList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DA"
// ������: "w:/common/components/rtl/Garant/DA/daLongProcessSubscriberList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaLongProcessSubscriberList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoDataContainer,
  daTypes,
  daInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IdaLongProcessSubscriber;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TdaLongProcessSubscriberList = class(_l3InterfacePtrList_)
 public
 // public methods
   function LongProcessNotify(aState: TdaProcessState): Boolean;
 end;//TdaLongProcessSubscriberList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TdaLongProcessSubscriberList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

// start class TdaLongProcessSubscriberList

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