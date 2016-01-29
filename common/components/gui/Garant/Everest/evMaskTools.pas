unit evMaskTools;

{ Библиотека "Эверест"    }
{ Начал: Инишев Д.А.       }
{ Модуль: evMaskTools - утилитные функции для работы с контролами дат. }
{ Начат: 12.11.2004 17:02 }
{ $Id: evMaskTools.pas,v 1.5 2007/12/04 12:47:02 lulin Exp $ }

// $Log: evMaskTools.pas,v $
// Revision 1.5  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.3.8.4  2007/07/18 15:07:19  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.3.8.3  2007/04/10 12:05:13  lulin
// - cleanup.
//
// Revision 1.3.8.2  2007/01/05 14:37:19  lulin
// - cleanup.
//
// Revision 1.3.8.1  2006/05/18 13:20:22  dinishev
// Add CVS _tag
//

interface

uses
  Messages,

  evdTypes
  ;

function InputChar(const Value    : string;
                   const EditMask : string; 
                   var NewChar    : Char;
                   Offset         : Integer): Boolean;
{* - Проверяет новый вводимый символ}

function IsNumPad(CharCode: Word; 
                  var Value: Char): Boolean;  

function IsCmdKey(const aMessage: TMessage;
                  aControlType: TevControlType): Boolean;
{* - Функция проверяет переданный символ на принадлежность 
     управляющему - "+", "-" и т.п.}

implementation

uses
 Windows,

 MaskUtils,
 SysUtils,

 evControlParaConst
 ;

function IsCmdKey(const aMessage : TMessage;
                  aControlType   : TevControlType): Boolean;
var
 KeyMsg: TWMKeyDown;
begin
 KeyMsg := TWMKeyDown(aMessage);
 Result := KeyMsg.CharCode in evParaCtrlKeys;
 if not Result then
  if aControlType = ev_ctCalEdit then
   Result := KeyMsg.CharCode in evCalParaCtrlKey;
end;

function IsNumPad(CharCode: Word; var Value: Char): Boolean;
const
 CharArr: array [VK_NUMPAD0..VK_NUMPAD9] of Char = ('0', '1', '2', '3', '4',
  '5', '6', '7', '8', '9');
begin
 Result := (CharCode >= VK_NUMPAD0) and (CharCode <= VK_NUMPAD9);
 if Result then Value := CharArr[CharCode];
end;

function DoInputChar(const Value    : string; 
                     const EditMask : string; 
                     var NewChar    : Char;
                     MaskOffset     : Integer): Boolean;
{* - Проверяет новый вводимый символ}
var
 Dir   : TMaskDirectives;
 Str   : string;
 CType : TMaskCharType;

  function IsKatakana(const Chr: Byte): Boolean;
  begin
   Result := (SysLocale.PriLangID = LANG_JAPANESE) and (Chr in [$A1..$DF]);
  end;

  function TestChar(NewChar: Char): Boolean;
  var
   Offset: Integer;
  begin
   Offset := MaskOffsetToOffset(EditMask, MaskOffset);
   Result := not ((MaskOffset < Length(EditMask)) and
             (UpCase(EditMask[MaskOffset]) = UpCase(EditMask[MaskOffset+1]))) or
             (ByteType(Value, Offset) = mbTrailByte) or
             (ByteType(Value, Offset+1) = mbLeadByte);
  end;

begin
 Result := True;
 CType := MaskGetCharType(EditMask, MaskOffset);
 if CType in [mcLiteral, mcIntlLiteral] then
  NewChar := MaskIntlLiteralToChar(EditMask[MaskOffset])
 else
 begin
  Dir := MaskGetCurrentDirectives(EditMask, MaskOffset);
  case EditMask[MaskOffset] of
   mMskNumeric, mMskNumericOpt:
    begin
     if not ((NewChar >= '0') and (NewChar <= '9')) then
      Result := False;
    end;
   mMskNumSymOpt:
     begin
      if not (((NewChar >= '0') and (NewChar <= '9')) or
        (NewChar = ' ') or(NewChar = '+') or(NewChar = '-')) then
       Result := False;
     end;
   mMskAscii, mMskAsciiOpt:
     begin
      if (NewChar in LeadBytes) and TestChar(NewChar) then
      begin
       Result := False;
       Exit;
      end;
      if IsCharAlpha(NewChar) then
      begin
       Str := ' ';
       Str[1] := NewChar;
       if (mdUpperCase in Dir)  then
        Str := AnsiUpperCase(Str)
       else if mdLowerCase in Dir then
        Str := AnsiLowerCase(Str);
       NewChar := Str[1];
      end;
     end;
   mMskAlpha, mMskAlphaOpt, mMskAlphaNum, mMskAlphaNumOpt:
     begin
      if (NewChar in LeadBytes) then
      begin
       if TestChar(NewChar) then
        Result := False;
       Exit;
      end;
      Str := ' ';
      Str[1] := NewChar;
      if IsKatakana(Byte(NewChar)) then
      begin
       NewChar := Str[1];
       Exit;
      end;
      if not IsCharAlpha(NewChar) then
      begin
       Result := False;
       if ((EditMask[MaskOffset] = mMskAlphaNum) or
          (EditMask[MaskOffset] = mMskAlphaNumOpt)) and
          (IsCharAlphaNumeric(NewChar)) then
        Result := True;
      end
      else if mdUpperCase in Dir then
       Str := AnsiUpperCase(Str)
      else if mdLowerCase in Dir then
       Str := AnsiLowerCase(Str);
      NewChar := Str[1];
     end;
   end;
  end;
end;

function FindLiteralChar(const EditMask : string;
                         MaskOffset     : Integer; 
                         InChar         : Char): Integer;
var
 CType   : TMaskCharType;
 LitChar : Char;
begin
 Result := -1;
 while MaskOffset < Length(EditMask) do
 begin
  Inc(MaskOffset);
  CType := MaskGetCharType(EditMask, MaskOffset);
  if CType in [mcLiteral, mcIntlLiteral] then
  begin
   LitChar := EditMask[MaskOffset];
   if CType = mcIntlLiteral then
    LitChar := MaskIntlLiteralToChar(LitChar);
   if LitChar = InChar then
    Result := MaskOffset;
   Exit;
  end;
 end;
end;

function InputChar(const Value    : string; 
                   const EditMask : string; 
                   var NewChar    : Char;
                   Offset         : Integer): Boolean;
var
 MaskOffset : Integer;
 CType      : TMaskCharType;
 InChar     : Char;
begin
 Result := True;
 if EditMask <> '' then
 begin
  Result := False;
  MaskOffset := OffsetToMaskOffset(EditMask, Offset);
  if MaskOffset >= 0 then
  begin
   CType := MaskGetCharType(EditMask, MaskOffset);
   InChar := NewChar;
   Result := DoInputChar(NewChar, EditMask, NewChar, MaskOffset);
   if not Result and (CType in [mcMask, mcMaskOpt]) then
   begin
    MaskOffset := FindLiteralChar(EditMask, MaskOffset, InChar);
    if MaskOffset > 0 then
    begin
     MaskOffset := MaskOffsetToOffset(EditMask, MaskOffset);
     SetCursor(MaskOffset);
     Exit;
    end;
   end;
  end;
 end;
 if not Result then
  MessageBeep(0)
end;

end.
