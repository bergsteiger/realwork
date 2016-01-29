unit l3NotifierBase.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _l3NotifierBase_ = class(Il3ChangeNotifier, Ml3Unknown)
  procedure Subscribe(const aRecipient: Il3Notify);
   {* �������� �� ���������. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "�������" �� ���������. }
 end;//_l3NotifierBase_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
