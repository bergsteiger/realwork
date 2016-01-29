unit evFontInterface;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evFontInterface - }
{ Начат: 19.05.2005 16:14 }
{ $Id: evFontInterface.pas,v 1.12 2014/04/08 17:13:19 lulin Exp $ }

// $Log: evFontInterface.pas,v $
// Revision 1.12  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.10  2014/03/24 12:02:14  lulin
// {RequestLink:522793127}
//
// Revision 1.9  2014/03/18 17:40:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.8  2014/02/14 15:33:32  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.7  2013/03/29 11:36:53  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.6  2008/01/23 11:50:49  voba
// - У дефолтного стиля все параметры собственные (Own)
//
// Revision 1.5  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.15  2007/09/20 18:10:38  lulin
// - форматируем параграф с учетом того, что он может содержать сегменты с объектами.
//
// Revision 1.1.2.14  2007/09/11 18:49:58  lulin
// - удален ненужный параметр.
//
// Revision 1.1.2.13  2007/04/13 11:36:17  lulin
// - используем родную канву для подсчетов.
//
// Revision 1.1.2.12  2007/01/12 12:53:11  lulin
// - bug fix: зацикливались при старте приложения.
//
// Revision 1.1.2.11  2007/01/12 11:00:48  lulin
// - cleanup.
//
// Revision 1.1.2.10  2007/01/11 14:06:28  lulin
// - интерфейс шрифта переехал в базовый модуль.
//
// Revision 1.1.2.9  2006/12/11 12:25:07  lulin
// - cleanup.
//
// Revision 1.1.2.8  2005/10/24 07:33:54  lulin
// - bug fix: не компилировалось.
//
// Revision 1.1.2.7  2005/10/07 11:21:14  lulin
// - спрятано устаревшее свойство шрифта.
//
// Revision 1.1.2.6  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.1.2.5  2005/05/23 13:26:05  lulin
// - используем интерфейс, а не объект.
//
// Revision 1.1.2.4  2005/05/23 13:03:42  lulin
// - cleanup.
//
// Revision 1.1.2.3  2005/05/20 12:10:52  lulin
// - new unit: l3FontTools.
//
// Revision 1.1.2.2  2005/05/19 12:48:34  lulin
// - new unit: evInterface.
//
// Revision 1.1.2.1  2005/05/19 12:31:10  lulin
// - получение шрифта у блока и у курсора приведено к единому знаменателю.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  
  Graphics,
  
  l3Types,
  l3Interfaces,

  k2Tags,
  
  evInterface,

  nevTools
  ;

type
  TevFontInterface = class(TevInterface, Il3Font)
   {* Инструмент для работы со шрифтом. }
    private
    // inhernal fields
      f_Font     : InevFontPrim;
      f_Style    : TevInterface;
    protected
    // property methods
      function  pm_GetName: String;
        override;
      procedure pm_SetName(const Value: String);
        override;
        {-}
      procedure pm_SetStyle(aValue: TevInterface);
        {-}
      function  pm_GetParam(Index: Long): Long;
        override;
      procedure pm_SetParam(anIndex: Long; aValue: Long);
        override;
        {-}
      procedure pm_SetIsTransparent(Index: Long; Value: Bool);
        override;
        {-}
      procedure pm_SetIsOwn(Index: Long; Value: Bool);
        override;
        {-}
      function pm_GetIsOwn(Index: Long): Bool;
       override;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
    // Il3Font
      function  Get_ForeColor: TColor;
      procedure Set_ForeColor(Value: TColor);
        {-}
      function  Get_BackColor: TColor;
      procedure Set_BackColor(Value: TColor);
        {-}
      function  Get_Name: TFontName;
      procedure Set_Name(const Value: TFontName);
        {-}
      function  Get_Pitch: TFontPitch;
      procedure Set_Pitch(Value: TFontPitch);
        {-}
      function  Get_Size: Long;
      procedure Set_Size(Value: Long);
        {-}
      function  Get_Style: TFontStyles;
      procedure Set_Style(Value: TFontStyles);
        {-}
      function  Get_Index: Tl3FontIndex;
      procedure Set_Index(Value: Tl3FontIndex);
        {-}
      function  Get_Bold: Boolean;
      procedure Set_Bold(Value: Boolean);
        {-}
      function  Get_Italic: Boolean;
      procedure Set_Italic(Value: Boolean);
        {-}
      function  Get_Underline: Boolean;
      procedure Set_Underline(Value: Boolean);
        {-}
      function  Get_Strikeout : Boolean;
        {-}
      procedure Set_Strikeout(Value : Boolean);
        {-}
    public
    // Il3Font
      function  AssignFont(aFont: TFont): Boolean;
        {-}
      procedure Assign2Font(aFont: TFont);
        overload;
        {-}
      procedure Assign2Font(const aFont: Il3Font);
        overload;
        {-}
      function IsAtomic: Boolean;
        {-}
      function HF: hFont;
        {-}
      function FM: Il3FontMetrics;
        {-}
      procedure Lock;
        {-}
      procedure Unlock;
        {-}
    public
    // public methods
      constructor Create;
        override;
        {-}
      procedure Changing;
        override;
        {-}
      procedure ChangedEx(aCancel: Boolean);
        override;
        {-}
      procedure CheckTag;
        {-}
    public
    // public properties
      property FontIndex : Tl3FontIndex
        read Get_Index
        write Set_Index;
        {-}
      property Pitch : TFontPitch
        read Get_Pitch
        write Set_Pitch;
        {-}
      property Style: TevInterface
        read f_Style
        write pm_SetStyle;
        {* - стиль к которому относиться шрифт. }
      property Bold: Bool
        index k2_tiBold
        read pm_GetBoolParam
        write pm_SetBoolParam;
        {* - жирный. }
      property Italic: Bool
        index k2_tiItalic
        read pm_GetBoolParam
        write pm_SetBoolParam;
        {* - курсив. }
      property Underline: Bool
        index k2_tiUnderline
        read pm_GetBoolParam
        write pm_SetBoolParam;
        {* - подчеркнутый. }
      property StrikeOut: Bool
        index k2_tiStrikeOut
        read pm_GetBoolParam
        write pm_SetBoolParam;
        {* - перечеркнутый. }
      property ForeColor: Long
        index k2_tiForeColor
        read pm_GetLongParam
        write pm_SetLongParam;
        {* - цвет текста. }
      property BackColor: Long
        index k2_tiBackColor
        read pm_GetLongParam
        write pm_SetLongParam;
        {* - цвет фона. }
      property Size: Long
        index k2_tiSize
        read pm_GetLongParam
        write pm_SetLongParam;
        {* - кегль. }
  end;//TevFontInterface

implementation

uses
  l3Base,
  l3FontTools,

  k2Interfaces,

  evStyleTableSpy,

  nevFontPrim
  ;

// start class TevFontInterface 

constructor TevFontInterface.Create;
  {override;}
  {-}
begin
 inherited;
 f_Font := TnevFontPrim.Make;
end;

procedure TevFontInterface.Cleanup;
  {override;}
  {-}
begin
 f_Font := nil;
 Style := nil;
 inherited;
end;

procedure TevFontInterface.Changing;
  //override;
  {-}
begin
 {$If not defined(DesignTimeLibrary)}
 evNotifyStyleTableChanging;
 {$IfEnd}
 inherited;
end;

procedure TevFontInterface.ChangedEx(aCancel: Boolean);
  //override;
  {-}
begin
 inherited ChangedEx(aCancel);
 {$If not defined(DesignTimeLibrary)}
 evNotifyStyleTableChanged(aCancel);
 {$IfEnd}
end;

procedure TevFontInterface.pm_SetStyle(aValue: TevInterface);
  {-}
begin
 Tag := nil;
 f_Style := aValue;
 if (f_Style <> nil) then
 begin
  Self.Tag := f_Style.Tag.rOwnAtom(k2_tiFont);
   // - Own - это чтобы не брать от родителя, т.к. иначе начинается чехарда с "С"
   //   вместо "Р".
  f_Font.InitFromTag(f_Style.Tag);
 end//f_Style <> nil
 else
  Tag := nil;
end;

function TevFontInterface.pm_GetName: String;
  {override;}
  {-}
var
 L: Long;
begin
 L := f_Font.GetParam(k2_tiName);
 if (L = 0) then
  Result := ''
 else
  Result := Tl3CustomString(L).AsString;
end;

procedure TevFontInterface.CheckTag;
  {-}
begin
 Tag := f_Style.Tag.cAtom(k2_tiFont, Context);
end;

procedure TevFontInterface.pm_SetName(const Value: String);
  {override;}
  {-}
begin
 CheckTag;
 inherited pm_SetName(Value);
 f_Font.InitFromTag(f_Style.Tag);
end;

function TevFontInterface.pm_GetParam(Index: Long): Long;
  {override;}
  {-}
begin
 Result := f_Font.GetParam(Tk2FontParam(Index));
end;

procedure TevFontInterface.pm_SetParam(anIndex: Long; aValue: Long);
  {override;}
begin
 CheckTag;
 inherited;
 f_Font.InitFromTag(f_Style.Tag);
end;

procedure TevFontInterface.pm_SetIsTransparent(Index: Long; Value: Bool);
  {override;}
  {-}
begin
 CheckTag;
 inherited pm_SetIsTransparent(Index, Value);
 f_Font.InitFromTag(f_Style.Tag);
end;

procedure TevFontInterface.pm_SetIsOwn(Index: Long; Value: Bool);
  {override;}
  {-}
begin
 CheckTag;
 inherited pm_SetIsOwn(Index, Value);
 f_Font.InitFromTag(f_Style.Tag);
end;

function TevFontInterface.pm_GetIsOwn(Index: Long): Bool;
  {override;}
  {-}
begin
 Result := inherited pm_GetIsOwn(Index) or Style.IsDefault;
end;

procedure TevFontInterface.Assign2Font(const aFont : Il3Font);
  {-}
begin
 Lock;
 try
  aFont.Lock;
  try
   aFont.Name      := Name;
   aFont.Size      := Size;
   aFont.Style     := Get_Style;
   aFont.Pitch     := Pitch;
   aFont.ForeColor := ForeColor;
   aFont.BackColor := BackColor;
   aFont.Index     := FontIndex;
  finally
   aFont.Unlock;
  end;//try..finally
 finally
  Unlock;
 end;//try..finally
end;

function TevFontInterface.IsAtomic: Boolean;
  {-}
begin
 Result := false;
end;

function TevFontInterface.HF: hFont;
  {-}
begin
 Result := 0;
 Assert(false);
end;

function TevFontInterface.FM: Il3FontMetrics;
  {-}
begin
 Result := nil;
end;

function TevFontInterface.AssignFont(aFont : TFont) : Boolean;
  {-}
begin
 Result := true;
 Lock;
 try
  Name := aFont.Name;
  Size := aFont.Size;
  Set_Style(aFont.Style);
  Pitch := aFont.Pitch;
  ForeColor := aFont.Color;
 finally
  Unlock;
 end;//try..finally
end;

procedure TevFontInterface.Assign2Font(aFont: TFont);
  //overload;
  {-}
begin
 l3IFont2Font(Il3Font(Self), aFont);
end;
  
function TevFontInterface.Get_ForeColor : TColor;
  {-}
begin
 Result := ForeColor;
end;

procedure TevFontInterface.Set_ForeColor(Value : TColor);
  {-}
begin
 ForeColor := Value;
end;

function TevFontInterface.Get_Italic : Boolean;
  {-}
begin
 Result := Italic;
end;

procedure TevFontInterface.Set_Italic(Value : Boolean);
  {-}
begin
 Italic := Value;
end;

function TevFontInterface.Get_Size : Long;
  {-}
begin
 Result := Size;
end;

procedure TevFontInterface.Set_Size(Value : Long);
  {-}
begin
 Size := Value;
end;

function TevFontInterface.Get_Strikeout : Boolean;
  {-}
begin
 Result := Bool(Param[k2_tiStrikeout]);
end;

procedure TevFontInterface.Set_Strikeout(Value : Boolean);
  {-}
begin
 Param[k2_tiStrikeout] := Integer(Value);
end;

function TevFontInterface.Get_Style : TFontStyles;
  {-}
begin
 Result := [];
 if Bold then
  Include(Result, fsBold);
 if Underline then
  Include(Result, fsUnderline);
 if Italic then
  Include(Result, fsItalic);
 if StrikeOut then
  Include(Result, fsStrikeOut);
end;

procedure TevFontInterface.Set_Style(Value : TFontStyles);
  {-}
begin
 Bold := fsBold in Value;
 Italic := fsItalic in Value;
 Underline := fsUnderline in Value;
 StrikeOut := fsStrikeOut in Value;
end;

function TevFontInterface.Get_BackColor : TColor;
  {-}
begin
 Result := BackColor;
end;

procedure TevFontInterface.Set_BackColor(Value : TColor);
  {-}
begin
 BackColor := Value;
end;

function TevFontInterface.Get_Bold : Boolean;
  {-}
begin
 Result := Bold;
end;

procedure TevFontInterface.Set_Bold(Value : Boolean);
  {-}
begin
 Bold := Value;
end;

function TevFontInterface.Get_Index : Tl3FontIndex;
  {-}
begin
 Result := Tl3FontIndex(Param[k2_tiIndex]);
end;

procedure TevFontInterface.Set_Index(Value : Tl3FontIndex);
  {-}
begin
 Param[k2_tiIndex] := Ord(Value);
end;

function TevFontInterface.Get_Name : TFontName;
  {-}
begin
 Result := Name;
end;

procedure TevFontInterface.Set_Name(const Value : TFontName);
  {-}
begin
 Name := Value;
end;

function TevFontInterface.Get_Pitch : TFontPitch;
  {-}
begin
 Result := TFontPitch(Param[k2_tiPitch]);
end;

procedure TevFontInterface.Set_Pitch(Value : TFontPitch);
  {-}
begin
 Param[k2_tiPitch] := Ord(Value);
end;

function TevFontInterface.Get_Underline : Boolean;
  {-}
begin
 Result := Underline;
end;

procedure TevFontInterface.Set_Underline(Value : Boolean);
  {-}
begin
 Underline := Value;
end;

procedure TevFontInterface.Lock;
  {-}
begin
end;

procedure TevFontInterface.Unlock;
  {-}
begin
end;

end.

