unit evHndFlt;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В. ©   }
{ Модуль: evHndFlt - }
{ Начат: 17.03.99 19:14 }
{ $Id: evHndFlt.pas,v 1.22 2014/10/23 11:39:14 lulin Exp $ }

// $Log: evHndFlt.pas,v $
// Revision 1.22  2014/10/23 11:39:14  lulin
// - добавляем диагностику.
//
// Revision 1.21  2014/05/14 13:11:41  lulin
// {RequestLink:517789752}.
//
// Revision 1.20  2014/03/28 06:14:13  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.19  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.18  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.17  2013/10/18 15:38:57  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.16  2009/03/04 16:25:52  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.15  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.13.8.1  2007/08/09 11:19:12  lulin
// - cleanup.
//
// Revision 1.13  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.12  2005/02/24 15:05:24  lulin
// - new behavior: "труба экспорта" учитывает, то что у документа может быть несколько потоков.
//
// Revision 1.11  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.10  2004/05/14 16:58:27  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.9  2004/05/14 14:48:47  law
// - исправлены префиксы у констант.
//
// Revision 1.8  2004/05/14 14:28:50  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.7  2002/09/18 08:06:10  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.6  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.5  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.4  2000/12/15 15:10:36  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Filer,
  l3Variant,

  k2Prim,
  k2Types,
  k2TagTerminator,

  m3DBInterfaces
  ;

type
  TevGenerateTopicIDEvent = function (Sender: TObject): Tm3DBStreamIndex of object;
  TevOutExtLongEvent = procedure(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler) of object;
   {* - событие для записи целочисленного параметра в поток. }

  TevCustomDocIDFilter = class(Tk2TagTerminator)
    private
    {internal fields}
      f_Locked      : Bool;
      f_Transparent : Bool;
      f_DocID       : Tm3DBStreamIndex;
    private
    {property fields}
      f_OnGenerateTopicID : TevGenerateTopicIDEvent;
    protected
    {internal methods}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure NewID(const ID: Tm3DBStreamIndex);
        virtual;
        {-}
      procedure DoneID(const ID: Tm3DBStreamIndex);
        virtual;
        {-}
      function  GenerateID: Tm3DBStreamIndex;
        //virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    protected
    {internal properties}
      property Transparent: Bool
        read f_Transparent
        write f_Transparent;
        {-}
    public
    {public methods}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
    public
    {public properties}
      property OnGenerateTopicID: TevGenerateTopicIDEvent
        read f_OnGenerateTopicID
        write f_OnGenerateTopicID;
        {-}
  end;{TevCustomDocIDFilter}

  TevCustomTopicSwitcher = class(TevCustomDocIDFilter)
    private
    {property fields}
      f_Filer : Tl3CustomFiler;
    private
    {event fields}
      f_OnInitTopic : TevOutExtLongEvent;
      f_OnDoneTopic : TevOutExtLongEvent;
    protected
    {property methods}
      function  pm_GetFiler: Tl3CustomFiler;
        virtual;
      procedure pm_SetFiler(Value: Tl3CustomFiler);
        virtual;
        {-}
    protected
    {internal methods}
      procedure Cleanup;
        override;
        {-}
      procedure Init(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
        virtual;
        {-}
      procedure Done(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
        virtual;
        {-}
      procedure NewID(const ID: Tm3DBStreamIndex);
        override;
        {-}
      procedure DoneID(const ID: Tm3DBStreamIndex);
        override;
        {-}
    public
    {public properties}
      property Filer: Tl3CustomFiler
        read pm_GetFiler
        write pm_SetFiler;
        {-}
    public
    {public events }
      property OnInitTopic: TevOutExtLongEvent
        read f_OnInitTopic
        write f_OnInitTopic;
        {-}
      property OnDoneTopic: TevOutExtLongEvent
        read f_OnDoneTopic
        write f_OnDoneTopic;
        {-}
  end;{TevCustomTopicSwitcher}

  TevTopicSwitcher = class(TevCustomTopicSwitcher)
    published
    {published properties}
      property Generator;
        {-}
      property Filer;
        {-}
    published
    {published events}
      property OnGenerateTopicID;
        {-}
      property OnInitTopic;
        {-}
      property OnDoneTopic;
        {-}
  end;{TevTopicSwitcher}

implementation

uses
  SysUtils,
  l3Base,
  k2Tags,

  Document_Const,
  AnnoTopic_Const
  ;

{ start class TevCustomDocIDFilter }

procedure TevCustomDocIDFilter.Cleanup;
  //override;
  {-}
begin
 f_Locked := false;
 inherited;
end;

procedure TevCustomDocIDFilter.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
begin
 inherited;
 if f_Locked then
 begin
  f_DocID := GenerateID;
  NewID(f_DocID);
  Generator.StartChild(TopType[1]);
  Generator.StartChild(TypeID);
 end//f_Locked
 else
 begin
  if not Transparent AND CurrentType.IsKindOf(k2_typDocument) then
  begin
   f_Locked := true;
   if CurrentType.IsKindOf(k2_typAnnoTopic) then
    f_DocID.rPart := m3_dsAnno
   else
    f_DocID.rPart := m3_dsMain;
  end//not Transparent..
  else
  begin
   Generator.StartChild(TypeID);
  end;//not Transparent..
 end;//f_Locked
end;

procedure TevCustomDocIDFilter.StartTag(TagID: Long);
  {override;}
  {-}
begin
 inherited StartTag(TagID);
 if f_Locked then
 begin
  f_DocID := GenerateID;
  NewID(f_DocID);
  Generator.StartChild(TopType[1]);
 end;{f_Locked}
 Generator.StartTag(TagID);
end;

procedure TevCustomDocIDFilter.CloseStructure(NeedUndo: Bool);
  {override;}
  {-вызывается на закрывающуюся скобку}
var
 IsDone : Bool;
begin
 Generator.Finish;
 IsDone := CurrentType.IsKindOf(k2_typDocument);
 inherited;
 if IsDone then DoneID(f_DocID);
end;

procedure TevCustomDocIDFilter.NewID(const ID: Tm3DBStreamIndex);
  {virtual;}
  {-}
begin
 f_Locked := false;
end;

procedure TevCustomDocIDFilter.DoneID(const ID: Tm3DBStreamIndex);
  {virtual;}
  {-}
begin
end;
  
function TevCustomDocIDFilter.GenerateID: Tm3DBStreamIndex;
  {virtual;}
  {-}
begin
 if Assigned(f_OnGenerateTopicID) then
  Result := f_OnGenerateTopicID(Self)
 else
  raise Exception.Create('Cannot generate DocID');
  {&&& exception &&&}
end;

procedure TevCustomDocIDFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
begin
 if f_Locked then begin
  if (AtomIndex = k2_tiInternalHandle) then
  begin
   if (Value.Kind = k2_vkInteger) then
    f_DocID.rID := Value.AsInteger
   else
    ConvertErrorEx(Value.Kind);
  end//AtomIndex = k2_tiInternalHandle
  else
   f_DocID := GenerateID;
  NewID(f_DocID);
  Generator.StartChild(CurrentType);
  Generator.AddAtomEx(AtomIndex, Value);
 end else
  Generator.AddAtomEx(AtomIndex, Value);
end;

{ start class TevCustomTopicSwitcher }

procedure TevCustomTopicSwitcher.Cleanup;
  {override;}
  {-}
begin
 Filer := nil;
 inherited;
end;

function TevCustomTopicSwitcher.pm_GetFiler: Tl3CustomFiler;
  {virtual;}
  {-}
begin
 Result := f_Filer;
end;

procedure TevCustomTopicSwitcher.pm_SetFiler(Value: Tl3CustomFiler);
  {virtual;}
  {-}
begin
 l3Set(f_Filer, Value);
end;

procedure TevCustomTopicSwitcher.Init(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
  {virtual;}
  {-}
begin
 if Assigned(f_OnInitTopic) then f_OnInitTopic(Self, ID, Filer);
end;

procedure TevCustomTopicSwitcher.Done(const ID: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
  {virtual;}
  {-}
begin
 if Assigned(f_OnDoneTopic) then f_OnDoneTopic(Self, ID, Filer);
end;

procedure TevCustomTopicSwitcher.NewID(const ID: Tm3DBStreamIndex);
  {override;}
  {-}
begin
 inherited NewID(ID);
 Init(ID, Filer);
end;

procedure TevCustomTopicSwitcher.DoneID(const ID: Tm3DBStreamIndex);
  {override;}
  {-}
begin
 Done(ID, Filer);
end;

end.

