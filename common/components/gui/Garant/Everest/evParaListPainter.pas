unit evParaListPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evParaListPainter.pas"
// Начат: 07.04.2009 18:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevParaListPainter
//
// Рисователь списка параграфов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
 { Рисователь параграфа является рисователем списка параграфов }

type
 _X_ = InevParaList;
 {$Include ..\Everest\evParaListPainter.imp.pas}
 TevParaListPainter = class(_evParaListPainter_)
  {* Рисователь списка параграфов }
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