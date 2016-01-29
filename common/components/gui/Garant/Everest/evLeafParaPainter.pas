unit evLeafParaPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evLeafParaPainter.pas"
// �����: 07.04.2009 17:21
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::LeafPara Painters::TevLeafParaPainter
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
 _X_ = InevLeafPara;
 {$Include ..\Everest\evLeafParaPainter.imp.pas}
 TevLeafParaPainter = class(_evLeafParaPainter_)
 end;//TevLeafParaPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
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