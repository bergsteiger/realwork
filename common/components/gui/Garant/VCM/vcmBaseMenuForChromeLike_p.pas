unit vcmBaseMenuForChromeLike_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCMTest"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmBaseMenuForChromeLike_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VCMTest::ChromeLike::TvcmBaseMenuForChromeLike
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
uses
  Classes
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmBaseMenuForChromeLike
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  vcmMenuForChromeLikeItemWrap,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

type
 TvcmBaseMenuForChromeLikeFriend = class(TvcmBaseMenuForChromeLike)
 end;//TvcmBaseMenuForChromeLikeFriend

// start class TvcmBaseMenuForChromeLike

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
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
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(XE)}
function TvcmBaseMenuForChromeLike_Get_Items(Self: TvcmBaseMenuForChromeLikeFriend; Index: Integer): TvcmMenuForChromeLikeItemWrap;
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
{$IfEnd} //not NoTabs AND not NoVCM AND not XE

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

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc5OpenAppClasses.mtGet, 'ItemCount', TypeInfo(Integer), [], [], TvcmBaseMenuForChromeLike_Get_ItemCount_Pub5);
 tc5PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc5OpenAppClasses.mtGet, 'Items', TypeInfo(TvcmMenuForChromeLikeItemWrap), [TypeInfo(Integer)], ['Index'], TvcmBaseMenuForChromeLike_Get_Items_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc6OpenAppClasses.mtGet, 'ItemCount', TypeInfo(Integer), [], [], TvcmBaseMenuForChromeLike_Get_ItemCount_Pub6);
 tc6PublicInfo._RegisterMethod(TvcmBaseMenuForChromeLike, tc6OpenAppClasses.mtGet, 'Items', TypeInfo(TvcmMenuForChromeLikeItemWrap), [TypeInfo(Integer)], ['Index'], TvcmBaseMenuForChromeLike_Get_Items_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.