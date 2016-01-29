unit vcmChromeLikeTabCaptionProvider.imp;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , vcmExternalInterfaces
;

type
 _vcmChromeLikeTabCaptionProvider_ = class(MvcmEntityForm, IvcmFormSetCaptionProvider)
  procedure UpdateTabCaption(const aCaption: IvcmCString);
  function DoGetFormSetCaption: IvcmCString;
  function DoGetFormSetTabCaption: IvcmCString;
  function FormSetCaption: IvcmCString;
  function FormSetTabCaption: IvcmCString;
 end;//_vcmChromeLikeTabCaptionProvider_
 
implementation

uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
;

end.
