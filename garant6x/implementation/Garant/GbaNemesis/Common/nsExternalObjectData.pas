unit nsExternalObjectData;

(*-----------------------------------------------------------------------------
 Название:   nsExternalObjectData
 Автор:      Лукьянец Р. В.
 Назначение: Реализация интерфайса InsLinkedObjectData для IExternalObject
 Версия:
   $Id: nsExternalObjectData.pas,v 1.10 2014/01/15 12:57:42 kostitsin Exp $
 История:
   $Log: nsExternalObjectData.pas,v $
   Revision 1.10  2014/01/15 12:57:42  kostitsin
   {requestlink: 451251129}

   Revision 1.9  2009/08/04 11:25:42  lulin
   [$159351827].

   Revision 1.8  2009/07/31 17:29:55  lulin
   - убираем мусор.

   Revision 1.7  2009/07/31 10:25:12  oman
   - new: {RequestLink:158795599}

   Revision 1.6  2009/07/31 09:43:23  oman
   - new: {RequestLink:158795599}

   Revision 1.5  2009/02/10 18:11:59  lulin
   - <K>: 133891247. Выделяем интерфейсы работы с документом.

   Revision 1.4  2008/12/12 19:19:09  lulin
   - <K>: 129762414.

   Revision 1.3  2008/01/10 07:23:30  oman
   Переход на новый адаптер

   Revision 1.2.4.1  2007/11/22 10:50:08  oman
   Перепиливаем на новый адаптер

   Revision 1.2  2007/09/28 07:03:07  mmorozov
   - небольшой рефакторинг _StdRes и _nsSaveDialog;
   - разделяем получение имени файла для диалогов сохранения и временных файлов + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-26809);

   Revision 1.1  2007/07/11 10:05:35  oman
   - new: Показ информации о графическом объекте - передаем всю
    нужную информацию (cq24711)

-----------------------------------------------------------------------------*)

interface

uses
 l3Interfaces,
 l3Types,
 l3IID,

 nevNavigation,

 vcmBase,

 DocumentDomainInterfaces,

 ExternalObjectUnit
 ;

type
 TnsExternalObjectData = class(TvcmBase, InsLinkedObjectData)
 protected
  // InsLinkedObjectData
  function pm_GetObjectTitle: Il3CString;
    {-}
  function pm_GetFileName: Il3CString;
    {-}
  function pm_GetWindowCaption: Il3CString;
    {-}
  function pm_GetData: IStream;
    {-}
  function pm_GetDescription: InsLinkedObjectDescription;
    {-}
  function Get_IsPicture: Boolean;
    {-}
 private
  f_Description: InsLinkedObjectDescription;
  f_Object: IExternalObject;
  f_Stream: IStream;
 protected
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aHyperLink: IevHyperLink;
                     const aObject: IExternalObject);
   reintroduce;
    {-}
  class function Make(const aHyperLink: IevHyperLink;
                      const aObject: IExternalObject): InsLinkedObjectData;
   reintroduce;
    {-}
  function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
    override;
    {-}
 end;

implementation

uses
 Classes,

 l3Stream,
 l3Memory,
 l3Base,

 k2Interfaces,
 k2Tags,

 StdRes,
 nsTypes,
 nsLinkedObjectDescription,
 nsExternalObject,
 nsExternalObjectPrim
 ;

{ TnsExternalObjectData }

procedure TnsExternalObjectData.Cleanup;
begin
 f_Stream := nil;
 f_Description := nil;
 f_Object := nil;
 inherited Cleanup;
end;

function TnsExternalObjectData.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
begin
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IExternalObject) then
  begin
   IExternalObject(Obj) := f_Object;
   Result.SetOK;
  end;//if IID.EQ(IExternalObject) then
end;

constructor TnsExternalObjectData.Create(const aHyperLink: IevHyperLink;
  const aObject: IExternalObject);
var
 l_Stream  : TnsExternalObjectStream;
begin
 inherited Create;
 f_Object := aObject;
 with aHyperLink do
  f_Description := TnsLinkedObjectDescription.Make(nsCStr(Hint),
                                                   nsCStr(Name),
                                                   TargetDocumentID);
 l_Stream := TnsExternalObjectStream.Create(f_Object);
 try
  f_Stream := l3Stream2IStream(l_Stream);
 finally
  vcmFree(l_Stream);
 end;
end;

function TnsExternalObjectData.Get_IsPicture: Boolean;
begin
 Result := f_Object.GetDataType = EOT_PIC;
end;

class function TnsExternalObjectData.Make(const aHyperLink: IevHyperLink;
  const aObject: IExternalObject): InsLinkedObjectData;
var
 l_Instance: TnsExternalObjectData;
begin
 l_Instance := Create(aHyperLink, aObject);
 try
  Result := l_Instance;
 finally
  vcmFree(l_Instance);
 end;
end;

function TnsExternalObjectData.pm_GetData: IStream;
begin
 Result := f_Stream;
end;

function TnsExternalObjectData.pm_GetDescription: InsLinkedObjectDescription;
begin
 Result := f_Description;
end;

function TnsExternalObjectData.pm_GetFileName: Il3CString;
begin
 Result := nsPrepareFileName(pm_GetObjectTitle);
end;

function TnsExternalObjectData.pm_GetObjectTitle: Il3CString;
begin
 Result := nsGetExternalObjectName(f_Object);
end;

function TnsExternalObjectData.pm_GetWindowCaption: Il3CString;
begin
 Result := vcmFmt(str_pncSimplePicture, [pm_GetObjectTitle])
end;

end.
