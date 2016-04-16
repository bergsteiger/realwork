unit nscTasksPanel;
 {* Наполнение Панели Задач }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscTasksPanel" MUID: (4D342DED0196)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

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
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
;

type
 TnscTasksPanel = class({$If NOT Defined(NoVCM)}
 TvcmCustOpsNotifier
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , IvcmCustOps
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Наполнение Панели Задач }
  private
   f_Groups: TnscTasksPanelGroupDescList;
   f_BaseSettingId: TafwSettingId;
  protected
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
    {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
   {$If NOT Defined(NoVCM)}
   function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
    {* добавить группу репозитория }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
    {* удалить группу репозитория }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
    aPosition: Integer): IvcmCustOpsGroup;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Refresh;
    {* полностью перечитать операции панели задач. Используется при
              переключении конфигурации }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetGroups: IvcmCustOpsGroupsIterator;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetBaseSettingId: TafwSettingId;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function pm_GetEnableSaveToSettings: Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure pm_SetEnableSaveToSettings(aValue: Boolean);
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aBaseSettingId: TafwSettingId;
    const aGroups: array of TnscTasksPanelGroupDesc); reintroduce;
   class function Make(const aBaseSettingId: TafwSettingId;
    const aGroups: array of TnscTasksPanelGroupDesc): IvcmCustOps; reintroduce;
 end;//TnscTasksPanel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscTasksPanelGroupsIterator
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
constructor TnscTasksPanel.Create(const aBaseSettingId: TafwSettingId;
 const aGroups: array of TnscTasksPanelGroupDesc);
//#UC START# *4D34335B0113_4D342DED0196_var*
var
 l_Index : Integer;
//#UC END# *4D34335B0113_4D342DED0196_var*
begin
//#UC START# *4D34335B0113_4D342DED0196_impl*
 inherited Create;
 f_BaseSettingId := aBaseSettingId;
 f_Groups := TnscTasksPanelGroupDescList.Create;
 for l_Index := Low(aGroups) to High(aGroups) do
  f_Groups.Add(aGroups[l_Index]);
//#UC END# *4D34335B0113_4D342DED0196_impl*
end;//TnscTasksPanel.Create

class function TnscTasksPanel.Make(const aBaseSettingId: TafwSettingId;
 const aGroups: array of TnscTasksPanelGroupDesc): IvcmCustOps;
var
 l_Inst : TnscTasksPanel;
begin
 l_Inst := Create(aBaseSettingId, aGroups);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscTasksPanel.Make

function TnscTasksPanel.As_Il3ChangeNotifier: Il3ChangeNotifier;
 {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
begin
 Result := Self;
end;//TnscTasksPanel.As_Il3ChangeNotifier

function TnscTasksPanel.AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
 {* добавить группу репозитория }
//#UC START# *4992FFB7015F_4D342DED0196_var*
//#UC END# *4992FFB7015F_4D342DED0196_var*
begin
//#UC START# *4992FFB7015F_4D342DED0196_impl*
 Result := nil;
 Assert(false);
//#UC END# *4992FFB7015F_4D342DED0196_impl*
end;//TnscTasksPanel.AddRepGroup

procedure TnscTasksPanel.DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
 {* удалить группу репозитория }
//#UC START# *4992FFC802A3_4D342DED0196_var*
//#UC END# *4992FFC802A3_4D342DED0196_var*
begin
//#UC START# *4992FFC802A3_4D342DED0196_impl*
 Assert(false);
//#UC END# *4992FFC802A3_4D342DED0196_impl*
end;//TnscTasksPanel.DeleteRepGroup

function TnscTasksPanel.AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
 aPosition: Integer): IvcmCustOpsGroup;
//#UC START# *4992FFD700FC_4D342DED0196_var*
//#UC END# *4992FFD700FC_4D342DED0196_var*
begin
//#UC START# *4992FFD700FC_4D342DED0196_impl*
 Assert(false);
 Result := nil;
//#UC END# *4992FFD700FC_4D342DED0196_impl*
end;//TnscTasksPanel.AddGroup

procedure TnscTasksPanel.Refresh;
 {* полностью перечитать операции панели задач. Используется при
              переключении конфигурации }
//#UC START# *4992FFEF01FB_4D342DED0196_var*
//#UC END# *4992FFEF01FB_4D342DED0196_var*
begin
//#UC START# *4992FFEF01FB_4D342DED0196_impl*
 Assert(false);
//#UC END# *4992FFEF01FB_4D342DED0196_impl*
end;//TnscTasksPanel.Refresh

function TnscTasksPanel.pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
//#UC START# *4993000E000A_4D342DED0196get_var*
//#UC END# *4993000E000A_4D342DED0196get_var*
begin
//#UC START# *4993000E000A_4D342DED0196get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4993000E000A_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetRepGroupsOperations

function TnscTasksPanel.pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
//#UC START# *4993002B01F4_4D342DED0196get_var*
//#UC END# *4993002B01F4_4D342DED0196get_var*
begin
//#UC START# *4993002B01F4_4D342DED0196get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4993002B01F4_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetRepGroups

function TnscTasksPanel.pm_GetGroups: IvcmCustOpsGroupsIterator;
//#UC START# *4993004300B5_4D342DED0196get_var*
//#UC END# *4993004300B5_4D342DED0196get_var*
begin
//#UC START# *4993004300B5_4D342DED0196get_impl*
 Result := TnscTasksPanelGroupsIterator.Make(f_Groups);
//#UC END# *4993004300B5_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetGroups

function TnscTasksPanel.pm_GetBaseSettingId: TafwSettingId;
//#UC START# *49930056007C_4D342DED0196get_var*
//#UC END# *49930056007C_4D342DED0196get_var*
begin
//#UC START# *49930056007C_4D342DED0196get_impl*
 Result := f_BaseSettingId;
//#UC END# *49930056007C_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetBaseSettingId

function TnscTasksPanel.pm_GetEnableSaveToSettings: Boolean;
//#UC START# *4F619F340358_4D342DED0196get_var*
//#UC END# *4F619F340358_4D342DED0196get_var*
begin
//#UC START# *4F619F340358_4D342DED0196get_impl*
 Result := false;
 Assert(false);
//#UC END# *4F619F340358_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetEnableSaveToSettings

procedure TnscTasksPanel.pm_SetEnableSaveToSettings(aValue: Boolean);
//#UC START# *4F619F340358_4D342DED0196set_var*
//#UC END# *4F619F340358_4D342DED0196set_var*
begin
//#UC START# *4F619F340358_4D342DED0196set_impl*
 Assert(false);
//#UC END# *4F619F340358_4D342DED0196set_impl*
end;//TnscTasksPanel.pm_SetEnableSaveToSettings

procedure TnscTasksPanel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D342DED0196_var*
//#UC END# *479731C50290_4D342DED0196_var*
begin
//#UC START# *479731C50290_4D342DED0196_impl*
 FreeAndNil(f_Groups);
 inherited;
//#UC END# *479731C50290_4D342DED0196_impl*
end;//TnscTasksPanel.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Nemesis)
end.
