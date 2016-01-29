unit ExprMake;

{ $Id: ExprMake.pas,v 1.44 2014/02/25 14:32:21 lulin Exp $ }

// $Log: ExprMake.pas,v $
// Revision 1.44  2014/02/25 14:32:21  lulin
// - конкретизируем тип выражения.
//
// Revision 1.43  2013/04/11 14:53:56  lulin
// - портируем.
//
// Revision 1.42  2013/04/04 11:33:59  lulin
// - портируем.
//
// Revision 1.41  2012/03/06 15:14:25  dinishev
// {Requestlink:343640765}. Страхуемся от Assert'ов при разборе формулы.
//
// Revision 1.40  2012/03/06 13:18:20  dinishev
// {Requestlink:343640765}
//
// Revision 1.39  2010/10/08 17:13:43  lulin
// {RequestLink:235870994}.         
// - [$235871850].
//
// Revision 1.38  2010/04/02 15:19:01  lulin
// {RequestLink:100008248}.
// - типа упрощаем код.
//
// Revision 1.36  2010/04/02 14:52:49  lulin
// {RequestLink:100008248}.
//
// Revision 1.35  2010/04/01 13:11:52  fireton
// - позволяем пробелы в формулах
//
// Revision 1.34  2010/03/31 14:13:21  lulin
// {RequestLink:200084559}.
// - передаём эффективную позицию "символа".
//
// Revision 1.33  2010/03/31 13:57:05  lulin
// {RequestLink:200084559}.
// - добавлена поддержка оператора "строка".
//
// Revision 1.32  2010/03/31 13:46:59  lulin
// {RequestLink:200084559}.
//
// Revision 1.31  2010/02/18 07:55:54  fireton
// - SystemR (система с правой фигурной скобкой)
//
// Revision 1.30  2009/11/23 11:14:28  fireton
// - ошибка при конвертации целого числа
//
// Revision 1.29  2008/07/15 18:32:31  lulin
// - рефакторинг отрисовки формул - код обобщён.
//
// Revision 1.28  2008/06/28 18:59:37  lulin
// - убрано дублирование констант.
//
// Revision 1.26  2008/06/28 18:10:30  lulin
// - используем массив преобразований.
//
// Revision 1.25  2008/06/28 17:37:06  lulin
// - используем массив преобразований.
//
// Revision 1.24  2008/06/28 17:20:26  lulin
// - используем константы.
//
// Revision 1.23  2008/06/28 17:11:44  lulin
// - безликие константы переводим на перечислимый тип.
//
// Revision 1.22  2008/06/28 16:14:30  lulin
// - безликие константы переводим на перечислимый тип.
//
// Revision 1.20  2008/06/28 15:50:36  lulin
// - причёсываем код.
// - добавлены оборотные операторы вкючения.
//
// Revision 1.19  2008/06/28 15:01:17  lulin
// - причёсываем код.
//
// Revision 1.18  2008/06/28 14:40:05  lulin
// - причёсываем код.
//
// Revision 1.16  2008/06/27 22:25:26  lulin
// - минимизируем переборы.
//
// Revision 1.15  2008/06/27 22:18:34  lulin
// - с динамического массива переделал на "родной" список целых чисел.
//
// Revision 1.14  2008/06/27 21:53:27  lulin
// - препроцессор преобразует строку в последовательность целых чисел, чтобы можно было расширять набор нетерминальных символов.
//
// Revision 1.13  2008/06/27 20:17:08  lulin
// - добавлена Юникодная строка.
//
// Revision 1.12  2008/06/27 20:02:59  lulin
// - добавлен диаметр и диакритические " и '.
// - добавлена возможность явно указать Юникод - #@.
//
// Revision 1.11  2008/06/27 15:58:11  lulin
// - <K>: 95489947.
//
// Revision 1.10  2008/06/27 14:07:20  lulin
// - <K>: 95489730.
//
// Revision 1.9  2008/01/15 17:09:55  lulin
// - cleanup.
//
// Revision 1.8  2007/11/16 13:30:55  fireton
// + функция Circle() - диакретический кружочек
//
// Revision 1.7  2007/10/22 10:11:16  lulin
// - изменил имя базового класса.
//
// Revision 1.6  2007/10/17 11:00:48  voba
// - bug fix (строrа 'F<=' приводила к integer overflow)
//
// Revision 1.5  2007/10/11 13:54:08  fireton
// - делаем отступы при отрисовке формул (нивелируем разницу между рассчитаным и реальным размерами)
//
// Revision 1.4  2007/07/23 05:20:47  oman
// warning fix
//
// Revision 1.3  2007/06/25 09:39:26  fireton
// - при ошибке разбора выражения теперь передается позиция, в которой она произошла
// - bug fix: memory leak при проверке выражений со степенями
//
// Revision 1.2  2002/12/15 11:56:56  law
// no message
//

{$I l3Define.inc }

interface

uses
  SysUtils,

  l3Types,
  l3Interfaces,
  l3Base,
  l3LongintList,

  ExprDraw,
  exprTokensList
  ;

type
  Tl3StringEx = class(TexprTokensList)
    public
    // public methods
      procedure Add(aChar: Integer; aPos : Integer);
        overload;
        {-}
      procedure Add(aChar: AnsiChar; aPos : Integer);
        overload;
        {-}
      procedure Add(anOp: TOp; var I: Integer);
        overload;
        {-}
      procedure Add(anOp: TMyOp; aPos : Integer);
        overload;
        {-}
      procedure Add(anOp: TMyOp; var aPos : Integer; anInc : Integer);
        overload;
        {-}
      procedure Add(const aString: AnsiString; aPos : Integer);
        overload;
        {-}
      procedure Add(anOp: TMyOp; aPos : Integer; const aString: Il3CString);
        overload;
        {-}
  end;//Tl3StringEx

  TeNeed = (
   EChain,
   EExpression,
   EBracketed,
   EArgument,
   EPower,
   EAbs,
   ESquared,
   EFigured
  );//TeNeed

  TOpSet = set of TOp;

  TMyOpSet = set of TMyOp;

  TExprBuilder = class(Tl3Base)
    private
    // internal fields
      P  : Integer;
      _S : Tl3StringEx;
    private
      procedure RaiseError(aMessage: AnsiString; aPosition: Integer);
      function SL: Integer;
      function SP: Integer;
      function SPis(aChar: TOp): Boolean;
        overload;
      function SPis(aChar: AnsiChar): Boolean;
        overload;
      function SPinc(aSet   : TCharset;
                     anOps  : TOpSet = [];
                     aMyOps : TMyOpSet = []): Boolean;
      function SCopy(aCount: Integer = High(Integer)): AnsiString;
      function SCopyFrom(aPos: Integer; aCount: Integer = High(Integer)): AnsiString;
      function iSVal: Integer;
        {-}
      function eSVal: Extended;
        {-}
    protected
      Build:Boolean;
      procedure Preprocess(const S: AnsiString);
      procedure AddMult(var Existing:Tl3Expr;Multiplier:Tl3Expr);
      function MakePower(Base,Exponent:Tl3Expr):Tl3Expr;
      function MakeIndex(Base,Index:Tl3Expr):Tl3Expr;
      function MakeCap(Base:Tl3Expr;Style:TExprCapStyle;N:Integer):Tl3Expr;
      procedure Decorate(var Base:Tl3Expr);
      function ExprString(Need : TeNeed; AllowComma : Boolean=False): Tl3Expr;
      function BoolExpr(out Flags:Integer):Tl3Expr;
      function Expr(out Flags:Integer):Tl3Expr;
      function Factor: Tl3Expr;
        overload;
      function Factor(out Flags:Integer): Tl3Expr;
        overload;
      function Trans(out Flags : Integer): Tl3Expr;
      function Func(var Flags : Integer): Tl3Expr;
      function FuncName(const aName : AnsiString;
                        out Flags   : Integer;
                        Brackets    : Boolean):Tl3Expr;
      function Token(const N:AnsiString):Tl3Expr;
      function GreekLetter(const N: AnsiString):Integer;
      function Comma:Boolean;
      procedure LookForComma;
      procedure Cleanup;
        override;
        {-}
    public
      FuncAutoIndex,VarAutoIndex,PostSymbols:Boolean;
      constructor Create; reintroduce;
      function SafeBuildExpr(const anExpr : AnsiString): Tl3Expr;
  end;//TExprBuilder

  EIncorrectExpr = class(Exception)
    public
      constructor Create(const aMessage: AnsiString; aPosition: Integer);
        reintroduce;
        {-}
    private
      f_Position: Integer;
    public
      property Position: Integer
        read f_Position;
  end;//EIncorrectExpr
  
const
  OpCode : array [TOp] of Integer = (
   0,
   esNotEqual,       // <> - не равно                         1
   esGreaterOrEqual, // >= - больше или равно                 2
   esLessOrEqual,    // <= - меньше или равно                 3
   esMuchGreater,    // >> - много больше                     4
   esMuchLess,       // << - много меньше                     5
   esArrow,          // -> - стрелка (стремится к пределу)    6
   esApproxEqual,    // ~~ - примерно равно                   7
   esPlusMinus,      // +- - плюс-минус                       8
   esMinusPlus,      // -+ - минус-плюс                       9
   esEquivalent,     // == - тождественно                     10
   esDivide,         // /+ - знак "минус с точкой снизу и точкой сверху" 11
   esCrossMultiply,  // *+ - косой крест                      12
   esEllipsis,       // ... - эллипсис                        13
   esApproxGreater,  // >~ - больше или порядка               14
   esApproxLess,     // <~ - меньше или порядка               15
   esSlash,          // // - делить символом "/", без дроби   16
   0,                // !( - обязательная скобка (закрывается обычной) 17
   esMultiply,       // *. - умножение точкой                 18
   0,                // ** - умножение без перестановки множителей 19
   esAlmostEqual     // =~ - знак равенства с тильдой сверху  20
  );//OpCode

function SafeBuildExpr(const Expr : AnsiString): TExprContainer;

implementation

uses
  l3Chars,
  l3String
  ;

const
 FlagPower = 1;
 FlagTrans = 3;

// start class TExprBuilder

constructor TExprBuilder.Create;
begin
 inherited Create;
 _S := Tl3StringEx.Create;
 VarAutoIndex:=True;
 FuncAutoIndex:=True;
 PostSymbols:=True
end;

procedure TExprBuilder.Cleanup;
begin
 l3Free(_S);
 inherited;
end;

procedure TExprBuilder.Preprocess(const S: AnsiString);

var
 l_Len : Integer;
 
 function Si(I:Integer) : AnsiChar;
 begin
  if (I > l_Len) then
   Result := #0
  else
   Result := S[I]; 
 end;

var
 I : Integer;
 l_InQuotedString : Boolean;
 l_ParCount: Integer;
begin
 Assert(Ord(High(TOp)) < 32);
 I := 1;
 _S.Clear;
 l_Len := Length(S);
 while I < l_Len do
 begin
  case S[I] of
   '<': case Si(I + 1) of
         '<':                        // << - много меньше
          _S.Add(opMuchLess, I);
         '>':                        // <> - не равно
          _S.Add(opNotEqual, I);
         '=':                        // <= - меньше или равно
          Case Si(I+2) of
           '=':
            _S.Add(opConsequenceLeft, I, 2); // <==
           '>':
            _S.Add(opConsequence, I, 2); // <=>
           else
            _S.Add(opLessOrEqual, I);
          end;//Case Si(I+2)
         '~':                        // <~ - меньше или порядка
          _S.Add(opApproxLess, I);
         else
          _S.Add('<', I);
        end; //case Si(I + 1) of...
             
   '>': case Si(I+1) of
         '=':                        // >= - больше или равно
          _S.Add(opGreaterOrEqual, I);
         '>':                        // >> - много больше
          _S.Add(opMuchGreater, I);
         '~':                        // >~ - больше или порядка
          _S.Add(opApproxGreater, I);
         else
          _S.Add('>', I);
        end;

   '=': case Si(I+1) of
         '=':                        // == - тождественно
          Case Si(I+2) of
           '~':
            _S.Add(opAlmostEqual2, I, 2); // ==~ - знак равенства с тильдой сверху
           '>':
            _S.Add(opConsequenceRight, I, 2); // ==>
           else
            _S.Add(opEquivalent, I);
          end;//Case Si(I+2)

         '~':                        // =~ - знак равенства с тильдой сверху
          _S.Add(opAlmostEqual, I);
         else
          _S.Add('=', I);
        end;

   '~': if Si(I+1)='~' then           // ~~ - примерно равно
         _S.Add(opApproxEqual, I)
        else
         _S.Add('~', I);

   '%': begin
    Inc(I);
    Case Si(I) of
     '(': begin
      if (Si(I+2) = ')') then
      begin
       Inc(I);
       if Si(I)='+' then               // (+) - плюс в круге
        begin
         _S.Add(opRoundPlus, I-1);
         Inc(I)
        end
       else
       if Si(I)='*' then               // (*) - косой крест в круге
        begin
         _S.Add(opRoundMul, I-1);
         Inc(I)
        end
       else
       if Si(I)='C' then               // (C) - C в круге
        begin
         if SL > 0 then
          _S.Add('&', I-1);
         _S.Add(opCopy, I-1);
         Inc(I);
        end
       else
       if Si(I)='R' then               // (R) - R в круге
        begin
         if SL > 0 then
          _S.Add('&', I-1);
         _S.Add(opRight, I-1);
         Inc(I)
        end
       else
       begin
        Dec(I);
        _S.Add('%(', I);
       end;//else
      end//Si(I+2) = ')'
      else
       _S.Add('%(', I);
     end;//'('
     'E':
     begin
      Inc(I);
      if (Si(I) = '/') then
       _S.Add(opNotIn, I-1)
      else
      begin
       Dec(I);
       _S.Add(opIn, I);
      end;//Si(I) = '/'
     end;//'E'
     'C':
     begin
      Inc(I);
      if (Si(I) = '/') then
       _S.Add(opNotInclude, I-1)
      else
      if (I <= Length(S)) AND (Si(I) = '-') then
       _S.Add(opIncludeOrEq, I-1)
      else
      begin
       Dec(I);
       _S.Add(opInclude, I);
      end;//Si(I) = '/'
     end;//'C'
     'c':
     begin
      Inc(I);
      (*if (Si(I) = '/') then
       _S.Add(opInvertNotInclude)
      else*)
      if (Si(I) = '-') then
       _S.Add(opInvertIncludeOrEq, I-1)
      else
      begin
       Dec(I);
       _S.Add(opInvertInclude, I);
      end;//Si(I) = '/'
     end;//'c'
     'O':
     begin
      Inc(I);
      if (Si(I) = '/') then
      begin
       if SL > 0 then
        _S.Add('&', I-1);
       _S.Add(opDiametr, I-1);
      end
      else
      begin
       Dec(I);
       _S.Add('%O', I);
      end;//Si(I) = '/'
     end;//'O'
     'U' :
      _S.Add(opJoin, I-1);
     'R' :
      _S.Add(opIntersest, I-1);
     'V' :
      _S.Add(opOr, I-1);
     'A' :
      _S.Add(opAND, I-1);
     else
     begin
      Dec(I);
      _S.Add('%', I);
     end;//else
    end;//Case Si(I)
   end;//'%'

   '+': if Si(I+1)='-' then           // +- - плюс-минус
         _S.Add(opPlusMinus, I)
        else
         _S.Add('+', I);

   '-': case Si(I+1) of               // -+ - минус-плюс
         '+':
          _S.Add(opMinusPlus, I);
         '>':                        // -> - стрелка (стремится к пределу)
          _S.Add(opArrow, I);
         else
          _S.Add('-', I);
        end;
   '/': case Si(I+1) of
         '/':                        // // - делить символом "/", без дроби
          _S.Add(opSlash, I);
         '+':                        // /+ - знак "минус с точкой снизу и точкой сверху"
          _S.Add(opDivide, I);
         else
          _S.Add('/', I)
        end;

   '*': case Si(I+1) of
         '+':                        // *+ - косой крест
          _S.Add(opCrossMultiply, I);
         '*':                        // ** - умножение без перестановки множителей
          _S.Add(opOrderMultiply, I);
         '.':                        // *. - умножение точкой
          _S.Add(opMultiply, I);
         else
          _S.Add('*', I)
        end;

   '!': if Si(I+1)='(' then           // !( - обязательная скобка (закрывается обычной)
         _S.Add(opStrictBracket, I)
        else
         _S.Add('!', I);

   ' ': ; // пробелы - выкидываем

   '.': if (Si(I+1)='.') and (Si(I+2)='.') then // ... - эллипсис
        begin
         _S.Add(opEllipsis, I);
         Inc(I)
        end
        else
         _S.Add('.', I);
   's','S':
    if UpperCase(Copy(S, I, 7)) = 'STRING(' then
    begin
     _S.Add('STRING(', I);
     Inc(I, 7);
     l_ParCount := 1;
     l_InQuotedString := False;
     while (I <= Length(S)) do
     begin
      case Si(I) of
       '(' : if not l_InQuotedString then
              Inc(l_ParCount);
       ')' : if not l_InQuotedString then
             begin
              Dec(l_ParCount);
              if l_ParCount = 0 then
              begin
               _S.Add(S[I], I);
               Break;
              end;
             end;
       '"' : l_InQuotedString := not l_InQuotedString;
      end;
      _S.Add(S[I], I);
      Inc(I);
     end;//while (I <= Length(S))
    end//UpperCase(Copy(S, I, 7)) = 'STRING('
    else
     _S.Add(S[I], I);
   else
    _S.Add(S[I], I);
  end; // case S[I] of...
  Inc(I);
 end;//while I < l_Len
 if I <= l_Len then
  _S.Add(S[I], I);
end;

   procedure TExprBuilder.AddMult;
    var ELast,MLast,Temp:Tl3Expr;
     begin
      if Build then
       begin
        if not Assigned(Existing) then
         begin
          Existing:=Multiplier;
          Exit
         end;
        ELast:=Existing;
        while Assigned(ELast.Next) do
         ELast:=ELast.Next;
        MLast:=Multiplier;
        while Assigned(MLast.Next) do
         MLast:=MLast.Next;
        if (ELast.FTType and efRight>0) and (Multiplier.FTType and efLeft>0) then
         Existing.AddNext(Multiplier)
        else
         if (MLast.FTType and efRight>0) and (Existing.FTType and efLeft>0) then
          begin
           Multiplier.AddNext(Existing);
           Existing:=Multiplier
          end
         else
          if (Existing is TExprNumber) and (MLast is TExprNumber) then
           begin
            TExprNumber(MLast).Number:=TExprNumber(MLast).Number*TExprNumber(Existing).Number;
            MLast.Next:=Existing.CutOff;
            l3Free(Existing);
            Existing:=Multiplier
           end
          else
           if (Multiplier.FTType and efLeft>0) and (MLast.FTType and efRight>0) then
            begin
             Temp:=Existing;
             while Assigned(Temp.Next) do
              if (Temp.FTType and efRight>0) and (Temp.Next.FTType and efLeft>0) then
               Break
              else
               Temp:=Temp.Next;
             if Assigned(Temp.Next) then
              begin
               MLast.Next:=Temp.CutOff;
               Temp.Next:=Multiplier
              end
             else
              begin
               Existing.AddNext(TExprSign.Create(esMultiply));
               Existing.AddNext(Multiplier)
              end
            end
           else
            begin
             Existing.AddNext(TExprSign.Create(esMultiply));
             Existing.AddNext(Multiplier)
            end
       end
      else
       Existing:=nil;
     end;

   function TExprBuilder.MakePower;
    var A:Tl3Expr;
     begin
      if not Build then
      begin
       Result:=nil;
       // если мы не строим выражение, а только проверяем правильность, то переданное нам выражение
       // можно грохнуть
       if Assigned(Exponent) then
        l3Free(Exponent);
      end
      else
       begin
        if Base is TExprCommonFunc then
         with TExprCommonFunc(Base) do
          if (Son is TExprIndex) and not Assigned(TExprIndex(Son).Twin2) then
           begin
            TExprIndex(Son).Twin2:=Exponent;
            Result:=Base;
            Exit
           end
          else
           if not (Son is TExprIndex) then
            begin
             A:=TExprIndex.Create(CutOffSon,nil,Exponent);
             Son:=A;
             Result:=Base;
             Exit
            end;
        if (Base is TExprIndex) and not Assigned(TExprIndex(Base).Twin2) then
         begin
          TExprIndex(Base).Twin2:=Exponent;
          Result:=Base
         end
        else
         Result:=TExprIndex.Create(Base,nil,Exponent)
        end
     end;

   function TExprBuilder.MakeIndex;
    var A:Tl3Expr;
     begin
      if not Build then
      begin
       Result:=nil;
       // если мы не строим выражение, а только проверяем правильность, то переданное нам выражение
       // можно грохнуть
       if Assigned(Index) then
        l3Free(Index);
      end
      else
       begin
        if Base is TExprCommonFunc then
         with TExprCommonFunc(Base) do
          if (Son is TExprIndex) and not Assigned(TExprIndex(Son).Twin1) then
           begin
            TExprIndex(Son).Twin1:=Index;
            Result:=Base;
            Exit
           end
          else
           if not (Son is TExprIndex) then
            begin
             A:=TExprIndex.Create(CutOffSon,Index,nil);
             Son:=A;
             Result:=Base;
             Exit
            end;
        if (Base is TExprIndex) and not Assigned(TExprIndex(Base).Twin1) then
         begin
          TExprIndex(Base).Twin1:=Index;
          Result:=Base
         end
        else
         Result:=TExprIndex.Create(Base,Index,nil)
        end
     end;

   function TExprBuilder.MakeCap;
    var A:Tl3Expr;
     begin
      if not Assigned(Base) then
       Result:=nil
      else
       if Base is TExprCommonFunc then
        with TExprCommonFunc(Base) do
         begin
          A:=MakeCap(CutOffSon,Style,N);
          Son:=A;
          Result:=Base
         end
       else
        if (Base is TExprIndex) and not Assigned(TExprIndex(Base).Twin2) then
         with TExprIndex(Base) do
          begin
           A:=TExprCap.Create(CutOffSon,Style,N);
           Son:=A;
           Result:=Base
          end
        else
         Result:=TExprCap.Create(Base,Style,N)
     end;

   procedure TExprBuilder.Decorate;
    var A:Tl3Expr;
     begin
      if (Base is TExprChain) and Assigned(TExprChain(Base).Son.Next) then
       begin
        A:=TExprChain(Base).CutOffSon;
        l3Free(Base);
        Base:=TExprBracketed.Create(A,ebRound,ebRound)
       end
     end;

function TExprBuilder.ExprString(Need : TeNeed; AllowComma : Boolean=False): Tl3Expr;
var
 Flags : Integer;
 A     : Tl3Expr;
 Sep   : Integer;
begin
 Result:=BoolExpr(Flags);
 while (SPis('&')) or ((SPis(',')) and AllowComma) do
 begin
  Sep := SP;
  Inc(P);
  if (Sep = Ord(',')) then
   while (SPis(' ')) and (P<SL-1) do
    Inc(P);
  A := BoolExpr(Flags);
  if Build then
   if (Sep = Ord('&')) then
    Result.AddNext(A)
   else
   begin
    Result.AddNext(TExprComma.Create);
    Result.AddNext(TExprSpace.Create(7));
    Result.AddNext(A)
   end;//Sep = Ord('&')
 end;//while (SPis('&')) or ((SPis(',')) and AllowComma)
 if Build then
  case Need of
   EExpression:
    if Assigned(Result.Next) then
     Result := TExprChain.Create(Result);
   EBracketed:
    Result := TExprRound.Create(Result);
   EArgument:
    if Assigned(Result.Next) then
     Result := TExprArgument.Create(Result);
   EPower:
    if Assigned(Result.Next) then
     Result := TExprBase.Create(Result)
    else
    if Flags and FlagPower=FlagPower then
     Result := TExprBracketed.Create(Result,ebRound,ebRound);
   EAbs:
    Result := TExprBracketed.Create(Result,ebModule,ebModule);
   ESquared:
    Result := TExprBracketed.Create(Result,ebSquare,ebSquare);
   EFigured:
    Result := TExprBracketed.Create(Result,ebFigure,ebFigure);
   EChain:
    // ничего не делаем
    ;
   else
    Assert(false);
  end;//case Need of
end;

function TExprBuilder.BoolExpr;
var
 LFlags : Integer;
 Sign   : Integer;
 A      : Tl3Expr;
 l_SP   : Integer;
begin
 Result := Expr(LFlags);
 while SPinc(['<','>','=','~'],
             [opNotEqual..opApproxEqual, opEquivalent, opApproxGreater, opApproxLess, opAlmostEqual],
             [opIn, opNotIn,
              opInclude, opNotInclude, opIncludeOrEq,
              opInvertInclude, opInvertIncludeOrEq, opAlmostEqual2, opAND, opOR]) do
 begin
  l_SP := SP;
  case l_SP of
   Ord(Low(TOp)) .. Ord(High(TOp)):
    Sign := OpCode[TOp(SP)];
   Ord('<'):
    Sign := esLess;
   Ord('='):
    Sign := esEqual;
   Ord('>'):
    Sign := esGreater;
   Ord('~'):
    Sign := esTilde;
   else
   begin
    if (l_SP < 0) then
     Sign := MyOpCode[TMyOp(-l_SP)]
    else
     Assert(false);
   end;//else
  end;//case SP
  Inc(P);
  A := Expr(LFlags);
  if Build then
   begin
    if (l_SP < 0) then
     Result.AddNext(TExprSymbolSign.Create(Sign))
    else
     Result.AddNext(TExprSign.Create(Sign));
    Result.AddNext(A)
   end//Build
 end;//while SPinc
 if Build then
  if Assigned(Result.Next) then
   Flags := FlagPower
  else
   Flags := LFlags
end;

function TExprBuilder.Expr;
var
 LFlags : Integer;
 Sign   : Integer;
 A      : Tl3Expr;
 l_SP   : Integer;
begin
 Result := Trans(LFlags);
 while SPinc(['-','+'], [opPlusMinus, opMinusPlus], [opRoundPlus, opJoin, opIntersest, opConsequence, opConsequenceLeft, opConsequenceRight]) do
 begin
  l_SP := SP;
  case l_SP of
   Ord(Low(TOp)) .. Ord(High(TOp)):
    Sign := OpCode[TOp(SP)];
   Ord('-'):
    Sign := esMinus;
   Ord('+'):
    Sign := esPlus;
   else
   begin
    if (l_SP < 0) then
     Sign := MyOpCode[TMyOp(-l_SP)]
    else
     Assert(false);
   end;//else
  end;//case SP
  Inc(P);
  A := Trans(LFlags);
  if Build then
  begin
   if (LFlags and FlagTrans = FlagTrans) then
    A:=TExprBracketed.Create(A,ebRound,ebRound);
   if (l_SP < 0) then
    Result.AddNext(TExprSymbolSign.Create(Sign))
   else
    Result.AddNext(TExprSign.Create(Sign));
   Result.AddNext(A);
  end;//Build
 end;//while SPinc(['-','+', opPlusMinus,opMinusPlus])
 if Build then
  if Assigned(Result.Next) then
   Flags := FlagPower
  else
   Flags := LFlags
end;

function TExprBuilder.Trans;
var
 LFlags  : Integer;
 D1,D2,A : Tl3Expr;
 l_SP    : Integer;
begin
 D2 := nil;
 D1 := Factor(LFlags);
 while SPinc(['*','/'],
             [opDivide,opCrossMultiply,opSlash,opMultiply,opOrderMultiply],
             [opRoundMul]) do
 begin
  l_SP := SP;
  case l_SP of
   Ord(opDivide),
   Ord(opCrossMultiply),
   Ord(opSlash),
   Ord(opMultiply):
   begin
    Inc(P);
    A:=Factor(LFlags);
    if Build then
    begin
     D1.AddNext(TExprSign.Create(OpCode[TOp(l_SP)]));
     D1.AddNext(A)
    end;//Build
   end;//opDivide
   Ord(opOrderMultiply):
   begin
    Inc(P);
    A:=Factor(LFlags);
    if Build then
     D1.AddNext(A)
   end;//Ord(opOrderMultiply)
   Ord('*'):
   begin
    Inc(P);
    AddMult(D1,Factor(LFlags))
   end;//Ord('*')
   Ord('/'):
   begin
    Inc(P);
    AddMult(D2,Factor(LFlags))
   end//Ord('/')
   else
   begin
    Assert(l_SP < 0);
    Inc(P);
    A:=Factor(LFlags);
    if Build then
    begin
     D1.AddNext(TExprSymbolSign.Create(MyOpCode[TMyOp(-l_SP)]));
     D1.AddNext(A)
    end;//Build
   end;//else
  end;//case l_SP
 end;//while 
 if Build then
 begin
  Flags:=0;
  if not Assigned(D2) and not Assigned(D1.Next) then
   Flags:=LFlags;
  if Assigned(D2) then
   begin
    if Assigned(D1.Next) then
     D1:=TExprChain.Create(D1);
    if Assigned(D2.Next) then
     D2:=TExprChain.Create(D2);
    Flags:=FlagPower;
    if D1.FTType and efRoundBrackets=efRoundBrackets then
     TExprBracketed(D1).RemoveBrackets;
    if D2.FTType and efRoundBrackets=efRoundBrackets then
     TExprBracketed(D2).RemoveBrackets;
    Result:=TExprRatio.Create(D1,D2)
   end
  else
   Result:=D1
 end//Build
 else
  Result := nil;
end;

function TExprBuilder.Factor: Tl3Expr;
  //overload;
var
 l_Flags : Integer;
begin
 Result := Factor(l_Flags); 
end;

function TExprBuilder.Factor(out Flags:Integer):Tl3Expr;

 procedure DoStrokes;
 var
  l_Count : Integer;
 begin//DoStrokes
  Inc(P);
  l_Count := 1;
  while SPis('`') do
  begin
   Inc(P);
   Inc(l_Count)
  end;//while SPis('`')
  Decorate(Result);
  Result:=MakePower(Result,TExprStrokes.Create(l_Count))
 end;//DoStrokes

 procedure DoDigits;
 var
  l_Ext: Extended;
 begin//DoDigits
  Result := nil;
  if Build then
  begin
   l_Ext := eSVal;
   Result := TExprNumber.Create(l_Ext, false)
  end
  else
   eSVal;
 end;//DoDigits

 procedure DoNumber;
 var
  l_Ext: Extended;
 begin//DoNumber
  Result := nil;
  Inc(P);
  if not SPinc(cc_Digits) then
   RaiseError('Ожидается цифра', P);
  if Build then
  begin
   l_Ext := eSVal;
   Result := TExprNumber.Create(l_Ext, true);
  end
  else
   eSVal;
 end;//DoNumber

var
 B : Tl3Expr;
begin
 Flags:=0;
 case SP of
  Ord('0')..Ord('9'):
   DoDigits;
  Ord('#'):
   DoNumber;
  Ord('+'):begin
       Inc(P);
       Flags:=FlagTrans;
       B:=Factor;
       if Build then
        begin
         Result:=TExprSign.Create(esPlus);
         Result.AddNext(B)
        end
       else
        Result:=nil
      end;
  Ord('-'):begin
       Inc(P);
       B:=Factor;
       if Build then
        begin
         Result:=TExprSign.Create(esMinus);
         Result.AddNext(B);
        end
       else
        Result:=nil
      end;
  Ord(opPlusMinus):
  begin
      Inc(P);
      Flags:=FlagTrans;
      B:=Factor;
      if Build then
       begin
        Result:=TExprSign.Create(esPlusMinus);
        Result.AddNext(B)
       end
      else
       Result:=nil
  end;//opPlusMinus
  Ord(opMinusPlus):
  begin
      Inc(P);
      Flags:=FlagTrans;
      B:=Factor;
      if Build then
       begin
        Result:=TExprSign.Create(esMinusPlus);
        Result.AddNext(B)
       end
      else
       Result:=nil
  end;//opMinusPlus
  Ord('['):begin
       Inc(P);
       Result:=ExprString(ESquared,True);
       if SPis(']') then
        Inc(P)
       else
        RaiseError('Ожидается "]"', P)
      end;
  Ord('{'):begin
       Inc(P);
       Result:=ExprString(EFigured,True);
       if SPis('}') then
        Inc(P)
       else
        RaiseError('Ожидается "}"', P)
      end;
  Ord('('):begin
       Inc(P);
       Result:=ExprString(EArgument);
       if SPis(')') then
        Inc(P)
       else
        RaiseError('Ожидается ")"', P)
      end;
  Ord('|'):begin
       Inc(P);
       Result:=ExprString(EAbs,True);
       if SPis('|') then
        Inc(P)
       else
        RaiseError('Ожидается "|"', P)
      end;
  Ord(opStrictBracket):
  begin
       Inc(P);
       Result:=ExprString(EBracketed,True);
       if SPis(')') then
        Inc(P)
       else
        RaiseError('Ожидается ")"', P)
  end;//opStrictBracket
  Ord(opEllipsis):
  begin
       Inc(P);
       if Build then
        Result:=TExprExtSymbol.Create(esEllipsis)
       else
        Result:=nil
  end;//opEllipsis
  Ord('_'):begin
       Inc(P);
       B:=Factor(Flags);
       if Build then
        Result:=MakeCap(B,ecVector,0)
       else
        Result:=nil
      end;
  Ord('A')..Ord('Z'),
  Ord('a')..Ord('z'),
  Ord(AnsiChar('А'))..Ord(AnsiChar('я')),
  Ord(AnsiChar('Ё')),Ord(AnsiChar('ё')),
  -Ord(opCopy),
  -Ord(opRight),
  -Ord(opDiametr):
   Result:=Func(Flags);
  else
   RaiseError('Недопустимый символ #' + IntToStr(SP), P)
 end;
 if PostSymbols then
  while SPinc(['^','_','!','`']) do
   case SP of
    Ord('^'):begin
         Inc(P);
         B:=Factor;
         if Build then
          begin
           if B is TExprArgument then
            TExprArgument(B).RemoveBrackets;
           Decorate(Result);
           Result:=MakePower(Result,B);
          end;
         Flags:=FlagPower
        end;
    Ord('_'):begin
         Inc(P);
         PostSymbols:=False;
         B:=Factor;
         PostSymbols:=True;
         if Build then
          begin
           if B is TExprArgument then
            TExprArgument(B).RemoveBrackets;
           Decorate(Result);
           Result:=MakeIndex(Result,B);
          end;
         //Flags:=FlagPower
        end;
    Ord('!'):begin
         Inc(P);
         Decorate(Result);
         if Build then
          Result.AddNext(TExprSimple.Create('!'))
        end;
    Ord('`'):
     DoStrokes;
   end;//case SP
end;

function TExprBuilder.Func;
var
 N          : AnsiString;
 I,J        : Integer;
 l_WasIndex : Boolean;
 l_Brackets : Boolean;
 l_SP       : Integer;       
begin
 Result := nil;
 l_SP := SP;
 Case l_SP of
  -Ord(opCopy),
  -Ord(opRight):
  begin
   if Build then
    Result := TExprSimple.Create(AnsiChar(MyOpCode[TMyOp(-l_SP)]));
  end;//esCopy
  -Ord(opDiametr):
  begin
   if Build then
    Result := TExprCustomText.Create(AnsiChar(MyOpCode[TMyOp(-l_SP)]), [], 'Symbol');
  end;//esDiametr
  else
  begin
   Assert(l_SP >= 0);
   N := AnsiChar(l_SP);
   Inc(P);
   while SPinc(cc_AlphaNum) do
   begin
    N := N + AnsiChar(SP);
    Inc(P)
   end;//while SPinc
   l_Brackets := SPis(opStrictBracket);
   if l_Brackets OR SPis('(') then
   begin
    Inc(P);
    Result := FuncName(N, Flags, l_Brackets);
    if SPis(')') then
     Inc(P)
    else
     RaiseError('Ожидается ")"', P);
   end//SPis('(')
   else
   begin
    if VarAutoIndex then
    begin
     I:=Length(N);
     while (N[I] in cc_Digits) do
      Dec(I);
     if (I < Length(N)) then
     begin
      l_WasIndex := true;
      J:=StrToInt(Copy(N,I+1,MaxInt));
      N:=Copy(N,1,I)
     end//I < Length(N)
     else
      l_WasIndex:=False;
    end//VarAutoIndex
    else
     l_WasIndex := false;
    Result := Token(N);
    if Build and l_WasIndex then
     Result := TExprIndex.Create(Result,TExprNumber.Create(J,False),nil);
   end;//SPis('(')
   Exit; // - чтобы не двигать P
  end;//else
 end;//Case SP
 Inc(P);
 // - смещаемся на следующий символ 
end;

   function TExprBuilder.FuncName(const aName: AnsiString; out Flags:Integer; Brackets : Boolean):Tl3Expr;

   var
     D : Tl3Expr;

    procedure DoFuncAutoIndex;
    var
     I      : Integer;
     l_Name : AnsiString;
     X      : Extended;
     GI     : Integer;
    begin//DoFuncAutoIndex
     I := Length(aName);
     while (aName[I] in cc_Digits) do
      Dec(I);
     if (I < Length(aName)) then
      if Build then
      begin
       X:=StrToFloat(Copy(aName,I+1,MaxInt));
       l_Name:=Copy(aName,1,I);
       GI:=GreekLetter(l_Name);
       if GI=0 then
        Result:=MakeIndex(TExprFunc.Create(l_Name,D),TExprNumber.Create(X,False))
       else
        case GI of
         1:Result:=MakeIndex(TExprCommonFunc.Create(TExprLambda.Create,D),TExprNumber.Create(X,False));
         2:Result:=MakeIndex(TExprCommonFunc.Create(TExprNabla.Create,D),TExprNumber.Create(X,False))
        else
         Result:=MakeIndex(TExprCommonFunc.Create(TExprExtSymbol.Create(GI),D),TExprNumber.Create(X,False))
        end
      end//Build
      else
       Result:=nil
     else
      if Build then
       begin
        GI:=GreekLetter(aName);
        if GI=0 then
         Result:=TExprFunc.Create(aName,D)
        else
         case GI of
          1:Result:=TExprCommonFunc.Create(TExprLambda.Create,D);
          2:Result:=TExprCommonFunc.Create(TExprNabla.Create,D)
         else
          Result:=TExprCommonFunc.Create(TExprExtSymbol.Create(GI),D)
         end 
       end
      else
       Result:=nil
    end;//DoFuncAutoIndex
    
    procedure DoString;
    var
     l_S : Tl3String;

     procedure DoQuotes;
     begin//DoQuotes
      Inc(P);
      while true do
      begin
       Case SP of
        Ord(cc_DoubleQuote):
        begin
         if _S[P].IsA(cc_DoubleQuote) then
         begin
          l_S.Append(cc_DoubleQuote);
          Inc(P)
         end
         else
          break;
        end;//cc_DoubleQuote
        else
        begin
         l_S.Append(AnsiChar(SP));
        end;//else
       end;//Case S[P]
       Inc(P);
       if (P >= SL) then
        RaiseError('Незавершённая строка', SL);
      end;//while true
      Inc(P)
     end;//DoQuotes

     procedure DoNumber;
     var
      l_NumStart : Integer;
      l_Hex      : Boolean;
      l_Unicode  : Boolean;
      l_CharCode : Integer;
     begin//DoNumber
      Inc(P);
      l_Hex := false;
      l_Unicode := false;
      l_NumStart := P;
      while true do
      begin
       Case SP of
        Ord(cc_DollarSign):
        begin
         if l_Hex then
          RaiseError('Повторный символ $', P)
         else
          l_Hex := true;
        end;//cc_DollarSign
        Ord('@'):
        begin
         if l_Unicode then
          RaiseError('Повторный символ @', P)
         else
         begin
          Inc(l_NumStart);
          l_Unicode := true;
         end;//l_Unicode
        end;//'@'
        Ord('0')..Ord('9'):
        // - ничего не делаем
        ;
        Ord('a')..Ord('f'), Ord('A')..Ord('F'):
         if not l_Hex then
          break;
        else
         break;
       end;//Case S[P]
       Inc(P);
       if (P >= SL) then
        RaiseError('Незавершённая строка', SL);
      end;//while true
      if (P = l_NumStart) then
      begin
       if l_Hex then
        RaiseError('Не введён код символа', P)
       else
        l_CharCode := Ord(cc_Number);
      end//P = l_NumStart
      else
       try
        l_CharCode := StrToInt(SCopyFrom(l_NumStart, P-l_NumStart));
       except
        RaiseError('Не введён код символа', P)
       end;//try..except
      if (l_CharCode = 12) then
       l_CharCode := $2640
      else
      if (l_CharCode = 13) then
       l_CharCode := $266a;
      if l_Unicode OR (l_CharCode > Integer(High(AnsiChar))) then
      begin
       l_S.CodePage := CP_Unicode;
       l_S.Append(l3PCharLen(@l_CharCode, 1, CP_Unicode));
      end
      else
       l_S.Append(AnsiChar(l_CharCode));
     end;//DoNumber

     procedure DoNumberAndQuotes;
     begin//DoNumberAndQuotes
      repeat
       Case SP of
        Ord(cc_DoubleQuote):
         DoQuotes;
        Ord(cc_Number):
         DoNumber;
        else
        begin
         l_S.Append(AnsiChar(SP));
         Inc(P);
        end;//else
       end;//Case S[P]
       if (P >= SL) then
        RaiseError('Незавершённая строка', SL);
      until SPis(')');
     end;//DoNumberAndQuotes

    var
     l_St : Tl3WString;
     //l_i  : Integer; 
    begin
     l_S := Tl3String.Create;
     try
      l_S.CodePage := CP_ANSI;
      Case SP of
       Ord(cc_DoubleQuote),
       Ord(cc_Number):
        DoNumberAndQuotes;
       else
       begin
        while not SPis(')') do
        begin
         l_S.Append(AnsiChar(SP));
         Inc(P);
         if (P >= SL) then
          RaiseError('Незавершённая строка', SL)
        end;//while (S[P]<>')')
       end;//else
      end;//Case S[P]
      if Build then
      begin
       l_St := l_S.AsWStr;
       if (l_St.SCodePage <> CP_RussianWin) then
       begin
        l_S.CodePage := CP_Unicode;
        l_St := l_S.AsWStr;
       end;//l_St.SCodePage <> CP_RissianWin
       if l3IsNil(l_St) then
        Result := TExprEmpty.Create
       else 
       if (l_St.SCodePage = CP_Unicode) then
       begin
        Result := TExprUnicode.Create(l_S.AsWideString);
(*        Result := TExprExtSymbol.Create(Integer(PWideChar(l_St.S)^));
        for l_i := 1 to Pred(l_St.SLen) do
         Result.AddNext(TExprExtSymbol.Create(Integer(PWideChar(l_St.S)[l_i])));*)
       end//l_S.CodePage = CP_Unicode
       else
        Result := TExprSimple.Create(l_S.AsString)
      end//Build
      else
       Result:=nil
     finally
      l3Free(l_S);
     end;//try..finally
    end;

    var A,C,D2:Tl3Expr;
        M,T:AnsiString;
        GI,P0:Integer;
        X:Extended;
        K,K2:Integer;
        LeftBr,RightBr:TExprBracket;
        Pr,Dig,MD:Integer;
        l_Int: Integer;
     begin
      Flags:=0;
      M:=UpperCase(aName);
      if M='SQRT' then begin
                        A:=ExprString(EExpression);
                        if Build then
                         Result:=TExprRoot.Create(A,nil)
                        else
                         Result:=nil
                       end else
      if M='SQR' then begin
                       Flags:=FlagPower;
                       Result:=MakePower(ExprString(EPower),TExprNumber.Create(2,False))
                      end else
      if M='LOG' then begin
                       A:=ExprString(EExpression);
                       LookForComma;
                       D:=ExprString(EArgument);
                       if Build and Brackets then
                        if D is TExprArgument then
                         TExprArgument(D).SetBrackets
                        else
                         D:=TExprRound.Create(D);
                       if Build then
                        Result:=TExprCommonFunc.Create(TExprIndex.Create(TExprFuncName.Create(aName),A,nil),D)
                       else
                        Result:=nil
                      end else
      if M='ABS' then begin
                       Result:=ExprString(EAbs)
                      end else
      if M='POW' then begin
                       Flags:=FlagPower;
                       D:=ExprString(EPower);
                       LookForComma;
                       Result:=MakePower(D,ExprString(EExpression))
                      end else
      if M='ROOT' then begin
                        D:=ExprString(EExpression);
                        LookForComma;
                        A:=ExprString(EExpression);
                        if Build then
                         Result:=TExprRoot.Create(A,D)
                        else
                         Result:=nil
                       end else
      if M='IND' then begin
                       D:=ExprString(EPower);
                       LookForComma;
                       Result:=MakeIndex(D,ExprString(EExpression))
                      end else
      if M='LIM' then begin
                       Flags:=FlagPower;
                       D:=ExprString(EExpression);
                       LookForComma;
                       A:=ExprString(EArgument);
                       if Build and Brackets then
                        if D is TExprArgument then
                         TExprArgument(D).SetBrackets
                        else
                         D:=TExprRound.Create(D);
                       if Build then
                        Result:=TExprCommonFunc.Create(TExprLim.Create(D),A)
                       else
                        Result:=nil
                      end else
      if M='FUNC' then begin
                        A:=ExprString(EExpression);
                        LookForComma;
                        D:=ExprString(EChain);
                        while Comma do
                         begin
                          A:=ExprString(EChain);
                          if Build then
                           begin
                            D.AddNext(TExprComma.Create);
                            D.AddNext(A)
                           end
                         end;
                        if Build then
                         begin
                          D:=TExprArgument.Create(D);
                          if Brackets then
                           TExprArgument(D).SetBrackets;
                          Result:=TExprCommonFunc.Create(A,D)
                         end
                        else
                         Result:=nil
                       end else
      if M='SPACE' then begin
                         Result := nil;
                         if Build then
                         begin
                          l_Int := iSVal;
                          Result:=TExprSpace.Create(l_Int);
                         end
                         else
                          iSVal;
                        end else
      if M='DIFF' then begin  // Diff(x[,n]) - дифференциал от dx^n
                        D:=ExprString(EPower);
                        if Comma then
                         begin
                          A:=ExprString(EExpression);
                          if Build then
                           begin
                            Result:=TExprSpace.Create(4);
                            Result.AddNext(TExprVar.Create('d'));
                            Result.AddNext(TExprIndex.Create(D,nil,A))
                           end
                          else
                           Result:=nil;
                         end
                        else
                         if Build then
                          begin
                           Result:=TExprSpace.Create(4);
                           Result.AddNext(TExprVar.Create('d'));
                           Result.AddNext(D)
                          end
                         else
                          Result:=nil
                       end else
      if M='PDIFF' then begin  // PDiff(x[,n]) - "частный дифференциал" от dx^n
                         D:=ExprString(EPower);
                         if Comma then
                          begin
                           A:=ExprString(EExpression);
                           if Build then
                            begin
                             Result:=TExprSpace.Create(4);
                             Result.AddNext(TExprExtSymbol.Create(esPartDiff));
                             Result.AddNext(TExprIndex.Create(D,nil,A))
                            end
                           else
                            Result:=nil;
                          end
                         else
                          if Build then
                           begin
                            Result:=TExprSpace.Create(4);
                            Result.AddNext(TExprExtSymbol.Create(esPartDiff));
                            Result.AddNext(D)
                           end
                          else
                           Result:=nil
                        end else
      if M='DIFFN' then begin  // DiffN(x[,n]) - d(^n)x
                         D:=ExprString(EPower);
                         if Comma then
                          begin
                           A:=ExprString(EPower);
                           if Build then
                            begin
                             Result:=TExprSpace.Create(4);
                             Result.AddNext(TExprIndex.Create(TExprVar.Create('d'),nil,A));
                             Result.AddNext(D)
                            end
                           else
                            Result:=nil;
                          end
                         else
                          if Build then
                           begin
                            Result:=TExprSpace.Create(4);
                            Result.AddNext(TExprVar.Create('d'));
                            Result.AddNext(D)
                           end
                          else
                           Result:=nil
                        end else
      if M='PDIFFN' then begin // PDiffN(x[,n]) - d(^n)x - "частный дифференциал"
                          D:=ExprString(EPower);
                          if Comma then
                           begin
                            A:=ExprString(EPower);
                            if Build then
                             begin
                              Result:=TExprSpace.Create(4);
                              Result.AddNext(TExprIndex.Create(TExprExtSymbol.Create(esPartDiff),nil,A));
                              Result.AddNext(D)
                             end
                            else
                             Result:=nil;
                           end
                          else
                           if Build then
                            begin
                             Result:=TExprSpace.Create(4);
                             Result.AddNext(TExprExtSymbol.Create(esPartDiff));
                             Result.AddNext(D)
                            end
                           else
                            Result:=nil
                         end else
      if M='DIFFR' then begin // DiffR(x[,n]) - d(^n)/dx^n
                         D:=ExprString(EPower);
                         if Comma then
                          begin
                           P0:=P;
                           A:=ExprString(EExpression);
                           if Build then
                            begin
                             Result:=TExprVar.Create('d');
                             Result.AddNext(TExprIndex.Create(D,nil,A));
                             P:=P0;
                             A:=ExprString(EExpression);
                             Result:=TExprChain.Create(Result);
                             Result:=TExprRatio.Create(TExprIndex.Create(TExprVar.Create('d'),nil,A),Result)
                            end
                           else
                            Result:=nil;
                          end
                         else
                          if Build then
                           begin
                            Result:=TExprVar.Create('d');
                            Result.AddNext(D);
                            Result:=TExprChain.Create(Result);
                            Result:=TExprRatio.Create(TExprVar.Create('d'),Result)
                           end
                          else
                           Result:=nil
                        end else
      if M='PDIFFR' then begin // DiffR(x[,n]) - d(^n)/dx^n - частный дифференциал
                          D:=ExprString(EPower);
                          if Comma then
                           begin
                            P0:=P;
                            A:=ExprString(EExpression);
                            if Build then
                             begin
                              Result:=TExprExtSymbol.Create(esPartDiff);
                              Result.AddNext(TExprIndex.Create(D,nil,A));
                              P:=P0;
                              A:=ExprString(EExpression);
                              Result:=TExprChain.Create(Result);
                              Result:=TExprRatio.Create(TExprIndex.Create(TExprExtSymbol.Create(esPartDiff),nil,A),Result)
                             end
                            else
                             Result:=nil;
                           end
                          else
                           if Build then
                            begin
                             Result:=TExprExtSymbol.Create(esPartDiff);
                             Result.AddNext(D);
                             Result:=TExprChain.Create(Result);
                             Result:=TExprRatio.Create(TExprExtSymbol.Create(esPartDiff),Result)
                            end
                           else
                            Result:=nil
                         end else
      if M='DIFFRF' then begin // DiffRF(y,x[,n]) - d(^n)y/dx^n
                          D2:=ExprString(EPower);
                          LookForComma;
                          D:=ExprString(EPower);
                          if Comma then
                           begin
                            P0:=P;
                            A:=ExprString(EExpression);
                            if Build then
                             begin
                              Result:=TExprVar.Create('d');
                              Result.AddNext(TExprIndex.Create(D,nil,A));
                              P:=P0;
                              A:=ExprString(EExpression);
                              Result:=TExprChain.Create(Result);
                              C:=TExprIndex.Create(TExprVar.Create('d'),nil,A);
                              C.AddNext(D2);
                              C:=TExprChain.Create(C);
                              Result:=TExprRatio.Create(C,Result)
                             end
                            else
                             Result:=nil
                           end
                          else
                           if Build then
                            begin
                             Result:=TExprVar.Create('d');
                             Result.AddNext(D);
                             Result:=TExprChain.Create(Result);
                             C:=TExprVar.Create('d');
                             C.AddNext(D2);
                             C:=TExprChain.Create(C);
                             Result:=TExprRatio.Create(C,Result)
                            end
                           else
                            Result:=nil
                         end else
      if M='PDIFFRF' then begin  // 
                           D2:=ExprString(EPower);
                           LookForComma;
                           D:=ExprString(EPower);
                           if Comma then
                            begin
                             P0:=P;
                             A:=ExprString(EExpression);
                             if Build then
                              begin
                               Result:=TExprExtSymbol.Create(esPartDiff);
                               Result.AddNext(TExprIndex.Create(D,nil,A));
                               P:=P0;
                               A:=ExprString(EExpression);
                               Result:=TExprChain.Create(Result);
                               C:=TExprIndex.Create(TExprExtSymbol.Create(esPartDiff),nil,A);
                               C.AddNext(D2);
                               C:=TExprChain.Create(C);
                               Result:=TExprRatio.Create(C,Result)
                              end
                             else
                              Result:=nil
                            end
                           else
                            if Build then
                             begin
                              Result:=TExprExtSymbol.Create(esPartDiff);
                              Result.AddNext(D);
                              Result:=TExprChain.Create(Result);
                              C:=TExprExtSymbol.Create(esPartDiff);
                              C.AddNext(D2);
                              C:=TExprChain.Create(C);
                              Result:=TExprRatio.Create(C,Result)
                             end
                            else
                             Result:=nil
                          end else
      if M='STRING' then
       DoString
      else
      if M='STROKES' then begin
                           Flags:=FlagPower;
                           D:=ExprString(EPower);
                           if Comma then
                            K := iSVal
                           else
                            K := 1;
                           if Build then
                            Result := MakePower(D,TExprStrokes.Create(K))
                           else
                            Result := nil;
                          end else
      if M='FACT' then begin
                        Flags:=FlagPower;
                        D:=ExprString(EPower);
                        if Build then
                         begin
                          Result:=D;
                          Result.AddNext(TExprSimple.Create('!'))
                         end
                        else
                         Result:=nil
                       end else
      if M='AT' then begin
                      A:=ExprString(EArgument);
                      LookForComma;
                      D:=ExprString(EExpression);
                      if Build then
                       Result:=TExprAtValue.Create(A,D)
                      else
                       Result:=nil
                     end else
      if M='LINE' then begin
                        A:=ExprString(EExpression);
                        if Build then
                         Result:=MakeCap(A,ecLine,0)
                        else
                         Result:=nil
                       end else
      if M='VECT' then begin
                        A:=ExprString(EExpression);
                        if Build then
                         Result:=MakeCap(A,ecVector,0)
                        else
                         Result:=nil
                       end else
      if M='CAP' then begin
                       A:=ExprString(EExpression);
                       if Build then
                        Result:=MakeCap(A,ecCap,0)
                       else
                        Result:=nil
                      end else
      if M='TILDE' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecTilde,0)
                         else
                          Result:=nil
                        end else
      if M='CIRCLE' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecCircle,0)
                         else
                          Result:=nil
                        end else
      if M='RDQ' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecRDQ,0)
                         else
                          Result:=nil
                        end else
      if M='LDQ' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecLDQ,0)
                         else
                          Result:=nil
                        end else
      if M='DQ' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecDQ,0)
                         else
                          Result:=nil
                        end else
      if M='RSQ' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecRSQ,0)
                         else
                          Result:=nil
                        end else
      if M='LSQ' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecLSQ,0)
                         else
                          Result:=nil
                        end else
      if M='SQ' then begin
                         A:=ExprString(EExpression);
                         if Build then
                          Result:=MakeCap(A,ecSQ,0)
                         else
                          Result:=nil
                        end else
      if M='POINTS' then begin
                          A:=ExprString(EExpression);
                          if Comma then
                           K := iSVal
                          else
                           K := 1;
                          if Build then
                           Result:=MakeCap(A,ecPoints,K)
                          else
                           Result:=nil
                         end else
      if M='STANDL' then begin
                          D:=ExprString(EExpression);
                          while Comma do
                           begin
                            A:=ExprString(EExpression);
                            if Build then
                             D.AddNext(A)
                           end;
                          if Build then
                           Result:=TExprStand.Create(D,ehLeft)
                          else
                           Result:=nil
                         end else
      if M='STANDC' then begin
                          D:=ExprString(EExpression);
                          while Comma do
                           begin
                            A:=ExprString(EExpression);
                            if Build then
                             D.AddNext(A)
                           end;
                          if Build then
                           Result:=TExprStand.Create(D,ehCenter)
                          else
                           Result:=nil
                         end else
      if M='STANDR' then begin
                          D:=ExprString(EExpression);
                          while Comma do
                           begin
                            A:=ExprString(EExpression);
                            if Build then
                             D.AddNext(A)
                           end;
                          if Build then
                           Result:=TExprStand.Create(D,ehRight)
                          else
                           Result:=nil
                         end else
      if M='MATRIX' then begin
                          K := iSVal;
                          LookForComma;
                          K2 := iSVal;
                          LookForComma;
                          D:=ExprString(EExpression);
                          while Comma do
                           begin
                            A:=ExprString(EExpression);
                            if Build then
                             D.AddNext(A)
                           end;
                          if Build then
                           Result:=TExprMatrix.Create(D,K,K2)
                          else
                           Result:=nil
                         end else
      if M='SUMMA' then begin
                         A:=ExprString(EArgument);
                         if Build and Brackets then
                          if A is TExprArgument then
                           TExprArgument(A).SetBrackets
                          else
                           A:=TExprRound.Create(A);
                         if Comma then
                          D:=ExprString(EExpression)
                         else
                          D:=nil;
                         if Comma then
                          D2:=ExprString(EExpression)
                         else
                          D2:=nil;
                         if Build then
                          Result:=TExprSumma.Create(A,D,D2)
                         else
                          Result:=nil
                        end else
      if M='PROD' then begin
                        A:=ExprString(EArgument);
                        if Build and Brackets then
                         if A is TExprArgument then
                          TExprArgument(A).SetBrackets
                         else
                          A:=TExprRound.Create(A);
                        if Comma then
                          D:=ExprString(EExpression)
                        else
                         D:=nil;
                        if Comma then
                         D2:=ExprString(EExpression)
                        else
                         D2:=nil;
                        if Build then
                         Result:=TExprProd.Create(A,D,D2)
                        else
                         Result:=nil
                       end else
      if M='CIRC' then begin
                        A:=ExprString(EArgument);
                        if Build and Brackets then
                         if A is TExprArgument then
                          TExprArgument(A).SetBrackets
                         else
                          A:=TExprRound.Create(A);
                        if Comma then
                         D:=ExprString(EExpression)
                        else
                         D:=nil;
                        if Comma then
                         D2:=ExprString(EExpression)
                        else
                         D2:=nil;
                        if Build then
                         Result:=TExprCirc.Create(A,D,D2)
                        else
                         Result:=nil
                       end else
      if M='INT' then begin
                       A:=ExprString(EArgument);
                       if Build and Brackets then
                        if A is TExprArgument then
                         TExprArgument(A).SetBrackets
                        else
                         A:=TExprRound.Create(A);
                       if Comma then
                         D:=ExprString(EExpression)
                       else
                        D:=nil;
                       if Comma then
                        D2:=ExprString(EExpression)
                       else
                        D2:=nil;
                       if Build then
                        Result:=TExprIntegral.Create(A,D,D2,1)
                       else
                        Result:=nil
                      end else
      if M='INTM' then begin
                        K := iSVal;
                        LookForComma;
                        A:=ExprString(EArgument);
                        if Build and Brackets then
                         if A is TExprArgument then
                          TExprArgument(A).SetBrackets
                         else
                          A:=TExprRound.Create(A);
                        if Comma then
                         D:=ExprString(EExpression)
                        else
                         D:=nil;
                        if Comma then
                         D2:=ExprString(EExpression)
                        else
                         D2:=nil;
                        if Build then
                         Result:=TExprIntegral.Create(A,D,D2,K)
                        else
                         Result:=nil
                       end else
      if M='CASE' then begin
                        A:=ExprString(EExpression);
                        while Comma do
                         begin
                          D:=ExprString(EExpression);
                          if Build then
                           A.AddNext(D)
                         end;
                        if Build then
                         Result:=TExprCase.Create(A)
                        else
                         Result:=nil
                       end else
      if M='COMMA' then begin
                         K := iSVal;
                         if Build then
                          begin
                           Result:=TExprComma.Create;
                           Result.AddNext(TExprSpace.Create(K))
                          end
                         else
                          Result:=nil
                        end else
      if M='BRACKETS' then begin
                            LeftBr:=ebNone;
                            RightBr:=ebNone;
                            case SP of
                             Ord('('):LeftBr:=ebRound;
                             Ord('['):LeftBr:=ebSquare;
                             Ord('{'):LeftBr:=ebFigure;
                             Ord('|'):LeftBr:=ebModule;
                             Ord('0'):LeftBr:=ebNone
                            else
                             RaiseError('Ожидается знак открывающей скобки', P)
                            end;
                            Inc(P);
                            if P>=SL then
                             RaiseError('Незавершённая строка', SL);
                            case SP of
                             Ord(')'):RightBr:=ebRound;
                             Ord(']'):RightBr:=ebSquare;
                             Ord('}'):RightBr:=ebFigure;
                             Ord('|'):RightBr:=ebModule;
                             Ord('0'):RightBr:=ebNone
                            else
                             RaiseError('Ожидается знак закрывающей скобки', P)
                            end;
                            Inc(P);
                            LookForComma;
                            A:=ExprString(EExpression);
                            if Build then
                             Result:=TExprBracketed.Create(A,LeftBr,RightBr)
                            else
                             Result:=nil
                           end else
      if M='SYSTEM' then begin
                          D:=ExprString(EExpression);
                          while Comma do
                           begin
                            A:=ExprString(EExpression);
                            if Build then
                             D.AddNext(A)
                           end;
                          if Build then
                           Result:=TExprBracketed.Create(TExprStand.Create(D,ehLeft),ebFigure,ebNone)
                          else
                           Result:=nil
                         end else
      if M='SYSTEMR' then begin
                          D:=ExprString(EExpression);
                          while Comma do
                           begin
                            A:=ExprString(EExpression);
                            if Build then
                             D.AddNext(A)
                           end;
                          if Build then
                           Result:=TExprBracketed.Create(TExprStand.Create(D,ehLeft),ebNone,ebFigure)
                          else
                           Result:=nil
                         end else
      if M='NUM' then begin
                       X := eSVal;
                       Dig:=4;
                       MD:=2;
                       if Comma then
                        begin
                         Pr := iSVal;
                         if Comma then
                         begin
                           Dig := iSVal;
                           if Comma then
                            MD := iSVal;
                         end//Comma
                        end//Comma
                       else
                        Pr:=4;
                       if Build then
                        Result:=TExprExpNumber.Create(X,Pr,Dig,MD)
                       else
                        Result:=nil
                      end else
      if M='SYMBOL' then begin
                          K := iSVal;
                          if Build then
                           Result := TExprExtSymbol.Create(K)
                          else
                           Result:=nil
                         end else
      if M='XSYMBOL' then begin
                          K := iSVal;
                          if Build then
                           Result:=TExprCustomText.Create(AnsiChar(K),[],'Symbol')
                          else
                           Result:=nil
                         end else
      if M='ANGLE' then begin
                         if SPis('"') then
                          begin
                           Inc(P);
                           T:='';
                           repeat
                            if not SPis('"') then
                             T:=T+AnsiChar(SP)
                            else
                             if _S[P].IsA('"') then
                              begin
                               T:=T+'"';
                               Inc(P)
                              end;
                            Inc(P);
                            if P>=SL then
                             RaiseError('Незавершённая строка', SL);
                           until SPis('"');
                           Inc(P)
                          end
                         else
                          begin
                           T:='';
                           while not SPis(')') do
                            begin
                             T:=T+AnsiChar(SP);
                             Inc(P);
                             if P>=SL then
                              RaiseError('Незавершённая строка', SL)
                            end
                          end;
                         if Build then
                          begin
                           Result:=TExprSign.Create(esAngle);
                           Result.AddNext(TExprSimple.Create(T))
                          end
                         else
                          Result:=nil
                        end
      else
       begin
        D:=ExprString(EChain,True);
        {while Comma do
         begin
          A:=ExprString(EChain);
          if Build then
           begin
            D.AddNext(TExprComma.Create);
            D.AddNext(A)
           end
         end;}
        if Build then
         begin
          D:=TExprArgument.Create(D);
          if Brackets then
           TExprArgument(D).SetBrackets
         end;
        if FuncAutoIndex then
         DoFuncAutoIndex
        else
         if Build then
          begin
           GI:=GreekLetter(aName);
           if GI=0 then
            Result:=TExprFunc.Create(aName,D)
           else
            case GI of
             1:Result:=TExprCommonFunc.Create(TExprLambda.Create,D);
             2:Result:=TExprCommonFunc.Create(TExprNabla.Create,D)
            else
             Result:=TExprCommonFunc.Create(TExprExtSymbol.Create(GI),D)
            end
          end
         else
          Result:=nil
       end
     end;

   function TExprBuilder.Token;
    var M:AnsiString;
        GI:Integer;
     begin
      M:=UpperCase(N);
      GI:=GreekLetter(N);
      if GI<>0 then if Build then
                     case GI of
                      1:Result:=TExprLambda.Create;
                      2:Result:=TExprNabla.Create
                     else
                      Result:=TExprExtSymbol.Create(GI)
                     end
                    else
                     Result:=nil else
      if M='INF' then if Build then
                       Result:=TExprExtSymbol.Create(esInfinum)
                      else
                       Result:=nil else
      if M='PLANK' then if Build then
                         Result:=TExprPlank.Create
                        else
                         Result:=nil else
      if M='NIL' then if Build then
                       Result:=Tl3Expr.Create
                      else
                       Result:=nil else
      if M='COMMA' then if Build then
                         Result:=TExprComma.Create
                        else
                         Result:=nil else
      if M='CONST' then if Build then
                         begin
                          Result:=TExprSimple.Create(N);
                          Result.AddNext(TExprSpace.Create(3))
                         end
                        else
                         Result:=nil else
      if M='ASTERIX' then if Build then
                           Result:=TExprAsterix.Create
                          else
                           Result:=nil else
      if M='MINUS' then if Build then
                         Result:=TExprExtSymbol.Create(esMinus)
                        else
                         Result:=nil else
      if M='PARALLEL' then if Build then
                            Result:=TExprSign.Create(esParallel)
                           else
                            Result:=nil else
      if M='PERPENDICULAR' then if Build then
                                 Result:=TExprSign.Create(esPerpendicular)
                                else
                                 Result:=nil else
      if M='ANGLE' then if Build then
                         Result:=TExprSign.Create(esAngle)
                        else
                         Result:=nil else
      if M='EMPTY' then if Build then
                         Result:=TExprEmpty.Create
                        else
                         Result:=nil
      else
      if M='ANY' then
       if Build then
        Result := TExprCustomText.Create(#$22, [], 'Symbol')
       else
        Result := nil
      else
      if M='EXISTS' then
       if Build then
        Result := TExprCustomText.Create(#$24, [], 'Symbol')
       else
        Result := nil
      else
       if Build then
        if (N[1] in cc_ANSIEnglish) then
         Result := TExprVar.Create(N)
        else
         Result := TExprSimple.Create(N)
       else
        Result := nil
     end;

   function TExprBuilder.GreekLetter;
    var M:AnsiString;
        DS:Integer;
     begin
      M:=UpperCase(N);
      if (N[1] in cc_LoEnglish) then
       DS:=32
      else
       DS:=0;
      if M='ALPHA' then
         Result:=913+DS else
      if M='BETA' then
         Result:=914+DS else
      if M='GAMMA' then
         Result:=915+DS else
      if M='DELTA' then
         Result:=916+DS else
      if M='EPSILON' then
         Result:=917+DS else
      if M='ZETA' then
         Result:=918+DS else
      if M='ETA' then
         Result:=919+DS else
      if M='THETA' then
         Result:=920+DS else
      if M='IOTA' then
         Result:=921+DS else
      if M='KAPPA' then
         Result:=922+DS else
      if M='LAMBDA' then
         Result:=923+DS else
      if M='MU' then
         Result:=924+DS else
      if M='NU' then
         Result:=925+DS else
      if M='XI' then
         Result:=926+DS else
      if M='OMICRON' then
         Result:=927+DS else
      if M='PI' then
         Result:=928+DS else
      if M='RHO' then
         Result:=929+DS else
      if M='SIGMA' then
         Result:=931+DS else
      if M='TAU' then
         Result:=932+DS else
      if M='UPSILON' then
         Result:=933+DS else
      if M='PHI' then
         Result:=934+DS else
      if M='CHI' then
         Result:=935+DS else
      if M='PSI' then
         Result:=936+DS else
      if M='OMEGA' then
         Result:=937+DS else
      if M='PLAMBDA' then
         Result:=1 else
      if M='NABLA' then
         Result:=2 else
      Result:=0
     end;

function TExprBuilder.Comma;
begin
 Result:=SPis(',');
 if Result then
 begin
  Inc(P);
  while (P < SL) and (SPis(' ')) do
   Inc(P)
 end;//Result
end;

procedure TExprBuilder.LookForComma;
begin
 if not Comma then
  RaiseError('Ожидается ","', P)
end;

function TExprBuilder.SafeBuildExpr(const anExpr : AnsiString): Tl3Expr;
begin
 PreProcess(anExpr);
 _S.Add(' ', Length(anExpr)+1);
 Build := false;
 P := 1;
 ExprString(EExpression, true);
 Build := true;
 P := 1;
 Result := ExprString(EExpression, true);
end;

procedure TExprBuilder.RaiseError(aMessage: AnsiString; aPosition: Integer);
var
 l_RealLength: Integer;
begin
 l_RealLength := SL-1; // это потому, что ExprMaker добавляет свой пробел после строки
 if aPosition > l_RealLength then
  aPosition := l_RealLength;
 raise EIncorrectExpr.Create(aMessage, _S[aPosition-1].rPos);
end;

function TExprBuilder.SL: Integer;
begin
 Result := _S.Count;
end;

function TExprBuilder.SP: Integer;
begin
 Result := _S[P-1].rChar;
end;

function TExprBuilder.SPis(aChar: TOp): Boolean;
  //overload;
begin
 Result := (SP = Ord(aChar));
end;

function TExprBuilder.SPis(aChar: AnsiChar): Boolean;
begin
 Result := (SP = Ord(aChar));
end;

function TExprBuilder.SPinc(aSet   : TCharset;
                            anOps  : TOpSet = [];
                            aMyOps : TMyOpSet = []): Boolean;
var
 l_V : Integer;
begin
 l_V := SP;
 if (l_V < 0) then
 begin
  l_V := -l_V;
  Result := ((l_V <= Ord(High(TMyOp))) AND (TMyOp(l_V) in aMyOps));
 end//l_V < 0
 else
 if (l_V > 255) then
  Result := false
 else
  Result := ((AnsiChar(l_V) in aSet) OR
             ((l_V <= Ord(High(TOp))) AND (TOp(l_V) in anOps)));
end;

function TExprBuilder.SCopy(aCount: Integer = High(Integer)): AnsiString;
var
 l_P : Integer;
 l_L : Integer;
begin
 Result := '';
 l_P := P-1;
 l_L := SL;
 while (l_P < l_L) AND (aCount > 0) do
 begin
  Result := Result + AnsiChar(_S[l_P].rChar);
  Inc(l_P);
  Dec(aCount);
 end;//while (l_P < l_L) AND (aCount > 0)
end;

function TExprBuilder.SCopyFrom(aPos: Integer; aCount: Integer = High(Integer)): AnsiString;
var
 l_P : Integer;
 l_L : Integer;
begin
 Result := '';
 l_P := aPos-1;
 l_L := SL;
 while (l_P < l_L) AND (aCount > 0) do
 begin
  Result := Result + AnsiChar(_S[l_P].rChar);
  Inc(l_P);
  Dec(aCount);
 end;//while (l_P < l_L) AND (aCount > 0)
end;

function TExprBuilder.iSVal: Integer;
  //overload;
  {-}
var
 B : Integer;
 theEnd : Integer;
begin
 Val(sCopy, Result, B);
 if (B = 1) then
  RaiseError('Ожидается число', P);
 theEnd := B;
 Val(SCopy(theEnd-1), Result, B);
 if (B > 0) then
  RaiseError('Ожидается число', P);
 //Assert(B = 0);
 Inc(P,theEnd-1);
end;

function TExprBuilder.eSVal: Extended;
  //overload;
  {-}
var
 B : Integer;
 theEnd : Integer;
begin
 Val(sCopy, Result, B);
 if (B = 1) then
  RaiseError('Ожидается число', P);
 theEnd := B;
 Val(SCopy(theEnd-1), Result, B);
 if (B > 0) then
  RaiseError('Ожидается число', P);
 // Assert(B = 0);
 Inc(P,theEnd-1);
end;

function SafeBuildExpr(const Expr : AnsiString): TExprContainer;
var
 Builder : TExprBuilder;
begin
 Builder := TExprBuilder.Create;
 try
  Result := TExprContainer.Create(Builder.SafeBuildExpr(Expr));
 finally
  l3Free(Builder);
 end;//try..finally
end;

// start class EIncorrectExpr

constructor EIncorrectExpr.Create(const aMessage: AnsiString; aPosition: Integer);
begin
 inherited CreateFmt(aMessage + ' (позиция %d).', [aPosition]);
 f_Position := aPosition;
end;

// start class Tl3StringEx

procedure Tl3StringEx.Add(aChar: Integer; aPos : Integer);
  //overload;
  {-}
begin
 inherited Add(TexprTokenInfo_C(aChar, aPos));
end;

procedure Tl3StringEx.Add(aChar: AnsiChar; aPos : Integer);
  {-}
begin
 inherited Add(TexprTokenInfo_C(Ord(aChar), aPos));
end;

procedure Tl3StringEx.Add(anOp: TOp; var I: Integer);
  //overload;
  {-}
begin
 Assert(anOp <> opNULL);
 inherited Add(TexprTokenInfo_C(Ord(anOp), I));
 Inc(I);
end;

procedure Tl3StringEx.Add(anOp: TMyOp; aPos : Integer);
  //overload;
  {-}
begin
 Add(anOp, aPos, nil);
end;

procedure Tl3StringEx.Add(anOp: TMyOp; var aPos : Integer; anInc : Integer);
  //overload;
  {-}
begin
 Add(anOp, aPos, nil);
 Inc(aPos, anInc);
end;

procedure Tl3StringEx.Add(const aString: AnsiString; aPos : Integer);
  //overload;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 1 to Length(aString) do
  Add(aString[l_Index], aPos + l_Index - 1);
end;

procedure Tl3StringEx.Add(anOp: TMyOp; aPos : Integer; const aString: Il3CString);
  //overload;
  {-}
begin
 Assert(anOp <> opMyNULL);
 inherited Add(TexprTokenInfo_C(-Ord(anOp), aPos, aString));
end;

end.
