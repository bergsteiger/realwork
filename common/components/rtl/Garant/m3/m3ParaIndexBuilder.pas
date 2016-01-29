unit m3ParaIndexBuilder;
{* Построитель индекса для потока параграфов. }

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3ParaIndexBuilder - }
{ Начат: 20.11.2001 16:44 }
{ $Id: m3ParaIndexBuilder.pas,v 1.10 2014/02/13 10:31:39 lulin Exp $ }

// $Log: m3ParaIndexBuilder.pas,v $
// Revision 1.10  2014/02/13 10:31:39  lulin
// - рефакторим безликие списки.
//
// Revision 1.9  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.8  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.7  2008/12/12 19:35:24  lulin
// - <K>: 129762414.
//
// Revision 1.6  2008/02/05 12:49:28  lulin
// - упрощаем базовые объекты.
//
// Revision 1.5  2007/08/14 19:32:06  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.4  2007/02/09 14:40:03  voba
// - buf fix (Шура чото наменял)
//
// Revision 1.3  2006/11/25 14:36:25  lulin
// - cleanup.
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.21  2004/08/18 12:27:24  law
// - перевел процедуру m4BuildIndexNew на использование m3IterateDocuments.
//
// Revision 1.20  2003/05/12 09:20:25  law
// - rename proc: ev_plIsNil -> l3IsNil.
//
// Revision 1.19  2002/05/13 13:47:22  law
// - change: изменен список параметров у Tl3WordAction.
//
// Revision 1.18  2002/04/19 16:22:48  law
// - change: Tl3WordAction - теперь функция. Должна возвращать true для продолжения перебора слов.
//
// Revision 1.17  2002/04/19 12:55:16  law
// - new proc: l3ParseWords.
//
// Revision 1.16  2002/03/28 16:51:12  law
// - bug fix: несовпадение прямого и обратного индексов.
//
// Revision 1.15  2002/03/22 13:29:47  law
// no message
//
// Revision 1.14  2002/02/28 14:20:08  law
// no message
//
// Revision 1.13  2002/02/26 15:48:10  law
// - optimization: попытка оптимизации путем уменьшения фрагментации выделяемой памяти.
//
// Revision 1.12  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.11  2002/02/20 14:14:05  law
// - bug fix: неправильная функция сравнения адресов.
//
// Revision 1.10  2002/02/20 12:42:36  law
// - new units: первая реализация индексации документов.
//
// Revision 1.9  2002/02/11 16:24:11  law
// - rename proc: evIsWordDelim -> l3IsWordDelim.
//
// Revision 1.8  2001/12/26 18:26:21  law
// - bug fix: заточка под баг Delphi 5.
//
// Revision 1.7  2001/12/20 14:12:11  law
// - new behavior: сделано использование морфологического разбора при поиске и индексации.
//
// Revision 1.6  2001/12/19 15:37:56  law
// - new behavior: сделаны поисковые операции ИЛИ и И.
//
// Revision 1.5  2001/12/11 14:17:34  law
// - new method version: Tm3ParaIndexBuilder.AddPara.
//
// Revision 1.4  2001/12/11 14:05:02  law
// - bug fix: использовался f_CurrentPara, а не aParaNum.
//
// Revision 1.3  2001/12/11 13:59:57  law
// - new method: Tm3ParaIndexBuilder.AddPara.
//
// Revision 1.2  2001/11/20 17:37:29  law
// - new behavior: сделана "рыба" для проверки работы индексатора.
//
// Revision 1.1  2001/11/20 14:29:41  law
// - new unit: m3ParaIndexBuilder.
//

{$I m3Define.inc}

interface

uses
  Windows,
  ActiveX,

  Classes,

  l3Interfaces,
  l3InternalInterfaces,
  l3IID,
  l3Base,
  l3ProtoObject,
  l3Types,
  l3Memory,

  m3StorageInterfaces,
  m3IdxInt,
  m3IndexInterfaces,
  m3Index
  ;

type
  _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
  {$Include ..\L3\l3COMQueryInterface.imp.pas}
  Tm3ParaIndexBuilder = class(_l3COMQueryInterface_, Im3ParaIndexBuilder)
   {* Построитель индекса для потока параграфов. }
    private
    // property fields
     f_IndexUpdater   : Im3IndexUpdater;
     f_ExtraSize      : Long;
    private
    // event fields
      f_OnSortFinished : TNotifyEvent;
    protected
    // internal fields 
     f_CurrentAddress : Pm3WordAddress;
     f_ConvertBuff    : PAnsiChar;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  GetToolsClass: Rm3ParaIndexBuilderTools;
        virtual;
        {-}
      procedure DoSortFinished(aSender: TObject);
        {-}
      function  DoWord(const aStr : Tl3PCharLen;
                       IsLast     : Bool): Bool;
        {-}  
    public
    // public methods
      constructor Create(const anIndexStorage : Im3IndexedStorage;
                         const aProgress      : Il3Progress = nil;
                         anExtraSize          : Long = 0);
        reintroduce;
        {-}
      procedure AddPara(aPara : Tl3PrimString);
        overload;
        {* - добавить параграф в индекс. }
      procedure AddPara(aParaNum : Long;
                        aPara    : Tl3PrimString);
        overload;
        {* - добавить параграф в индекс. }
      procedure AddPara(aParaNum    : Long;
                        const aPara : Tl3WString);
        overload;
        {* - добавить параграф в индекс. }
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
    public
    // public properties
      property IndexUpdater: Im3IndexUpdater
        read f_IndexUpdater
        write f_IndexUpdater;
        {* - построитель индекса. }
    public
    // public events
      property OnSortFinished: TNotifyEvent
        read f_OnSortFinished
        write f_OnSortFinished;
        {-}
  end;//Tm3ParaIndexBuilder

implementation

uses
  SysUtils,

  l3String,
  l3StringEx,

  m3IdxCla
  ;

{$Include ..\L3\l3COMQueryInterface.imp.pas}
  
// start class Tm3ParaIndexBuilder

constructor Tm3ParaIndexBuilder.Create(const anIndexStorage : Im3IndexedStorage;
                                       const aProgress      : Il3Progress = nil;
                                       anExtraSize          : Long = 0);
  //reintroduce;
  {-}
var
 l_PackageStorageTools : Tm3ParaIndexBuilderTools;
begin
 inherited Create;
 f_ExtraSize := anExtraSize;
 l3System.GetLocalMem(f_CurrentAddress, SizeOf(Tm3WordAddress) + f_ExtraSize);
 l3FillChar(f_CurrentAddress^, SizeOf(Tm3WordAddress) + f_ExtraSize, 0);
 l_PackageStorageTools := GetToolsClass.Create(anIndexStorage);
 try
  IndexUpdater := Tm3IndexUpdater.MakeInterface(l_PackageStorageTools,
                                                l_PackageStorageTools,
                                                l_PackageStorageTools,
                                                l_PackageStorageTools,
                                                l_PackageStorageTools,
                                                SizeOf(Tm3WordAddress) + f_ExtraSize,
                                                DoSortFinished,
                                                aProgress);
 finally
  l3Free(l_PackageStorageTools);
 end;//try.finally
end;

procedure Tm3ParaIndexBuilder.Cleanup;
  //override;
  {-}
begin
 IndexUpdater := nil;
 l3System.FreeLocalMem(f_ConvertBuff);
 l3System.FreeLocalMem(f_CurrentAddress);
 inherited;
end;

function Tm3ParaIndexBuilder.GetToolsClass: Rm3ParaIndexBuilderTools;
  //virtual;
  {-}
begin
 Result := Tm3ParaIndexBuilderTools;
end;

procedure Tm3ParaIndexBuilder.DoSortFinished(aSender: TObject);
  {-}
begin
 if Assigned(f_OnSortFinished) then
  f_OnSortFinished(Self);
end;
  
function Tm3ParaIndexBuilder.DoWord(const aStr : Tl3PCharLen;
                                    IsLast     : Bool): Bool;
  {-}
var
 l_Str : Tl3Str;
begin
 Result := true;
 l_Str.Init(aStr,
            CP_Unicode,
            @f_ConvertBuff);
 CharUpperBuffW(PWideChar(l_Str.S), l_Str.SLen);
 with IndexUpdater do
  AddMainValue(GetNormalizater,
               l_Str.AsWideString,
               f_CurrentAddress,
               SizeOf(Tm3WordAddress) + f_ExtraSize);
 Inc(f_CurrentAddress^.rWord);
end;

procedure Tm3ParaIndexBuilder.AddPara(aParaNum    : Long;
                                      const aPara : Tl3WString);
  //overload;
  {* - добавить параграф в индекс. }
begin
 if not l3IsNil(aPara) then begin
  with f_CurrentAddress^ do begin
   rPara := aParaNum;
   rWord := 0;
  end;//with f_CurrentAddress
  l3ParseWords(aPara, DoWord);
 end;//not l3IsNil(aPara)
end;

procedure Tm3ParaIndexBuilder.AddPara(aParaNum : Long;
                                      aPara    : Tl3PrimString);
  {* - добавить параграф в индекс. }
begin
 if not aPara.Empty then
  AddPara(aParaNum, aPara.AsWStr);
end;

procedure Tm3ParaIndexBuilder.AddPara(aPara : Tl3PrimString);
  {* - добавить параграф в индекс. }
begin
 if not aPara.Empty then begin
  AddPara(f_CurrentAddress^.rPara, aPara);
  Inc(f_CurrentAddress^.rPara);
 end;//not aPara.Empty
end;

function Tm3ParaIndexBuilder.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(Il3ProgressSource) then
 begin
  if Supports(IndexUpdater, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

end.

