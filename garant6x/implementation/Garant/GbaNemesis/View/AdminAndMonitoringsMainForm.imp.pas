{$IfNDef AdminAndMonitoringsMainForm_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/AdminAndMonitoringsMainForm.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Common For Admin And Monitoring::View::MainForm::AdminAndMonitoringsMainForm
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define AdminAndMonitoringsMainForm_imp}
 _AdminAndMonitoringsMainForm_ = {abstract mixin} class(_AdminAndMonitoringsMainForm_Parent_)
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
   procedure LoadSettings; override;
 end;//_AdminAndMonitoringsMainForm_

{$Else AdminAndMonitoringsMainForm_imp}

// start class _AdminAndMonitoringsMainForm_

{$If not defined(NoVCM)}
procedure _AdminAndMonitoringsMainForm_.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4F7C1E96000A_var*
//#UC END# *49803F5503AA_4F7C1E96000A_var*
begin
//#UC START# *49803F5503AA_4F7C1E96000A_impl*
 inherited;
 with Dispatcher do
 begin
  FormDispatcher.Lock;
  try
   // ������� ��������������� ��������:
   ChildZonePanel.Hide;
   LoadSettings;
  finally
   FormDispatcher.UnLock;
  end;//try..finally
 end;//with Dispatcher
//#UC END# *49803F5503AA_4F7C1E96000A_impl*
end;//_AdminAndMonitoringsMainForm_.DoInit
{$IfEnd} //not NoVCM

procedure _AdminAndMonitoringsMainForm_.LoadSettings;
//#UC START# *4F7B0815025A_4F7C1E96000A_var*
const
 cMaximized: TvcmPathPair = (rName: 'Maximized');
var
 l_Path      : TvcmPathPairs;
 l_PPath     : TvcmPathPairs;
 l_Maximized : Boolean;
//#UC END# *4F7B0815025A_4F7C1E96000A_var*
begin
//#UC START# *4F7B0815025A_4F7C1E96000A_impl*
 inherited;
 vcmGetFormPath(Self, l_Path);
 vcmCatPath(l_Path, cMaximized, l_PPath);
 if not vcmLoadBoolParam(l_PPath, l_Maximized) then //����� ��������� ���
  WindowState := wsMaximized;
//#UC END# *4F7B0815025A_4F7C1E96000A_impl*
end;//_AdminAndMonitoringsMainForm_.LoadSettings

{$EndIf AdminAndMonitoringsMainForm_imp}
