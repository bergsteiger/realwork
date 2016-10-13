unit msmMultiPanelViewParent;

// Модуль: "w:\common\components\gui\Garant\msm\msmMultiPanelViewParent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmMultiPanelViewParent" MUID: (57B3468D0000)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewParentPrim
 , msmControllers
 , msmViewParentControlList
 , msmViewList
 //#UC START# *57B3468D0000intf_uses*
 , Controls
 //#UC END# *57B3468D0000intf_uses*
;

type
 //#UC START# *57B3468D0000ci*
 //#UC END# *57B3468D0000ci*
 //#UC START# *57B3468D0000cit*
 //#UC END# *57B3468D0000cit*
 TmsmMultiPanelViewParent = class(TmsmViewParentPrim, ImsmViewParent)
  private
   f_Parent: TmsmViewParentControl;
   f_Parents: TmsmViewParentControlList;
   f_Views: TmsmViewList;
  protected
   function IsVert: Boolean; virtual;
   procedure InsertView(aView: TmsmView;
    const aContext: TmsmViewContext);
   procedure RemoveView(aView: TmsmView);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   constructor Create(aParent: TmsmViewParentControl); reintroduce;
   class function Make(aParent: TmsmViewParentControl): ImsmViewParent; reintroduce;
 //#UC START# *57B3468D0000publ*
 //#UC END# *57B3468D0000publ*
 end;//TmsmMultiPanelViewParent

implementation

uses
 l3ImplUses
 , msmSizeablePanel
 //#UC START# *57B3468D0000impl_uses*
 , SysUtils
 , vtSizeablePanel
 //, msmSizeablePanel
 //#UC END# *57B3468D0000impl_uses*
;

constructor TmsmMultiPanelViewParent.Create(aParent: TmsmViewParentControl);
//#UC START# *57B346D700A8_57B3468D0000_var*
//#UC END# *57B346D700A8_57B3468D0000_var*
begin
//#UC START# *57B346D700A8_57B3468D0000_impl*
 Assert(aParent <> nil);
 f_Parent := aParent;
 inherited Create;
//#UC END# *57B346D700A8_57B3468D0000_impl*
end;//TmsmMultiPanelViewParent.Create

class function TmsmMultiPanelViewParent.Make(aParent: TmsmViewParentControl): ImsmViewParent;
var
 l_Inst : TmsmMultiPanelViewParent;
begin
 l_Inst := Create(aParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmMultiPanelViewParent.Make

function TmsmMultiPanelViewParent.IsVert: Boolean;
//#UC START# *57EA4F0302FD_57B3468D0000_var*
//#UC END# *57EA4F0302FD_57B3468D0000_var*
begin
//#UC START# *57EA4F0302FD_57B3468D0000_impl*
 Result := false;
//#UC END# *57EA4F0302FD_57B3468D0000_impl*
end;//TmsmMultiPanelViewParent.IsVert

procedure TmsmMultiPanelViewParent.InsertView(aView: TmsmView;
 const aContext: TmsmViewContext);
//#UC START# *57B345EC0195_57B3468D0000_var*
var
 l_Panel : TmsmSizeablePanel;
 l_Extent : Integer;
 l_ViewCount : Integer;
 l_Index : Integer;
 l_View : TmsmView;
//#UC END# *57B345EC0195_57B3468D0000_var*
begin
//#UC START# *57B345EC0195_57B3468D0000_impl*
 Assert(f_Views.IndexOf(aView) < 0);
 //f_Parent.DisableAlign;
 try
  if f_Views.Empty then
   l_View := nil
  else
   l_View := f_Views.Last;
  f_Views.Add(aView);
  l_ViewCount := f_Views.Count;
  if (l_View = nil) then
  begin
   aView.Parent := f_Parent;
   aView.Align := alClient;
  end//l_View = nil
  else
  begin
   if IsVert then
   begin
    l_Extent := f_Parent.Height div l_ViewCount;
    for l_Index := 0 to Pred(f_Parents.Count) do
     f_Parents[l_Index].Height := l_Extent
   end//IsVert
   else
   begin
    l_Extent := f_Parent.Width div l_ViewCount;
    for l_Index := 0 to Pred(f_Parents.Count) do
     f_Parents[l_Index].Width := l_Extent;
   end;//IsVert
   l_View.Align := alNone;
   l_View.Parent := nil;
   l_Panel := TmsmSizeablePanel.Create(f_Parent);
   l_Panel.Parent := f_Parent;
   if IsVert then
   begin
    l_Panel.Height := l_Extent;
    if f_Parents.Empty then
     l_Panel.Top := 0
    else
     l_Panel.Top := f_Parents.Last.Left + f_Parents.Last.Height;
    l_Panel.Align := alTop;
    l_Panel.SizeableSides := [szBottom];
   end//IsVert
   else
   begin
    l_Panel.Width := l_Extent;
    if f_Parents.Empty then
     l_Panel.Left := 0
    else
     l_Panel.Left := f_Parents.Last.Left + f_Parents.Last.Width;
    l_Panel.Align := alLeft;
    l_Panel.SizeableSides := [szRight];
   end;//IsVert
   l_Panel.SplitterBevel := bvRaised;
   f_Parents.Add(l_Panel);
   l_View.Parent := l_Panel;
   l_View.Align := alClient;
   aView.Parent := f_Parent;
   aView.Align := alClient;
  end;//l_View = nil
 finally
  //f_Parent.EnableAlign;
 end;//try..finally
//#UC END# *57B345EC0195_57B3468D0000_impl*
end;//TmsmMultiPanelViewParent.InsertView

procedure TmsmMultiPanelViewParent.RemoveView(aView: TmsmView);
//#UC START# *57B3461C0319_57B3468D0000_var*
var
 l_Parent : TmsmViewParentControl;
//#UC END# *57B3461C0319_57B3468D0000_var*
begin
//#UC START# *57B3461C0319_57B3468D0000_impl*
 Assert(f_Views.IndexOf(aView) >= 0);
 l_Parent := aView.Parent;
 if (l_Parent = nil) then
 // - наверное родителя уже грохнули
 begin
  Assert(false);
  f_Parents.Clear;
  f_Parent := nil;
 end//l_Parent = nil
 else
 begin
  Assert((l_Parent = f_Parent) OR (f_Parents.IndexOf(l_Parent) >= 0));
  aView.Parent := nil;
  // - изымаем контрол
  if (l_Parent <> f_Parent) then
  begin
   l_Parent.Parent := nil;
   // - изымаем родителя
   f_Parents.Remove(l_Parent);
   FreeAndNil(l_Parent);
  end;//l_Parent <> f_Parent
 end;//l_Parent = nil
 f_Views.Remove(aView);
//#UC END# *57B3461C0319_57B3468D0000_impl*
end;//TmsmMultiPanelViewParent.RemoveView

procedure TmsmMultiPanelViewParent.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B3468D0000_var*
//#UC END# *479731C50290_57B3468D0000_var*
begin
//#UC START# *479731C50290_57B3468D0000_impl*
 Assert(f_Parents.Empty);
 Assert(f_Views.Empty);
 f_Parent := nil;
 FreeAndNil(f_Parents);
 FreeAndNil(f_Views);
 inherited;
//#UC END# *479731C50290_57B3468D0000_impl*
end;//TmsmMultiPanelViewParent.Cleanup

procedure TmsmMultiPanelViewParent.InitFields;
//#UC START# *47A042E100E2_57B3468D0000_var*
//#UC END# *47A042E100E2_57B3468D0000_var*
begin
//#UC START# *47A042E100E2_57B3468D0000_impl*
 inherited;
 f_Parents := TmsmViewParentControlList.Create;
 f_Views := TmsmViewList.Create;
//#UC END# *47A042E100E2_57B3468D0000_impl*
end;//TmsmMultiPanelViewParent.InitFields

//#UC START# *57B3468D0000impl*
//#UC END# *57B3468D0000impl*

end.
