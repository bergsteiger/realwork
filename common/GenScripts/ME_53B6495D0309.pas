unit vcmChromeLikeTabUpdater.imp;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , vcmUserControls
 , vcmExternalInterfaces
;

type
 _vcmChromeLikeTabUpdater_ = class(MvcmContainerForm, IvcmFormSetIconProvider)
  function DoGetFormSetImageIndex: Integer;
  procedure UpdateChromeLikeTab;
  function NeedUpdateChromeLikeTab: Boolean;
  function NeedUpdateChromeLikeTabCaption(const aCaption: IvcmCString): Boolean;
  procedure UpdateChromeLikeTabCaption(const aCaption: IvcmCString);
  function FormSetImageIndex: Integer;
  function CanDefineFormSetIcon: Boolean;
 end;//_vcmChromeLikeTabUpdater_
 
implementation

uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
 , l3Interfaces
 , l3String
;

end.
