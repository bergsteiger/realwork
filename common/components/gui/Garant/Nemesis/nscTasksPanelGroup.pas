unit nscTasksPanelGroup;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTasksPanelGroup.pas"
// Начат: 17.01.2011 15:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanelGroup
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmTasksPanel
  {$IfEnd} //not NoVCM
  ,
  nscTasksPanelGroupDescList,
  l3Interfaces {a}
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTasksPanelGroup = class(TvcmCustOpsNotifier {$If not defined(NoVCM)}, IvcmCustOpsGroup{$IfEnd} //not NoVCM
  {$If not defined(NoVCM)}, IvcmCustOpsRepGroup{$IfEnd} //not NoVCM
 )
 private
 // private fields
   f_Desc : TnscTasksPanelGroupDesc;
   f_ID : Integer;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function pm_GetPosition: Integer;
   procedure pm_SetPosition(aValue: Integer);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
    aForAllUseCases: Boolean;
    aPosition: Integer;
    const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
     {* добавить операцию в панель задач }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetRepGroup: IvcmCustOpsRepGroup;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetCaption: IvcmCString;
   procedure pm_SetCaption(const aValue: IvcmCString);
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetId: Integer;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_IsLinkToExistingControl: Boolean;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_Control: TWinControl;
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(anID: Integer;
     const aDesc: TnscTasksPanelGroupDesc); reintroduce;
   class function Make(anID: Integer;
     const aDesc: TnscTasksPanelGroupDesc): IvcmCustOpsGroup; reintroduce;
     {* Сигнатура фабрики TnscTasksPanelGroup.Make }
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
 end;//TnscTasksPanelGroup
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TnscTasksPanelGroup

constructor TnscTasksPanelGroup.Create(anID: Integer;
  const aDesc: TnscTasksPanelGroupDesc);
//#UC START# *4D3454300132_4D34310D0115_var*
//#UC END# *4D3454300132_4D34310D0115_var*
begin
//#UC START# *4D3454300132_4D34310D0115_impl*
 inherited Create;
 f_Desc := aDesc;
 f_ID := anID;
//#UC END# *4D3454300132_4D34310D0115_impl*
end;//TnscTasksPanelGroup.Create

class function TnscTasksPanelGroup.Make(anID: Integer;
  const aDesc: TnscTasksPanelGroupDesc): IvcmCustOpsGroup;
var
 l_Inst : TnscTasksPanelGroup;
begin
 l_Inst := Create(anID, aDesc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetPosition: Integer;
//#UC START# *4992FD01012E_4D34310D0115get_var*
//#UC END# *4992FD01012E_4D34310D0115get_var*
begin
//#UC START# *4992FD01012E_4D34310D0115get_impl*
 Result := f_ID;
//#UC END# *4992FD01012E_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetPosition
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TnscTasksPanelGroup.pm_SetPosition(aValue: Integer);
//#UC START# *4992FD01012E_4D34310D0115set_var*
//#UC END# *4992FD01012E_4D34310D0115set_var*
begin
//#UC START# *4992FD01012E_4D34310D0115set_impl*
 Assert(false);
//#UC END# *4992FD01012E_4D34310D0115set_impl*
end;//TnscTasksPanelGroup.pm_SetPosition
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.AddOperation(const aRepOp: IvcmCustOpsRepOperation;
  aForAllUseCases: Boolean;
  aPosition: Integer;
  const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
//#UC START# *4992FD32031B_4D34310D0115_var*
//#UC END# *4992FD32031B_4D34310D0115_var*
begin
//#UC START# *4992FD32031B_4D34310D0115_impl*
 Assert(false);
//#UC END# *4992FD32031B_4D34310D0115_impl*
end;//TnscTasksPanelGroup.AddOperation
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
//#UC START# *4992FD530270_4D34310D0115get_var*
//#UC END# *4992FD530270_4D34310D0115get_var*
begin
//#UC START# *4992FD530270_4D34310D0115get_impl*
 Result := nil;
//#UC END# *4992FD530270_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetOperations
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetRepGroup: IvcmCustOpsRepGroup;
//#UC START# *4992FD8302D9_4D34310D0115get_var*
//#UC END# *4992FD8302D9_4D34310D0115get_var*
begin
//#UC START# *4992FD8302D9_4D34310D0115get_impl*
 Result := Self;
//#UC END# *4992FD8302D9_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetRepGroup
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetCaption: IvcmCString;
//#UC START# *4992FF4F02E2_4D34310D0115get_var*
//#UC END# *4992FF4F02E2_4D34310D0115get_var*
begin
//#UC START# *4992FF4F02E2_4D34310D0115get_impl*
 Result := f_Desc.rCaption.AsCStr;
//#UC END# *4992FF4F02E2_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TnscTasksPanelGroup.pm_SetCaption(const aValue: IvcmCString);
//#UC START# *4992FF4F02E2_4D34310D0115set_var*
//#UC END# *4992FF4F02E2_4D34310D0115set_var*
begin
//#UC START# *4992FF4F02E2_4D34310D0115set_impl*
 Assert(false);
//#UC END# *4992FF4F02E2_4D34310D0115set_impl*
end;//TnscTasksPanelGroup.pm_SetCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetId: Integer;
//#UC START# *4992FF64034E_4D34310D0115get_var*
//#UC END# *4992FF64034E_4D34310D0115get_var*
begin
//#UC START# *4992FF64034E_4D34310D0115get_impl*
 Result := f_ID;
//#UC END# *4992FF64034E_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetId
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.Get_IsLinkToExistingControl: Boolean;
//#UC START# *4D346D3403BD_4D34310D0115get_var*
//#UC END# *4D346D3403BD_4D34310D0115get_var*
begin
//#UC START# *4D346D3403BD_4D34310D0115get_impl*
 Result := true;
//#UC END# *4D346D3403BD_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.Get_IsLinkToExistingControl
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanelGroup.Get_Control: TWinControl;
//#UC START# *4D346D830170_4D34310D0115get_var*
//#UC END# *4D346D830170_4D34310D0115get_var*
begin
//#UC START# *4D346D830170_4D34310D0115get_impl*
 Result := f_Desc.rControl;
//#UC END# *4D346D830170_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.Get_Control
{$IfEnd} //not NoVCM

procedure TnscTasksPanelGroup.ClearFields;
 {-}
begin
 Finalize(f_Desc);
 inherited;
end;//TnscTasksPanelGroup.ClearFields

// Методы преобразования к реализуемым интерфейсам

function TnscTasksPanelGroup.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

{$IfEnd} //Nemesis

end.