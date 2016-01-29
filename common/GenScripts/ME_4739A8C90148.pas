unit ExprMake;

interface

uses
 l3IntfUses
 , ExprDraw
 , l3Base
 , exprTokensList
;

type
 EIncorrectExpr = class
  {* Во время разбора формулы обнаружена синтаксическая ошибка. }
 end;//EIncorrectExpr
 
 TExprBuilder = class(Tl3Base)
  {* Библиотека содержит класс TExprBuilder, который строит дерево выражения по строке, содержащей
выражение в текстовом виде. Подробно синтаксис исходного выражения с примерами разобран в программе
ExprGuide.

Класс TExprBuilder имеет две функции для построения выражений: BuildExpr и SafeBuildExpr. Обе эти
функции в качестве параметра принимают строку и возвращают указатель на корень построенного дерева.
Если выражение содержит ошибки, возникает исключение EIncorrectExpr. Если исключение возникло во
время работы функции BuildExpr, в памяти остаётся мусор от частично построенного дерева, поэтому
функцией BuildExpr можно пользоваться только для заведомо корректных строк. Функция SafeBuildExpr
сначала осуществляет прогонку алгоритма построения дерева вхолостую. На этом этапе дерево не строится,
но исключения при неверном синтаксисе возникают. И только если первый этап пройден успешно, функция
приступает к следующему этапу: построению дерева. Дерево, созданное в результате работы функций
BuildExpr и SafeBuidExpr, после использования надо освободить, вызвав Free. }
  procedure RaiseError(const aMessage: AnsiString;
   aPosition: Integer);
  function Preprocess(const S: AnsiString): AnsiString;
  procedure AddMult(var Existing: Tl3Expr;
   Multiplier: Tl3Expr);
  function MakePower(Base: Tl3Expr;
   Exponent: Tl3Expr): Tl3Expr;
  function MakeIndex(Base: Tl3Expr;
   Index: Tl3Expr): Tl3Expr;
  function MakeCap(Base: Tl3Expr;
   Style: TExprCapStyle;
   N: Integer): Tl3Expr;
  procedure Decorate(var Base: Tl3Expr);
  function ExprString(Need: Integer;
   AllowComma: Boolean): Tl3Expr;
  function BoolExpr(var Flags: Integer): Tl3Expr;
  function Expr(var Flags: Integer): Tl3Expr;
  function Factor(var Flags: Integer): Tl3Expr;
  function Trans(var Flags: Integer): Tl3Expr;
  function Func(var Flags: Integer): Tl3Expr;
  function FuncName(const N: AnsiString;
   var Flags: Integer;
   Brackets: Boolean): Tl3Expr;
  function Token(N: PAnsiChar;
   var Flags: Integer): Tl3Expr;
  function GreekLetter(const N: AnsiString): Integer;
  function Comma: Boolean;
  procedure LookForComma;
  function BuildExpr(const Expr: AnsiString): Tl3Expr;
  function SafeBuildExpr(const Expr: AnsiString): Tl3Expr;
  procedure Create;
 end;//TExprBuilder
 
 Tl3StringEx = class(TexprTokensList)
 end;//Tl3StringEx
 
implementation

uses
 l3ImplUses
;

end.
