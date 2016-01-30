unit NOT_FINISHED_ExprMake;
 {* Глобальные методы для разбора формул. }

// Модуль: "w:\common\components\rtl\external\Expr\NOT_FINISHED_ExprMake.pas"
// Стереотип: "UtilityPack"

{$Include l3Define.inc}

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
  protected
   Build: Boolean;
   P: Integer;
   S: AnsiString;
  public
   FuncAutoIndex: Boolean;
   VarAutoIndex: Boolean;
   PostSymbols: Boolean;
  private
   procedure RaiseError(const aMessage: AnsiString;
    aPosition: Integer); virtual;
  protected
   function Preprocess(const S: AnsiString): AnsiString; virtual;
   procedure AddMult(var Existing: Tl3Expr;
    Multiplier: Tl3Expr); virtual;
   function MakePower(Base: Tl3Expr;
    Exponent: Tl3Expr): Tl3Expr; virtual;
   function MakeIndex(Base: Tl3Expr;
    Index: Tl3Expr): Tl3Expr; virtual;
   function MakeCap(Base: Tl3Expr;
    Style: TExprCapStyle;
    N: Integer): Tl3Expr; virtual;
   procedure Decorate(var Base: Tl3Expr); virtual;
   function ExprString(Need: Integer;
    AllowComma: Boolean = False): Tl3Expr; virtual;
   function BoolExpr(var Flags: Integer): Tl3Expr; virtual;
   function Expr(var Flags: Integer): Tl3Expr; virtual;
   function Factor(var Flags: Integer): Tl3Expr; virtual;
   function Trans(var Flags: Integer): Tl3Expr; virtual;
   function Func(var Flags: Integer): Tl3Expr; virtual;
   function FuncName(const N: AnsiString;
    var Flags: Integer;
    Brackets: Boolean): Tl3Expr; virtual;
   function Token(N: PAnsiChar;
    var Flags: Integer): Tl3Expr; virtual;
   function GreekLetter(const N: AnsiString): Integer; virtual;
   function Comma: Boolean; virtual;
   procedure LookForComma; virtual;
  public
   function BuildExpr(const Expr: AnsiString): Tl3Expr; virtual;
   function SafeBuildExpr(const Expr: AnsiString): Tl3Expr; virtual;
   constructor Create; reintroduce; virtual;
 end;//TExprBuilder

 Tl3StringEx = class(TexprTokensList)
 end;//Tl3StringEx

function BuildExpr(const Expr: AnsiString): Tl3Expr; { can raise EIncorrectExpr }
 {* Разбирает формулу. Строит дерево разбора. Может возбуждать исключение. }
function SafeBuildExpr(const Expr: AnsiString): Tl3Expr;
 {* Разбирает формулу. Строит дерево разбора. Не может возбуждать исключение. }

implementation

uses
 l3ImplUses
;

function BuildExpr(const Expr: AnsiString): Tl3Expr; { can raise EIncorrectExpr }
 {* Разбирает формулу. Строит дерево разбора. Может возбуждать исключение. }
//#UC START# *4739A90703E6_4739A8C90148_var*
//#UC END# *4739A90703E6_4739A8C90148_var*
begin
//#UC START# *4739A90703E6_4739A8C90148_impl*
 assert(false, 'BuildExpr not implemented');
//#UC END# *4739A90703E6_4739A8C90148_impl*
end;//BuildExpr

function SafeBuildExpr(const Expr: AnsiString): Tl3Expr;
 {* Разбирает формулу. Строит дерево разбора. Не может возбуждать исключение. }
//#UC START# *4739A9530128_4739A8C90148_var*
//#UC END# *4739A9530128_4739A8C90148_var*
begin
//#UC START# *4739A9530128_4739A8C90148_impl*
 assert(false, 'SafeBuildExpr not implemented');
//#UC END# *4739A9530128_4739A8C90148_impl*
end;//SafeBuildExpr

procedure TExprBuilder.RaiseError(const aMessage: AnsiString;
 aPosition: Integer);
//#UC START# *4739B7BB02D0_4739A0D8009C_var*
//#UC END# *4739B7BB02D0_4739A0D8009C_var*
begin
//#UC START# *4739B7BB02D0_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.RaiseError not implemented');
//#UC END# *4739B7BB02D0_4739A0D8009C_impl*
end;//TExprBuilder.RaiseError

function TExprBuilder.Preprocess(const S: AnsiString): AnsiString;
//#UC START# *4739B82302B2_4739A0D8009C_var*
//#UC END# *4739B82302B2_4739A0D8009C_var*
begin
//#UC START# *4739B82302B2_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Preprocess not implemented');
//#UC END# *4739B82302B2_4739A0D8009C_impl*
end;//TExprBuilder.Preprocess

procedure TExprBuilder.AddMult(var Existing: Tl3Expr;
 Multiplier: Tl3Expr);
//#UC START# *4739B83C0131_4739A0D8009C_var*
//#UC END# *4739B83C0131_4739A0D8009C_var*
begin
//#UC START# *4739B83C0131_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.AddMult not implemented');
//#UC END# *4739B83C0131_4739A0D8009C_impl*
end;//TExprBuilder.AddMult

function TExprBuilder.MakePower(Base: Tl3Expr;
 Exponent: Tl3Expr): Tl3Expr;
//#UC START# *4739B874036C_4739A0D8009C_var*
//#UC END# *4739B874036C_4739A0D8009C_var*
begin
//#UC START# *4739B874036C_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.MakePower not implemented');
//#UC END# *4739B874036C_4739A0D8009C_impl*
end;//TExprBuilder.MakePower

function TExprBuilder.MakeIndex(Base: Tl3Expr;
 Index: Tl3Expr): Tl3Expr;
//#UC START# *4739B890024A_4739A0D8009C_var*
//#UC END# *4739B890024A_4739A0D8009C_var*
begin
//#UC START# *4739B890024A_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.MakeIndex not implemented');
//#UC END# *4739B890024A_4739A0D8009C_impl*
end;//TExprBuilder.MakeIndex

function TExprBuilder.MakeCap(Base: Tl3Expr;
 Style: TExprCapStyle;
 N: Integer): Tl3Expr;
//#UC START# *4739B8A60328_4739A0D8009C_var*
//#UC END# *4739B8A60328_4739A0D8009C_var*
begin
//#UC START# *4739B8A60328_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.MakeCap not implemented');
//#UC END# *4739B8A60328_4739A0D8009C_impl*
end;//TExprBuilder.MakeCap

procedure TExprBuilder.Decorate(var Base: Tl3Expr);
//#UC START# *473C36980376_4739A0D8009C_var*
//#UC END# *473C36980376_4739A0D8009C_var*
begin
//#UC START# *473C36980376_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Decorate not implemented');
//#UC END# *473C36980376_4739A0D8009C_impl*
end;//TExprBuilder.Decorate

function TExprBuilder.ExprString(Need: Integer;
 AllowComma: Boolean = False): Tl3Expr;
//#UC START# *473C36B90107_4739A0D8009C_var*
//#UC END# *473C36B90107_4739A0D8009C_var*
begin
//#UC START# *473C36B90107_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.ExprString not implemented');
//#UC END# *473C36B90107_4739A0D8009C_impl*
end;//TExprBuilder.ExprString

function TExprBuilder.BoolExpr(var Flags: Integer): Tl3Expr;
//#UC START# *473C36C802F3_4739A0D8009C_var*
//#UC END# *473C36C802F3_4739A0D8009C_var*
begin
//#UC START# *473C36C802F3_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.BoolExpr not implemented');
//#UC END# *473C36C802F3_4739A0D8009C_impl*
end;//TExprBuilder.BoolExpr

function TExprBuilder.Expr(var Flags: Integer): Tl3Expr;
//#UC START# *473C36DF00ED_4739A0D8009C_var*
//#UC END# *473C36DF00ED_4739A0D8009C_var*
begin
//#UC START# *473C36DF00ED_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Expr not implemented');
//#UC END# *473C36DF00ED_4739A0D8009C_impl*
end;//TExprBuilder.Expr

function TExprBuilder.Factor(var Flags: Integer): Tl3Expr;
//#UC START# *473C36EB0040_4739A0D8009C_var*
//#UC END# *473C36EB0040_4739A0D8009C_var*
begin
//#UC START# *473C36EB0040_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Factor not implemented');
//#UC END# *473C36EB0040_4739A0D8009C_impl*
end;//TExprBuilder.Factor

function TExprBuilder.Trans(var Flags: Integer): Tl3Expr;
//#UC START# *473C37180135_4739A0D8009C_var*
//#UC END# *473C37180135_4739A0D8009C_var*
begin
//#UC START# *473C37180135_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Trans not implemented');
//#UC END# *473C37180135_4739A0D8009C_impl*
end;//TExprBuilder.Trans

function TExprBuilder.Func(var Flags: Integer): Tl3Expr;
//#UC START# *473C372C0152_4739A0D8009C_var*
//#UC END# *473C372C0152_4739A0D8009C_var*
begin
//#UC START# *473C372C0152_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Func not implemented');
//#UC END# *473C372C0152_4739A0D8009C_impl*
end;//TExprBuilder.Func

function TExprBuilder.FuncName(const N: AnsiString;
 var Flags: Integer;
 Brackets: Boolean): Tl3Expr;
//#UC START# *473C373E0311_4739A0D8009C_var*
//#UC END# *473C373E0311_4739A0D8009C_var*
begin
//#UC START# *473C373E0311_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.FuncName not implemented');
//#UC END# *473C373E0311_4739A0D8009C_impl*
end;//TExprBuilder.FuncName

function TExprBuilder.Token(N: PAnsiChar;
 var Flags: Integer): Tl3Expr;
//#UC START# *473C38AE03C4_4739A0D8009C_var*
//#UC END# *473C38AE03C4_4739A0D8009C_var*
begin
//#UC START# *473C38AE03C4_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Token not implemented');
//#UC END# *473C38AE03C4_4739A0D8009C_impl*
end;//TExprBuilder.Token

function TExprBuilder.GreekLetter(const N: AnsiString): Integer;
//#UC START# *473C38CB002C_4739A0D8009C_var*
//#UC END# *473C38CB002C_4739A0D8009C_var*
begin
//#UC START# *473C38CB002C_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.GreekLetter not implemented');
//#UC END# *473C38CB002C_4739A0D8009C_impl*
end;//TExprBuilder.GreekLetter

function TExprBuilder.Comma: Boolean;
//#UC START# *473C38DE02DD_4739A0D8009C_var*
//#UC END# *473C38DE02DD_4739A0D8009C_var*
begin
//#UC START# *473C38DE02DD_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Comma not implemented');
//#UC END# *473C38DE02DD_4739A0D8009C_impl*
end;//TExprBuilder.Comma

procedure TExprBuilder.LookForComma;
//#UC START# *473C38F1028A_4739A0D8009C_var*
//#UC END# *473C38F1028A_4739A0D8009C_var*
begin
//#UC START# *473C38F1028A_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.LookForComma not implemented');
//#UC END# *473C38F1028A_4739A0D8009C_impl*
end;//TExprBuilder.LookForComma

function TExprBuilder.BuildExpr(const Expr: AnsiString): Tl3Expr;
//#UC START# *473C390A0380_4739A0D8009C_var*
//#UC END# *473C390A0380_4739A0D8009C_var*
begin
//#UC START# *473C390A0380_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.BuildExpr not implemented');
//#UC END# *473C390A0380_4739A0D8009C_impl*
end;//TExprBuilder.BuildExpr

function TExprBuilder.SafeBuildExpr(const Expr: AnsiString): Tl3Expr;
//#UC START# *473C391B001D_4739A0D8009C_var*
//#UC END# *473C391B001D_4739A0D8009C_var*
begin
//#UC START# *473C391B001D_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.SafeBuildExpr not implemented');
//#UC END# *473C391B001D_4739A0D8009C_impl*
end;//TExprBuilder.SafeBuildExpr

constructor TExprBuilder.Create;
//#UC START# *473C393C00A7_4739A0D8009C_var*
//#UC END# *473C393C00A7_4739A0D8009C_var*
begin
//#UC START# *473C393C00A7_4739A0D8009C_impl*
 assert(false, 'TExprBuilder.Create not implemented');
//#UC END# *473C393C00A7_4739A0D8009C_impl*
end;//TExprBuilder.Create

end.
