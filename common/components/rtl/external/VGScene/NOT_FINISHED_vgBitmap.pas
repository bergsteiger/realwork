unit NOT_FINISHED_vgBitmap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VGScene"
// ������: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgBitmap.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgBitmap
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgObject,
  vgCustomBitmap
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgBitmapObject = class(TvgObject)
 end;//TvgBitmapObject

 TvgBitmap = class(TvgCustomBitmap)
 end;//TvgBitmap
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}


{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// ����������� TvgBitmapObject
 TtfwClassRef.Register(TvgBitmapObject);
{$IfEnd} //not NoScripts AND not NoVGScene

end.