unit arContentsTreeWaiter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Main"
// Модуль: "w:/archi/source/projects/Archi/Main/arContentsTreeWaiter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Main::MainWindows::TarContentsTreeWaiter
//
// Ожидальщик окончания загрузки документа для подключения дерева.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  nevTools,
  l3Tool,
  l3Variant
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarContentsTreeWaiter = class(Tl3Tool, InevWaiter)
  {* Ожидальщик окончания загрузки документа для подключения дерева. }
 protected
 // realized methods
   function TrySelect(const aContainer: InevDocumentContainer): Boolean;
   function TrySelectObj(const aContainer: InevDocumentContainer;
     aParent: Tl3Variant;
     aChild: Tl3Variant): Boolean;
 public
 // public methods
   class function Make(const aControl: InevControl): InevWaiter;
 end;//TarContentsTreeWaiter
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  Main,
  Editwin,
  l3Interfaces,
  l3Base
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarContentsTreeWaiter

class function TarContentsTreeWaiter.Make(const aControl: InevControl): InevWaiter;
//#UC START# *4E008700020B_4E00671D02B5_var*
var
 l_Waiter: TarContentsTreeWaiter;
//#UC END# *4E008700020B_4E00671D02B5_var*
begin
//#UC START# *4E008700020B_4E00671D02B5_impl*
 if (aControl = nil) then
  Result := nil
 else
 begin
  l_Waiter := Create(aControl As Il3ToolOwner);
  try
   Result := l_Waiter;
  finally
   l3Free(l_Waiter);
  end;//try..finally
 end;
//#UC END# *4E008700020B_4E00671D02B5_impl*
end;//TarContentsTreeWaiter.Make

function TarContentsTreeWaiter.TrySelect(const aContainer: InevDocumentContainer): Boolean;
//#UC START# *47C6B3040133_4E00671D02B5_var*
//#UC END# *47C6B3040133_4E00671D02B5_var*
begin
//#UC START# *47C6B3040133_4E00671D02B5_impl*
 if (MainForm.ActiveMDIChild <> nil) and (MainForm.ActiveMDIChild is TDocEditorWindow) then
  with (MainForm.ActiveMDIChild as TDocEditorWindow) do
  begin
   otlBlocks.TreeStruct := aContainer.ContentsTree;
   cbClassSubs.TreeStruct := aContainer.ContentsTree;
   otlBlocks.Changed;
  end; // with (MainForm.ActiveMDIChild as TDocEditorWindow) do
//#UC END# *47C6B3040133_4E00671D02B5_impl*
end;//TarContentsTreeWaiter.TrySelect

function TarContentsTreeWaiter.TrySelectObj(const aContainer: InevDocumentContainer;
  aParent: Tl3Variant;
  aChild: Tl3Variant): Boolean;
//#UC START# *47C6B30F0277_4E00671D02B5_var*
//#UC END# *47C6B30F0277_4E00671D02B5_var*
begin
//#UC START# *47C6B30F0277_4E00671D02B5_impl*
 //#UC END# *47C6B30F0277_4E00671D02B5_impl*
end;//TarContentsTreeWaiter.TrySelectObj

{$IfEnd} //AppClientSide

end.