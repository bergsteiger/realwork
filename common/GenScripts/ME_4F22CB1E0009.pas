unit vcmEntityFormModelPart;

interface

uses
 l3IntfUses
 , vcmForm
 , vcmInterfaces
 , Messages
;

type
 TvcmEntityFormModelPart = class(TvcmForm)
  function CanHaveCloseButtonInNavigator: Boolean;
  function CanHaveOwnCloseButtonInNavigator: Boolean;
  function IsBaloon: Boolean;
  procedure FormInsertedIntoContainer;
  procedure FocusIsSetToUs;
  procedure BecomeVisible;
  function IsMainObjectForm: Boolean;
  procedure BecomeInvisible;
  function DoGetCaptionForSaving: AnsiString;
  procedure WMSetFocus(var Message: TMessage);
  procedure CMVisibleChanged(var Message: TMessage);
  function NeedSetMyFocus: Boolean;
 end;//TvcmEntityFormModelPart
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , VCMFormsProcessingPack
 , vcmMainForm
 , afwFacade
;

end.
