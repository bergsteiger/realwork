unit dd_lcBaseFilter;
// Базовые фильтры

{ $Id: dd_lcBaseFilter.pas,v 1.11 2013/04/05 12:04:30 lulin Exp $ }
// $Log: dd_lcBaseFilter.pas,v $
// Revision 1.11  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.10  2011/12/07 07:12:41  narry
// Нестандартный вид номера в таблице дата-номер (309168209)
//
// Revision 1.9  2011/11/10 11:03:15  narry
// Для тестов выключен вывод в лог
//
// Revision 1.8  2011/10/21 13:11:59  narry
// Накопившиеся изменения
//
// Revision 1.7  2011/09/19 13:00:17  narry
// При заливке испортилась таблица (285509624)
//
// Revision 1.6  2011/09/13 12:03:05  narry
// Расшифровка типа "Решения и Постановления"  (281526721)
//
// Revision 1.5  2011/09/07 11:41:03  narry
// Логирование изменений CVS
//

interface

uses
 k2TagFilter,
 ddTypes, k2TagGen, l3PrimString, l3ValLst, ddHeaderFilter, evdLeafParaFilter;

type
 Tdd_lcBaseFilter = class(Tk2TagFilter)
 private
  f_Category: Integer;
  f_OnError: TddErrorEvent;
 public
  procedure ErrorReaction(const aMsg: AnsiString); overload;
  procedure ErrorReaction(const aMsg: AnsiString; const Args: array of const); overload;
  procedure SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer; aOnError:
      TddErrorEvent): Pointer; overload;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

type
 Tdd_lcSynoFilter = class(Tdd_lcBaseFilter)
 private
  f_SynoList: Tl3ValueList;
  procedure pm_SetSynoList(const Value: Tl3ValueList);
 protected
  procedure Cleanup; override;
 public
  function CheckValue(const aText: AnsiString; out CorrectText: AnsiString): Boolean;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer; aOnError:
      TddErrorEvent; aSynoList: Tl3ValueList): Pointer; overload;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer; aOnError:
      TddErrorEvent; const aSynoFilename: AnsiString; const aDelimeter: AnsiString = '='): Pointer; overload;
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; const aSynoFilename:
      AnsiString; const aDelimeter: AnsiString = '='): Pointer; overload;
  property SynoList: Tl3ValueList read f_SynoList write pm_SetSynoList;
 end;

type
 Tdd_lcBaseHeaderFilter = class(TddHeaderFilter)
 private
  f_Category: Integer;
  f_OnError: TddErrorEvent;
 public
  procedure ErrorReaction(const aMsg: AnsiString); overload;
  procedure ErrorReaction(const aMsg: AnsiString; const Args: array of const); overload;
  procedure SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer; aOnError:
      TddErrorEvent): Pointer; overload;
 end;

 Tdd_lcParaFilter = class(TevdLeafParaFilter)
 private
  f_Category: Integer;
  f_OnError: TddErrorEvent;
 public
  procedure ErrorReaction(const aMsg: AnsiString); overload;
  procedure ErrorReaction(const aMsg: AnsiString; const Args: array of const);
      overload;
  procedure SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
        {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
      aOnError: TddErrorEvent): Pointer; overload;
  property Category: Integer read f_Category write f_Category;
 end;

implementation

uses
 l3Base, ddValueList, SysUtils, l3LingLib;

procedure Tdd_lcBaseFilter.ErrorReaction(const aMsg: AnsiString);
begin
 {$IFNDEF nsTest}
 if Assigned(f_OnError) then
  f_OnError(aMsg, f_Category)
 else
  l3System.Msg2Log(aMsg);
 {$ENDIF} 
end;

procedure Tdd_lcBaseFilter.ErrorReaction(const aMsg: AnsiString; const Args: array of const);
begin
 ErrorReaction(Format(aMsg, Args));
end;

procedure Tdd_lcBaseFilter.SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
begin
 f_Onerror:= aHandler;
 f_Category:= aCategory;
end;

class function Tdd_lcBaseFilter.SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
    aOnError: TddErrorEvent): Pointer;
var
 l_Filter : Tdd_lcBaseFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

function Tdd_lcSynoFilter.CheckValue(const aText: AnsiString; out CorrectText: AnsiString): Boolean;
begin
 CorrectText:= '';
 if f_SynoList <> nil then
  CorrectText:= AnsiLowerCase(f_SynoList.Values[AnsiUpperCase(aText)]);
 Result:= CorrectText <> '';
 if Result then
  ApplayCapsScheme(PAnsiChar(CorrectText), Length(CorrectText), GetCapsScheme(PAnsiChar(aText), Length(aText)));
end;

procedure Tdd_lcSynoFilter.Cleanup;
begin
 inherited;
 FreeAndNil(f_SynoList);
end;

procedure Tdd_lcSynoFilter.pm_SetSynoList(const Value: Tl3ValueList);
begin
 f_SynoList := Value.Use;
end;

class function Tdd_lcSynoFilter.SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
    aOnError: TddErrorEvent; aSynoList: Tl3ValueList): Pointer;
var
 l_Filter : Tdd_lcSynoFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l_Filter.SynoList:= aSynoList;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

class function Tdd_lcSynoFilter.SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
    aOnError: TddErrorEvent; const aSynoFilename: AnsiString; const aDelimeter: AnsiString = '='): Pointer;
var
 l_List: Tl3ValueList;
begin
 l_List:= TddValueList.MakeSorted;
 try
  TddValueList(l_List).LoadFromFile(aSynoFilename, aDelimeter);
  Result:= SetTo(theGenerator, aCategory, aOnError, l_List);
 finally
  FreeAndNil(l_List);
 end;
end;

class function Tdd_lcSynoFilter.SetTo(var theGenerator: Tk2TagGenerator; const
    aSynoFilename: AnsiString; const aDelimeter: AnsiString = '='): Pointer;
var
 l_List: Tl3ValueList;
 l_Filter : Tdd_lcSynoFilter;
begin
 l_List:= TddValueList.MakeSorted;
 try
  TddValueList(l_List).LoadFromFile(aSynoFilename, aDelimeter);
  l_Filter := Create;
  try
   l_Filter.Generator := theGenerator;
   l_Filter.SynoList:= l_List;
   l3Set(theGenerator, l_Filter);
  finally
   l3Free(l_Filter);
  end;//try..finally
  Result := theGenerator;
 finally
  FreeAndNil(l_List);
 end;
end;

procedure Tdd_lcBaseHeaderFilter.ErrorReaction(const aMsg: AnsiString);
begin
 {$IFNDEF nsTest}
 if Assigned(f_OnError) then
  f_OnError(aMsg, f_Category)
 else
  l3System.Msg2Log(aMsg);
 {$ENDIF} 
end;

procedure Tdd_lcBaseHeaderFilter.ErrorReaction(const aMsg: AnsiString; const Args: array of const);
begin
 ErrorReaction(Format(aMsg, Args));
end;

procedure Tdd_lcBaseHeaderFilter.SetOnError(aCategory: Integer; aHandler: TddErrorEvent);
begin
 f_Onerror:= aHandler;
 f_Category:= aCategory;
end;

class function Tdd_lcBaseHeaderFilter.SetTo(var theGenerator: Tk2TagGenerator; aCategory: Integer;
    aOnError: TddErrorEvent): Pointer;
var
 l_Filter : Tdd_lcBaseHeaderFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure Tdd_lcParaFilter.ErrorReaction(const aMsg: AnsiString);
begin
 {$IFNDEF nsTest}
 if Assigned(f_OnError) then
  f_OnError(aMsg, f_Category)
 else
  l3System.Msg2Log(aMsg);
 {$ENDIF}
end;

procedure Tdd_lcParaFilter.ErrorReaction(const aMsg: AnsiString; const Args: array
    of const);
begin
 ErrorReaction(Format(aMsg, Args));
end;

procedure Tdd_lcParaFilter.SetOnError(aCategory: Integer; aHandler:
    TddErrorEvent);
begin
 f_Onerror:= aHandler;
 f_Category:= aCategory;
end;

class function Tdd_lcParaFilter.SetTo(var theGenerator: Tk2TagGenerator;
    aCategory: Integer; aOnError: TddErrorEvent): Pointer;
var
 l_Filter : Tdd_lcParaFilter;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.SetOnError(aCategory, aOnError);
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

end.
