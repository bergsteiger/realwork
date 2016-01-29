unit l3FontManager;
{* ������ ��� ������ �� ��������. }

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3Font -                    }
{ �����: 11.10.1999 14:27             }
{ $Id: l3FontManager.pas,v 1.24 2015/06/03 12:43:16 lulin Exp $ }

// $Log: l3FontManager.pas,v $
// Revision 1.24  2015/06/03 12:43:16  lulin
// - �������� ��������� �����������.
//
// Revision 1.23  2014/03/03 14:03:53  lulin
// - ����������� ��������� �������.
//
// Revision 1.22  2014/03/03 13:02:35  lulin
// - �������� _Tl3LogFont � ��������� ����.
//
// Revision 1.21  2014/03/03 12:09:24  lulin
// - ��������� ��������.
//
// Revision 1.20  2013/11/06 17:05:23  lulin
// - ������ ����� ��� XE.
//
// Revision 1.19  2013/11/05 16:42:19  lulin
// - ���������� ����� � ������� ��������.
//
// Revision 1.18  2013/11/05 16:38:20  lulin
// - ���������� ����� � ������� ��������.
//
// Revision 1.17  2013/04/04 11:33:01  lulin
// - ���������.
//
// Revision 1.16  2011/11/07 07:25:51  lulin
// {RequestLink:296632270}
//
// Revision 1.15  2011/09/02 12:02:31  lulin
// {RequestLink:280006084}.
//
// Revision 1.14  2011/05/18 17:46:00  lulin
// {RequestLink:266409354}.
//
// Revision 1.13  2010/02/27 10:51:17  lulin
// {RequestLink:193822954}.
// - �������� ���������.
//
// Revision 1.12  2010/02/24 18:16:05  lulin
// - ����������� �� ��������� � �������� ���������, ������������ � ���������� �� ������ ���������.
//
// Revision 1.11  2009/07/21 15:10:18  lulin
// - bug fix: �� ��������� � �� ������� ���������� � �����.
//
// Revision 1.10  2008/02/20 17:23:09  lulin
// - �������� ������.
//
// Revision 1.9  2008/02/12 19:32:36  lulin
// - ����������� �� ��������������� �������.
//
// Revision 1.8  2008/02/06 09:55:31  lulin
// - ���������� ������� ������� ��������������� ���������.
//
// Revision 1.7  2008/02/05 09:58:12  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.6  2007/08/14 14:30:13  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.5  2007/02/16 15:36:10  lulin
// - cleanup.
//
// Revision 1.4  2007/01/30 15:24:24  lulin
// - ����� ���� - ������ ����� �������� ����.
//
// Revision 1.3  2007/01/12 13:22:46  lulin
// - cleanup.
//
// Revision 1.2  2006/12/25 10:20:29  lulin
// - ��������� ������ ������ �������� ����� �������, � �� �����.
//
// Revision 1.1  2006/12/04 15:39:41  lulin
// - ������ ������������ � ������������ � ��� ���������.
//
// Revision 1.31  2006/05/03 15:04:22  lulin
// - cleanup: �� ����������� �����������, � ����������� ��������� �������������.
//
// Revision 1.30  2006/04/20 13:33:35  voba
// -  change in Tl3_CustomString - ������ pm_GetSt ������ ����������� DoGetSt
//
// Revision 1.29  2006/01/16 16:41:47  lulin
// - ������� ����������� �������� �� �������� ��� ������� ������� (������-�� �� ������������������ �� ��������).
//
// Revision 1.28  2005/11/23 11:33:45  migel
// - fix: ����������� ��������, ���� � ������� ��� ������ `Courier*` (��������� ��. CQ:16889).
//
// Revision 1.27  2005/05/26 15:35:10  lulin
// - ������� ����� ������ ������ ��������� �� ������ � ��������� ����������.
//
// Revision 1.26  2005/05/26 13:19:36  lulin
// - new unit: _l3ScreenIC.
//
// Revision 1.25  2005/04/28 15:04:11  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.24.4.1  2005/04/26 14:30:57  lulin
// - �������� l3Free � _l3Use.
//
// Revision 1.24  2005/04/04 14:02:02  mmorozov
// new: global function l3IsDefaultCharset;
//
// Revision 1.23  2005/04/01 10:10:58  mmorozov
// remove: ���������� ����������;
//
// Revision 1.22  2005/03/28 08:36:12  mmorozov
// - ��������� ����������������� ��������� lpPrintTextMetric;
//
// Revision 1.21  2005/01/28 15:35:26  lulin
// - new behavior: ��� ������ ������� �������� ���������� ������� " New".
//
// Revision 1.20  2004/12/08 13:51:31  lulin
// - ����� ��������������� ���� ������������� ������.
//
// Revision 1.18  2004/11/22 14:01:10  lulin
// - bug fix: ������������� AV - ���� �� ������� �� ������ ������������� ������.
//
// Revision 1.17  2004/11/22 12:58:20  lulin
// - ��������� �����������.
//
// Revision 1.16  2004/11/22 12:47:45  lulin
// - ���������� �������� Default - ����� �� ������ ����� ������ ���.
//
// Revision 1.15  2004/11/22 12:35:52  lulin
// - new behavior: ���� ���� ������ Courier New Cyr, �� ���� ������ ������������.
//
// Revision 1.14  2004/11/22 12:14:53  lulin
// - bug fix: ������������� ������������.
//
// Revision 1.13  2004/09/28 17:22:15  lulin
// - � ������ ����������� ������ ��� ����������. ���� ��� ��������� ���������� �� ����.
//
// Revision 1.12  2004/06/10 11:03:25  law
// - �������� Tl3CustomString.Len ������� �����������.
//
// Revision 1.11  2004/04/15 09:59:04  law
// - bug fix: ������� ���������� ������� ��� ���������������.
//
// Revision 1.10  2001/09/10 11:38:44  law
// - split unit: evDef -> evDef + l3Defaults.
//
// Revision 1.9  2001/07/26 15:55:03  law
// - comments: xHelpGen.
//
// Revision 1.8  2000/12/15 15:19:00  law
// - ��������� ��������� Log.
//

{$Include l3Define.inc }

interface

uses
  Windows,
  Classes,
  Graphics,

  l3Interfaces,
  l3Types,
  l3Base,
  l3Dict,
  l3LogFont,
  l3FontManagerPrim
  ;

type
  Tl3LogFont = l3LogFont.Tl3LogFont;

  Tl3FontManager = class(Tl3FontManagerPrim)
   {* �������� �������. }
    private
      f_ANSIDOSFontNameRecursionCount: Integer;
    protected
    // property methods
      function pm_GetDRByName(const aName: AnsiString): Tl3LogFont;
        override;
        {-}
    protected
    // internal methods
      function EnumFontFamProc(lpLogFont    : PEnumLogFont;
                               lpTextMetric : PTextMetric;
                               FontType     : Integer): Integer;
        {-}
      procedure InitFields;
        override;
        {-}
  end;{Tl3FontManager}

function Fonts: Tl3FontManager;
 {* - ���������� �������� ������� �� ���������. }

implementation

uses
  SysUtils,
  StrUtils,

  l3Chars,
  l3Defaults,
  l3ScreenIC,
  l3FontTools,
  l3String,
  l3FontManagerEx
  ;

// start class Tl3FontManager

function _EnumFontFamProc(LogFont    : PEnumLogFont;
                          TextMetric : PTextMetric;
                          FontType   : Integer;
                          Self       : Pointer): Integer;
  export;
  stdcall;
begin
 Result := Tl3FontManager(Self).EnumFontFamProc(LogFont, TextMetric, FontType);
end;

procedure Tl3FontManager.InitFields;
  {override;}
  {-}
begin
 inherited;
 f_ANSIDOSFontNameRecursionCount := 0;
 EnumFontFamilies(l3CrtIC.DC, nil, @_EnumFontFamProc, LParam(Self));
end;

function Tl3FontManager.EnumFontFamProc(lpLogFont    : PEnumLogFont;
                                        lpTextMetric : PTextMetric;
                                        FontType     : Integer): Integer;
  {-}
  (* procedure lpPrintTextMetric(aMetric         : TTextMetric;
                              const aFileName : AnsiString);
  var
   lStrings : TStrings;
  begin
   lStrings := TStringList.Create;
   try
    lStrings.Add(Format('tmDescent = %d',          [aMetric.tmDescent]));
    lStrings.Add(Format('tmDefaultChar = %s',      [aMetric.tmDefaultChar]));
    lStrings.Add(Format('tmCharSet = %d',          [aMetric.tmCharSet]));
    lStrings.Add(Format('tmBreakChar = %s',        [aMetric.tmBreakChar]));
    lStrings.Add(Format('tmAveCharWidth = %d',     [aMetric.tmAveCharWidth]));
    lStrings.Add(Format('tmAscent = %d',           [aMetric.tmAscent]));
    lStrings.Add(Format('tmWeight = %d',           [aMetric.tmWeight]));
    lStrings.Add(Format('tmUnderlined = %d',       [aMetric.tmUnderlined]));
    lStrings.Add(Format('tmStruckOut = %d',        [aMetric.tmStruckOut]));
    lStrings.Add(Format('tmPitchAndFamily = %d',   [aMetric.tmPitchAndFamily]));
    lStrings.Add(Format('tmOverhang = %d',         [aMetric.tmOverhang]));
    lStrings.Add(Format('tmMaxCharWidth = %d',     [aMetric.tmMaxCharWidth]));
    lStrings.Add(Format('tmLastChar = %s',         [aMetric.tmLastChar]));
    lStrings.Add(Format('tmItalic = %d',           [aMetric.tmItalic]));
    lStrings.Add(Format('tmInternalLeading = %d',  [aMetric.tmInternalLeading]));
    lStrings.Add(Format('tmHeight = %d',           [aMetric.tmHeight]));
    lStrings.Add(Format('tmFirstChar = %s',        [aMetric.tmFirstChar]));
    lStrings.Add(Format('tmExternalLeading = %d',  [aMetric.tmExternalLeading]));
    lStrings.Add(Format('tmDigitizedAspectY = %d', [aMetric.tmDigitizedAspectY]));
    lStrings.Add(Format('tmDigitizedAspectX = %d', [aMetric.tmDigitizedAspectX]));
    lStrings.SaveToFile(aFileName);
   finally
    l3Free(lStrings);
   end;
  end; *)

var
 LF : Tl3LogFont;
begin
 LF := Tl3LogFont.Create(lpLogFont^, lpTextMetric^);
 try
  Add(LF);
 finally
  FreeAndNil(LF);
 end;{try..finally}
 Result := -1;
end;

function Tl3FontManager.pm_GetDRByName(const aName: AnsiString): Tl3LogFont;
  {override;}
  {-}
  
type
 Pl3LogFont = ^Tl3LogFont;

 function DoFont(pFont: Pl3LogFont; anIndex: Long): Boolean;
 begin//DoFont
  if not pFont.IsFixed then
  begin
   pm_GetDRByName := pFont^;
   Result := false;
  end//pFont^.IsFixed
  else
   Result := true;
 end;//DoFont

var
 l_LF : Tl3LogFont;
 l_Index : Integer;
begin
 Result := inherited pm_GetDRByName(aName);
 if (Result = nil) AND (aName <> '') then
 begin
  try
   if {not ANSISameText(fs_Cyr, aName) AND} ANSIEndsText(fs_Cyr, aName) then
    Result := DRByName[Copy(aName, 1, Length(aName)-Length(fs_Cyr))]
   else
   if {not ANSISameText(fs_New, aName) AND} ANSIEndsText(fs_New, aName) then
    Result := DRByName[Copy(aName, 1, Length(aName)-Length(fs_New))];

   if (Result = nil) then
   begin
    if (aName <> def_ANSIDOSFontName) and
       (f_ANSIDOSFontNameRecursionCount = 0) then
    begin
     Inc(f_ANSIDOSFontNameRecursionCount);
     try
      Result := DRByName[def_ANSIDOSFontName];
     finally
      Dec(f_ANSIDOSFontNameRecursionCount);
     end;
    end//aName <> def_ANSIDOSFontName
    else
     // - ���� ����� �����, ������� �������� ��������
     IterateAllF(l3L2IA(@DoFont));
   end;//Result = nil
  finally
   if (Result <> nil) then
   begin
    //if not ANSISameText(fs_Cyr, aName) then
    begin
     // - ��������� ��������� ����� - ����� ������ �� ������
     l_LF := Tl3LogFont.CreateNamed(Result.LogFont, Result.TextMetric, aName);
     try
      //l_LF.f_LogFont := Tl3LogFont(Result).LogFont;
      {$IfDef XE}
      //l_WS := aName;
      //l3Move(l_WS[1], l_LF.f_LogFont.elfLogFont.lfFaceName[0], Length(l_WS) * SizeOf(Char));
      {$Else XE}
      //l3Move(aName[1], l_LF.f_LogFont.elfLogFont.lfFaceName[0], Length(aName));
      {$EndIf XE}
      //l_LF.f_NameLen := Length(aName);
      //l_LF.f_TextMetric := Tl3LogFont(Result).TextMetric;
      l_Index := Add(l_LF);
      Assert(l_Index >= 0);
      Result := Items[l_Index];
     finally
      FreeAndNil(l_LF);
     end;//try..finally
    end;//not ANSISameText(fs_Cyr, aName)
   end;//Result <> nil
  end;//try..finally
 end;//Result = nil
end;

function Fonts: Tl3FontManager;
begin
 Result := Tl3FontManagerEx.Instance;
end;

end.

