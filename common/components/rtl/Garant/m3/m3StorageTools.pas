unit m3StorageTools;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3StorageTools - }
{ Начат: 22.02.2002 12:59 }
{ $Id: m3StorageTools.pas,v 1.18 2014/10/31 17:42:58 lulin Exp $ }

// $Log: m3StorageTools.pas,v $
// Revision 1.18  2014/10/31 17:42:58  lulin
// - перетряхиваем код.
//
// Revision 1.17  2014/10/31 14:14:30  lulin
// - перетряхиваем код.
//
// Revision 1.16  2014/10/30 16:37:12  lulin
// - перетряхиваем код.
//
// Revision 1.15  2014/10/30 16:19:38  lulin
// - перетряхиваем код.
//
// Revision 1.14  2014/10/30 15:59:02  lulin
// - перетряхиваем код.
//
// Revision 1.13  2014/10/30 13:43:54  lulin
// - перетряхиваем код.
//
// Revision 1.12  2014/09/19 10:15:38  fireton
// - избавляемся от m3IsStorageExists и m3DeleteStorage
//
// Revision 1.11  2014/09/18 15:00:49  lulin
// - переносим функцию распаковки в более правильное место.
//
// Revision 1.10  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.9  2012/12/17 09:32:45  fireton
// - bugfix: не работало определение наличия на диске кэша структур
//
// Revision 1.8  2012/11/29 04:48:59  fireton
// - bugfix: не работало определение наличия на диске кэша структур
//
// Revision 1.7  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.6  2008/05/08 14:04:19  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.5  2007/12/21 10:02:19  lulin
// - модуль m3StorageInterfaces полностью перенесен на модель.
//
// Revision 1.4  2007/08/21 12:09:02  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.3  2005/01/24 11:43:26  lulin
// - new behavior: при освобождении заглушки очищаем указатель на нее.
//
// Revision 1.2  2004/09/09 14:53:53  lulin
// - small fix.
// - сделан вывод в лог информации и залочках в новом хранилище.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.11  2004/08/30 09:48:40  voba
// - не учитывали, что Storage м.б. равен nil.
//
// Revision 1.10  2004/06/10 14:22:32  law
// - bug fix: неправильно обрабатывался режим m3_saCreate.
//
// Revision 1.9  2004/05/13 16:10:57  voba
// - bug fix: не проверялось, что хранилище не открыто.
//
// Revision 1.8  2002/10/16 14:13:31  narry
// - change: добавлена возможность открытия/создания потока без сжатия.
//
// Revision 1.7  2002/09/13 13:59:22  law
// - new methods: m3L2ISA, m3FreeISA, m3L2IS2A, m3FreeIS2A.
//
// Revision 1.6  2002/09/12 14:50:42  law
// - new proc: m3COMOpenStream, m3COMSafeOpenStream.
//
// Revision 1.5  2002/04/17 11:55:03  law
// - new proc: _m3ReadWideString.
//
// Revision 1.4  2002/04/16 15:03:52  law
// - new behavior: m3COM(Safe)OpenStorage (Stream) - теперь, когда элемент не найден, не возвращают ошибку (исключение), а возвращают элемент = nil.
//
// Revision 1.3  2002/04/05 12:53:07  law
// - change: расширен интерфейс Im3IndexedStorage.
//
// Revision 1.2  2002/02/26 15:48:10  law
// - optimization: попытка оптимизации путем уменьшения фрагментации выделяемой памяти.
//
// Revision 1.1  2002/02/22 10:30:53  law
// - optimization: используем интерфейс Im3IndexedStorage.
//

{$I m3Define.inc}

interface

uses
  Windows,
  ActiveX,
  
  l3Types,
  l3Base,
  l3Interfaces,
  
  m3StorageInterfaces
  ;

function m3COMSafeOpenStorage(const AStorage : Im3IndexedStorage;
                              anIndex        : Long;
                              aStatStgMode   : Long;
                              aTryCreate     : Bool;
                              out theStorage : Im3IndexedStorage): hResult;
  overload;
  {-}
function m3COMOpenStorage(const AStorage : Im3IndexedStorage;
                          anIndex        : Long;
                          aStatStgMode   : Long;
                          aTryCreate     : Bool): Im3IndexedStorage;
  overload;
  {-}
function m3COMSafeOpenStorage(const AStorage : Im3IndexedStorage;
                              const aName    : Tl3WString;
                              aStatStgMode   : Long;
                              aTryCreate     : Bool;
                              out theStorage : Im3IndexedStorage): hResult;
  overload;
  {-}
function m3COMOpenStorage(const AStorage : Im3IndexedStorage;
                          const aName    : Tl3WString;
                          aStatStgMode   : Long;
                          aTryCreate     : Bool): Im3IndexedStorage;
  overload;
  {-}
function m3COMSafeOpenStream(const AStorage : Im3IndexedStorage;
                             const aName    : Tl3WString;
                             aStatStgMode   : Long;
                             aTryCreate     : Bool;
                             out theStream  : IStream;
                             aUseCompression : Bool = true): hResult;
  overload;
  {-}
function m3COMSafeOpenStream(const AStorage : Im3IndexedStorage;
                             anIndex        : Long;
                             aStatStgMode   : Long;
                             aTryCreate     : Bool;
                             out theStream  : IStream;
                             aUseCompression : Bool = true): hResult;
  overload;
  {-}
function m3COMOpenStream(const AStorage : Im3IndexedStorage;
                         const aName    : Tl3WString;
                         aStatStgMode   : Long;
                         aTryCreate     : Bool;
                         aUseCompression : Bool = true): IStream;
  overload;
  {-}
function m3COMOpenStream(const AStorage : Im3IndexedStorage;
                         anIndex        : Long;
                         aStatStgMode   : Long;
                         aTryCreate     : Bool;
                         aUseCompression : Bool = true): IStream;
  overload;
  {-}

function  m3ReadWideString(const aStream: IStream; out theString: WideString): hResult;
  {-}

procedure m3ExtractStorage(const aStorage: Im3IndexedStorage; const aDir: AnsiString);

implementation

uses
  SysUtils,
  ComObj,

  l3Chars,
  l3String,
  l3Stream,
  l3FileUtils,
  
  m3Const,

  m3SplittedFileStream
  ;

function m3COMSafeOpenStorage(const AStorage : Im3IndexedStorage;
                              anIndex        : Long;
                              aStatStgMode   : Long;
                              aTryCreate     : Bool;
                              out theStorage : Im3IndexedStorage): hResult;
var
 l_S : Tm3Store;                              
begin
 if (aStorage = nil) then
 begin
  theStorage := nil;
  Result := S_False;
 end//aStorage = nil
 else
 begin
  Result := aStorage.OpenStore(anIndex, aStatStgMode, m3_stStorage, l_S, true);
  if l3IFail(Result) AND
     ((Result = STG_E_FILENOTFOUND) OR (Result = STG_E_INVALIDFLAG)) then
  begin
   if aTryCreate then
   begin
    Result := aStorage.CreateStore(anIndex, aStatStgMode, m3_stStorage, l_S, true);
    theStorage := l_S.rStorage;
   end
   else
   begin
    Result := S_Ok;
    theStorage := nil;
   end;
  end
  else
   theStorage := l_S.rStorage;
 end;//aStorage = nil
end;

function m3COMOpenStorage(const AStorage : Im3IndexedStorage;
                          anIndex        : Long;
                          aStatStgMode   : Long;
                          aTryCreate     : Bool): Im3IndexedStorage;
begin
 OleCheck(m3COMSafeOpenStorage(aStorage, anIndex, aStatStgMode, aTryCreate, Result));
end;

function m3COMSafeOpenStorage(const AStorage : Im3IndexedStorage;
                              const aName    : Tl3WString;
                              aStatStgMode   : Long;
                              aTryCreate     : Bool;
                              out theStorage : Im3IndexedStorage): hResult;
  //overload;
  {-}
var
 l_S : Tm3Store;
begin
 Result := aStorage.OpenStore(aName, aStatStgMode, m3_stStorage, l_S, true);
 theStorage := l_S.rStorage;
 if l3IFail(Result) AND
    (aTryCreate and ((Result = STG_E_FILENOTFOUND) OR (Result = STG_E_INVALIDFLAG))) then
 begin
   Result := aStorage.CreateStore(aName, aStatStgMode, m3_stStorage, l_S, true);
   theStorage := l_S.rStorage;
 end;//l3IFail(Result)
end;

function m3COMOpenStorage(const AStorage : Im3IndexedStorage;
                          const aName    : Tl3WString;
                          aStatStgMode   : Long;
                          aTryCreate     : Bool): Im3IndexedStorage;
  //overload;
  {-}
begin
 OleCheck(m3COMSafeOpenStorage(aStorage, aName, aStatStgMode, aTryCreate, Result));
end;

function m3COMSafeOpenStream(const AStorage : Im3IndexedStorage;
                             const aName    : Tl3WString;
                             aStatStgMode   : Long;
                             aTryCreate     : Bool;
                             out theStream  : IStream;
                             aUseCompression : Bool = true): hResult;
  //overload;
  {-}
var
 l_S : Tm3Store;
begin
 if (aStorage = nil) then
  Result := S_Ok
 else
 begin
  Result := aStorage.OpenStore(aName, aStatStgMode, m3_stStream, l_S, aUseCompression);
  theStream := l_S.rStream;
  if l3IFail(Result) AND ((Result = STG_E_FILENOTFOUND) OR (Result = STG_E_INVALIDFLAG)) then
  begin
    if aTryCreate then
    begin
     Result := aStorage.CreateStore(aName, aStatStgMode, m3_stStream, l_S, aUseCompression);
     theStream := l_S.rStream;
    end//aTryCreate
    else
    begin
     Result := S_Ok;
     theStream := nil;
    end;//aTryCreate
  end;//l3IFail(Result)
 end;//aStorage <> nil
end;

function m3COMOpenStream(const AStorage : Im3IndexedStorage;
                         const aName    : Tl3WString;
                         aStatStgMode   : Long;
                         aTryCreate     : Bool;
                         aUseCompression : Bool = true): IStream;
  //overload;
  {-}
begin
 OleCheck(m3COMSafeOpenStream(aStorage, aName, aStatStgMode, aTryCreate, Result, aUseCompression));
end;

function m3COMSafeOpenStream(const AStorage : Im3IndexedStorage;
                             anIndex        : Long;
                             aStatStgMode   : Long;
                             aTryCreate     : Bool;
                             out theStream  : IStream;
                             aUseCompression : Bool = true): hResult;
  //overload;
  {-}
var
 l_S : Tm3Store;  
begin
 if (aStorage = nil) then
  Result := S_Ok
 else
 begin
  Result := aStorage.OpenStore(anIndex, aStatStgMode, m3_stStream, l_S, aUseCompression);
  theStream := l_S.rStream;
  if l3IFail(Result) AND ((Result = STG_E_FILENOTFOUND) OR (Result = STG_E_INVALIDFLAG)) then begin
    if aTryCreate then
    begin
     Result := aStorage.CreateStore(anIndex, aStatStgMode, m3_stStream, l_S, aUseCompression);
     theStream := l_S.rStream;
    end//aTryCreate
    else
    begin
     Result := S_Ok;
     theStream := nil;
    end;//aTryCreate
  end;
 end;//aStorage = nil
end;

function m3COMOpenStream(const AStorage : Im3IndexedStorage;
                         anIndex        : Long;
                         aStatStgMode   : Long;
                         aTryCreate     : Bool;
                         aUseCompression : Bool = true): IStream;
  //overload;
  {-}
begin
 OleCheck(m3COMSafeOpenStream(aStorage, anIndex, aStatStgMode, aTryCreate, Result, aUseCompression));
end;

function  m3ReadWideString(const aStream: IStream; out theString: WideString): hResult;
  {-}
var
 l_Char : WideChar;
 l_Read : Int64;
begin
 theString := '';
 Result := S_False;
 while true do
 begin
  Result := aStream.Read(@l_Char, SizeOf(l_Char), @l_Read);
  if (Result = S_False) then
   Exit;
  OleCheck(Result);
  if (l_Char = cc_Null) then
   break;
  theString := theString + l_Char; 
 end;//while true  
end;

procedure m3ExtractStorage(const aStorage: Im3IndexedStorage; const aDir: AnsiString);

 function DoElement(const aStoreInfo : Tm3StorageElementInfo): Boolean;

  function MangleName: AnsiString;
  begin//MangleName
   Result := l3Str(aStoreInfo.rName);
   if (Result[1] = m3IndexPrefix) then
    System.Delete(Result, 1, 1);
  end;//MangleName

 var
  l_Stream : IStream;
  l_Storage : Im3IndexedStorage;
  l_OutStream : Tl3FileStream;
  l_Read      : Int64;
  l_Written   : Int64;
 begin//DoElement
  Result := true;
  case aStoreInfo.rInfo.rStoreType of
   m3_stStorage:
   begin
    try
     l_Storage := aStorage.OpenStore(aStoreInfo, m3_saRead, true).rStorage;
    except
     on E: Exception do
     begin
      l3System.Exception2Log(E);
      Exit;
     end;//on E: Exception
    end;//try..except
    if (l_Storage <> nil) then
    begin
     m3ExtractStorage(l_Storage, ConcatDirName(aDir, MangleName));
    end;//l_Storage <> nil
   end;//m3_stStorage
   m3_stStream:
   begin
    try
     l_Stream := aStorage.OpenStore(aStoreInfo, m3_saRead, true).rStream;
    except
     on E: Exception do
     begin
      l3System.Exception2Log(E);
      Exit;
     end;//on E: Exception
    end;//try..except
    if (l_Stream <> nil) then
    begin
     l_OutStream := Tl3FileStream.Create(ConcatDirName(aDir, MangleName), l3_fmWrite);
     try
      l_Stream.CopyTo(l_OutStream, High(Int64), l_Read, l_Written);
     finally
      FreeAndNil(l_OutStream);
     end;//try..finally
    end;//l_Stream <> nil
   end;//m3_stStream
   else
   begin
    l3System.Msg2Log('Странный тип элемента ' + l3Str(aStoreInfo.rName));
   end;//else
  end;//case HandleType
 end;//DoElement

begin
 if (aStorage = nil) then
  Exit;
 ForceDirectories(aDir);
 aStorage.IterateAllF(L2Mm3StorageIteratorsIterateAllFAction(@DoElement));
end;

end.

