unit ddRTFUnits;

// Модуль: "w:\common\components\rtl\Garant\dd\ddRTFUnits.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddRTFUnits" MUID: (521AFA27009B)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
;

function Inch2Pixel(aInch: Integer;
 aDPI: Integer = 96): Integer;
function Inch2Point(aInch: Integer): Integer;
function Inch2Twip(aInch: Integer): Integer;
function Pixel2Inch(aPixel: Integer;
 aDPI: Integer = 96): Integer;
function Pixel2Twip(aPixels: Integer;
 aDPI: Integer = 96): Integer;
function Point2Inch(aPoints: Integer): Integer;
function Twip2Inch(aTwip: Integer): Integer;
function Twip2Pixel(aTwips: Integer;
 aDPI: Integer = 96): Integer;

implementation

uses
 l3ImplUses
 , l3Math
 , RTFtypes
;

function Inch2Pixel(aInch: Integer;
 aDPI: Integer = 96): Integer;
//#UC START# *521AFAF9024B_521AFA27009B_var*
//#UC END# *521AFAF9024B_521AFA27009B_var*
begin
//#UC START# *521AFAF9024B_521AFA27009B_impl*
 Result := aDPI * aInch
//#UC END# *521AFAF9024B_521AFA27009B_impl*
end;//Inch2Pixel

function Inch2Point(aInch: Integer): Integer;
//#UC START# *521AFB2401E5_521AFA27009B_var*
//#UC END# *521AFB2401E5_521AFA27009B_var*
begin
//#UC START# *521AFB2401E5_521AFA27009B_impl*
 Result := aInch div 72;
//#UC END# *521AFB2401E5_521AFA27009B_impl*
end;//Inch2Point

function Inch2Twip(aInch: Integer): Integer;
//#UC START# *521AFB3F0168_521AFA27009B_var*
//#UC END# *521AFB3F0168_521AFA27009B_var*
begin
//#UC START# *521AFB3F0168_521AFA27009B_impl*
 Result := rtfTwip * aInch
//#UC END# *521AFB3F0168_521AFA27009B_impl*
end;//Inch2Twip

function Pixel2Inch(aPixel: Integer;
 aDPI: Integer = 96): Integer;
//#UC START# *521AFB5E039F_521AFA27009B_var*
//#UC END# *521AFB5E039F_521AFA27009B_var*
begin
//#UC START# *521AFB5E039F_521AFA27009B_impl*
 Result := aPixel div aDPI;
//#UC END# *521AFB5E039F_521AFA27009B_impl*
end;//Pixel2Inch

function Pixel2Twip(aPixels: Integer;
 aDPI: Integer = 96): Integer;
//#UC START# *521AFB8401C4_521AFA27009B_var*
//#UC END# *521AFB8401C4_521AFA27009B_var*
begin
//#UC START# *521AFB8401C4_521AFA27009B_impl*
 Result := l3MulDiv(aPixels, rtfTwip, aDPI);
//#UC END# *521AFB8401C4_521AFA27009B_impl*
end;//Pixel2Twip

function Point2Inch(aPoints: Integer): Integer;
//#UC START# *521AFBA60106_521AFA27009B_var*
//#UC END# *521AFBA60106_521AFA27009B_var*
begin
//#UC START# *521AFBA60106_521AFA27009B_impl*
 Result:= aPoints * 72;
//#UC END# *521AFBA60106_521AFA27009B_impl*
end;//Point2Inch

function Twip2Inch(aTwip: Integer): Integer;
//#UC START# *521AFBC702B5_521AFA27009B_var*
//#UC END# *521AFBC702B5_521AFA27009B_var*
begin
//#UC START# *521AFBC702B5_521AFA27009B_impl*
 Result := aTwip div rtfTwip
//#UC END# *521AFBC702B5_521AFA27009B_impl*
end;//Twip2Inch

function Twip2Pixel(aTwips: Integer;
 aDPI: Integer = 96): Integer;
//#UC START# *521AFBE20296_521AFA27009B_var*
//#UC END# *521AFBE20296_521AFA27009B_var*
begin
//#UC START# *521AFBE20296_521AFA27009B_impl*
 Result:= l3MulDiv(aTwips, aDPI, rtfTwip);
//#UC END# *521AFBE20296_521AFA27009B_impl*
end;//Twip2Pixel

end.
