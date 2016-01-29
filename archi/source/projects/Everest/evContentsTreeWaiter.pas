unit evContentsTreeWaiter;

interface

uses
  nevTools,
  l3Tool,
  nevBase
  ;

type
 TevContentsTreeWaiter = class(Tl3Tool, InevWaiter)
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

implementation

uses
  MainEditor,
  EdWin,
  l3Interfaces,
  l3Base
  ;

// start class TarContentsTreeWaiter

class function TevContentsTreeWaiter.Make(const aControl: InevControl): InevWaiter;
var
 l_Waiter: TevContentsTreeWaiter;
begin
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
end;//TevContentsTreeWaiter.Make

function TevContentsTreeWaiter.TrySelect(const aContainer: InevDocumentContainer): Boolean;
begin
 with MainForm.ActiveEditor do
 begin
  outExplorer.TreeStruct := aContainer.ContentsTree;
  outExplorer.Changed;
 end; // with MainForm.ActiveEditor do
end;//TevContentsTreeWaiter.TrySelect

function TevContentsTreeWaiter.TrySelectObj(const aContainer: InevDocumentContainer;
  aParent: Tl3Variant;
  aChild: Tl3Variant): Boolean;
begin
end;//TevContentsTreeWaiter.TrySelectObj

end.