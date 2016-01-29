unit NOT_FINISHED_l3ItemsStorage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3ItemsStorage.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Trees::Tl3ItemsStorage
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoPersistentDataContainer,
  l3Types,
  l3Interfaces,
  l3NotifyPtrList
  ;

type
 _l3LockedChange_Parent_ = Tl3ProtoPersistentDataContainer;
 {$Include ..\L3\l3LockedChange.imp.pas}
 _l3Sortable_Parent_ = _l3LockedChange_;
 {$Include ..\L3\l3Sortable.imp.pas}
 _l3ChangingChangedNotifier_Parent_ = _l3Sortable_;
 {$Include ..\L3\l3ChangingChangedNotifier.imp.pas}
 Tl3ItemsStorage = class(_l3ChangingChangedNotifier_)
 protected
 // realized methods
   procedure Swap(var I1: _ItemType_;
    var I2: _ItemType_); override;
     {* ������ �������� ��������� �������. �� ��������� ���������� ��������. }
 end;//Tl3ItemsStorage

implementation

uses
  l3Base,
  SysUtils,
  l3IID,
  l3InterfacesMisc
  ;

// start class Tl3ItemsStorage

function DoCompareItems(const A: _ItemType_;
  const B: _ItemType_;
  aSortIndex: Tl3SortIndex
  {$If defined(l3Items_CompareItemsRec_NeedsRList)}
  ;
  aList: _l3Sortable_
  {$IfEnd} //l3Items_CompareItemsRec_NeedsRList
  ): Integer;
//#UC START# *47B5B5F1038E_4908A9FF0357_var*
//#UC END# *47B5B5F1038E_4908A9FF0357_var*
begin
//#UC START# *47B5B5F1038E_4908A9FF0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B5B5F1038E_4908A9FF0357_impl*
end;//DoCompareItems

{$Include ..\L3\l3LockedChange.imp.pas}

type _Instance_R_ = Tl3ItemsStorage;

{$Include ..\L3\l3Sortable.imp.pas}

{$Include ..\L3\l3ChangingChangedNotifier.imp.pas}

// start class Tl3ItemsStorage

procedure Tl3ItemsStorage.Swap(var I1: _ItemType_;
  var I2: _ItemType_);
//#UC START# *47B5B88203A7_4908A9FF0357_var*
//#UC END# *47B5B88203A7_4908A9FF0357_var*
begin
//#UC START# *47B5B88203A7_4908A9FF0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B5B88203A7_4908A9FF0357_impl*
end;//Tl3ItemsStorage.Swap

end.