unit nevCommentFormatInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevCommentFormatInfo.pas"
// �����: 01.09.2011 11:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevCommentFormatInfo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevDocumentPartFormatInfo,
  l3Variant
  ;

type
 TnevCommentFormatInfo = class(TnevDocumentPartFormatInfo)
 protected
 // overridden protected methods
   procedure TuneFrameText(aText: Tl3Variant); override;
   function AllowTotalRecalc: Boolean; override;
 end;//TnevCommentFormatInfo

implementation

uses
  evdStyles,
  k2Tags
  ;

// start class TnevCommentFormatInfo

procedure TnevCommentFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4E5F3389001D_var*
//#UC END# *4E5F8B2601DC_4E5F3389001D_var*
begin
//#UC START# *4E5F8B2601DC_4E5F3389001D_impl*
 aText.IntA[k2_tiStyle] := ev_saUserComment;
//#UC END# *4E5F8B2601DC_4E5F3389001D_impl*
end;//TnevCommentFormatInfo.TuneFrameText

function TnevCommentFormatInfo.AllowTotalRecalc: Boolean;
//#UC START# *4E7095FC023D_4E5F3389001D_var*
//#UC END# *4E7095FC023D_4E5F3389001D_var*
begin
//#UC START# *4E7095FC023D_4E5F3389001D_impl*
 Result := true;
//#UC END# *4E7095FC023D_4E5F3389001D_impl*
end;//TnevCommentFormatInfo.AllowTotalRecalc

end.