unit nevSegmentFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevSegmentFormatInfo.pas"
// Начат: 01.09.2011 19:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevSegmentFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevFormatInfo,
  evResultFontInterfaces,
  nevBase,
  nevTools
  ;

type
 TnevSegmentFormatInfo = class(TnevFormatInfo)
 protected
 // realized methods
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); override;
 protected
 // overridden protected methods
   procedure Release; override;
   function IsSegment: Boolean; override;
   procedure DoFontSuperposition(var theResult: IevResultFont;
     var theNeedApplyZoom: Boolean;
     aCorrectItalic: Boolean;
     aInTable: Boolean;
     var theOwnFont: Boolean); override;
 public
 // overridden public methods
   function ParaFont(aCorrectItalic: Boolean): IevResultFont; override;
 end;//TnevSegmentFormatInfo

implementation

uses
  l3Base,
  k2Const,
  l3Interfaces,
  k2Tags,
  evResultFontHolder
  ;

// start class TnevSegmentFormatInfo

procedure TnevSegmentFormatInfo.DoInvalidateShape(const aShape: InevObject;
  aParts: TnevShapeParts);
//#UC START# *48172A690313_4E5FAB3E0333_var*
//#UC END# *48172A690313_4E5FAB3E0333_var*
begin
//#UC START# *48172A690313_4E5FAB3E0333_impl*
 Assert(false);
//#UC END# *48172A690313_4E5FAB3E0333_impl*
end;//TnevSegmentFormatInfo.DoInvalidateShape

procedure TnevSegmentFormatInfo.Release;
//#UC START# *479F2AFB0397_4E5FAB3E0333_var*
//#UC END# *479F2AFB0397_4E5FAB3E0333_var*
begin
//#UC START# *479F2AFB0397_4E5FAB3E0333_impl*
 inherited;
//#UC END# *479F2AFB0397_4E5FAB3E0333_impl*
end;//TnevSegmentFormatInfo.Release

function TnevSegmentFormatInfo.IsSegment: Boolean;
//#UC START# *4E5FAB8A0258_4E5FAB3E0333_var*
//#UC END# *4E5FAB8A0258_4E5FAB3E0333_var*
begin
//#UC START# *4E5FAB8A0258_4E5FAB3E0333_impl*
 Result := true;
//#UC END# *4E5FAB8A0258_4E5FAB3E0333_impl*
end;//TnevSegmentFormatInfo.IsSegment

function TnevSegmentFormatInfo.ParaFont(aCorrectItalic: Boolean): IevResultFont;
//#UC START# *4E5FBCFA0118_4E5FAB3E0333_var*
//#UC END# *4E5FBCFA0118_4E5FAB3E0333_var*
begin
//#UC START# *4E5FBCFA0118_4E5FAB3E0333_impl*
 //Assert(false);
 Result := inherited ParaFont(aCorrectItalic);
//#UC END# *4E5FBCFA0118_4E5FAB3E0333_impl*
end;//TnevSegmentFormatInfo.ParaFont

procedure TnevSegmentFormatInfo.DoFontSuperposition(var theResult: IevResultFont;
  var theNeedApplyZoom: Boolean;
  aCorrectItalic: Boolean;
  aInTable: Boolean;
  var theOwnFont: Boolean);
//#UC START# *4E5FC90E03BD_4E5FAB3E0333_var*
var
 l_SegmentAndParaFontSuperposition : IevResultFont;
//#UC END# *4E5FC90E03BD_4E5FAB3E0333_var*
begin
//#UC START# *4E5FC90E03BD_4E5FAB3E0333_impl*
 theOwnFont := true;
 l_SegmentAndParaFontSuperposition := TevResultFontHolder.Make;
 with l_SegmentAndParaFontSuperposition do
 begin
  Assert(theResult <> nil);
  if (theResult <> nil) then
   AddFont(theResult);
  if aInTable then
   if IsTransparent(k2_tiSize) then
    theNeedApplyZoom := false;
    // http://mdp.garant.ru/pages/viewpage.action?pageId=213254777&focusedCommentId=213254791#comment-213254791
  AddFont(Parent.ParaFont(aCorrectItalic));
 end;//with l_SegmentAndParaFontSuperposition
 theResult := l_SegmentAndParaFontSuperposition;
//#UC END# *4E5FC90E03BD_4E5FAB3E0333_impl*
end;//TnevSegmentFormatInfo.DoFontSuperposition

end.