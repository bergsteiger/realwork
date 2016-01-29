unit nsCompareEditionsInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/nsCompareEditionsInfo.pas"
// Начат: 04.08.2009 19:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::CommonObjects::TnsCompareEditionsInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  eeInterfaces,
  EditionsInterfaces,
  nsCompareEditionsInfoPrim,
  bsTypesNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsCompareEditionsInfo = class(TnsCompareEditionsInfoPrim, InsCompareEditionsInfo)
 private
 // private fields
   f_EditionForCompare : Integer;
   f_Position : TbsDocPos;
 protected
 // realized methods
   function Get_State: IDocumentState;
   function Get_EditionForCompare: TRedactionID;
   procedure Set_EditionForCompare(aValue: TRedactionID);
   function Get_Position: TbsDocPos;
 public
 // public methods
   constructor Create(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     aEditionForCompare: Integer;
     const aDocumentForReturn: TnsDocumentForReturnInfo); reintroduce; overload; 
   class function Make(const aDoc: IDocument;
     const aPara: IeeLeafPara;
     aEditionForCompare: Integer;
     const aDocumentForReturn: TnsDocumentForReturnInfo): InsCompareEditionsInfo; reintroduce; overload; 
     {* Сигнатура фабрики TnsCompareEditionsInfo.Make }
   constructor Create(const aDoc: IDocument;
     const aPosition: TbsDocPos;
     aEditionForCompare: Integer;
     const aDocumentForReturn: TnsDocumentForReturnInfo); overload; 
   class function Make(const aDoc: IDocument;
     const aPosition: TbsDocPos;
     aEditionForCompare: Integer;
     const aDocumentForReturn: TnsDocumentForReturnInfo): InsCompareEditionsInfo; reintroduce; overload; 
     {* Сигнатура фабрики TnsCompareEditionsInfo.Make$1 }
 end;//TnsCompareEditionsInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsCompareEditionsInfo

constructor TnsCompareEditionsInfo.Create(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  aEditionForCompare: Integer;
  const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *4B6BD88A03B2_4A78506900E2_var*
var
 l_State : IDocumentState;
//#UC END# *4B6BD88A03B2_4A78506900E2_var*
begin
//#UC START# *4B6BD88A03B2_4A78506900E2_impl*
 inherited Create(aDoc, aPara, aDocumentForReturn);
 if (aEditionForCompare = -1) then
 begin
  Get_State.Clone(l_State);
  l_State.SetPrevActiveRedaction;
  f_EditionForCompare := l_State.Redaction;
 end//aEditionForCompare = -1
 else
  f_EditionForCompare := aEditionForCompare;
//#UC END# *4B6BD88A03B2_4A78506900E2_impl*
end;//TnsCompareEditionsInfo.Create

class function TnsCompareEditionsInfo.Make(const aDoc: IDocument;
  const aPara: IeeLeafPara;
  aEditionForCompare: Integer;
  const aDocumentForReturn: TnsDocumentForReturnInfo): InsCompareEditionsInfo;
var
 l_Inst : TnsCompareEditionsInfo;
begin
 l_Inst := Create(aDoc, aPara, aEditionForCompare, aDocumentForReturn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TnsCompareEditionsInfo.Create(const aDoc: IDocument;
  const aPosition: TbsDocPos;
  aEditionForCompare: Integer;
  const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *5214BEB10136_4A78506900E2_var*
var
 l_Para: IeeLeafPara;
//#UC END# *5214BEB10136_4A78506900E2_var*
begin
//#UC START# *5214BEB10136_4A78506900E2_impl*
 l_Para := nil;
 Create(aDoc, l_Para, aEditionForCompare, aDocumentForReturn);
 f_Position := aPosition;
//#UC END# *5214BEB10136_4A78506900E2_impl*
end;//TnsCompareEditionsInfo.Create

class function TnsCompareEditionsInfo.Make(const aDoc: IDocument;
  const aPosition: TbsDocPos;
  aEditionForCompare: Integer;
  const aDocumentForReturn: TnsDocumentForReturnInfo): InsCompareEditionsInfo;
var
 l_Inst : TnsCompareEditionsInfo;
begin
 l_Inst := Create(aDoc, aPosition, aEditionForCompare, aDocumentForReturn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsCompareEditionsInfo.Get_State: IDocumentState;
//#UC START# *4A784CF30229_4A78506900E2get_var*
//#UC END# *4A784CF30229_4A78506900E2get_var*
begin
//#UC START# *4A784CF30229_4A78506900E2get_impl*
 f_Doc.GetCurrentState(Result);
 Assert(Result <> nil);
//#UC END# *4A784CF30229_4A78506900E2get_impl*
end;//TnsCompareEditionsInfo.Get_State

function TnsCompareEditionsInfo.Get_EditionForCompare: TRedactionID;
//#UC START# *4B6BD5E001F4_4A78506900E2get_var*
//#UC END# *4B6BD5E001F4_4A78506900E2get_var*
begin
//#UC START# *4B6BD5E001F4_4A78506900E2get_impl*
 Result := f_EditionForCompare;
//#UC END# *4B6BD5E001F4_4A78506900E2get_impl*
end;//TnsCompareEditionsInfo.Get_EditionForCompare

procedure TnsCompareEditionsInfo.Set_EditionForCompare(aValue: TRedactionID);
//#UC START# *4B6BD5E001F4_4A78506900E2set_var*
//#UC END# *4B6BD5E001F4_4A78506900E2set_var*
begin
//#UC START# *4B6BD5E001F4_4A78506900E2set_impl*
 Assert(false);
//#UC END# *4B6BD5E001F4_4A78506900E2set_impl*
end;//TnsCompareEditionsInfo.Set_EditionForCompare

function TnsCompareEditionsInfo.Get_Position: TbsDocPos;
//#UC START# *5214A243027F_4A78506900E2get_var*
//#UC END# *5214A243027F_4A78506900E2get_var*
begin
//#UC START# *5214A243027F_4A78506900E2get_impl*
 Result := f_Position;
//#UC END# *5214A243027F_4A78506900E2get_impl*
end;//TnsCompareEditionsInfo.Get_Position

{$IfEnd} //not Admin AND not Monitorings

end.