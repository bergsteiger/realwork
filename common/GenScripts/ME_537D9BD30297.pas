unit vcmContainedForm.imp;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , vcmTabbedContainerForm
 , Windows
 , vcmMainForm
 , Forms
 , Controls
;

type
 _vcmContainedForm_ = class(MvcmMainForm, IvcmFormSetIconProvider, IvcmSizeableForm, IvcmContainedForm)
  function NeedMakeContainer: Boolean;
  function NeedUseTabs: Boolean;
  function MakeVCMContainer(aOpenKind: TvcmMainFormOpenKind): IvcmContainer;
  procedure ResetFocusedControl;
  procedure DoOnContainerIsClosing;
  procedure DoInitContainedForm(aForm: TvcmMainForm);
  function DoOpenNew(aOpenKind: TvcmMainFormOpenKind): IvcmContainedForm;
  function FormSetImageIndex: Integer;
  function CanChangeSize: Boolean;
  function CanBeMaximized: Boolean;
  procedure NotifyContainerIsClosing;
  function IsEmpty: Boolean;
  function CanDefineFormSetIcon: Boolean;
  procedure InitContainedForm;
  procedure SaveFocusedControl;
  procedure RestoreFocusedControl;
  function OpenNew(aOpenKind: TvcmMainFormOpenKind): IvcmContainedForm;
  function AsForm: IvcmEntityForm;
  procedure CloseContainedForm;
  function ContainedFormHistory: IvcmHistory;
  procedure StartTabHistoryOperation;
  procedure FinishTabHistoryOperation;
  function IsInHistoryOperation: Boolean;
 end;//_vcmContainedForm_
 
implementation

uses
 l3ImplUses
 , vcmTabbedContainerFormDispatcher
;

type
 THackCustomForm = class(TScrollingWinControl)
 end;//THackCustomForm
 
end.
