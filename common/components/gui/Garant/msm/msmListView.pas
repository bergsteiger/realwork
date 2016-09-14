unit msmListView;

// Модуль: "w:\common\components\gui\Garant\msm\msmListView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListView" MUID: (57B4564702F8)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , vtLister
 , l3ControlsTypes
 , Classes
 //#UC START# *57B4564702F8intf_uses*
 //#UC END# *57B4564702F8intf_uses*
;

type
 //#UC START# *57B4564702F8ci*
 //#UC END# *57B4564702F8ci*
 //#UC START# *57B4564702F8cit*
 //#UC END# *57B4564702F8cit*
 TmsmListView = class(TvtLister)
  private
   f_OnGetItemImage: Tl3GetItemImage;
  private
   function DoGetItemImageIndex(Sender: TObject;
    Index: LongInt): Integer;
  protected
   procedure Invalidate;
    {* Запрос на перерисовку. }
  public
   procedure CallDropDrawPoints;
   constructor Create(AOwner: TComponent); override;
  public
   property OnGetItemImage: Tl3GetItemImage
    read f_OnGetItemImage
    write f_OnGetItemImage;
 //#UC START# *57B4564702F8publ*
  public
   property AllowWithoutCurrent; 
 //#UC END# *57B4564702F8publ*
 end;//TmsmListView

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57B4564702F8impl_uses*
 , ImgList
 //#UC END# *57B4564702F8impl_uses*
;

procedure TmsmListView.CallDropDrawPoints;
//#UC START# *57B565DA01A1_57B4564702F8_var*
//#UC END# *57B565DA01A1_57B4564702F8_var*
begin
//#UC START# *57B565DA01A1_57B4564702F8_impl*
 DropDrawPoints;
//#UC END# *57B565DA01A1_57B4564702F8_impl*
end;//TmsmListView.CallDropDrawPoints

function TmsmListView.DoGetItemImageIndex(Sender: TObject;
 Index: LongInt): Integer;
//#UC START# *57D94AB5005D_57B4564702F8_var*
var
 l_Images : TCustomImageList;
//#UC END# *57D94AB5005D_57B4564702F8_var*
begin
//#UC START# *57D94AB5005D_57B4564702F8_impl*
 Result := -1;
 if Assigned(f_OnGetItemImage) then
 begin
  l_Images := Self.Images;
  Result := f_OnGetItemImage(Sender, Index, l_Images);
  if (l_Images <> Self.Images) then
   Self.Images := l_Images;
 end;//Assigned(f_OnGetItemImage)
//#UC END# *57D94AB5005D_57B4564702F8_impl*
end;//TmsmListView.DoGetItemImageIndex

procedure TmsmListView.Invalidate;
 {* Запрос на перерисовку. }
//#UC START# *46A5AA4B003C_57B4564702F8_var*
//#UC END# *46A5AA4B003C_57B4564702F8_var*
begin
//#UC START# *46A5AA4B003C_57B4564702F8_impl*
 inherited;
//#UC END# *46A5AA4B003C_57B4564702F8_impl*
end;//TmsmListView.Invalidate

constructor TmsmListView.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57B4564702F8_var*
//#UC END# *47D1602000C6_57B4564702F8_var*
begin
//#UC START# *47D1602000C6_57B4564702F8_impl*
 inherited;
 Self.OnGetItemImageIndex := Self.DoGetItemImageIndex;
//#UC END# *47D1602000C6_57B4564702F8_impl*
end;//TmsmListView.Create

//#UC START# *57B4564702F8impl*
//#UC END# *57B4564702F8impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TmsmListView);
 {* Регистрация TmsmListView }
{$IfEnd} // NOT Defined(NoScripts)

end.
