unit nevControlsBlockFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevControlsBlockFormatInfo.pas"
// Начат: 01.09.2011 13:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevControlsBlockFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevDocumentPartFormatInfo,
  nevBase,
  l3Variant
  ;

type
 TnevControlsBlockFormatInfo = class(TnevDocumentPartFormatInfo)
 protected
 // overridden property methods
   function pm_GetLocSpacing: TnevRect; override;
 protected
 // overridden protected methods
   procedure TuneFrameText(aText: Tl3Variant); override;
   function AllowTotalRecalc: Boolean; override;
 end;//TnevControlsBlockFormatInfo

implementation

uses
  evdStyles,
  k2Tags,
  Graphics,
  evTextStyle_Const,
  l3Types,
  l3String
  ;

// start class TnevControlsBlockFormatInfo

function TnevControlsBlockFormatInfo.pm_GetLocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_4E5F54E500AAget_var*
//#UC END# *4E5F3D1102B8_4E5F54E500AAget_var*
begin
//#UC START# *4E5F3D1102B8_4E5F54E500AAget_impl*
 Result := inherited pm_GetLocSpacing;
 if l3IsNil(Obj.AsObject.PCharLenA[k2_tiShortName]) then
  Result.Top := 0;
//#UC END# *4E5F3D1102B8_4E5F54E500AAget_impl*
end;//TnevControlsBlockFormatInfo.pm_GetLocSpacing

procedure TnevControlsBlockFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4E5F54E500AA_var*
//#UC END# *4E5F8B2601DC_4E5F54E500AA_var*
begin
//#UC START# *4E5F8B2601DC_4E5F54E500AA_impl*
 aText.IntA[k2_tiStyle] := ev_saControlsBlockHeader;
//#UC END# *4E5F8B2601DC_4E5F54E500AA_impl*
end;//TnevControlsBlockFormatInfo.TuneFrameText

function TnevControlsBlockFormatInfo.AllowTotalRecalc: Boolean;
//#UC START# *4E7095FC023D_4E5F54E500AA_var*
//#UC END# *4E7095FC023D_4E5F54E500AA_var*
begin
//#UC START# *4E7095FC023D_4E5F54E500AA_impl*
 Result := true;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=232098711
 // - чтобы ноды-группы пересчитывались полностью
 //   вообще говоря - надо в TevNodePainter.CalcHeight как-то флажок взводить
//#UC END# *4E7095FC023D_4E5F54E500AA_impl*
end;//TnevControlsBlockFormatInfo.AllowTotalRecalc

end.