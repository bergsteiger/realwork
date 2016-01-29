unit PrimChild_Form;

interface

uses
 l3IntfUses
 , vcmContainerForm
 , F1Like_InternalOperations_Controls
 , nscFormsPageControl
 , ElPgCtl
 , vcmInterfaces
 , Controls
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
;

type
 // ChildZone
 
 // cutUsual
 
 // cutForDiction
 
 TPrimChildForm = class(TvcmContainerForm, Switcher)
  procedure AdjustSizeToFixed;
  function ChildZoneMinHeight: Integer;
  function ActivePageHasOnlyEntityForm: Boolean;
  function GrandParentProportional: Boolean;
  procedure UpdateMainTab(const aForm: IvcmEntityForm);
  procedure OnParentCanResize(Sender: TObject;
   var ANewWidth: Integer;
   var ANewHeight: Integer;
   var CanResize: Boolean);
   {* при восстановлении всех настроек и активной первой закладке не даЄм мен€ть размер и запоминаем ANewHeight }
  procedure ChildZoneChange(Sender: TObject);
  procedure vcmContainerFormAfterRemoveForm(const aForm: IvcmEntityForm);
  procedure vcmContainerFormAfterInsertForm(const aForm: IvcmEntityForm);
  procedure vcmContainerFormNeedUpdateTab(aSender: TObject;
   const aForm: IvcmEntityForm);
  procedure ChildZoneTabSheetClick(Sender: TObject;
   Page: TElTabSheet);
  procedure BecomeActive;
  procedure SetFirstPageActive;
 end;//TPrimChildForm
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Forms
 , Graphics
 , Windows
 , l3MinMax
 , nsFormUtils
 , Messages
 , PresentationInterfaces
 , vtProportionalPanel
 , afwFacade
 , l3String
 , l3Interfaces
 , l3MessageID
 , TtfwClassRef_Proxy
;

type
 THackControl = class(TControl)
 end;//THackControl
 
 Tkw_FormUserType_cutUsual = class(TtfwInteger)
  {* —лово словар€ дл€ типа формы cutUsual }
 end;//Tkw_FormUserType_cutUsual
 
 Tkw_FormUserType_cutForDiction = class(TtfwInteger)
  {* —лово словар€ дл€ типа формы cutForDiction }
 end;//Tkw_FormUserType_cutForDiction
 
end.
