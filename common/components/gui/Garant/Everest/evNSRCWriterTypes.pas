unit evNSRCWriterTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evNSRCWriterTypes.pas"
// Начат: 26.03.2010 14:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Generators::evNSRCWriterTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdTypes
  ;

type
 TevNSRCParaStyle = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   Letter : AnsiChar;
   ParaLI : Integer;
   ParaWC : Integer;
   ParaFI : Integer;
   IsDecorPara : Boolean;
   PrintFontSize : Integer;
   StyleID : Integer;
 public
    function EQ(const anOther: TevNSRCParaStyle): Boolean;
     {* Функция проверки эквивалентности }
    procedure Clear;
 end;//TevNSRCParaStyle

 TevNSRCParaParas = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   Justification : TevIndentType;
   Width : Integer;
   FirstIndent : Integer;
   LeftIndent : Integer;
   Style : TevNSRCParaStyle;
 public
    procedure Clear;
 end;//TevNSRCParaParas

implementation

uses
  l3Base,
  l3Const
  ;

// start class TevNSRCParaStyle

function TevNSRCParaStyle.EQ(const anOther: TevNSRCParaStyle): Boolean;
//#UC START# *4BACA14E0110_4BAC9A7301E3_var*
//#UC END# *4BACA14E0110_4BAC9A7301E3_var*
begin
//#UC START# *4BACA14E0110_4BAC9A7301E3_impl*
 Result :=
  (Self.Letter = anOther.Letter) AND
  (Self.ParaLI = anOther.ParaLI) AND
  (Self.ParaWC = anOther.ParaWC) AND
  (Self.ParaFI = anOther.ParaFI) AND
  (Self.IsDecorPara = anOther.IsDecorPara) AND
  (Self.PrintFontSize = anOther.PrintFontSize) AND
  (Self.StyleID = anOther.StyleID);
//#UC END# *4BACA14E0110_4BAC9A7301E3_impl*
end;//TevNSRCParaStyle.EQ

procedure TevNSRCParaStyle.Clear;
//#UC START# *4BACA4BF01A5_4BAC9A7301E3_var*
//#UC END# *4BACA4BF01A5_4BAC9A7301E3_var*
begin
//#UC START# *4BACA4BF01A5_4BAC9A7301E3_impl*
 l3FillChar(Self, SizeOf(Self));
//#UC END# *4BACA4BF01A5_4BAC9A7301E3_impl*
end;//TevNSRCParaStyle.Clear
// start class TevNSRCParaParas

procedure TevNSRCParaParas.Clear;
//#UC START# *4BACA4D403D4_4BAC9ADB0162_var*
//#UC END# *4BACA4D403D4_4BAC9ADB0162_var*
begin
//#UC START# *4BACA4D403D4_4BAC9ADB0162_impl*
 Justification := ev_itNone;
 FirstIndent := l3NilLong;
 Width := l3NilLong;
 LeftIndent := l3NilLong;
//#UC END# *4BACA4D403D4_4BAC9ADB0162_impl*
end;//TevNSRCParaParas.Clear

end.