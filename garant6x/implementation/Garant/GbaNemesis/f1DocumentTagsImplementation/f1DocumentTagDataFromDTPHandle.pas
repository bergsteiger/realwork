unit f1DocumentTagDataFromDTPHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1DocumentTagDataFromDTPHandle.pas"
// Начат: 24.02.2011 22:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::Tf1DocumentTagDataFromDTPHandle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DocumentUnit,
  F1TagDataProviderInterface,
  f1DocumentTagDataFromDTP,
  IOUnit,
  l3Interfaces,
  k2Base,
  nevBase,
  l3Variant
  ;

type
 Tf1DocumentTagDataFromDTPHandle = class(Tf1DocumentTagDataFromDTP)
 private
 // private fields
   f_Handle : Cardinal;
   f_Doc : IDocument;
 protected
 // overridden property methods
   function pm_GetFProvider: IDocumentTextProvider; override;
 protected
 // overridden protected methods
   function GetAllParaChildrenCount: Integer; override;
   function DoGetType: Tk2Type; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(aHandle: Cardinal;
     const aDoc: IDocument); reintroduce;
   class function Make(aHandle: Cardinal;
     const aDoc: IDocument): If1TagDataProvider; reintroduce;
     {* Сигнатура фабрики Tf1DocumentTagDataFromDTPHandle.Make }
 end;//Tf1DocumentTagDataFromDTPHandle

implementation

uses
  Document_Const,
  AutoreferatDocument_Const,
  k2Facade
  ;

// start class Tf1DocumentTagDataFromDTPHandle

constructor Tf1DocumentTagDataFromDTPHandle.Create(aHandle: Cardinal;
  const aDoc: IDocument);
//#UC START# *4D66AF7A025A_4D66AE9800B7_var*
//#UC END# *4D66AF7A025A_4D66AE9800B7_var*
begin
//#UC START# *4D66AF7A025A_4D66AE9800B7_impl*
 inherited Create(nil);
 f_Handle := aHandle;
 f_Doc := aDoc; 
//#UC END# *4D66AF7A025A_4D66AE9800B7_impl*
end;//Tf1DocumentTagDataFromDTPHandle.Create

class function Tf1DocumentTagDataFromDTPHandle.Make(aHandle: Cardinal;
  const aDoc: IDocument): If1TagDataProvider;
var
 l_Inst : Tf1DocumentTagDataFromDTPHandle;
begin
 l_Inst := Create(aHandle, aDoc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function Tf1DocumentTagDataFromDTPHandle.pm_GetFProvider: IDocumentTextProvider;
//#UC START# *4C727B320016_4D66AE9800B7get_var*
//#UC END# *4C727B320016_4D66AE9800B7get_var*
begin
//#UC START# *4C727B320016_4D66AE9800B7get_impl*
 if (f_f_Provider = nil) then
  f_Doc.GetTextProviderByDesc(f_Handle, f_f_Provider);
 Result := f_f_Provider; 
//#UC END# *4C727B320016_4D66AE9800B7get_impl*
end;//Tf1DocumentTagDataFromDTPHandle.pm_GetFProvider

function Tf1DocumentTagDataFromDTPHandle.GetAllParaChildrenCount: Integer;
//#UC START# *4C7294F40339_4D66AE9800B7_var*
//#UC END# *4C7294F40339_4D66AE9800B7_var*
begin
//#UC START# *4C7294F40339_4D66AE9800B7_impl*
 Result := inherited GetAllParaChildrenCount;
 Assert(false, 'Значение GetAllParaChildrenCount уже должно быть известно для документа автореферата');
//#UC END# *4C7294F40339_4D66AE9800B7_impl*
end;//Tf1DocumentTagDataFromDTPHandle.GetAllParaChildrenCount

function Tf1DocumentTagDataFromDTPHandle.DoGetType: Tk2Type;
//#UC START# *4D66B40B02C4_4D66AE9800B7_var*
//#UC END# *4D66B40B02C4_4D66AE9800B7_var*
begin
//#UC START# *4D66B40B02C4_4D66AE9800B7_impl*
 Result := k2_typAutoreferatDocument;
//#UC END# *4D66B40B02C4_4D66AE9800B7_impl*
end;//Tf1DocumentTagDataFromDTPHandle.DoGetType

procedure Tf1DocumentTagDataFromDTPHandle.ClearFields;
 {-}
begin
 f_Doc := nil;
 inherited;
end;//Tf1DocumentTagDataFromDTPHandle.ClearFields

end.