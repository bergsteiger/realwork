unit NOT_FINISHED_F_ImageView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Frames"
// ������: "w:/archi/source/projects/Archi/Frames/NOT_FINISHED_F_ImageView.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Frames::Frames::F_ImageView
//
// ����� ��� ��������� ��������������� TIFF
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  Classes
  {$If not defined(NoImageEn)}
  ,
  imageenview
  {$IfEnd} //not NoImageEn
  
  ;

type
 TfrmImgViewer = class
 public
 // public fields
   PageView : TImageEnView;
 end;//TfrmImgViewer
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
{$IfEnd} //AppClientSide
end.