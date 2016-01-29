unit evFormats;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evFormats -     }
{ Начат: 27.12.2006 17:28 }
{ $Id: evFormats.pas,v 1.4 2013/06/03 09:11:20 lulin Exp $ }

// $Log: evFormats.pas,v $
// Revision 1.4  2013/06/03 09:11:20  lulin
// - запил против бракоделов из Embarcadero.
//
// Revision 1.3  2012/11/01 09:41:35  lulin
// - забыл точку с запятой.
//
// Revision 1.2  2012/11/01 07:42:57  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.1  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.1  2006/12/27 14:39:12  lulin
// - упрощена работа со списками форматов.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces
  ;

var
  evPlainTextFormats : Tl3ClipboardFormats = nil;
  evAllFormats : Tl3ClipboardFormats = nil;

implementation

uses
  l3Base,

  evTypes
  ;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evFormats.pas initialization enter'); {$EndIf}
 evPlainTextFormats := l3FormatArray([cf_UnicodeText, cf_Text, cf_OEMText]);
 {$IfDef XE4}
 evAllFormats :=  l3CatFormatArray(
                  l3CatFormatArray(
                  l3CatFormatArray([cf_EverestBin],
                  l3CatFormatArray([cf_EverestTxt],
                                  l3FormatArray([cf_RTF, cf_RTFLite,
                                                 cf_Bitmap])
                                 )),
                                 evPlainTextFormats),
                                 [cf_hDrop]);
 {$Else}
 evAllFormats := l3FormatArray([cf_EverestBin, cf_EverestTxt,
                                cf_RTF, cf_RTFLite,
                                cf_Bitmap,
                                cf_UnicodeText, cf_Text, cf_OEMText,
                                cf_hDrop]);
 {$EndIf XE4}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evFormats.pas initialization leave'); {$EndIf}
finalization
 evPlainTextFormats := nil;
 evAllFormats := nil;

end.

