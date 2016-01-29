unit nevFontTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevFontTool.pas"
// Начат: 15.09.2011 17:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Garbage::TnevFontTool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3CProtoObject,
  nevGarbageInterfaces,
  nevBase,
  evResultFontInterfaces,
  l3Variant
  ;

type
 _nevFontTool_Parent_ = Tl3CProtoObject;
 {$Include ..\Everest\nevFontTool.imp.pas}
 TnevFontTool = class(_nevFontTool_, InevFontTool)
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: InevFontTool; reintroduce;
     {* Сигнатура фабрики TnevFontTool.Make }
 end;//TnevFontTool

implementation

uses
  evStandardStyles,
  SysUtils,
  evResultFontHolder,
  evDef,
  evdTypes,
  nevTools,
  evStyleInterface,
  k2Tags,
  k2Const
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  l3Base,
  evDefaultStylesFontSizes,
  l3MinMax,
  ObjectSegment_Const,
  l3Types,
  Table_Const,
  l3Math,
  evGlyphFont,
  BitmapPara_Const
  ;

{$Include ..\Everest\nevFontTool.imp.pas}

// start class TnevFontTool

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
end;

end.