unit nsInternalPictureData;

(*-----------------------------------------------------------------------------
 Название:   nsInternalPictureData
 Автор:      Лукьянец Р. В.
 Назначение: Реализация интерфайса InsLinkedObjectData для картинок встроенных в документ
 Версия:
   $Id: nsInternalPictureData.pas,v 1.4 2014/04/25 14:57:41 lulin Exp $
 История:
   $Log: nsInternalPictureData.pas,v $
   Revision 1.4  2014/04/25 14:57:41  lulin
   - переходим от интерфейсов к объектам.

   Revision 1.3  2014/01/15 12:57:30  kostitsin
   {requestlink: 451251129}

   Revision 1.2  2012/03/19 13:37:45  lulin
   {RequestLink:342860007}

   Revision 1.1  2012/03/19 12:41:39  lulin
   {RequestLink:342860007}

   Revision 1.5  2009/08/04 11:25:42  lulin
   [$159351827].

   Revision 1.4  2009/07/31 17:29:55  lulin
   - убираем мусор.

   Revision 1.3  2009/02/10 18:11:59  lulin
   - <K>: 133891247. Выделяем интерфейсы работы с документом.

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

 eeInterfaces,

 vcmBase,

 DocumentDomainInterfaces
 ;

type
 TnsInternalPictureData = class(TvcmBase, InsLinkedObjectData)
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
  f_ObjectTitle: Il3CString;
  f_Description: InsLinkedObjectDescription;
  f_Stream: IStream;
 protected
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(const aPara: IeePara;
                     const aPicture: IeePicture;
                     const aTitle: Il3CString);
   reintroduce;
    {-}
  class function Make(const aPara: IeePara;
                      const aPicture: IeePicture;
                      const aTitle: Il3CString): InsLinkedObjectData;
   reintroduce;
    {-}
 end;

implementation

uses
 Classes,

 l3Stream,
 l3Memory,
 l3String,

 k2Interfaces,
 k2Tags,

 StdRes,
 nsTypes,
 nsLinkedObjectDescription,
 nsExternalObject,
 nsExternalObjectPrim
 ;

{ TnsInternalPictureData }

procedure TnsInternalPictureData.Cleanup;
begin
 f_ObjectTitle := nil;
 f_Stream := nil;
 f_Description := nil;
 inherited Cleanup;
end;

constructor TnsInternalPictureData.Create(const aPara: IeePara;
  const aPicture: IeePicture; const aTitle: Il3CString);
var
 l_Stream  : Tl3MemoryStream;
begin
 inherited Create;
 with aPara.AsObject do
  f_Description := TnsLinkedObjectDescription.Make(nsCStr(StrA[k2_tiName]),
                                                   nsCStr(StrA[k2_tiShortName]),
                                                   IntA[k2_tiExternalHandle]);
 f_ObjectTitle := aTitle;
 l_Stream := Tl3MemoryStream.Make;
 try
  f_Stream := l3Stream2IStream(l_Stream);
  aPicture.SaveToStream(f_Stream);
  l_Stream.Seek(0, soBeginning);
 finally
  vcmFree(l_Stream);
 end;
end;

class function TnsInternalPictureData.Make(const aPara: IeePara;
  const aPicture: IeePicture;
  const aTitle: Il3CString): InsLinkedObjectData;
var
 l_Instance: TnsInternalPictureData;
begin
 l_Instance := Create(aPara, aPicture, aTitle);
 try
  Result := l_Instance;
 finally
  vcmFree(l_Instance);
 end;
end;

function TnsInternalPictureData.pm_GetData: IStream;
begin
 Result := f_Stream;
end;

function TnsInternalPictureData.pm_GetFileName: Il3CString;
begin
 Result := nsPrepareFileName(pm_GetWindowCaption);
end;

function TnsInternalPictureData.pm_GetObjectTitle: Il3CString;
begin
 Result := f_ObjectTitle;
end;

function TnsInternalPictureData.pm_GetWindowCaption: Il3CString;
begin
 if not l3IsNil(pm_GetObjectTitle) then
  Result := vcmFmt(str_pncNamedDocumentPicture, [pm_GetObjectTitle])
 else
  Result := vcmCStr(str_pncDocumentPicture);
end;

function TnsInternalPictureData.pm_GetDescription: InsLinkedObjectDescription;
begin
 Result := f_Description;
end;

function TnsInternalPictureData.Get_IsPicture: Boolean;
begin
 Result := True;
end;

end.
