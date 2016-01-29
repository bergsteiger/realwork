unit vcmChromeLikeTabIconUpdater.imp;

interface

uses
 l3IntfUses
 , vcmInterfaces
;

type
 _vcmChromeLikeTabIconUpdater_ = class(MvcmEntityForm, IvcmFormSetIconProvider)
  function DoGetTabImageIndex: Integer;
  procedure UpdateTabIcon;
  function DoGetCanDefineFormSetIcon: Boolean;
  function FormSetImageIndex: Integer;
  function CanDefineFormSetIcon: Boolean;
 end;//_vcmChromeLikeTabIconUpdater_
 
implementation

uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
;

end.
