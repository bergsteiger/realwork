unit NOT_FINISHED_evEditorWithOperations;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evEditorWithOperations.pas"
// Начат: 25.11.2004 11:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevEditorWithOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3InternalInterfaces,
  Types,
  evCustomEditor
  ;

type
 TevEditorProvideOperationType = (
  {* Операции которые публикует редактор. }
   potEdit // редактирование текста
 , potTable // работа с таблицами
 , potFontStyle // стиль текста
 , potPrint // операции печати
 , potText
 );//TevEditorProvideOperationType

 TevEditorProvideOperationTypes = set of TevEditorProvideOperationType;

 TevEditorWithOperations = class(TevCustomEditor {$If not defined(NoVCM)}, IvcmOperationsProvider{$IfEnd} //not NoVCM
 , Il3CommandPublisherInfo)
 private
 // private fields
   f_ProvideOperationTypes : TevEditorProvideOperationTypes;
   f_Published : Boolean;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure ProvideOps(const aPublisher: IvcmOperationsPublisher);
     {* предоставить список доступных операций. }
   {$IfEnd} //not NoVCM
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
 protected
 // protected methods
    {$If not defined(NoVCM)}
   function TextGetTarget(const aPt: TPoint;
     out theTarget: IUnknown): Boolean; virtual;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function CanCut: Boolean; virtual;
    {$IfEnd} //not NoVCM
   function DefineProvideOperations: TevEditorProvideOperationTypes; virtual;
     {* Какие операции публикуются компонентом. }
   {$If not defined(NoVCM)}
   procedure OpSelectAll(const aParams: IvcmExecuteParamsPrim); virtual;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure TestSelectAll(const aParams: IvcmTestParamsPrim); virtual;
   {$IfEnd} //not NoVCM
   function IsCommandPublished(Cmd: Tl3OperationCode): Boolean; virtual;
 public
 // public methods
   function IsReadOnlyTarget(const aTarget: IUnknown): Boolean; virtual;
 end;//TevEditorWithOperations

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TevEditorWithOperations

{$If not defined(NoVCM)}
function TevEditorWithOperations.TextGetTarget(const aPt: TPoint;
  out theTarget: IUnknown): Boolean;
//#UC START# *54C0FF240304_4829D85C03C1_var*
//#UC END# *54C0FF240304_4829D85C03C1_var*
begin
//#UC START# *54C0FF240304_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FF240304_4829D85C03C1_impl*
end;//TevEditorWithOperations.TextGetTarget
{$IfEnd} //not NoVCM

function TevEditorWithOperations.IsReadOnlyTarget(const aTarget: IUnknown): Boolean;
//#UC START# *54C0FFEF0266_4829D85C03C1_var*
//#UC END# *54C0FFEF0266_4829D85C03C1_var*
begin
//#UC START# *54C0FFEF0266_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C0FFEF0266_4829D85C03C1_impl*
end;//TevEditorWithOperations.IsReadOnlyTarget

{$If not defined(NoVCM)}
function TevEditorWithOperations.CanCut: Boolean;
//#UC START# *54C1051E0360_4829D85C03C1_var*
//#UC END# *54C1051E0360_4829D85C03C1_var*
begin
//#UC START# *54C1051E0360_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *54C1051E0360_4829D85C03C1_impl*
end;//TevEditorWithOperations.CanCut
{$IfEnd} //not NoVCM

function TevEditorWithOperations.DefineProvideOperations: TevEditorProvideOperationTypes;
//#UC START# *48735C4A03C3_4829D85C03C1_var*
//#UC END# *48735C4A03C3_4829D85C03C1_var*
begin
//#UC START# *48735C4A03C3_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48735C4A03C3_4829D85C03C1_impl*
end;//TevEditorWithOperations.DefineProvideOperations

{$If not defined(NoVCM)}
procedure TevEditorWithOperations.OpSelectAll(const aParams: IvcmExecuteParamsPrim);
//#UC START# *48E228CC0396_4829D85C03C1_var*
//#UC END# *48E228CC0396_4829D85C03C1_var*
begin
//#UC START# *48E228CC0396_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E228CC0396_4829D85C03C1_impl*
end;//TevEditorWithOperations.OpSelectAll
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TevEditorWithOperations.TestSelectAll(const aParams: IvcmTestParamsPrim);
//#UC START# *48E228DB0194_4829D85C03C1_var*
//#UC END# *48E228DB0194_4829D85C03C1_var*
begin
//#UC START# *48E228DB0194_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E228DB0194_4829D85C03C1_impl*
end;//TevEditorWithOperations.TestSelectAll
{$IfEnd} //not NoVCM

function TevEditorWithOperations.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *4B309684022A_4829D85C03C1_var*
//#UC END# *4B309684022A_4829D85C03C1_var*
begin
//#UC START# *4B309684022A_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B309684022A_4829D85C03C1_impl*
end;//TevEditorWithOperations.IsCommandPublished

{$If not defined(NoVCM)}
procedure TevEditorWithOperations.ProvideOps(const aPublisher: IvcmOperationsPublisher);
//#UC START# *4769552100DD_4829D85C03C1_var*
//#UC END# *4769552100DD_4829D85C03C1_var*
begin
//#UC START# *4769552100DD_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4769552100DD_4829D85C03C1_impl*
end;//TevEditorWithOperations.ProvideOps
{$IfEnd} //not NoVCM

function TevEditorWithOperations.IsCommandPublished(Cmd: Tl3OperationCode): Boolean;
//#UC START# *476BFD420341_4829D85C03C1_var*
//#UC END# *476BFD420341_4829D85C03C1_var*
begin
//#UC START# *476BFD420341_4829D85C03C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *476BFD420341_4829D85C03C1_impl*
end;//TevEditorWithOperations.IsCommandPublished

initialization
{$If not defined(NoScripts)}
// Регистрация TevEditorWithOperations
 TtfwClassRef.Register(TevEditorWithOperations);
{$IfEnd} //not NoScripts

end.