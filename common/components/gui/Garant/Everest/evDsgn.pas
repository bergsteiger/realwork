unit evDsgn;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В.     }
{ Модуль: evDsgn - }
{ Начат: 16.10.98 16:24 }
{ $Id: evDsgn.pas,v 1.29 2014/07/01 12:23:17 lulin Exp $ }

// $Log: evDsgn.pas,v $
// Revision 1.29  2014/07/01 12:23:17  lulin
// - пытаемся собрать несобирающееся.
//
// Revision 1.28  2014/07/01 12:21:17  lulin
// - пытаемся собрать несобирающееся.
//
// Revision 1.27  2014/02/18 16:31:20  lulin
// - подготавливаемся к обобщению словарей.
//
// Revision 1.26  2012/11/01 09:41:35  lulin
// - забыл точку с запятой.
//
// Revision 1.25  2012/11/01 07:42:57  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.24  2009/07/22 07:10:26  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.23  2009/07/21 12:49:23  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.22  2009/03/04 18:14:14  lulin
// - <K>: 137470629. Удалён ненужный интерфейс.
//
// Revision 1.21  2009/03/04 16:58:50  lulin
// - <K>: 137470629. Bug fix: не собиралась библиотека.
//
// Revision 1.20  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.19  2008/02/21 08:58:35  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.18  2008/02/07 08:40:54  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.17  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.14.8.4  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.14.8.3.2.1  2007/09/12 19:56:47  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.14.8.3  2006/12/14 10:41:03  lulin
// - cleanup.
//
// Revision 1.14.8.2  2005/07/15 10:14:03  lulin
// - избавляемся от использования самостийной функции преобразования интерфейсов.
//
// Revision 1.14.8.1  2005/05/24 08:48:30  lulin
// - bug fix: не компилировалось.
//
// Revision 1.14  2005/03/28 12:29:03  lulin
// - bug fix: не компилировалось.
//
// Revision 1.13  2004/11/05 15:12:29  lulin
// - bug fix: не компилировалось.
//
// Revision 1.12  2002/10/01 08:51:28  narry
// no message
//
// Revision 1.11  2001/08/31 07:19:14  law
// - split unit: evDsgn -> evDsgn, l3HackRTTI.
//
// Revision 1.10  2001/08/30 16:34:02  law
// - new version: портировал на Delphi 6.
//
// Revision 1.9  2001/03/26 13:50:23  law
// - убран класс Wk2Handle.
//
// Revision 1.8  2001/01/31 10:37:29  law
// - оптимизировано использование QueryInterface.
//
// Revision 1.7  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Classes,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}

  evStyleInterface
  ;

type
  {$IfDef Delphi6}
  TGetPropEditProc = TGetPropProc;
  {$EndIf Delphi6}

  TevStyleProperty = class(TIntegerProperty)
    private
    // internal fields
      f_SI : TevStyleInterface;
    protected
    // internal methods
      function  pm_GetSI: TevStyleInterface;
        {-}
    public
    // public methods
      destructor Destroy;
        override;
        {-}
      procedure Edit;
        override;
        {-}
      function GetAttributes: TPropertyAttributes;
        override;
        {-}
      function GetValue: string;
        override;
        {-}
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
      procedure SetValue(const Value: string);
        override;
        {-}
    public
    {public properties}
      property SI: TevStyleInterface
        read pm_GetSI;
        {-}
  end;//TevStyleProperty

implementation

uses
  TypInfo,
  SysUtils,
  {$IfDef Delphi6}
  RTLConsts,
  DesignConst,
  Consts,
  {$Else  Delphi6}
  Consts,
  {$EndIf Delphi6}

  l3Types,
  //l3CBase,
  l3Base,
  l3Dict,
  l3InterfacesMisc,

  k2Interfaces,
  k2Tags,
  k2InternalInterfaces,
  k2Dictionary,

  evTypes,
  evdStyles,

  TextPara_Const
  ;

// start class TevStyleProperty

function TevStyleProperty.pm_GetSI: TevStyleInterface;
  {-}
(*var
 TT : Ik2TypeTable;
 l_TypeTableSource : Ik2TypeTableSource;*)
begin
 if (f_SI = nil) then
 begin
  f_SI := TevStyleInterface.Create{(Self)};
(*  if Supports(GetComponent(0), Ik2TypeTableSource, l_TypeTableSource) then
   try
    TT := l_TypeTableSource.TypeTable;
    if (TT <> nil) then f_SI.TypeTable := TT;
   finally
    l_TypeTableSource := nil;
   end;{try..finally}*)
  f_SI.SelectStyledObjectType(k2_typTextPara);
 end;{f_SI = nil}
 Result := f_SI;
end;

destructor TevStyleProperty.Destroy;
  {override;}
  {-}
begin
 l3Free(f_SI);
 inherited Destroy;
end;

procedure TevStyleProperty.Edit;
(*var
  ColorDialog: TColorDialog;
  IniName: string;
  IniFile: TIniFile;

  procedure GetCustomColors;
  begin
    IniFile := TIniFile.Create('DELPHI.INI');
    try
      IniFile.ReadSectionValues(LoadStr(SCustomColors), ColorDialog.CustomColors);
    except
      { Ignore errors reading values }
    end;
  end;

  procedure SaveCustomColors;
  var
    I, P: Integer;
    S: string;
  begin
    if IniFile <> nil then
      with ColorDialog do
        for I := 0 to CustomColors.Count - 1 do
        begin
          S := CustomColors.Strings[I];
          P := Pos('=', S);
          if P <> 0 then
          begin
            S := Copy(S, 1, P - 1);
            IniFile.WriteString(LoadStr(SCustomColors), S, CustomColors.Values[S]);
          end;
        end;
  end;
*)
begin
(*  IniFile := nil;
  ColorDialog := TColorDialog.Create(Application);
  try
    GetCustomColors;
    ColorDialog.Color := GetOrdValue;
    ColorDialog.HelpContext := hcDColorEditor;
    ColorDialog.Options := [cdShowHelp];
    if ColorDialog.Execute then SetOrdValue(ColorDialog.Color);
    SaveCustomColors;
  finally
    if IniFile <> nil then IniFile.Free;
    ColorDialog.Free;
  end;*)
end;

function TevStyleProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paMultiSelect, {paDialog, }paValueList];
end;

procedure TevStyleProperty.GetValues(Proc: TGetStrProc);

type
  Pl3PrimString = ^Tl3PrimString;

 function StyleFunc(Style: Pl3PrimString; Index: Long): Bool; far;
 begin
  Proc(Style.AsString);
  Result := true;
 end;

var
 VT : Tk2Dictionary;
begin
 VT := SI.GetVT;
 VT.IterateAllF(l3L2IA(@StyleFunc));
end;

function TevStyleProperty.GetValue: string;
begin
 with SI.SelectStyle(GetOrdValue).Attr[k2_tiName] do
  if IsValid then
   Result := AsString
  else
   Result := '';
end;

procedure TevStyleProperty.SetValue(const Value: string);
begin
 with SI.SelectStyle(Value).Attr[k2_tiHandle] do
  if IsValid then
   SetOrdValue(AsLong)
  else
   SetOrdValue(ev_saTxtNormalANSI);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evDsgn.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\evDsgn.pas initialization leave'); {$EndIf}
end.

