unit vcmForm;

interface

uses
 l3IntfUses
 , vcmUserInteractiveForm
 , Forms
 , afwInterfaces
 , vcmLayoutImplementation
;

type
 TvcmCloseQueryEvent = procedure(Sender: TObject;
  var CanClose: Boolean;
  aCaller: TCustomForm) of object;
 
 TvcmInterfacedForm = class(TvcmUserInteractiveForm)
  procedure DoSaveInSettings;
  function NeedSaveInSettings: Boolean;
  procedure ClearModal;
  function SafeClose: Boolean;
  function CallCloseQuery(aCaller: TCustomForm): Boolean;
 end;//TvcmInterfacedForm
 
 TvcmTextForm = class(TvcmInterfacedForm, IafwTextControl)
  function CCaption: IafwCString;
  function SafeClose: Boolean;
 end;//TvcmTextForm
 
 TvcmFormImplementation = class(TvcmLayoutImplementation)
 end;//TvcmFormImplementation
 
 TvcmForm = class(TvcmTextForm)
  procedure DoLoadFromSettings;
  function NeedNotifyContainerOnCaptionChanged: Boolean;
  function IsAcceptable(aDataUpdate: Boolean): Boolean;
   {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
 end;//TvcmForm
 
 TvcmCloseQueryEvent = procedure(Sender: TObject;
  var CanClose: Boolean;
  aCaller: TCustomForm) of object;
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , vcmDialogs
 , vtDialogsResEx
;

end.
