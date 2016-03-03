unit vcmBaseMenuForChromeLike_p;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmBaseMenuForChromeLike_p.pas"
// Стереотип: "TestClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 {$If NOT Defined(NoVGScene)}
 , vcmBaseMenuForChromeLike
 {$IfEnd} // NOT Defined(NoVGScene)
 , vcmMenuForChromeLikeItemWrap
;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , Variants
 , ActiveX
 , tc5OpenAppClasses
 , tc5PublicInfo
 , tc6OpenAppClasses
 , tc6PublicInfo
;

type
 TvcmBaseMenuForChromeLikeFriend = {final} class(TvcmBaseMenuForChromeLike)
  {* Друг к классу TvcmBaseMenuForChromeLike }
 end;//TvcmBaseMenuForChromeLikeFriend

function TvcmBaseMenuForChromeLike_Get_ItemCount(Self: TvcmBaseMenuForChromeLikeFriend): Integer;
//#UC START# *547769DD0375_54776921001Aget_var*
//#UC END# *547769DD0375_54776921001Aget_var*
begin
 with Self do
 begin
//#UC START# *547769DD0375_54776921001Aget_impl*
  Result := ItemCount;
//#UC END# *547769DD0375_54776921001Aget_impl*
 end;//with Self
end;//TvcmBaseMenuForChromeLike_Get_ItemCount

function TvcmBaseMenuForChromeLike_Get_Items(Self: TvcmBaseMenuForChromeLikeFriend;
 Index: Integer): TvcmMenuForChromeLikeItemWrap;
//#UC START# *54779C5903A7_54776921001Aget_var*
//#UC END# *54779C5903A7_54776921001Aget_var*
begin
 with Self do
 begin
//#UC START# *54779C5903A7_54776921001Aget_impl*
  Result := TvcmMenuForChromeLikeItemWrap.Create(Items[Index]);
//#UC END# *54779C5903A7_54776921001Aget_impl*
 end;//with Self
end;//TvcmBaseMenuForChromeLike_Get_Items

procedure TvcmBaseMenuForChromeLike_Get_ItemCount_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmBaseMenuForChromeLike);
 try
  Value := (TvcmBaseMenuForChromeLike_Get_ItemCount(TvcmBaseMenuForChromeLikeFriend(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvcmBaseMenuForChromeLike_Get_Items_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmBaseMenuForChromeLike);
 try
  Value := tc5PublicInfo.VarFromObject(TvcmBaseMenuForChromeLike_Get_Items(TvcmBaseMenuForChromeLikeFriend(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc5OpenAppClasses.mtGet, 'ItemCount', TypeInfo(Integer), [], [], TvcmBaseMenuForChromeLike_Get_ItemCount_Pub5);
 tc5PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc5OpenAppClasses.mtGet, 'Items', TypeInfo(TvcmMenuForChromeLikeItemWrap), [TypeInfo(Integer)], ['Index'], TvcmBaseMenuForChromeLike_Get_Items_Pub5);
end;

procedure TvcmBaseMenuForChromeLike_Get_ItemCount_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmBaseMenuForChromeLike);
 try
  Value := (TvcmBaseMenuForChromeLike_Get_ItemCount(TvcmBaseMenuForChromeLikeFriend(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvcmBaseMenuForChromeLike_Get_Items_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvcmBaseMenuForChromeLike);
 try
  Value := tc6PublicInfo.VarFromObject(TvcmBaseMenuForChromeLike_Get_Items(TvcmBaseMenuForChromeLikeFriend(Instance), OleVariant(Args^[0])));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc6OpenAppClasses.mtGet, 'ItemCount', TypeInfo(Integer), [], [], TvcmBaseMenuForChromeLike_Get_ItemCount_Pub6);
 tc6PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc6OpenAppClasses.mtGet, 'Items', TypeInfo(TvcmMenuForChromeLikeItemWrap), [TypeInfo(Integer)], ['Index'], TvcmBaseMenuForChromeLike_Get_Items_Pub6);
end;

initialization
 _RegisterPublicInformation5;
 _RegisterPublicInformation6;
{$IfEnd} // NOT Defined(XE) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
