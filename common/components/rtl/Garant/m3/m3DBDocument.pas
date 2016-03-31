unit m3DBDocument;
 {* Реализация документа. }

// Модуль: "w:\common\components\rtl\Garant\m3\m3DBDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3DBDocument" MUID: (4742DCCE00DD)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseObject
 , m3DBInterfaces
 , m3PrimDB
 , ActiveX
 , m3StorageInterfaces
;

type
 Tm3DBDocument = class(Tm3BaseObject, Im3DBDocument)
  {* Реализация документа. }
  private
   f_ID: Integer;
    {* Поле для свойства ID }
  protected
   function pm_GetID: Integer;
   procedure Delete;
    {* Удаляет документ из хранилища. }
   function Undelete: Boolean;
    {* Восстанавливает документ. }
   function GetConst: Im3DBDocumentPart;
    {* Постоянная часть документа. }
   function GetVersion(aLevel: Integer = 0): Im3DBDocumentPart;
    {* Переменная часть документа. }
   function Open(aMode: Tm3StoreAccess = m3_saRead;
    aDocPart: Tm3DocPartSelector = m3_defDocPart;
    aIndex: Integer = 0): IStream;
    {* открыть документ. }
   function GetFreeObjectID: Integer;
   procedure DeleteObject(aObjID: Integer);
  public
   constructor Create(aDB: Tm3PrimDB;
    anID: Integer); reintroduce;
   class function Make(aDB: Tm3PrimDB;
    anID: Integer): Im3DBDocument; reintroduce;
  protected
   property ID: Integer
    read f_ID;
 end;//Tm3DBDocument

implementation

uses
 l3ImplUses
 , m3DBDocumentPart
 , m3DB
;

constructor Tm3DBDocument.Create(aDB: Tm3PrimDB;
 anID: Integer);
//#UC START# *555B2DEC002E_4742DCCE00DD_var*
//#UC END# *555B2DEC002E_4742DCCE00DD_var*
begin
//#UC START# *555B2DEC002E_4742DCCE00DD_impl*
 inherited Create(aDB);
 f_ID := anID;
//#UC END# *555B2DEC002E_4742DCCE00DD_impl*
end;//Tm3DBDocument.Create

class function Tm3DBDocument.Make(aDB: Tm3PrimDB;
 anID: Integer): Im3DBDocument;
var
 l_Inst : Tm3DBDocument;
begin
 l_Inst := Create(aDB, anID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tm3DBDocument.Make

function Tm3DBDocument.pm_GetID: Integer;
//#UC START# *472084D802D5_4742DCCE00DDget_var*
//#UC END# *472084D802D5_4742DCCE00DDget_var*
begin
//#UC START# *472084D802D5_4742DCCE00DDget_impl*
 Result := f_ID;
//#UC END# *472084D802D5_4742DCCE00DDget_impl*
end;//Tm3DBDocument.pm_GetID

procedure Tm3DBDocument.Delete;
 {* Удаляет документ из хранилища. }
//#UC START# *472084FC00BA_4742DCCE00DD_var*
//#UC END# *472084FC00BA_4742DCCE00DD_var*
begin
//#UC START# *472084FC00BA_4742DCCE00DD_impl*
 if (f_DB <> nil) then
  with f_DB do
  begin
   Start(m3_saReadWrite);
   try
    ModifyDeleted(f_ID, true);
    //if ModifyDeleted(f_ID, true) then
    // ModifyModified(f_ID, false);
   finally
    Finish;
   end;//try..finally
  end;//with f_DB
//#UC END# *472084FC00BA_4742DCCE00DD_impl*
end;//Tm3DBDocument.Delete

function Tm3DBDocument.Undelete: Boolean;
 {* Восстанавливает документ. }
//#UC START# *47208516014E_4742DCCE00DD_var*
//#UC END# *47208516014E_4742DCCE00DD_var*
begin
//#UC START# *47208516014E_4742DCCE00DD_impl*
 if (f_DB = nil) then
  Result := false
 else
 begin
  with f_DB do
  begin
   Start(m3_saReadWrite);
   try
    ModifyDeleted(f_ID, false);
    Result := True;

    //Result := ModifyDeleted(f_ID, false);
    //if Result then
    // ModifyModified(f_ID, true);
   finally
    Finish;
   end;//try..finally
  end;//with f_DB
 end;//f_DB = nil
//#UC END# *47208516014E_4742DCCE00DD_impl*
end;//Tm3DBDocument.Undelete

function Tm3DBDocument.GetConst: Im3DBDocumentPart;
 {* Постоянная часть документа. }
//#UC START# *472085390162_4742DCCE00DD_var*
//#UC END# *472085390162_4742DCCE00DD_var*
begin
//#UC START# *472085390162_4742DCCE00DD_impl*
 Result := Tm3DBDocumentPart.Make(f_DB, Self, Cm3ConstVersion);
//#UC END# *472085390162_4742DCCE00DD_impl*
end;//Tm3DBDocument.GetConst

function Tm3DBDocument.GetVersion(aLevel: Integer = 0): Im3DBDocumentPart;
 {* Переменная часть документа. }
//#UC START# *4720856602B2_4742DCCE00DD_var*
//#UC END# *4720856602B2_4742DCCE00DD_var*
begin
//#UC START# *4720856602B2_4742DCCE00DD_impl*
 Result := Tm3DBDocumentPart.Make(f_DB, Self, aLevel);
//#UC END# *4720856602B2_4742DCCE00DD_impl*
end;//Tm3DBDocument.GetVersion

function Tm3DBDocument.Open(aMode: Tm3StoreAccess = m3_saRead;
 aDocPart: Tm3DocPartSelector = m3_defDocPart;
 aIndex: Integer = 0): IStream;
 {* открыть документ. }
//#UC START# *472085990020_4742DCCE00DD_var*
//#UC END# *472085990020_4742DCCE00DD_var*
begin
//#UC START# *472085990020_4742DCCE00DD_impl*
 Result := GetVersion.Open(aMode, aDocPart, aIndex);
 if (aMode = m3_saRead) AND (Result = nil) then
  Result := GetConst.Open(aMode, aDocPart, aIndex);
//#UC END# *472085990020_4742DCCE00DD_impl*
end;//Tm3DBDocument.Open

function Tm3DBDocument.GetFreeObjectID: Integer;
//#UC START# *486B7FD901A7_4742DCCE00DD_var*
var
 l_ExistID : Im3StorageElementIDList;
//#UC END# *486B7FD901A7_4742DCCE00DD_var*
begin
//#UC START# *486B7FD901A7_4742DCCE00DD_impl*
 Result := 0;
 l_ExistID := f_DB.GetDocumentObjectsIDs(f_ID);
 try
  while true do
  begin
   if (l_ExistID.IndexOf(Result) < 0) then
    Exit
   else
    Inc(Result);
  end;//while true
 finally
  l_ExistID := nil;
 end;//try..finally
//#UC END# *486B7FD901A7_4742DCCE00DD_impl*
end;//Tm3DBDocument.GetFreeObjectID

procedure Tm3DBDocument.DeleteObject(aObjID: Integer);
//#UC START# *486B7FE5002E_4742DCCE00DD_var*
var
 l_ObjStream: IStream;
//#UC END# *486B7FE5002E_4742DCCE00DD_var*
begin
//#UC START# *486B7FE5002E_4742DCCE00DD_impl*
 // Для удаления надо создать поток объекта с нулевой длиной
 l_ObjStream := Open(m3_saReadWrite, m3_dsObject, aObjID);
 l_ObjStream := nil;
//#UC END# *486B7FE5002E_4742DCCE00DD_impl*
end;//Tm3DBDocument.DeleteObject

end.
