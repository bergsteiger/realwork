unit evParaListPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evParaListPainter.pas"
// �����: 07.04.2009 18:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevParaListPainter
//
// ���������� ������ ����������
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
  nevRealTools,
  l3Interfaces,
  nevBase,
  l3InternalInterfaces,
  l3Units,
  l3Variant,
  l3ProtoObject
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
 {$Define ParaPainter_IsParaListPainter}
 { ���������� ��������� �������� ����������� ������ ���������� }

type
 _X_ = InevParaList;
 {$Include ..\Everest\evParaListPainter.imp.pas}
 TevParaListPainter = class(_evParaListPainter_)
  {* ���������� ������ ���������� }
 end;//TevParaListPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  k2Tags,
  l3VirtualCanvas,
  nevVirtualDrawView,
  evParaDrawTools
  {$If defined(evUseVisibleCursors)}
  ,
  nevAfterEndPoint
  {$IfEnd} //evUseVisibleCursors
  ,
  l3MinMax,
  nevFacade,
  l3Const,
  Graphics,
  l3SmartCanvas,
  l3Base,
  l3Tree
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evdTypes,
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

{$Include ..\Everest\evParaListPainter.imp.pas}


{$IfEnd} //evNeedPainters
end.