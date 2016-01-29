{$IfNDef RegionableControl_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SkinnedControls"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/SkinnedControls/RegionableControl.imp.pas"
// Начат: 27.10.2010 16:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GUIControlMixIn::Class>> Shared Delphi::SkinnedControls::Core::RegionableControl
//
// Контрол с поддержкой регионов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RegionableControl_imp}
 _RegionableControl_ = {mixin} class(_RegionableControl_Parent_)
  {* Контрол с поддержкой регионов }
 private
 // private fields
   f_Reg : Tl3Region;
 private
 // private methods
   procedure UpdateRegion;
   procedure ClearRegion;
   procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   procedure DestroyWnd; override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   procedure Resize; override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   procedure VisibleChanging; override;
   {$IfEnd} //not NoVCL
 protected
 // protected methods
   procedure TuneRegion(aRegion: Tl3Region); virtual;
 end;//_RegionableControl_

{$Else RegionableControl_imp}

// start class _RegionableControl_

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
//#UC START# *479731C50290_4CC81FB7008B_var*
//#UC END# *479731C50290_4CC81FB7008B_var*
begin
//#UC START# *479731C50290_4CC81FB7008B_impl*
 ClearRegion;
 FreeAndNil(f_Reg);
 inherited;
//#UC END# *479731C50290_4CC81FB7008B_impl*
end;//_RegionableControl_.Cleanup

{$If not defined(NoVCL)}
procedure _RegionableControl_.CreateWnd;
//#UC START# *4CC8414403B8_4CC81FB7008B_var*
//#UC END# *4CC8414403B8_4CC81FB7008B_var*
begin
//#UC START# *4CC8414403B8_4CC81FB7008B_impl*
 inherited;
 UpdateRegion;
//#UC END# *4CC8414403B8_4CC81FB7008B_impl*
end;//_RegionableControl_.CreateWnd
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure _RegionableControl_.DestroyWnd;
//#UC START# *4CC841540158_4CC81FB7008B_var*
//#UC END# *4CC841540158_4CC81FB7008B_var*
begin
//#UC START# *4CC841540158_4CC81FB7008B_impl*
 ClearRegion;
 inherited;
//#UC END# *4CC841540158_4CC81FB7008B_impl*
end;//_RegionableControl_.DestroyWnd
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure _RegionableControl_.Resize;
//#UC START# *4CC8417A0288_4CC81FB7008B_var*
//#UC END# *4CC8417A0288_4CC81FB7008B_var*
begin
//#UC START# *4CC8417A0288_4CC81FB7008B_impl*
 inherited;
 UpdateRegion;
//#UC END# *4CC8417A0288_4CC81FB7008B_impl*
end;//_RegionableControl_.Resize
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure _RegionableControl_.VisibleChanging;
//#UC START# *4CC8658C017B_4CC81FB7008B_var*
//#UC END# *4CC8658C017B_4CC81FB7008B_var*
begin
//#UC START# *4CC8658C017B_4CC81FB7008B_impl*
 inherited;
 //UpdateRegion;
//#UC END# *4CC8658C017B_4CC81FB7008B_impl*
end;//_RegionableControl_.VisibleChanging
{$IfEnd} //not NoVCL

{$EndIf RegionableControl_imp}
