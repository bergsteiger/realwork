unit nevContainers;
 {* ��������� ���������� ��� �������� ����������� }

// ������: "w:\common\components\gui\Garant\Everest\nevContainers.pas"
// ���������: "Interfaces"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3PureMixIns
 , nevTools
;

type
 //_ItemType_ = IevSub;
 InevFlatSubsList = interface
  {* ������� ���������. �-�� Il3InterfacedList }
  ['{0288488A-FBEB-4E1D-AA0C-3B2E1F3DA447}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: IevSub;
  function pm_GetLast: IevSub;
  function pm_GetItems(anIndex: Integer): IevSub;
  function pm_GetCount: Integer;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: IevSub
   read pm_GetFirst;
   {* ������ �������. }
  property Last: IevSub
   read pm_GetLast;
   {* ��������� �������. }
  property Items[anIndex: Integer]: IevSub
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* ����� ���������. }
 end;//InevFlatSubsList

implementation

uses
 l3ImplUses
;

end.
