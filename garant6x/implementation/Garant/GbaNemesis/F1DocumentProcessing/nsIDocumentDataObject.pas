unit nsIDocumentDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsIDocumentDataObject.pas"
// Начат: 2005/11/28 18:45:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsIDocumentDataObject
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
  nevTools,
  evHolderDataObject,
  nevBase,
  evdInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsIDocumentDataObject = class(TevHolderDataObject)
 private
 // private fields
   f_Document : IDocument;
 protected
 // overridden protected methods
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* сохраняет поток в G }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IDocument); reintroduce;
   class function Make(const aData: IDocument): InevStorable; reintroduce;
     {* Сигнатура фабрики TnsIDocumentDataObject.Make }
 end;//TnsIDocumentDataObject
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocumentToolsNew
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsIDocumentDataObject

constructor TnsIDocumentDataObject.Create(const aData: IDocument);
//#UC START# *4D3ED5BF0202_4B1FC0FC010E_var*
//#UC END# *4D3ED5BF0202_4B1FC0FC010E_var*
begin
//#UC START# *4D3ED5BF0202_4B1FC0FC010E_impl*
 inherited Create(nil);
 f_Document := aData;
//#UC END# *4D3ED5BF0202_4B1FC0FC010E_impl*
end;//TnsIDocumentDataObject.Create

class function TnsIDocumentDataObject.Make(const aData: IDocument): InevStorable;
var
 l_Inst : TnsIDocumentDataObject;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsIDocumentDataObject.DoStore(const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
//#UC START# *48EA34990191_4B1FC0FC010E_var*
//#UC END# *48EA34990191_4B1FC0FC010E_var*
begin
//#UC START# *48EA34990191_4B1FC0FC010E_impl*
 nsGetText(f_Document, f_Holder);
 try
  inherited;
 finally
  f_Holder := nil;
 end;//try..finally
//#UC END# *48EA34990191_4B1FC0FC010E_impl*
end;//TnsIDocumentDataObject.DoStore

procedure TnsIDocumentDataObject.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Document := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsIDocumentDataObject.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.