unit nevNodeGroupFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevNodeGroupFormatInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevNodeGroupFormatInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevControlsBlockFormatInfo,
  nevBase,
  l3Variant
  ;

type
 TnevNodeGroupFormatInfo = class(TnevControlsBlockFormatInfo)
 protected
 // overridden property methods
   function pm_GetLocSpacing: TnevRect; override;
 protected
 // overridden protected methods
   procedure TuneFrameText(aText: Tl3Variant); override;
 end;//TnevNodeGroupFormatInfo

implementation

uses
  evTextStyle_Const,
  Graphics,
  k2Tags,
  evdStyles
  ;

// start class TnevNodeGroupFormatInfo

function TnevNodeGroupFormatInfo.pm_GetLocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_4ED4EA8B0364get_var*
//#UC END# *4E5F3D1102B8_4ED4EA8B0364get_var*
begin
//#UC START# *4E5F3D1102B8_4ED4EA8B0364get_impl*
 Result := inherited pm_GetLocSpacing;
 Result.Left := 0;
 Result.Right := 0;
//#UC END# *4E5F3D1102B8_4ED4EA8B0364get_impl*
end;//TnevNodeGroupFormatInfo.pm_GetLocSpacing

procedure TnevNodeGroupFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4ED4EA8B0364_var*
//#UC END# *4E5F8B2601DC_4ED4EA8B0364_var*
begin
//#UC START# *4E5F8B2601DC_4ED4EA8B0364_impl*
 aText.IntA[k2_tiStyle] := ev_saNodeGroupHeader;
//#UC END# *4E5F8B2601DC_4ED4EA8B0364_impl*
end;//TnevNodeGroupFormatInfo.TuneFrameText

end.