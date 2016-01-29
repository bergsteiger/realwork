unit vcmOperationableIdentifiedUserFriendly;
{* Базовый класс для объектов имеющих отображение для пользователя и операции. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmOperationableIdentifiedUserFriendly - }
{ Начат: 26.02.2003 21:38 }
{ $Id: vcmOperationableIdentifiedUserFriendly.pas,v 1.18 2015/07/09 09:54:20 kostitsin Exp $ }

// $Log: vcmOperationableIdentifiedUserFriendly.pas,v $
// Revision 1.18  2015/07/09 09:54:20  kostitsin
// чтобы не мешалось.
//
// Revision 1.17  2015/07/09 09:49:02  kostitsin
// {requestlink: 127042272 } - грохнул ещё пачку _TvcmInterfaceList.
//
// Revision 1.16  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.15  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.14  2009/02/20 13:07:04  lulin
// - <K>: 136941122.
//
// Revision 1.13  2008/03/19 14:23:42  lulin
// - cleanup.
//
// Revision 1.12  2007/04/12 07:57:07  lulin
// - используем строки с кодировкой.
//
// Revision 1.11  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.10  2007/01/20 17:35:43  lulin
// - разрешаем вызывать операции только по заранее известным идентификаторам.
//
// Revision 1.9  2006/12/10 17:50:17  lulin
// - cleanup.
//
// Revision 1.8  2004/09/11 11:22:02  lulin
// - кешируем список описателей операций.
//
// Revision 1.7  2004/09/10 16:21:42  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.6  2004/09/10 14:04:00  lulin
// - оптимизация - кешируем EntityDef и передаем ссылку на EntityItem, а не на кучу параметров.
//
// Revision 1.5  2004/06/02 10:20:38  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.4  2004/02/02 15:08:58  law
// - cleanup.
//
// Revision 1.3  2004/02/02 13:19:13  am
// new: Появилась возможность задавать форме более одного тулбара.
//
// Revision 1.2.20.1  2004/01/20 15:25:01  am
// *** empty log message ***
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:42  law
// - переименовываем MVC в VCM.
//
// Revision 1.5  2003/03/27 14:36:52  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.4  2003/03/26 12:13:40  law
// - cleanup.
//
// Revision 1.3  2003/03/20 16:42:56  law
// - change: всем объектам кроме Name добавлено свойство Caption.
//
// Revision 1.2  2003/03/14 18:24:08  law
// - наконец-то родил пример под BCB.
//
// Revision 1.1  2003/02/27 10:23:23  law
// - new unit: vcmOperationableIdentifiedUserFriendly.
//
// Revision 1.4  2003/02/27 10:06:08  law
// - change: модулю и сущности добавлен идентификатор.
//
// Revision 1.3  2003/02/27 09:51:44  law
// - new behavior: сделано добавление операций сущности в меню.
//
// Revision 1.2  2003/02/27 09:37:57  law
// - new behavior: к описанию сущности добавлены операции.
//
// Revision 1.1  2003/02/27 07:57:37  law
// - new behavior: сделано получение сущностей модуля.
//

{$Include vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmInterfaces,

  vcmUserControls,
  vcmBase,
  vcmBaseOperationsCollection,
  vcmIdentifiedUserFriendly,
  vcmOperationDefList
  ;

type
  IvcmOperationsHolder = interface(IUnknown)
    ['{92EB9AA2-4A3D-464A-9918-28A8E3CC0468}']
    // public methods
      procedure ClearOps;
        {-}
  end;//IvcmOperationsHolder

  TvcmOperationalIdentifiedUserFriendly = class(TvcmIdentifiedUserFriendly, IvcmOperationalIdentifiedUserFriendlyControl, IvcmOperationsHolder)
   {* Базовый класс для объектов имеющих отображение для пользователя и операции. }
    private
    // internal fields
      f_OpList     : TvcmOperationDefList;
      f_Operations : TvcmBaseOperationsCollection;
      f_ToolbarPos : TvcmToolbarPos;
    protected
    // interface methods
      // IvcmEntityDef
      function Get_OperationsDefIterator: IvcmOperationsDefIterator;
        {-}
      function Get_ToolbarPos: TvcmToolbarPos;
        virtual;
        {-}
      // IvcmOperationsHolder
      procedure ClearOps;
        virtual;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const anID            : TvcmControlID;
                         const aName           : String;
                         const aCaption        : IvcmCString;
                         const aHint           : IvcmCString;
                         const aLongHint       : IvcmCString;
                         //const aDescription    : String;
                         const aToolbarPos     : TvcmToolbarPos;                         
                         anImageIndex          : Integer;
                         const anOperationsDef : TvcmBaseOperationsCollection);
        reintroduce;
        {-}
  end;//TvcmOperationalIdentifiedUserFriendly

implementation

uses
  vcmOperationsDefIterator
  ;

// start class TvcmOperationalIdentifiedUserFriendly

constructor TvcmOperationalIdentifiedUserFriendly.Create(const anID            : TvcmControlID;
                                                         const aName           : String;
                                                         const aCaption        : IvcmCString;
                                                         const aHint           : IvcmCString;
                                                         const aLongHint       : IvcmCString;
                                                         //const aDescription    : String;
                                                         const aToolbarPos     : TvcmToolbarPos;
                                                         anImageIndex          : Integer;
                                                         const anOperationsDef : TvcmBaseOperationsCollection);
  //reintroduce;
  {-}
begin
 inherited Create(anID, aName, aCaption, aHint, aLongHint, anImageIndex);
 f_Operations := anOperationsDef;
 f_ToolbarPos := aToolbarPos;
 f_OpList := nil;
end;

procedure TvcmOperationalIdentifiedUserFriendly.Cleanup;
  //override;
  {-}
begin
 vcmFree(f_OpList);
 f_Operations := nil;
 inherited;
end;

function TvcmOperationalIdentifiedUserFriendly.Get_OperationsDefIterator: IvcmOperationsDefIterator;
  {-}
var
 l_Iterator : TvcmOperationsDefIterator;
begin
 if (f_OpList <> nil) then
 begin
  if f_OpList.Empty then
   Result := nil
  else
  begin
   l_Iterator := TvcmOperationsDefIterator.Create(f_OpList);
   try
    Result := l_Iterator;
   finally
    vcmFree(l_Iterator);
   end;//try..finally
  end;//f_OpList.Empty
 end//f_OpList <> nil
 else
 if (f_Operations <> nil) then
 begin
  f_OpList := TvcmOperationDefList.Create;
  try
   f_Operations.GetOperations(f_OpList);
   if f_OpList.Empty then
    Result := nil
   else begin
    l_Iterator := TvcmOperationsDefIterator.Create(f_OpList);
    try
     Result := l_Iterator;
    finally
     vcmFree(l_Iterator);
    end;//try..finally
   end;//l_List.Empty
  except
   vcmFree(f_OpList);
   raise;
  end;//try..except
 end//f_Operations <> nil
 else
  Result := nil;
end;

function TvcmOperationalIdentifiedUserFriendly.Get_ToolbarPos: TvcmToolbarPos;
begin
 Result := f_ToolbarPos;
end;

procedure TvcmOperationalIdentifiedUserFriendly.ClearOps;
  {-}
begin
 if (f_Operations <> nil) AND (f_OpList = nil) then
 begin
  f_OpList := TvcmOperationDefList.Create;
  try
   f_Operations.GetOperations(f_OpList);
   if f_OpList.Empty then
    vcmFree(f_OpList);
  except
   vcmFree(f_OpList);
   raise;
  end;//try..except
 end;//f_Operations <> nil
 f_Operations := nil;
end;

end.

