unit nsAnnotationHeaderTagData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/nsAnnotationHeaderTagData.pas"
// Начат: 02.03.2011 12:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TnsAnnotationHeaderTagData
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
  l3CProtoObject,
  F1TagDataProviderInterface,
  l3Variant,
  IOUnit,
  l3Interfaces,
  k2Base,
  nevBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsAnnotationHeaderTagData = class(Tl3CProtoObject, If1TagDataProvider)
 private
 // private fields
   f_Doc : IDocument;
   f_Index : Integer;
   f_Anno : Tl3Tag;
 protected
 // realized methods
   function Get_Caption: IString;
   function Get_Style: IStream;
   function Get_ExternalID: Integer;
   function Get_TypeID: Tk2Type;
   procedure Set_WStyle(const aValue: IStream);
   function Get_AllParaChildrenCount: Integer;
   function Get_ChildrenCount: Integer;
   function Get_FirstChild: If1TagDataProvider;
   function Get_SiblingByIndex(anIndex: Integer): If1TagDataProvider;
   function Get_Next: If1TagDataProvider;
   function Get_AsDocumentTextProvider: IDocumentTextProvider;
   function Get_Comment: IStream;
   function Get_TechComment: IString;
   function Get_IsProviderGot: Boolean;
 public
 // realized methods
   procedure CreateNewNode(var theIndex: Integer;
    var theNode: Tl3Tag;
    const aMaker: If1ChildMaker;
    const anOp: InevOp);
   procedure BuildSubs(aProp: Tk2CustomProperty;
    const aChecker: If1AtomChecker);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(anIndex: Integer;
     const aDoc: IDocument;
     anAnno: Tl3Tag); reintroduce;
   class function Make(anIndex: Integer;
     const aDoc: IDocument;
     anAnno: Tl3Tag): If1TagDataProvider; reintroduce;
     {* Сигнатура фабрики TnsAnnotationHeaderTagData.Make }
 end;//TnsAnnotationHeaderTagData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Document_Const,
  k2Tags,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAnnotationHeaderTagData

constructor TnsAnnotationHeaderTagData.Create(anIndex: Integer;
  const aDoc: IDocument;
  anAnno: Tl3Tag);
//#UC START# *4D6E0DA7024B_4D6E0D500395_var*
//#UC END# *4D6E0DA7024B_4D6E0D500395_var*
begin
//#UC START# *4D6E0DA7024B_4D6E0D500395_impl*
 inherited Create;
 f_Index := anIndex;
 f_Doc := aDoc;
 anAnno.SetRef(f_Anno);
//#UC END# *4D6E0DA7024B_4D6E0D500395_impl*
end;//TnsAnnotationHeaderTagData.Create

class function TnsAnnotationHeaderTagData.Make(anIndex: Integer;
  const aDoc: IDocument;
  anAnno: Tl3Tag): If1TagDataProvider;
var
 l_Inst : TnsAnnotationHeaderTagData;
begin
 l_Inst := Create(anIndex, aDoc, anAnno);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsAnnotationHeaderTagData.Get_Caption: IString;
//#UC START# *4C6EA2B000F6_4D6E0D500395get_var*
//#UC END# *4C6EA2B000F6_4D6E0D500395get_var*
begin
//#UC START# *4C6EA2B000F6_4D6E0D500395get_impl*
 Result := nil;
//#UC END# *4C6EA2B000F6_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_Caption

function TnsAnnotationHeaderTagData.Get_Style: IStream;
//#UC START# *4C6EA2D1023E_4D6E0D500395get_var*
//#UC END# *4C6EA2D1023E_4D6E0D500395get_var*
begin
//#UC START# *4C6EA2D1023E_4D6E0D500395get_impl*
 f_Doc.GetAnnotationHeaderEvd(f_Index, Result);
 f_Doc := nil;
//#UC END# *4C6EA2D1023E_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_Style

function TnsAnnotationHeaderTagData.Get_ExternalID: Integer;
//#UC START# *4C6EA2F700DA_4D6E0D500395get_var*
//#UC END# *4C6EA2F700DA_4D6E0D500395get_var*
begin
//#UC START# *4C6EA2F700DA_4D6E0D500395get_impl*
 Result := f_Anno.IntA[k2_tiExternalHandle];
//#UC END# *4C6EA2F700DA_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_ExternalID

function TnsAnnotationHeaderTagData.Get_TypeID: Tk2Type;
//#UC START# *4C6EA8390114_4D6E0D500395get_var*
//#UC END# *4C6EA8390114_4D6E0D500395get_var*
begin
//#UC START# *4C6EA8390114_4D6E0D500395get_impl*
 Result := k2_typDocument;
//#UC END# *4C6EA8390114_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_TypeID

procedure TnsAnnotationHeaderTagData.Set_WStyle(const aValue: IStream);
//#UC START# *4C6EAB57003B_4D6E0D500395set_var*
//#UC END# *4C6EAB57003B_4D6E0D500395set_var*
begin
//#UC START# *4C6EAB57003B_4D6E0D500395set_impl*
 Assert(false);
//#UC END# *4C6EAB57003B_4D6E0D500395set_impl*
end;//TnsAnnotationHeaderTagData.Set_WStyle

function TnsAnnotationHeaderTagData.Get_AllParaChildrenCount: Integer;
//#UC START# *4C6EB42D017A_4D6E0D500395get_var*
//#UC END# *4C6EB42D017A_4D6E0D500395get_var*
begin
//#UC START# *4C6EB42D017A_4D6E0D500395get_impl*
 Result := 0;
 Assert(false);
//#UC END# *4C6EB42D017A_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_AllParaChildrenCount

function TnsAnnotationHeaderTagData.Get_ChildrenCount: Integer;
//#UC START# *4C6EB4470246_4D6E0D500395get_var*
//#UC END# *4C6EB4470246_4D6E0D500395get_var*
begin
//#UC START# *4C6EB4470246_4D6E0D500395get_impl*
 Result := 0;
 Assert(false);
//#UC END# *4C6EB4470246_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_ChildrenCount

procedure TnsAnnotationHeaderTagData.CreateNewNode(var theIndex: Integer;
  var theNode: Tl3Tag;
  const aMaker: If1ChildMaker;
  const anOp: InevOp);
//#UC START# *4C6EB48D0004_4D6E0D500395_var*
//#UC END# *4C6EB48D0004_4D6E0D500395_var*
begin
//#UC START# *4C6EB48D0004_4D6E0D500395_impl*
 // - ничего не делаем, всё уже сделано за нас
 if theNode.IsKindOf(k2_typDocument) then
  theNode.IntA[k2_tiExternalHandle] := 0;
  // - так как оказалось, что там вложенный документ
//#UC END# *4C6EB48D0004_4D6E0D500395_impl*
end;//TnsAnnotationHeaderTagData.CreateNewNode

function TnsAnnotationHeaderTagData.Get_FirstChild: If1TagDataProvider;
//#UC START# *4C6EB4E70277_4D6E0D500395get_var*
//#UC END# *4C6EB4E70277_4D6E0D500395get_var*
begin
//#UC START# *4C6EB4E70277_4D6E0D500395get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C6EB4E70277_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_FirstChild

procedure TnsAnnotationHeaderTagData.BuildSubs(aProp: Tk2CustomProperty;
  const aChecker: If1AtomChecker);
//#UC START# *4C722FCA0397_4D6E0D500395_var*
//#UC END# *4C722FCA0397_4D6E0D500395_var*
begin
//#UC START# *4C722FCA0397_4D6E0D500395_impl*
 Assert(false);
//#UC END# *4C722FCA0397_4D6E0D500395_impl*
end;//TnsAnnotationHeaderTagData.BuildSubs

function TnsAnnotationHeaderTagData.Get_SiblingByIndex(anIndex: Integer): If1TagDataProvider;
//#UC START# *4C723CF1024D_4D6E0D500395get_var*
//#UC END# *4C723CF1024D_4D6E0D500395get_var*
begin
//#UC START# *4C723CF1024D_4D6E0D500395get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C723CF1024D_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_SiblingByIndex

function TnsAnnotationHeaderTagData.Get_Next: If1TagDataProvider;
//#UC START# *4C7240410220_4D6E0D500395get_var*
//#UC END# *4C7240410220_4D6E0D500395get_var*
begin
//#UC START# *4C7240410220_4D6E0D500395get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C7240410220_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_Next

function TnsAnnotationHeaderTagData.Get_AsDocumentTextProvider: IDocumentTextProvider;
//#UC START# *4C99D2C600BC_4D6E0D500395get_var*
//#UC END# *4C99D2C600BC_4D6E0D500395get_var*
begin
//#UC START# *4C99D2C600BC_4D6E0D500395get_impl*
 Result := nil;
 //Assert(false);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=255981614
//#UC END# *4C99D2C600BC_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_AsDocumentTextProvider

function TnsAnnotationHeaderTagData.Get_Comment: IStream;
//#UC START# *4CEFAFB700D1_4D6E0D500395get_var*
//#UC END# *4CEFAFB700D1_4D6E0D500395get_var*
begin
//#UC START# *4CEFAFB700D1_4D6E0D500395get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4CEFAFB700D1_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_Comment

function TnsAnnotationHeaderTagData.Get_TechComment: IString;
//#UC START# *4D0F4C9E0379_4D6E0D500395get_var*
//#UC END# *4D0F4C9E0379_4D6E0D500395get_var*
begin
//#UC START# *4D0F4C9E0379_4D6E0D500395get_impl*
 Result := nil;
 Assert(false);
//#UC END# *4D0F4C9E0379_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_TechComment

function TnsAnnotationHeaderTagData.Get_IsProviderGot: Boolean;
//#UC START# *4D6E5C270068_4D6E0D500395get_var*
//#UC END# *4D6E5C270068_4D6E0D500395get_var*
begin
//#UC START# *4D6E5C270068_4D6E0D500395get_impl*
 Result := (f_Doc = nil);
//#UC END# *4D6E5C270068_4D6E0D500395get_impl*
end;//TnsAnnotationHeaderTagData.Get_IsProviderGot

procedure TnsAnnotationHeaderTagData.Cleanup;
//#UC START# *479731C50290_4D6E0D500395_var*
//#UC END# *479731C50290_4D6E0D500395_var*
begin
//#UC START# *479731C50290_4D6E0D500395_impl*
 FreeAndNil(f_Anno);
 inherited;
//#UC END# *479731C50290_4D6E0D500395_impl*
end;//TnsAnnotationHeaderTagData.Cleanup

procedure TnsAnnotationHeaderTagData.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Doc := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsAnnotationHeaderTagData.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.