unit DT_DSour;

{ $Id: DT_DSOUR.PAS,v 1.10 2016/06/16 05:40:06 lukyanets Exp $ }

// $Log: DT_DSOUR.PAS,v $
// Revision 1.10  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.9  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.8  2007/02/22 14:33:53  narry
// - переход к 64 битам
//
// Revision 1.7  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.6  2003/05/29 15:21:04  voba
// - bug fix
//
// Revision 1.5  2003/05/19 15:39:52  demon
// - new behavior: Теперь можно мапировать атрибут не только на аналогичный словарь другого семейства,
// но и на другой словарь (как другого, так и своего семейства)
//
// Revision 1.4  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

interface
uses daTypes, Dt_ATbl,Dt_Types,Dt_Const;
const
 dsFamID   = 1;
 dsDictID  = 2;
 dsSFamID  = 3;
 dsSDictID = 4;
 dsFamKey  = 5;
type
 TDictSourceTbl = Class(TPrometTbl)
  constructor Create; {$IfDef Win32}reintroduce;{$endIf Win32}

  procedure   GetSourDict(aFamily : TdaFamilyID;aDict : TdaDictionaryType;
                          var newFamily : TdaFamilyID;var newDict : TdaDictionaryType);
 end;
implementation
uses HT_Const,HT_Dll,Dt_Err;

(************************** TDictSourceTbl *******************************)

constructor TDictSourceTbl.Create;
begin
 inherited Create(MainTblsFamily, TblPassW[MainPassIndex[mtDictSrc]], MainTblNames[mtDictSrc],True);
end;

procedure TDictSourceTbl.GetSourDict(aFamily : TdaFamilyID;aDict : TdaDictionaryType;
                                     var newFamily : TdaFamilyID;var newDict : TdaDictionaryType);
var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
 CurDict : Word;
begin
 RefreshSrchList;
 newFamily:=aFamily;
 newDict:=aDict;
 ClearFullRec;
 PutToFullRec(dsFamID,aFamily);
 curDict:=Word(aDict);
 PutToFullRec(dsDictID,curDict);
 AbsNum:=Ht(htRecordByUniq(@fSrchList,TblH,dsFamKey,fFullRecord,@RecH));
 if AbsNum > 0 then
 begin
  GetFullRec(AbsNum,False);
  GetFromFullRec(dsSFamId,newFamily);
  GetFromFullRec(dsSDictID,curDict);
  newDict:=TdaDictionaryType(CurDict);
 end;
end;
end.
