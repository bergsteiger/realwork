unit evNSRCWriterTypes;

// Модуль: "w:\common\components\gui\Garant\Everest\evNSRCWriterTypes.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdTypes
;

type
 TevNSRCParaStyle = object
  public
   Letter: AnsiChar;
   ParaLI: Integer;
   ParaWC: Integer;
   ParaFI: Integer;
   IsDecorPara: Boolean;
   PrintFontSize: Integer;
   StyleID: Integer;
  public
   function EQ(const anOther: TevNSRCParaStyle): Boolean;
    {* Функция проверки эквивалентности }
   procedure Clear;
 end;//TevNSRCParaStyle

 TevNSRCParaParas = object
  public
   Justification: TevIndentType;
   Width: Integer;
   FirstIndent: Integer;
   LeftIndent: Integer;
   Style: TevNSRCParaStyle;
  public
   procedure Clear;
 end;//TevNSRCParaParas

implementation

uses
 l3ImplUses
 , l3Base
 , l3Const
;

function TevNSRCParaStyle.EQ(const anOther: TevNSRCParaStyle): Boolean;
 {* Функция проверки эквивалентности }
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
