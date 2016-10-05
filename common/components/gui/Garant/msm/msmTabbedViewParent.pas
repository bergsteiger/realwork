unit msmTabbedViewParent;

// Модуль: "w:\common\components\gui\Garant\msm\msmTabbedViewParent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmTabbedViewParent" MUID: (57B4802B0112)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewParentPrim
 , msmControllers
 , msmPageControl
 //#UC START# *57B4802B0112intf_uses*
 //#UC END# *57B4802B0112intf_uses*
;

type
 //#UC START# *57B4802B0112ci*
 //#UC END# *57B4802B0112ci*
 //#UC START# *57B4802B0112cit*
 //#UC END# *57B4802B0112cit*
 TmsmTabbedViewParent = class(TmsmViewParentPrim, ImsmViewParent)
  private
   f_Pages: TmsmPageControl;
   f_Parent: TmsmViewParentControl;
  protected
   procedure InsertView(aView: TmsmView;
    const aContext: TmsmViewContext);
   procedure RemoveView(aView: TmsmView);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aParent: TmsmViewParentControl); reintroduce;
   class function Make(aParent: TmsmViewParentControl): ImsmViewParent; reintroduce;
 //#UC START# *57B4802B0112publ*
 //#UC END# *57B4802B0112publ*
 end;//TmsmTabbedViewParent

implementation

uses
 l3ImplUses
 , msmTabCaptionController
 //#UC START# *57B4802B0112impl_uses*
 , SysUtils
 , Graphics
 , Controls
 , ElPgCtl
 , l3Defaults
 //#UC END# *57B4802B0112impl_uses*
;

constructor TmsmTabbedViewParent.Create(aParent: TmsmViewParentControl);
//#UC START# *57B480A700A0_57B4802B0112_var*
//#UC END# *57B480A700A0_57B4802B0112_var*
begin
//#UC START# *57B480A700A0_57B4802B0112_impl*
 Assert(aParent <> nil);
 f_Parent := aParent;
 f_Pages := nil;
 inherited Create;
//#UC END# *57B480A700A0_57B4802B0112_impl*
end;//TmsmTabbedViewParent.Create

class function TmsmTabbedViewParent.Make(aParent: TmsmViewParentControl): ImsmViewParent;
var
 l_Inst : TmsmTabbedViewParent;
begin
 l_Inst := Create(aParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmTabbedViewParent.Make

procedure TmsmTabbedViewParent.InsertView(aView: TmsmView;
 const aContext: TmsmViewContext);
//#UC START# *57B345EC0195_57B4802B0112_var*
var
 l_Page : TElTabSheet;
//#UC END# *57B345EC0195_57B4802B0112_var*
begin
//#UC START# *57B345EC0195_57B4802B0112_impl*
 Assert(aView.Parent = nil);
 //f_Parent.DisableAlign;
 try
  if (f_Pages = nil) then
  begin
   f_Pages := TmsmPageControl.Create(f_Parent);
   //f_Pages.Style := etsButtons;
   //f_Pages.Style := etsFlatButtons;
   f_Pages.Style := etsFlatTabs;
   //f_Pages.Style := etsTabs;
   f_Pages.TabPosition := etpBottom;
   f_Pages.ParentColor := false;
   f_Pages.TabHeight := 28;
   //f_Pages.Color := clWhite;
   f_Pages.Color := cGarant2011BackColor;
   f_Pages.TabBkColor := cGarant2011BackColor;
   f_Pages.Parent := f_Parent;
   f_Pages.Align := alClient;
   f_Pages.UseXPThemes := False;
  end;//f_Pages = nil
  l_Page := f_Pages.NewPage;
  if (aContext.rCaptionModel <> nil) then
   Add(TmsmTabCaptionController.Make(l_Page, aContext.rCaptionModel))
  else
   l_Page.Caption := aContext.Caption;
  aView.Parent := l_Page;
  aView.Align := alClient;
 finally
  //f_Parent.EnableAlign;
 end;//try..finally
//#UC END# *57B345EC0195_57B4802B0112_impl*
end;//TmsmTabbedViewParent.InsertView

procedure TmsmTabbedViewParent.RemoveView(aView: TmsmView);
//#UC START# *57B3461C0319_57B4802B0112_var*
var
 l_P : TmsmViewParentControl;
//#UC END# *57B3461C0319_57B4802B0112_var*
begin
//#UC START# *57B3461C0319_57B4802B0112_impl*
 l_P := aView.Parent;
 Assert(l_P <> nil);
 Assert(l_P.Parent = f_Pages);
 aView.Parent := nil;
 FreeAndNil(l_P);
//#UC END# *57B3461C0319_57B4802B0112_impl*
end;//TmsmTabbedViewParent.RemoveView

procedure TmsmTabbedViewParent.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57B4802B0112_var*
//#UC END# *479731C50290_57B4802B0112_var*
begin
//#UC START# *479731C50290_57B4802B0112_impl*
 f_Parent := nil;
 FreeAndNil(f_Pages);
 f_Pages := nil;
 inherited;
//#UC END# *479731C50290_57B4802B0112_impl*
end;//TmsmTabbedViewParent.Cleanup

//#UC START# *57B4802B0112impl*
//#UC END# *57B4802B0112impl*

end.
