unit Dt_RecalcHLinkFilter;
{ Описание: Фильтр проверяет и, при необходимости, заменяет адреса гиперссылок.}
{ Алгоритм: у каждой гиперссылки читается Handle. Если в таблице HLINK имеется
            хоть одна запись с ID = этот Handle и SourDoc = заданным DocID,
            то тогда все адреса этой гиперссылки (DestDoc, DestSub) заменяются
            на адреса, найденные в HLINK (для указанных ID и SourDoc).
            Иначе - адреса пропускаются без изменений.}

{ $Id: Dt_RecalcHLinkFilter.pas,v 1.47 2016/06/16 05:40:06 lukyanets Exp $ }
// $Log: Dt_RecalcHLinkFilter.pas,v $
// Revision 1.47  2016/06/16 05:40:06  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.46  2014/03/28 06:13:29  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.45  2013/10/21 15:43:09  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.44  2013/10/21 10:30:56  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.43  2013/10/18 15:38:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.42  2013/05/13 17:23:52  lulin
// - разборки с упавшими тестами.
//
// Revision 1.41  2012/08/22 07:28:27  dinishev
// Bug fix: отъехали тесты.
//
// Revision 1.40  2012/08/20 12:32:37  voba
// - K: 385977491
//
// Revision 1.39  2012/05/17 12:36:35  voba
// - k:363574319
//
// Revision 1.38  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.37  2009/03/04 16:26:03  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.36  2008/05/08 14:04:12  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.35  2008/03/21 14:09:27  lulin
// - cleanup.
//                                                    
// Revision 1.34  2008/02/21 16:32:51  lulin
// - cleanup.
//
// Revision 1.33  2008/02/19 11:38:38  lulin
// - восстановил компилируемость Архивариуса.
//
// Revision 1.32  2008/02/14 09:40:39  lulin
// - удалён ненужный класс.
//
// Revision 1.31  2008/02/13 20:20:11  lulin
// - <TDN>: 73.
//
// Revision 1.30  2008/02/13 16:03:08  lulin
// - убраны излишне гибкие методы поиска.
//
// Revision 1.29  2008/02/07 19:13:11  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.28  2008/02/06 15:37:06  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.27  2008/02/05 09:58:05  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.26  2008/02/04 11:56:16  lulin
// - bug fix: падали при открытии документа в Архивариусе.
//
// Revision 1.25  2008/02/01 15:14:48  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.24  2007/08/09 18:05:27  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.23  2007/08/09 11:19:23  lulin
// - cleanup.
//
// Revision 1.22  2007/04/10 10:37:32  voba
// - change Sab to ISab
//
// Revision 1.21  2006/06/15 09:45:06  voba
// -bug fix : не восстанавливались ссылки из таблицы
//
// Revision 1.20  2006/03/24 14:40:08  fireton
// - change: список ссылок набирается не в OpenStream, а в AddAtomEx, когда приезжает DocumentID
//
// Revision 1.19  2005/03/28 11:32:25  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.18  2005/03/21 10:05:03  lulin
// - new interface: _Ik2Type.
//
// Revision 1.17  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.16  2004/08/26 17:06:30  step
// speed optimization
//
// Revision 1.15  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.14  2004/06/02 08:45:46  law
// - удален конструктор Tl3VList.MakePersistentSorted - пользуйтесь _Tl3ObjectRefList.MakeSorted.
//
// Revision 1.13  2004/05/14 16:58:47  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.12  2004/05/14 14:48:59  law
// - исправлены префиксы у констант.
//
// Revision 1.11  2004/05/14 14:29:05  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.10  2003/12/29 12:39:03  voba
// -bug fix: учитывает дополнительные теги (шрифт) внутри ссылки
//
// Revision 1.9  2003/12/24 11:45:26  step
// speed optimization
//
// Revision 1.8  2003/12/23 15:08:17  step
// bug fix: учтен произвольный порядок следования Handle и Addresses
//
// Revision 1.7  2003/12/22 15:59:59  step
// bug fix: сброс флага f_RecalcNeeded перенесен из StartChild в CloseStructure
//
// Revision 1.6  2003/12/22 14:02:19  step
// bug fix: исправлена CloseStructure
//
// Revision 1.5  2003/12/17 15:01:16  voba
// - bug fix
//
// Revision 1.4  2003/12/17 14:39:30  voba
// - speed optimize
//
// Revision 1.3  2003/12/16 13:13:08  voba
// - change: create - заменил reintroduce на override
//
// Revision 1.2  2003/12/04 12:15:51  step
// bug fix: список д.б. сортированым
//
// Revision 1.1  2003/12/04 10:30:04  step
// Новый фильтр для проверки гиперссылок
//

{$Include DtDefine.inc}

interface

uses
  Classes,
  Contnrs,

  l3Types,
  l3Base,
  l3Variant,
  l3BaseWithIDList,
  l3ObjectRefList,

  k2Prim,
  k2TagGen,
  k2Types,
  
  k2TagFilter,

  daTypes,

  dt_Types;

type
  TRecalcAction = (raUndefined, raPassThru, raReplace);

  TRecalcHLinksFilter = class(Tk2TagFilter)
  private
   f_Family       : TdaFamilyID;
   f_DocID        : TDocID;
   f_Links        : Tl3BaseWithIDList;
   f_Addresses    : Tl3ObjectRefList;

   // флаги
   f_ExternalDocID : Boolean; // True когда пользователь руками задает DocID, при этом информация из тега игнорируется
   f_NeedLoadLinks : Boolean; // требуется загрузка списка ссылок
   f_FoundIndex   : Integer;
   f_LinkId       : Longint;
   f_RecalcAction : TRecalcAction;
   f_InPara       : Boolean;
   f_InHyperlink  : Boolean;
   f_InAddress    : Boolean;
   // обработчики соотв. событий
   procedure AfterOpenHyperlink;
   procedure BeforeCloseHyperLink;
   procedure BeforeOpenAddress;
   procedure AfterCloseAddress;
   procedure FillLinksList;
   procedure OnReadDocId(const Value: Tk2Variant);
   procedure OnReadSubId(const Value: Tk2Variant);
   procedure OnReadHandle(const Value: Tk2Variant);

   function  GetLinks : Tl3BaseWithIDList;
   function  GetAddresses : Tl3ObjectRefList;

   procedure SetFamily(aValue : TdaFamilyID);
   procedure SetDocIDPrim(aValue: TDocID);
   procedure SetDocID(aValue : TDocID);
  protected
   procedure Cleanup; override;
   procedure CloseStructure(NeedUndo: Bool); override;
  public
   constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
   procedure OpenStream; override;
   procedure CloseStream(NeedUndo : Boolean); override;
   procedure StartChild(TypeID: Tl3VariantDef); override;
   procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;

   class function SetTo(var theGenerator : Tk2TagGenerator;
                            aDocFamily   : TdaFamilyID;
                            aDocID       : TDocID): Pointer;
      overload;

   property  Addresses : Tl3ObjectRefList read GetAddresses;
   property  Links    : Tl3BaseWithIDList read GetLinks;

   property  Family : TdaFamilyID read f_Family write SetFamily;
   property  DocID  : TDocID read f_DocID write SetDocID;
  end;

implementation

uses
  SysUtils,
  l3BaseWithID,

  k2Interfaces,
  k2Tags,
  k2Base,

  Dt_err,
  Dt_Hyper,
  Dt_LinkServ,
  HT_Const,
  HT_Dll,
  Math,

  Address_Const,
  Hyperlink_Const,
  TextPara_Const,
  AnnoTopic_Const,
  Document_Const
  ;

type

 THLinkData = class(Tl3BaseWithId)
 public
  Doc: TDocID;
  Sub: TSubID;
  constructor Create(anId: LongInt;
                     aDoc: TDocID;
                     aSub: TSubID);
 end;

 TAddress = class(Tl3Base)
 public
  DocId: TDocID;
  SubId: TSubID;
  constructor Create;
 end;

constructor TRecalcHLinksFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 //f_Links := Tl3BaseWithIDList.MakeSorted(l3_dupAccept);
 //f_Addresses := _TObjectList.Create(True);
end;

function  TRecalcHLinksFilter.GetLinks : Tl3BaseWithIDList;
begin
 if f_Links = nil then
  f_Links := Tl3BaseWithIDList.MakeSorted(l3_dupAccept);

 if f_NeedLoadLinks then
  FillLinksList;

 Result := f_Links;
end;

function  TRecalcHLinksFilter.GetAddresses : Tl3ObjectRefList;
begin
 if f_Addresses = nil then
  f_Addresses := Tl3ObjectRefList.Make;
 Result := f_Addresses;
end;

procedure TRecalcHLinksFilter.Cleanup;
begin
 //f_Links.Clear;
 l3Free(f_Links);
 FreeAndNil(f_Addresses);
 inherited;
end;

procedure TRecalcHLinksFilter.CloseStructure(NeedUndo: Bool);
var
 CT             : Tk2Type;
 l_WasInAddress : Boolean;
begin
 l_WasInAddress := false;

 CT := CurrentType;
 if f_InAddress and CT.IsKindOf(k2_typAddress) and f_InHyperlink then
 begin
  // - закрываем именно адрес ссылки
  l_WasInAddress := true;
  f_InAddress := False;
 end//f_InAddress..
 else if f_InHyperlink and CT.IsKindOf(k2_typHyperlink) then
 begin
  // - закрываем именно ссылку
  BeforeCloseHyperLink;
  f_InHyperlink := False;
 end//f_InHyperlink
 else if f_InPara and CT.IsKindOf(k2_typTextPara) then
 begin
  // - закрываем именно текстовый параграф
  // - здесь, например можно добавить что-нибудь к закрываемому параграфу
  f_InPara := False;
 end;//f_InPara

 inherited;

 if l_WasInAddress then
  AfterCloseAddress;
end;

procedure TRecalcHLinksFilter.StartChild(TypeID: Tl3VariantDef);
var
 CT : Tk2Type;
begin
 CT := Tk2Type(TypeID);
 if CT.IsKindOf(k2_typAddress) and f_InHyperlink then
  BeforeOpenAddress;

 inherited;

 CT := CurrentType;
 if not f_InPara then
  f_InPara := CT.IsKindOf(k2_typTextPara)
 else if not f_InHyperlink then
  f_InHyperlink := CT.IsKindOf(k2_typHyperlink)
 else if not f_InAddress then
  f_InAddress := CT.IsKindOf(k2_typAddress);

 if f_InHyperlink and not f_InAddress then
  AfterOpenHyperlink;
end;

procedure TRecalcHLinksFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 lSkipTag : Boolean;
begin
 lSkipTag := False;
 if f_InHyperlink and not f_InAddress and (AtomIndex = k2_tiHandle) then
  OnReadHandle(Value);

 if f_InAddress then
  case AtomIndex of
   k2_tiDocID: OnReadDocId(Value);
   k2_tiSubID: OnReadSubId(Value);
   k2_tiName : lSkipTag := True;
  end;

 if not lSkipTag then
  inherited;

 if (not f_ExternalDocID) and (AtomIndex = k2_tiInternalHandle) and
    (TopType[0].IsKindOf(k2_typDocument) or TopType[0].IsKindOf(k2_typAnnoTopic)) then
 begin
  if (Value.Kind = k2_vkInteger) then
   SetDocIDPrim(TDocID(Value.AsInteger))
  else
   ConvertErrorEx(Value.Kind)
 end;
end;

procedure TRecalcHLinksFilter.SetDocID(aValue: TDocID);
begin
 f_ExternalDocID := True;
 SetDocIDPrim(aValue);
end;

procedure TRecalcHLinksFilter.SetDocIDPrim(aValue: TDocID);
begin
 if f_DocID <> aValue then
 begin
  f_NeedLoadLinks := True;
  f_DocID := aValue;
 end;
end;

procedure TRecalcHLinksFilter.SetFamily(aValue: TdaFamilyID);
begin
 if f_Family <> aValue then
 begin
  if StreamOpened then
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   f_Family := aValue;
 end;
end;

procedure TRecalcHLinksFilter.CloseStream(NeedUndo: Boolean);
begin
 if f_Links <> nil then
  f_Links.Clear;

 inherited;
end;

procedure TRecalcHLinksFilter.OpenStream;
begin
 inherited;
 f_InPara :=False;
 f_InHyperlink :=False;
 f_InAddress :=False;

 if f_Addresses <> nil then
  f_Addresses.Clear;
end;

{ THLinkData }

constructor THLinkData.Create(anId: Integer; aDoc: TDocID; aSub: TSubID);
begin
 inherited Create(anId);
 Doc := aDoc;
 Sub := aSub;
end;

{ TAddress }

constructor TAddress.Create;
begin
 inherited Create;

 DocId := 0;
 SubId := 0;
end;

procedure TRecalcHLinksFilter.AfterCloseAddress;
begin
 if f_RecalcAction in [raUndefined, raReplace] then
  DecSkipTags;
end;

procedure TRecalcHLinksFilter.BeforeCloseHyperLink;
var
 l_LinkData : THLinkData;
 I: Integer;
begin
 if Generator = nil then
  Exit;

 if f_RecalcAction = raReplace then
  for I := f_FoundIndex to Pred(Links.Count) do
  begin
   l_LinkData := THLinkData(Links.Items[I]);

   if (l_LinkData.ID <> f_LinkId) then
    Break;

   Generator.StartChild(k2_typAddress);
   try
    Generator.AddIntegerAtom(k2_tiDocID, l_LinkData.Doc);
    Generator.AddIntegerAtom(k2_tiSubID, l_LinkData.Sub);
   finally
    Generator.Finish;
   end;
  end
  else
   for I := 0 to Pred(Addresses.Count) do
   begin
    Generator.StartChild(k2_typAddress);
    try
     Generator.AddIntegerAtom(k2_tiDocID, TAddress(Addresses.Items[I]).DocId);
     Generator.AddIntegerAtom(k2_tiSubID, TAddress(Addresses.Items[I]).SubId);
    finally
     Generator.Finish;
    end;
   end; // for

 Addresses.Clear;
end;

procedure TRecalcHLinksFilter.AfterOpenHyperlink;
begin
 f_RecalcAction := raUndefined;
 f_FoundIndex := -1;
 f_LinkId := -1;
end;

procedure TRecalcHLinksFilter.OnReadDocId(const Value: Tk2Variant);
begin
 if f_RecalcAction = raUndefined then
  if (Value.Kind = k2_vkInteger) and (Addresses.Count > 0) then
   TAddress(Addresses.Items[Pred(Addresses.Count)]).DocId := Value.AsInteger;
end;

procedure TRecalcHLinksFilter.OnReadHandle(const Value: Tk2Variant);
begin
 if Value.Kind = k2_vkInteger then
 begin
  f_LinkId := Value.AsInteger;

  if (f_LinkId > 0) and Links.FindData(f_LinkId, f_FoundIndex) then
   f_RecalcAction := raReplace
  else
   f_RecalcAction := raPassThru;
 end;
end;

procedure TRecalcHLinksFilter.OnReadSubId(const Value: Tk2Variant);
begin
 if f_RecalcAction = raUndefined then
  if (Value.Kind = k2_vkInteger) and (Addresses.Count > 0) then
   TAddress(Addresses.Items[Pred(Addresses.Count)]).SubId := Value.AsInteger;
end;

procedure TRecalcHLinksFilter.BeforeOpenAddress;
var
 l_A : TAddress;
begin
 if (f_RecalcAction in [raUndefined, raReplace]) then
  IncSkipTags;

 if f_RecalcAction = raUndefined then
 begin
  l_A := TAddress.Create;
  try
   Addresses.Add(l_A); // вставка пустого адреса (наполним при чтении DocId и SubId)
  finally
   FreeAndNil(l_A);
  end;//try..finally
 end;//
end;

procedure TRecalcHLinksFilter.FillLinksList;
const
  hlFldCount  = 4;
  hlFldArr: array[1..hlFldCount] of SmallInt = (hlID_fld,
                                                hlSourD_fld,
                                                hlDestD_fld,
                                                hlDestS_fld);
var
 l_LinksSab : Sab;
 l_pLinkRec : PHyperLinkRec;
 l_Item     : THLinkData;
 l_Buffer   : PChar;
 l_BufferSize: Integer;
 l_BytesInBuffer: Integer;
 I: Integer;
begin
 // набираем в список f_Links все линки для документа DocID
 if (f_Family <> 0) and (f_DocID <> 0) then
 begin
  l_LinksSab := LinkServer(f_Family).HLinkTbl.GetHListOnDoc(f_DocID).HTSab; // уже отсортированные по Id
  f_Links.Clear;
  if l_LinksSab.gFoundCnt > 0 then
  begin
   Ht(htOpenResults(l_LinksSab,
                    ROPEN_READ,
                    @hlFldArr,
                    hlFldCount));
   try
    l_BufferSize := Min(MAX_BUF_LEN, l_LinksSab.gFoundCnt * SizeOf(THyperLinkRec));
    l3System.GetLocalMem(l_Buffer, l_BufferSize);
    try
     repeat
      l_BytesInBuffer := htReadResults(l_LinksSab,
                                       l_Buffer,
                                       l_BufferSize);
      for I := 0 to (l_BytesInBuffer div SizeOf(THyperLinkRec)) - 1 do
      begin
       l_pLinkRec := PHyperLinkRec(l_Buffer + I * SizeOf(THyperLinkRec));
       if l_pLinkRec^.ID <> 0 then
       begin
        l_Item := THLinkData.Create(l_pLinkRec^.ID,
                                    l_pLinkRec^.DDoc,
                                    l_pLinkRec^.DSub);
        try
         f_Links.Add(l_Item);
        finally
         l3Free(l_Item);
        end;
       end; // if
      end; // for
     until l_BytesInBuffer = 0;
    finally
     l3System.FreeLocalMem(l_Buffer);
    end;
   finally
    htCloseResults(l_LinksSab);
   end;
  end;
 end;
 f_NeedLoadLinks := False;
end;

class function TRecalcHLinksFilter.SetTo(var theGenerator : Tk2TagGenerator;
                                             aDocFamily   : TdaFamilyID;
                                             aDocID       : TDocID): Pointer;
begin
 Result := inherited SetTo(theGenerator);
 with (theGenerator as TRecalcHLinksFilter) do
 begin
  Family := aDocFamily;
  DocID  := aDocID;
 end;
end;


end.

