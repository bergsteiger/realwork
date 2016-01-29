unit evTextParaPainterPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evTextParaPainterPrim.pas"
// �����: 06.04.2009 20:21
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::LeafPara Painters::TevTextParaPainterPrim
//
// ������������� �����, ����� ������ ������ ���� ����� �� ������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters)}
uses
  nevTools,
  l3InternalInterfaces,
  l3Interfaces,
  nevBase,
  l3Units,
  nevRealTools,
  l3Variant,
  l3ProtoObject
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 _X_ = InevTextPara;
 {$Include ..\Everest\evLeafParaPainter.imp.pas}
 TevTextParaPainterPrim = class(_evLeafParaPainter_)
  {* ������������� �����, ����� ������ ������ ���� ����� �� ������ ���������� }
 end;//TevTextParaPainterPrim
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  evDefaultStylesFontSizes,
  k2Tags,
  evdTypes
  {$If defined(evUseVisibleCursors)}
  ,
  nevAfterEndPoint
  {$IfEnd} //evUseVisibleCursors
  ,
  Graphics,
  l3SmartCanvas,
  l3MinMax,
  l3Base,
  l3Tree
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  TableCell_Const,
  DocumentSub_Const,
  Mark_Const,
  LeafPara_Const,
  CommentPara_Const,
  Block_Const,
  TextPara_Const,
  k2Base,
  SysUtils,
  Table_Const,
  Windows
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}

{$Include ..\Everest\evLeafParaPainter.imp.pas}


{$IfEnd} //evNeedPainters
end.