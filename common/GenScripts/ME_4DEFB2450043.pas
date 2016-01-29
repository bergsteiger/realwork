unit l3OtherListView.imp;

interface

uses
 l3IntfUses
 , l3CustomOtherListView
 , l3PureMixIns
;

type
 // _ListType_
 
 PItemType = ^_ItemType_;
 
 _l3OtherListView_ = class(Tl3CustomOtherListView)
  procedure Create(const aList: _ListType_);
  function CompareData(const anItem1: _ItemType_;
   const anItem2: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
  function CompareItems(anIndex1: Integer;
   anIndex2: Integer): Integer;
  function OtherListCount: Integer;
 end;//_l3OtherListView_
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
