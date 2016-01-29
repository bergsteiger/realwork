unit evdNativeUnpackedWriter;
{* Писатель тегов в формате evd. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evEvdWrt - генератор текстов в формате evd }
{ Начат: 05.10.1999 13:00 }
{ $Id: evdNativeUnpackedWriter.pas,v 1.15 2014/09/01 09:42:07 lulin Exp $ }

// $Log: evdNativeUnpackedWriter.pas,v $
// Revision 1.15  2014/09/01 09:42:07  lulin
// - начинаем делать возможность задавать тегам артибуты типа "множество".
//
// Revision 1.14  2014/04/22 14:20:16  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.13  2014/04/09 16:03:02  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.12  2014/04/09 15:45:01  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/03/27 14:20:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/03/25 16:23:45  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/03/06 17:23:24  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.8  2013/10/23 16:04:43  lulin
// - правильнее определяем "автоматические" типы.
//
// Revision 1.7  2013/10/22 16:45:05  lulin
// - реорганизуем таблицу тегов, чтобы избавится от "шаманства" и идентификаторами.
//
// Revision 1.6  2013/10/21 15:43:12  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:31:00  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2013/10/18 14:11:31  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2013/04/04 11:21:18  lulin
// - портируем.
//
// Revision 1.2  2012/07/12 18:33:16  lulin
// {RequestLink:237994598}
//
// Revision 1.1  2011/12/19 17:36:03  lulin
// {RequestLink:282693895}
// - делаем тест.
//
// Revision 1.55  2011/07/07 19:53:56  lulin
// {RequestLink:228688745}.
//
// Revision 1.54  2010/06/22 12:50:12  lulin
// {RequestLink:219122682}.
// - bug fix: были проблемы с новыми пакованными комментариями.
//
// Revision 1.53  2010/06/18 14:14:48  lulin
// {RequestLink:182452717}.
// - меняем способ нумерования версий. Теперь версии нумеруем с шагом 20. 0-е - это Архивариус, 1-е - это F1.
//
// Revision 1.52  2010/06/15 12:46:37  lulin
// {RequestLink:159355611}.
// - правильнее инициализируем признак записи бинарности файла.
//
// Revision 1.50  2010/06/10 11:35:31  lulin
// {RequestLink:159355611}.
//
// Revision 1.49  2009/07/06 16:38:17  lulin
// - вычищаем ненужное.
//
// Revision 1.48  2009/07/03 16:24:09  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.47  2009/03/18 14:59:52  lulin
// - делаем возможность отката, если во время записи произошло исключение.
//
// Revision 1.46  2009/03/04 13:33:09  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.45  2009/02/27 07:14:56  lulin
// - <K>: 137465982. №26.
//
// Revision 1.44  2009/01/16 12:12:50  lulin
// - bug fix: не падаем при записи невалидных текстовых EVD.
//
// Revision 1.43  2008/06/19 12:55:26  lulin
// - переименованы константы.
//
// Revision 1.42  2008/02/20 17:23:05  lulin
// - упрощаем строки.
//
// Revision 1.41  2008/02/19 18:48:17  lulin
// - удалены ненужные классы.
//
// Revision 1.40  2008/02/19 11:05:55  lulin
// - восстановил всякие экзотические поиски в списках объектов.
//
// Revision 1.39  2008/02/13 16:03:10  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.38  2008/02/07 19:13:13  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.37  2008/02/06 11:44:39  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.36  2008/02/05 18:20:38  lulin
// - удалено ненужное свойство строк.
//
// Revision 1.35  2008/02/05 17:39:35  lulin
// - избавляемся от ненужного именованного объекта.
//
// Revision 1.34  2008/02/05 16:13:12  lulin
// - избавляем базовый объект от лишнего свойства.
//
// Revision 1.33  2008/02/05 12:49:20  lulin
// - упрощаем базовые объекты.
//
// Revision 1.32  2008/02/01 15:14:50  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.31  2007/09/25 13:55:42  lulin
// - bug fix: не собиралось для Эверест (Lite).
//
// Revision 1.30  2007/08/29 17:05:04  lulin
// - записываем короткую кодировку, если это возможно.
//
// Revision 1.29  2007/08/29 15:04:50  lulin
// - страхуемся от попытки чтнения неверного формата.
//
// Revision 1.28  2007/08/29 14:52:33  lulin
// - не пишем информацию о текстовых скобках.
//
// Revision 1.27  2007/08/29 14:27:02  lulin
// - пакуем EVD-теги - вместо слова, пишем байт.
//
// Revision 1.26  2007/08/29 12:54:46  lulin
// - cleanup.
//
// Revision 1.25  2007/08/29 12:46:19  lulin
// - cleanup.
//
// Revision 1.24  2007/08/29 12:37:08  lulin
// - файл версий переехал в правильную папку.
//
// Revision 1.23  2007/08/29 12:00:33  lulin
// - константы распилены на два файла.
//
// Revision 1.22  2007/08/10 19:17:24  lulin
// - cleanup.
//
// Revision 1.21  2007/08/09 18:05:28  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.20  2007/08/09 16:14:25  lulin
// - обходимся без приведения типов.
//
// Revision 1.19  2007/08/09 16:12:06  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.18  2007/08/09 14:55:25  lulin
// - избавляемся от излишнего использования интерфейсов.
//
// Revision 1.17  2007/08/09 13:01:44  lulin
// - изолируем потомков от излишних знаний о внутренностях базового генератора.
//
// Revision 1.16  2007/08/09 11:19:25  lulin
// - cleanup.
//
// Revision 1.15  2007/08/09 09:17:53  lulin
// - cleanup.
//
// Revision 1.14  2006/12/01 17:08:06  lulin
// - обращаемся к символам строки напрямую.
//
// Revision 1.13  2006/12/01 17:00:52  lulin
// - bug fix: корректно записываем Unicode-строки.
//
// Revision 1.12  2006/12/01 16:45:17  lulin
// - cleanup.
//
// Revision 1.11  2006/12/01 16:37:38  lulin
// - cleanup.
//
// Revision 1.10  2006/11/25 16:50:30  lulin
// - удалена запись,чтение маски заполненных тегов.
//
// Revision 1.9  2006/11/24 19:21:17  lulin
// - корректно используем Unicode строки.
//
// Revision 1.8  2006/02/07 15:16:31  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.7  2005/11/08 14:11:28  lulin
// - new behavior: для атомарных атрибутов пытаемся преобразовывать строки в числа.
//
// Revision 1.6  2005/11/08 13:51:15  lulin
// - cleanup.
//
// Revision 1.5  2005/11/08 13:46:55  lulin
// - cleanup.
//
// Revision 1.3  2005/11/08 13:39:09  lulin
// - bug fix: падало при попытке записать несуществующий атрибут.
//
// Revision 1.2  2005/10/28 12:48:17  lulin
// - bug fix: не всегда записывались картинки в EVD.
//
// Revision 1.1  2005/07/21 13:00:42  lulin
// - писатель формата EVD переехал в папку EVD.
//
// Revision 1.65.4.4  2005/07/21 10:20:04  lulin
// - теперь TextSource не знает как создавать Reader'ы, а про это знает контейнер документа.
//
// Revision 1.65.4.3  2005/06/23 13:08:24  lulin
// - файл с ключевыми словами переехал в папку EVD.
//
// Revision 1.65.4.2  2005/06/23 12:55:33  lulin
// - файл с константами переехал в папку EVD.
//
// Revision 1.65.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.64.2.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.64.2.1  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.64.4.1  2005/04/22 10:40:27  lulin
// - cleanup: убраны ненужные параметры.
//
// Revision 1.65  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.64.4.1  2005/04/22 10:40:27  lulin
// - cleanup: убраны ненужные параметры.
//
// Revision 1.64  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.63  2005/03/25 12:12:14  lulin
// - используем _Ik2Type вместо Tk2Type.
//
// Revision 1.62  2005/03/22 17:03:04  lulin
// - спрятаны ненужные методы. Чуть подоптимизирована загрузка - ГК в Эвересте на 1 сек меньше.
//
// Revision 1.61  2005/03/22 10:38:01  lulin
// - cleanup.
//
// Revision 1.60  2005/03/22 09:05:56  narry
// - bug fix: AV
//
// Revision 1.59  2005/03/21 13:42:58  lulin
// - убраны ненужные методы.
//
// Revision 1.58  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.57  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.56  2004/06/10 09:32:09  law
// - bug fix: неправильно записывались документы в бинарном виде в структурированное хранилище.
//
// Revision 1.55  2004/06/02 15:12:07  law
// - конструкторы Make перенесены с _Tl3PVList на _Tl3PtrRecList.
//
// Revision 1.54  2004/05/14 18:06:41  law
// - change:  методы, связанные с генерацией evd перенесены с TevCustomFileGenerator на TevCustomEvdWriter.
//
// Revision 1.53  2004/05/14 16:22:57  law
// - remove class: TevTextObjectGenerator.
// - remove class: TevTextObjectParser.
//
// Revision 1.52  2004/05/14 16:07:56  law
// - new units: evFileGenerator, evPlainTextGenerator.
//
// Revision 1.51  2004/05/14 15:16:52  law
// - remove unit: evTypesE.
//
// Revision 1.50  2004/05/14 14:48:47  law
// - исправлены префиксы у констант.
//
// Revision 1.49  2004/05/14 14:08:49  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.48  2003/10/21 16:57:23  law
// - new behavior: TevCustomEVDWriter - не вызываем _Flush при Undo (может это спорно может надо откатывать накопленные теги).
//
// Revision 1.47  2003/10/20 11:07:43  law
// - bug fix: при формировании EVD-текст (для одного параграфа) оформление для всех парагграфов накапливалось в буфере.
//
// Revision 1.46  2003/10/20 09:43:07  law
// - bug fix: при параллельном залитии справки и текста не ставилась директива %binary.
//
// Revision 1.45  2003/10/15 13:11:13  law
// - bug fix: оформление параграфов накапливалось в один буфер.
//
// Revision 1.44  2003/10/15 08:29:20  law
// - bug fix: оформление параграфов накапливалось в один буфер.
//
// Revision 1.43  2003/10/14 13:11:53  law
// - new method: IeeGenerator._AddRawData.
//
// Revision 1.42  2003/10/14 12:48:30  law
// - new prop: TevCustomEvdWriter.SkipTopBrackets.
//
// Revision 1.41  2003/10/14 12:15:59  law
// - new prop: TevCustomEvdWriter.NeedOutHeader.
//
// Revision 1.40  2003/10/14 12:02:08  law
// - bug fix: при записи в evd два раза писали директиву %binary.
//
// Revision 1.39  2003/06/23 11:09:44  law
// - bug fix: не записывался текст в формате EVD-Binary.
//
// Revision 1.38  2003/04/25 10:46:23  law
// - bug fix: нельзя было по-простому добавить ссылку.
//
// Revision 1.37  2002/09/23 12:18:19  law
// - new prop: Tk2ChildrenProperty._DefaultChildType.
//
// Revision 1.36  2002/09/18 09:33:26  law
// - new behavior: при записи в evd-binary опускаем тип дочернего тега по умолчанию.
//
// Revision 1.35  2002/09/18 09:02:46  law
// - new behavior: при записи в evd-текст опускаем имя типа дочернего тега по умолчанию.
//
// Revision 1.34  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, k2Ver.
// - new behavior: Tk2CustomReader теперь наследуется от Tk2CustomStackGenerator и соответственно наследует его поведение.
//
// Revision 1.33  2002/09/18 06:03:32  law
// - cleanup: удален параметр IsDefault.
//
// Revision 1.32  2002/01/29 16:18:49  law
// - bug fix: Range Check Error при записывании размера маски.
//
// Revision 1.31  2002/01/05 11:00:43  law
// - some cosmetics.
//
// Revision 1.30  2001/10/23 15:21:31  law
// - new proc: TevCustomEvdWriter._OutBinary.
//
// Revision 1.29  2001/10/19 16:20:22  law
// - new unit: evEvdWriter.
//
// Revision 1.28  2001/09/11 10:11:08  law
// - change method: добавлен параметр по умолчанию.
//
// Revision 1.27  2001/08/31 08:50:07  law
// - cleanup: первые шаги к кроссплатформенности.
//
// Revision 1.26  2001/05/31 09:23:40  law
// - cleanup: убрана работа со старой логикой масок тегов.
//
// Revision 1.25  2001/05/31 08:30:33  law
// - cleanup: убрана запись компонент.
// - comments: добавлены комментарии для xHelpGen.
//
// Revision 1.24  2001/04/18 13:56:35  law
// - bug fix: AV при поиска TevTextObjectParser.
//
// Revision 1.23  2001/04/18 13:25:23  law
// - comments: добавлены комментарии для xHelpGen.
//
// Revision 1.22  2001/03/27 13:59:43  law
// - bug fix: неправильно выливалась таблица шрифтов.
//
// Revision 1.21  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.20  2001/03/13 13:20:39  law
// - some tuning & comments.
//
// Revision 1.19  2001/01/24 14:53:43  law
// - сделано более компактное сохранение имен шрифто
//
// Revision 1.18  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.17  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$Include evdDefine.inc }

interface

uses
  Classes,
  
  l3Types,
  l3Base,
  l3StringList,
  l3Variant,
  l3Interfaces,

  k2Interfaces,
  k2Types,
  k2Base,
  k2TagGen,
  k2FileGenerator,

  evdConst
  ;

type
  TevdNativeUnpackedWriter = class(Tk2CustomFileGenerator)
   {* Писатель тегов в формате evd. }
    private
    {property fields}
      f_OutEndComment : Bool;
      f_FontNames     : Tl3StringList;
      f_WasBinary     : Boolean;
      f_NeedOutHeader : Boolean;
      f_SkipTopBrackets : Boolean;
      f_SmallHeader     : Boolean;
    protected
    // property methods
      function  pm_GetIndent: Long;
        virtual;
        {-}
    protected
    // internal methods
      procedure OutObject(AtomIndex: Long; O: Tl3Variant);
        {-}
      procedure WriteStream(aStream: TStream);
        {-}
{      procedure OutPropPath(PI: PPropInfo);
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-вызывается один раз в конце генерации}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
      function  GetKeyWord(anID: Long): string;
        {-}
      procedure OutKeyWord(anID: Long);
        {-}
      procedure Cleanup;
        override;
        {-}  
      procedure DoStartChild(TypeID: Tk2Type);
        //virtual;
        {-}
      procedure DoCloseStructure(NeedUndo: Bool);
        virtual;
        {-}
      procedure WriteStartChild(TypeID: Tk2Type);
        {-}
      procedure WriteAtom(AtomIndex: Long; const Value: Tk2Variant);
        {-}
      procedure OutBinary(WithPrefix: Bool = true);
        {-}
      procedure OutEndBinary;
        {-}  
      function  WriteTypeID(ID: TevTypeID): Long;
        {-}
      function  WriteOrd(V: sInt32): Long;
        {-}
      function  WriteTransparent: Long;
        {-}
      function  WriteString(S : Tl3WString): Long;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {- P - адрес указателя куда будет положен Self}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure AfterStreamOpened;
        override;
        {-}
      procedure OutHeader;
        virtual;
        {-}  
    public
    // public properties
      property WasBinary: Boolean
        read f_WasBinary
        write f_WasBinary;
        {-}
      property Indent: Long
        read pm_GetIndent;
        {* - текущий уровень вложенности. }
      property OutEndComment : Bool
        read f_OutEndComment
        write f_OutEndComment
        default false;
        {-}
      property NeedOutHeader: Boolean
        read f_NeedOutHeader
        write f_NeedOutHeader;
        {-}
      property SkipTopBrackets: Boolean
        read f_SkipTopBrackets
        write f_SkipTopBrackets;
        {-}
      property SmallHeader: Boolean
        read f_SmallHeader
        write f_SmallHeader;
        {-}  
  end;{TevdNativeUnpackedWriter}

implementation

uses
  SysUtils,
  TypInfo,

  l3Chars,
  l3String,

  k2Tags,
  k2Const,
  k2Except,

  evdVer,
  evdKW,
  evdTxtConst,

  Document_Const,
  k2FontName_Const
  ;

// start class TevdNativeUnpackedWriter 

constructor TevdNativeUnpackedWriter.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
begin
 inherited;
 f_OutEndComment := false;
 KeyWords := EvdKeyWords;
 NeedOutHeader := true;
end;

procedure TevdNativeUnpackedWriter.Cleanup;
  //override;
  {-}
begin
 l3Free(f_FontNames);
 inherited;
end;

function TevdNativeUnpackedWriter.pm_GetIndent: Long;
  {-}
begin
 Result := Types.Hi;
end;

procedure TevdNativeUnpackedWriter.OutBinary(WithPrefix: Bool = true);
  {-}
begin{OutBinary}
 if not f_WasBinary then
 begin
  f_WasBinary := true;
  Exit;
  if WithPrefix then
   OutString(evDirectivePrefix);
  OutKeyWord(evd_kwBinary);
  OutEOL;
 end;//not f_WasBinary
end;{OutBinary}

procedure TevdNativeUnpackedWriter.OutEndBinary;
  {-}
begin
 if NeedOutHeader AND not SmallHeader then
 begin
  f_WasBinary := false;
  OutString(evDirectivePrefix + GetKeyWord(evd_kwEndBinary));
 end;//NeedOutHeader
end;
  
function TevdNativeUnpackedWriter.WriteOrd(V: sInt32): Long;
  {-}
begin
 if (V >= 0) then begin
  if (V <= High(uInt8)) then begin
   Result := WriteTypeID(ev_idUInt8);
   Inc(Result, WriteBuf(@V, SizeOf(uInt8)));
  end else if (V <= High(uInt16)) then begin
   Result := WriteTypeID(ev_idUInt16);
   Inc(Result, WriteBuf(@V, SizeOf(uInt16)));
  end else begin
   Result := WriteTypeID(ev_idUInt32);
   Inc(Result, WriteBuf(@V, SizeOf(uInt32)));
  end;
 end else begin
  if (V >= Low(sInt8)) then begin
   Result := WriteTypeID(ev_idSInt8);
   Inc(Result, WriteBuf(@V, SizeOf(sInt8)));
  end else if (V >= High(sInt16)) then begin
   Result := WriteTypeID(ev_idSInt16);
   Inc(Result, WriteBuf(@V, SizeOf(sInt16)));
  end else begin
   Result := WriteTypeID(ev_idSInt32);
   Inc(Result, WriteBuf(@V, SizeOf(sInt32)));
  end;
 end;
end;

function TevdNativeUnpackedWriter.WriteTransparent: Long;
  {-}
begin
 Result := WriteTypeID(ev_idTransparent);
end;

function TevdNativeUnpackedWriter.WriteString(S : Tl3WString): Long;
  {-}
var
 l_S : Tl3WString;
 l_CharSize : Long;
begin
 l_S := S;
 if (l_S.SCodePage = CP_ANSI) OR (l_S.SCodePage = CP_RussianWin) then
  Result := 0
 else
 begin
  Result := WriteTypeID(ev_idCodePage);
  Inc(Result, WriteLong(l_S.SCodePage));
 end;{l_S.SCodePage <> CP_ANSI}
 if (l_S.SCodePage = CP_Unicode) then
  l_CharSize := SizeOf(WideChar)
 else
  l_CharSize := SizeOf(AnsiChar);
 if (l_S.SLen <= High(uInt8)) AND (l_CharSize = SizeOf(AnsiChar)) then
 begin
  Inc(Result, WriteTypeID(ev_idString8));
  Inc(Result, WriteByte(l_S.SLen));
  Inc(Result, WriteBuf(l_S.S, l_S.SLen));
 end//l_S.SLen <= High(uInt8)) AND (l_CharSize = SizeOf(AnsiChar)
 else
 begin
  if (l_S.SLen <= High(uInt16)) then
  begin
   Inc(Result, WriteTypeID(ev_idString16));
   Inc(Result, WriteWord(l_S.SLen));
  end//l_S.SLen <= High(uInt16)
  else
  begin
   Inc(Result, WriteTypeID(ev_idString32));
   Inc(Result, WriteLong(l_S.SLen));
  end;//l_S.SLen <= High(uInt16)
  Inc(Result, WriteBuf(l_S.S, l_S.SLen * l_CharSize));
 end;//SLen <= High(uInt8)
end;

function TevdNativeUnpackedWriter.WriteTypeID(ID: TevTypeID): Long;
  {-}
begin
 Result := WriteBuf(@ID, SizeOf(ID));
end;

procedure TevdNativeUnpackedWriter.OutHeader;
  {-}
var
 Title : String;
begin
 if NeedOutHeader then
 begin
  if (Filer.Pos = 0) then
  begin
   f_WasBinary := false;
   if not SmallHeader then
   begin
    Title := l3System.AppTitle;
    if not IsValidIdent(Title) then
     Title := cc_SingleQuote + Title + cc_SingleQuote;
    OutString(evDirectivePrefix);
    OutKeyWord(evd_kwProducer);
    OutString(cc_HardSpace + Title + cc_HardSpace);
    OutKeyWord(evd_kwDate);
    OutString(cc_HardSpace + cc_SingleQuote + DateToStr(Date) + cc_SingleQuote);
    OutEOL;
    Assert(evFormatCurVersionS <> '');
    OutString(evDirectivePrefix +
               GetKeyWord(evd_kwFormat)   + cc_HardSpace +
               GetKeyWord(evd_kwVersion)  + cc_HardSpace +
               evFormatCurVersionS        + cc_HardSpace);
    OutString(GetKeyWord(evd_kwRevision) + cc_HardSpace +
               GetKeyWord(evd_kwDate)     + cc_HardSpace +
               cc_SingleQuote + evEVDCurRevisionDate + cc_SingleQuote + cc_HardSpace);
   end;//not SmallHeader
   OutBinary(SmallHeader)
  end//Filer.Pos = 0
  else
   OutBinary;
 end;//NeedOutHeader
end;

procedure TevdNativeUnpackedWriter.AfterStreamOpened;
  {override;}
  {-}
begin
 if Filer.Opened then OutHeader;
end;

procedure TevdNativeUnpackedWriter.CloseStream(NeedUndo: Bool);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 if (f_FontNames <> nil) then f_FontNames.Clear;
  OutEndBinary;
 inherited;
end;

procedure TevdNativeUnpackedWriter.CloseStructure(NeedUndo: Bool);
  {override;}
  {-вызывается на закрывающуюся скобку}
begin
 DoCloseStructure(NeedUndo);
 inherited;
end;

procedure TevdNativeUnpackedWriter.DoCloseStructure(NeedUndo: Bool);
  //virtual;
  {-}
begin
  if (Indent <> 0) OR not SkipTopBrackets then
  begin
   if NeedUndo then
    WriteWord(unpack_idRollback)
   else
    WriteWord(unpack_idFinish);
  end;//Indent <> 0
  if (Indent = 0) OR CurrentType.IsKindOf(k2_typDocument) then
  begin
   if not NeedUndo then
    Filer.Flush
   else
    Filer.Rollback;
   if (f_FontNames <> nil) then
    f_FontNames.Clear;
    // - очищаем таблицу шрифтов в конце записи документа
  end;//Indent = 0..
end;

function TevdNativeUnpackedWriter.GetKeyWord(anID: Long): string;
  {-}
begin
 Result := KeyWords.DRByID[anID].AsString;
end;

procedure TevdNativeUnpackedWriter.OutKeyWord(anID: Long);
  {-}
begin
 OutString(GetKeyWord(anID));
end;

procedure TevdNativeUnpackedWriter.StartTag(TagID: Long);
  {override;}
  {-}
begin
 inherited;
 if (Indent = 0) AND SkipTopBrackets then
  Exit;
 if (Indent = 0) then OutHeader;
  WriteWord(TagID);
  WriteTypeID(ev_idAtom);
end;

procedure TevdNativeUnpackedWriter.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
begin
 inherited;
 DoStartChild(Tk2Type(TypeID));
end;

procedure TevdNativeUnpackedWriter.DoStartChild(TypeID: Tk2Type);
  //virtual;
  {-}
begin
 WriteStartChild(TypeID);
end;

procedure TevdNativeUnpackedWriter.WriteStartChild(TypeID: Tk2Type);
  {-}
var
 TT : Tk2TypePrim;
begin
 if (Indent = 0) AND SkipTopBrackets then
  Exit;
 if (Indent = 0) then OutHeader;
  TT := TopType[1];
  if (TT <> nil) then
  begin
   if (TT.DefaultChildTypeID = TypeID) then
   begin
    WriteWord(unpack_idDefaultChild);
    Exit;
   end;//l_Prop <> nil..
  end;//TT <> nil
  Assert(not TypeID.IsAuto);
  WriteWord(TypeID.ID);
  WriteTypeID(ev_idChild);
end;

procedure TevdNativeUnpackedWriter.OutObject(AtomIndex: Long; O: Tl3Variant);
  {-}
var
 l_Index    : Long;
 l_Prop     : Tk2CustomPropertyPrim;
 l_AT       : Tk2TypePrim;
 l_Tag      : Tl3Variant;
 l_S        : Tl3WString;
begin
  l_Prop := CurrentType.Prop[AtomIndex];
  if (l_Prop = nil) then
   l_AT := nil
  else
   l_AT := Tk2TypePrim(l_Prop.AtomType);
  if (l_AT <> nil) AND l_AT.IsKindOf(k2_typFontName) then
  begin
   if (f_FontNames <> nil) AND f_FontNames.FindData(O.AsWStr, l_Index) then
   begin
    WriteTypeID(ev_idFontID);
    WriteOrd(l_Index);
   end//f_FontNames <> nil
   else
   begin
    if (f_FontNames = nil) then
     f_FontNames := Tl3StringList.Make;
    f_FontNames.Add(O.AsWStr);
    WriteTypeID(ev_idFontName);
    WriteString(O.AsWStr)
   end;//f_FontNames <> nil..
  end//..k2_idFontName..
  else
  begin
   if (l_AT <> nil) then
   begin
    Case Tk2Type(l_AT).AtomType^.Kind of
     tkInteger,
     tkEnumeration,
     tkSet:
     begin
      try
       l_Tag := O;
       //l_Tag := Tk2Type(l_AT)._StrToTag(l3PCharLen2String(O.AsWStr)).AsObject;
       if l_Tag.IsValid then
       begin
        WriteOrd(l_Tag.AsLong);
        Exit;
       end;//l_Tag.IsValid
      except
       on EConvertError do ;
       on Ek2ConversionError do ;
      end;//try..except
     end;//tkInteger..
    end;//Case l_Prop.AtomType.TypeInfo^.Kind
   end;//l_Prop <> nil
   WriteString(O.AsWStr);
  end;//l_Prop <> nil 
end;

procedure TevdNativeUnpackedWriter.WriteStream(aStream: TStream);
  {-}
var
 StreamSize : Long;
begin
  aStream.Seek(0, soBeginning);
  StreamSize := aStream.Size;
  WriteByte(Ord(ev_idStream));
  WriteLong(StreamSize);
  Filer.Stream.CopyFrom(aStream, StreamSize);
end;

procedure TevdNativeUnpackedWriter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
begin
 WriteAtom(AtomIndex, Value);
end;

procedure TevdNativeUnpackedWriter.WriteAtom(AtomIndex: Long; const Value: Tk2Variant);
  {-}
var
 l_AT   : Tk2TypePrim;
 l_Prop : Tk2CustomPropertyPrim;
begin
  if (AtomIndex = k2_tiChildren) then
   AtomIndex := unpack_idChildren;
  with Value do
   Case Kind of
    k2_vkString :
    begin
     if not AsString.Empty then
     begin
      WriteWord(AtomIndex);
      OutObject(AtomIndex, AsVariant);
     end;//not AsString.Empty
    end;//ev_tkString
    else
    begin
     WriteWord(AtomIndex);
     Case Kind of
      k2_vkInteger:
       WriteOrd(AsInteger);
      k2_vkTransparent:
       WriteTransparent;
      k2_vkStream:
       WriteStream(AsStream);
      else
       inherited AddAtomEx(AtomIndex, Value);
     end;//Case Kind
    end;//else
   end;//Case Kind
end;

end.

