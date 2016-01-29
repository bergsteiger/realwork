unit ddDocTypeDetector;

{ $Id: ddDocTypeDetector.pas,v 1.48 2015/10/13 12:55:55 fireton Exp $ }

// $Log: ddDocTypeDetector.pas,v $
// Revision 1.48  2015/10/13 12:55:55  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.47.4.1  2015/10/08 13:08:13  fireton
// - переделка ExportPipe на новый filer dispatcher
//
// Revision 1.47  2015/01/29 11:30:03  fireton
// - нельзя было использовать без объекта
//
// Revision 1.46  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.45  2014/04/07 06:53:33  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.44  2014/03/28 06:13:17  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.43  2013/10/23 12:26:07  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.42  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.41  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.40  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.39  2013/10/18 15:39:01  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.38  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.37  2012/10/02 08:05:21  narry
// Обновление
//
// Revision 1.36  2011/12/06 07:04:05  narry
// Пересборка для поддержки MDP
//
// Revision 1.35  2010/07/26 14:42:55  narry
// К228690182. Для аннотаций не выставляется DocType
//
// Revision 1.34  2010/07/26 14:27:25  narry
// К228690171
//
// Revision 1.33  2010/07/09 11:51:19  narry
// - К172985568
//
// Revision 1.32  2010/03/10 13:57:24  narry
// - не собиралось
//
// Revision 1.31  2010/01/26 13:06:34  narry
// - не определялась группа доступа
//
// Revision 1.30  2009/03/04 16:25:56  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.29  2008/09/23 12:17:48  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.28  2008/05/08 14:04:08  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.27  2008/03/04 11:45:06  narry
// - обновление
//
// Revision 1.26  2007/08/09 18:05:21  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.25  2007/08/09 17:17:05  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.24  2007/08/09 11:19:17  lulin
// - cleanup.
//
// Revision 1.23  2007/04/25 09:30:55  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.22  2006/04/12 09:41:49  narry
// - изменение: переименование свойства SaveFirstAtom в RewriteAtoms
//
// Revision 1.21  2005/11/02 16:36:27  narry
// - исправление: неверное имя Группы доступа
//
// Revision 1.20  2005/10/18 09:06:45  lulin
// - исправлено, то что не компилировалось в связи с переездом модулей.
//
// Revision 1.19  2005/07/14 15:47:41  narry
// - update
//
// Revision 1.18  2005/04/28 12:58:28  narry
// - update
//
// Revision 1.17  2005/04/18 12:49:15  narry
// - bug fix: не закрывалась последняя скобка для документов без структуры
//
// Revision 1.16  2005/03/28 11:32:17  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.15  2005/03/24 18:39:24  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.14  2005/03/21 17:02:26  lulin
// - используем правильный тип описателя свойства.
//
// Revision 1.13  2005/03/21 10:04:55  lulin
// - new interface: _Ik2Type.
//
// Revision 1.12  2005/03/18 16:11:27  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.11  2005/02/24 15:24:49  narry
// - update
//
// Revision 1.10  2005/02/18 12:00:57  narry
// - update: поддержка Аннотаций
//
// Revision 1.9  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.8  2004/06/29 14:26:45  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.7  2004/05/14 16:58:35  law
// - new units: k2TagTerminator, k2TagFilter.
//

interface

uses
  l3Types,
  l3Variant,

  k2Types,
  k2TagGen,
  k2TagTerminator,
  k2Interfaces,
  k2DocumentBuffer,

  ddHeaderFilter,

  dt_Types                                      
  , evdBufferedFilter,
  ddPipeOutInterfaces;

type
  TNewDocumentEvent = procedure (aSender: TObject;
                                 aTopicNo: Longint;
                                 aPart: TddExportDocPart;
                                 aMainGroup: ShortString) of object;
  TNewDocumentProc  = procedure (aSender: TObject;
                                 aTopicNo: Longint;
                                 aPart: TddExportDocPart;
                                 aMainGroup: ShortString);
 TddExportDocTypes = set of TDocType;
 TddDocTypeDetector = class(TevdBufferedFilter)
 private
  f_AccGroup: AnsiString;
  f_DocType: Integer;
  f_ExportTypes: TddExportDocTypes;
  f_OnStartDocument: TNewDocumentEvent;
  f_OnStartDocumentProc: TNewDocumentProc;
  function ValidDocType: Boolean;
 protected
        {* - Функция, определяющая тип Тегов, для которых будет выполняться буферизация.}
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
    // internal methods
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
    // public methods
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
      {-}
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {-}
  procedure StartChild(TypeID: Tl3VariantDef); override;
  property DocType: Integer read f_DocType;
  property ExportTypes: TddExportDocTypes read f_ExportTypes write f_ExportTypes;
      {-}
  property OnStartDocument    : TNewDocumentEvent read f_OnStartDocument write f_OnStartDocument;
  property OnStartDocumentProc: TNewDocumentProc read f_OnStartDocumentProc write f_OnStartDocumentProc;
 end;

const
 dtOnlyDocs = [dtNone, dtText, dtShortCut, dtObject];
 dtAll      = [dtNone, dtText, dtRelText, dtShortCut, dtObject, dtDictEntry, dtAnnotation, dtFlash];

implementation

uses
  l3Base,

  k2Tags,
  k2Base,

  Document_Const,
  TextPara_Const,
  Block_Const,
  Table_Const,
  BitmapPara_Const,
  SectionBreak_const,
  PageBreak_Const,
  DictRec_Const,
  AnnoTopic_Const
  , Math;

// start class TevdBufferedFilter

constructor TddDocTypeDetector.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_ExportTypes:= dtAll;
end;

procedure TddDocTypeDetector.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
  if AtomIndex = k2_tiType then
   f_DocType:= Value.AsInteger;
 inherited
end;

function TddDocTypeDetector.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
var
 l_AC, l_DN: Tl3Variant;
 l_ExtTopicNo: Integer;
 i: Integer;
 l_Part: TddExportDocPart;
begin
 //if ValidDocType then
  if Assigned(f_OnStartDocument) or Assigned(f_OnStartDocumentProc) then
  begin
   if aTagID = -k2_idAnnotopic then
   begin
    l_Part := edpAnnotation;
    f_DocType:= Ord(dtAnnotation);
   end
   else
    if aLeaf.IntA[k2_tiType] = Ord(dtRelText) then
     l_Part := edpReference
    else
     l_Part := edpDocument;
   l_ExtTopicNo:= aLeaf.IntA[k2_tiExternalHandle];
   l_AC:= aLeaf.Attr[k2_tiAccGroups];
   if l_AC.IsValid and (l_AC.ChildrenCount > 0) then
    f_AccGroup:= l_AC.Child[0].StrA[k2_tiShortName]
   else
   if aLeaf.Attr[k2_tiGroups].IsValid and (aLeaf.Attr[k2_tiGroups].ChildrenCount > 0) then
    f_AccGroup:= aLeaf.Attr[k2_tiGroups].Child[0].StrA[k2_tiShortName]
   else
   if l_Part <> edpReference then
    f_AccGroup:= 'UNKNOWN';
   //if ValidDocType then
    if Assigned(f_OnStartDocument) then
     f_OnStartDocument(Self,
                       IfThen(ValidDocType, l_ExtTopicNo, -l_ExtTopicNo),
                       l_Part, f_AccGroup);
    if Assigned(f_OnStartDocumentProc) then
     f_OnStartDocumentProc(Self,
                           IfThen(ValidDocType, l_ExtTopicNo, -l_ExtTopicNo),
                           l_Part, f_AccGroup);
  end; // Assigned(f_OnStartDocument)
 Result:= ValidDocType;//TDocType(aLeaf.IntA[k2_tiType]) in ExportTypes;
end;

function TddDocTypeDetector.NeedStartBuffering(aID : Integer): Boolean;
var
 l_Type: Tk2Type;
begin
 Result:= False;
 if aID < 0 then
 begin
  l_Type := TypeTable.TypeByHandle[-aID];
  Result := l_Type.IsKindOf(k2_typDocument);
 end;
end;

procedure TddDocTypeDetector.StartChild(TypeID: Tl3VariantDef);
var
 l_Type: Tk2Type;
begin
 l_Type := Tk2Type(TypeID);
 if l_Type.IsKindOf(k2_typDocument) then
  f_DocType:= Ord(dtNone);
 if not l_Type.IsKindOf(k2_typDocument) and (SkipLevel = 2) and
   l_Type.IsKindOf([k2_typTextPara, k2_typBlock, k2_typTable, k2_typBitmapPara, k2_typSectionBreak, k2_typPageBreak]) and
   ValidDocType then
    StopBufferingAndFlush(False, TopObject[0], False);
 inherited;
end;

function TddDocTypeDetector.ValidDocType: Boolean;
begin
 Result := TdocType(f_DocType) in ExportTypes;
end;

end.
