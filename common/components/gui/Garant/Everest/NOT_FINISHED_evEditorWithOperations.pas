unit NOT_FINISHED_evEditorWithOperations;

// ћодуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evEditorWithOperations.pas"
// —тереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEditor
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3InternalInterfaces
 , l3Interfaces
 , Types
;

type
 TevEditorProvideOperationType = (
  {* ќперации которые публикует редактор. }
  potEdit
   {* редактирование текста }
  , potTable
   {* работа с таблицами }
  , potFontStyle
   {* стиль текста }
  , potPrint
   {* операции печати }
  , potText
 );//TevEditorProvideOperationType

 TevEditorProvideOperationTypes = set of TevEditorProvideOperationType;

 TevEditorWithOperations = class(TevCustomEditor{$If NOT Defined(NoVCM)}
 , IvcmOperationsProvider
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3CommandPublisherInfo)
  private
   f_ProvideOperationTypes: TevEditorProvideOperationTypes;
   f_Published: Boolean;
  protected
   {$If NOT Defined(NoVCM)}
   function TextGetTarget(const aPt: TPoint;
    out theTarget: IUnknown): Boolean; virtual;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function CanCut: Boolean; virtual;
   {$IfEnd} // NOT Defined(NoVCM)
   function DefineProvideOperations: TevEditorProvideOperationTypes; virtual;
    {*  акие операции публикуютс€ компонентом. }
   {$If NOT Defined(NoVCM)}
   procedure opSelectAll(const aParams: IvcmExecuteParamsPrim); virtual;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure testSelectAll(const aParams: IvcmTestParamsPrim); virtual;
   {$IfEnd} // NOT Defined(NoVCM)
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; overload; virtual;
   {$If NOT Defined(NoVCM)}
   procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
    {* предоставить список доступных операций. }
   {$IfEnd} // NOT Defined(NoVCM)
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; overload;
  public
   function IsReadOnlyTarget(const aTarget: IUnknown): Boolean; virtual;
 end;//TevEditorWithOperations

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
function TevEditorWithOperations.TextGetTarget(const aPt: TPoint;
 out theTarget: IUnknown): Boolean;
//#UC START# *54C0FF240304_4829D85C03C1_var*
//#UC END# *54C0FF240304_4829D85C03C1_var*
begin
//#UC START# *54C0FF240304_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FF240304_4829D85C03C1_impl*
end;//TevEditorWithOperations.TextGetTarget
{$IfEnd} // NOT Defined(NoVCM)

function TevEditorWithOperations.IsReadOnlyTarget(const aTarget: IUnknown): Boolean;
//#UC START# *54C0FFEF0266_4829D85C03C1_var*
//#UC END# *54C0FFEF0266_4829D85C03C1_var*
begin
//#UC START# *54C0FFEF0266_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FFEF0266_4829D85C03C1_impl*
end;//TevEditorWithOperations.IsReadOnlyTarget

{$If NOT Defined(NoVCM)}
function TevEditorWithOperations.CanCut: Boolean;
//#UC START# *54C1051E0360_4829D85C03C1_var*
//#UC END# *54C1051E0360_4829D85C03C1_var*
begin
//#UC START# *54C1051E0360_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C1051E0360_4829D85C03C1_impl*
end;//TevEditorWithOperations.CanCut
{$IfEnd} // NOT Defined(NoVCM)

function TevEditorWithOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
 {*  акие операции публикуютс€ компонентом. }
//#UC START# *48735C4A03C3_4829D85C03C1_var*
//#UC END# *48735C4A03C3_4829D85C03C1_var*
begin
//#UC START# *48735C4A03C3_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48735C4A03C3_4829D85C03C1_impl*
end;//TevEditorWithOperations.DefineProvideOperations

{$If NOT Defined(NoVCM)}
procedure TevEditorWithOperations.opSelectAll(const aParams: IvcmExecuteParamsPrim);
//#UC START# *48E228CC0396_4829D85C03C1_var*
//#UC END# *48E228CC0396_4829D85C03C1_var*
begin
//#UC START# *48E228CC0396_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E228CC0396_4829D85C03C1_impl*
end;//TevEditorWithOperations.opSelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TevEditorWithOperations.testSelectAll(const aParams: IvcmTestParamsPrim);
//#UC START# *48E228DB0194_4829D85C03C1_var*
//#UC END# *48E228DB0194_4829D85C03C1_var*
begin
//#UC START# *48E228DB0194_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E228DB0194_4829D85C03C1_impl*
end;//TevEditorWithOperations.testSelectAll
{$IfEnd} // NOT Defined(NoVCM)

function TevEditorWithOperations.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *4B309684022A_4829D85C03C1_var*
//#UC END# *4B309684022A_4829D85C03C1_var*
begin
//#UC START# *4B309684022A_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B309684022A_4829D85C03C1_impl*
end;//TevEditorWithOperations.IsCommandPublished

{$If NOT Defined(NoVCM)}
procedure TevEditorWithOperations.ProvideOps(const aPublisher: IvcmOperationsPublisher);
 {* предоставить список доступных операций. }
//#UC START# *4769552100DD_4829D85C03C1_var*
//#UC END# *4769552100DD_4829D85C03C1_var*
begin
//#UC START# *4769552100DD_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4769552100DD_4829D85C03C1_impl*
end;//TevEditorWithOperations.ProvideOps
{$IfEnd} // NOT Defined(NoVCM)

function TevEditorWithOperations.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *476BFD420341_4829D85C03C1_var*
//#UC END# *476BFD420341_4829D85C03C1_var*
begin
//#UC START# *476BFD420341_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *476BFD420341_4829D85C03C1_impl*
end;//TevEditorWithOperations.IsCommandPublished

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevEditorWithOperations);
 {* –егистраци€ TevEditorWithOperations }
{$IfEnd} // NOT Defined(NoScripts)

end.
