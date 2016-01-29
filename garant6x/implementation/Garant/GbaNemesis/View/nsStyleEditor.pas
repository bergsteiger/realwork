unit nsStyleEditor;

(*-----------------------------------------------------------------------------
 Название:   nsStyleEditor
 Автор:      Морозов М. А.
 Назначение: Классы и интерфейсы для работы с редактором стилей.
 Версия:
  $Id: nsStyleEditor.pas,v 1.3 2014/01/09 12:26:05 morozov Exp $
 История:
  $Log: nsStyleEditor.pas,v $
  Revision 1.3  2014/01/09 12:26:05  morozov
  {RequestLink: 509702957}

  Revision 1.2  2013/04/24 09:35:56  lulin
  - портируем.

  Revision 1.1  2012/04/05 15:52:32  lulin
  {RequestLink:237994598}

  Revision 1.31  2011/08/03 11:07:48  lulin
  {RequestLink:272663564}.

  Revision 1.30  2011/08/02 16:41:39  lulin
  {RequestLink:272663564}.

  Revision 1.29  2011/08/02 16:14:51  lulin
  {RequestLink:272663564}.

  Revision 1.28  2011/07/29 14:18:53  lulin
  {RequestLink:209585097}.

  Revision 1.27  2011/06/17 12:31:51  lulin
  {RequestLink:228688486}.

  Revision 1.26  2011/02/14 14:01:07  lulin
  {RequestLink:231670346}.

  Revision 1.25  2009/10/19 07:32:27  oman
  - new: {RequestLink:167347184}

  Revision 1.24  2009/10/15 13:11:53  oman
  - new:  {RequestLink:166855474}

  Revision 1.23  2009/10/02 19:10:41  lulin
  - окончательно избавился от инициализации форм переменными списками параметров. Всё перевёл на фабрики.

  Revision 1.22  2009/08/06 09:28:46  oman
  - new: Пользуем стили для заголовков - {RequestLink:152408792}

  Revision 1.21  2009/07/27 08:46:24  lulin
  - bug fix: не компилировалось.

  Revision 1.20  2009/07/27 08:30:31  oman
  - new: Добавил стили - {RequestLink:157910955}

  Revision 1.19  2009/06/05 08:36:00  oman
  - new: Подключили стиль - [$149784287]

  Revision 1.18  2009/03/25 16:59:40  lulin
  [$136937722]. Показываем пользователю стиль с информацией о версии.

  Revision 1.17  2009/02/10 19:03:57  lulin
  - <K>: 133891247. Вычищаем морально устаревший модуль.

  Revision 1.16  2009/02/10 12:53:47  lulin
  - <K>: 133891247. Выделяем интерфейсы настройки.

  Revision 1.15  2009/01/11 13:31:59  oman
  - fix: Недовосстанавливали таблицу стилей (К-121164853)

  Revision 1.14  2008/11/14 07:44:18  oman
  - fix: Альтернативная локализация таблицы стилей (К-121164853)

  Revision 1.13  2008/06/20 14:48:40  lulin
  - используем префиксы элементов.

  Revision 1.12  2008/01/10 07:23:32  oman
  Переход на новый адаптер

  Revision 1.11.4.1  2007/11/20 11:39:19  oman
  Перепиливаем на новый адаптер

  Revision 1.11  2007/08/09 12:39:29  mmorozov
  - change: при корректировке таблицы стилей используем современные цвета (в рамках CQ: OIT5-26289);

  Revision 1.10  2007/08/08 12:11:48  oman
  - fix: Ставим заточку на предмет совпадения цветов фона и текста
   для ОМ - раньше цвет фона не пользовался и там может быть
   мусор (cq26287)

  Revision 1.9  2007/04/05 07:58:25  lulin
  - избавляемся от лишних преобразований строк при записи в настройки.

  Revision 1.8  2007/02/07 17:48:48  lulin
  - избавляемся от копирования строк при чтении из настроек.

  Revision 1.7  2007/01/31 13:46:04  oman
  - fix: Локализация библиотек и редактора стилей (cq24249)

  Revision 1.6  2007/01/30 15:06:38  oman
  - fix: Локализация редактора стилей - пока без перевода (cq24249)

  Revision 1.5  2006/04/28 09:47:41  oman
  - fix: Перестал приводится интерфейс (cq20749)

  Revision 1.4  2006/04/25 13:52:28  oman
  - change: Собирание интерфейсов по редактированию настроек в одно место
  - new beh: Интерфейсы по работе с настройками конфигурации и
   списком конфигураций (cq20377)

  Revision 1.3  2006/01/18 09:36:24  oman
  - cleanup (убраны не нужные операции opClearModifiedSign)
  - мелкий рефакторинг

  Revision 1.2  2005/12/13 16:13:15  oman
  - new behavior: наследник реализующий InsEditSettingsInfo, с учетом специфики
  таблицы стилей.

  Revision 1.1  2005/02/14 12:05:16  mmorozov
  - модуль для работы с таблицей стилей;

-----------------------------------------------------------------------------*)

interface

uses
  l3Interfaces,
  l3Types,

  vcmBase,
  vcmExternalInterfaces,
  vcmInterfaces,

  evdStyles,
  f1TextStyle_Const,

  nsConfiguration,

  StdRes,

  ConfigInterfaces,

  SettingsUnit,

  l3StringIDEx
  ;

type
  TnsStyleTableSettingsInfo = class(TnsEditSettingsInfo, InsStyleTableSettingsInfo)
  protected
  // protected methods
   function MakeEditingSettings: IvcmStrings;
    override;
   procedure DoLoad(aRestoreDefault: Boolean = False);
    override;
   procedure DoSave(aSaveAsDefault: Boolean = False);
    override;
  public  
   class function Make(const aConfig : IConfiguration = nil) : InsStyleTableSettingsInfo;
     {-}
  end;

 TnsVisibleStyleTableEntry = record
  ID: Long;
  ForAll: Boolean;
  Name: PvcmStringId;
 end;

const
 //http://mdp.garant.ru/pages/viewpage.action?pageId=504892332 
 str_saNormalSBSLeft_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_SBSLeft_Value'; rValue : 'Текст (лев. подпись)');
 str_saNormalSBSRight_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_SBSRight_Value'; rValue : 'Текст (прав. подпись)');
 str_saTxtHeader2_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader2_Value'; rValue : 'Заголовок 2');
 str_saTxtHeader3_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader3_Value'; rValue : 'Заголовок 3');
 str_saTxtHeader4_Value : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TextStyle_TxtHeader4_Value'; rValue : 'Заголовок 4');
 str_saNormalTable_Value: Tl3StringIDEx = (rs : -1; rLocalized : false; rkey : 'TextStyle_NormalTable_Value'; rValue: 'Нормальный (таблица)');
 str_saNormalTableList_Value: Tl3StringIDEx = (rs : -1; rLocalized : false; rkey : 'TextStyle_NormalTableList_Value'; rValue: 'Текст в таблице');
 str_saNormalNote_Value : Tl3StringIDEx = (rs : -1; rLocalized : false; rkey : 'TextStyle_NormalNote_Value'; rValue: 'Текст (справка)');

 VisibleStyleTable: array [0..40] of TnsVisibleStyleTableEntry = (
  (ID: ev_saTxtNormalANSI;              ForAll: True;  Name: @str_saTxtNormalANSI),
  (ID: ev_saTxtNormalOEM;               ForAll: True;  Name: @str_saTxtNormalOEM),
  (ID: ev_saTxtHeader1;                 ForAll: True;  Name: @str_saTxtHeader1),
  (ID: ev_saTxtOutOfDate;               ForAll: True;  Name: @str_saTxtOutOfDate),
  (ID: ev_saHyperLink;                  ForAll: True;  Name: @str_saHyperLink),
  (ID: ev_saTxtComment;                 ForAll: True;  Name: @str_saTxtComment),
  (ID: ev_saColorSelection;             ForAll: True;  Name: @str_saColorSelection),
  (ID: ev_saHyperLinkCont;              ForAll: True;  Name: @str_saHyperLinkCont),
  (ID: ev_saToLeft;                     ForAll: True;  Name: @str_saToLeft),
  (ID: ev_saArticleHeader;              ForAll: True;  Name: @str_saArticleHeader),
  (ID: ev_saUserComment;                ForAll: True;  Name: @str_saUserComment),
  (ID: ev_saContents;                   ForAll: True;  Name: @str_saContents),
  (ID: ev_saNotApplied;                 ForAll: True;  Name: @str_saNotApplied),
  (ID: ev_saDictEntry;                  ForAll: True;  Name: @str_saDictEntry),
  (ID: ev_saHFLeft;                     ForAll: True;  Name: @str_saHFLeft),
  (ID: ev_saHFRight;                    ForAll: True;  Name: @str_saHFRight),
  (ID: ev_saMainMenu;                   ForAll: True;  Name: @str_saMainMenu),
  (ID: ev_saMainMenuConstPath;          ForAll: True;  Name: @str_saMainMenuConstPath),
  (ID: ev_saMainMenuChangePath;         ForAll: True;  Name: @str_saMainMenuChangePath),
  (ID: ev_saMainMenuHeader;             ForAll: True;  Name: @str_saMainMenuHeader),
  (ID: ev_saMainMenuInteractiveHeader;  ForAll: True;  Name: @str_saMainMenuInteractiveHeader),
  (ID: ev_saFoundWords;                 ForAll: True;  Name: @str_saFoundWords),
  (ID: ev_saTechComment;                ForAll: False; Name: @str_saTechComment),
  (ID: ev_saMistake;                    ForAll: True;  Name: @str_saMistake),
  (ID: ev_saVersionInfo;                ForAll: True;  Name: @str_saVersionInfo),
  (ID: ev_saActiveHyperlink;            ForAll: True;  Name: @str_saActiveHyperlink),
  (ID: ev_saAddedText;                  ForAll: True;  Name: @str_saAddedText),
  (ID: ev_saDeletedText;                ForAll: True;  Name: @str_saDeletedText),
  (ID: ev_saChatHeaderSender;           ForAll: True;  Name: @str_saChatHeaderSender),
  (ID: ev_saChatHeaderRecipient;        ForAll: True;  Name: @str_saChatHeaderRecipient),
  (ID: f1_saNewSchoolMainMenuHeader;    ForAll: True;  Name: @str_saNewSchoolMainMenuHeader),
  (ID: f1_saNewSchoolMainMenuConstPath; ForAll: True;  Name: @str_saNewSchoolMainMenuConstPath),
  (ID: f1_saNewSchoolMainMenu;          ForAll: True;  Name: @str_saNewSchoolMainMenu),
  (ID: ev_saNormalSBSRight;             ForAll: True;  Name: @str_saNormalSBSRight_Value),
  (ID: ev_saNormalSBSLeft;              ForAll: True;  Name: @str_saNormalSBSLeft_Value),
  (ID: ev_saTxtHeader2;                 ForAll: True;  Name: @str_saTxtHeader2_Value),
  (ID: ev_saTxtHeader3;                 ForAll: True;  Name: @str_saTxtHeader3_Value),
  (ID: ev_saTxtHeader4;                 ForAll: True;  Name: @str_saTxtHeader4_Value),
  (ID: ev_saNormalTableList;            ForAll: False; Name: @str_saNormalTableList_Value),
  (ID: ev_saNormalNote;                 ForAll: False; Name: @str_saNormalNote_Value),
  (ID: ev_saNormalTable;                ForAll: False; Name: @str_saNormalTable_Value)
 );

function ResourceStyle: AnsiString;

implementation

Uses
 Classes,
 SysUtils,
 Graphics,

 l3Base,
 l3Stream,
 l3Memory,
 l3String,

 k2Tags,

 afwInterfaces,
 afwFacade,

 vcmStringList,

 evStyleInterfaceEx,
 evStyleTableSpy,

 nsSettings,
 nsConst,
 nsTypes
 ;

const
 CDefaultStyleTableResourceName = 'evStandardTextStyleTable';

var
 g_StyleTableProperties: IvcmStrings;
  {* - настройки редактируемые пользователем в таблице стилей. }
 g_ResourceStyle: AnsiString;
  {* - настройка лежащая в ресурсах }
 g_StartupStyleTable: TStream = nil;

function StartupStyleTable: TStream;
begin
 if g_StartupStyleTable = nil then
 begin
  g_StartupStyleTable := Tl3StringStream.Create;
  with TevStyleInterfaceEx.Make do
   try
    Save(g_StartupStyleTable);
   finally
    Free;
   end;//try..finally
 end;//if g_StartupStyleTable = nil then
 Result := g_StartupStyleTable;
 g_StartupStyleTable.Seek(0, soBeginning);
end;


function ResourceStyle: AnsiString;

 function GetStringFromResource(const aResourceName: AnsiString): AnsiString;
 var
  l_Size: Integer;
 begin//GetStringFromResource
  with Tl3ResourceStream.Create(HInstance, aResourceName) do
  try
   l_Size := Succ(Integer(Size));
   SetLength(Result, l_Size);
   ReadBuffer(PAnsiChar(Result)^, Pred(Longint(l_Size)));
   Result[l_Size] := #0;
  finally
   Free;
  end;//try..finally
 end;//GetStringFromResource

begin
 if (g_ResourceStyle = '') then
  g_ResourceStyle := GetStringFromResource(CDefaultStyleTableResourceName);
 Result := g_ResourceStyle;
end;

{ TnsStyleTableSettingsInfo }

class function TnsStyleTableSettingsInfo.Make(const aConfig : IConfiguration = nil) : InsStyleTableSettingsInfo;
  {-}
begin
 Result := inherited Make(aConfig) As InsStyleTableSettingsInfo;
end;

procedure TnsStyleTableSettingsInfo.DoLoad(aRestoreDefault: Boolean);

 function GetStringFromSettings(const aPropertyId: TPropertyStringID): Il3CString;
 begin//GetStringFromSettings
  Result := Settings.LoadString(aPropertyId, '', aRestoreDefault);
  if l3IsNil(Result) then
   Result := l3CStr(ResourceStyle);
 end;//GetStringFromSettings

 procedure lp_CorrectMainMenuHeaderStyle(const aTable: TevStyleInterfaceEx);
  {* - Проверим и починим цвет фона для заголовков основного меню
       (ЦК26287 и К-34504764). }
 begin
  with aTable do
  begin
   SelectStyle(ev_saMainMenuHeader);
   if not Font.IsOwn[k2_tiBackColor] and (Font.BackColor = clDefault) and
    (ColorToRGB(Font.ForeColor) = clWhite) then
   begin
    Changing;
    try
     with Font do
     begin
      ForeColor := c_MainMenuColor;
      BackColor := $00F9F8FA;
     end;//with Font do
    finally
     ChangedEx(False);
    end;//try..finally
    Self.Save;
   end;//if not Font.IsOwn[k2_tiBackColor]
  end;//with aTable do
 end;//lp_CorrectMainMenuHeaderStyle

 procedure lp_CorrectStyleNames(const aTable: TevStyleInterfaceEx);
 var
  l_IDX: Integer;
 begin
  // Грузим имена стилей.
  for l_IDX := Low(VisibleStyleTable) to High(VisibleStyleTable) do
  begin
   aTable.SelectStyle(VisibleStyleTable[l_IDX].ID);
   aTable.Name := nsEStr(vcmCStr(VisibleStyleTable[l_IDX].Name^));
  end;
 end;

var
 l_Stream : TStream;
 l_String : Il3CString;
 l_Table  : TevStyleInterfaceEx;
 l_N      : AnsiString;
 l_N1     : AnsiString;
 l_OS     : Boolean;
 l_SB     : Integer;
begin
 EvNotifyStyleTableChanging;
 try
  l_Table := TevStyleInterfaceEx.Make;
  try
   l_Table.SelectStyle(ev_saVersionInfo);
   l_N := l_Table.Tag.StrA[k2_tiShortName];
   l_Table.SelectStyle(ev_saTxtComment);
   l_N1 := l_Table.Tag.StrA[k2_tiShortName];
   l_OS := l_Table.Tag.BoolA[k2_tiHeaderHasOwnSpace];
   l_SB := l_Table.Tag.IntA[k2_tiSpaceBefore];

   // Восстанавливаем таблицу стилей на стартовую
   l_Table.Load(StartupStyleTable);

   // Грузим из настроек
   l_String := GetStringFromSettings(pi_StyleTable);
   if not l3IsNil(l_String) then
   begin
    l_Stream := Tl3StringStream.Create(l3PCharLen(l_String));
    try
     l_Table.Load(l_Stream);
    finally
     l3Free(l_Stream);
    end;//try..finally
   end;//not l3IsNil(l_String)

   // Грузим имена стилей.
   lp_CorrectStyleNames(l_Table);

   // Хачим стили
   lp_CorrectMainMenuHeaderStyle(l_Table);

   l_Table.SelectStyle(ev_saVersionInfo);
   l_Table.Tag.StrA[k2_tiShortName] := l_N;
   l_Table.SelectStyle(ev_saTxtComment);
   l_Table.Tag.StrA[k2_tiShortName] := l_N1;
   l_Table.Tag.BoolA[k2_tiHeaderHasOwnSpace] := l_OS;
   l_Table.Tag.IntA[k2_tiSpaceBefore] := l_SB;
  finally
   FreeAndNil(l_Table);
  end;//try..finally
 finally
  EvNotifyStyleTableChanged;
 end;//try..finally
end;

function TnsStyleTableSettingsInfo.MakeEditingSettings: IvcmStrings;
begin
 if not Assigned(g_StyleTableProperties) then
 begin
  g_StyleTableProperties := TvcmStringList.Make;
  with g_StyleTableProperties do
  begin
   Add(pi_StyleTable);
  end;
 end;
 Result := g_StyleTableProperties;
end;

procedure TnsStyleTableSettingsInfo.DoSave(aSaveAsDefault: Boolean);
var
 l_MemoryStream : Tl3StringStream;
begin
 l_MemoryStream := Tl3StringStream.Create;
 try
  with TevStyleInterfaceEx.Make do
   try
    Save(l_MemoryStream);
   finally
    Free;
   end;//try..finally
  Settings.SaveString(pi_StyleTable, l_MemoryStream As Il3CString, ResourceStyle, aSaveAsDefault);
 finally
  l3Free(l_MemoryStream);
 end;//try..finally
end;

initialization
 str_saNormalSBSRight_Value.Init;
 str_saNormalSBSLeft_Value.Init;
 str_saTxtHeader2_Value.Init;
 str_saTxtHeader3_Value.Init;
 str_saTxtHeader4_Value.Init;
 str_saNormalTable_Value.Init;
 str_saNormalNote_Value.Init;
 str_saNormalTableList_Value.Init;
 
finalization
 g_StyleTableProperties := nil;
 Finalize(g_ResourceStyle);
 FreeAndNil(g_StartupStyleTable);

end.
