unit vg_services;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/vg_services.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VGScene::Impl::vg_services
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ProtoObject
  {$If not defined(NoVCL)}
  ,
  l3IterateComponentParents
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3GetComponentFromPointHelper
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3FormatObjectInfoHelper
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3GetCaptureHelper
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3GetComponentBoundsHelper
  {$IfEnd} //not NoVCL
  ,
  Types,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3RTTI
  ;

type
 TvgGetComponentFromPointImpl = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3GetComponentFromPointHelper{$IfEnd} //not NoVCL
 )
 public
 // realized methods
    {$If not defined(NoVCL)}
   procedure GetComponent(const aPoint: TPoint;
     out aComponent: TComponent;
     out aBindedControl: TControl);
     {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
    {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvgGetComponentFromPointImpl;
    {- возвращает экземпляр синглетона. }
 end;//TvgGetComponentFromPointImpl

 TvgFormatObjectInfoImpl = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3FormatObjectInfoHelper{$IfEnd} //not NoVCL
 )
 public
 // realized methods
    {$If not defined(NoVCL)}
   function Format(anObject: TObject;
     aShortInfo: Boolean;
     anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
    {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvgFormatObjectInfoImpl;
    {- возвращает экземпляр синглетона. }
 end;//TvgFormatObjectInfoImpl

 TvgIterateComponentsImpl = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3IterateComponentParents{$IfEnd} //not NoVCL
 )
 public
 // realized methods
    {$If not defined(NoVCL)}
   {iterator} procedure IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
     aComponent: TComponent);
    {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvgIterateComponentsImpl;
    {- возвращает экземпляр синглетона. }
 end;//TvgIterateComponentsImpl

 TvgGetCaptureImpl = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3GetCaptureHelper{$IfEnd} //not NoVCL
 )
 public
 // realized methods
    {$If not defined(NoVCL)}
   function GetCapture: TComponent;
    {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvgGetCaptureImpl;
    {- возвращает экземпляр синглетона. }
 end;//TvgGetCaptureImpl

 TvgGetComponentBoundsImpl = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3GetComponentBoundsHelper{$IfEnd} //not NoVCL
 )
 public
 // realized methods
    {$If not defined(NoVCL)}
   function GetBounds(aComponent: TComponent): TRect;
    {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvgGetComponentBoundsImpl;
    {- возвращает экземпляр синглетона. }
 end;//TvgGetComponentBoundsImpl
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Base {a}
  {$If not defined(NoVCL)}
  ,
  l3HugeMessageDlgWithWikiHelper
  {$IfEnd} //not NoVCL
  ,
  SysUtils,
  vgObject,
  Windows,
  vg_scene,
  vg_controls,
  vgVisualObject
  ;


// start class TvgGetComponentFromPointImpl

var g_TvgGetComponentFromPointImpl : TvgGetComponentFromPointImpl = nil;

procedure TvgGetComponentFromPointImplFree;
begin
 l3Free(g_TvgGetComponentFromPointImpl);
end;

class function TvgGetComponentFromPointImpl.Instance: TvgGetComponentFromPointImpl;
begin
 if (g_TvgGetComponentFromPointImpl = nil) then
 begin
  l3System.AddExitProc(TvgGetComponentFromPointImplFree);
  g_TvgGetComponentFromPointImpl := Create;
 end;
 Result := g_TvgGetComponentFromPointImpl;
end;


class function TvgGetComponentFromPointImpl.Exists: Boolean;
 {-}
begin
 Result := g_TvgGetComponentFromPointImpl <> nil;
end;//TvgGetComponentFromPointImpl.Exists

{$If not defined(NoVCL)}
procedure TvgGetComponentFromPointImpl.GetComponent(const aPoint: TPoint;
  out aComponent: TComponent;
  out aBindedControl: TControl);
//#UC START# *77F02E022F3C_551ABD0E013B_var*
var
 l_CPos: TPoint;
//#UC END# *77F02E022F3C_551ABD0E013B_var*
begin
//#UC START# *77F02E022F3C_551ABD0E013B_impl*
 aBindedControl := FindDragTarget(aPoint, True);
 if Assigned(aBindedControl) and (aBindedControl is TvgCustomScene) then
  with TvgCustomScene(aBindedControl) do
  begin
   l_CPos := ScreenToClient(aPoint);
   aComponent := ObjectByPoint(l_CPos.X, l_CPos.Y);
  end else
   aComponent := nil;
//#UC END# *77F02E022F3C_551ABD0E013B_impl*
end;//TvgGetComponentFromPointImpl.GetComponent
{$IfEnd} //not NoVCL

// start class TvgFormatObjectInfoImpl

var g_TvgFormatObjectInfoImpl : TvgFormatObjectInfoImpl = nil;

procedure TvgFormatObjectInfoImplFree;
begin
 l3Free(g_TvgFormatObjectInfoImpl);
end;

class function TvgFormatObjectInfoImpl.Instance: TvgFormatObjectInfoImpl;
begin
 if (g_TvgFormatObjectInfoImpl = nil) then
 begin
  l3System.AddExitProc(TvgFormatObjectInfoImplFree);
  g_TvgFormatObjectInfoImpl := Create;
 end;
 Result := g_TvgFormatObjectInfoImpl;
end;


class function TvgFormatObjectInfoImpl.Exists: Boolean;
 {-}
begin
 Result := g_TvgFormatObjectInfoImpl <> nil;
end;//TvgFormatObjectInfoImpl.Exists

{$If not defined(NoVCL)}
function TvgFormatObjectInfoImpl.Format(anObject: TObject;
  aShortInfo: Boolean;
  anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
//#UC START# *D4A861440DBF_551BCE070003_var*
 procedure lp_AddInfo(var theInfo: AnsiString;
  const aCaption: AnsiString;
  const aValue: AnsiString;
  aNewLine: Boolean = False);
 begin
  if Length(aValue) > 0 then
  begin
   if Length(theInfo) > 0 then
    if aNewLine
     then theInfo := theInfo + #13#10
     else theInfo := theInfo + ', ';
   theInfo := theInfo + aCaption + ':' + aValue;
  end;
 end;

 function lp_FormatLinkToObject(anObject: TObject): AnsiString;
 begin
  Result := '$' + IntToHex(Integer(anObject), 8);
  if Assigned(anObjectPropFound) then
   anObjectPropFound(anObject, Result)
  else
   Result := Tl3HugeMessageDlgWithWikiHelper.Instance.FormatLink(Result, IntToStr(Integer(anObject)));
 end;
 
var
 l_VO: TvgVisualObject;
//#UC END# *D4A861440DBF_551BCE070003_var*
begin
//#UC START# *D4A861440DBF_551BCE070003_impl*
 if aShortInfo then
 begin
  if Assigned(anObject) and (anObject is TvgVisualObject) then
  begin
   l_VO := TvgVisualObject(anObject);
   lp_AddInfo(Result, 'name', l_VO.Name, True);
   if l_VO is TvgTextControl then
    lp_AddInfo(Result, 'text', TvgTextControl(l_VO).Text);
   lp_AddInfo(Result, 'class', l_VO.ClassName);
   if Assigned(l_VO.Owner) then
    lp_AddInfo(Result, 'Owner', lp_FormatLinkToObject(l_VO.Owner), True);
   if Assigned(l_VO.Parent) then
    lp_AddInfo(Result, 'Parent', lp_FormatLinkToObject(l_VO.Parent), True);
  end;
 end
 else
  Result := L3FormatRTTIInfo(anObject, True, anObjectPropFound, Tl3HugeMessageDlgWithWikiHelper.Instance.CanUseWiki);
//#UC END# *D4A861440DBF_551BCE070003_impl*
end;//TvgFormatObjectInfoImpl.Format
{$IfEnd} //not NoVCL

// start class TvgIterateComponentsImpl

var g_TvgIterateComponentsImpl : TvgIterateComponentsImpl = nil;

procedure TvgIterateComponentsImplFree;
begin
 l3Free(g_TvgIterateComponentsImpl);
end;

class function TvgIterateComponentsImpl.Instance: TvgIterateComponentsImpl;
begin
 if (g_TvgIterateComponentsImpl = nil) then
 begin
  l3System.AddExitProc(TvgIterateComponentsImplFree);
  g_TvgIterateComponentsImpl := Create;
 end;
 Result := g_TvgIterateComponentsImpl;
end;


class function TvgIterateComponentsImpl.Exists: Boolean;
 {-}
begin
 Result := g_TvgIterateComponentsImpl <> nil;
end;//TvgIterateComponentsImpl.Exists

{$If not defined(NoVCL)}
{iterator} procedure TvgIterateComponentsImpl.IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
  aComponent: TComponent);
//#UC START# *3410F441967F_551C4D2300E5_var*
var
 Hack : Pointer absolute anAction;
 l_VO: TvgVisualObject;
 l_O: TvgObject;
 l_C: TControl;
//#UC END# *3410F441967F_551C4D2300E5_var*
begin
//#UC START# *3410F441967F_551C4D2300E5_impl*
 try
  anAction(aComponent);
  if aComponent is TvgVisualObject then
  begin
   l_VO := TvgVisualObject(aComponent);
   l_C := l_VO.Scene.GetSceneControl;
   while Assigned(l_VO.Parent) and (l_VO.Parent is TvgVisualObject) do
   begin
    l_VO := TvgVisualObject(l_VO.Parent);
    anAction(l_VO);
   end;
  end else
  if aComponent is TControl then
   l_C := TControl(aComponent)
  else
   l_C := nil;

  if Assigned(l_C) then
   while Assigned(l_C.Parent) do
   begin
    l_C := l_C.Parent;
    anAction(l_C);
   end;
 finally
  l3FreeLocalStub(Hack);
 end;
//#UC END# *3410F441967F_551C4D2300E5_impl*
end;//TvgIterateComponentsImpl.IterateF
{$IfEnd} //not NoVCL

// start class TvgGetCaptureImpl

var g_TvgGetCaptureImpl : TvgGetCaptureImpl = nil;

procedure TvgGetCaptureImplFree;
begin
 l3Free(g_TvgGetCaptureImpl);
end;

class function TvgGetCaptureImpl.Instance: TvgGetCaptureImpl;
begin
 if (g_TvgGetCaptureImpl = nil) then
 begin
  l3System.AddExitProc(TvgGetCaptureImplFree);
  g_TvgGetCaptureImpl := Create;
 end;
 Result := g_TvgGetCaptureImpl;
end;


class function TvgGetCaptureImpl.Exists: Boolean;
 {-}
begin
 Result := g_TvgGetCaptureImpl <> nil;
end;//TvgGetCaptureImpl.Exists

{$If not defined(NoVCL)}
function TvgGetCaptureImpl.GetCapture: TComponent;
//#UC START# *FC96CEF34C46_55226D5F0212_var*
var
 l_C: TControl;
//#UC END# *FC96CEF34C46_55226D5F0212_var*
begin
//#UC START# *FC96CEF34C46_55226D5F0212_impl*
 Result := GetCaptureControl;
 if Result is TvgCustomScene then
  Result := TvgCustomScene(Result).Captured;
 if not Assigned(Result) then
  if GetAsyncKeyState(VK_LBUTTON) < 0 then
  begin
   l_C := FindDragTarget(Mouse.CursorPos, True);
   if Assigned(l_C) and (l_C is TvgCustomScene) then
    with TvgCustomScene(l_C) do
     Result := ObjectByPoint(MousePos.X, MousePos.Y);
  end;
//#UC END# *FC96CEF34C46_55226D5F0212_impl*
end;//TvgGetCaptureImpl.GetCapture
{$IfEnd} //not NoVCL

// start class TvgGetComponentBoundsImpl

var g_TvgGetComponentBoundsImpl : TvgGetComponentBoundsImpl = nil;

procedure TvgGetComponentBoundsImplFree;
begin
 l3Free(g_TvgGetComponentBoundsImpl);
end;

class function TvgGetComponentBoundsImpl.Instance: TvgGetComponentBoundsImpl;
begin
 if (g_TvgGetComponentBoundsImpl = nil) then
 begin
  l3System.AddExitProc(TvgGetComponentBoundsImplFree);
  g_TvgGetComponentBoundsImpl := Create;
 end;
 Result := g_TvgGetComponentBoundsImpl;
end;


class function TvgGetComponentBoundsImpl.Exists: Boolean;
 {-}
begin
 Result := g_TvgGetComponentBoundsImpl <> nil;
end;//TvgGetComponentBoundsImpl.Exists

{$If not defined(NoVCL)}
function TvgGetComponentBoundsImpl.GetBounds(aComponent: TComponent): TRect;
//#UC START# *BB0BB5CAA29B_5522D81901CB_var*
var
 VO: TvgVisualObject;
 TL, BR: TvgPoint;
//#UC END# *BB0BB5CAA29B_5522D81901CB_var*
begin
//#UC START# *BB0BB5CAA29B_5522D81901CB_impl*
 if aComponent is TvgVisualObject then
 begin
  VO := TvgVisualObject(aComponent);
  TL := VO.Scene.LocalToScreen(VO.LocalToAbsolute(vgPoint(0, 0)));
  BR := VO.Scene.LocalToScreen(VO.LocalToAbsolute(vgPoint(VO.Width, VO.Height)));
  Result := Rect(Trunc(TL.X), Trunc(TL.Y), Trunc(BR.X), Trunc(BR.Y));
 end else
  Result := EmptyRect;
//#UC END# *BB0BB5CAA29B_5522D81901CB_impl*
end;//TvgGetComponentBoundsImpl.GetBounds
{$IfEnd} //not NoVCL
{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoVGScene)}
// Регистрация TvgGetComponentFromPointImpl
 {$If not defined(NoVCL)}
 Tl3GetComponentFromPointHelper.Instance.Alien := TvgGetComponentFromPointImpl.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene
{$If not defined(NoVGScene)}
// Регистрация TvgFormatObjectInfoImpl
 {$If not defined(NoVCL)}
 Tl3FormatObjectInfoHelper.Instance.Alien := TvgFormatObjectInfoImpl.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene
{$If not defined(NoVGScene)}
// Регистрация TvgIterateComponentsImpl
 {$If not defined(NoVCL)}
 Tl3IterateComponentParents.Instance.Alien := TvgIterateComponentsImpl.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene
{$If not defined(NoVGScene)}
// Регистрация TvgGetCaptureImpl
 {$If not defined(NoVCL)}
 Tl3GetCaptureHelper.Instance.Alien := TvgGetCaptureImpl.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene
{$If not defined(NoVGScene)}
// Регистрация TvgGetComponentBoundsImpl
 {$If not defined(NoVCL)}
 Tl3GetComponentBoundsHelper.Instance.Alien := TvgGetComponentBoundsImpl.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene

end.