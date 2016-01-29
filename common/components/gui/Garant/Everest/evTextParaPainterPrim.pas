unit evTextParaPainterPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evTextParaPainterPrim.pas"
// Начат: 06.04.2009 20:21
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::LeafPara Painters::TevTextParaPainterPrim
//
// Промежуточный класс, чтобы другие классы было проще на модель переносить
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
  {* Промежуточный класс, чтобы другие классы было проще на модель переносить }
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