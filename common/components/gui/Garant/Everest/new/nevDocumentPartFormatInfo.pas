unit nevDocumentPartFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevDocumentPartFormatInfo.pas"
// Начат: 01.09.2011 11:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevDocumentPartFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevListFormatInfo,
  nevBase,
  nevFormatInfo
  ;

type
 TnevDocumentPartFormatInfo = class(TnevListFormatInfo)
 protected
 // overridden property methods
   function pm_GetLocSpacing: TnevRect; override;
 protected
 // overridden protected methods
   function AllowTotalRecalc: Boolean; override;
 public
 // overridden public methods
   function GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo; override;
 end;//TnevDocumentPartFormatInfo

implementation

uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evDocumentPart
  {$IfEnd} //k2ForEditor
  ,
  l3Units,
  k2Tags
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  l3String,
  nevTools
  ;

type
  THackFormatInfo = class(TnevListFormatInfo)
  end;//THackFormatInfo

// start class TnevDocumentPartFormatInfo

function TnevDocumentPartFormatInfo.GetInfoForChild(const aChild: InevObjectPrim): TnevFormatInfo;
//#UC START# *4815C94A027A_4E5F3349020F_var*
//#UC END# *4815C94A027A_4E5F3349020F_var*
begin
//#UC START# *4815C94A027A_4E5F3349020F_impl*
 if aChild.IsDecorationElement then
  Result := THackFormatInfo(ParentInfo).LocLocDecorFormatInfo(aChild)
 else
  Result := inherited GetInfoForChild(aChild);
//#UC END# *4815C94A027A_4E5F3349020F_impl*
end;//TnevDocumentPartFormatInfo.GetInfoForChild

function TnevDocumentPartFormatInfo.pm_GetLocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_4E5F3349020Fget_var*

 function lp_HasBlockStyle(const aPara: InevPara): Boolean;
 var
  l_Style: Tl3Variant;
 begin
  Result := False;
  if (aPara <> nil) and EvHasOwnStyle(aPara) then
  begin
   l_Style := aPara.AsObject.Attr[k2_tiStyle];
   Result := not l3IsNil(l_Style.PCharLenA[k2_tiShortName]);
  end; // if EvHasOwnStyle(aPara) then
 end;

var
 l_Para: InevPara;

 function lp_NeedIncBottom: Boolean;
 begin
  Result := True;
  if not Obj.AsObject.QT(InevPara, l_Para) then
   Assert(false);
  if lp_HasBlockStyle(l_Para.Next) then
   Result := False;
 end;

var
 l_Style : Tl3Variant;
//#UC END# *4E5F3D1102B8_4E5F3349020Fget_var*
begin
//#UC START# *4E5F3D1102B8_4E5F3349020Fget_impl*
 if Obj.AsObject.BoolA[k2_tiCollapsed] then
  if EvHasOwnStyle(Obj) and not EvExpandedText(Obj.AsObject)then
   Result := l3Rect0
  else
   Result := inherited pm_GetLocSpacing
 else
 begin
  Result := inherited pm_GetLocSpacing;
  if EvHasOwnStyle(Obj) and not EvExpandedText(Obj.AsObject)then
  begin
   l_Style := Obj.AsObject.Attr[k2_tiStyle];
   if not l3IsNil(l_Style.PCharLenA[k2_tiShortName]) then
   // - стиль имеет заголовок, который надо рисовать
   begin
    Result.Top := Result.Top + Self.DecorHeight(nev_dtHeader);
    if lp_NeedIncBottom then
     Result.Bottom := Result.Bottom + Self.DecorHeight(nev_dtFooter)
    else
     Result.Bottom := 0;
   end;//not l3IsNil(l_Style.PCharLenA[k2_tiShortName])
  end; // if EvHasOwnStyle(Obj) then
 end;
 if Metrics.ShowDocumentParts then
 begin
  Tl3Rect(Result).TopLeft := Tl3Rect(Result).TopLeft.Add(l3Point1(evDocumentPartMargin));
  Tl3Rect(Result).BottomRight := Tl3Rect(Result).BottomRight.Add(l3PointY(evDocumentPartMargin));
 end;//aView.ShowDocumentParts
//#UC END# *4E5F3D1102B8_4E5F3349020Fget_impl*
end;//TnevDocumentPartFormatInfo.pm_GetLocSpacing

function TnevDocumentPartFormatInfo.AllowTotalRecalc: Boolean;
//#UC START# *4E7095FC023D_4E5F3349020F_var*
//#UC END# *4E7095FC023D_4E5F3349020F_var*
begin
//#UC START# *4E7095FC023D_4E5F3349020F_impl*
 Result := false;
//#UC END# *4E7095FC023D_4E5F3349020F_impl*
end;//TnevDocumentPartFormatInfo.AllowTotalRecalc

end.