unit nscTasksPanelGroup;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroup.pas"
// Стереотип: "SimpleClass"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmTasksPanel
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nscTasksPanelGroupDescList
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnscTasksPanelGroup = class(TvcmCustOpsNotifier{$If NOT Defined(NoVCM)}
 , IvcmCustOpsGroup
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , IvcmCustOpsRepGroup
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3ChangeNotifier)
  private
   f_Desc: TnscTasksPanelGroupDesc;
   f_ID: Integer;
  protected
   function As_Il3ChangeNotifier: Il3ChangeNotifier; overload;
    {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
   function As_Il3ChangeNotifier: Il3ChangeNotifier; overload;
    {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
   {$If NOT Defined(NoVCM)}
   function pm_GetPosition: Integer;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure pm_SetPosition(aValue: Integer);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
    aForAllUseCases: Boolean;
    aPosition: Integer;
    const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
    {* добавить операцию в панель задач }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetRepGroup: IvcmCustOpsRepGroup;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetCaption: IvcmCString;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure pm_SetCaption(const aValue: IvcmCString);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetId: Integer;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function Get_IsLinkToExistingControl: Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function Get_Control: TWinControl;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   constructor Create(anID: Integer;
    const aDesc: TnscTasksPanelGroupDesc); reintroduce;
   class function Make(anID: Integer;
    const aDesc: TnscTasksPanelGroupDesc): IvcmCustOpsGroup; reintroduce;
 end;//TnscTasksPanelGroup
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

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
end;//TnscTasksPanelGroup.Make

function TnscTasksPanelGroup.As_Il3ChangeNotifier: Il3ChangeNotifier;
 {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
begin
 Result := Self;
end;//TnscTasksPanelGroup.As_Il3ChangeNotifier

function TnscTasksPanelGroup.As_Il3ChangeNotifier: Il3ChangeNotifier;
 {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
begin
 Result := Self;
end;//TnscTasksPanelGroup.As_Il3ChangeNotifier

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetPosition: Integer;
//#UC START# *4992FD01012E_4D34310D0115get_var*
//#UC END# *4992FD01012E_4D34310D0115get_var*
begin
//#UC START# *4992FD01012E_4D34310D0115get_impl*
 Result := f_ID;
//#UC END# *4992FD01012E_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetPosition
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTasksPanelGroup.pm_SetPosition(aValue: Integer);
//#UC START# *4992FD01012E_4D34310D0115set_var*
//#UC END# *4992FD01012E_4D34310D0115set_var*
begin
//#UC START# *4992FD01012E_4D34310D0115set_impl*
 Assert(false);
//#UC END# *4992FD01012E_4D34310D0115set_impl*
end;//TnscTasksPanelGroup.pm_SetPosition
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.AddOperation(const aRepOp: IvcmCustOpsRepOperation;
 aForAllUseCases: Boolean;
 aPosition: Integer;
 const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
 {* добавить операцию в панель задач }
//#UC START# *4992FD32031B_4D34310D0115_var*
//#UC END# *4992FD32031B_4D34310D0115_var*
begin
//#UC START# *4992FD32031B_4D34310D0115_impl*
 Assert(false);
//#UC END# *4992FD32031B_4D34310D0115_impl*
end;//TnscTasksPanelGroup.AddOperation
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetOperations: IvcmCustOpsGroupOperationsIterator;
//#UC START# *4992FD530270_4D34310D0115get_var*
//#UC END# *4992FD530270_4D34310D0115get_var*
begin
//#UC START# *4992FD530270_4D34310D0115get_impl*
 Result := nil;
//#UC END# *4992FD530270_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetOperations
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetRepGroup: IvcmCustOpsRepGroup;
//#UC START# *4992FD8302D9_4D34310D0115get_var*
//#UC END# *4992FD8302D9_4D34310D0115get_var*
begin
//#UC START# *4992FD8302D9_4D34310D0115get_impl*
 Result := Self;
//#UC END# *4992FD8302D9_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetRepGroup
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetCaption: IvcmCString;
//#UC START# *4992FF4F02E2_4D34310D0115get_var*
//#UC END# *4992FF4F02E2_4D34310D0115get_var*
begin
//#UC START# *4992FF4F02E2_4D34310D0115get_impl*
 Result := f_Desc.rCaption.AsCStr;
//#UC END# *4992FF4F02E2_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TnscTasksPanelGroup.pm_SetCaption(const aValue: IvcmCString);
//#UC START# *4992FF4F02E2_4D34310D0115set_var*
//#UC END# *4992FF4F02E2_4D34310D0115set_var*
begin
//#UC START# *4992FF4F02E2_4D34310D0115set_impl*
 Assert(false);
//#UC END# *4992FF4F02E2_4D34310D0115set_impl*
end;//TnscTasksPanelGroup.pm_SetCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.pm_GetId: Integer;
//#UC START# *4992FF64034E_4D34310D0115get_var*
//#UC END# *4992FF64034E_4D34310D0115get_var*
begin
//#UC START# *4992FF64034E_4D34310D0115get_impl*
 Result := f_ID;
//#UC END# *4992FF64034E_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.pm_GetId
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.Get_IsLinkToExistingControl: Boolean;
//#UC START# *4D346D3403BD_4D34310D0115get_var*
//#UC END# *4D346D3403BD_4D34310D0115get_var*
begin
//#UC START# *4D346D3403BD_4D34310D0115get_impl*
 Result := true;
//#UC END# *4D346D3403BD_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.Get_IsLinkToExistingControl
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroup.Get_Control: TWinControl;
//#UC START# *4D346D830170_4D34310D0115get_var*
//#UC END# *4D346D830170_4D34310D0115get_var*
begin
//#UC START# *4D346D830170_4D34310D0115get_impl*
 Result := f_Desc.rControl;
//#UC END# *4D346D830170_4D34310D0115get_impl*
end;//TnscTasksPanelGroup.Get_Control
{$IfEnd} // NOT Defined(NoVCM)

procedure TnscTasksPanelGroup.ClearFields;
begin
 Finalize(f_Desc);
 inherited;
end;//TnscTasksPanelGroup.ClearFields
{$IfEnd} // Defined(Nemesis)

end.
