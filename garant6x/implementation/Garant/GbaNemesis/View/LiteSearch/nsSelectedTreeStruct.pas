unit nsSelectedTreeStruct;

// $Id: nsSelectedTreeStruct.pas,v 1.1 2015/03/05 18:05:30 kostitsin Exp $

// $Log: nsSelectedTreeStruct.pas,v $
// Revision 1.1  2015/03/05 18:05:30  kostitsin
// {requestlink: 588808889 }
//
// Revision 1.15  2009/10/26 09:23:55  oman
// - fix: {RequestLink:121160631}
//
// Revision 1.14  2009/02/10 18:47:31  lulin
// - <K>: 133891247. Выделяем интерфейсы работы с адаптером и советами дня.
//
// Revision 1.13  2009/02/09 19:17:30  lulin
// - <K>: 133891247. Выделяем интерфейсы поиска.
//
// Revision 1.12  2008/12/29 16:41:04  lulin
// - <K>: 134316705.
//
// Revision 1.11  2008/12/25 12:20:19  lulin
// - <K>: 121153186.
//
// Revision 1.10  2008/10/24 14:56:39  lulin
// - чистка кода.
//
// Revision 1.9  2008/10/23 13:35:47  lulin
// - <K>: 121159788.
//
// Revision 1.8  2008/10/23 12:54:34  lulin
// - <K>: 121154612.
//
// Revision 1.7  2008/03/26 14:29:03  lulin
// - <K>: 88080898.
//
// Revision 1.6  2008/03/26 11:37:16  lulin
// - зачистка в рамках <K>: 88080898.
//
// Revision 1.5  2008/03/26 11:12:52  lulin
// - зачистка в рамках <K>: 88080898.
//
// Revision 1.4  2008/01/10 07:23:08  oman
// Переход на новый адаптер
//
// Revision 1.2.4.2  2007/12/21 09:45:43  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.2.4.1  2007/11/23 10:41:26  oman
// cleanup
//
// Revision 1.3  2007/12/21 07:12:12  mmorozov
// - new: подписка на уведомление об обновлении данных (CQ: OIT5-27823);
//
// Revision 1.2  2007/07/13 13:55:00  oman
// - fix: Убираем операцию "Свернуть все"/"Развернуть все" (cq25605)
//
// Revision 1.1  2007/03/29 13:18:58  oman
// Вычитываем таки параметры контекстного фильтра для атрибутов
//
//

{$include nsDefine.inc}

interface

// <no_string>

uses
 l3Interfaces,
 l3Tree,
 l3TreeInterfaces,

 afwInterfaces,

 vcmExternalInterfaces,

 nsTypes,
 nsNodes,
 bsInterfaces,

 SearchDomainInterfaces
 ;

type
  _nsTaggedTreeInfo_Parent_ = Tl3Tree;
  {$Include nsTaggedTreeInfo.imp.pas}
  _afwApplicationDataUpdate_Parent_ = _nsTaggedTreeInfo_;
  {$Include afwApplicationDataUpdate.imp.pas}
  TnsSelectedTreeStruct = class(_afwApplicationDataUpdate_)
  {-}
  protected
   procedure FinishDataUpdate;
     override;
     {* вызывает по окончании обновления }
  public
  // public methods
   class function Make(const aTag: Il3CString;
                       aShowRoot: boolean): Il3SimpleTree;
     reintroduce;
     overload;
     {-}
  end;//TnsSelectedTreeStruct

implementation

uses
 SysUtils,
 
 l3String,

 afwFacade,

 bsUtils,

 nsTreeAttributeNodesNew,
 DynamicTreeUnit
 ;

{$Include nsTaggedTreeInfo.imp.pas}

{$Include afwApplicationDataUpdate.imp.pas}

{ TnsSelectedTreeStruct }

procedure TnsSelectedTreeStruct.FinishDataUpdate;
begin
 inherited;
 Changing;
 try
  RootNode.ReleaseChilds;
 finally
  Changed;
 end;
end;

class function TnsSelectedTreeStruct.Make(const aTag: Il3CString;
  aShowRoot: boolean): Il3SimpleTree;
Var
 l_TaggedInfo: InsTaggedTreeInfo;
begin
 Result := inherited Make;
 if Supports(Result, InsTaggedTreeInfo, l_TaggedInfo) then
  l_TaggedInfo.Tag := aTag;

 Result.RootNode := TnsSelectedRoot.Make;
end;

end.
