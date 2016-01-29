unit ddSpell;

{ $Id: ddSpell.pas,v 1.59 2014/05/27 12:03:57 lulin Exp $ }

// $Log: ddSpell.pas,v $
// Revision 1.59  2014/05/27 12:03:57  lulin
// - чистка кода.
//
// Revision 1.58  2014/04/25 10:28:17  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.57  2014/04/08 14:16:18  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.56  2013/04/17 14:19:22  lulin
// - портируем.
//
// Revision 1.55  2011/08/23 17:56:53  lulin
// {RequestLink:279774229}.
//
// Revision 1.54  2010/07/12 14:34:45  fireton
// - переработанная проверка орфографии
//
// Revision 1.53  2010/05/17 12:00:52  voba
// - K:213255655
//
// Revision 1.52  2010/02/25 13:46:00  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.51  2010/02/24 18:22:24  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.50  2010/02/24 17:41:08  lulin
// - удаляем излишнюю виртуальность.
//
// Revision 1.49  2009/12/14 11:46:48  lulin
// - готовимся к возврату более простых строк.
//
// Revision 1.48  2009/03/04 14:17:43  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.47  2008/10/13 13:37:49  dinishev
// <K> : 84640081
//
// Revision 1.46  2008/10/09 11:29:27  dinishev
// Подготавливаемся к <K> : 89103144
//
// Revision 1.45  2008/06/20 14:48:48  lulin
// - используем префиксы элементов.
//
// Revision 1.44  2008/06/20 12:48:58  lulin
// - используем префиксы элементов.
//
// Revision 1.43  2008/06/18 11:45:23  dinishev
// По возможности вычищаем ARCHI_OLD_EVEREST
//
// Revision 1.42  2008/04/23 09:52:43  lulin
// - <K>: 89105866.
//
// Revision 1.41  2008/04/15 08:26:34  dinishev
// Восстанавливаем старый редактор
//
// Revision 1.40  2008/04/11 10:30:34  lulin
// - <K>: 89099090.
//
// Revision 1.39  2008/02/19 11:38:46  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.38  2008/02/14 15:41:00  lulin
// - удалён ненужный класс.
//
// Revision 1.37  2008/02/13 15:59:29  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.36  2008/02/12 19:33:00  lulin
// - избавляемся от универсальности списков.
//
// Revision 1.35  2008/02/06 15:38:53  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.34  2008/02/06 11:44:37  lulin
// - список строк переехал в отдельный файл.
//
// Revision 1.33  2008/02/05 09:56:53  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.32  2008/02/01 15:16:24  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.31  2007/12/03 09:48:15  dinishev
// Используем редактор из ветки
//
// Revision 1.30  2007/08/30 19:41:21  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.29  2005/05/24 14:53:14  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.28  2005/05/16 11:43:13  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.27  2005/04/26 16:55:13  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.26  2005/03/31 13:36:47  fireton
// - add: добавляем дополнительную проверку на "цифробуквенные конгломераты" (с) Бабанин
//
// Revision 1.25  2005/03/28 12:00:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.24  2005/03/11 16:28:58  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.23  2004/11/25 07:38:18  lulin
// - new unit: TevCustomEditor.
//
// Revision 1.22  2004/06/09 11:07:14  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.21  2004/06/02 16:58:15  law
// - cleanup.
//
// Revision 1.20  2004/06/02 08:33:15  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.19  2004/05/05 12:53:05  law
// - rename method: TevBaseSearcher.CheckEx -> TevBaseSearcher.DoCheck.
// - rename method: TevBaseSearcher.Search -> TevBaseSearcher.DoCheckText.
//
// Revision 1.18  2004/04/14 15:00:42  law
// - rename proc: ev_lpCharSetPresent -> l3CharSetPresent.
//
// Revision 1.17  2003/11/28 14:51:38  law
// - new unit: evSegmentsListConst.
//
// Revision 1.16  2002/10/29 11:19:56  law
// - cleanup.
//
// Revision 1.15  2002/10/29 11:08:04  law
// - new directive: evDualSpell.
//
// Revision 1.14  2002/07/31 15:09:23  law
// - new behavior: сделано обучение спеллера.
//
// Revision 1.13  2002/07/31 14:38:41  law
// - cleanup.
//
// Revision 1.12  2002/07/09 12:12:56  law
// - rename unit: l3UnitsTools -> l3Units.
//
// Revision 1.11  2002/06/28 16:13:33  law
// - new behavior: проверка орфографии при помощи DLL от Информатика.
// - new directive: evAlienSpell.
//
// Revision 1.10  2002/04/09 09:38:43  voba
// no message
//
// Revision 1.9  2002/02/08 13:30:07  law
// - use directive: evRunTime.
//
// Revision 1.8  2001/12/28 14:19:58  law
// - remove proc: Tl3CustomString._SetSt и Tl3CustomString.DoSetSt.
//
// Revision 1.7  2001/08/29 07:01:30  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.6  2001/03/14 16:27:40  law
// - убран параметр OEM.
//
// Revision 1.5  2001/02/20 13:33:52  law
// - some tuning
//
// Revision 1.4  2000/12/15 16:21:58  law
// - вставлены директивы Log.
//

interface

{$Include evDefine.inc }

{$IfDef evDualSpell}
 {$Define evAlienSpell}
{$EndIf evDualSpell}

uses
  Classes,
  SysUtils,

  l3Base,
  l3StringList,
  l3ObjectRefList,
  l3Types,
  l3InterfacedComponent,
  l3Filer,

  nevTools,

  k2Interfaces,

  evInternalInterfaces,
  evSearch,
  evIntf,

  ddSpellInterfaces,

  evTypes

  ;

type
  TddReplaceItem = class(Tl3String)
    private
    {internal fields}
      f_GoodWord : Tl3String;
    private
    {property methods}
      procedure pm_SetGoodWord(Value: Tl3String);
        {-}
    protected
    {internal methods}
      procedure Release;
        override;
        {-}
    public
    {public methods}
      procedure InitFields;
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
    public
    {public properties}
      property GoodWord: Tl3String
        read f_GoodWord
        write pm_SetGoodWord;
        {-}
  end;{TddReplaceItem}

  TddSpellDictionary = class(Tl3InterfacedComponent)
    private
      f_WordList : Tl3StringList;
      f_Filer    : TevDOSFiler;
      f_Changed  : Bool;
    protected
    {property methods}
      function  pm_GetFileName: String;
        {-}
      procedure pm_SetFileName(const Value: String);
        {-}
    protected
    {internal methods}
      procedure Release;
        override;
        {-}
    public
      constructor Create(AOwner: TComponent = nil);
        override;
        {-}
      procedure Add(var St: Tl3String);
      { добавляет слово в словарь }
      function InList(St: Tl3String): Bool;
      { слово присутствует в словаре }
      procedure Load;
        {-}
      procedure Save;
        {-}
    published
      property FileName: String
        read pm_GetFileName
        write pm_SetFileName;
        {-}
  end;{TddSpellDictionary}

  TddSpellCheckSearcher = class(TevBaseSearcher)
    private
      f_SpellChecker: IddSpeller;
    protected
    {property methods}
      function  pm_GetNotFoundMessage: AnsiString;
        override;
        {-}
    protected
    {internal methods}
      procedure Cleanup; override;
        {-}
    public
      constructor Create(aSpellChecker: IddSpeller);
        {-}
      function   DoCheckText(aSender : Tl3Variant;
                             aStr          : Tl3CustomString;
                             const aSel    : TevPair;
                             out theSel    : TevPair): Bool;
        override;
        {-}
    published
        {-}
  end;{TddSpellChecker}

  TddFoundValidator = class(TevBaseSearcher)
  protected
   function DoCheckTextEx(aPara    : Tl3Variant;
                          aText          : Tl3CustomString;
                          const aSel     : TevPair;
                          const aPrevSel : TevPair;
                          out theSel     : TevPair): Bool;
    override;
  end;

{$IfNDef evRunTime}
procedure Register;
{$EndIf  evRunTime}

implementation

uses
  Controls,
  Graphics,

  l3Chars,
  l3String,
  l3MinMax,
  l3PrimString,

  k2TagGen,
  k2Tags,

  evConst,
  evFacadeUtils,
  evCommonTypes,
  evCustomEditor
  ;

{$IfNDef evRunTime}
procedure Register;
begin
 RegisterComponents(evEverestPage, [TddSpellDictionary, TddSpellCheckSearcher]);
end;
{$EndIf  evRunTime}

procedure TddSpellCheckSearcher.Cleanup;
begin
 f_SpellChecker := nil;
 inherited;
end;

constructor TddSpellCheckSearcher.Create(aSpellChecker: IddSpeller);
begin
 inherited Create;
 f_SpellChecker := aSpellChecker;
end;

function TddSpellCheckSearcher.pm_GetNotFoundMessage: AnsiString;
begin
 Result:= 'Проверка правописания в документе завершена';
end;

function TddSpellCheckSearcher.DoCheckText(aSender : Tl3Variant;
                                     aStr          : Tl3CustomString;
                                     const aSel    : TevPair;
                                     out theSel    : TevPair): Bool;
begin
 Result := f_SpellChecker.SearchEvent(aSender,
                                      aStr,
                                      aSel.rStart, aSel.rFinish,
                                      theSel.rStart, theSel.rFinish);
end;

{ start class TddSpellDictionary }

function TddSpellDictionary.pm_GetFileName: String;
  {-}
begin
 if (f_Filer = nil) then
  Result := EmptyStr
 else
  Result := f_Filer.FileName; 
end;

procedure TddSpellDictionary.pm_SetFileName(const Value: String);
begin
 if (FileName <> Value) then begin
  try
   Save;
   if (Value = EmptyStr) then
    FreeAndNil(f_Filer)
   else begin
    if (f_Filer = nil) then f_Filer := TevDOSFiler.Create(nil);
    f_Filer.FileName := Value;
   end;
   Load;
  except
  end;
 end;
end;

procedure TddSpellDictionary.Load;
var
 S : Tl3String;
begin
 try
  if not f_WordList.Empty then f_WordList.Clear;
  f_Filer.Mode := l3_fmRead;
  f_Filer.Open;
  try
   if (f_WordList = nil) then
    f_WordList := Tl3StringList.MakeSorted;
   while not f_Filer.EOF do
   begin
    S := Tl3String.Make(f_Filer.ReadLn);
    try
     if not S.Empty then
      f_WordList.Add(S);
    finally
     FreeAndNil(S);
    end;{try..finally}
   end;{while not EOF}
  finally
   f_Filer.Close;
  end;{try..finally}
  f_Changed := False;
 except
 end;
end;

procedure TddSpellDictionary.Save;

 function SaveWord(S: Pl3CustomString; Index: Long): Bool; far;
 begin
  Result := true;
  if (Index > 0) then f_Filer.Write(cc_EOL);
  f_Filer.Write(S^.St, S^.Len);
 end;{SaveWord}

begin
 if (Self <> nil) AND f_Changed then
  try
   f_Filer.Mode := l3_fmWrite;
   f_Filer.Open;
   try
    f_WordList.IterateAllF(l3L2IA(@SaveWord));
   finally
    f_Filer.Close;
   end;{try..finally}
  except
  end;
end;

constructor TddSpellDictionary.Create(AOwner: TComponent);
begin
 inherited;
 f_Changed:= false;
end;

procedure TddSpellDictionary.Release;
begin
 { SaveDictionary;}
 FreeAndNil(f_Filer);
 FreeAndNil(f_WordList);
 inherited;
end;

procedure TddSpellDictionary.Add(var St: Tl3String);
{ добавляет слово в словарь }
begin
 if (Self <> nil) then begin
  if (f_WordList = nil) then
   f_WordList := Tl3StringList.MakeSorted;
  if (f_WordList.Add(St) >= 0) then begin
   FreeAndNil(St);
   f_Changed:= True;
  end;
 end;{Self <> nil}
end;

function TddSpellDictionary.InList(St: Tl3String): Boolean;
var
 i : Long;
begin
 if (Self = nil) then
  Result := false
 else
  Result := (f_WordList <> nil) AND f_WordList.FindData(St, i);
end;

{ start class TddReplaceItem }

procedure TddReplaceItem.InitFields;
  {override;}
  {-}
begin
 inherited;
 if (f_GoodWord = nil) then
  f_GoodWord := Tl3String.Create;
end;

procedure TddReplaceItem.BeforeAddToCache;
  {override;}
  {-}
begin
 inherited;
 if (f_GoodWord <> nil) then
  f_GoodWord.BeforeAddToCache;
end;

procedure TddReplaceItem.Release;
  {override;}
  {-}
begin
 FreeAndNil(f_GoodWord);
 inherited;
end;

procedure TddReplaceItem.pm_SetGoodWord(Value: Tl3String);
  {-}
begin
 l3Set(f_GoodWord, Value);
end;

function TddFoundValidator.DoCheckTextEx(aPara    : Tl3Variant;
                                         aText          : Tl3CustomString;
                                         const aSel     : TevPair;
                                         const aPrevSel : TevPair;
                                         out theSel     : TevPair): Bool;
begin
 Result := not l3CharSetPresent(aText.St + aSel.rStart, aSel.rFinish-aSel.rStart, cc_Digits);
 if Result then
  theSel := aSel;
end;

end.

