{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.Bind.GenData"'}    {Do not Localize}
unit Data.Bind.GenData;

interface

const
  cContactsItemCount = 10;

implementation

uses 
  System.Classes, Data.Bind.Components,
    System.RTTI,
    Generics.Collections, System.SysUtils,  Data.Bind.ObjectScope,
    System.Math, System.UITypes, System.Types, System.DateUtils;

function GetLoremIpsum: TArray<string>; forward;
function GetIntegers: TArray<Integer>; forward;
function GetUIntegers: TArray<UInt32>; forward;
function GetSingles: TArray<Single>; forward;
function GetCurrency: TArray<Currency>; forward;
function GetDateTime: TArray<TDateTime>; forward;
function GetDate: TArray<TDate>; forward;
function GetTime: TArray<TTime>; forward;


const
  CColorNames: array[0..140] of string =
  (
'Antiquewhite', //    Antiquewhite = Alpha or TAlphaColor($FAEBD7);
// 'Aqua', //    Aqua = Alpha or TAlphaColor($00FFFF);
'Aquamarine', //    Aquamarine = Alpha or TAlphaColor($7FFFD4);
'Azure', //    Azure = Alpha or TAlphaColor($F0FFFF);
'Beige', //    Beige = Alpha or TAlphaColor($F5F5DC);
'Bisque', //    Bisque = Alpha or TAlphaColor($FFE4C4);
'Black', //    Black = Alpha or TAlphaColor($000000);
'Blanchedalmond', //    Blanchedalmond = Alpha or TAlphaColor($FFEBCD);
'Blue', //    Blue = Alpha or TAlphaColor($0000FF);
'Blueviolet', //    Blueviolet = Alpha or TAlphaColor($8A2BE2);
'Brown', //    Brown = Alpha or TAlphaColor($A52A2A);
'Burlywood', //    Burlywood = Alpha or TAlphaColor($DEB887);
'Cadetblue', //    Cadetblue = Alpha or TAlphaColor($5F9EA0);
'Chartreuse', //    Chartreuse = Alpha or TAlphaColor($7FFF00);
'Chocolate', //    Chocolate = Alpha or TAlphaColor($D2691E);
'Coral', //    Coral = Alpha or TAlphaColor($FF7F50);
'Cornflowerblue', //    Cornflowerblue = Alpha or TAlphaColor($6495ED);
'Cornsilk', //    Cornsilk = Alpha or TAlphaColor($FFF8DC);
'Cream', //    Cream = Alpha or TAlphaColor($F0FBFF);
'Crimson', //    Crimson = Alpha or TAlphaColor($DC143C);
'Cyan', //    Cyan = Alpha or TAlphaColor($00FFFF);
'Darkblue', //    Darkblue = Alpha or TAlphaColor($00008B);
'Darkcyan', //    Darkcyan = Alpha or TAlphaColor($008B8B);
'Darkgoldenrod', //    Darkgoldenrod = Alpha or TAlphaColor($B8860B);
//'Darkgray', //    Darkgray = Alpha or TAlphaColor($A9A9A9); // Duplicate of DarkGrey
'Darkgreen', //    Darkgreen = Alpha or TAlphaColor($006400);
'Darkgrey', //    Darkgrey = Alpha or TAlphaColor($A9A9A9);
'Darkkhaki', //    Darkkhaki = Alpha or TAlphaColor($BDB76B);
'Darkmagenta', //    Darkmagenta = Alpha or TAlphaColor($8B008B);
'Darkolivegreen', //    Darkolivegreen = Alpha or TAlphaColor($556B2F);
'Darkorange', //    Darkorange = Alpha or TAlphaColor($FF8C00);
'Darkorchid', //    Darkorchid = Alpha or TAlphaColor($9932CC);
'Darkred', //    Darkred = Alpha or TAlphaColor($8B0000);
'Darksalmon', //    Darksalmon = Alpha or TAlphaColor($E9967A);
'Darkseagreen', //    Darkseagreen = Alpha or TAlphaColor($8FBC8F);
'Darkslateblue', //    Darkslateblue = Alpha or TAlphaColor($483D8B);
// 'Darkslategray', //    Darkslategray = Alpha or TAlphaColor($2F4F4F); // Duplicate of DarkSlateGray
'Darkslategrey', //    Darkslategrey = Alpha or TAlphaColor($2F4F4F);
'Darkturquoise', //    Darkturquoise = Alpha or TAlphaColor($00CED1);
'Darkviolet', //    Darkviolet = Alpha or TAlphaColor($9400D3);
'Deeppink', //    Deeppink = Alpha or TAlphaColor($FF1493);
'Deepskyblue', //    Deepskyblue = Alpha or TAlphaColor($00BFFF);
// 'Dimgray', //    Dimgray = Alpha or TAlphaColor($696969); Duplicat of DimGrey
'Dimgrey', //    Dimgrey = Alpha or TAlphaColor($696969);
'Dodgerblue', //    Dodgerblue = Alpha or TAlphaColor($1E90FF);
'Firebrick', //    Firebrick = Alpha or TAlphaColor($B22222);
'Floralwhite', //    Floralwhite = Alpha or TAlphaColor($FFFAF0);
'Forestgreen', //    Forestgreen = Alpha or TAlphaColor($228B22);
// 'Fuchsia', //    Fuchsia = Alpha or TAlphaColor($FF00FF); // Duplicate of Magenta
'Gainsboro', //    Gainsboro = Alpha or TAlphaColor($DCDCDC);
'Ghostwhite', //    Ghostwhite = Alpha or TAlphaColor($F8F8FF);
'Gold', //    Gold = Alpha or TAlphaColor($FFD700);
'Goldenrod', //    Goldenrod = Alpha or TAlphaColor($DAA520);
//'Gray', //    Gray = Alpha or TAlphaColor($808080); // Duplicate of Gray
'Green', //    Green = Alpha or TAlphaColor($008000);
'Greenyellow', //    Greenyellow = Alpha or TAlphaColor($ADFF2F);
'Grey', //    Grey = Alpha or TAlphaColor($808080);
'Honeydew', //    Honeydew = Alpha or TAlphaColor($F0FFF0);
'Hotpink', //    Hotpink = Alpha or TAlphaColor($FF69B4);
'Indianred', //    Indianred = Alpha or TAlphaColor($CD5C5C);
'Indigo', //    Indigo = Alpha or TAlphaColor($4B0082);
'Ivory', //    Ivory = Alpha or TAlphaColor($FFFFF0);
'Khaki', //    Khaki = Alpha or TAlphaColor($F0E68C);
'Lavender', //    Lavender = Alpha or TAlphaColor($E6E6FA);
'Lavenderblush', //    Lavenderblush = Alpha or TAlphaColor($FFF0F5);
'Lawngreen', //    Lawngreen = Alpha or TAlphaColor($7CFC00);
'LegacySkyBlue', //    LegacySkyBlue = Alpha or TAlphaColor($F0CAA6);
'Lemonchiffon', //    Lemonchiffon = Alpha or TAlphaColor($FFFACD);
'Lightblue', //    Lightblue = Alpha or TAlphaColor($ADD8E6);
'Lightcoral', //    Lightcoral = Alpha or TAlphaColor($F08080);
'Lightcyan', //    Lightcyan = Alpha or TAlphaColor($E0FFFF);
'Lightgoldenrodyellow', //    Lightgoldenrodyellow = Alpha or TAlphaColor($FAFAD2);
// 'Lightgray', //    Lightgray = Alpha or TAlphaColor($D3D3D3); Duplicate of LightGray
'Lightgreen', //    Lightgreen = Alpha or TAlphaColor($90EE90);
'Lightgrey', //    Lightgrey = Alpha or TAlphaColor($D3D3D3);
'Lightpink', //    Lightpink = Alpha or TAlphaColor($FFB6C1);
'Lightsalmon', //    Lightsalmon = Alpha or TAlphaColor($FFA07A);
'Lightseagreen', //    Lightseagreen = Alpha or TAlphaColor($20B2AA);
'Lightskyblue', //    Lightskyblue = Alpha or TAlphaColor($87CEFA);
// 'Lightslategray', //    Lightslategray = Alpha or TAlphaColor($778899); // Duplicate of LightSlateGrey
'Lightslategrey', //    Lightslategrey = Alpha or TAlphaColor($778899);
'Lightsteelblue', //    Lightsteelblue = Alpha or TAlphaColor($B0C4DE);
'Lightyellow', //    Lightyellow = Alpha or TAlphaColor($FFFFE0);
'Lime', //    Lime = Alpha or TAlphaColor($00FF00);
'Limegreen', //    Limegreen = Alpha or TAlphaColor($32CD32);
'Linen', //    Linen = Alpha or TAlphaColor($FAF0E6);
'LtGray', //    LtGray = Alpha or TAlphaColor($C0C0C0);
//'DkGray', //    DkGray = Alpha or TAlphaColor($808080);
'Magenta', //    Magenta = Alpha or TAlphaColor($FF00FF);
'Maroon', //    Maroon = Alpha or TAlphaColor($800000);
'MedGray', //    MedGray = Alpha or TAlphaColor($A0A0A0);
'Mediumaquamarine', //    Mediumaquamarine = Alpha or TAlphaColor($66CDAA);
'Mediumblue', //    Mediumblue = Alpha or TAlphaColor($0000CD);
'Mediumorchid', //    Mediumorchid = Alpha or TAlphaColor($BA55D3);
'Mediumpurple', //    Mediumpurple = Alpha or TAlphaColor($9370DB);
'Mediumseagreen', //    Mediumseagreen = Alpha or TAlphaColor($3CB371);
'Mediumslateblue', //    Mediumslateblue = Alpha or TAlphaColor($7B68EE);
'Mediumspringgreen', //    Mediumspringgreen = Alpha or TAlphaColor($00FA9A);
'Mediumturquoise', //    Mediumturquoise = Alpha or TAlphaColor($48D1CC);
'Mediumvioletred', //    Mediumvioletred = Alpha or TAlphaColor($C71585);
'Midnightblue', //    Midnightblue = Alpha or TAlphaColor($191970);
'Mintcream', //    Mintcream = Alpha or TAlphaColor($F5FFFA);
'Mistyrose', //    Mistyrose = Alpha or TAlphaColor($FFE4E1);
'Moccasin', //    Moccasin = Alpha or TAlphaColor($FFE4B5);
'MoneyGreen', //    MoneyGreen = Alpha or TAlphaColor($C0DCC0);
'Navajowhite', //    Navajowhite = Alpha or TAlphaColor($FFDEAD);
'Navy', //    Navy = Alpha or TAlphaColor($000080);
'Oldlace', //    Oldlace = Alpha or TAlphaColor($FDF5E6);
'Olive', //    Olive = Alpha or TAlphaColor($808000);
'Olivedrab', //    Olivedrab = Alpha or TAlphaColor($6B8E23);
'Orange', //    Orange = Alpha or TAlphaColor($FFA500);
'Orangered', //    Orangered = Alpha or TAlphaColor($FF4500);
'Orchid', //    Orchid = Alpha or TAlphaColor($DA70D6);
'Palegoldenrod', //    Palegoldenrod = Alpha or TAlphaColor($EEE8AA);
'Palegreen', //    Palegreen = Alpha or TAlphaColor($98FB98);
'Paleturquoise', //    Paleturquoise = Alpha or TAlphaColor($AFEEEE);
'Palevioletred', //    Palevioletred = Alpha or TAlphaColor($DB7093);
'Papayawhip', //    Papayawhip = Alpha or TAlphaColor($FFEFD5);
'Peachpuff', //    Peachpuff = Alpha or TAlphaColor($FFDAB9);
'Peru', //    Peru = Alpha or TAlphaColor($CD853F);
'Pink', //    Pink = Alpha or TAlphaColor($FFC0CB);
'Plum', //    Plum = Alpha or TAlphaColor($DDA0DD);
'Powderblue', //    Powderblue = Alpha or TAlphaColor($B0E0E6);
'Purple', //    Purple = Alpha or TAlphaColor($800080);
'Red', //    Red = Alpha or TAlphaColor($FF0000);
'Rosybrown', //    Rosybrown = Alpha or TAlphaColor($BC8F8F);
'Royalblue', //    Royalblue = Alpha or TAlphaColor($4169E1);
'Saddlebrown', //    Saddlebrown = Alpha or TAlphaColor($8B4513);
'Salmon', //    Salmon = Alpha or TAlphaColor($FA8072);
'Sandybrown', //    Sandybrown = Alpha or TAlphaColor($F4A460);
'Seagreen', //    Seagreen = Alpha or TAlphaColor($2E8B57);
'Seashell', //    Seashell = Alpha or TAlphaColor($FFF5EE);
'Sienna', //    Sienna = Alpha or TAlphaColor($A0522D);
//'Silver', //    Silver = Alpha or TAlphaColor($C0C0C0); duplicate of ltgrey
'Skyblue', //    Skyblue = Alpha or TAlphaColor($87CEEB);
'Slateblue', //    Slateblue = Alpha or TAlphaColor($6A5ACD);
// 'Slategray', //    Slategray = Alpha or TAlphaColor($708090); Duplicate of SlateGray
'Slategrey', //    Slategrey = Alpha or TAlphaColor($708090);
'Snow', //    Snow = Alpha or TAlphaColor($FFFAFA);
'Springgreen', //    Springgreen = Alpha or TAlphaColor($00FF7F);
'Steelblue', //    Steelblue = Alpha or TAlphaColor($4682B4);
'Tan', //    Tan = Alpha or TAlphaColor($D2B48C);
'Teal', //    Teal = Alpha or TAlphaColor($008080);
'Thistle', //    Thistle = Alpha or TAlphaColor($D8BFD8);
'Tomato', //    Tomato = Alpha or TAlphaColor($FF6347);
'Turquoise', //    Turquoise = Alpha or TAlphaColor($40E0D0);
'Violet', //    Violet = Alpha or TAlphaColor($EE82EE);
'Wheat', //    Wheat = Alpha or TAlphaColor($F5DEB3);
'White', //    White = Alpha or TAlphaColor($FFFFFF);
'Whitesmoke', //    Whitesmoke = Alpha or TAlphaColor($F5F5F5);
'Yellow', //    Yellow = Alpha or TAlphaColor($FFFF00);
'Yellowgreen' //    Yellowgreen = Alpha or TAlphaColor($9ACD32);
  );

  CAlphaColorValues: array[0..140] of TAlphaColor =
  (
TAlphaColorRec.Antiquewhite, //    Antiquewhite = Alpha or TAlphaColor($FAEBD7);
//TAlphaColorRec.Aqua, //    Aqua = Alpha or TAlphaColor($00FFFF);
TAlphaColorRec.Aquamarine, //    Aquamarine = Alpha or TAlphaColor($7FFFD4);
TAlphaColorRec.Azure, //    Azure = Alpha or TAlphaColor($F0FFFF);
TAlphaColorRec.Beige, //    Beige = Alpha or TAlphaColor($F5F5DC);
TAlphaColorRec.Bisque, //    Bisque = Alpha or TAlphaColor($FFE4C4);
TAlphaColorRec.Black, //    Black = Alpha or TAlphaColor($000000);
TAlphaColorRec.Blanchedalmond, //    Blanchedalmond = Alpha or TAlphaColor($FFEBCD);
TAlphaColorRec.Blue, //    Blue = Alpha or TAlphaColor($0000FF);
TAlphaColorRec.Blueviolet, //    Blueviolet = Alpha or TAlphaColor($8A2BE2);
TAlphaColorRec.Brown, //    Brown = Alpha or TAlphaColor($A52A2A);
TAlphaColorRec.Burlywood, //    Burlywood = Alpha or TAlphaColor($DEB887);
TAlphaColorRec.Cadetblue, //    Cadetblue = Alpha or TAlphaColor($5F9EA0);
TAlphaColorRec.Chartreuse, //    Chartreuse = Alpha or TAlphaColor($7FFF00);
TAlphaColorRec.Chocolate, //    Chocolate = Alpha or TAlphaColor($D2691E);
TAlphaColorRec.Coral, //    Coral = Alpha or TAlphaColor($FF7F50);
TAlphaColorRec.Cornflowerblue, //    Cornflowerblue = Alpha or TAlphaColor($6495ED);
TAlphaColorRec.Cornsilk, //    Cornsilk = Alpha or TAlphaColor($FFF8DC);
TAlphaColorRec.Cream, //    Cream = Alpha or TAlphaColor($F0FBFF);
TAlphaColorRec.Crimson, //    Crimson = Alpha or TAlphaColor($DC143C);
TAlphaColorRec.Cyan, //    Cyan = Alpha or TAlphaColor($00FFFF);
TAlphaColorRec.Darkblue, //    Darkblue = Alpha or TAlphaColor($00008B);
TAlphaColorRec.Darkcyan, //    Darkcyan = Alpha or TAlphaColor($008B8B);
TAlphaColorRec.Darkgoldenrod, //    Darkgoldenrod = Alpha or TAlphaColor($B8860B);
//TAlphaColorRec.Darkgray, //    Darkgray = Alpha or TAlphaColor($A9A9A9);
TAlphaColorRec.Darkgreen, //    Darkgreen = Alpha or TAlphaColor($006400);
TAlphaColorRec.Darkgrey, //    Darkgrey = Alpha or TAlphaColor($A9A9A9);
TAlphaColorRec.Darkkhaki, //    Darkkhaki = Alpha or TAlphaColor($BDB76B);
TAlphaColorRec.Darkmagenta, //    Darkmagenta = Alpha or TAlphaColor($8B008B);
TAlphaColorRec.Darkolivegreen, //    Darkolivegreen = Alpha or TAlphaColor($556B2F);
TAlphaColorRec.Darkorange, //    Darkorange = Alpha or TAlphaColor($FF8C00);
TAlphaColorRec.Darkorchid, //    Darkorchid = Alpha or TAlphaColor($9932CC);
TAlphaColorRec.Darkred, //    Darkred = Alpha or TAlphaColor($8B0000);
TAlphaColorRec.Darksalmon, //    Darksalmon = Alpha or TAlphaColor($E9967A);
TAlphaColorRec.Darkseagreen, //    Darkseagreen = Alpha or TAlphaColor($8FBC8F);
TAlphaColorRec.Darkslateblue, //    Darkslateblue = Alpha or TAlphaColor($483D8B);
//TAlphaColorRec.Darkslategray, //    Darkslategray = Alpha or TAlphaColor($2F4F4F);
TAlphaColorRec.Darkslategrey, //    Darkslategrey = Alpha or TAlphaColor($2F4F4F);
TAlphaColorRec.Darkturquoise, //    Darkturquoise = Alpha or TAlphaColor($00CED1);
TAlphaColorRec.Darkviolet, //    Darkviolet = Alpha or TAlphaColor($9400D3);
TAlphaColorRec.Deeppink, //    Deeppink = Alpha or TAlphaColor($FF1493);
TAlphaColorRec.Deepskyblue, //    Deepskyblue = Alpha or TAlphaColor($00BFFF);
//TAlphaColorRec.Dimgray, //    Dimgray = Alpha or TAlphaColor($696969);
TAlphaColorRec.Dimgrey, //    Dimgrey = Alpha or TAlphaColor($696969);
TAlphaColorRec.Dodgerblue, //    Dodgerblue = Alpha or TAlphaColor($1E90FF);
TAlphaColorRec.Firebrick, //    Firebrick = Alpha or TAlphaColor($B22222);
TAlphaColorRec.Floralwhite, //    Floralwhite = Alpha or TAlphaColor($FFFAF0);
TAlphaColorRec.Forestgreen, //    Forestgreen = Alpha or TAlphaColor($228B22);
// TAlphaColorRec.Fuchsia, //    Fuchsia = Alpha or TAlphaColor($FF00FF);
TAlphaColorRec.Gainsboro, //    Gainsboro = Alpha or TAlphaColor($DCDCDC);
TAlphaColorRec.Ghostwhite, //    Ghostwhite = Alpha or TAlphaColor($F8F8FF);
TAlphaColorRec.Gold, //    Gold = Alpha or TAlphaColor($FFD700);
TAlphaColorRec.Goldenrod, //    Goldenrod = Alpha or TAlphaColor($DAA520);
//TAlphaColorRec.Gray, //    Gray = Alpha or TAlphaColor($808080);
TAlphaColorRec.Green, //    Green = Alpha or TAlphaColor($008000);
TAlphaColorRec.Greenyellow, //    Greenyellow = Alpha or TAlphaColor($ADFF2F);
TAlphaColorRec.Grey, //    Grey = Alpha or TAlphaColor($808080);
TAlphaColorRec.Honeydew, //    Honeydew = Alpha or TAlphaColor($F0FFF0);
TAlphaColorRec.Hotpink, //    Hotpink = Alpha or TAlphaColor($FF69B4);
TAlphaColorRec.Indianred, //    Indianred = Alpha or TAlphaColor($CD5C5C);
TAlphaColorRec.Indigo, //    Indigo = Alpha or TAlphaColor($4B0082);
TAlphaColorRec.Ivory, //    Ivory = Alpha or TAlphaColor($FFFFF0);
TAlphaColorRec.Khaki, //    Khaki = Alpha or TAlphaColor($F0E68C);
TAlphaColorRec.Lavender, //    Lavender = Alpha or TAlphaColor($E6E6FA);
TAlphaColorRec.Lavenderblush, //    Lavenderblush = Alpha or TAlphaColor($FFF0F5);
TAlphaColorRec.Lawngreen, //    Lawngreen = Alpha or TAlphaColor($7CFC00);
TAlphaColorRec.LegacySkyBlue, //    LegacySkyBlue = Alpha or TAlphaColor($F0CAA6);
TAlphaColorRec.Lemonchiffon, //    Lemonchiffon = Alpha or TAlphaColor($FFFACD);
TAlphaColorRec.Lightblue, //    Lightblue = Alpha or TAlphaColor($ADD8E6);
TAlphaColorRec.Lightcoral, //    Lightcoral = Alpha or TAlphaColor($F08080);
TAlphaColorRec.Lightcyan, //    Lightcyan = Alpha or TAlphaColor($E0FFFF);
TAlphaColorRec.Lightgoldenrodyellow, //    Lightgoldenrodyellow = Alpha or TAlphaColor($FAFAD2);
//TAlphaColorRec.Lightgray, //    Lightgray = Alpha or TAlphaColor($D3D3D3);
TAlphaColorRec.Lightgreen, //    Lightgreen = Alpha or TAlphaColor($90EE90);
TAlphaColorRec.Lightgrey, //    Lightgrey = Alpha or TAlphaColor($D3D3D3);
TAlphaColorRec.Lightpink, //    Lightpink = Alpha or TAlphaColor($FFB6C1);
TAlphaColorRec.Lightsalmon, //    Lightsalmon = Alpha or TAlphaColor($FFA07A);
TAlphaColorRec.Lightseagreen, //    Lightseagreen = Alpha or TAlphaColor($20B2AA);
TAlphaColorRec.Lightskyblue, //    Lightskyblue = Alpha or TAlphaColor($87CEFA);
//TAlphaColorRec.Lightslategray, //    Lightslategray = Alpha or TAlphaColor($778899);
TAlphaColorRec.Lightslategrey, //    Lightslategrey = Alpha or TAlphaColor($778899);
TAlphaColorRec.Lightsteelblue, //    Lightsteelblue = Alpha or TAlphaColor($B0C4DE);
TAlphaColorRec.Lightyellow, //    Lightyellow = Alpha or TAlphaColor($FFFFE0);
TAlphaColorRec.LtGray, //    LtGray = Alpha or TAlphaColor($C0C0C0);
TAlphaColorRec.Lime, //    Lime = Alpha or TAlphaColor($00FF00);
TAlphaColorRec.Limegreen, //    Limegreen = Alpha or TAlphaColor($32CD32);
TAlphaColorRec.Linen, //    Linen = Alpha or TAlphaColor($FAF0E6);
//TAlphaColorRec.DkGray, //    DkGray = Alpha or TAlphaColor($808080);
TAlphaColorRec.Magenta, //    Magenta = Alpha or TAlphaColor($FF00FF);
TAlphaColorRec.Maroon, //    Maroon = Alpha or TAlphaColor($800000);
TAlphaColorRec.MedGray, //    MedGray = Alpha or TAlphaColor($A0A0A0);
TAlphaColorRec.Mediumaquamarine, //    Mediumaquamarine = Alpha or TAlphaColor($66CDAA);
TAlphaColorRec.Mediumblue, //    Mediumblue = Alpha or TAlphaColor($0000CD);
TAlphaColorRec.Mediumorchid, //    Mediumorchid = Alpha or TAlphaColor($BA55D3);
TAlphaColorRec.Mediumpurple, //    Mediumpurple = Alpha or TAlphaColor($9370DB);
TAlphaColorRec.Mediumseagreen, //    Mediumseagreen = Alpha or TAlphaColor($3CB371);
TAlphaColorRec.Mediumslateblue, //    Mediumslateblue = Alpha or TAlphaColor($7B68EE);
TAlphaColorRec.Mediumspringgreen, //    Mediumspringgreen = Alpha or TAlphaColor($00FA9A);
TAlphaColorRec.Mediumturquoise, //    Mediumturquoise = Alpha or TAlphaColor($48D1CC);
TAlphaColorRec.Mediumvioletred, //    Mediumvioletred = Alpha or TAlphaColor($C71585);
TAlphaColorRec.Midnightblue, //    Midnightblue = Alpha or TAlphaColor($191970);
TAlphaColorRec.Mintcream, //    Mintcream = Alpha or TAlphaColor($F5FFFA);
TAlphaColorRec.Mistyrose, //    Mistyrose = Alpha or TAlphaColor($FFE4E1);
TAlphaColorRec.Moccasin, //    Moccasin = Alpha or TAlphaColor($FFE4B5);
TAlphaColorRec.MoneyGreen, //    MoneyGreen = Alpha or TAlphaColor($C0DCC0);
TAlphaColorRec.Navajowhite, //    Navajowhite = Alpha or TAlphaColor($FFDEAD);
TAlphaColorRec.Navy, //    Navy = Alpha or TAlphaColor($000080);
TAlphaColorRec.Oldlace, //    Oldlace = Alpha or TAlphaColor($FDF5E6);
TAlphaColorRec.Olive, //    Olive = Alpha or TAlphaColor($808000);
TAlphaColorRec.Olivedrab, //    Olivedrab = Alpha or TAlphaColor($6B8E23);
TAlphaColorRec.Orange, //    Orange = Alpha or TAlphaColor($FFA500);
TAlphaColorRec.Orangered, //    Orangered = Alpha or TAlphaColor($FF4500);
TAlphaColorRec.Orchid, //    Orchid = Alpha or TAlphaColor($DA70D6);
TAlphaColorRec.Palegoldenrod, //    Palegoldenrod = Alpha or TAlphaColor($EEE8AA);
TAlphaColorRec.Palegreen, //    Palegreen = Alpha or TAlphaColor($98FB98);
TAlphaColorRec.Paleturquoise, //    Paleturquoise = Alpha or TAlphaColor($AFEEEE);
TAlphaColorRec.Palevioletred, //    Palevioletred = Alpha or TAlphaColor($DB7093);
TAlphaColorRec.Papayawhip, //    Papayawhip = Alpha or TAlphaColor($FFEFD5);
TAlphaColorRec.Peachpuff, //    Peachpuff = Alpha or TAlphaColor($FFDAB9);
TAlphaColorRec.Peru, //    Peru = Alpha or TAlphaColor($CD853F);
TAlphaColorRec.Pink, //    Pink = Alpha or TAlphaColor($FFC0CB);
TAlphaColorRec.Plum, //    Plum = Alpha or TAlphaColor($DDA0DD);
TAlphaColorRec.Powderblue, //    Powderblue = Alpha or TAlphaColor($B0E0E6);
TAlphaColorRec.Purple, //    Purple = Alpha or TAlphaColor($800080);
TAlphaColorRec.Red, //    Red = Alpha or TAlphaColor($FF0000);
TAlphaColorRec.Rosybrown, //    Rosybrown = Alpha or TAlphaColor($BC8F8F);
TAlphaColorRec.Royalblue, //    Royalblue = Alpha or TAlphaColor($4169E1);
TAlphaColorRec.Saddlebrown, //    Saddlebrown = Alpha or TAlphaColor($8B4513);
TAlphaColorRec.Salmon, //    Salmon = Alpha or TAlphaColor($FA8072);
TAlphaColorRec.Sandybrown, //    Sandybrown = Alpha or TAlphaColor($F4A460);
TAlphaColorRec.Seagreen, //    Seagreen = Alpha or TAlphaColor($2E8B57);
TAlphaColorRec.Seashell, //    Seashell = Alpha or TAlphaColor($FFF5EE);
TAlphaColorRec.Sienna, //    Sienna = Alpha or TAlphaColor($A0522D);
// TAlphaColorRec.Silver, //    Silver = Alpha or TAlphaColor($C0C0C0);
TAlphaColorRec.Skyblue, //    Skyblue = Alpha or TAlphaColor($87CEEB);
TAlphaColorRec.Slateblue, //    Slateblue = Alpha or TAlphaColor($6A5ACD);
//TAlphaColorRec.Slategray, //    Slategray = Alpha or TAlphaColor($708090);
TAlphaColorRec.Slategrey, //    Slategrey = Alpha or TAlphaColor($708090);
TAlphaColorRec.Snow, //    Snow = Alpha or TAlphaColor($FFFAFA);
TAlphaColorRec.Springgreen, //    Springgreen = Alpha or TAlphaColor($00FF7F);
TAlphaColorRec.Steelblue, //    Steelblue = Alpha or TAlphaColor($4682B4);
TAlphaColorRec.Tan, //    Tan = Alpha or TAlphaColor($D2B48C);
TAlphaColorRec.Teal, //    Teal = Alpha or TAlphaColor($008080);
TAlphaColorRec.Thistle, //    Thistle = Alpha or TAlphaColor($D8BFD8);
TAlphaColorRec.Tomato, //    Tomato = Alpha or TAlphaColor($FF6347);
TAlphaColorRec.Turquoise, //    Turquoise = Alpha or TAlphaColor($40E0D0);
TAlphaColorRec.Violet, //    Violet = Alpha or TAlphaColor($EE82EE);
TAlphaColorRec.Wheat, //    Wheat = Alpha or TAlphaColor($F5DEB3);
TAlphaColorRec.White, //    White = Alpha or TAlphaColor($FFFFFF);
TAlphaColorRec.Whitesmoke, //    Whitesmoke = Alpha or TAlphaColor($F5F5F5);
TAlphaColorRec.Yellow, //    Yellow = Alpha or TAlphaColor($FFFF00);
TAlphaColorRec.Yellowgreen //    Yellowgreen = Alpha or TAlphaColor($9ACD32);
  );

  CColorValues: array[0..140] of TColor =
  (
TColorRec.Antiquewhite, //    Antiquewhite = Alpha or TAlphaColor($FAEBD7);
//TColorRec.Aqua, //    Aqua = Alpha or TAlphaColor($00FFFF); // Duplicate of Cyan
TColorRec.Aquamarine, //    Aquamarine = Alpha or TAlphaColor($7FFFD4);
TColorRec.Azure, //    Azure = Alpha or TAlphaColor($F0FFFF);
TColorRec.Beige, //    Beige = Alpha or TAlphaColor($F5F5DC);
TColorRec.Bisque, //    Bisque = Alpha or TAlphaColor($FFE4C4);
TColorRec.Black, //    Black = Alpha or TAlphaColor($000000);
TColorRec.Blanchedalmond, //    Blanchedalmond = Alpha or TAlphaColor($FFEBCD);
TColorRec.Blue, //    Blue = Alpha or TAlphaColor($0000FF);
TColorRec.Blueviolet, //    Blueviolet = Alpha or TAlphaColor($8A2BE2);
TColorRec.Brown, //    Brown = Alpha or TAlphaColor($A52A2A);
TColorRec.Burlywood, //    Burlywood = Alpha or TAlphaColor($DEB887);
TColorRec.Cadetblue, //    Cadetblue = Alpha or TAlphaColor($5F9EA0);
TColorRec.Chartreuse, //    Chartreuse = Alpha or TAlphaColor($7FFF00);
TColorRec.Chocolate, //    Chocolate = Alpha or TAlphaColor($D2691E);
TColorRec.Coral, //    Coral = Alpha or TAlphaColor($FF7F50);
TColorRec.Cornflowerblue, //    Cornflowerblue = Alpha or TAlphaColor($6495ED);
TColorRec.Cornsilk, //    Cornsilk = Alpha or TAlphaColor($FFF8DC);
TColorRec.Cream, //    Cream = Alpha or TAlphaColor($F0FBFF);
TColorRec.Crimson, //    Crimson = Alpha or TAlphaColor($DC143C);
TColorRec.Cyan, //    Cyan = Alpha or TAlphaColor($00FFFF);
TColorRec.Darkblue, //    Darkblue = Alpha or TAlphaColor($00008B);
TColorRec.Darkcyan, //    Darkcyan = Alpha or TAlphaColor($008B8B);
TColorRec.Darkgoldenrod, //    Darkgoldenrod = Alpha or TAlphaColor($B8860B);
//TColorRec.Darkgray, //    Darkgray = Alpha or TAlphaColor($A9A9A9);
TColorRec.Darkgreen, //    Darkgreen = Alpha or TAlphaColor($006400);
TColorRec.Darkgrey, //    Darkgrey = Alpha or TAlphaColor($A9A9A9);
TColorRec.Darkkhaki, //    Darkkhaki = Alpha or TAlphaColor($BDB76B);
TColorRec.Darkmagenta, //    Darkmagenta = Alpha or TAlphaColor($8B008B);
TColorRec.Darkolivegreen, //    Darkolivegreen = Alpha or TAlphaColor($556B2F);
TColorRec.Darkorange, //    Darkorange = Alpha or TAlphaColor($FF8C00);
TColorRec.Darkorchid, //    Darkorchid = Alpha or TAlphaColor($9932CC);
TColorRec.Darkred, //    Darkred = Alpha or TAlphaColor($8B0000);
TColorRec.Darksalmon, //    Darksalmon = Alpha or TAlphaColor($E9967A);
TColorRec.Darkseagreen, //    Darkseagreen = Alpha or TAlphaColor($8FBC8F);
TColorRec.Darkslateblue, //    Darkslateblue = Alpha or TAlphaColor($483D8B);
//TColorRec.Darkslategray, //    Darkslategray = Alpha or TAlphaColor($2F4F4F);
TColorRec.Darkslategrey, //    Darkslategrey = Alpha or TAlphaColor($2F4F4F);
TColorRec.Darkturquoise, //    Darkturquoise = Alpha or TAlphaColor($00CED1);
TColorRec.Darkviolet, //    Darkviolet = Alpha or TAlphaColor($9400D3);
TColorRec.Deeppink, //    Deeppink = Alpha or TAlphaColor($FF1493);
TColorRec.Deepskyblue, //    Deepskyblue = Alpha or TAlphaColor($00BFFF);
//TColorRec.Dimgray, //    Dimgray = Alpha or TAlphaColor($696969);
TColorRec.Dimgrey, //    Dimgrey = Alpha or TAlphaColor($696969);
TColorRec.Dodgerblue, //    Dodgerblue = Alpha or TAlphaColor($1E90FF);
TColorRec.Firebrick, //    Firebrick = Alpha or TAlphaColor($B22222);
TColorRec.Floralwhite, //    Floralwhite = Alpha or TAlphaColor($FFFAF0);
TColorRec.Forestgreen, //    Forestgreen = Alpha or TAlphaColor($228B22);
// TColorRec.Fuchsia, //    Fuchsia = Alpha or TAlphaColor($FF00FF);
TColorRec.Gainsboro, //    Gainsboro = Alpha or TAlphaColor($DCDCDC);
TColorRec.Ghostwhite, //    Ghostwhite = Alpha or TAlphaColor($F8F8FF);
TColorRec.Gold, //    Gold = Alpha or TAlphaColor($FFD700);
TColorRec.Goldenrod, //    Goldenrod = Alpha or TAlphaColor($DAA520);
//TColorRec.Gray, //    Gray = Alpha or TAlphaColor($808080);
TColorRec.Green, //    Green = Alpha or TAlphaColor($008000);
TColorRec.Greenyellow, //    Greenyellow = Alpha or TAlphaColor($ADFF2F);
TColorRec.Grey, //    Grey = Alpha or TAlphaColor($808080);
TColorRec.Honeydew, //    Honeydew = Alpha or TAlphaColor($F0FFF0);
TColorRec.Hotpink, //    Hotpink = Alpha or TAlphaColor($FF69B4);
TColorRec.Indianred, //    Indianred = Alpha or TAlphaColor($CD5C5C);
TColorRec.Indigo, //    Indigo = Alpha or TAlphaColor($4B0082);
TColorRec.Ivory, //    Ivory = Alpha or TAlphaColor($FFFFF0);
TColorRec.Khaki, //    Khaki = Alpha or TAlphaColor($F0E68C);
TColorRec.Lavender, //    Lavender = Alpha or TAlphaColor($E6E6FA);
TColorRec.Lavenderblush, //    Lavenderblush = Alpha or TAlphaColor($FFF0F5);
TColorRec.Lawngreen, //    Lawngreen = Alpha or TAlphaColor($7CFC00);
TColorRec.LegacySkyBlue, //    LegacySkyBlue = Alpha or TAlphaColor($F0CAA6);
TColorRec.Lemonchiffon, //    Lemonchiffon = Alpha or TAlphaColor($FFFACD);
TColorRec.Lightblue, //    Lightblue = Alpha or TAlphaColor($ADD8E6);
TColorRec.Lightcoral, //    Lightcoral = Alpha or TAlphaColor($F08080);
TColorRec.Lightcyan, //    Lightcyan = Alpha or TAlphaColor($E0FFFF);
TColorRec.Lightgoldenrodyellow, //    Lightgoldenrodyellow = Alpha or TAlphaColor($FAFAD2);
//TColorRec.Lightgray, //    Lightgray = Alpha or TAlphaColor($D3D3D3);
TColorRec.Lightgreen, //    Lightgreen = Alpha or TAlphaColor($90EE90);
TColorRec.Lightgrey, //    Lightgrey = Alpha or TAlphaColor($D3D3D3);
TColorRec.Lightpink, //    Lightpink = Alpha or TAlphaColor($FFB6C1);
TColorRec.Lightsalmon, //    Lightsalmon = Alpha or TAlphaColor($FFA07A);
TColorRec.Lightseagreen, //    Lightseagreen = Alpha or TAlphaColor($20B2AA);
TColorRec.Lightskyblue, //    Lightskyblue = Alpha or TAlphaColor($87CEFA);
//TColorRec.Lightslategray, //    Lightslategray = Alpha or TAlphaColor($778899);
TColorRec.Lightslategrey, //    Lightslategrey = Alpha or TAlphaColor($778899);
TColorRec.Lightsteelblue, //    Lightsteelblue = Alpha or TAlphaColor($B0C4DE);
TColorRec.Lightyellow, //    Lightyellow = Alpha or TAlphaColor($FFFFE0);
TColorRec.Lime, //    Lime = Alpha or TAlphaColor($00FF00);
TColorRec.Limegreen, //    Limegreen = Alpha or TAlphaColor($32CD32);
TColorRec.Linen, //    Linen = Alpha or TAlphaColor($FAF0E6);
TColorRec.LtGray, //    LtGray = Alpha or TAlphaColor($C0C0C0);
// TColorRec.DkGray, //    DkGray = Alpha or TAlphaColor($808080); Duplicate of Grey
TColorRec.Magenta, //    Magenta = Alpha or TAlphaColor($FF00FF);
TColorRec.Maroon, //    Maroon = Alpha or TAlphaColor($800000);
TColorRec.MedGray, //    MedGray = Alpha or TAlphaColor($A0A0A0);
TColorRec.Mediumaquamarine, //    Mediumaquamarine = Alpha or TAlphaColor($66CDAA);
TColorRec.Mediumblue, //    Mediumblue = Alpha or TAlphaColor($0000CD);
TColorRec.Mediumorchid, //    Mediumorchid = Alpha or TAlphaColor($BA55D3);
TColorRec.Mediumpurple, //    Mediumpurple = Alpha or TAlphaColor($9370DB);
TColorRec.Mediumseagreen, //    Mediumseagreen = Alpha or TAlphaColor($3CB371);
TColorRec.Mediumslateblue, //    Mediumslateblue = Alpha or TAlphaColor($7B68EE);
TColorRec.Mediumspringgreen, //    Mediumspringgreen = Alpha or TAlphaColor($00FA9A);
TColorRec.Mediumturquoise, //    Mediumturquoise = Alpha or TAlphaColor($48D1CC);
TColorRec.Mediumvioletred, //    Mediumvioletred = Alpha or TAlphaColor($C71585);
TColorRec.Midnightblue, //    Midnightblue = Alpha or TAlphaColor($191970);
TColorRec.Mintcream, //    Mintcream = Alpha or TAlphaColor($F5FFFA);
TColorRec.Mistyrose, //    Mistyrose = Alpha or TAlphaColor($FFE4E1);
TColorRec.Moccasin, //    Moccasin = Alpha or TAlphaColor($FFE4B5);
TColorRec.MoneyGreen, //    MoneyGreen = Alpha or TAlphaColor($C0DCC0);
TColorRec.Navajowhite, //    Navajowhite = Alpha or TAlphaColor($FFDEAD);
TColorRec.Navy, //    Navy = Alpha or TAlphaColor($000080);
TColorRec.Oldlace, //    Oldlace = Alpha or TAlphaColor($FDF5E6);
TColorRec.Olive, //    Olive = Alpha or TAlphaColor($808000);
TColorRec.Olivedrab, //    Olivedrab = Alpha or TAlphaColor($6B8E23);
TColorRec.Orange, //    Orange = Alpha or TAlphaColor($FFA500);
TColorRec.Orangered, //    Orangered = Alpha or TAlphaColor($FF4500);
TColorRec.Orchid, //    Orchid = Alpha or TAlphaColor($DA70D6);
TColorRec.Palegoldenrod, //    Palegoldenrod = Alpha or TAlphaColor($EEE8AA);
TColorRec.Palegreen, //    Palegreen = Alpha or TAlphaColor($98FB98);
TColorRec.Paleturquoise, //    Paleturquoise = Alpha or TAlphaColor($AFEEEE);
TColorRec.Palevioletred, //    Palevioletred = Alpha or TAlphaColor($DB7093);
TColorRec.Papayawhip, //    Papayawhip = Alpha or TAlphaColor($FFEFD5);
TColorRec.Peachpuff, //    Peachpuff = Alpha or TAlphaColor($FFDAB9);
TColorRec.Peru, //    Peru = Alpha or TAlphaColor($CD853F);
TColorRec.Pink, //    Pink = Alpha or TAlphaColor($FFC0CB);
TColorRec.Plum, //    Plum = Alpha or TAlphaColor($DDA0DD);
TColorRec.Powderblue, //    Powderblue = Alpha or TAlphaColor($B0E0E6);
TColorRec.Purple, //    Purple = Alpha or TAlphaColor($800080);
TColorRec.Red, //    Red = Alpha or TAlphaColor($FF0000);
TColorRec.Rosybrown, //    Rosybrown = Alpha or TAlphaColor($BC8F8F);
TColorRec.Royalblue, //    Royalblue = Alpha or TAlphaColor($4169E1);
TColorRec.Saddlebrown, //    Saddlebrown = Alpha or TAlphaColor($8B4513);
TColorRec.Salmon, //    Salmon = Alpha or TAlphaColor($FA8072);
TColorRec.Sandybrown, //    Sandybrown = Alpha or TAlphaColor($F4A460);
TColorRec.Seagreen, //    Seagreen = Alpha or TAlphaColor($2E8B57);
TColorRec.Seashell, //    Seashell = Alpha or TAlphaColor($FFF5EE);
TColorRec.Sienna, //    Sienna = Alpha or TAlphaColor($A0522D);
//TColorRec.Silver, //    Silver = Alpha or TAlphaColor($C0C0C0);
TColorRec.Skyblue, //    Skyblue = Alpha or TAlphaColor($87CEEB);
TColorRec.Slateblue, //    Slateblue = Alpha or TAlphaColor($6A5ACD);
//TColorRec.Slategray, //    Slategray = Alpha or TAlphaColor($708090);
TColorRec.Slategrey, //    Slategrey = Alpha or TAlphaColor($708090);
TColorRec.Snow, //    Snow = Alpha or TAlphaColor($FFFAFA);
TColorRec.Springgreen, //    Springgreen = Alpha or TAlphaColor($00FF7F);
TColorRec.Steelblue, //    Steelblue = Alpha or TAlphaColor($4682B4);
TColorRec.Tan, //    Tan = Alpha or TAlphaColor($D2B48C);
TColorRec.Teal, //    Teal = Alpha or TAlphaColor($008080);
TColorRec.Thistle, //    Thistle = Alpha or TAlphaColor($D8BFD8);
TColorRec.Tomato, //    Tomato = Alpha or TAlphaColor($FF6347);
TColorRec.Turquoise, //    Turquoise = Alpha or TAlphaColor($40E0D0);
TColorRec.Violet, //    Violet = Alpha or TAlphaColor($EE82EE);
TColorRec.Wheat, //    Wheat = Alpha or TAlphaColor($F5DEB3);
TColorRec.White, //    White = Alpha or TAlphaColor($FFFFFF);
TColorRec.Whitesmoke, //    Whitesmoke = Alpha or TAlphaColor($F5F5F5);
TColorRec.Yellow, //    Yellow = Alpha or TAlphaColor($FFFF00);
TColorRec.Yellowgreen //    Yellowgreen = Alpha or TAlphaColor($9ACD32);
  );


type

  TAlphaColorGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

  TColorGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

  TAlphaColorNameGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

  TPathsGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

  TPathNamesGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;


  TSimpleValueGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

  TStringsGenerator = class(TDelegateValueGenerator)
  private
    function MakeStrings(AIndex: Integer; AValues: TArray<string>): TStrings;
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

  TContactStringGenerator = class(TDelegateValueGenerator)
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;

const
  sIntegers = 'Integers';
  sCurrency = 'Currency';
  sDateTime = 'DateTime';
  sDate = 'Date';
  sTime = 'Time';
  sUIntegers = 'UIntegers';
  sFloats = 'Floats';
  sBooleans = 'Booleans';
  sLoremIpsums = 'LoremIpsum';


{ TSimpleValueGenerator }

function TSimpleValueGenerator.CreateDelegate;
var
  ADelegate: TValueGeneratorDelegate;
begin
  ADelegate := nil;
  if SameText(GeneratorName, sUIntegers) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, uint32>.Create(Options, GetUIntegers);
      ftInteger:
        ADelegate := TTypedListValueGeneratorDelegate2<Integer, uint32>.Create(Options, GetUIntegers);
      ftUInteger:
        ADelegate := TTypedListValueGeneratorDelegate<uint32>.Create(Options, GetUIntegers);
      ftSingle:
        ADelegate := TTypedListValueGeneratorDelegate2<Single, uint32>.Create(Options, GetUIntegers);
    else
      Assert(False);
    end
  end
  else if SameText(GeneratorName, sIntegers) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, Integer>.Create(Options, GetIntegers);
      ftInteger:
        ADelegate := TTypedListValueGeneratorDelegate<Integer>.Create(Options, GetIntegers);
      ftSingle:
        ADelegate := TTypedListValueGeneratorDelegate2<Single, Integer>.Create(Options, GetIntegers);
      ftUInteger:
        ADelegate := TTypedListValueGeneratorDelegate2<UInt32, Integer>.Create(Options, GetIntegers);
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sFloats) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, single>.Create(Options, GetSingles);
      ftSingle:
        ADelegate := TTypedListValueGeneratorDelegate<Single>.Create(Options, GetSingles);
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sBooleans) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, boolean>.Create(Options, TArray<Boolean>.Create(false, true));
      ftBoolean:
        ADelegate := TTypedListValueGeneratorDelegate<Boolean>.Create(Options, TArray<Boolean>.Create(false, true));
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sLoremIpsums) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, GetLoremIpsum);
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sCurrency) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, Currency>.Create(Options, GetCurrency);
      ftCurrency:
        ADelegate := TTypedListValueGeneratorDelegate<Currency>.Create(Options, GetCurrency);
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sDateTime) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, TDateTime>.Create(Options, GetDateTime);
      ftDateTime:
        ADelegate := TTypedListValueGeneratorDelegate<TDateTime>.Create(Options, GetDateTime);
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sTime) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, TTime>.Create(Options, GetTime);
      ftTime:
        ADelegate := TTypedListValueGeneratorDelegate<TTime>.Create(Options, GetTime);
    else
      Assert(False);
    end;
  end
  else if SameText(GeneratorName, sDate) then
  begin
    case FieldType of
      ftString:
        ADelegate := TTypedListValueGeneratorDelegate2<string, TDate>.Create(Options, GetDate);
      ftDate:
        ADelegate := TTypedListValueGeneratorDelegate<TDate>.Create(Options, GetDate);
    else
      Assert(False);
    end;
  end
  else
    Assert(False);
  Result := ADelegate;
end;

const
  sThisUnit = 'Data.Bind.GenData';

  sAlphaColors = 'AlphaColors';
  sColors = 'Colors';
  sColorNames = 'ColorsNames';
  sPaths = 'PathData';
  sPathNames = 'PathDataNames';
  sContactNames = 'ContactNames';
  sContactTitles = 'ContactTitles';

  sAlphaColorField = 'AlphaColor%d';
  sColorField = 'Color%d';
  sAlphaColorNameField = 'ColorsName%d';
  sPathField = 'PathData%d';
  sPathNameField = 'PathDataNames%d';
  sStringsField = 'StringsField%d';

  sDateTimeField = 'DateTimeField%d';
  sTimeField = 'TimeField%d';
  sDateField = 'DateField%d';
  sCurrencyField = 'CurrencyField%d';
  sIntegerField = 'IntField%d';
  sUIntegerField = 'UIntField%d';
  sFloatField = 'FloatField%d';
  sBooleanField = 'BoolField%d';
  sLoremIpsumField = 'LoremIpsum%d';
  sContactNameField = 'ContactName%d';
  sContactTitleField = 'ContactTitle%d';

procedure RegisterGenerators;
begin
  RegisterValueGenerator(sIntegers, [ftInteger, ftString, ftSingle],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sIntegerField, sThisUnit));
  RegisterValueGenerator(sUIntegers, [ftInteger, ftUInteger, ftString, ftSingle],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sUIntegerField, sThisUnit));
  RegisterValueGenerator(sFloats, [ftSingle],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sFloatField, sThisUnit));
  RegisterValueGenerator(sBooleans, [ftBoolean],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sBooleanField, sThisUnit));
  RegisterValueGenerator(sDateTime, [ftDateTime, ftString],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sDateTimeField, sThisUnit));
  RegisterValueGenerator(sDate, [ftDate, ftString],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sDateField, sThisUnit));
  RegisterValueGenerator(sTime, [ftTime, ftString],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sTimeField, sThisUnit));
  RegisterValueGenerator(sCurrency, [ftCurrency],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sCurrencyField, sThisUnit));
  RegisterValueGenerator(sLoremIpsums, [ftString],
    TValueGeneratorDescription.Create(TSimpleValueGenerator, sLoremIpsumField, sThisUnit));
  RegisterValueGenerator(sAlphaColors, [ftUInteger],
    TValueGeneratorDescription.Create(TAlphaColorGenerator, sAlphaColorField, sThisUnit));
  RegisterValueGenerator(sColors, [ftUInteger],
    TValueGeneratorDescription.Create(TColorGenerator, sColorField, sThisUnit));
  RegisterValueGenerator(sColorNames, [ftString],
    TValueGeneratorDescription.Create(TAlphaColorNameGenerator, sAlphaColorNameField, sThisUnit));
  RegisterValueGenerator(sPaths, [ftString],
    TValueGeneratorDescription.Create(TPathsGenerator, sPathField, sThisUnit));
  RegisterValueGenerator(sPathNames, [ftString],
    TValueGeneratorDescription.Create(TPathNamesGenerator, sPathNameField, sThisUnit));
  RegisterValueGenerator(sLoremIpsums, [ftTStrings],
    TValueGeneratorDescription.Create(TStringsGenerator, sStringsField, sThisUnit));
  RegisterValueGenerator(sContactNames, [ftString],
    TValueGeneratorDescription.Create(TContactStringGenerator, sContactNameField, sThisUnit));
  RegisterValueGenerator(sContactTitles, [ftString],
    TValueGeneratorDescription.Create(TContactStringGenerator, sContactTitleField, sThisUnit));
end;

procedure UnRegisterGenerators;
begin
  UnRegisterValueGenerator(sCurrency, [ftCurrency, ftString], '');
  UnRegisterValueGenerator(sDateTime, [ftDateTime, ftString], '');
  UnRegisterValueGenerator(sDate, [ftDate, ftString], '');
  UnRegisterValueGenerator(sTime, [ftTime, ftString], '');
  UnRegisterValueGenerator(sColorNames, [ftString], '');
  UnRegisterValueGenerator(sPaths, [ftString], '');
  UnRegisterValueGenerator(sPathNames, [ftString], '');
  UnRegisterValueGenerator(sLoremIpsums, [ftTStrings], '');
end;



function TAlphaColorGenerator.CreateDelegate: TValueGeneratorDelegate;
var
  ADelegate: TValueGeneratorDelegate;
  LStringList: TList<string>;
  LAlphaColorList: TList<TAlphaColor>;
  I: Integer;
begin
  ADelegate := nil;
  case FieldType of
    ftString:
    begin
      LStringList := TList<string>.Create;
      try
        for I := Low(CAlphaColorValues) to High(CAlphaColorValues) do
          LStringList.Add(UIntToStr( CAlphaColorValues[I]));
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, LStringList.ToArray);
      finally
        LStringList.Free;
      end;
    end;
    ftUInteger:
    begin
      LAlphaColorList := TList<TAlphaColor>.Create;
      try
        for I := Low(CAlphaColorValues) to High(CAlphaColorValues) do
        begin
          Assert(not LAlphaColorList.Contains(CAlphaColorValues[I]));
          LAlphaColorList.Add(CAlphaColorValues[I]);
        end;
        ADelegate := TTypedListValueGeneratorDelegate<TAlphaColor>.Create(Options, LAlphaColorList.ToArray);
      finally
        LAlphaColorList.Free;
      end;
    end
  else
    Assert(False);
  end;
  Result := ADelegate;
end;

function TColorGenerator.CreateDelegate: TValueGeneratorDelegate;
var
  ADelegate: TValueGeneratorDelegate;
  LStringList: TList<string>;
  LColorList: TList<TColor>;
  I: Integer;
begin
  ADelegate := nil;
  case FieldType of
    ftString:
    begin
      LStringList := TList<string>.Create;
      try
        for I := Low(CColorValues) to High(CColorValues) do
        begin
          LStringList.Add(IntToStr( CColorValues[I]));
        end;
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, LStringList.ToArray);
      finally
        LStringList.Free;
      end;
    end;
    ftUInteger:
    begin
      LColorList := TList<TColor>.Create;
      try
        for I := Low(CColorValues) to High(CColorValues) do
        begin
          // Expect unique values
          Assert(not LColorList.Contains(CColorValues[I]));
          LColorList.Add(CColorValues[I]);
        end;
        ADelegate := TTypedListValueGeneratorDelegate<TColor>.Create(Options, LColorList.ToArray);
      finally
        LColorList.Free;
      end;
    end
  else
    Assert(False);
  end;
  Result := ADelegate;
end;

function TAlphaColorNameGenerator.CreateDelegate: TValueGeneratorDelegate;
var
  ADelegate: TValueGeneratorDelegate;
  LStringList: TList<string>;
  I: Integer;
begin
  ADelegate := nil;
  case FieldType of
    ftString:
    begin
      LStringList := TList<string>.Create;
      try
        for I := Low(CColorNames) to High(CColorNames) do
        begin
          // Expect unique values
          Assert(not LStringList.Contains(CColorNames[I]));
          LStringList.Add(CColorNames[I]);
        end;
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, LStringList.ToArray);
      finally
        LStringList.Free;
      end;
    end;
  else
    Assert(False);
  end;
  Result := ADelegate;
end;


const
  cPathNames: array[0..9] of string =
  (
    'First',
    'Previous',
    'Next',
    'Last',
    'Insert',
    'Delete',
    'Edit',
    'Post',
    'Cancel',
    'Apply'

  );

  cPaths: array[0..9] of string =
  (
    'M 361.374,349.551 L 325.968,315.176 L 361.374,280.801 Z M 323.202,349.551 L 287.797,315.176 L 323.202,280.801 Z M 286.357,349.551 L 279.277,349.551 L 279.277,280.801 L 286.357,280.801 Z',
    'M 327.076,346.113 L 291.667,311.738 L 327.076,277.363 Z ',
    'M 341.236,311.738 L 305.830,346.113 L 305.830,277.363 Z ',
    'M 361.374,349.551 L 354.294,349.551 L 354.294,280.801 L 361.374,280.801 Z M 352.854,315.176 L 317.448,349.551 L 317.448,280.801 Z M 314.682,315.176 L 279.277,349.551 L 279.277,280.801 Z',
    // plus
    'M 315.303,336.714 L 315.303,315.122 L 293.228,315.122 L 293.228,306.099 L 315.303,306.099 L 315.303,284.668 L 324.706,284.668 L 324.706,306.099 L 346.781,306.099 L 346.781,315.122 L '+
    '324.706,315.122 L 324.706,336.714 Z ',
    // minus
    'M 286.766,375.304 L 286.766,364.321 L 352.763,364.321 L 352.763,375.304 Z ',
    // edit
    'M 350.074,271.455 L 350.074,350.947 L 289.995,350.947 L 289.995,271.455 Z M 347.362,274.087 L 292.704,274.087 L 292.704,348.315 L 347.362,348.315 Z M 300.892,337.681 L 300.892,335.049'+
    ' L 339.121,335.049 L 339.121,337.681 Z M 300.892,327.100 L 300.892,324.468 L 339.121,324.468 L 339.121,327.100 Z M 300.892,316.519 L 300.892,313.887 L 339.121,313.887 L 339.121,316.519 '+
    'Z M 300.892,305.884 L 300.892,303.252 L 339.121,303.252 L 339.121,305.884 Z M 300.892,295.249 L 300.892,292.617 L 339.121,292.617 L 339.121,295.249 Z M 300.892,284.668 L 300.892,282.036 L'+
    ' 339.121,282.036 L 339.121,284.668 Z ',
    // post
    'M 358.467,266.729 L '+
    '360.400,269.414 C 352.512,275.181 '+
    '343.733,284.064 334.069,296.058 L '+
    '334.069,296.058 C 324.407,308.056 '+
    '317.029,319.261 311.940,329.678 L '+
    '311.940,329.678 L 307.844,332.363 '+
    'C 304.454,334.659 302.148,336.358 '+
    '300.929,337.466 L 300.929,337.466 '+
    'C 300.452,335.787 299.402,333.028 '+
    '297.777,329.194 L 297.777,329.194 '+
    'L 296.229,325.703 C '+
    '294.017,320.695 291.959,316.989 '+
    '290.059,314.588 L 290.059,314.588 '+
    'C 288.159,312.191 286.031,310.597 '+
    '283.671,309.805 L 283.671,309.805 '+
    'C 287.656,305.726 291.308,303.685 '+
    '294.625,303.682 L 294.625,303.682 '+
    'C 297.465,303.685 300.620,307.428 '+
    '304.085,314.907 L 304.085,314.907 '+
    'L 305.800,318.667 C '+
    '312.034,308.465 320.037,298.549 '+
    '329.809,288.915 L 329.809,288.915 '+
    'C 339.584,279.283 349.135,271.888 '+
    '358.467,266.729 L 358.467,266.729 '+
    'Z ',
    // cancel
    'M 319.704,321.353 L 318.875,322.480 C 313.121,330.933 308.402,335.160 304.712,335.156 L 304.712,335.156 C 300.472,335.160 296.306,331.813 292.211,325.112 L 292.211,325.112 C 292.765,325.153 293.171,325.169 293.426,325.166 L 293.426,325.166 '+
    'C 298.260,325.169 '+
    '303.645,321.588 309.580,314.424 L 309.580,314.424 L 311.074,312.598 L 309.140,310.557 C 303.719,304.974 301.006,300.231 301.006,296.323 L 301.006,296.323 C 301.006,293.141 303.977,289.381 309.912,285.044 L 309.912,285.044 C 310.761,290.596 '+
    '313.289,296.004 '+
    '317.492,301.265 L 317.492,301.265 L 319.150,303.306 L 320.480,301.641 C 326.640,294.017 332.226,290.204 337.241,290.200 L 337.241,290.200 C 341.152,290.204 344.123,293.087 346.150,298.848 L 346.150,298.848 C 345.559,298.781 345.136,298.744 '+
    '344.878,298.740 '+
    'L 344.878,298.740 C 343.109,298.744 340.618,299.898 337.409,302.208 L 337.409,302.208 C 334.200,304.518 331.490,307.123 329.275,310.020 L 329.275,310.020 L 327.617,312.222 L 329.221,313.726 C 335.160,319.315 341.357,322.108 347.809,322.104 '+
    'L 347.809,322.104 '+
    'C 344.344,328.912 340.729,332.313 336.966,332.310 L 336.966,332.310 C 333.575,332.313 328.667,329.413 322.249,323.608 L 322.249,323.608 Z ',
    // refresh
    'M 354.848,307.012 C 354.848,312.779 353.633,318.224 351.196,323.340 L 351.196,323.340 C '+
    '348.614,328.677 344.999,332.994 340.353,336.284 L 340.353,336.284 L 346.493,340.957 L '+
    '326.744,346.113 L 328.570,327.046 L 334.102,331.289 C 339.819,326.388 342.676,319.567 '+
    '342.676,310.825 L 342.676,310.825 C 342.676,299.620 337.180,290.865 326.190,284.561 L '+
    '326.190,284.561 L 333.159,271.401 C 339.947,274.590 345.298,279.515 349.205,286.172 L '+
    '349.205,286.172 C 352.968,292.550 354.848,299.496 354.848,307.012 L 354.848,307.012 Z M '+
    '312.581,332.954 L 305.609,346.113 C 298.861,342.931 293.530,338.006 289.623,331.343 L '+
    '289.623,331.343 C 285.823,324.971 283.923,318.026 283.923,310.503 L 283.923,310.503 C '+
    '283.923,304.742 285.158,299.297 287.629,294.175 L 287.629,294.175 C 290.214,288.844 '+
    '293.809,284.527 298.418,281.230 L 298.418,281.230 L 292.278,276.504 L 312.027,271.401 L '+
    '310.201,290.469 L 304.669,286.226 C 298.955,291.133 296.095,297.955 296.095,306.689 L '+
    '296.095,306.689 C 296.095,317.902 301.590,326.656 312.581,332.954 L 312.581,332.954 Z '
  );

function TPathsGenerator.CreateDelegate: TValueGeneratorDelegate;
var
  ADelegate: TValueGeneratorDelegate;
  LStringList: TList<string>;
  I: Integer;
begin
  ADelegate := nil;
  case FieldType of
    ftString:
    begin
      LStringList := TList<string>.Create;
      try
        for I := Low(cPaths) to High(cPaths) do
          LStringList.Add(cPaths[I]);
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, LStringList.ToArray);
      finally
        LStringList.Free;
      end;
    end;
  else
    Assert(False);
  end;
  Result := ADelegate;
end;

function TPathNamesGenerator.CreateDelegate: TValueGeneratorDelegate;
var
  ADelegate: TValueGeneratorDelegate;
  LStringList: TList<string>;
  I: Integer;
begin
  ADelegate := nil;
  case FieldType of
    ftString:
    begin
      LStringList := TList<string>.Create;
      try
        for I := Low(cPathNames) to High(cPathNames) do
          LStringList.Add(cPathNames[I]);
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, LStringList.ToArray);
      finally
        LStringList.Free;
      end;
    end;
  else
    Assert(False);
  end;
  Result := ADelegate;
end;


const sLoremIpsum =
'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' +
'Fusce felis nisi, porta eget vulputate quis, vehicula a orci. ' +
'Vestibulum varius mauris eu tortor condimentum sed fermentum dui ornare. ' +
'Aenean iaculis risus id libero accumsan in adipiscing leo molestie. ' +
'In quis turpis augue. Pellentesque sollicitudin adipiscing ligula in interdum. ' +
'Aliquam eu convallis nibh. Phasellus malesuada tincidunt sagittis. ' +
'Praesent sagittis vehicula enim, sit amet gravida elit lobortis et. ' +
'Ut congue nisi at risus imperdiet id tincidunt urna iaculis. Proin ut ipsum ut libero mollis luctus.' +
'Phasellus vehicula odio eu velit condimentum dapibus. Cum sociis natoque ' +
'penatibus et magnis dis parturient montes, nascetur ridiculus mus. ' +
'Nulla vestibulum semper ligula, vel consectetur est ornare quis. ' +
'Nullam rhoncus pellentesque velit cursus condimentum. ' +
'Sed pretium enim ac purus ornare sit amet volutpat metus dignissim. ' +
'Proin mi dolor, semper ac faucibus ac, aliquam eget neque. ' +
'Nam iaculis tempus fringilla. Quisque molestie vestibulum blandit. ' +
'Aenean malesuada fringilla leo, non accumsan leo ullamcorper in. ' +
'Praesent ultricies varius dolor, at ultricies felis placerat sit amet. ' +
'Curabitur bibendum, eros eu varius placerat, ipsum mi vehicula purus, eu congue sapien orci eu est. ' +
'Morbi blandit volutpat ante, non ultrices eros semper at. Fusce leo leo, mollis id viverra a, ' +
'pulvinar non diam. Praesent ornare mauris ac magna placerat rutrum.' +
'Curabitur volutpat urna fermentum sem iaculis ultrices. Maecenas adipiscing sapien risus, nec consectetur arcu. ' +
'Sed in arcu iaculis felis placerat elementum vitae porta libero. Donec quis purus nisi, ac ultrices lorem. ' +
'Proin vitae diam id turpis rhoncus vestibulum scelerisque vel leo. ' +
'Nulla quis scelerisque sem. Etiam imperdiet lacinia nulla sit amet varius. ' +
'Aliquam in interdum mauris. Praesent placerat, libero vel bibendum malesuada, velit libero vestibulum erat, ' +
'vel porttitor diam urna et nibh. Nullam fringilla cursus tempor. ' +
'Cras eleifend malesuada lacus quis consectetur. Cum sociis natoque penatibus et magnis dis parturient montes, ' +
'nascetur ridiculus mus. Sed vestibulum bibendum sodales.' +
'Mauris consectetur ipsum ac turpis aliquam id placerat justo ornare. ' +
'Donec nisl arcu, faucibus vel dictum vitae, dapibus vel mauris. ' +
'Sed lacinia, elit ut commodo tempor, mauris felis consequat nisl, sit amet laoreet est quam et tortor. ' +
'Proin mattis interdum tempus. Etiam ac vehicula neque. ' +
'Donec tempor, velit sit amet adipiscing laoreet, lorem ipsum convallis elit, a tempus elit urna sit amet sem. ' +
'Etiam vitae nisi dolor. Duis euismod eleifend ipsum aliquet porttitor. Integer luctus mattis nibh nec congue. ' +
'Ut et elit nec sem accumsan aliquam. Sed eu rhoncus magna. Sed eu augue in elit rutrum bibendum. Etiam ac placerat nibh.' +
'Suspendisse in turpis vitae urna molestie porttitor. Proin quam arcu, lobortis et adipiscing sed, eleifend sed lorem. ' +
'Suspendisse a pellentesque nulla. Etiam et molestie est. Praesent erat est, aliquet vitae suscipit sed, pharetra non mi. ' +
'Nunc at diam nibh. Suspendisse potenti. Suspendisse eleifend porttitor suscipit. ' +
'Donec porttitor convallis sapien at condimentum. Quisque id enim a ligula interdum feugiat. ' +
'Ut adipiscing libero sit amet sem varius pulvinar. ' +
'Fusce nulla ligula, pretium quis eleifend id, vehicula vel leo.';

var
  GLoremIpsum: TStrings;


function GetLoremIpsum: TArray<string>;
var
  I, J: Integer;
begin
  if GLoremIpsum = nil then
  begin
    GLoremIpsum := TStringList.Create;
    I := 1;
    repeat
      J := FindDelimiter('.,', sLoremIpsum, I);
      if J < 1 then
        J := sLoremIpsum.Length;
      if J-I > 0 then
        GLoremIpsum.Add(sLoremIpsum.Substring(I-1, J-1).Trim);
      I := J + 1;
    until J = sLoremIpsum.Length;
  end;
  Result := GLoremIpsum.ToStringArray
end;

function GetIntegers: TArray<Integer>;
var
  LList: TList<Integer>;
  I: Integer;
begin
  LList := TList<Integer>.Create;
  try
    for I := -100 to 100 do
      LList.Add(I);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;

end;

function GetUIntegers: TArray<UInt32>;
var
  LList: TList<UInt32>;
  I: Integer;
begin
  LList := TList<UInt32>.Create;
  try
    for I := 0 to 200 do
      LList.Add(I);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function GetSingles: TArray<Single>;
var
  LList: TList<Single>;
  I: Integer;
begin
  LList := TList<Single>.Create;
  try
    for I := 0 to 200 do
      LList.Add((I) + (I) / 100);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function GetCurrency: TArray<Currency>;
var
  LList: TList<Currency>;
  I: Integer;
begin
  LList := TList<Currency>.Create;
  try
    for I := 0 to 200 do
      LList.Add((I) + (I) / 100);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function GetDate: TArray<TDate>;
var
  LDateTime: TDateTime;
  LList: TList<TDate>;
begin
  LList := TList<TDate>.Create;
  try
    for LDateTime in GetDateTime do
      LList.Add(DateOf(LDateTime));
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function GetTime: TArray<TTime>;
var
  LDateTime: TDateTime;
  LList: TList<TTime>;
begin
  LList := TList<TTime>.Create;
  try
    for LDateTime in GetDateTime do
      LList.Add(TimeOf(LDateTime));
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function GetDateTime: TArray<TDateTime>;
var
  LList: TList<TDateTime>;
  I: Integer;
  LDateTime: TDateTime;
begin
  LList := TList<TDateTime>.Create;
  try
    LDateTime := StartOfTheYear(Now);
    for I := 0 to 200 do
    begin
      LList.Add(LDateTime);
      // Every day should be different
      if I mod 5 = 0 then
        LDateTime := IncWeek(LDateTime, I mod 3 + 1)
      else if I mod 50 = 0  then
        LDateTime := IncYear(LDateTime, I mod 3 + 1)
      else
        LDateTime := IncDay(LDateTime, I mod 3 + 1);
      // Every time should be different
      if I mod 2 = 0  then
        LDateTime := IncHour(LDateTime, I mod 3 + 1);
      LDateTime := IncMinute(LDateTime, I mod 10 + 1);
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;


{ TStrings }

function TStringsGenerator.CreateDelegate: TValueGeneratorDelegate;
const
  cCount = 50;
var
  ADelegate: TValueGeneratorDelegateWithEvents;
  LList: TList<Integer>;
  I: Integer;
  LStrings: TArray<string>;
begin
  ADelegate := nil;
  case FieldType of
    ftTStrings,
    ftString:
    begin
      LList := TList<integer>.Create;
      try
        for I := 1 to cCount do
          LList.Add(I);
        ADelegate := TTypedListValueGeneratorDelegate<Integer>.Create(Options, LList.ToArray);
        if FieldType = ftTStrings then
        begin
          LStrings := GetLoremIpsum;
          ADelegate.OnGetValue :=
            function(AValue: TValue; var AFree: Boolean): TValue
            begin
              Result := MakeStrings(AValue.AsInteger, LStrings);
              AFree := True;
            end
        end
        else
          ADelegate.OnGetValue :=
            function(AKey: TValue; var AFree: Boolean): TValue
            begin
              Result := Format('Strings%d', [AKey.AsInteger]);
            end
      finally
        LList.Free;
      end;
    end;
  else
    Assert(False);
  end;
  Result := ADelegate;
end;

function TStringsGenerator.MakeStrings(AIndex: Integer; AValues: TArray<string>): TStrings;
var
  I: Integer;
  LText: string;
  LCount: Integer;
begin
  if SameText(GeneratorName, sLoremIpsums) then
  begin
    Result := TStringList.Create;
    I := AIndex mod (Length(AValues)-1);
    LCount := 3;
    LText := IntToStr(AIndex) + '. ';
    while LCount > 0 do
    begin
      if I >= Length(AValues) then
        I := 0;
      LText := LText + AValues[I];
      Dec(LCount);
    end;
    Result.Text := LText;
  end
  else
  begin
    Result := TStringList.Create;
    for I := 0 to 10 do
      Result.Add(Format('', [AIndex, I]));
  end;

end;

const
  cContactNames: array[0..cContactsItemCount-1] of string =
  (
'Adam Brown',
'Paul Davis',
'Mark Anderson',
'James Garcia',
'Steve Moore',
//'Daniel Walker',
//'Tina Miller',
'Christine Jones',
'Michelle Smith',
'Mary Harris',
'Susan Sanchez',
'Donna Martin'

  );

  cContactTitles: array[0..cContactsItemCount-1] of string =
  (
'Accountant',
'Receptionist',
'Software Engineer',
'IT Manager',
'Account Manager',
'Marketing Director',
'Product Specialist',
'Sales Manager',
'Vice President',
'Staffing Manager'

  );

{ TContactStringGenerator }

function TContactStringGenerator.CreateDelegate: TValueGeneratorDelegate;
var
  ADelegate: TValueGeneratorDelegate;
  LStringList: TList<string>;
  S: string;
begin
  ADelegate := nil;
  case FieldType of
    ftString:
    begin
      LStringList := TList<string>.Create;
      try
        if SameText(GeneratorName, sContactNames) then
          for s in cContactNames do
            LStringList.Add(s)
        else if SameText(GeneratorName, sContactTitles) then
          for s in cContactTitles do
            LStringList.Add(s);
        Assert(LStringList.Count = cContactsItemCount);
        ADelegate := TTypedListValueGeneratorDelegate<string>.Create(Options, LStringList.ToArray);
      finally
        LStringList.Free;
      end;
    end;
  else
    Assert(False);
  end;
  Result := ADelegate;
end;

initialization
  RegisterGenerators;
finalization
  UnregisterGenerators;
  GLoremIpsum.Free;
end.

