unit m3EvdDocumentIndexBuilder;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3EvdDocumentIndexBuilder - }
{ Начат: 20.02.2002 14:51 }
{ $Id: m3EvdDocumentIndexBuilder.pas,v 1.6 2009/03/19 16:28:30 lulin Exp $ }

// $Log: m3EvdDocumentIndexBuilder.pas,v $
// Revision 1.6  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.5  2008/12/12 19:35:24  lulin
// - <K>: 129762414.
//
// Revision 1.4  2008/02/29 08:24:14  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.3  2008/02/05 12:49:28  lulin
// - упрощаем базовые объекты.
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.4  2004/08/19 15:37:03  law
// - в нулевом приближении сделана индексация нового хранилища.
//
// Revision 1.3  2004/05/18 11:39:14  law
// - класс Tm3EvdDocumentIndexBuilder теперь поддерживает интерфейс Il3DocIDSource.
//
// Revision 1.2  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.1  2002/02/20 12:42:35  law
// - new units: первая реализация индексации документов.
//

{$I m3Define.inc}

interface

uses
  ActiveX,
  
  Classes,

  l3Types,
  l3IID,
  l3Interfaces,
  l3Base,

  k2PlTxRd,

  m3StorageInterfaces,
  m3DocumentIndexBuilder
  ;

type
  Tm3EvdDocumentIndexBuilder = class(Tk2CustomPlainTextReader, Il3DocIDSource)
    protected
    // internal fields
      f_DocumentIndexBuilder : Tm3DocumentIndexBuilder;
    private
    // event fields
      f_OnSortFinished : TNotifyEvent;
    protected
    // property methods
      function  pm_GetCurrentDocument: Long;
      procedure pm_SetCurrentDocument(aValue: Long);
        {-}
    // interface methods
      // Il3DocIDSource    
      function  Il3DocIDSource.pm_GetDocID = pm_GetCurrentDocument;
      procedure Il3DocIDSource.pm_SetDocID = pm_SetCurrentDocument;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoText(S: Tl3PrimString);
        override;
        {-}
      procedure DoSortFinished(aSender: TObject);
        {-}
    public
    // public methods
      constructor Create(const anIndexStorage : Im3IndexedStorage;
                         const aProgress      : Il3Progress = nil);
        reintroduce;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
    public
    // public properties
      property CurrentDocument: Long
        read pm_GetCurrentDocument
        write pm_SetCurrentDocument;
        {-}    
    public
    // public events
      property OnSortFinished: TNotifyEvent
        read f_OnSortFinished
        write f_OnSortFinished;
        {-}
  end;//Tm3EvdDocumentIndexBuilder

implementation

uses
  SysUtils
  ;

// start class Tm3EvdDocumentIndexBuilder

constructor Tm3EvdDocumentIndexBuilder.Create(const anIndexStorage : Im3IndexedStorage;
                                              const aProgress      : Il3Progress = nil);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_DocumentIndexBuilder := Tm3DocumentIndexBuilder.Create(anIndexStorage, aProgress);
 f_DocumentIndexBuilder.OnSortFinished := DoSortFinished;
end;

procedure Tm3EvdDocumentIndexBuilder.Cleanup;
  //override;
  {-}
begin
 l3Free(f_DocumentIndexBuilder);
 inherited;
end;

function Tm3EvdDocumentIndexBuilder.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 if IID.EQ(Il3ProgressSource) then
 begin
  if Supports(f_DocumentIndexBuilder, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function Tm3EvdDocumentIndexBuilder.pm_GetCurrentDocument: Long;
  {-}
begin
 Result := f_DocumentIndexBuilder.CurrentDocument;
end;

procedure Tm3EvdDocumentIndexBuilder.pm_SetCurrentDocument(aValue: Long);
  {-}
begin
 f_DocumentIndexBuilder.CurrentDocument := aValue;
end;

procedure Tm3EvdDocumentIndexBuilder.DoText(S: Tl3PrimString);
  //override;
  {-}
begin
 f_DocumentIndexBuilder.AddPara(S);
end;

procedure Tm3EvdDocumentIndexBuilder.DoSortFinished(aSender: TObject);
  {-}
begin
 if Assigned(f_OnSortFinished) then
  f_OnSortFinished(Self);
end;

end.

