{$IfNDef RegionableControl_imp}

// Модуль: "w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas"
// Стереотип: "GUIControlMixIn"
// Элемент модели: "RegionableControl" MUID: (4CC81FB7008B)
// Имя типа: "_RegionableControl_"

{$Define RegionableControl_imp}

 _RegionableControl_ = class(_RegionableControl_Parent_)
  {* Контрол с поддержкой регионов }
  private
   f_Reg: Tl3Region;
  private
   procedure UpdateRegion;
   procedure ClearRegion;
   procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
  protected
   procedure TuneRegion(aRegion: Tl3Region); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DestroyWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Resize; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure VisibleChanging; override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//_RegionableControl_

{$Else RegionableControl_imp}

{$IfNDef RegionableControl_imp_impl}

{$Define RegionableControl_imp_impl}

procedure _RegionableControl_.UpdateRegion;
//#UC START# *4CC8471A035A_4CC81FB7008B_var*
//#UC END# *4CC8471A035A_4CC81FB7008B_var*
begin
//#UC START# *4CC8471A035A_4CC81FB7008B_impl*
 ClearRegion;
 if (f_Reg = nil) then
  f_Reg := Tl3Region.Create
 else
  f_Reg.FreeRgn;
 if (Width > 0) AND (Height > 0) AND Visible then
 begin
  if HandleAllocated then
  begin
   TuneRegion(f_Reg);
   if not f_Reg.Empty then
    SetWindowRgn(Handle, f_Reg.Rgn, true);
  end;//HandleAllocated
 end;//Visible
//#UC END# *4CC8471A035A_4CC81FB7008B_impl*
end;//_RegionableControl_.UpdateRegion

procedure _RegionableControl_.ClearRegion;
//#UC START# *4CC84762022A_4CC81FB7008B_var*
//#UC END# *4CC84762022A_4CC81FB7008B_var*
begin
//#UC START# *4CC84762022A_4CC81FB7008B_impl*
 if HandleAllocated then
  SetWindowRgn(Handle, 0, false);
//#UC END# *4CC84762022A_4CC81FB7008B_impl*
end;//_RegionableControl_.ClearRegion

procedure _RegionableControl_.TuneRegion(aRegion: Tl3Region);
//#UC START# *4CC847800383_4CC81FB7008B_var*
//#UC END# *4CC847800383_4CC81FB7008B_var*
begin
//#UC START# *4CC847800383_4CC81FB7008B_impl*
 // - ничего не делаем, полагаемся на потомков
//#UC END# *4CC847800383_4CC81FB7008B_impl*
end;//_RegionableControl_.TuneRegion

procedure _RegionableControl_.CMVisibleChanged(var Message: TMessage);
//#UC START# *4CC867FC01B3_4CC81FB7008B_var*
//#UC END# *4CC867FC01B3_4CC81FB7008B_var*
begin
//#UC START# *4CC867FC01B3_4CC81FB7008B_impl*
 inherited;
 UpdateRegion;
//#UC END# *4CC867FC01B3_4CC81FB7008B_impl*
end;//_RegionableControl_.CMVisibleChanged

procedure _RegionableControl_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CC81FB7008B_var*
//#UC END# *479731C50290_4CC81FB7008B_var*
begin
//#UC START# *479731C50290_4CC81FB7008B_impl*
 ClearRegion;
 FreeAndNil(f_Reg);
 inherited;
//#UC END# *479731C50290_4CC81FB7008B_impl*
end;//_RegionableControl_.Cleanup

{$If NOT Defined(NoVCL)}
procedure _RegionableControl_.CreateWnd;
//#UC START# *4CC8414403B8_4CC81FB7008B_var*
//#UC END# *4CC8414403B8_4CC81FB7008B_var*
begin
//#UC START# *4CC8414403B8_4CC81FB7008B_impl*
 inherited;
 UpdateRegion;
//#UC END# *4CC8414403B8_4CC81FB7008B_impl*
end;//_RegionableControl_.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure _RegionableControl_.DestroyWnd;
//#UC START# *4CC841540158_4CC81FB7008B_var*
//#UC END# *4CC841540158_4CC81FB7008B_var*
begin
//#UC START# *4CC841540158_4CC81FB7008B_impl*
 ClearRegion;
 inherited;
//#UC END# *4CC841540158_4CC81FB7008B_impl*
end;//_RegionableControl_.DestroyWnd
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure _RegionableControl_.Resize;
//#UC START# *4CC8417A0288_4CC81FB7008B_var*
//#UC END# *4CC8417A0288_4CC81FB7008B_var*
begin
//#UC START# *4CC8417A0288_4CC81FB7008B_impl*
 inherited;
 UpdateRegion;
//#UC END# *4CC8417A0288_4CC81FB7008B_impl*
end;//_RegionableControl_.Resize
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure _RegionableControl_.VisibleChanging;
//#UC START# *4CC8658C017B_4CC81FB7008B_var*
//#UC END# *4CC8658C017B_4CC81FB7008B_var*
begin
//#UC START# *4CC8658C017B_4CC81FB7008B_impl*
 inherited;
 //UpdateRegion;
//#UC END# *4CC8658C017B_4CC81FB7008B_impl*
end;//_RegionableControl_.VisibleChanging
{$IfEnd} // NOT Defined(NoVCL)

{$EndIf RegionableControl_imp_impl}

{$EndIf RegionableControl_imp}

