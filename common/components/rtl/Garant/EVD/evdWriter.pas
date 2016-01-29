unit evdWriter;
{* Писатель тегов в формате evd. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evEvdWrt - генератор текстов в формате evd }
{ Начат: 05.10.1999 13:00 }
{ $Id: evdWriter.pas,v 1.89 2015/08/31 12:20:48 lulin Exp $ }

// $Log: evdWriter.pas,v $
// Revision 1.89  2015/08/31 12:20:48  lulin
// {RequestLink:605362960}
// - форматируем код.
//
// Revision 1.87  2015/08/31 12:16:16  lulin
// {RequestLink:605362960}
// - правильнее пишем пустую Unicode строку.
//
// Revision 1.86  2015/08/18 12:34:09  lulin
// {RequestLink:604929290}
//
// Revision 1.85  2015/05/21 13:10:29  lulin
// - развязываем зависимости.
//
// Revision 1.84  2015/05/21 12:57:43  lulin
// - развязываем зависимости.
//
// Revision 1.83  2015/03/17 13:37:28  dinishev
// {Requestlink:590774242}
//
// Revision 1.82  2014/12/19 13:59:29  lukyanets
// Пишем бинарно
//
// Revision 1.81  2014/09/01 09:42:07  lulin
// - начинаем делать возможность задавать тегам артибуты типа "множество".
//
// Revision 1.80  2014/07/14 03:08:36  fireton
// - не собиралось
//
// Revision 1.79  2014/07/11 17:26:44  lulin
// - учимся читать задания из EVD.
//
// Revision 1.78  2014/07/11 16:36:25  lulin
// - учимся читать задания из EVD.
//
// Revision 1.77  2014/07/11 13:44:26  lulin
// - заворачиваем SourceFiles в теги.
//
// Revision 1.76  2014/07/11 13:10:01  lulin
// - заворачиваем SourceFiles в теги.
//
// Revision 1.75  2014/07/08 17:28:11  lulin
// {RequestLink:553427493}.
//
// Revision 1.74  2014/04/22 14:20:16  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.73  2014/04/22 10:56:16  lulin
// - прячем ненужный метод.
//
// Revision 1.72  2014/04/11 16:48:22  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.71  2014/04/09 16:03:02  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.70  2014/04/09 15:45:01  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.69  2014/03/27 14:20:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.68  2014/03/25 16:23:45  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.67  2014/03/06 17:23:24  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.66  2013/10/23 16:04:43  lulin
// - правильнее определяем "автоматические" типы.
//
// Revision 1.65  2013/10/22 16:45:05  lulin
// - реорганизуем таблицу тегов, чтобы избавится от "шаманства" и идентификаторами.
//
// Revision 1.64  2013/10/21 15:43:12  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.63  2013/10/21 10:31:00  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.62  2013/10/18 14:11:31  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.61  2013/04/05 16:44:16  lulin
// - портируем.
//
// Revision 1.60  2013/04/04 11:21:18  lulin
// - портируем.
//
// Revision 1.59  2012/10/02 12:10:57  lulin
// {RequestLink:397291045}
//
// Revision 1.57  2012/09/21 07:56:35  fireton
// - TevdCustomNativeWriter.Make
//
// Revision 1.56  2012/07/12 18:33:16  lulin
// {RequestLink:237994598}
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
// - change: TevVariant переименован в _Tk2Variant и переехал в k2Types.
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
  , k2Prim;

type
  TevdCustomNativeWriter = class(Tk2CustomFileGenerator)
   {* Писатель тегов в формате evd. }
    private
    {property fields}
      f_OutEndComment : Bool;
      {$IfDef evdNeedEverestTxt}
      f_Binary        : Bool;
      {$EndIf evdNeedEverestTxt}
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
      {$IfDef evdNeedEverestTxt}   
      procedure DoIndent;
        {-}
      procedure CloseLevel(NeedUndo: Bool);
        {-}
      procedure OutPropertyName(const aProp: Tk2Base; ID: Long);
        {-}
      {$EndIf evdNeedEverestTxt}
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
      function  GetKeyWord(anID: Long): AnsiString;
        {-}
      procedure OutKeyWord(anID: Long);
        {-}
      procedure Cleanup;
        override;
        {-}  
      procedure DoStartChild(TypeID: Tk2Type);
        virtual;
        {-}
      procedure DoCloseStructure(NeedUndo: Bool);
        virtual;
        {-}
      procedure WriteStartChild(TypeID: Tk2Type);
        {-}
      procedure WriteAtom(AtomIndex: Long; const Value: Ik2Variant);
        {-}
      procedure OutBinary(WithPrefix: Bool = true);
        {-}
      procedure OutEndBinary(Force: Boolean = False);
        {-}  
      function  WriteTypeID(ID: TevTypeID): Long;
        {-}
      function  WriteOrd(V: sInt32): Long;
        {-}
      function  WriteTransparent: Long;
        {-}
      function  WriteString(const S : Tl3WString): Long;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {- P - адрес указателя куда будет положен Self}
      constructor Make(const aFileName: AnsiString);
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Ik2Variant);
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
      {$IfDef evdNeedEverestTxt}
      property Binary: Bool
        read f_Binary
        write f_Binary
        default false;
        {* - писать в бинарном формате? }
      {$EndIf evdNeedEverestTxt}  
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
  end;{TevdCustomNativeWriter}

  TevdNativeWriter = class(TevdCustomNativeWriter)
   {*! Писатель тегов в формате evd. (С published свойствами) }
    published
      property Filer;
        {-}
      {$IfDef evdNeedEverestTxt}
      property Binary;
        {-}
      {$EndIf evdNeedEverestTxt}  
      property OutEndComment;
        {-}
  end;//TevdNativeWriter

implementation

uses
  SysUtils,
  TypInfo,

  l3Chars,
  l3String,
  l3Filer,

  k2Tags,
  k2Const,
  k2Except,

  evdVer,
  evdKW,
  {.$IfDef evdNeedEverestTxt}
  evdTxtConst,
  {.$EndIf evdNeedEverestTxt}

  Document_Const,
  k2FontName_Const,

  l3Memory,

  evdCustomNativeWriterServices
  ;

// start class TevdCustomNativeWriter 

constructor TevdCustomNativeWriter.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
begin
 inherited;
 f_OutEndComment := false;
 KeyWords := EvdKeyWords;
 NeedOutHeader := true;
 {$IfDef EverestLite}
 {$IfDef evdNeedEverestTxt}
 Binary := true;
 {$EndIf evdNeedEverestTxt}
 {$EndIf EverestLite}
end;

procedure TevdCustomNativeWriter.Cleanup;
  //override;
  {-}
begin
 l3Free(f_FontNames);
 inherited;
end;

function TevdCustomNativeWriter.pm_GetIndent: Long;
  {-}
begin
 Result := Types.Hi;
end;

{$IfDef evdNeedEverestTxt}
procedure TevdCustomNativeWriter.DoIndent;
  {-}
begin
 OutString(ev_psFixLen('', Indent, #32));
end;

procedure TevdCustomNativeWriter.CloseLevel(NeedUndo: Bool);
  {-}
begin
 DoIndent;
 if NeedUndo then OutString(evRollbackPrefix);
 OutString(evdCloseBracket);
 if OutEndComment then
 begin
  OutString(' //');
  OutString(TopObject[0].AsString);
 end;//OutEndComment
 OutEOL;
end;

procedure TevdCustomNativeWriter.OutPropertyName(const aProp: Tk2Base; ID: Long);
  {-}
var
 TT : Tk2TypePrim;
begin
 if (aProp = nil) then
 begin
  if (ID >= 0) then
   OutString(Format('<%d>', [ID]))
  else
   OutString(Format(': <%d>', [-ID]));
 end//aProp = nil
 else
 begin
  if (ID < 0) then
  begin
   OutString(':');
   TT := TopType[1];
   if (TT <> nil) then
    if (TT.DefaultChildTypeID = aProp.TagType) then
     Exit;
   OutString(cc_HardSpace);
   OutString(aProp.AsString);
  end//ID < 0
  else
   OutString(aProp.AsString);
 end;//ID < 0
end;
{$EndIf evdNeedEverestTxt}

procedure TevdCustomNativeWriter.OutBinary(WithPrefix: Bool = true);
  {-}
begin{OutBinary}
 if not f_WasBinary then
 begin
  f_WasBinary := true;
  if WithPrefix then
   OutString(evDirectivePrefix);
  OutKeyWord(evd_kwPBinary);
  OutEOL;
 end;//not f_WasBinary
end;{OutBinary}

procedure TevdCustomNativeWriter.OutEndBinary(Force: Boolean = False);
  {-}
begin
 if NeedOutHeader AND (Force or not SmallHeader) then
 begin
  f_WasBinary := false;
  OutString(evDirectivePrefix + GetKeyWord(evd_kwEndBinary));
 end;//NeedOutHeader
end;
  
function TevdCustomNativeWriter.WriteOrd(V: sInt32): Long;
  {-}
begin
 if (V >= 0) then begin
  if (V <= High(uInt8)) then
  begin
   Result := WriteTypeID(ev_idUInt8);
   Inc(Result, WriteBuf(@V, SizeOf(uInt8)));
  end//V <= High(uInt8)
  else
  if (V <= High(uInt16)) then
  begin
   Result := WriteTypeID(ev_idUInt16);
   Inc(Result, WriteBuf(@V, SizeOf(uInt16)));
  end//V <= High(uInt16)
  else
  begin
   Result := WriteTypeID(ev_idUInt32);
   Inc(Result, WriteBuf(@V, SizeOf(uInt32)));
  end;//V <= High(uInt16)
 end//V <= High(uInt8)
 else
 begin
  if (V >= Low(sInt8)) then
  begin
   Result := WriteTypeID(ev_idSInt8);
   Inc(Result, WriteBuf(@V, SizeOf(sInt8)));
  end//V >= Low(sInt8)
  else
  if (V >= High(sInt16)) then
  begin
   Result := WriteTypeID(ev_idSInt16);
   Inc(Result, WriteBuf(@V, SizeOf(sInt16)));
  end//V >= High(sInt16)
  else
  begin
   Result := WriteTypeID(ev_idSInt32);
   Inc(Result, WriteBuf(@V, SizeOf(sInt32)));
  end;//V >= High(sInt16)
 end;//V <= High(uInt8)
end;

function TevdCustomNativeWriter.WriteTransparent: Long;
  {-}
begin
 Result := WriteTypeID(ev_idTransparent);
end;

function TevdCustomNativeWriter.WriteString(const S : Tl3WString): Long;
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
  if (l_S.SCodePage >= 0) AND (l_S.SCodePage <= High(Byte)) then
  begin
   Result := WriteTypeID(ev_idShortCodePage);
   Inc(Result, WriteByte(l_S.SCodePage));
  end
  else
  begin
   Result := WriteTypeID(ev_idCodePage);
   Inc(Result, WriteLong(l_S.SCodePage));
  end;//_CodePage >= 0..
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

function TevdCustomNativeWriter.WriteTypeID(ID: TevTypeID): Long;
  {-}
begin
 Result := WriteBuf(@ID, SizeOf(ID));
end;

procedure TevdCustomNativeWriter.OutHeader;
  {-}
var
 Title : AnsiString;
 l_Date : TDateTime;
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
    {$If Defined(nsTest) AND Defined(InsiderTest)}
    l_Date := 70000;
    {$Else}
    l_Date := Date;
    {$IfEnd}
    OutString(cc_HardSpace + cc_SingleQuote + DateToStr(l_Date) + cc_SingleQuote);
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
   {$IfDef evdNeedEverestTxt}
   if Binary then
    OutBinary(SmallHeader)
   else
    OutEOL;
   {$Else  evdNeedEverestTxt}
   OutBinary(SmallHeader)
   {$EndIf evdNeedEverestTxt}
  end//Filer.Pos = 0
  else
  begin
   {$IfDef evdNeedEverestTxt}
   if Binary then
   {$EndIf evdNeedEverestTxt}
    OutBinary;
  end;//Filer.Pos = 0
 end;//NeedOutHeader
end;

procedure TevdCustomNativeWriter.AfterStreamOpened;
  {override;}
  {-}
begin
 if Filer.Opened then OutHeader;
end;

procedure TevdCustomNativeWriter.CloseStream(NeedUndo: Bool);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 if (f_FontNames <> nil) then f_FontNames.Clear;
 {$IfDef evdNeedEverestTxt}
 if Binary then
 {$EndIf evdNeedEverestTxt}
  OutEndBinary;
 inherited;
end;

procedure TevdCustomNativeWriter.CloseStructure(NeedUndo: Bool);
  {override;}
  {-вызывается на закрывающуюся скобку}
begin
 DoCloseStructure(NeedUndo);
 inherited;
end;

procedure TevdCustomNativeWriter.DoCloseStructure(NeedUndo: Bool);
  //virtual;
  {-}
begin
 {$IfDef evdNeedEverestTxt}
 if Binary then
 begin
 {$EndIf evdNeedEverestTxt}
  if (Indent <> 0) OR not SkipTopBrackets then
  begin
   if NeedUndo then
    WriteByte(evd_pack_idRollback)
   else
    WriteByte(evd_pack_idFinish);
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
 {$IfDef evdNeedEverestTxt}
 end//Binary
 else
 begin
  if (Indent <> 0) OR not SkipTopBrackets then
   CloseLevel(NeedUndo);
  if (Indent = 0) OR CurrentType.IsKindOf(k2_typDocument) then
  begin
   if not NeedUndo then
    Filer.Flush
   else
    Filer.Rollback;
  end;//Indent = 0
 end;//Binary
 {$EndIf evdNeedEverestTxt}
end;

function TevdCustomNativeWriter.GetKeyWord(anID: Long): AnsiString;
  {-}
begin
 Result := KeyWords.DRByID[anID].AsString;
end;

procedure TevdCustomNativeWriter.OutKeyWord(anID: Long);
  {-}
begin
 OutString(GetKeyWord(anID));
end;

procedure TevdCustomNativeWriter.StartTag(TagID: Long);
  {override;}
  {-}
begin
 inherited;
 if (Indent = 0) AND SkipTopBrackets then
  Exit;
 if (Indent = 0) then OutHeader;
 {$IfDef evdNeedEverestTxt}
 if Binary then
 begin
 {$EndIf evdNeedEverestTxt}
  Assert(TagID <= k2_tiLast, 'Именованные теги пока не поддерживаются бинарным форматом');
  WriteByte(TagID);
  WriteTypeID(ev_idAtom);
 {$IfDef evdNeedEverestTxt}
 end//Binary
 else
 begin
  DoIndent;
  OutPropertyName(TopObject[0], TagID);
  OutString(' = ');
  OutString(evdOpenBracket);
  OutEOL;
 end;//Binary
 {$EndIf evdNeedEverestTxt}
end;

procedure TevdCustomNativeWriter.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
begin
 inherited;
 DoStartChild(Tk2Type(TypeID));
end;

procedure TevdCustomNativeWriter.DoStartChild(TypeID: Tk2Type);
  //virtual;
  {-}
begin
 WriteStartChild(TypeID);
end;

procedure TevdCustomNativeWriter.WriteStartChild(TypeID: Tk2Type);
  {-}
var
 TT : Tk2TypePrim;
begin
 if (Indent = 0) AND SkipTopBrackets then
  Exit;
 if (Indent = 0) then OutHeader;
 {$IfDef evdNeedEverestTxt}
 if Binary then
 begin
 {$EndIf evdNeedEverestTxt}
  TT := TopType[1];
  if (TT <> nil) then
  begin
   if (TT.DefaultChildTypeID = TypeID) then
   begin
    WriteByte(evd_pack_idDefaultChild);
    Exit;
   end;//l_Prop <> nil..
  end;//TT <> nil
  Assert(not TypeID.IsAuto);
  WriteByte(TypeID.ID);
  WriteTypeID(ev_idChild);
 {$IfDef evdNeedEverestTxt}
 end//Binary
 else
 begin
  DoIndent;
  Assert(TypeID <> nil);
  OutPropertyName(TopObject[0], -TypeID.ID);
  OutString(' = ');
  OutString(evdOpenBracket);
  OutEOL;
 end;//Binary
 {$EndIf evdNeedEverestTxt}
end;

procedure TevdCustomNativeWriter.OutObject(AtomIndex: Long; O: Tl3Variant);
  {-}
const
 csnConvertCharCode = [0..31, 39, 60];
var
 l_Index    : Long;
 l_Prop     : Tk2CustomPropertyPrim;
 l_AT       : Tk2TypePrim;
 l_Tag      : Tl3Variant;
 {$IfDef evdNeedEverestTxt}
 l_Open     : Boolean;
 l_C        : PAnsiChar;
 l_WC       : PWideChar;
 l_W        : Integer;
 {$EndIf evdNeedEverestTxt}
 l_S        : Tl3WString;
begin
 {$IfDef evdNeedEverestTxt}
 if Binary then
 begin
 {$EndIf evdNeedEverestTxt}
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
 {$IfDef evdNeedEverestTxt}
 end//Binary
 else
 begin
  if (O = nil) then
  begin
   OutString(cc_SingleQuote);
   OutString(cc_SingleQuote);
  end//O = nil
  else
  begin
   l_S := O.AsWStr;
   if (l_S.SCodePage = CP_Unicode) then
   begin
    l_Open := false;
    l_WC := PWideChar(l_S.S);
    if (l_WC = nil) OR (l_S.SLen <= 0) then
    begin
     OutString(cc_SingleQuote);
     OutString(cc_SingleQuote);
    end//l_WC = nil
    else
    begin
     for l_Index := 0 to Pred(l_S.SLen) do
     begin
      l_W := Integer(l_WC[l_Index]);
      if (l_W < 32) OR (l_W > 127) OR (l_W in csnConvertCharCode) then
      begin
       if l_Open then
       begin
        OutString(cc_SingleQuote);
        l_Open := false;
       end;//l_Open
       OutString('#'+IntToStr(l_W));
      end//l_W < 32..
      else
      begin
       if not l_Open then
       begin
        OutString(cc_SingleQuote);
        l_Open := true;
       end;//l_Open
       if (l_W in csnConvertCharCode) then
        OutString('<' + IntToStr(l_W) + '>')
       else
        OutString(Char(l_W));
      end;//l_W < 32..
     end;//for l_Index
     if l_Open then
      OutString(cc_SingleQuote);
    end;//l_WC = nil
   end//l_S.SCodePage = CP_Unicode
   else
   begin
    OutString(cc_SingleQuote);
    l_C := l_S.S;
    if (l_C <> nil) then
    begin
     for l_Index := 0 to Pred(l_S.SLen) do
     begin
      if (l_C[l_Index] in [#0..#31, cc_SingleQuote, #60]) then
       OutString('<' + IntToStr(Ord(l_C[l_Index])) + '>')
      else
       OutString(l_C[l_Index]);
     end;//for l_Index
    end;//l_C <> nil
    OutString(cc_SingleQuote);
    if (l_C <> nil) AND
       (l_S.SCodePage <> CP_ANSI) AND
       (l_S.SCodePage <> CP_RussianWin) then
     OutString(cc_Comma + cc_HardSpace + IntToStr(l_S.SCodePage));
   end;//l_CodePage = CP_Unicode
  end;//O = nil
 end;//Binary
 {$EndIf evdNeedEverestTxt}
end;

procedure TevdCustomNativeWriter.WriteStream(aStream: TStream);
  {-}
var
 StreamSize : Long;
begin
 {$IfDef evdNeedEverestTxt}
 if Binary then
 begin
 {$EndIf evdNeedEverestTxt}
  aStream.Seek(0, soBeginning);
  StreamSize := aStream.Size;
  WriteByte(Ord(ev_idStream));
  WriteLong(StreamSize);
  Filer.Stream.CopyFrom(aStream, StreamSize);
 {$IfDef evdNeedEverestTxt}
 end;//Binary
 {$EndIf evdNeedEverestTxt}
end;

procedure TevdCustomNativeWriter.AddAtomEx(AtomIndex: Long; const Value: Ik2Variant);
  {override;}
  {-}
begin
 WriteAtom(AtomIndex, Value);
end;

constructor TevdCustomNativeWriter.Make(const aFileName: AnsiString);
var
 l_Filer : Tl3CustomFiler;
begin
 Create;
 l_Filer := Tl3CustomDOSFiler.Make(aFileName, l3_fmWrite, false);
 try
  Self.Filer := l_Filer;
 finally
  l3Free(l_Filer);
 end;//try..finally
end;

procedure TevdCustomNativeWriter.WriteAtom(AtomIndex: Long; const Value: Ik2Variant);
  {-}
var
 l_AT   : Tk2TypePrim;
 l_Prop : Tk2CustomPropertyPrim;
 l_StringStream : Tl3StringStream;
begin
 {$IfDef evdNeedEverestTxt}
 if Binary then
 begin
 {$EndIf evdNeedEverestTxt}
  Assert(AtomIndex <= k2_tiLast, 'Именованные теги пока не поддерживаются бинарным форматом');
  if (AtomIndex = k2_tiChildren) then
   AtomIndex := evd_pack_idChildren;
  with Value do
   Case Kind of
    k2_vkString :
    begin
     if not AsString.Empty then
     begin
      WriteByte(AtomIndex);
      OutObject(AtomIndex, AsVariant);
     end;//not AsString.Empty
    end;//ev_tkString
    else
    begin
     WriteByte(AtomIndex);
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
 {$IfDef evdNeedEverestTxt}
 end//Binary
 else
 begin
  if (Value.Kind = k2_vkStream) AND NeedOutHeader then
  begin
   OutString(evDirectivePrefix);
   OutKeyWord(evd_kwPBinary);
   OutEOL;
   Binary := true;
   try
    AddAtomEx(AtomIndex, Value);
   finally
    Binary := false;
    OutEndBinary(True);
   end;{try..finally}
  end//Value.Kind = k2_vkStream
  else
  begin
   OutString(cc_HardSpace);
   DoIndent;
   OutPropertyName(FindProperty(AtomIndex), AtomIndex);
   OutString(' = ');
   Case Value.Kind of
    k2_vkInteger:
    begin
     l_Prop := CurrentType.Prop[AtomIndex];
     if (l_Prop = nil) then
      OutString(IntToStr(Value.AsInteger))
     else
     begin
      l_AT := Tk2TypePrim(l_Prop.AtomType);
      Assert(l_AT <> nil);
      Assert(Tk2Type(l_AT).AtomType <> nil);
      Case Tk2Type(l_AT).AtomType^.Kind of
       tkInteger,
       tkEnumeration,
       tkSet:
        OutString(Value.AsVariant.AsString);
       else
        OutString(IntToStr(Value.AsInteger))
      end;//Case l_AT.AtomType^.Kind
     end;//l_Prop = nil
    end;//ev_tkInteger
    k2_vkString:
     OutObject(AtomIndex, Value.AsVariant);
    k2_vkTransparent:
     OutString(evTransparentToken);
    k2_vkStream:
    begin
     l_StringStream := Tl3StringStream.Create;
     try
      l_StringStream._String.CodePage := CP_ANSI;
      l_StringStream.CopyFrom(Value.AsStream, Value.AsStream.Size);
      //MimeEncodeStreamNoCRLF(Value.AsStream, l_StringStream);
      OutObject(AtomIndex, l_StringStream._String);
     finally
      FreeAndNil(l_StringStream);
     end;//try..finally
    end;//k2_vkStream
    else
     inherited AddAtomEx(AtomIndex, Value);
   end;//Case TK
   OutEOL;
  end;//Value.Kind = k2_vkStream
 end;//Binary
 {$EndIf evdNeedEverestTxt}
end;

end.

