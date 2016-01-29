unit afwStatusElement.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _afwStatusElement_ = class(IafwStatusElement, Ml3Unknown)
  {* Реализация IafwStatusElement }
  procedure DoGetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
   {* Собственно процесс получения информации }
  function DoSubscribe: Boolean;
   {* Подписаться к строке статуса }
  procedure DoUnsubscribe;
   {* Отписаться от строки статуса }
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
