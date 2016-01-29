unit nscTasksPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Nemesis/nscTasksPanel.pas"
// �����: 11.01.2011 14:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanel
//
// ���������� ������ �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  afwInterfaces
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
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTasksPanel = class(TvcmCustOpsNotifier {$If not defined(NoVCM)}, IvcmCustOps{$IfEnd} //not NoVCM
 )
  {* ���������� ������ ����� }
 private
 // private fields
   f_Groups : TnscTasksPanelGroupDescList;
   f_BaseSettingId : TafwSettingId;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
     {* �������� ������ ����������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
     {* ������� ������ ����������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
    aPosition: Integer): IvcmCustOpsGroup;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Refresh;
     {* ��������� ���������� �������� ������ �����. ������������ ���
              ������������ ������������ }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetGroups: IvcmCustOpsGroupsIterator;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetBaseSettingId: TafwSettingId;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function pm_GetEnableSaveToSettings: Boolean;
   procedure pm_SetEnableSaveToSettings(aValue: Boolean);
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(const aBaseSettingId: TafwSettingId;
     const aGroups: array of TnscTasksPanelGroupDesc); reintroduce;
   class function Make(const aBaseSettingId: TafwSettingId;
     const aGroups: array of TnscTasksPanelGroupDesc): IvcmCustOps; reintroduce;
     {* ��������� ������� TnscTasksPanel.Make }
 protected
 // ������ �������������� � ����������� �����������
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
 end;//TnscTasksPanel
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  nscTasksPanelGroupsIterator,
  SysUtils,
  l3Base
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTasksPanel

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
end;

{$If not defined(NoVCM)}
function TnscTasksPanel.AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
//#UC START# *4992FFB7015F_4D342DED0196_var*
//#UC END# *4992FFB7015F_4D342DED0196_var*
begin
//#UC START# *4992FFB7015F_4D342DED0196_impl*
 Result := nil;
 Assert(false);
//#UC END# *4992FFB7015F_4D342DED0196_impl*
end;//TnscTasksPanel.AddRepGroup
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TnscTasksPanel.DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
//#UC START# *4992FFC802A3_4D342DED0196_var*
//#UC END# *4992FFC802A3_4D342DED0196_var*
begin
//#UC START# *4992FFC802A3_4D342DED0196_impl*
 Assert(false);
//#UC END# *4992FFC802A3_4D342DED0196_impl*
end;//TnscTasksPanel.DeleteRepGroup
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TnscTasksPanel.Refresh;
//#UC START# *4992FFEF01FB_4D342DED0196_var*
//#UC END# *4992FFEF01FB_4D342DED0196_var*
begin
//#UC START# *4992FFEF01FB_4D342DED0196_impl*
 Assert(false);
//#UC END# *4992FFEF01FB_4D342DED0196_impl*
end;//TnscTasksPanel.Refresh
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanel.pm_GetRepGroupsOperations: IvcmCustOpsRepGroupsOperationsIterator;
//#UC START# *4993000E000A_4D342DED0196get_var*
//#UC END# *4993000E000A_4D342DED0196get_var*
begin
//#UC START# *4993000E000A_4D342DED0196get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4993000E000A_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetRepGroupsOperations
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanel.pm_GetRepGroups: IvcmCustOpsRepGroupsIterator;
//#UC START# *4993002B01F4_4D342DED0196get_var*
//#UC END# *4993002B01F4_4D342DED0196get_var*
begin
//#UC START# *4993002B01F4_4D342DED0196get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4993002B01F4_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetRepGroups
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanel.pm_GetGroups: IvcmCustOpsGroupsIterator;
//#UC START# *4993004300B5_4D342DED0196get_var*
//#UC END# *4993004300B5_4D342DED0196get_var*
begin
//#UC START# *4993004300B5_4D342DED0196get_impl*
 Result := TnscTasksPanelGroupsIterator.Make(f_Groups);
//#UC END# *4993004300B5_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetGroups
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanel.pm_GetBaseSettingId: TafwSettingId;
//#UC START# *49930056007C_4D342DED0196get_var*
//#UC END# *49930056007C_4D342DED0196get_var*
begin
//#UC START# *49930056007C_4D342DED0196get_impl*
 Result := f_BaseSettingId;
//#UC END# *49930056007C_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetBaseSettingId
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TnscTasksPanel.pm_GetEnableSaveToSettings: Boolean;
//#UC START# *4F619F340358_4D342DED0196get_var*
//#UC END# *4F619F340358_4D342DED0196get_var*
begin
//#UC START# *4F619F340358_4D342DED0196get_impl*
 Result := false;
 Assert(false);
//#UC END# *4F619F340358_4D342DED0196get_impl*
end;//TnscTasksPanel.pm_GetEnableSaveToSettings
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TnscTasksPanel.pm_SetEnableSaveToSettings(aValue: Boolean);
//#UC START# *4F619F340358_4D342DED0196set_var*
//#UC END# *4F619F340358_4D342DED0196set_var*
begin
//#UC START# *4F619F340358_4D342DED0196set_impl*
 Assert(false);
//#UC END# *4F619F340358_4D342DED0196set_impl*
end;//TnscTasksPanel.pm_SetEnableSaveToSettings
{$IfEnd} //not NoVCM

procedure TnscTasksPanel.Cleanup;
//#UC START# *479731C50290_4D342DED0196_var*
//#UC END# *479731C50290_4D342DED0196_var*
begin
//#UC START# *479731C50290_4D342DED0196_impl*
 FreeAndNil(f_Groups);
 inherited;
//#UC END# *479731C50290_4D342DED0196_impl*
end;//TnscTasksPanel.Cleanup

// ������ �������������� � ����������� �����������

function TnscTasksPanel.As_Il3ChangeNotifier: Il3ChangeNotifier;
begin
 Result := Self;
end;

{$IfEnd} //Nemesis

end.