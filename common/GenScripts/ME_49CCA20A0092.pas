unit afwStatusElement.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwStatusElement_ = class(IafwStatusElement, Ml3Unknown)
  {* ���������� IafwStatusElement }
  procedure DoGetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
   {* ���������� ������� ��������� ���������� }
  function DoSubscribe: Boolean;
   {* ����������� � ������ ������� }
  procedure DoUnsubscribe;
   {* ���������� �� ������ ������� }
  function NeedUpdateOnUnsubscribe: Boolean;
  procedure GetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
 end;//_afwStatusElement_
 
implementation

uses
 l3ImplUses
 , afwFacade
;

end.
