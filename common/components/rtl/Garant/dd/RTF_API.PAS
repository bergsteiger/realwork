unit Rtf_api;

{ $Id: RTF_API.PAS,v 1.7 2013/04/11 16:46:26 lulin Exp $ }

// $Log: RTF_API.PAS,v $
// Revision 1.7  2013/04/11 16:46:26  lulin
// - отлаживаем под XE3.
//
// Revision 1.6  2007/08/14 19:31:52  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.5  2007/08/14 14:30:05  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.4  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.3  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

function InitRTF(var H: Pointer; aFileName: PAnsiChar): Boolean; export;
{ создает внутренний объект }

function DoneRTF(var H: Pointer): Boolean; export;
{ уничтожает внутренний объект }

function RTFStatus(H: Pointer): Integer; export;
{ Возвращает внутреннее состояние объекта }

function RTFObjID(H: Pointer): Byte; export;
{ Возвращает идентификатор текущего объекта }


function SetDocAttributes(H: Pointer; Coding: Integer; Language: Integer;
             Paper: Byte; { 0 - A4, 1 - A5, 2 - Letter, 3 - Legal, 4 - Executive}
             Before, After, Left, Right: Real; IndentMeasureUnit: Byte): Boolean; export;



function OpenFontTable(H: Pointer): Boolean; export;
{ переводит объект в состояние приема шрифтов}

function CloseFontTable(H: Pointer): Boolean; export;
{ закрывает состояние приема шрифтов. Повторный вызов OpenFontTable приведет
к ошибке }

function InsertFont(H: Pointer; FNumber: Integer;     {\fN}
    FFontName: PAnsiChar): Boolean; export;
{ Добавляет новый фонт с указанным номером. Если шрифт с таким номером
уже существует, выдается сообщение об ошибке }
function AddFont(H: Pointer; FNumber: Integer;     {\fN}
    FFamily: Byte; {\fnil\froman\fswiss\fmodern\fscript\fdecor\ftech\fbidi}
    FCharSet: Word;    {\fcharset}
    FPitch  : Byte;    {\fprq}
    FPanose : Longint; {\panose}
    FFontName: AnsiString;
    FAlternate: AnsiString;  {\falt}
    FFontType: Byte;{\ftnil\fttruetype}
    FCodePage: Integer {\cpg}): Integer;
{ Добавляет указанный шрифт во внутреннюю структуру и возвращает его номер,
  если он не был указан явным образом. В случае повторения номера шрифт
  не добавляется и выставляется состояние ошибки ecDuplicateID.
  Добавление шрифта возможно только в самом начале документа.
  После использования ссылки на таблицу (например, определение стиля или
  вывод текста), попытка добавления шрифта игнорируется. }

function CheckFont(H: Pointer; aFontName: PAnsiChar): Integer; export;
{ Проверяет наличие указанного шрифта в таблице. Возвращает либо его номер,
  либо -1 }

function OpenColorTable(H: Pointer): Boolean; export;
{ Открывает таблицу цветов для приема цветов }

function CloseColorTable(H: Pointer): Boolean; export;
{Закрывает таблицу шрифтов}
function AddColor(H: Pointer; Color: Longint; var No: Byte): Boolean; export;
{Добавляет цвет, заданный комбинацией красный-зеленый-синий в таблицу цветов  }
function AddRGBColor(H: Pointer; Red, Green, Blue: Byte; var No: Byte): Boolean; export;
{Добавляет цвет, заданный красной, зеленой и синей составляющими в таблицу цветов}

function OpenStyleTable(H: Pointer): Boolean; export;
{ Открывает таблицу стилей }
function CloseStyleTable(H: Pointer): Boolean; export;
{ Закрывает таблицу стилей }
function AddParagraphStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             Align: Byte; First, Before, After, Left, Right: Real; IndentMeasureUnit: Byte;
             InterLine: Real; ILMeasureUnit: Byte;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean; export;
{ Добавляет новый стиль параграфа в таблицу стилей.
    StyleNo: Byte;      номер добавляемого стиля
    StyleName: AnsiString;  имя добавляемого стиля
    Align: Byte;        выравнивание (0 - влево, 1 - вправо, 2 - по центру, 3 - по ширине)
    First,              отступ первой строки (отрицательное значение - выступ)
    Before,             интервал до абзаца
    After,              интервал после абзаца
    Left,               отступ слева
    Right: Real;        отступ справа
    IndentMeasureUnit: Byte; единица измерения для интервалов и отступов(0- дюймы, 1 - сантиметры)
    InterLine: Real;    расстояние между строками
    ILMeasureUnit: Byte; единица измерения для межстрочного интервала (0 - строки, 1- дюймы, 2 - сантиметры)
    FontNo: Byte;       номер шрифта абзаца
    FontSize: Byte;     высота шрифта в пунктах
    Bold,               полужирное начертание
    Italic,             курсивное начертание
    Underline: Boolean; подчеркивание
    ForegroundColor,    номер цвета символов в таблице цветов
    BackgroundColor: Byte; номер цвета фона в таблице цветов
    CharPosition: Byte  позиция символов (0 - обычная, 1 -верхний индекс, 2 - нижний}

function AddCharacterStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean; export;
{ Добавляет новый стиль символов в таблицу стилей.
    StyleNo: Byte;      номер добавляемого стиля
    StyleName: AnsiString;  имя добавляемого стиля
    FontNo: Byte;       номер шрифта абзаца
    FontSize: Byte;     высота шрифта в пунктах
    Bold,               полужирное начертание
    Italic,             курсивное начертание
    Underline: Boolean; подчеркивание
    ForegroundColor,    номер цвета символов в таблице цветов
    BackgroundColor: Byte; номер цвета фона в таблице цветов
    CharPosition: Byte  позиция символов (0 - обычная, 1 -верхний индекс, 2 - нижний }

function WriteParagraph(H: Pointer; ParaStyle: Byte;
                        Buffer: Pointer; BufferLen: Word): Boolean; export;
{ Записывает текстовый блок как единый параграф, присваивая ему указанный стиль }
function OpenParagraph(H: Pointer; ParaStyle: Byte): Boolean; export;
{ Открывает параграф с указанным стилем }
function OpenParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean; export;
{ Открывает параграф с непосредственной задачей его атрибутов }
function CloseParagraph(H: Pointer): Boolean; export;
{ Закрывает параграф }
function SetParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean; export;
{ Устанавливает атрибуты параграфа }
function AddTab(H: Pointer; Size: Real; MeasureUnit: Byte;
                TabKind: Byte; TabLead: Byte): Boolean; export;
{ Добавляет к текущему открытому параграфу очередную табуляцию
  Size    - позиция в дюймах или сантиметрах
  TabKind - выравнивание текста относительно позиции табуляции
            (0-влево, 1-вправо, 2-по центру, 3-по десятичной точке)
  TabLead - заполнитель табуляции
            (0-нет, 1-точки, 2-перенос, 3-подчеркивание, 4-тонкие линии, 5-знак равно)
   }


function SetCharacterAttr(H: Pointer;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean; export;
{ Устанавливает атрибуты символу }


procedure WriteText(H: Pointer; aText: PAnsiChar); export;
{ выводит указанный текст в файл. Оформление не затрагивается }

procedure WriteTextAttr(H: Pointer; aText: PAnsiChar; FontNumber: Integer;
                         FontSize: Integer;
                         ColorF: Integer;
                         ColorB: Integer;
                         Bold: Boolean;
                         Italic: Boolean;
                         Underline: Boolean;
                         Striked: Byte;
                         CharPos: Byte;
                         Scale: Integer;
                         Expan: Integer;
                         KerningSize: Integer); export;
{ Выводит указнный текст вместе с указанным оформлением. Оформление относится
  только к данному текстовому фрагменту }

function OpenTable(H: Pointer): Boolean; export;
{ Устанавливает состояние таблицы. После этого возможен вызов либо
  CloseTable, либо OpenRow }

function CloseTable(H: Pointer): Boolean; export;
{ Закывает текущую таблицу }
function SetTableAttr(H: Pointer; BorderUp, BorderLeft, BorderBottom, BorderRight: Boolean;
                      BorderWidth: Real): Boolean;
{Устанавливает атрибуты всей таблицы - наличие внешних рамок и их толщину}
function OpenRow(H: Pointer): Boolean; export;
{Открывает строку таблицы}
function CloseRow(H: Pointer): Boolean; export;
{Закрывает строку таблицы }
function SetRowAttr(H: Pointer): Boolean;
{Устанавливает атрибуты строки таблицы ???}
function AddCell(H: Pointer; aWidth: Real; MeasureUnit: Byte): Boolean; export;
{Добавляет описание ячейки строки - ее ширину и наличие рамок}
function OpenCell(H: Pointer): Boolean; export;
{открывает ячейку для вывода в нее текста}
function CloseCell(H: Pointer): Boolean; export;
{Закрывает ячейку }

function StartNumbering(H: Pointer; Style: Byte; StartNo: Byte; Text: PAnsiChar): Boolean; export;
{ Начинает вывод нумерованных абзацев. Style - 0 буллет, 1  }

function ContinueNumbering(H: Pointer; Text: PAnsiChar): Boolean; export;
{ Продолжает список, начатый вызовом StartNumbering }


{ процедуры и функцции для внутреннего использования }
procedure StartObject(H: Pointer; objID: Integer; Default: Boolean);
{ Начинает новый объект. По умолчанию текущим объектом считается абзац.
  Другими словами, если не начинался иной объект можно не вызывать
  StartObject(H, objPara) }

procedure FinishObject(H: Pointer; objID: Integer);
{ Заканчивает текущий объект. Если текущим объектом являлся абзац,
  то автоматически начинается новый абзац. }

procedure SetProperty(H: Pointer; objID: Integer; propID: Integer; propValue: Longint);
{Устанавливает указанному обекту указнное свойство в указанное значение.
 Если это возможно, оформление вываливается в файл, иначе накапливается
 во внутренних структурах }

procedure ClearProperties(H: Pointer; objID: Integer);
{ Сбрасывает все оформление указанного объекта в значения по умолчанию }



implementation

Uses RTF_w, RTFTypes, SysUtils;

function InitRTF(var H: Pointer; aFileName: PAnsiChar): Boolean;
{ создает внутренний объект }
begin
  try
    H:= TRTFWriter.Create;
    TRTFWriter(H).FileName:= StrPas(aFileName);

    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function DoneRTF(var H: Pointer): Boolean;
{ уничтожает внутренний объект }
begin
  try
    TRTFWriter(H).Destroy;
    Result:= True;
  except
    Result:= False;
  end;
end;

function RTFStatus(H: Pointer): Integer;
{ Возвращает внутреннее состояние объекта }
begin
  try
    Result:= Ord(TRTFWriter(H).Status)
  except
    Result:= -1;
  end;
end;

function RTFObjID(H: Pointer): Byte;
begin
  try
    Result:= TRTFWriter(H).ObjID;
  except
    Result:= 255;
  end;
end;

function OpenFontTable(H: Pointer): Boolean;
{ переводит объект в состояние приема шрифтов}
begin
  try
    TRTFWriter(H).OpenFontTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function CloseFontTable(H: Pointer): Boolean;
{ закрывает состояние приема шрифтов. Повторный вызов OpenFontTable приведет
к ошибке }
begin
  try
    TRTFWriter(H).CloseFontTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function InsertFont(H: Pointer; FNumber: Integer;     {\fN}
    FFontName: PAnsiChar): Boolean;
begin
  Result:= TRTFWriter(H).InsertFont(FNumber, StrPas(FFontName)) <> -1;
end;

function AddFont(H: Pointer; FNumber: Integer;     {\fN}
    FFamily: Byte; {\fnil\froman\fswiss\fmodern\fscript\fdecor\ftech\fbidi}
    FCharSet: Word;    {\fcharset}
    FPitch  : Byte;    {\fprq}
    FPanose : Longint; {\panose}
    FFontName: AnsiString;
    FAlternate: AnsiString;  {\falt}
    FFontType: Byte;{\ftnil\fttruetype}
    FCodePage: Integer {\cpg}): Integer;
{ Добавляет указанный шрифт во внутреннюю структуру и возвращает его номер,
  если он не был указан явным образом. В случае повторения номера шрифт
  не добавляется и выставляется состояние ошибки ecDuplicateID.
  Добавление шрифта возможно только в самом начале документа.
  После использования ссылки на таблицу (например, определение стиля или
  вывод текста), попытка добавления шрифта игнорируется. }
begin
end;

function CheckFont(H: Pointer; aFontName: PAnsiChar): Integer;
{ Проверяет наличие указанного шрифта в таблице. Возвращает либо его номер,
  либо -1 }
begin
  try
    Result:= TRTFWriter(H).CheckFont(StrPas(aFontname));
  except
    Result:= -1;
  end;
end;

procedure SetDocProperty(H: Pointer; propID: Integer; propValue: Longint);
begin
  case propID of
    ipropName: TRTFWriter(H).FileName:= String(Pointer(propValue)^);
  end;
end;

procedure SetParaProperty(H: Pointer; propID: Integer; propValue: Longint);
begin
end;

procedure SetCharProperty(H: Pointer; propID: Integer; propValue: Longint);
begin
  TRTFWriter(H).SetCharProperty(propID, propValue, True);
end;

procedure SetProperty(H: Pointer; objID: Integer; propID: Integer; propValue: Longint);
{Устанавливает указанному обекту указнное свойство в указанное значение.
 Если это возможно, оформление вываливается в файл, иначе накапливается
 во внутренних структурах }
begin
  begin
    case objID of
      rsDocument : SetDocProperty(H, propID, propValue);
      rsParagraph: SetParaProperty(H, propID, propValue);
      rsChar: SetCharProperty(H, propID, propValue);
    end;
  end;
end;

procedure ClearProperties(H: Pointer; objID: Integer);
{ Сбрасывает все оформление указанного объекта в значения по умолчанию }
begin
end;


procedure WriteText(H: Pointer; aText: PAnsiChar);
{ выводит указанный текст в файл. Оформление не затрагивается }
begin
  TRTFWriter(H).WriteBlock(aText);
end;

procedure WriteTextAttr(H: Pointer; aText: PAnsiChar; FontNumber: Integer;
                         FontSize: Integer;
                         ColorF: Integer;
                         ColorB: Integer;
                         Bold: Boolean;
                         Italic: Boolean;
                         Underline: Boolean;
                         Striked: Byte;
                         CharPos: Byte;
                         Scale: Integer;
                         Expan: Integer;
                         KerningSize: Integer);
{ Выводит указнный текст вместе с указанным оформлением. Оформление относится
  только к данному текстовому фрагменту }
begin
  TRTFWriter(H).WriteToFile(aText, FontNumber, FontSize, ColorF, ColorB,
                         Bold, Italic, Underline, TStrikeType(Striked),
                         TCharPosition(CharPos), Scale, Expan,
                         KerningSize);
end;

procedure StartObject(H: Pointer; objID: Integer; Default: Boolean);
{ Начинает новый объект. По умолчанию текущим объектом считается абзац.
  Другими словами, если не начинался иной объект можно не вызывать
  StartObject(H, objPara) }
begin
  TRTFWriter(H).StartObject(objID);
  if Default then
    TRTFWriter(H).ClearProperties(objID);
end;


procedure FinishObject(H: Pointer; objID: Integer);
{ Заканчивает текущий объект. Если текущим объектом являлся абзац,
  то автоматически начинается новый абзац. }
begin
  TRTFWriter(H).EndObject(objID);
end;


function OpenColorTable(H: Pointer): Boolean;
begin
  TRTFWriter(H).OpenColorTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;

function CloseColorTable(H: Pointer): Boolean;
begin
  TRTFWriter(H).CloseColorTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;


function AddColor(H: Pointer; Color: Longint; var No: Byte): Boolean;
begin
  TRTFWriter(H).InsertColor(Color, No);
  Result:= TRTFWriter(H).Status = ecOk;
end;


function AddRGBColor(H: Pointer; Red, Green, Blue: Byte; var No: Byte): Boolean;
begin
  TRTFWriter(H).InsertRGBColor(Red, Green, Blue, No);
  Result:= TRTFWriter(H).Status = ecOk;
end;

function OpenStyleTable(H: Pointer): Boolean;
begin
  TRTFWriter(H).OpenStyleTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;

function CloseStyleTable(H: Pointer): Boolean;
begin
  tRTFWriter(H).CloseStyleTable;
  Result:= TRTFWriter(H).Status = ecOk;
end;

function AddParagraphStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             Align: Byte; First, Before, After, Left, Right: Real; IndentMeasureUnit: Byte;
             InterLine: Real; ILMeasureUnit: Byte;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean;
begin
  tRTFWriter(H).AddParagraphStyle(StyleNo, StrPas(StyleName),
             Align, First, Before, After, Left, Right, IndentMeasureUnit,
             InterLine, ILMeasureUnit, FontNo, FontSize, Bold, Italic, Underline,
             ForegroundColor, BackgroundColor, CharPosition);
  Result:= TRTFWriter(H).Status = ecOk;
end;

function AddCharacterStyle(H: Pointer; StyleNo: Byte; StyleName: PAnsiChar;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean;
begin
  tRTFWriter(H).AddCharacterStyle(StyleNo, StrPas(StyleName),
             FontNo, FontSize, Bold, Italic, Underline,
             ForegroundColor, BackgroundColor, CharPosition);
  Result:= TRTFWriter(H).Status = ecOk;
end;


function WriteParagraph(H: Pointer; ParaStyle: Byte;
                        Buffer: Pointer; BufferLen: Word): Boolean;
var
  C: PAnsiChar;
begin
  try
    if OpenParagraph(H, ParaStyle) then
    begin
      GetMem(C, BufferLen+1);
      l3FillChar(C[0], BufferLen+1, 0);
      l3Move(Buffer^, C[0], BufferLen);
      WriteText(H, C);
      FreeMem(C, BufferLen+1);
      CloseParagraph(H);
      Result:= True;
    end
    else
      Result:= False;
   except
     Result:= False;
   end;
end;

function OpenParagraph(H: Pointer; ParaStyle: Byte): Boolean;
begin
  try
    TRTFWriter(H).OpenParagraph(ParaStyle);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function OpenParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).OpenParagraphAttr(Align, First, Before, After,
                           Left, Right, IndentMeasureUnit,
                           InterLine, ILMeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function CloseParagraph(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseParagraph;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function SetParagraphAttr(H: Pointer; Align: Byte; First, Before, After,
                           Left, Right: Real; IndentMeasureUnit: Byte;
                           InterLine: Real; ILMeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).SetParagraphAttr(Align, First, Before, After,
                           Left, Right, IndentMeasureUnit,
                           InterLine, ILMeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function SetCharacterAttr(H: Pointer;
             FontNo: Byte; FontSize: Byte; Bold, Italic, Underline: Boolean;
             ForegroundColor, BackgroundColor: Byte; CharPosition: Byte): Boolean;
begin
  try
    TRTFWriter(H).SetCharacterAttr(FontNo, FontSize, Bold, Italic, Underline,
             ForegroundColor, BackgroundColor, CharPosition);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function SetDocAttributes(H: Pointer; Coding: Integer; Language: Integer;
             Paper: Byte; { 0 - A4, 1 - A5, 2 - Letter, 3 - Legal, 4 - Executive}
             Before, After, Left, Right: Real; IndentMeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).SetDocAttributes(Coding, Language, Paper,
                  Before, After, Left, Right, IndentMeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function OpenTable(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).OpenTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function CloseTable(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseTable;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function SetTableAttr(H: Pointer; BorderUp, BorderLeft, BorderBottom, BorderRight: Boolean;
                      BorderWidth: Real): Boolean;
begin
  try
    TRTFWriter(H).SetTableAttr(BorderUp, BorderLeft, BorderBottom, BorderRight,
                      BorderWidth);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function OpenRow(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).OpenRow;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function CloseRow(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseRow;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function SetRowAttr(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).SetRowAttr;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function AddCell(H: Pointer; aWidth: Real; MeasureUnit: Byte): Boolean;
begin
  try
    TRTFWriter(H).AddCell(aWidth, MeasureUnit);
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function OpenCell(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).OpenCell;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function CloseCell(H: Pointer): Boolean;
begin
  try
    TRTFWriter(H).CloseCell;
    Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False
  end;
end;

function AddTab(H: Pointer; Size: Real; MeasureUnit: Byte;
                TabKind: Byte; TabLead: Byte): Boolean; 
{ Добавляет к текущему открытому параграфу очередную табуляцию
  Size    - позиция в дюймах или сантиметрах
  TabKind - выравнивание текста относительно позиции табуляции
            (0-влево, 1-вправо, 2-по центру, 3-по десятичной точке)
  TabLead - заполнитель табуляции
            (0-нет, 1-точки, 2-перенос, 3-подчеркивание, 4-тонкие линии, 5-знак равно)
   }
begin
  try
   TRTFWriter(H).AddTab(Size, MeasureUnit, TabKind, TabLead);
   Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function StartNumbering(H: Pointer; Style: Byte; StartNo: Byte; Text: PAnsiChar): Boolean;
{ Начинает вывод нумерованных абзацев. Style - 0 буллет, 1  }
begin
  try
   TRTFWriter(H).StartNumbering(Style, StartNo, Text);
   Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;

function ContinueNumbering(H: Pointer; Text: PAnsiChar): Boolean;
{ Продолжает список, начатый вызовом StartNumbering }
begin
  try
   TRTFWriter(H).ContinueNumbering(Text);
   Result:= TRTFWriter(H).Status = ecOk;
  except
    Result:= False;
  end;
end;


end.
