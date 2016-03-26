unit vg_services;

// Модуль: "w:\common\components\rtl\external\VGScene\vg_services.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vg_services" MUID: (551ABCF10068)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , l3GetComponentFromPointHelper
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , Classes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3FormatObjectInfoHelper
 {$IfEnd} // NOT Defined(NoVCL)
 , l3RTTI
 {$If NOT Defined(NoVCL)}
 , l3IterateComponentParents
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3GetCaptureHelper
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , l3GetComponentBoundsHelper
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvgGetComponentFromPointImpl = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3GetComponentFromPointHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   {$If NOT Defined(NoVCL)}
   procedure GetComponent(const aPoint: TPoint;
    out aComponent: TComponent;
    out aBindedControl: TControl);
    {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvgGetComponentFromPointImpl;
    {* Метод получения экземпляра синглетона TvgGetComponentFromPointImpl }
 end;//TvgGetComponentFromPointImpl

 TvgFormatObjectInfoImpl = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3FormatObjectInfoHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   {$If NOT Defined(NoVCL)}
   function Format(anObject: TObject;
    aShortInfo: Boolean;
    anObjectPropFound: TRTTIInfoObjectPropertyFoundCallBack): AnsiString;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvgFormatObjectInfoImpl;
    {* Метод получения экземпляра синглетона TvgFormatObjectInfoImpl }
 end;//TvgFormatObjectInfoImpl

 TvgIterateComponentsImpl = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3IterateComponentParents
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   {$If NOT Defined(NoVCL)}
   procedure IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
    aComponent: TComponent);
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvgIterateComponentsImpl;
    {* Метод получения экземпляра синглетона TvgIterateComponentsImpl }
 end;//TvgIterateComponentsImpl

 TvgGetCaptureImpl = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3GetCaptureHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   {$If NOT Defined(NoVCL)}
   function GetCapture: TComponent;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvgGetCaptureImpl;
    {* Метод получения экземпляра синглетона TvgGetCaptureImpl }
 end;//TvgGetCaptureImpl

 TvgGetComponentBoundsImpl = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3GetComponentBoundsHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   {$If NOT Defined(NoVCL)}
   function GetBounds(aComponent: TComponent): TRect;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvgGetComponentBoundsImpl;
    {* Метод получения экземпляра синглетона TvgGetComponentBoundsImpl }
 end;//TvgGetComponentBoundsImpl
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , vg_scene
 , vg_controls
 , vgVisualObject
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCL)}
 , l3HugeMessageDlgWithWikiHelper
 {$IfEnd} // NOT Defined(NoVCL)
 , vgObject
 , Windows
;

var g_TvgGetComponentFromPointImpl: TvgGetComponentFromPointImpl = nil;
 {* Экземпляр синглетона TvgGetComponentFromPointImpl }
var g_TvgFormatObjectInfoImpl: TvgFormatObjectInfoImpl = nil;
 {* Экземпляр синглетона TvgFormatObjectInfoImpl }
var g_TvgIterateComponentsImpl: TvgIterateComponentsImpl = nil;
 {* Экземпляр синглетона TvgIterateComponentsImpl }
var g_TvgGetCaptureImpl: TvgGetCaptureImpl = nil;
 {* Экземпляр синглетона TvgGetCaptureImpl }
var g_TvgGetComponentBoundsImpl: TvgGetComponentBoundsImpl = nil;
 {* Экземпляр синглетона TvgGetComponentBoundsImpl }

procedure TvgGetComponentFromPointImplFree;
 {* Метод освобождения экземпляра синглетона TvgGetComponentFromPointImpl }
begin
 l3Free(g_TvgGetComponentFromPointImpl);
end;//TvgGetComponentFromPointImplFree

procedure TvgFormatObjectInfoImplFree;
 {* Метод освобождения экземпляра синглетона TvgFormatObjectInfoImpl }
begin
 l3Free(g_TvgFormatObjectInfoImpl);
end;//TvgFormatObjectInfoImplFree

procedure TvgIterateComponentsImplFree;
 {* Метод освобождения экземпляра синглетона TvgIterateComponentsImpl }
begin
 l3Free(g_TvgIterateComponentsImpl);
end;//TvgIterateComponentsImplFree

procedure TvgGetCaptureImplFree;
 {* Метод освобождения экземпляра синглетона TvgGetCaptureImpl }
begin
 l3Free(g_TvgGetCaptureImpl);
end;//TvgGetCaptureImplFree

procedure TvgGetComponentBoundsImplFree;
 {* Метод освобождения экземпляра синглетона TvgGetComponentBoundsImpl }
begin
 l3Free(g_TvgGetComponentBoundsImpl);
end;//TvgGetComponentBoundsImplFree

class function TvgGetComponentFromPointImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvgGetComponentFromPointImpl <> nil;
end;//TvgGetComponentFromPointImpl.Exists

{$If NOT Defined(NoVCL)}
procedure TvgGetComponentFromPointImpl.GetComponent(const aPoint: TPoint;
 out aComponent: TComponent;
 out aBindedControl: TControl);
 {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
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
{$IfEnd} // NOT Defined(NoVCL)

class function TvgGetComponentFromPointImpl.Instance: TvgGetComponentFromPointImpl;
 {* Метод получения экземпляра синглетона TvgGetComponentFromPointImpl }
begin
 if (g_TvgGetComponentFromPointImpl = nil) then
 begin
  l3System.AddExitProc(TvgGetComponentFromPointImplFree);
  g_TvgGetComponentFromPointImpl := Create;
 end;
 Result := g_TvgGetComponentFromPointImpl;
end;//TvgGetComponentFromPointImpl.Instance

class function TvgFormatObjectInfoImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvgFormatObjectInfoImpl <> nil;
end;//TvgFormatObjectInfoImpl.Exists

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

class function TvgFormatObjectInfoImpl.Instance: TvgFormatObjectInfoImpl;
 {* Метод получения экземпляра синглетона TvgFormatObjectInfoImpl }
begin
 if (g_TvgFormatObjectInfoImpl = nil) then
 begin
  l3System.AddExitProc(TvgFormatObjectInfoImplFree);
  g_TvgFormatObjectInfoImpl := Create;
 end;
 Result := g_TvgFormatObjectInfoImpl;
end;//TvgFormatObjectInfoImpl.Instance

class function TvgIterateComponentsImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvgIterateComponentsImpl <> nil;
end;//TvgIterateComponentsImpl.Exists

{$If NOT Defined(NoVCL)}
procedure TvgIterateComponentsImpl.IterateF(anAction: Ml3IterateComponentParents_IterateF_Action;
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
{$IfEnd} // NOT Defined(NoVCL)

class function TvgIterateComponentsImpl.Instance: TvgIterateComponentsImpl;
 {* Метод получения экземпляра синглетона TvgIterateComponentsImpl }
begin
 if (g_TvgIterateComponentsImpl = nil) then
 begin
  l3System.AddExitProc(TvgIterateComponentsImplFree);
  g_TvgIterateComponentsImpl := Create;
 end;
 Result := g_TvgIterateComponentsImpl;
end;//TvgIterateComponentsImpl.Instance

class function TvgGetCaptureImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvgGetCaptureImpl <> nil;
end;//TvgGetCaptureImpl.Exists

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

class function TvgGetCaptureImpl.Instance: TvgGetCaptureImpl;
 {* Метод получения экземпляра синглетона TvgGetCaptureImpl }
begin
 if (g_TvgGetCaptureImpl = nil) then
 begin
  l3System.AddExitProc(TvgGetCaptureImplFree);
  g_TvgGetCaptureImpl := Create;
 end;
 Result := g_TvgGetCaptureImpl;
end;//TvgGetCaptureImpl.Instance

class function TvgGetComponentBoundsImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvgGetComponentBoundsImpl <> nil;
end;//TvgGetComponentBoundsImpl.Exists

{$If NOT Defined(NoVCL)}
function TvgGetComponentBoundsImpl.GetBounds(aComponent: TComponent): TRect;
//#UC START# *BB0BB5CAA29B_5522D81901CB_var*
var
 VO: TvgVisualObject;
 TL, BR: TvgPoint;
const
 c_EmptyRect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
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
  Result := c_EmptyRect;
//#UC END# *BB0BB5CAA29B_5522D81901CB_impl*
end;//TvgGetComponentBoundsImpl.GetBounds
{$IfEnd} // NOT Defined(NoVCL)

class function TvgGetComponentBoundsImpl.Instance: TvgGetComponentBoundsImpl;
 {* Метод получения экземпляра синглетона TvgGetComponentBoundsImpl }
begin
 if (g_TvgGetComponentBoundsImpl = nil) then
 begin
  l3System.AddExitProc(TvgGetComponentBoundsImplFree);
  g_TvgGetComponentBoundsImpl := Create;
 end;
 Result := g_TvgGetComponentBoundsImpl;
end;//TvgGetComponentBoundsImpl.Instance

initialization
{$If NOT Defined(NoVCL)}
 Tl3GetComponentFromPointHelper.Instance.Alien := TvgGetComponentFromPointImpl.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TvgGetComponentFromPointImpl }
{$If NOT Defined(NoVCL)}
 Tl3FormatObjectInfoHelper.Instance.Alien := TvgFormatObjectInfoImpl.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TvgFormatObjectInfoImpl }
{$If NOT Defined(NoVCL)}
 Tl3IterateComponentParents.Instance.Alien := TvgIterateComponentsImpl.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TvgIterateComponentsImpl }
{$If NOT Defined(NoVCL)}
 Tl3GetCaptureHelper.Instance.Alien := TvgGetCaptureImpl.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TvgGetCaptureImpl }
{$If NOT Defined(NoVCL)}
 Tl3GetComponentBoundsHelper.Instance.Alien := TvgGetComponentBoundsImpl.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* Регистрация TvgGetComponentBoundsImpl }
{$IfEnd} // NOT Defined(NoVGScene)

end.
