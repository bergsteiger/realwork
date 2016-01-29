unit vcmHistoryItemList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
;

type
 TvcmHistoryItemList = class(Tl3ProtoDataContainer, IvcmHistoryItems)
  procedure Create(const aOtherList: IvcmHistoryItems); overload;
  procedure Make(const aOtherList: IvcmHistoryItems); overload;
  procedure Create; overload;
  procedure Make; overload;
  procedure Assign(const aOtherList: IvcmHistoryItems);
  function HistoryItemCount: Integer;
  function HistoryItems: IvcmHistoryItem;
  function MakeClone: IvcmHistoryItems;
 end;//TvcmHistoryItemList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
