unit vcmBaseModuleDef;
{* Ѕазовый класс описани€ модул€. }

{ Ѕиблиотека "vcm"        }
{ јвтор: Ћюлин ј.¬. ©     }
{ ћодуль: vcm -           }
{ Ќачат: 24.02.2003 14:38 }
{ $Id: vcmBaseModuleDef.pas,v 1.21 2015/07/09 09:54:20 kostitsin Exp $ }

// $Log: vcmBaseModuleDef.pas,v $
// Revision 1.21  2015/07/09 09:54:20  kostitsin
// чтобы не мешалось.
//
// Revision 1.20  2015/07/09 09:49:02  kostitsin
// {requestlink: 127042272 } - грохнул ещЄ пачку _TvcmInterfaceList.
//
// Revision 1.19  2015/03/12 11:03:49  lulin
// - перетр€хиваем слова.
//
// Revision 1.18  2013/08/26 15:31:46  lulin
// - чистим код.
//
// Revision 1.17  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.16  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.15  2009/02/20 13:07:04  lulin
// - <K>: 136941122.
//
// Revision 1.14  2008/03/19 14:23:42  lulin
// - cleanup.
//
// Revision 1.13  2008/01/31 18:53:31  lulin
// - избавл€емс€ от излишней универсальности списков.
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
// Revision 1.9  2004/09/10 14:04:00  lulin
// - оптимизаци€ - кешируем EntityDef и передаем ссылку на EntityItem, а не на кучу параметров.
//
// Revision 1.8  2004/07/14 13:49:27  law
// - optimiztion: пореже создаем формы сущностей.
// - optimization: стараемс€ не создавать Handle форм только дл€ информации.
//
// Revision 1.7  2004/06/02 10:20:37  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.6  2004/02/10 12:59:47  law
// - change: IvcmUserTypesIterator теперь возвращает IvcmUserTypeDef.
//
// Revision 1.5  2004/02/02 13:19:13  am
// new: ѕо€вилась возможность задавать форме более одного тулбара.
//
// Revision 1.4.4.1  2004/01/20 15:25:01  am
// *** empty log message ***
//
// Revision 1.4  2003/12/30 10:03:52  law
// - optimization: при создании второго Main-окна не создаем по новой все формы сущностей (CQ OIT5-5628).
//
// Revision 1.3  2003/07/25 17:51:54  law
// - new behavior: начал получать список UserType'ов.
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.16  2003/03/27 14:36:52  law
// - new prop: операци€ теперь имеет картинку.
//
// Revision 1.15  2003/03/20 16:42:56  law
// - change: всем объектам кроме Name добавлено свойство Caption.
//
// Revision 1.14  2003/03/19 13:04:16  law
// - new method: _TvcmModule.Make.
//
// Revision 1.13  2003/03/14 18:24:07  law
// - наконец-то родил пример под _BCB.
//
// Revision 1.12  2003/03/12 16:07:00  law
// - change: _TvcmModule теперь наследуетс€ от _TDataModule.
//
// Revision 1.11  2003/02/27 10:23:23  law
// - new unit: vcmOperationableIdentifiedUserFriendly.
//
// Revision 1.10  2003/02/27 10:06:08  law
// - change: модулю и сущности добавлен идентификатор.
//
// Revision 1.9  2003/02/27 07:57:37  law
// - new behavior: сделано получение сущностей модул€.
//
// Revision 1.8  2003/02/26 18:21:37  law
// - rename unit: vcmModuleOperationsDefIterator -> vcmOperationsDefIterator.
//
// Revision 1.7  2003/02/25 17:59:45  law
// - new behavior: начал писать обв€зку дл€ выполнени€ операций модул€.
//
// Revision 1.6  2003/02/25 14:08:15  law
// - rename method: _TvcmModule._GetOperations -> _TvcmModule.GetOperationsDef.
//
// Revision 1.5  2003/02/25 11:08:05  law
// - change: добавлено определение операций модул€.
//
// Revision 1.4  2003/02/24 16:13:37  law
// - new prop: IvcmModuleDef.OperationsDefIterator.
//
// Revision 1.3  2003/02/24 15:58:09  law
// no message
//
// Revision 1.2  2003/02/24 13:43:00  law
// - new prop: IvcmModuleDef.Hint, IvcmModuleDef.LongHint.
//
// Revision 1.1  2003/02/24 12:01:13  law
// - new units: vcmBase, vcmBaseModuleDef, vcmModule.
//

{$Include vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBase,
  vcmBaseOperationsCollection,
  vcmOperationableIdentifiedUserFriendly,
  vcmModule,
  vcmUserTypeDefList,
  vcmEntitiesDefList
  ;

type
  TvcmBaseModuleDef = class(TvcmOperationalIdentifiedUserFriendly, IvcmModuleDef)
   {* Ѕазовый класс дл€ описани€ модул€ приложени€, построенного на основе библиотеки vcm. }
    private
    // internal fields
      f_ModuleClass  : RvcmModule;
      f_EntitiesList : TvcmEntitiesDefList;
      f_UserTypes    : TvcmUserTypeDefList;
    protected
    // interface methods
      // IvcmModuleDef
      function Get_EntitiesDefIterator: IvcmEntitiesDefIterator;
        {-}
      function Get_UserTypesIterator: IvcmUserTypesIterator;
        {-}
      function Make: IvcmModule;
        {* - создает модуль. }
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const anID            : TvcmControlID;
                         aModuleClass          : RvcmModule;
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
  end;//TvcmBaseModuleDef

implementation

uses
  SysUtils,
  Classes,

  vcmEntitiesDefIterator,
  vcmOperationsDefIterator,
  vcmUserTypesIterator
  ;

// start class TvcmBaseModuleDef

constructor TvcmBaseModuleDef.Create(const anID            : TvcmControlID;
                                     aModuleClass          : RvcmModule;
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
 inherited Create(anID, aName, aCaption, aHint, aLongHint, aToolbarPos, anImageIndex, anOperationsDef);
 f_ModuleClass := aModuleClass;
 f_EntitiesList := nil;
end;

procedure TvcmBaseModuleDef.Cleanup;
  //override;
  {-}
begin
 vcmFree(f_UserTypes);
 vcmFree(f_EntitiesList);
 inherited;
end;

function TvcmBaseModuleDef.Get_EntitiesDefIterator: IvcmEntitiesDefIterator;
  {-}
var
 l_Iterator : TvcmEntitiesDefIterator;
 l_List     : TvcmEntitiesDefList;
begin
 if (f_EntitiesList = nil) then
 begin
  f_UserTypes := TvcmUserTypeDefList.Create;
  l_List := TvcmEntitiesDefList.Create;
  try
   f_ModuleClass.GetEntitiesDef(l_List, f_UserTypes);
   vcmSet(f_EntitiesList, l_List);
  finally
   vcmFree(l_List);
  end;//try..finally
 end;//f_EntitiesList = nil
 if f_EntitiesList.Empty then
  Result := nil
 else begin
  l_Iterator := TvcmEntitiesDefIterator.Create(f_EntitiesList);
  try
   Result := l_Iterator;
  finally
   vcmFree(l_Iterator);
  end;//try..finally
 end;//l_List.Empty
end;

function TvcmBaseModuleDef.Get_UserTypesIterator: IvcmUserTypesIterator;
  {-}
begin
 if (f_UserTypes = nil) then
  Get_EntitiesDefIterator;
 if (f_UserTypes = nil) then
  Result := nil
 else 
  Result := TvcmUserTypesIterator.Make(f_UserTypes);
end;

function TvcmBaseModuleDef.Make: IvcmModule;
  {* - создает модуль. }
begin
 Result := f_ModuleClass.Make;
end;

end.

