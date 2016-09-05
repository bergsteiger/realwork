unit l3UnitsTools;

// Модуль: "w:\common\components\rtl\Garant\L3\l3UnitsTools.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3UnitsTools" MUID: (4A3918BB0114)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

function evInch2Char(aPixel: LongInt): LongInt;
function evChar2Inch(aChar: LongInt): LongInt;
function l3Cm2Inch(aCm: LongInt): LongInt;
function evPixel2Cm(anInch: LongInt): LongInt;
function evCellWidthEpsilon: Integer;
 {* Погрешность выравнивания ячеек в дюймах (соотвествует ширине символа). }
function EvHalfCellWidthEpsilon: Integer;
function l3FrameLinesDelta: Integer;
 {* Величина, используемая при выравнивании линий в FrameLines }
function evGetMinimalCellWidth: Integer;
 {* Возвращает минимально допустимую ширину ячейки. }

implementation

uses
 l3ImplUses
 , l3Math
 , l3Defaults
 , l3Const
 //#UC START# *4A3918BB0114impl_uses*
 //#UC END# *4A3918BB0114impl_uses*
;

var g_CWEpsilon: Integer = 0;
var g_CWEpsilon_div2: Integer = 0;

const
 cnMaxPredefChars = 73;

procedure CheckEpsilonParams;
//#UC START# *4F2A42D00142_4A3918BB0114_var*
//#UC END# *4F2A42D00142_4A3918BB0114_var*
begin
//#UC START# *4F2A42D00142_4A3918BB0114_impl*
 if g_CWEpsilon = 0 then
 begin
  g_CWEpsilon := evChar2Inch(1);
  g_CWEpsilon_div2 := g_CWEpsilon div 2;
  //g_BoundAlignment := g_CWEpsilon * 4;
 end; // if g_CWEpsilon = 0 then
//#UC END# *4F2A42D00142_4A3918BB0114_impl*
end;//CheckEpsilonParams

function evInch2Char(aPixel: LongInt): LongInt;
//#UC START# *4F2A3430033F_4A3918BB0114_var*
//#UC END# *4F2A3430033F_4A3918BB0114_var*
begin
//#UC START# *4F2A3430033F_4A3918BB0114_impl*
 Result := l3MulDiv(aPixel, cnMaxPredefChars, def_inchPrintableWidth);
//#UC END# *4F2A3430033F_4A3918BB0114_impl*
end;//evInch2Char

function evChar2Inch(aChar: LongInt): LongInt;
//#UC START# *4F2A3451001B_4A3918BB0114_var*
//#UC END# *4F2A3451001B_4A3918BB0114_var*
begin
//#UC START# *4F2A3451001B_4A3918BB0114_impl*
 Result := l3MulDiv(aChar, def_inchPrintableWidth, cnMaxPredefChars);
//#UC END# *4F2A3451001B_4A3918BB0114_impl*
end;//evChar2Inch

function l3Cm2Inch(aCm: LongInt): LongInt;
//#UC START# *4F2A348600F9_4A3918BB0114_var*
//#UC END# *4F2A348600F9_4A3918BB0114_var*
begin
//#UC START# *4F2A348600F9_4A3918BB0114_impl*
 Result := l3MulDiv(aCm, l3Inch, l3mmInInch);
//#UC END# *4F2A348600F9_4A3918BB0114_impl*
end;//l3Cm2Inch

function evPixel2Cm(anInch: LongInt): LongInt;
//#UC START# *4F2A34B20068_4A3918BB0114_var*
//#UC END# *4F2A34B20068_4A3918BB0114_var*
begin
//#UC START# *4F2A34B20068_4A3918BB0114_impl*
 Result := l3MulDiv(anInch, l3mmInInch, l3Inch);
//#UC END# *4F2A34B20068_4A3918BB0114_impl*
end;//evPixel2Cm

function evCellWidthEpsilon: Integer;
 {* Погрешность выравнивания ячеек в дюймах (соотвествует ширине символа). }
//#UC START# *4F2A40EA0064_4A3918BB0114_var*
//#UC END# *4F2A40EA0064_4A3918BB0114_var*
begin
//#UC START# *4F2A40EA0064_4A3918BB0114_impl*
 CheckEpsilonParams;
 Result := g_CWEpsilon;
//#UC END# *4F2A40EA0064_4A3918BB0114_impl*
end;//evCellWidthEpsilon

function EvHalfCellWidthEpsilon: Integer;
//#UC START# *4F2A416E022B_4A3918BB0114_var*
//#UC END# *4F2A416E022B_4A3918BB0114_var*
begin
//#UC START# *4F2A416E022B_4A3918BB0114_impl*
 CheckEpsilonParams;
 Result := g_CWEpsilon_div2;
//#UC END# *4F2A416E022B_4A3918BB0114_impl*
end;//EvHalfCellWidthEpsilon

function l3FrameLinesDelta: Integer;
 {* Величина, используемая при выравнивании линий в FrameLines }
//#UC START# *4F2A554B0360_4A3918BB0114_var*
//#UC END# *4F2A554B0360_4A3918BB0114_var*
begin
//#UC START# *4F2A554B0360_4A3918BB0114_impl*
 CheckEpsilonParams;
 Result := g_CWEpsilon;
//#UC END# *4F2A554B0360_4A3918BB0114_impl*
end;//l3FrameLinesDelta

function evGetMinimalCellWidth: Integer;
 {* Возвращает минимально допустимую ширину ячейки. }
//#UC START# *5119E20703B0_4A3918BB0114_var*
//#UC END# *5119E20703B0_4A3918BB0114_var*
begin
//#UC START# *5119E20703B0_4A3918BB0114_impl*
 Result := evCellWidthEpsilon;
//#UC END# *5119E20703B0_4A3918BB0114_impl*
end;//evGetMinimalCellWidth

end.
