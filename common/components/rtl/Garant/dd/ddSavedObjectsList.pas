unit ddSavedObjectsList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddSavedObjectsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddSavedObjectsList" MUID: (579885AE00B2)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Variant
 , l3Interfaces
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
 //#UC START# *579885AE00B2intf_uses*
 //#UC END# *579885AE00B2intf_uses*
;

type
 TddSavedObjectInfo = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rInternalID: Integer;
   rExternalID: Integer;
   rData: IStream;
   rSaved: Boolean;
 end;//TddSavedObjectInfo

 //#UC START# *579885AE00B2ci*
 //#UC END# *579885AE00B2ci*
 _ItemType_ = TddSavedObjectInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 //#UC START# *579885AE00B2cit*
 //#UC END# *579885AE00B2cit*
 TddSavedObjectsList = class(_l3RecordListPrim_)
  private
   f_Family: Integer;
   f_DocID: Integer;
  private
   procedure FlushObjects;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeRelease; override;
  public
   constructor Create(aFamily: Integer;
    aDocID: Integer); reintroduce;
   procedure SaveObject(aPara: Tl3Variant;
    const aData: IStream);
 //#UC START# *579885AE00B2publ*
 //#UC END# *579885AE00B2publ*
 end;//TddSavedObjectsList

function TddSavedObjectInfo_C(anInternalID: Integer;
 anExternalID: Integer;
 const aData: IStream): TddSavedObjectInfo;

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *579885AE00B2impl_uses*
 , ActiveX
 
 , l3Stream
 
 , k2Interfaces
 , k2Tags

 , m2ComLib

 , m3StorageInterfaces
 , m3DBInterfaces

 , daDataProvider

 , Dt_err
 
 , DT_Serv

 , Dialogs
 , vtDialogs
 //#UC END# *579885AE00B2impl_uses*
;

function TddSavedObjectInfo_C(anInternalID: Integer;
 anExternalID: Integer;
 const aData: IStream): TddSavedObjectInfo;
//#UC START# *5798B531019C_5798B3EE0111_var*
//#UC END# *5798B531019C_5798B3EE0111_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5798B531019C_5798B3EE0111_impl*
 Result.rInternalID := anInternalID;
 Result.rExternalID := anExternalID;
 Result.rData := aData;
 Result.rSaved := false;
//#UC END# *5798B531019C_5798B3EE0111_impl*
end;//TddSavedObjectInfo_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_579885AE00B2_var*
//#UC END# *47B07CF403D0_579885AE00B2_var*
begin
//#UC START# *47B07CF403D0_579885AE00B2_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_579885AE00B2_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_579885AE00B2_var*
//#UC END# *47B2C42A0163_579885AE00B2_var*
begin
//#UC START# *47B2C42A0163_579885AE00B2_impl*
 Assert(false);
//#UC END# *47B2C42A0163_579885AE00B2_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_579885AE00B2_var*
//#UC END# *47B99D4503A2_579885AE00B2_var*
begin
//#UC START# *47B99D4503A2_579885AE00B2_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_579885AE00B2_impl*
end;//CompareExistingItems

type _Instance_R_ = TddSavedObjectsList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

constructor TddSavedObjectsList.Create(aFamily: Integer;
 aDocID: Integer);
//#UC START# *5798A0E302A5_579885AE00B2_var*
//#UC END# *5798A0E302A5_579885AE00B2_var*
begin
//#UC START# *5798A0E302A5_579885AE00B2_impl*
 inherited Create;
 f_Family := aFamily;
 f_DocID := aDocID;
//#UC END# *5798A0E302A5_579885AE00B2_impl*
end;//TddSavedObjectsList.Create

procedure TddSavedObjectsList.SaveObject(aPara: Tl3Variant;
 const aData: IStream);
//#UC START# *5798A87D02CA_579885AE00B2_var*
var
 l_InternalID : Integer;
 l_ExternalID : Integer;
 l_O : TddSavedObjectInfo;
 l_Item : TddSavedObjectInfo;
 l_Found : Boolean;
 l_Index : Integer;
 l_Out   : IStream;
 l_RawData : Ik2RawData; 
//#UC END# *5798A87D02CA_579885AE00B2_var*
begin
//#UC START# *5798A87D02CA_579885AE00B2_impl*
 l_RawData := nil;
 try
  l_InternalID := -1;
  l_ExternalID := -1;
  if Supports(aData, Ik2RawData, l_RawData) then
  begin
   l_InternalID := l_RawData.InternalID;
   l_ExternalID := l_RawData.ExternalID;
  end;//Supports(aData, Ik2RawData, l_RawData)

  if (l_InternalID <= 0) then
   if aPara.Attr[k2_tiInternalHandle].IsValid then
    l_InternalID := aPara.IntA[k2_tiInternalHandle];
  if (l_ExternalID <= 0) then
   if aPara.Attr[k2_tiExternalHandle].IsValid then
    l_ExternalID := aPara.IntA[k2_tiExternalHandle];
  l_O := TddSavedObjectInfo_C(l_InternalID, l_ExternalID, aData);

  l_Found := false;

  for l_Index := 0 to Pred(Self.Count) do
  begin
   l_Item := Self.Items[l_Index];
   try
    m2COMSeek(l_Item.rData, 0, STREAM_SEEK_SET);
    m2COMSeek(aData, 0, STREAM_SEEK_SET);
    if l3CompareStreams(l_Item.rData, aData) then
    begin
     l_Found := true;
     l_O := l_Item;
    end;//l3CompareStreams(l_Item.rData, aData)
    m2COMSeek(l_Item.rData, 0, STREAM_SEEK_SET);
    m2COMSeek(aData, 0, STREAM_SEEK_SET);
    if l_Found then
     break;
   finally
    Finalize(l_Item);
   end;//try..finally
  end;//for l_Index

  if not l_Found then
  begin
   // - тут будем проверять уникальность номеров
   for l_Index := 0 to Pred(Self.Count) do
   begin
    with Self.ItemSlot(l_Index)^ do
    begin
     if (rInternalID = l_O.rInternalID) then
      l_O.rInternalID := -1;
     if (rExternalID = l_O.rExternalID) then
      l_O.rExternalID := -1;
    end;//with Self.ItemSlot(l_Index)^
   end;//for l_Index
  end;//not l_Found

  if not l_Found then
  begin
   if (l_O.rInternalID <= 0) then
   begin
    l_Out := dtGetObjectStream(f_Family, f_DocID, l_O.rInternalID, m3_saCreate);
    try
     m2COMCopyData(l_Out, aData);
    finally
     l_Out := nil;
    end;//try..finally
    l_O.rSaved := true;
   end;//l_O.rInternalID < 0
   if (l_O.rExternalID <= 0) then
    try
     l_O.rExternalID := GlobalDataProvider.GetFreeExtObjID(f_Family);
    except
     on EHTErrors do
     begin
      vtMessageDlg(l3CStr('Не удаётся назначить ID для изображения! Обратитесь в службу поддержки.'), mtError);
     end;//on EHTErrors
    end;//try..except
   Add(l_O);
  end;//not l_Found

  try
   Assert(l_O.rInternalID > 0);
   Assert(l_O.rExternalID > 0);
  except
   on E: Exception do
   vtMessageDlg(l3CStr(E.Message), mtError);
  end;//try..except 
  aPara.IntA[k2_tiInternalHandle] := l_O.rInternalID;
  aPara.IntA[k2_tiExternalHandle] := l_O.rExternalID;
  if (l_RawData <> nil) then
  begin
   l_RawData.InternalID := l_O.rInternalID;
   l_RawData.ExternalID := l_O.rExternalID;
  end;//l_RawData <> nil
 finally
  l_RawData := nil;
 end;//try..finally
//#UC END# *5798A87D02CA_579885AE00B2_impl*
end;//TddSavedObjectsList.SaveObject

procedure TddSavedObjectsList.FlushObjects;
//#UC START# *5798B3AF0046_579885AE00B2_var*

var
 l_DB : Im3DB;
 l_Doc : Im3DBDocument;
 
 procedure CheckDoc;
 begin//CheckDoc
  if (l_DB = nil) then
   l_DB := dtGetDB(f_Family);
  if (l_Doc = nil) then
   l_Doc := l_DB.GetDocument(f_DocID); 
 end;//CheckDoc

var
 l_Index : Integer;
 l_In : IStream;
 l_Out : IStream;
 l_Read : Int64;
 l_Written : Int64;
 l_InternalID : Integer;
 l_NeedSaveObject : Boolean;
 l_RawData : Ik2RawData; 
//#UC END# *5798B3AF0046_579885AE00B2_var*
begin
//#UC START# *5798B3AF0046_579885AE00B2_impl*
 if not Self.Empty then
 begin
  l_DB := nil;
  try
   l_Doc := nil;
   try
    for l_Index := 0 to Pred(Self.Count) do
    begin
     try
      with Self.ItemSlot(l_Index)^ do
      begin
       if rSaved then
        continue;
       l_In := rData;
       l_InternalID := rInternalID;
      end;//with Self.ItemSlot(l_Index)^
      l_NeedSaveObject := true;
      if Supports(l_In, Ik2RawData, l_RawData) then
      try
       l_NeedSaveObject := l_RawData.IsModified;
      finally
       l_RawData := nil;
      end;//try..finally
      if l_NeedSaveObject then
      begin
       CheckDoc;
       l_Out := l_Doc.Open(m3_saRead, m3_dsObject, l_InternalID);
       try
        if (l_Out <> nil) then
        begin
         m2COMSeek(l_In, 0, STREAM_SEEK_SET);
         l_NeedSaveObject := not l3CompareStreams(l_In, l_Out);
         if l_NeedSaveObject then
          m2COMSeek(l_In, 0, STREAM_SEEK_SET);
        end;//l_Out <> nil
       finally
        l_Out := nil;
       end;//try..finally
       if l_NeedSaveObject then
       begin
        CheckDoc;
        l_Out := l_Doc.Open(m3_saCreate, m3_dsObject, l_InternalID);
        try
         m2COMCopyData(l_Out, l_In);
        finally
         l_Out := nil;
        end;//try..finally
       end;//l_NeedSaveObject
      end;//l_NeedSaveObject
     finally
      l_In := nil
     end;//try..finally
    end;//for l_Index
   finally
    l_Doc := nil;
   end;//try..finally
  finally
   l_DB := nil;
  end;//try..finally
 end;//not Self.Empty
//#UC END# *5798B3AF0046_579885AE00B2_impl*
end;//TddSavedObjectsList.FlushObjects

procedure TddSavedObjectsList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_579885AE00B2_var*
//#UC END# *479731C50290_579885AE00B2_var*
begin
//#UC START# *479731C50290_579885AE00B2_impl*
 f_Family := 0;
 f_DocID := 0;
 inherited;
//#UC END# *479731C50290_579885AE00B2_impl*
end;//TddSavedObjectsList.Cleanup

procedure TddSavedObjectsList.InitFields;
//#UC START# *47A042E100E2_579885AE00B2_var*
//#UC END# *47A042E100E2_579885AE00B2_var*
begin
//#UC START# *47A042E100E2_579885AE00B2_impl*
 inherited;
 //Sorted := true;
//#UC END# *47A042E100E2_579885AE00B2_impl*
end;//TddSavedObjectsList.InitFields

procedure TddSavedObjectsList.BeforeRelease;
//#UC START# *49BFC98902FF_579885AE00B2_var*
//#UC END# *49BFC98902FF_579885AE00B2_var*
begin
//#UC START# *49BFC98902FF_579885AE00B2_impl*
 FlushObjects;
 inherited;
//#UC END# *49BFC98902FF_579885AE00B2_impl*
end;//TddSavedObjectsList.BeforeRelease

//#UC START# *579885AE00B2impl*
//#UC END# *579885AE00B2impl*

end.
