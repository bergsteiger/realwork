unit m4Search;
{* Поисковые формулы. }

{ Библиотека "M4"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m4Search -      }
{ Начат: 10.12.2001 19:23 }
{ $Id: m4Search.pas,v 1.9 2011/05/18 12:10:36 lulin Exp $ }

// $Log: m4Search.pas,v $
// Revision 1.9  2011/05/18 12:10:36  lulin
// {RequestLink:266409354}.
//
// Revision 1.8  2009/03/19 16:28:32  lulin
// [$139443095].
//
// Revision 1.7  2007/08/14 14:30:19  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.6  2005/03/03 15:42:23  lulin
// - bug fix: некорректно подсвечивался результат поисков "Путин & Ельцин" и "Путин &A Ельцин".
//
// Revision 1.5  2005/03/02 18:36:18  lulin
// - new exception: Em4SearchCanceled.
//
// Revision 1.4  2005/03/02 18:09:27  lulin
// - new behavior: при контекстном поиске по маске, если слов больше чем 20 спрашиваем пользователя о необходимости продолжить поиск (через интерфейс IafwUserQuery), а не просто кидаем исключение.
//
// Revision 1.3  2005/03/02 17:49:12  lulin
// - new interface: IafwUserQuery.
//
// Revision 1.2  2004/09/21 11:22:31  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 07:15:22  law
// - cleanup.
//
// Revision 1.37  2003/02/20 14:53:17  law
// no message
//
// Revision 1.36  2003/02/20 14:05:42  law
// - cleanup.
//
// Revision 1.35  2003/02/18 18:06:20  law
// - new directive: m4DebugSearch.
//
// Revision 1.34  2002/09/11 11:41:30  law
// - bug fix: в операции следования не учитывалось желаемое расстояние между словами.
//
// Revision 1.33  2002/09/10 13:17:40  voba
// - bug fix: убрана симметричность следования при поиске в пределах параграфа.
//
// Revision 1.32  2002/09/10 12:40:47  law
// - new behavior: доделан поиск следования в пределах документа и в пределах абзаца.
//
// Revision 1.31  2002/09/10 09:56:51  law
// - new unit: m4SearchConst.
//
// Revision 1.30  2002/09/10 08:46:58  law
// - new behavior: подсветка всех слов входящих в выражение.
//
// Revision 1.29  2002/09/10 08:26:08  law
// - change: вместо Tm3DocumentAddress используем Im4Address.
//
// Revision 1.28  2002/09/09 13:25:04  law
// - cleanup.
//
// Revision 1.27  2002/09/05 12:42:42  law
// - bug fix: не всегда искались выражения с маской.
//
// Revision 1.26  2002/04/23 15:02:45  law
// - bug fix: перепутал знак расстояния.
//
// Revision 1.25  2002/04/23 14:47:11  law
// - new class: Tm4FollowExpression.
//
// Revision 1.24  2002/04/23 14:16:23  law
// - bug fix: неправильно интерпретировались модификаторы операции И.
//
// Revision 1.23  2002/04/23 11:25:54  law
// - bug fix: не разбирались суффиксы П, А, Д.
//
// Revision 1.22  2002/04/19 08:47:05  law
// - new class: Tm4ANDExpression.
//
// Revision 1.21  2002/04/16 15:02:22  law
// - _move const: m3StopWordAddress переехала в m3DocumentAddress.
//
// Revision 1.20  2002/03/11 13:41:28  law
// - bug fix: неправильно работала операция И (AND).
//
// Revision 1.19  2002/03/11 13:39:13  law
// - bug fix: неправильно работала операция И (AND).
//
// Revision 1.18  2002/03/11 13:28:54  law
// - bug fix: некорректно работала операция НО НЕ.
//
// Revision 1.17  2002/03/11 12:48:41  law
// - new behavior: сделан поиск по сложным формулам (без учета расстояния).
//
// Revision 1.16  2002/03/06 14:50:02  law
// no message
//
// Revision 1.15  2002/03/05 16:12:40  law
// - new behavior: реализован простейший поиск по полной базе документов.
//
// Revision 1.14  2002/03/01 10:06:50  law
// - new behavior: начата работа над указанием расстояния поиска.
//
// Revision 1.13  2001/12/26 18:26:22  law
// - bug fix: заточка под баг Delphi 5.
//
// Revision 1.12  2001/12/21 16:06:40  law
// - new behavior: при исключении выводится и маска.
//
// Revision 1.11  2001/12/21 15:44:58  law
// - bug fix.
//
// Revision 1.10  2001/12/21 15:35:31  law
// - new behavior: число слов при поиске по маске ограничено числом 20.
//
// Revision 1.9  2001/12/21 15:01:28  law
// - new behavior: освобождение ресурсов по мере вычисления формул.
//
// Revision 1.8  2001/12/21 13:12:42  law
// - new behavior: сделан поиск с учетом масок * и ?.
//
// Revision 1.7  2001/12/20 16:29:12  law
// - new behavior: сделан разбор масок * и ?.
//
// Revision 1.6  2001/12/19 16:54:10  law
// - bug fix: в операции следования терялась ситуация "еле еле" и т.п.
//
// Revision 1.5  2001/12/19 16:36:00  law
// - bug fix: в операции следования неправильно обрабатывалась ситуация с двумя одинаковыми словами.
//
// Revision 1.4  2001/12/19 16:28:39  law
// - comments: ToDo.
//
// Revision 1.3  2001/12/19 16:17:34  law
// - new behavior: реализована операция НО НЕ.
//
// Revision 1.2  2001/12/19 15:37:57  law
// - new behavior: сделаны поисковые операции ИЛИ и И.
//
// Revision 1.1  2001/12/11 13:32:39  law
// - new unit: m4Search.
//

{$Include m4Define.inc}

interface

uses
  SysUtils,
  
  l3Types,
  l3Base,
  l3Chars,
  l3ProtoObject,

  m3IdxInt,
  m3Index,
  m3DocumentAddress,

  m4DocumentAddress
  ;

type
  Tm4BaseExpression = class(Tl3ProtoObject)
   {* Базовое поисковое выражение. }
    public
    // public methods
      function Evaluate: String;
        virtual;
        {-}
      function GetElement(const aSearcher     : Im3IndexSearcher;
                          const aNormalizater : Im3Normalizater;
                          IsExtended          : Bool;
                          out theAddress      : Im4Address): Bool;
        virtual;
        {-}
  end;//Tm4BaseExpression

  Tm4SimpleExpression = class(Tm4BaseExpression)
   {* Простое (константное) поисковое выражение. }
    private
    // property fields
      f_Value    : String;
      f_CodePage : Long;
    public
    // public methods
      constructor Create(const aValue: String; aCodePage : Long = CP_OEM);
        reintroduce;
        {* - создает выражение. }
      function Evaluate: String;
        override;
        {-}
    public
    // public properties
      property Value: String
        read f_Value;
        {-}
  end;//Tm4SimpleExpression

  Tm4WordExpression = class(Tm4SimpleExpression)
    private
    // property fields
      f_Result        : Im3IndexSearcherResult;
      f_NeedNormalize : Bool;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aValue   : String;
                         aCodePage      : Long = CP_OEM;
                         aNeedNormalize : Bool = true);
        reintroduce;
        {* - создает выражение. }
      function GetElement(const aSearcher     : Im3IndexSearcher;
                          const aNormalizater : Im3Normalizater;
                          IsExtended          : Bool;
                          out theAddress      : Im4Address): Bool;
        override;
        {-}
  end;//Tm4WordExpression

  Tm4MaskExpression = class(Tm4SimpleExpression)
    private
    // property fields
      f_SubExpr : Tm4BaseExpression;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      function GetElement(const aSearcher     : Im3IndexSearcher;
                          const aNormalizater : Im3Normalizater;
                          IsExtended          : Bool;
                          out theAddress      : Im4Address): Bool;
        override;
        {-}
  end;//Tm4MaskExpression

  Tm4SearchOperation = (m4_soAnd, m4_soFollow, m4_soOr, m4_soAndNot);

  Tm4BinaryExpression = class(Tm4BaseExpression)
   {* Поисковое выражение с двумя параметрами. }
    private
    // internal fields
      f_Left      : Tm4BaseExpression;
      f_Right     : Tm4BaseExpression;
      f_Operation : Tm4SearchOperation;
      f_PrevLeft  : Im4Address;
      f_PrevRight : Im4Address;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure LoadNext(const aSearcher     : Im3IndexSearcher;
                         const aNormalizater : Im3Normalizater;
                         IsExtended          : Bool);
        {-}
      function DoGetElement(const aSearcher     : Im3IndexSearcher;
                            const aNormalizater : Im3Normalizater;
                            IsExtended          : Bool;
                            out theAddress      : Im4Address): Bool;
        virtual;
        {-}
      function GetDistanceString: String;
        virtual;
        {-}
    public
    // public methods
      constructor Create(anOp          : Tm4SearchOperation;
                         aLeft, aRight : Tm4BaseExpression);
        reintroduce;
        {* - создает выражение. }
      function Evaluate: String;
        override;
        {-}
      function GetElement(const aSearcher     : Im3IndexSearcher;
                          const aNormalizater : Im3Normalizater;
                          IsExtended          : Bool;
                          out theAddress      : Im4Address): Bool;
        override;
        {-}
    public
    // public properties
      property Left: Tm4BaseExpression
        read f_Left;
        {-}
      property Right: Tm4BaseExpression
        read f_Right;
        {-}
  end;//Tm4BinaryExpression

  Tm4DistanceExpression = class(Tm4BinaryExpression)
    protected
    // internal fields
      f_Distance : Long;
    protected
    // internal methods
      function GetDistanceString: String;
        override;
        {-}
    public
    // public methods
      constructor Create(anOp          : Tm4SearchOperation;
                         aLeft, aRight : Tm4BaseExpression;
                         aDistance     : Long);
        //reintroduce;
        {* - создает выражение. }
    public
    // public properties
      property Distance: Long
        read f_Distance;
        {* - расстояние поиска. }
  end;//Tm4DistanceExpression

  Tm4ANDExpression = class(Tm4DistanceExpression)
   {* Операция И. }
    protected
    // internal methods
      function DoGetElement(const aSearcher     : Im3IndexSearcher;
                            const aNormalizater : Im3Normalizater;
                            IsExtended          : Bool;
                            out theAddress      : Im4Address): Bool;
        override;
        {-}
  end;//Tm4ANDExpression

  Tm4FollowExpression = class(Tm4DistanceExpression)
   {* Операция следования. }
    protected
    // internal methods
      function DoGetElement(const aSearcher     : Im3IndexSearcher;
                            const aNormalizater : Im3Normalizater;
                            IsExtended          : Bool;
                            out theAddress      : Im4Address): Bool;
        override;
        {-}
  end;//Tm4FollowExpression

  Em4SearchCanceled = class(Exception);

function CreateBinaryOp(anOp       : Tm4SearchOperation;
                        var aLeft  : Tm4BaseExpression;
                        var aRight : Tm4BaseExpression;
                        aDistance  : Long = 0): Tm4BinaryExpression;
  {-}

implementation

uses
  Math,

  l3String,

  afwFacade,
  
  m4SearchConst
  ;

// start class Tm4BaseExpression

function Tm4BaseExpression.Evaluate: String;
  //virtual;
  {-}
begin
 Result := '';
end;

function Tm4BaseExpression.GetElement(const aSearcher     : Im3IndexSearcher;
                                      const aNormalizater : Im3Normalizater;
                                      IsExtended          : Bool;
                                      out theAddress      : Im4Address): Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

// start class Tm4WordExpression

constructor Tm4WordExpression.Create(const aValue   : String;
                                     aCodePage      : Long = CP_OEM;
                                     aNeedNormalize : Bool = true);
  //reintroduce;
  {* - создает выражение. }
begin
 inherited Create(aValue, aCodePage);
 f_NeedNormalize := aNeedNormalize;
end;

procedure Tm4WordExpression.Cleanup;
  //override;
  {-}
begin
 f_Result := nil;
 inherited;
end;

function Tm4WordExpression.GetElement(const aSearcher     : Im3IndexSearcher;
                                      const aNormalizater : Im3Normalizater;
                                      IsExtended          : Bool;
                                      out theAddress      : Im4Address): Bool;
  //override;
  {-}
var
 l_Address : Tm3DocumentAddress;
 {$IfDef m4DebugSearch}
 l_Now     : TDateTime;
 {$EndIf m4DebugSearch}
begin
 if (f_Result = nil) then begin
  {$IfDef m4DebugSearch}
  l_Now := Now;
  {$EndIf m4DebugSearch}
  if f_NeedNormalize then
   f_Result := aSearcher.GetResult(aNormalizater,
                                   l3ChangeCodePage(Value, f_CodePage, CP_ANSI))
  else
   f_Result := aSearcher.GetResult(nil,
                                   l3ChangeCodePage(Value, f_CodePage, CP_ANSI));
  {$IfDef m4DebugSearch}
  WriteLn(l3ChangeCodePage('Время поиска вхождений "', CP_ANSI, CP_OEM) +
          l3ChangeCodePage(Value, f_CodePage, CP_OEM) + '" ' +
          TimeToStr(Now - l_Now));
  WriteLn(l3ChangeCodePage('Число вхождений:', CP_ANSI, CP_OEM) +
          IntToStr(f_Result.GetCount));
  {$EndIf m4DebugSearch}
 end;//f_Result = nil
 if (f_Result = nil) then
  Result := false
 else if IsExtended then
  Result := f_Result.Get(@l_Address, SizeOf(Tm3DocumentAddress))
 else begin
  Result := f_Result.Get(@l_Address, SizeOf(Tm3WordAddress));
  l_Address.rDocument := 0;
 end;//f_Result = nil
 if Result then
  theAddress := Tm4Address.Make(l_Address)
 else
  f_Result := nil;
end;

// start class Tm4SimpleExpression

constructor Tm4SimpleExpression.Create(const aValue : String;
                                       aCodePage    : Long = CP_OEM);
  //reintroduce;
  {* - создает выражение. }
begin
 inherited Create;
 f_Value := aValue;
 f_CodePage := aCodePage;
end;

function Tm4SimpleExpression.Evaluate: String;
  //override;
  {-}
begin
 Result := f_Value;
end;

// start class Tm4BinaryExpression

constructor Tm4BinaryExpression.Create(anOp          : Tm4SearchOperation;
                                       aLeft, aRight : Tm4BaseExpression);
  //reintroduce;
  {* - создает выражение. }
begin
 inherited Create;
 f_Operation := anOp;
 l3Set(f_Left, aLeft);
 l3Set(f_Right, aRight);
 f_PrevLeft := m4NullDocumentAddress;
 f_PrevRight := m4NullDocumentAddress;
end;

procedure Tm4BinaryExpression.Cleanup;
  //override;
  {-}
begin
 f_PrevLeft := nil;
 f_PrevRight := nil;
 l3Free(f_Left);
 l3Free(f_Right);
 inherited;
end;

function Tm4BinaryExpression.Evaluate: String;
  //override;
  {-}
var
 l_DistanceString : String;  
begin
 Result := f_Left.Evaluate;
 Case f_Operation of
  m4_soAnd    : Result := Result + '&';
  m4_soFollow : Result := Result + ':';
  m4_soOr     : Result := Result + '|';
  m4_soAndNot : Result := Result + '~';
 end;//Case f_Operation
 l_DistanceString := GetDistanceString;
 if (l_DistanceString = '') then
  Result := Result + f_Right.Evaluate
 else
  Result := Result + l_DistanceString + ' ' + f_Right.Evaluate;
end;

procedure Tm4BinaryExpression.LoadNext(const aSearcher     : Im3IndexSearcher;
                                       const aNormalizater : Im3Normalizater;
                                       IsExtended          : Bool);
  {-}
begin
 if f_PrevLeft.EQ(m3NullDocumentAddress) then
  if (Left = nil) OR not Left.GetElement(aSearcher, aNormalizater, IsExtended, f_PrevLeft) then
   f_PrevLeft := Tm4Address.Make(m3StopWordAddress);
 if f_PrevRight.EQ(m3NullDocumentAddress) then
  if (Right = nil) OR not Right.GetElement(aSearcher, aNormalizater, IsExtended, f_PrevRight) then
   f_PrevRight := Tm4Address.Make(m3StopWordAddress);
end;

function Tm4BinaryExpression.DoGetElement(const aSearcher     : Im3IndexSearcher;
                                          const aNormalizater : Im3Normalizater;
                                          IsExtended          : Bool;
                                          out theAddress      : Im4Address): Bool;
  //virtual;
  {-}

 procedure _GetNext;
 begin//_GetNext
  LoadNext(aSearcher, aNormalizater, IsExtended);
 end;//_GetNext

 procedure _OROp;
 begin//_OROp
  _GetNext;
  Case f_PrevLeft.CaseCompare(f_PrevRight) of
   -1 : begin
    // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
    theAddress := f_PrevLeft;
    Result := true;
    f_PrevLeft := m4NullDocumentAddress;
   end;//-1
   0 : begin
    theAddress := f_PrevLeft;
    if not theAddress.EQ(m3StopWordAddress) then begin
     f_PrevLeft  := m4NullDocumentAddress;
     f_PrevRight := m4NullDocumentAddress;
     Result := true;
    end;//not theAddress.EQ(m3StopWordAddress)
   end;//0
   +1 : begin
    // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
    theAddress := f_PrevRight;
    Result := true;
    f_PrevRight := m4NullDocumentAddress;
   end;//+1
  end;//Case f_PrevLeft.CaseCompare..
 end;//_OROp

 procedure _ANDNotOp;
  // - надо учитывать, что операция несимметричная - интересует только левый операнд
 begin//_ANDNotOp
  repeat
   _GetNext;
   Case f_PrevLeft.CaseHighCompare(f_PrevRight) of
    -1 : begin
     // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
     theAddress := f_PrevLeft;
     Result := true;
     f_PrevLeft := m4NullDocumentAddress;
     // - надо выбрать следующий левый операнд
     break;
    end;//-1
    0 : begin
     if not f_PrevLeft.EQ(m3StopWordAddress) then begin
      repeat
       f_PrevLeft  := m4NullDocumentAddress;
       // - надо выбрать следующий левый операнд
       _GetNext;
       if f_PrevLeft.EQ(m3StopWordAddress) then
        Exit // - выходим из верхнего цикла - в нашей формуле уже не осталось результатов
       else if (f_PrevLeft.CaseHighCompare(f_PrevRight) > 0) then
        break; // - перебрали все ненужные документы
      until false;
      f_PrevRight := m4NullDocumentAddress;
      //not theAddress.EQ(m3StopWordAddress)
     end else
      break;
    end;//0
    +1 : begin
     // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
     f_PrevRight := m4NullDocumentAddress;
     // - надо выбрать следующий правый операнд
    end;//+1
   end;//Case f_PrevLeft.CaseHighCompare..
  until false;
 end;//_ANDNotOp

 procedure _ExtendedANDNotOp;
  // - надо учитывать, что операция несимметричная - интересует только левый операнд
 begin//_ExtendedANDNotOp
  repeat
   _GetNext;
   Case Sign(f_PrevLeft.Address.rDocument - f_PrevRight.Address.rDocument) of
    -1 : begin
     // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
     theAddress := f_PrevLeft;
     Result := true;
     f_PrevLeft := m4NullDocumentAddress;
     // - надо выбрать следующий левый операнд
     break;
    end;//-1
    0 : begin
     if not f_PrevLeft.EQ(m3StopWordAddress) then begin
      repeat
       f_PrevLeft  := m4NullDocumentAddress;
       // - надо выбрать следующий левый операнд
       _GetNext;
       if f_PrevLeft.EQ(m3StopWordAddress) then
        Exit // - выходим из верхнего цикла - в нашей формуле уже не осталось результатов
       else if (f_PrevLeft.Address.rDocument > f_PrevRight.Address.rDocument) then
        break; // - перебрали все ненужные документы
      until false;
      f_PrevRight := m4NullDocumentAddress;
      //not theAddress.EQ(m3StopWordAddress)
     end else
      break;
    end;//0
    +1 : begin
     // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
     f_PrevRight := m4NullDocumentAddress;
     // - надо выбрать следующий правый операнд
    end;//+1
   end;//Case f_PrevLeft.CaseHighCompare..
  until false;
 end;//_ExtendedANDNotOp

begin
 Result := false;
 Case f_Operation of
  m4_soAndNot :
   if IsExtended then
    _ExtendedANDNotOp
   else
    _ANDNOTOp;
  else _OROp;
 end;//Case f_Operation
end;

function Tm4BinaryExpression.GetDistanceString: String;
  //virtual;
  {-}
begin
 Result := '';
end;

function Tm4BinaryExpression.GetElement(const aSearcher     : Im3IndexSearcher;
                                        const aNormalizater : Im3Normalizater;
                                        IsExtended          : Bool;
                                        out theAddress      : Im4Address): Bool;
  //override;
  {-}

begin
 Result := DoGetElement(aSearcher, aNormalizater, IsExtended, theAddress);
 if not Result then begin
  l3Free(f_Left);
  l3Free(f_Right);
 end;//not Result
end;

function CreateBinaryOp(anOp       : Tm4SearchOperation;
                        var aLeft  : Tm4BaseExpression;
                        var aRight : Tm4BaseExpression;
                        aDistance  : Long = 0): Tm4BinaryExpression;
  {-}
begin
 Case anOp of
  m4_soAND:
   Result := Tm4ANDExpression.Create(anOp, aLeft, aRight, aDistance);
  m4_soFollow:
   Result := Tm4FollowExpression.Create(anOp, aLeft, aRight, aDistance);
  else
   Result := Tm4BinaryExpression.Create(anOp, aLeft, aRight);
 end;//Case anOp
 l3Free(aLeft);
 l3Free(aRight);
end;

// start class Tm4MaskExpression

procedure Tm4MaskExpression.Cleanup;
  //override;
  {-}
begin
 l3Free(f_SubExpr);
 inherited;
end;

function Tm4MaskExpression.GetElement(const aSearcher     : Im3IndexSearcher;
                                      const aNormalizater : Im3Normalizater;
                                      IsExtended          : Bool;
                                      out theAddress      : Im4Address): Bool;
  //override;
  {-}
const
 l_MaxCount = 20;
 l_Msg = 'Количество слов с маской "%s" (%d) больше %d. %s';
var
 l_Count : Long;
 l_Words : Im3NormalizaterResult;
 l_Index : Long;
 l_Word  : String;
 l_Expr  : Tm4BaseExpression;
begin
 Result := false;
 if (f_SubExpr = nil) then begin
  f_Value := l3ChangeCodePage(Value, f_CodePage, CP_ANSI);
  f_CodePage := CP_ANSI;
  l_Words := aSearcher.GetWordsByMask(Value);
  try
   if (l_Words <> nil) then begin
    with l_Words do begin
     l_Count := GetCount;
     if (l_Count > l_MaxCount) then
     begin
      if (afw.Application <> nil) AND (afw.Application.UserQuery <> nil) AND
         not afw.Application.UserQuery.Ask(Format(l_Msg, [Value, l_Count, l_MaxCount, 'Продолжать поиск?'])) then
      raise Em4SearchCanceled.CreateFmt(l_Msg, [Value, l_Count, l_MaxCount, '']);
     end;//l_Count > l_MaxCount
     for l_Index := 0 to Pred(l_Count) do begin
      l_Word := GetValue;
      if (l_Word <> '') then begin
       if (f_SubExpr = nil) then
        f_SubExpr := Tm4WordExpression.Create(l_Word, CP_ANSI, false)
       else begin
        l_Expr := Tm4WordExpression.Create(l_Word, CP_ANSI, false);
        try
         f_SubExpr := CreateBinaryOp(m4_soOR, f_SubExpr, l_Expr);
        finally
         l3Free(l_Expr);
        end;//try..finally
       end;//f_SubExpr = nil
      end;//l_Word <> ''
     end;//for l_Index..
    end;//with l_Words 
   end;//l_Words <> nil..
  finally
   l_Words := nil;
  end;//try..finally
 end;//f_SubExpr = nil
 if (f_SubExpr <> nil) then
  Result := f_SubExpr.GetElement(aSearcher, aNormalizater, IsExtended, theAddress);
 if not Result then
  l3Free(f_SubExpr); 
end;

// start class Tm4ANDExpression

function Tm4ANDExpression.DoGetElement(const aSearcher     : Im3IndexSearcher;
                                       const aNormalizater : Im3Normalizater;
                                       IsExtended          : Bool;
                                       out theAddress      : Im4Address): Bool;
  //override;
  {-}
  
 procedure _GetNext;
 begin//_GetNext
  LoadNext(aSearcher, aNormalizater, IsExtended);
 end;//_GetNext

 procedure _ANDOp;
 begin//_ANDOp
  repeat
   _GetNext;
   Case f_PrevLeft.CaseHighCompare(f_PrevRight) of
    -1 : begin
     // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
     f_PrevLeft := m4NullDocumentAddress;
     // - надо выбрать следующий левый операнд
    end;//-1
    0 : begin
     Result := true;
     Case f_PrevLeft.CaseLowCompare(f_PrevRight) of
      -1 : begin
       theAddress := f_PrevLeft;
       f_PrevLeft := m4NullDocumentAddress;
       // - надо выбрать следующий левый операнд
      end;//-1
      0 : begin
       theAddress := f_PrevLeft;
       if theAddress.EQ(m3StopWordAddress) then
        Result := false
       else begin
        f_PrevLeft  := m4NullDocumentAddress;
        f_PrevRight := m4NullDocumentAddress;
        // - надо выбрать оба операнда
        Result := true;
       end;//not theAddress.EQ(m3StopWordAddress)
      end;//0
      +1 : begin
       theAddress := f_PrevRight;
       f_PrevRight := m4NullDocumentAddress;
       // - надо выбрать следующий правый операнд
      end;//+1
     end;//Case f_PrevLeft.CaseLowCompare(
     break;
    end;//0
    +1 : begin
     // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
     f_PrevRight := m4NullDocumentAddress;
     // - надо выбрать следующий правый операнд
    end;//+1
   end;//Case f_PrevLeft.CaseHighCompare..
  until false;
 end;//_ANDOp

 procedure _ExtendedANDOp;
 var
  l_Dist : Long;
 begin//_ExtendedANDOp
  repeat
   _GetNext;
   Case Sign(f_PrevLeft.Address.rDocument - f_PrevRight.Address.rDocument) of
    -1 : begin
     // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
     f_PrevLeft := m4NullDocumentAddress;
     // - надо выбрать следующий левый операнд
    end;//-1
    0 : begin
     if (Distance = 0) OR (Distance = m4InDocument) then begin
      Result := true;
      Case f_PrevLeft.CaseCompare(f_PrevRight) of
       -1 : begin
        theAddress := f_PrevLeft;
        f_PrevLeft := m4NullDocumentAddress;
        // - надо выбрать следующий левый операнд
        theAddress.LinkAddress(f_PrevRight);
       end;//-1
       0 : begin
        theAddress := f_PrevLeft;
        if theAddress.EQ(m3StopWordAddress) then
         Result := false
        else begin
         f_PrevLeft  := m4NullDocumentAddress;
         f_PrevRight := m4NullDocumentAddress;
         // - надо выбрать оба операнда
        end;//theAddress.EQ(m3StopWordAddress)
       end;//0
       +1 : begin
        theAddress := f_PrevRight;
        f_PrevRight := m4NullDocumentAddress;
        // - надо выбрать следующий правый операнд
        theAddress.LinkAddress(f_PrevLeft);
       end;//+1
      end;//Case f_PrevLeft.CaseCompare(
      break;
     end else begin
      if (Distance = m4InPara) OR (Distance = m4InSentence) then begin
       Case f_PrevLeft.CaseHighCompare(f_PrevRight) of
        -1 : begin
         theAddress := f_PrevLeft;
         f_PrevLeft := m4NullDocumentAddress;
         // - надо выбрать следующий левый операнд
         //theAddress.LinkAddress(f_PrevRight);
        end;//-1
        0 : begin
         theAddress := f_PrevLeft;
         if theAddress.EQ(m3StopWordAddress) then
          Result := false
         else begin
          theAddress.LinkAddress(f_PrevRight);
          f_PrevLeft  := m4NullDocumentAddress;
          f_PrevRight := m4NullDocumentAddress;
          // - надо выбрать оба операнда
          Result := true;
         end;//..m3StopWordAddress..
         break;
        end;//0
        +1 : begin
         theAddress := f_PrevRight;
         f_PrevRight := m4NullDocumentAddress;
         // - надо выбрать следующий правый операнд
         //theAddress.LinkAddress(f_PrevLeft);
        end;//+1
       end;//Case f_PrevLeft.CaseHighCompare(..
      end else begin
       l_Dist := f_PrevLeft.Address.rPara - f_PrevRight.Address.rPara;
       if (Abs(l_Dist) = Distance) then begin
        if (l_Dist < 0) then begin
         theAddress := f_PrevRight;
         // - возвращаем правый адрес для корректной следующей операции следования
         // !!! - здесь надо не забыть про то куда девать левый операнд !!!
         theAddress.LinkAddress(f_PrevLeft);
        end else begin
         theAddress := f_PrevLeft;
         // - возвращаем левый адрес для корректной следующей операции следования
         // !!! - здесь надо не забыть про то куда девать правый операнд !!!
         theAddress.LinkAddress(f_PrevRight);
        end;//l_Dist < 0
        Result := true;
        f_PrevLeft  := m4NullDocumentAddress;
        f_PrevRight := m4NullDocumentAddress;
        break;
        //Abs(l_Dist) = Distance
       end else if (l_Dist = 0) then begin
        // - это одно и то же слово
        if not f_PrevLeft.EQ(m3StopWordAddress) then begin
         // - не достигли конца
         f_PrevRight := m4NullDocumentAddress;
         // - выбираем дальше правое слово, а левое пока трогать не надо
         //not theAddress.EQ(m3StopWordAddress)
        end else
         break;
       end else if (l_Dist < 0) then
        f_PrevLeft := m4NullDocumentAddress
        // - надо выбрать следующий левый операнд
        //l_Dist <= 0
       else
         f_PrevRight := m4NullDocumentAddress;
        // - надо выбрать следующий правый операнд
        //l_Dist <= 0
      end;//Distance = m4InPara..
     end;//Distance = 0
    end;//0
    +1 : begin
     // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
     f_PrevRight := m4NullDocumentAddress;
     // - надо выбрать следующий правый операнд
    end;//+1
   end;//Case f_PrevLeft.CaseHighCompare..
  until false;
 end;//_ExtendedANDOp

begin
 Result := false;
 if IsExtended then
  _ExtendedANDOp
 else
  _ANDOp;
end;

// start class Tm4DistanceExpression

constructor Tm4DistanceExpression.Create(anOp          : Tm4SearchOperation;
                                         aLeft, aRight : Tm4BaseExpression;
                                         aDistance     : Long);
  //reintroduce;
  {* - создает выражение. }
begin
 inherited Create(anOp, aLeft, aRight);
 f_Distance := aDistance;
end;

function Tm4DistanceExpression.GetDistanceString: String;
  //override;
  {-}
begin
 if (f_Distance = 0) then
  Result := inherited GetDistanceString
 else if (f_Distance > 0) then
  Result := IntToStr(f_Distance)
 else if (f_Distance < 0) then
  Case f_Distance of
   m4InSentence : Result := 'S';
   m4InPara     : Result := 'A';
   m4InDocument : Result := 'D';
   else
    Result := inherited GetDistanceString;
  end;//Case f_Distance
end;

// start class Tm4FollowExpression

function Tm4FollowExpression.DoGetElement(const aSearcher     : Im3IndexSearcher;
                                          const aNormalizater : Im3Normalizater;
                                          IsExtended          : Bool;
                                          out theAddress      : Im4Address): Bool;
  //override;
  {-}
  
 procedure _GetNext;
 begin//_GetNext
  LoadNext(aSearcher, aNormalizater, IsExtended);
 end;//_GetNext

 procedure _FollowOp;
 var
  l_Dist : Long;
 begin//_FollowOp
  repeat
   _GetNext;
   Case f_PrevLeft.CaseHighCompare(f_PrevRight) of
    -1 : begin
     // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
     if f_PrevRight.EQ(m3StopWordAddress) then
      break
     else
      f_PrevLeft := m4NullDocumentAddress;
     // - надо выбрать следующий левый операнд
    end;//-1
    0 : begin
     l_Dist := f_PrevLeft.LowCompare(f_PrevRight);
     if (l_Dist = -1) then begin
      theAddress := f_PrevRight;
      // - возвращаем правый адрес для корректной следующей операции следования
      // !!! - здесь надо не забыть про то куда девать левый операнд !!!
      theAddress.LinkAddress(f_PrevLeft);
      Result := true;
      f_PrevLeft  := m4NullDocumentAddress;
      f_PrevRight := m4NullDocumentAddress;
      break;
      //l_Dist = -1
     end else if (l_Dist = 0) then begin
      // - это одно и то же слово
      if not f_PrevLeft.EQ(m3StopWordAddress) then begin
       // - не достигли конца
       f_PrevRight := m4NullDocumentAddress;
       // - выбираем дальше правое слово, а левое пока трогать не надо
       //not theAddress.EQ(m3StopWordAddress)
      end else
       break;
     end else if (l_Dist < 0) then 
      f_PrevLeft := m4NullDocumentAddress
      // - надо выбрать следующий левый операнд
      //l_Dist <= 0
     else
       f_PrevRight := m4NullDocumentAddress;
      // - надо выбрать следующий правый операнд
      //l_Dist <= 0
    end;//0
    +1 : begin
     // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
     if f_PrevLeft.EQ(m3StopWordAddress) then
      break
     else
      f_PrevRight := m4NullDocumentAddress;
     // - надо выбрать следующий правый операнд
    end;//+1
   end;//Case f_PrevLeft.CaseHighCompare..
  until false; 
 end;//_FollowOp

 procedure _ExtendedFollowOp;
 var
  l_Dist : Long;
 begin//_ExtendedFollowOp
  repeat
   _GetNext;
   Case Sign(f_PrevLeft.Address.rDocument - f_PrevRight.Address.rDocument) of
    -1: begin
     // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
     if f_PrevRight.EQ(m3StopWordAddress) then
      break
     else
      f_PrevLeft := m4NullDocumentAddress;
     // - надо выбрать следующий левый операнд
    end;//-1
    0: begin
     if (Distance = m4InDocument) then begin
      // - следование в документе
      Case f_PrevLeft.CaseCompare(f_PrevRight) of
       -1 : begin
        if not f_PrevRight.EQ(m3StopWordAddress) then begin
         theAddress := f_PrevRight;
         // - возвращаем правый адрес для корректной следующей операции следования
         // !!! - здесь надо не забыть про то куда девать левый операнд !!!
         theAddress.LinkAddress(f_PrevLeft);
         Result := true;
         f_PrevLeft  := m4NullDocumentAddress;
         f_PrevRight := m4NullDocumentAddress;
        end;//not f_PrevRight.EQ(m3StopWordAddress)
        break;
       end;//-1
       0 : begin
        // - это одно и то же слово
        if not f_PrevLeft.EQ(m3StopWordAddress) then begin
         // - не достигли конца
         f_PrevRight := m4NullDocumentAddress;
         // - выбираем дальше правое слово, а левое пока трогать не надо
         //not theAddress.EQ(m3StopWordAddress)
        end else
         break;
       end;//0
       +1 : begin
        // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
        if f_PrevLeft.EQ(m3StopWordAddress) then
         break
        else
         f_PrevRight := m4NullDocumentAddress;
        // - надо выбрать следующий правый операнд
       end;//+1
      end;//Case f_PrevLeft.CaseCompare(f_PrevRight)
     end else
      Case f_PrevLeft.CaseHighCompare(f_PrevRight) of
       -1 : begin
        // - если f_PrevLeft.EQ(m3StopWordAddress) - то сюда попасть не можем
        if f_PrevRight.EQ(m3StopWordAddress) then
         break
        else
         f_PrevLeft := m4NullDocumentAddress;
        // - надо выбрать следующий левый операнд
       end;//-1
       0 : begin
        l_Dist := f_PrevLeft.LowCompare(f_PrevRight);
        if (l_Dist < 0) AND (l_Dist >= -Succ(Distance)) then begin
         theAddress := f_PrevRight;
         // - возвращаем правый адрес для корректной следующей операции следования
         // !!! - здесь надо не забыть про то куда девать левый операнд !!!
         theAddress.LinkAddress(f_PrevLeft);
         Result := true;
         f_PrevLeft  := m4NullDocumentAddress;
         f_PrevRight := m4NullDocumentAddress;
         break;
         //l_Dist = -1
        end else if (l_Dist = 0) then begin
         // - это одно и то же слово
         if not f_PrevLeft.EQ(m3StopWordAddress) then begin
          // - не достигли конца
          f_PrevRight := m4NullDocumentAddress;
          // - выбираем дальше правое слово, а левое пока трогать не надо
          //not theAddress.EQ(m3StopWordAddress)
         end else
          break;
        end else if (Distance = m4InPara) OR (Distance = m4InSentence) then begin
         // - ищем в пределах абзаца
         if (l_Dist < 0) then begin
          Result := true;
          theAddress := f_PrevRight;
          theAddress.LinkAddress(f_PrevLeft);
          f_PrevLeft  := m4NullDocumentAddress;
          f_PrevRight := m4NullDocumentAddress;
          //l_Dist <= 0
          break;
         end else
          f_PrevRight := m4NullDocumentAddress;
          // - выбираем дальше правое слово, а левое пока трогать не надо
        end else if (l_Dist < 0) then
         f_PrevLeft := m4NullDocumentAddress
         // - надо выбрать следующий левый операнд
         //l_Dist <= 0
        else
          f_PrevRight := m4NullDocumentAddress;
         // - надо выбрать следующий правый операнд
         //l_Dist <= 0
       end;//0
       +1 : begin
        // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
        if f_PrevLeft.EQ(m3StopWordAddress) then
         break
        else
         f_PrevRight := m4NullDocumentAddress;
        // - надо выбрать следующий правый операнд
       end;//+1
      end;//Case f_PrevLeft.CaseHighCompare..
    end;//0
    +1: begin
     // - если f_PrevRight.EQ(m3StopWordAddress) - то сюда попасть не можем
     if f_PrevLeft.EQ(m3StopWordAddress) then
      break
     else
      f_PrevRight := m4NullDocumentAddress;
     // - надо выбрать следующий правый операнд
    end;//+1
   end;//Case Sign(f_PrevLeft.rDocument - f_PrevRight.rDocument)..
  until false;
 end;//_ExtendedFollowOp

begin
 Result := false;
 if IsExtended then
  _ExtendedFollowOp
 else
  _FollowOp;
end;

end.

