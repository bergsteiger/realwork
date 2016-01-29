unit evCursorShapeMisc;
{* Вспомогательные функции для работы с курсором мыши. }

{ Библиотека "Эверест"        }
{ Автор: Люлин А.В. ©         }
{ Модуль: evCursorShapeMisc - }
{ Начат: 02.11.2000 13:36     }
{ $Id: evCursorShapeMisc.pas,v 1.8 2012/11/01 09:41:35 lulin Exp $ }

// $Log: evCursorShapeMisc.pas,v $
// Revision 1.8  2012/11/01 09:41:35  lulin
// - забыл точку с запятой.
//
// Revision 1.7  2012/11/01 07:42:57  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.6  2009/06/02 17:23:15  lulin
// - удалены ненужные интерфейсы и переопределения типов.
//
// Revision 1.5  2008/02/27 13:21:45  oman
// - fix: Новые курсоры для руки (cq28334)
//
// Revision 1.4  2008/02/27 07:31:35  oman
// - fix: Новые курсоры для руки (cq28334)
//
// Revision 1.3  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.2.60.1  2006/11/03 11:00:03  lulin
// - объединил с веткой 6.4.
//
// Revision 1.2.102.1  2006/10/19 10:56:17  lulin
// - параметры курсора переехали в более общую библиотеку.
//
// Revision 1.2  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

{$IfDef l3ConsoleApp}
  !!! - нельзя изпользовать данный модуль с директивой l3ConsoleApp.
{$EndIf l3ConsoleApp}

uses
  Windows,
  Controls,
  
  l3Types,

  afwInterfaces
  ;

function evCursorShape2Cursor(aCursorShape: TafwCursorShape): TCursor;
  {* - преобразует TevCursorShape в TCursor. }

{$R evCursors.res evCursors.rc }

implementation

uses
  TypInfo,
  SysUtils,
  Forms
  ;

const
 evCursorsBase = 1000;

function CalcResourceName(aCursorShape: TafwCursorShape): String;
begin
 Result := GetEnumName(TypeInfo(TafwCursorShape), Ord(aCursorShape));
 Result := 'CR_' + UpperCase(System.Copy(Result, 6, Length(Result) - 5));
end;

function evCursorShape2Cursor(aCursorShape: TafwCursorShape): TCursor;
  {* - преобразует TafwCursorShape в TCursor. }
const
 Cursors : array [Low(TafwCursorShape)..ev_csSizeAll] of TCursor =
  (crDefault,  crNone,      crArrow,     crCross,     crIBeam,     crSizeNESW,
   crSizeNS,   crSizeNWSE,  crSizeWE,    crUpArrow,   crHourGlass, crDrag,
   crNoDrop,   crHSplit,    crVSplit,    crMultiDrag, crSQLWait,   crNo,
   crAppStart, crHelp,      crHandPoint, crSize,      crSizeAll);
var
 l_Cursor      : HCursor;
 l_CursorIndex : TCursor;
 l_CursorName  : String;
 l_CursorPChar : PChar;
begin
 if (aCursorShape >=Low(Cursors)) AND (aCursorShape <= High(Cursors)) then
  Result := Cursors[aCursorShape]
 else begin
  l_CursorIndex := evCursorsBase + Ord(aCursorShape) - Ord(High(Cursors)) - 1;
  Result := l_CursorIndex;
  l_Cursor := Screen.Cursors[l_CursorIndex];
  if (l_Cursor = Screen.Cursors[crDefault]) then begin
   if (aCursorShape = ev_csSelectLine) then
    l_CursorPChar := MakeIntResource(32668)
   else begin
    l_CursorName := CalcResourceName(aCursorShape);
    l_CursorPChar := PChar(l_CursorName);
   end;
   l_Cursor := LoadCursor(hInstance, l_CursorPChar);
   if (l_Cursor = 0) then
    Result := crDefault
   else
    Screen.Cursors[l_CursorIndex] := l_Cursor;
  end;
 end;
end;

var
 l_Cursor: HCursor;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evCursorShapeMisc.pas initialization enter'); {$EndIf}
 l_Cursor := LoadCursor(hInstance, PChar(CalcResourceName(ev_csHandPoint)));
 if (l_Cursor <> 0) then
  Screen.Cursors[crHandPoint] := l_Cursor;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evCursorShapeMisc.pas initialization leave'); {$EndIf}
end.

