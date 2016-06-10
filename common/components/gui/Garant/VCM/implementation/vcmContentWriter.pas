unit vcmContentWriter;

{ $Id: vcmContentWriter.pas,v 1.46 2016/05/26 12:33:48 kostitsin Exp $ }

// $Log: vcmContentWriter.pas,v $
// Revision 1.46  2016/05/26 12:33:48  kostitsin
// - не собиралось
//
// Revision 1.45  2015/07/21 14:28:57  lulin
// - делаем чтобы собиралось.
//
// Revision 1.44  2013/11/11 15:21:12  lulin
// - вычищаем устаревший код.
//
// Revision 1.43  2013/04/05 12:02:33  lulin
// - портируем.
//
// Revision 1.42  2012/05/23 18:32:59  lulin
// {RequestLink:294608726}
//
// Revision 1.41  2011/06/23 17:01:31  lulin
// {RequestLink:254944102}.
//
// Revision 1.40  2010/06/01 18:42:23  lulin
// {RequestLink:215549303}.
// - вычищаем ненужные данные.
//
// Revision 1.39  2009/05/26 10:30:01  oman
// - new: Рисуем пока без клавиатуры - [$148018532]
//
// Revision 1.38  2009/02/20 13:44:16  lulin
// - <K>: 136941122.
//
// Revision 1.37  2009/02/19 14:03:31  lulin
// - <K>: 136941122. Выделяем интерфейсы писателей.
//
// Revision 1.36  2008/07/14 17:43:49  lulin
// - <K>: 100958755.
//
// Revision 1.35  2008/02/19 11:05:49  lulin
// - восстановил всякие экзотические поиски в списках объектов.
//
// Revision 1.34  2008/02/13 16:03:04  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.33  2008/02/06 11:44:30  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.32  2007/07/27 11:57:28  oman
// - new: В механизм локализации включаем фабрики сборок (cq25775)
//
// Revision 1.31  2007/07/27 10:11:11  oman
// - new: Локализуем свойство "EmptyHint" (cq25825)
//
// Revision 1.30  2007/07/26 12:24:28  oman
// - fix: Заточки для локализации vtHeader - новые обработчики
// _OnGetLocalizationInfo (cq24480)
//
// Revision 1.29  2007/04/10 13:20:08  lulin
// - используем строки с кодировкой.
//
// Revision 1.28  2007/02/26 12:59:48  oman
// - fix: Не выливали Message._CustomButtonCaption (cq24518)
//
// Revision 1.27  2006/11/25 15:47:39  lulin
// - для писателей в файл выделен общий предок.
//
// Revision 1.26  2006/11/25 15:22:33  lulin
// - удален лишний предок.
//
// Revision 1.25  2006/11/25 14:53:53  lulin
// - bug fix: не компилировалось.
//
// Revision 1.24  2006/11/22 09:49:07  lulin
// - убран ненужный параметр.
//
// Revision 1.23  2006/11/03 11:00:29  lulin
// - объединил с веткой 6.4.
//
// Revision 1.22.2.3  2006/10/23 07:50:39  lulin
// - bug fix: были ошибки в константах.
//
// Revision 1.22.2.2  2006/10/23 07:28:57  lulin
// - выливаем для контролов свойства Text и ItemsText.
//
// Revision 1.22.2.1  2006/10/17 12:47:38  lulin
// - bug fix: не выливались длинные имена пользовательских типов.
//
// Revision 1.22  2006/06/26 12:23:11  oman
// - new beh: При генерации файла <имя проекта>.res.lng выводим перевод
//  в зависимости от директивы vcmExportTranslation (которая сейчас
//  выключена) (cq21409)
//
// Revision 1.21  2006/03/24 09:28:04  lulin
// - вынесены константы.
//
// Revision 1.20  2006/03/24 09:08:26  lulin
// - new behavior: не выливаем не русские заголовки.
//
// Revision 1.19  2006/03/23 14:39:49  lulin
// - new behavior: выливаем строковые константы.
//
// Revision 1.18  2006/03/23 12:48:54  lulin
// - выводим пустые строки.
//
// Revision 1.17  2006/03/20 13:03:50  lulin
// - new behavior: выливаем параметры состояний операции.
//
// Revision 1.16  2006/03/16 14:53:01  lulin
// - new behavior: не записываем дублирующиеся Hint'ы.
//
// Revision 1.15  2006/03/13 14:23:54  lulin
// - new behavior: записываем UserType'ы.
//
// Revision 1.14  2006/03/13 13:04:04  lulin
// - не записываем категории - ибо ини должны покрываться именами или категориями (пунктами меню).
//
// Revision 1.13  2006/03/13 10:14:55  lulin
// - перевод категории делаем из перевода пункта меню.
//
// Revision 1.12  2006/03/10 18:22:01  lulin
// - работа над заливкой/выливкой строковых ресурсов.
//
// Revision 1.11  2006/03/10 11:49:01  lulin
// - поддерживаем интерфейс IvcmResources - с реализацией.
//
// Revision 1.10  2006/03/10 08:11:50  lulin
// - new behavior: не записываем значения с дублирующимися ключами.
//
// Revision 1.9  2006/03/10 07:22:21  lulin
// - не выводим лишние элементы пути.
// - разделяем операции модулей и сущностей.
//
// Revision 1.8  2006/03/09 20:07:35  lulin
// - bug fix: строки с кавычками обрезались.
// - new behavior: выливаем сообщения системы.
//
// Revision 1.7  2006/03/09 19:19:02  lulin
// - выделены константы.
//
// Revision 1.6  2006/03/09 18:43:24  lulin
// - выделяем константы.
// - записываем тип элемента.
//
// Revision 1.5  2006/03/09 17:58:03  lulin
// - еще раз выдлены константы.
//
// Revision 1.4  2006/03/09 17:25:51  lulin
// - выделены константы.
//
// Revision 1.3  2006/03/09 17:14:49  lulin
// - выводим решетку и после перевода.
//
// Revision 1.2  2006/03/09 16:57:10  lulin
// - добавлены директивы CVS.
//

{$Include vcmDefine.inc}

interface

{$IfDef vcmNeedL3}
uses
  ActiveX,

  vcmUserControls,
  vcmInterfaces,
  vcmWritersInterfaces,

  l3Interfaces,
  l3Types,
  l3Base,
  l3StringList,
  l3Writer,
  l3ValLst
  ;

type
  TvcmContentWriter = class(Tl3Writer, IvcmContentWriter)
    private
    // internal fields
      f_Levels    : Tl3StringList;
      f_Written   : Tl3StringList;
      f_MenuItems : Tl3ValueList;
      LastModule,
      LastForm,
      LastEntity : AnsiString;
      LastOp     : AnsiString;
      function GetElement(const aType: AnsiString): AnsiString;
      function WriteParam(ParamName, Name, aSuffix: AnsiString;
                          const aLast : AnsiString = ''): AnsiString;
      procedure SaveElement(Name, aSuffix: AnsiString);
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    protected
    // interface methods
      procedure OpenLevel(const aString : AnsiString);
        overload;
        {* - открывает новый тег. }
      procedure OpenLevel(const aString : AnsiString;
                          const aSuffix : AnsiString);
        overload;
        {* - открывает новый тег. aSuffix - атрибуты тега. }
      procedure OpenSubLevel(const aSuffix : AnsiString = '');
        {* - открывает подуровень, путем отрезания буквы "s" у предыдущего уровня. }
      procedure CloseLevel;
        {* - закрывает тег. }
      function  CS(const aSt: Tl3PCharLenPrim): AnsiString;
        overload;
        {* - Escape'ит строку. }
      function  CS(const aSt: Il3CString): AnsiString;
        overload;
        {* - Escape'ит строку. }
      function  CS(const aString: AnsiString): AnsiString;
        overload;
        {* - Escape'ит строку. }
      procedure Finish;
        override;
        {* - заканчивает генерацию. }
      procedure SaveUF(const aString : AnsiString;
                       const anUF    : IvcmUserFriendlyControl;
                       aNeedClose    : Boolean = true);
        overload;
        {* - сохраняет объект в поток. }
      procedure SaveUF(const aString : AnsiString;
                       const anUF    : IvcmUserFriendlyControl;
                       const aSuffix : AnsiString;
                       aNeedClose    : Boolean = true);
        overload;
        {* - сохраняет объект в поток. }
      procedure PutData(const aString: AnsiString); overload;
      procedure PutData(const aString: Il3CString); overload;
      procedure PutData(const aString: Tl3WString); overload;
      procedure PutSimpleField(const aName: AnsiString;
       const aAttributes: AnsiString;
       const aData: AnsiString);
    {* Утилитный метод. Открывает тег с атрибутами, записывает внутрь данные и закрывает тег. }
    public
    // public methods
      constructor Create(const aFileName: String);
        override;
        {-}
      class function Make(const aFileName: AnsiString): IvcmContentWriter;
        reintroduce;
        {* - создает генератор, для записи содержимого в файл. }
  end;//TvcmContentWriter

{$EndIf vcmNeedL3}

implementation

{$IfDef vcmNeedL3}

uses
  SysUtils,
  StrUtils,

  l3Chars,
  l3String,

  vcmExportConst,
  vcmContentConst
  ;

function ParseName(Name: AnsiString): AnsiString;
var
 L, I: Integer;
 S: AnsiString;
begin
 Result := '';
 L := Length(Name);
 if L = 0 then
  Exit;
 S := '';
 for I := 1 to L do
 begin
  if (Name[I] in cc_UpEnglish) and ((I < L) and (Name[I + 1] in cc_LoEnglish)) then
  begin
   if S <> '' then
    Result := Result + ' ' + S;
   S := Name[I];
  end else
  if S <> '' then
   S := S + Name[I];
 end;
 Result := Trim(Result + ' ' + S);
end;

function GetLastName(Name: AnsiString): AnsiString;
var
  I: Integer;
begin
 Result := '';
 for I := Length(Name) downto 1 do
  if (Name[I] = c_vcmContentSep) then
   Break
  else
   Result := Name[I] + Result;
end;

function SetFirstCapital(S: AnsiString): AnsiString;
var
  I: Integer;
begin
 Result := LowerCase(S);
 for I := 1 to Length(S) do
  if Result[I] <> ' ' then
  begin
   Result[I] := UpCase(Result[I]);
   Break;
  end;
end;

procedure SkipSpaces(S: AnsiString; var I: Integer);
var
 L: Integer;
begin
 L := Length(S);
 while (I <= L) and (S[I] = ' ') do
  Inc(I);
end;

function GetValue(S, Name: AnsiString): AnsiString;
var
 Opened: Boolean;
 Tmp: AnsiString;
 L, I: Integer;
begin
 Name := LowerCase(Name);
 Result := '';
 Opened := False;
 Tmp := '';
 L := Length(S);
 if L = 0 then
  Exit;
 I := 1;
 repeat
  if S[I] = '"' then
   Opened := not Opened
  else
  if not Opened then
  begin
   if S[I] = ' ' then
    Tmp := ''
   else
   if S[I] = '=' then
   begin
    Inc(I);
    SkipSpaces(S, I);
    if LowerCase(Trim(Tmp)) <> Name then
    begin
     Tmp := '';
     Continue;
    end;
    if S[I] = '"' then
    begin
     Result := '';
     Inc(I);
     while (I <= L) and (S[I] <> '"') do
     begin
      Result := Result + S[I];
      Inc(I);
     end;
    end;
    Break;
   end
   else
    Tmp := Tmp + S[I];
  end;
  Inc(I);
 until I > L;
end;

function GetName(S: AnsiString): AnsiString;
begin
 Result := GetValue(S, c_vcmID);
end;

function Add(S1, S2: AnsiString): AnsiString;
begin
  if S2 = '' then
    Result := S1
  else
  begin
    Result := S2;
    if S1 <> '' then
      Result := S1 + c_vcmContentSep + Result;
  end;
end;

const
 cModule = c_vcmModule;
 cForm = c_vcmForm;
 cEntity = c_vcmEntity;
 cControl = c_vcmControl;
 cOperation = c_vcmOperation;
 cState = c_vcmState;
 cModuleOperation = c_vcmModuleOperation;
 cMessage = c_vcmMessage;
 cString = c_vcmString;
 cMenuItem = c_vcmMenuItem;
 cUserType = c_vcmUserType;
 cFormSetFactory = c_vcmFormSetFactory;

// start class TvcmContentWriter

constructor TvcmContentWriter.Create(const aFileName: String);
  //reintroduce;
  {-}
begin
 inherited;

 LastModule := '';
 LastForm := '';
 LastEntity := '';
 LastOp := '';
end;

class function TvcmContentWriter.Make(const aFileName: AnsiString): IvcmContentWriter;
  //reintroduce;
  //overload;
  {* - создает генератор, для записи содержимого в файл. }
var
 l_Writer: TvcmContentWriter;
begin
 l_Writer := Create(aFileName);
 try
  Result := l_Writer;
 finally
  l3Free(l_Writer);
 end;//try..finally
end;

procedure TvcmContentWriter.Cleanup;
  //override;
  {-}
begin
 l3Free(f_MenuItems);
 l3Free(f_Written);
 l3Free(f_Levels);
 inherited;
end;

procedure TvcmContentWriter.OpenLevel(const aString : AnsiString);
  //overload;
  {-}
begin
 OpenLevel(aString, '');
end;

function TvcmContentWriter.GetElement(const aType: AnsiString): AnsiString;
var
 l_E    : AnsiString;
 l_Type : AnsiString;
begin
 l_Type := aType;
 if (aType = cModule) then
  Result := Add('', LastModule)
 else
 begin
  Result := '';
  if (aType = cForm) OR (aType = cControl) {OR (aType = cUserType)} then
   Result := Add(Result, LastForm);
  l_E := LastEntity;
  if (l_E = '') AND (aType = cOperation) then
  begin
   l_E := LastModule;
   l_Type := cModuleOperation;
  end;//l_E = ''
  Result := Add(Result, l_E);
  if (aType = cState) then
   Result := Add(Result, LastOp);  
 end;//aType = cModule
 Result := Add(l_Type, Result)
end;

function TvcmContentWriter.WriteParam(ParamName, Name, aSuffix : AnsiString;
                                      const aLast              : AnsiString = ''): AnsiString;
var
 l_Path  : AnsiString;
 l_Index : Integer;
{$IfDef vcmExportTranslation}
 l_Name  : AnsiString;
{$EndIf vcmExportTranslation}
begin
 if (LowerCase(ParamName) = c_vcmCaption) then
  Result := GetValue(aSuffix, c_vcmTitle)
 else
  Result := GetValue(aSuffix, ParamName);
 if (Result <> '') AND (Result <> aLast) then
 begin
  l_Path := Format('%s%s%s',
                   [Name, c_vcmContentSep, ParamName]);
  if (f_Written <> nil) AND f_Written.FindData(l_Path, l_Index) then
   Exit;
   // - не записываем дубликаты
{$IfDef vcmExportTranslation}
  if (LowerCase(ParamName) = c_vcmCategory) then
  begin
   if (f_MenuItems <> nil) then
    l_Name := f_MenuItems.Values[Result];
   if (l_Name = '') then
   begin
    l_Name := ReverseString(ev_psSuffix(ReverseString(Name), c_vcmContentSep));
    l_Name := SetFirstCapital(ParseName(GetLastName(l_Name)));
   end;//l_Name = ''
  end//LowerCase(ParamName) = c_vcmCategory
  else
   l_Name := SetFirstCapital(ParseName(GetLastName(Name)));
{$EndIf vcmExportTranslation}
  if not l3CharSetPresent(PChar(Result), Length(Result), cc_ANSIRussian) then
   Exit;
  WriteLn(Format('%s%s%s',
                         [c_vcmOpenKey, l_Path, c_vcmCloseKey]));
  WriteLn(Result);
  WriteLn(c_vcmValueEnd);
{$IfDef vcmExportTranslation}
  WriteLn(l_Name);
{$Else vcmExportTranslation}
  WriteLn('');
{$EndIf vcmExportTranslation}
  WriteLn(c_vcmValueEnd);
  if (f_Written = nil) then
   f_Written := Tl3StringList.MakeSorted;
  f_Written.Add(l_Path);
 end;//Result <> ''
end;

procedure TvcmContentWriter.SaveElement(Name, aSuffix: AnsiString);
var
 l_Last : AnsiString;
begin
 l_Last := WriteParam(SetFirstCapital(c_vcmCaption), Name, aSuffix);
 l_Last := WriteParam(SetFirstCapital(c_vcmHint), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmLongHint), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmLongCaption), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmEmptyHint), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmText), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmItems+c_vcmText), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmCustomButtonCaption), Name, aSuffix, l_Last);
// l_Last := WriteParam(SetFirstCapital(c_vcmAdditionalInfo), Name, aSuffix, l_Last);
 //l_Last := WriteParam(SetFirstCapital(c_vcmChoices), Name, aSuffix, l_Last);
 l_Last := WriteParam(SetFirstCapital(c_vcmFooterCaption), Name, aSuffix, c_vcmFooterCaption);
//WriteParam(SetFirstCapital(c_vcmCategory), Name, aSuffix);
end;

procedure TvcmContentWriter.OpenLevel(const aString : AnsiString;
                                      const aSuffix : AnsiString);
  //overload;
  {-}
var
 S: AnsiString;
begin
 if (f_Levels = nil) then
  f_Levels := Tl3StringList.Create;
 if (aSuffix <> '') then
 begin
  S := LowerCase(aString);
  if (S = cModule) then
  begin
   LastModule := GetName(aSuffix);
   SaveElement(GetElement(S), aSuffix);
  end//S = cModule
  else
  if (S = cForm) then
  begin
   LastForm := GetName(aSuffix);
   SaveElement(GetElement(S), aSuffix);
  end//S = cForm
  else
  if (S = cEntity) then
  begin
   LastEntity := GetName(aSuffix);
   SaveElement(GetElement(S), aSuffix);
  end//S = cEntity
  else
  if (S = cOperation) then
  begin
   LastOp := GetName(aSuffix);
   SaveElement(Add(GetElement(S), LastOp), aSuffix);
  end//S = cOperation
  else
  if (S = cControl) or (S = cFormSetFactory) or
     (S = cMessage) or {(S = cUserType) or} (S = cState) or (S = cString) then
   SaveElement(Add(GetElement(S), GetName(aSuffix)), aSuffix)
  else
  if (S = cMenuItem) then
  begin
   if (f_MenuItems = nil) then
    f_MenuItems := Tl3ValueList.Create;
   f_MenuItems.Values[GetValue(aSuffix, c_vcmTitle)] := GetValue(aSuffix, c_vcmID); 
   SaveElement(Add(GetElement(S), GetName(aSuffix)), aSuffix);
  end;//S = cMenuItem
 end;//aSuffix <> ''
 f_Levels.Add(aString);
end;

procedure TvcmContentWriter.OpenSubLevel(const aSuffix : AnsiString = '');
  {-}
var
 l_S : AnsiString;
begin
 with f_Levels do
  l_S := Items[Pred(Count)].AsString;
 OpenLevel(Copy(l_S, 1, Pred(Length(l_S))), aSuffix);
end;

procedure TvcmContentWriter.CloseLevel;
  {-}
var
 l_Out : AnsiString;
begin
 if (f_Levels <> nil) AND (f_Levels.Count > 0) then
 begin
  with f_Levels do
  begin
   l_Out := LowerCase(Items[Pred(Count)].AsString);
   if (l_Out = cModule) then
   begin
    LastModule := '';
    LastForm := '';
    LastEntity := '';
    LastOp := '';
   end
   else
   if (l_Out = cForm) then
   begin
    LastForm := '';
    LastEntity := '';
    LastOp := '';
   end
   else
   if (l_Out = cEntity) then
   begin
    LastEntity := '';
    LastOp := '';
   end//l_Out = cEntity
   else
   if (l_Out = cOperation) then
    LastOp := '';
   Delete(Pred(Count));
   if (Count = 0) then
    l3Free(f_Levels);
  end;//f_Levels
 end;
end;

function TvcmContentWriter.CS(const aString: AnsiString): AnsiString;
  {-}
begin
 Result := ANSIReplaceStr(aString, '"', '''');
end;

function TvcmContentWriter.CS(const aSt: Tl3PCharLenPrim): AnsiString;
  //overload;
  {* - Escape'ит строку. }
begin
 Result := CS(l3PCharLen2String(aSt));
end;

function TvcmContentWriter.CS(const aSt: Il3CString): AnsiString;
  //overload;
  {* - Escape'ит строку. }
begin
 Result := CS(l3PCharLen(aSt));
end;

procedure TvcmContentWriter.Finish;
  {-}
begin
 inherited;
 if (f_Written <> nil) then
  f_Written.Clear;
 if (f_MenuItems <> nil) then
  f_MenuItems.Clear;  
end;

procedure TvcmContentWriter.SaveUF(const aString : AnsiString;
                                   const anUF    : IvcmUserFriendlyControl;
                                   aNeedClose    : Boolean = true);
  //overload;
  {* - сохраняет объект в поток. }
begin
 SaveUF(aString, anUF, '', aNeedClose);
end;

procedure TvcmContentWriter.SaveUF(const aString : AnsiString;
                                   const anUF    : IvcmUserFriendlyControl;
                                   const aSuffix : AnsiString;
                                   aNeedClose    : Boolean = true);
  //overload;
  {* - сохраняет объект в поток. }
var
 l_Suffix : AnsiString;
begin
 l_Suffix := Format(cTitID + ' %s="%s" %s="%s" %s',
                   [CS(anUF.Caption), CS(anUF.Name),
                    c_vcmHint, CS(anUF.Hint),
                    c_vcmLongHint, CS(anUF.LongHint), aSuffix]);
 OpenLevel(aString, l_Suffix);
 if aNeedClose then
  CloseLevel;
end;

procedure TvcmContentWriter.PutData(const aString: Il3CString);
begin
 Assert(False);
end;

procedure TvcmContentWriter.PutData(const aString: AnsiString);
begin
 Assert(False);
end;

procedure TvcmContentWriter.PutData(const aString: Tl3WString);
begin
 Assert(False);
end;

procedure TvcmContentWriter.PutSimpleField(const aName, aAttributes,
  aData: AnsiString);
begin
 Assert(False);
end;

{$EndIf vcmNeedL3}

end.
