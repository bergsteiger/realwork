unit evHAFPainter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3InternalInterfaces
 , l3Interfaces
 , l3Variant
;

type
 TevHAFPainter = class(Tl3ProtoObject, Il3HAFPainter)
  function MacroDocCurrentPage(const aCanvas: Il3Canvas): Il3CString;
  function MacroDocPagesCount: Il3CString;
  procedure Create(const aMacroReplacer: Il3HAFMacroReplacer);
  procedure Make(const aMacroReplacer: Il3HAFMacroReplacer);
  procedure TuneHeader(const aCanvas: Il3Canvas;
   aHeader: Tl3Variant;
   aTop: Boolean);
  function DoNeedPagesCount: Boolean;
  function DocumentName: Il3CString;
  function NeedPagesCount: Boolean;
  procedure SetPagesCount(aValue: Integer);
  procedure StartPage(const CN: Il3Canvas;
   aTop: Boolean);
  function MacroReplacer: Il3HAFMacroReplacer;
 end;//TevHAFPainter
 
implementation

uses
 l3ImplUses
 , l3String
 , evHAFPainterMacros
 , nevRealTools
 , l3Units
 , nevTools
 , Graphics
 , Windows
 , evConst
 , evDef
 , Document_Const
 , SBS_Const
 , k2Tags
 , evSBSPar
 , evdTypes
 , nevHAFPainterView
 , l3Base
;

end.
