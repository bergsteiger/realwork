unit vgVisualObject_p;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGSceneTest"
// Модуль: "w:/common/components/rtl/external/VGScene/vgVisualObject_p.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestClass::Class>> Shared Delphi TestComplete Wrappers::VGSceneTest::Impl::TvgVisualObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\l3Define.inc}

interface

implementation

{$If not defined(XE)}
uses
  Classes
  {$If not defined(NoVGScene)}
  ,
  vgVisualObject
  {$IfEnd} //not NoVGScene
  ,
  Variants {a},
  ActiveX {a},
  tc5OpenAppClasses {a},
  tc5PublicInfo {a},
  tc6OpenAppClasses {a},
  tc6PublicInfo {a}
  ;
{$IfEnd} //not XE

// start class TvgVisualObject

{$If not defined(XE)}
function TvgVisualObject_Get_ScreenLeft(Self: TvgVisualObject): Integer;
//#UC START# *536B848D031F_536B7D0F0314get_var*
//#UC END# *536B848D031F_536B7D0F0314get_var*
begin
 with Self do
 begin
//#UC START# *536B848D031F_536B7D0F0314get_impl*
  Result := Trunc(Scene.LocalToScreen(Position.Point).X);
//#UC END# *536B848D031F_536B7D0F0314get_impl*
 end;//with Self
end;//TvgVisualObject_Get_ScreenLeft
{$IfEnd} //not XE

{$If not defined(XE)}
function TvgVisualObject_Get_ScreenTop(Self: TvgVisualObject): Integer;
//#UC START# *536B849D0317_536B7D0F0314get_var*
//#UC END# *536B849D0317_536B7D0F0314get_var*
begin
 with Self do
 begin
//#UC START# *536B849D0317_536B7D0F0314get_impl*
  Result := Trunc(Scene.LocalToScreen(Position.Point).Y);
//#UC END# *536B849D0317_536B7D0F0314get_impl*
 end;//with Self
end;//TvgVisualObject_Get_ScreenTop
{$IfEnd} //not XE

procedure TvgVisualObject_Get_ScreenLeft_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgVisualObject);
 try
  Value := (TvgVisualObject_Get_ScreenLeft(TvgVisualObject(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgVisualObject_Get_ScreenLeft_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgVisualObject);
 try
  Value := (TvgVisualObject_Get_ScreenLeft(TvgVisualObject(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgVisualObject_Get_ScreenTop_Pub5(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgVisualObject);
 try
  Value := (TvgVisualObject_Get_ScreenTop(TvgVisualObject(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure TvgVisualObject_Get_ScreenTop_Pub6(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
begin
 Assert(Instance is TvgVisualObject);
 try
  Value := (TvgVisualObject_Get_ScreenTop(TvgVisualObject(Instance)));
 except
  // - гасим исключения
  Value := Unassigned;
 end;//try..except
end;

procedure _RegisterPublicInformation5;
begin
 tc5PublicInfo._RegisterMethod(TvgVisualObject, tc5OpenAppClasses.mtGet, 'ScreenLeft', TypeInfo(Integer), [], [], TvgVisualObject_Get_ScreenLeft_Pub5);
 tc5PublicInfo._RegisterMethod(TvgVisualObject, tc5OpenAppClasses.mtGet, 'ScreenTop', TypeInfo(Integer), [], [], TvgVisualObject_Get_ScreenTop_Pub5);
end;

procedure _RegisterPublicInformation6;
begin
 tc6PublicInfo._RegisterMethod(TvgVisualObject, tc6OpenAppClasses.mtGet, 'ScreenLeft', TypeInfo(Integer), [], [], TvgVisualObject_Get_ScreenLeft_Pub6);
 tc6PublicInfo._RegisterMethod(TvgVisualObject, tc6OpenAppClasses.mtGet, 'ScreenTop', TypeInfo(Integer), [], [], TvgVisualObject_Get_ScreenTop_Pub6);
end;

initialization
  _RegisterPublicInformation5;
  _RegisterPublicInformation6;

end.