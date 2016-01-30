unit nevFontTool;

// Модуль: "w:\common\components\gui\Garant\Everest\nevFontTool.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevGarbageInterfaces
 , evResultFontInterfaces
 , l3Variant
 , nevBase
;

type
 _nevFontTool_Parent_ = Tl3CProtoObject;
 {$Include nevFontTool.imp.pas}
 TnevFontTool = class(_nevFontTool_, InevFontTool)
  public
   constructor Create; reintroduce;
   class function Make: InevFontTool; reintroduce;
 end;//TnevFontTool

implementation

uses
 l3ImplUses
 , evStandardStyles
 , SysUtils
 , evResultFontHolder
 , evDef
 , evdTypes
 , nevTools
 , evStyleInterface
 , k2Tags
 , k2Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , l3Base
 , evDefaultStylesFontSizes
 , l3MinMax
 , ObjectSegment_Const
 , l3Types
 , Table_Const
 , l3Math
 , evGlyphFont
 , BitmapPara_Const
;

{$Include nevFontTool.imp.pas}

constructor TnevFontTool.Create;
//#UC START# *4E7204190000_4E7203ED01F2_var*
//#UC END# *4E7204190000_4E7203ED01F2_var*
begin
//#UC START# *4E7204190000_4E7203ED01F2_impl*
 inherited Create;
//#UC END# *4E7204190000_4E7203ED01F2_impl*
end;//TnevFontTool.Create

class function TnevFontTool.Make: InevFontTool;
var
 l_Inst : TnevFontTool;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevFontTool.Make

end.
