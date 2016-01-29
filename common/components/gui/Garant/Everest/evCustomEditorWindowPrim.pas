unit evCustomEditorWindowPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evCustomEditorWindowPrim.pas"
// �����: 16.12.2009 15:44
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevCustomEditorWindowPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Interfaces,
  l3Core,
  Messages,
  Classes,
  nevTools
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evDef,
  nevControl
  ;

type
 TevMakeExportFiltersEvent = procedure (aSelection: Boolean;
  aForExport: Boolean;
  var theGen: Ik2TagGenerator) of object;

 TevCustomEditorWindowPrim = class(TnevControl)
 private
 // private fields
   f_Zoom : Integer;
    {* ���� ��� �������� Zoom}
   f_ForceRepaint : Boolean;
    {* ���� ��� �������� ForceRepaint}
   f_OnMakeExportFilters : TevMakeExportFiltersEvent;
    {* ���� ��� �������� OnMakeExportFilters}
   f_OnFocusViaMouseSet : TNotifyEvent;
    {* ���� ��� �������� OnFocusViaMouseSet}
 private
 // private methods
   procedure WMMOUSEACTIVATE(var aMsg: TWMMouseActivate); message WM_MOUSEACTIVATE;
 protected
 // property methods
   procedure pm_SetZoom(aValue: Integer);
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure DoForceRepaint; override;
   procedure DoAfterCreateCanvas; override;
     {* ����������� ����� �������� ����� ��� ���������, ��������, Zoom'� � �����������. }
 protected
 // protected fields
   f_LockForceRepaint : Integer;
 protected
 // protected methods
   function GetDocumentPartByPoint(const aPoint: InevBasePoint): IevDocumentPart; virtual;
   procedure RecalcScreenCursor(const aPoint: TPoint;
     var theCursor: TCursor); virtual;
   procedure SetFocusViaMouse;
   function WantSoftEnter: Boolean; virtual;
   procedure DoAfterSetZoom; virtual;
 public
 // public methods
   function GetVScrollerHint(const anAnchor: InevBasePoint): AnsiString;
   function GetDocumentPartHint(const aPart: IevDocumentPart): AnsiString;
   function NeedAlignMarksOnSingleClick: Boolean; virtual;
 protected
 // protected properties
   property ForceRepaint: Boolean
     read f_ForceRepaint
     write f_ForceRepaint;
     {* ������� ������������� ��������� ���� ��� Locked }
 public
 // public properties
   property Zoom: Integer
     read f_Zoom
     write pm_SetZoom
     default def_Zoom;
   property OnMakeExportFilters: TevMakeExportFiltersEvent
     read f_OnMakeExportFilters
     write f_OnMakeExportFilters;
   property OnFocusViaMouseSet: TNotifyEvent
     read f_OnFocusViaMouseSet
     write f_OnFocusViaMouseSet;
 end;//TevCustomEditorWindowPrim

implementation

uses
  l3String
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  Block_Const,
  Document_Const,
  k2Tags,
  Windows
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  evSchemaWordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  evParaWordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  EditorFromStackKeyWordsPack
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  EditorParaCoordsToScreenPack
  {$IfEnd} //not NoScripts
  
  ;

// start class TevCustomEditorWindowPrim

function TevCustomEditorWindowPrim.GetVScrollerHint(const anAnchor: InevBasePoint): AnsiString;
//#UC START# *4C0CA1FC02A8_4B28D63A00EC_var*
//#UC END# *4C0CA1FC02A8_4B28D63A00EC_var*
begin
//#UC START# *4C0CA1FC02A8_4B28D63A00EC_impl*
 Result := GetDocumentPartHint(GetDocumentPartByPoint(anAnchor));
//#UC END# *4C0CA1FC02A8_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.GetVScrollerHint

function TevCustomEditorWindowPrim.GetDocumentPartHint(const aPart: IevDocumentPart): AnsiString;
//#UC START# *4C0E39BE0272_4B28D63A00EC_var*

 function lp_CalcLevel(const aPart: IevDocumentPart): Integer;
 var
  l_P : IevDocumentPart;
 begin//lp_CalcLevel
  Result := 1;
  l_P := aPart;
  while l_P.ID <> 0 do
  begin
   if not l3IsNil(l_P.Name) then
    Inc(Result);
   l_P := l_P.ParentDocumentPart;
   Assert(l_P <> nil);
   // - ����� ������ http://mdp.garant.ru/pages/viewpage.action?pageId=217693932
   if (l_P = nil) then
    break;
   if not l_P.Exists then
    break;
  end;//while l_P.ID <> 0
 end;//lp_CalcLevel

var
 l_P : IevDocumentPart;
 l_MaxLevel: Integer;
 l_CurLevel: Integer;
//#UC END# *4C0E39BE0272_4B28D63A00EC_var*
begin
//#UC START# *4C0E39BE0272_4B28D63A00EC_impl*
 Result := '';
 if aPart = nil then
  Exit;
 if not aPart.Exists then
  Exit; 
 l_P := aPart;
 l_MaxLevel := lp_CalcLevel(aPart);
 l_CurLevel := l_MaxLevel - 2;
 l_P := aPart;
 while true do
 begin
  if l_P.ID = 0 then
  begin
   if (l_MaxLevel = 1) then
    Result := l3PCharLen2String(l_P.Para.PCharLenA[k2_tiName]);
   break;
  end
  else
  begin
   if not l3IsNil(l_P.Name) then
   begin
    if Result <> '' then
     Result := #13#10 + Result;
    Result := StringOfChar(#9, l_CurLevel * 6) + l3PCharLen2String(l_P.Name) + Result;
    Dec(l_CurLevel);
   end;
   l_P := l_P.ParentDocumentPart;
   if (l_P = nil) then
    break;
  end;//l_P.ID = 0
 end;//while true
//#UC END# *4C0E39BE0272_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.GetDocumentPartHint

function TevCustomEditorWindowPrim.GetDocumentPartByPoint(const aPoint: InevBasePoint): IevDocumentPart;
//#UC START# *4C0E3AF002E8_4B28D63A00EC_var*
//#UC END# *4C0E3AF002E8_4B28D63A00EC_var*
begin
//#UC START# *4C0E3AF002E8_4B28D63A00EC_impl*
 Result := nil;
//#UC END# *4C0E3AF002E8_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.GetDocumentPartByPoint

function TevCustomEditorWindowPrim.NeedAlignMarksOnSingleClick: Boolean;
//#UC START# *4D6D427D023A_4B28D63A00EC_var*
//#UC END# *4D6D427D023A_4B28D63A00EC_var*
begin
//#UC START# *4D6D427D023A_4B28D63A00EC_impl*
 Result := true;
//#UC END# *4D6D427D023A_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.NeedAlignMarksOnSingleClick

procedure TevCustomEditorWindowPrim.RecalcScreenCursor(const aPoint: TPoint;
  var theCursor: TCursor);
//#UC START# *4E788DB902F9_4B28D63A00EC_var*
//#UC END# *4E788DB902F9_4B28D63A00EC_var*
begin
//#UC START# *4E788DB902F9_4B28D63A00EC_impl*
 // - ������ �� ������
//#UC END# *4E788DB902F9_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.RecalcScreenCursor

procedure TevCustomEditorWindowPrim.SetFocusViaMouse;
//#UC START# *4E7B4686012C_4B28D63A00EC_var*
//#UC END# *4E7B4686012C_4B28D63A00EC_var*
begin
//#UC START# *4E7B4686012C_4B28D63A00EC_impl*
 if CanFocus then
 begin
  SetFocus;
  if Assigned(f_OnFocusViaMouseSet) then
   if Focused then
    f_OnFocusViaMouseSet(Self);
 end;//CanFocus
//#UC END# *4E7B4686012C_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.SetFocusViaMouse

procedure TevCustomEditorWindowPrim.pm_SetZoom(aValue: Integer);
//#UC START# *4D3973B70186_4B28D63A00ECset_var*
//#UC END# *4D3973B70186_4B28D63A00ECset_var*
begin
//#UC START# *4D3973B70186_4B28D63A00ECset_impl*
 if f_Zoom <> aValue then
 begin
  f_Zoom := aValue;
  if f_Canvas <> nil then
   Canvas.Zoom := aValue;
  DoAfterSetZoom; 
 end // if f_Zoom <> aValue then
//#UC END# *4D3973B70186_4B28D63A00ECset_impl*
end;//TevCustomEditorWindowPrim.pm_SetZoom

function TevCustomEditorWindowPrim.WantSoftEnter: Boolean;
//#UC START# *4B28D6780001_4B28D63A00EC_var*
//#UC END# *4B28D6780001_4B28D63A00EC_var*
begin
//#UC START# *4B28D6780001_4B28D63A00EC_impl*
 Result := true;
//#UC END# *4B28D6780001_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.WantSoftEnter

procedure TevCustomEditorWindowPrim.DoAfterSetZoom;
//#UC START# *4D3998FE03C1_4B28D63A00EC_var*
//#UC END# *4D3998FE03C1_4B28D63A00EC_var*
begin
//#UC START# *4D3998FE03C1_4B28D63A00EC_impl*
//#UC END# *4D3998FE03C1_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.DoAfterSetZoom

procedure TevCustomEditorWindowPrim.WMMOUSEACTIVATE(var aMsg: TWMMouseActivate);
//#UC START# *4E7B4F3A00E5_4B28D63A00EC_var*
//#UC END# *4E7B4F3A00E5_4B28D63A00EC_var*
begin
//#UC START# *4E7B4F3A00E5_4B28D63A00EC_impl*
 inherited;
 if (aMsg.Result = MA_ACTIVATE) OR
    (aMsg.Result = MA_ACTIVATEANDEAT) then
  if Assigned(f_OnFocusViaMouseSet) then
   f_OnFocusViaMouseSet(Self);  
//#UC END# *4E7B4F3A00E5_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.WMMOUSEACTIVATE

procedure TevCustomEditorWindowPrim.InitFields;
//#UC START# *47A042E100E2_4B28D63A00EC_var*
//#UC END# *47A042E100E2_4B28D63A00EC_var*
begin
//#UC START# *47A042E100E2_4B28D63A00EC_impl*
 inherited;
 Zoom := def_Zoom;
//#UC END# *47A042E100E2_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.InitFields

procedure TevCustomEditorWindowPrim.DoForceRepaint;
//#UC START# *4BCC315901D3_4B28D63A00EC_var*
var
 l_OFR : Boolean;
//#UC END# *4BCC315901D3_4B28D63A00EC_var*
begin
//#UC START# *4BCC315901D3_4B28D63A00EC_impl*
 if (f_LockForceRepaint > 0) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=244712636&focusedCommentId=263292913#comment-263292913
  Exit;
 l_OFR := ForceRepaint;
 try
  ForceRepaint := true;
  inherited DoForceRepaint;
 finally
  ForceRepaint := l_OFR;
 end;//try..finally
//#UC END# *4BCC315901D3_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.DoForceRepaint

procedure TevCustomEditorWindowPrim.DoAfterCreateCanvas;
//#UC START# *4D3974AB02E5_4B28D63A00EC_var*
//#UC END# *4D3974AB02E5_4B28D63A00EC_var*
begin
//#UC START# *4D3974AB02E5_4B28D63A00EC_impl*
 f_Canvas.Zoom := f_Zoom;
//#UC END# *4D3974AB02E5_4B28D63A00EC_impl*
end;//TevCustomEditorWindowPrim.DoAfterCreateCanvas

initialization
{$If not defined(NoScripts)}
// ����������� TevCustomEditorWindowPrim
 TtfwClassRef.Register(TevCustomEditorWindowPrim);
{$IfEnd} //not NoScripts

end.