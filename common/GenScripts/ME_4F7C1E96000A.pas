{$IfNDef AdminAndMonitoringsMainForm_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas"
// Стереотип: "Impurity"

{$Define AdminAndMonitoringsMainForm_imp}

 _AdminAndMonitoringsMainForm_ = {abstract} class(_AdminAndMonitoringsMainForm_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure LoadSettings; override;
 end;//_AdminAndMonitoringsMainForm_

{$Else AdminAndMonitoringsMainForm_imp}

{$IfNDef AdminAndMonitoringsMainForm_imp_impl}

{$Define AdminAndMonitoringsMainForm_imp_impl}

{$If NOT Defined(NoVCM)}
procedure _AdminAndMonitoringsMainForm_.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4F7C1E96000A_var*
//#UC END# *49803F5503AA_4F7C1E96000A_var*
begin
//#UC START# *49803F5503AA_4F7C1E96000A_impl*
 inherited;
 with Dispatcher do
 begin
  FormDispatcher.Lock;
  try
   // Убираем вспомогательные элементы:
   ChildZonePanel.Hide;
   LoadSettings;
  finally
   FormDispatcher.UnLock;
  end;//try..finally
 end;//with Dispatcher
//#UC END# *49803F5503AA_4F7C1E96000A_impl*
end;//_AdminAndMonitoringsMainForm_.DoInit
{$IfEnd} // NOT Defined(NoVCM)

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
 if not vcmLoadBoolParam(l_PPath, l_Maximized) then //Такой настройки нет
  WindowState := wsMaximized;
//#UC END# *4F7B0815025A_4F7C1E96000A_impl*
end;//_AdminAndMonitoringsMainForm_.LoadSettings

{$EndIf AdminAndMonitoringsMainForm_imp_impl}

{$EndIf AdminAndMonitoringsMainForm_imp}

