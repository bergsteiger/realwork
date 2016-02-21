unit destLevelText;

// Модуль: "w:\common\components\rtl\Garant\dd\destLevelText.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , l3Memory
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestLevelText = class(TddRTFDestination)
  private
   f_Length: Integer;
    {* Поле для свойства Length }
   f_Numbers: AnsiString;
    {* Поле для свойства Numbers }
   f_Text: AnsiString;
    {* Поле для свойства Text }
   f_UnicodeSymbol: Word;
    {* Поле для свойства UnicodeSymbol }
   f_UnicodeBuffer: Tl3MemoryStream;
    {* Поле для свойства UnicodeBuffer }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
    aState: TddRTFState); override;
   procedure AddUnicodeChar(aText: Word;
    aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
  public
   property Length: Integer
    read f_Length
    write f_Length;
   property Numbers: AnsiString
    read f_Numbers
    write f_Numbers;
   property Text: AnsiString
    read f_Text
    write f_Text;
   property UnicodeSymbol: Word
    read f_UnicodeSymbol
    write f_UnicodeSymbol;
   property UnicodeBuffer: Tl3MemoryStream
    read f_UnicodeBuffer;
 end;//TdestLevelText

implementation

uses
 l3ImplUses
 , destListLevel
 , SysUtils
 , l3Types
 , l3String
;

procedure TdestLevelText.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51DD039F01CF_var*
var
 l_Str: Tl3PCharLen;
//#UC END# *5461BEC2017D_51DD039F01CF_var*
begin
//#UC START# *5461BEC2017D_51DD039F01CF_impl*
 if aNewDest.RDS = rdsListLevel then
 begin
  TdestListLevel(aNewDest).Level.Text := Text;
  TdestListLevel(aNewDest).Level.Numbers := Numbers;
  l_Str := l3PCharLen(UnicodeBuffer.MemoryPool.AsPointer, UnicodeBuffer.Position div 2, cp_Unicode);
  TdestListLevel(aNewDest).Level.UnicodeText.AsPCharLen := l_Str;
 end; // aNewDest.RDS = rdsListLevel
 Clear;
//#UC END# *5461BEC2017D_51DD039F01CF_impl*
end;//TdestLevelText.Close

procedure TdestLevelText.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_51DD039F01CF_var*
//#UC END# *54E1F08400F9_51DD039F01CF_var*
begin
//#UC START# *54E1F08400F9_51DD039F01CF_impl*
 Assert(False);
//#UC END# *54E1F08400F9_51DD039F01CF_impl*
end;//TdestLevelText.WriteText

procedure TdestLevelText.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51DD039F01CF_var*
//#UC END# *479731C50290_51DD039F01CF_var*
begin
//#UC START# *479731C50290_51DD039F01CF_impl*
 FreeAndNil(f_UnicodeBuffer);
 inherited;
//#UC END# *479731C50290_51DD039F01CF_impl*
end;//TdestLevelText.Cleanup

procedure TdestLevelText.Clear;
//#UC START# *51D27A48038E_51DD039F01CF_var*
//#UC END# *51D27A48038E_51DD039F01CF_var*
begin
//#UC START# *51D27A48038E_51DD039F01CF_impl*
 f_Length:= 0;
 f_UnicodeBuffer.Size := 0;
 f_UnicodeBuffer.Position := 0;
 f_Text:= '';
 f_Numbers:= '';
//#UC END# *51D27A48038E_51DD039F01CF_impl*
end;//TdestLevelText.Clear

procedure TdestLevelText.AddAnsiChar(aText: AnsiChar;
 aState: TddRTFState);
//#UC START# *51D27C0402E9_51DD039F01CF_var*
//#UC END# *51D27C0402E9_51DD039F01CF_var*
begin
//#UC START# *51D27C0402E9_51DD039F01CF_impl*
 if Length = 0 then
  Length:= Ord(aText)
 else
 begin
  if aText <> ';' then
   f_Numbers:= f_Numbers + aText;
  if aText < #9 then
   f_Text:= f_Text + '%s'
  else
  if aText <> ';' then
   f_Text:= f_Text + aText;
 end;
//#UC END# *51D27C0402E9_51DD039F01CF_impl*
end;//TdestLevelText.AddAnsiChar

procedure TdestLevelText.AddUnicodeChar(aText: Word;
 aState: TddRTFState);
//#UC START# *51D27DFA0308_51DD039F01CF_var*

 function lp_NeedSymbol: Boolean;
 const
  cnUnicodeA = 1040;
  cnUnicode_ya = 1103;
  cnUnicode_yo = 1105;
  cnUnicodeYO = 1025;
 begin
  Result := (aText >= cnUnicodeA) and (aText <= cnUnicode_ya) or (aText = cnUnicode_yo) or (aText = cnUnicodeYO);
 end;

//#UC END# *51D27DFA0308_51DD039F01CF_var*
begin
//#UC START# *51D27DFA0308_51DD039F01CF_impl*
 if lp_NeedSymbol then
  UnicodeBuffer.Write(aText, SizeOf(aText));
//#UC END# *51D27DFA0308_51DD039F01CF_impl*
end;//TdestLevelText.AddUnicodeChar

constructor TdestLevelText.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51DD039F01CF_var*
//#UC END# *51E7C9DB0213_51DD039F01CF_var*
begin
//#UC START# *51E7C9DB0213_51DD039F01CF_impl*
 inherited;
 f_UnicodeBuffer := Tl3MemoryStream.Create;
//#UC END# *51E7C9DB0213_51DD039F01CF_impl*
end;//TdestLevelText.Create

end.
