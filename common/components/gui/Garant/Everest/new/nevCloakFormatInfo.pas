unit nevCloakFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevCloakFormatInfo.pas"
// �����: 01.09.2011 13:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevCloakFormatInfo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevControlsBlockFormatInfo,
  l3Variant
  ;

type
 TnevCloakFormatInfo = class(TnevControlsBlockFormatInfo)
 protected
 // overridden protected methods
   procedure TuneFrameText(aText: Tl3Variant); override;
 end;//TnevCloakFormatInfo

implementation

uses
  evdStyles,
  k2Tags,
  Graphics,
  evTextStyle_Const
  ;

// start class TnevCloakFormatInfo

procedure TnevCloakFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4E5F550D0032_var*
//#UC END# *4E5F8B2601DC_4E5F550D0032_var*
begin
//#UC START# *4E5F8B2601DC_4E5F550D0032_impl*
 aText.IntA[k2_tiStyle] := ev_saCloakHeader;
//#UC END# *4E5F8B2601DC_4E5F550D0032_impl*
end;//TnevCloakFormatInfo.TuneFrameText

end.