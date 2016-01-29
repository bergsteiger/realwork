unit nscTasksPanelGroupsIterator;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmTaskPanelInterfaces
 , nscTasksPanelGroupDescList
;

type
 TnscTasksPanelGroupsIterator = class(Tl3ProtoObject, IvcmCustOpsGroupsIterator)
  procedure Create(aGroups: TnscTasksPanelGroupDescList);
  function Make(aGroups: TnscTasksPanelGroupDescList): IvcmCustOpsGroupsIterator;
  function Next: IvcmCustOpsGroup;
 end;//TnscTasksPanelGroupsIterator
 
implementation

uses
 l3ImplUses
 , nscTasksPanelGroup
 , SysUtils
 , l3Base
;

end.
