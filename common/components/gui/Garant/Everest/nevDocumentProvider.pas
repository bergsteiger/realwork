unit nevDocumentProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevDocumentProvider.pas"
// Начат: 13.10.2010 13:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Printing::TnevDocumentProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  afwInterfaces,
  nevTools,
  l3ProtoObject,
  l3Variant,
  nevBase,
  evdInterfaces
  ;

type
 TnevDocumentProvider = class(Tl3ProtoObject, InevDocumentProvider)
 private
 // private fields
   f_Storable : InevStorable;
 protected
 // property methods
   function pm_GetCanProvideOriginalDocument: Boolean; virtual;
   function pm_GetOriginalDocument: Tl3Variant; virtual;
   function pm_GetPageSetup: IafwPageSetup; virtual;
 protected
 // realized methods
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload; 
     {* сохраняет выделение в G. }
   function Get_CanProvideOriginalDocument: Boolean;
   function Get_PageSetup: IafwPageSetup;
   function Get_OriginalDocument: Tl3Variant;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aStorable: InevStorable); reintroduce;
   class function Make(const aStorable: InevStorable): InevDocumentProvider; reintroduce;
     {* Сигнатура фабрики TnevDocumentProvider.Make }
 protected
 // protected properties
   property CanProvideOriginalDocument: Boolean
     read pm_GetCanProvideOriginalDocument;
   property OriginalDocument: Tl3Variant
     read pm_GetOriginalDocument;
   property PageSetup: IafwPageSetup
     read pm_GetPageSetup;
 end;//TnevDocumentProvider

implementation

uses
  afwFacade,
  evPreviewForTestsTuning
  ;

// start class TnevDocumentProvider

constructor TnevDocumentProvider.Create(const aStorable: InevStorable);
//#UC START# *4CB57EB40216_4CB57E560195_var*
//#UC END# *4CB57EB40216_4CB57E560195_var*
begin
//#UC START# *4CB57EB40216_4CB57E560195_impl*
 Assert(aStorable <> nil);
 inherited Create;
 f_Storable := aStorable;
//#UC END# *4CB57EB40216_4CB57E560195_impl*
end;//TnevDocumentProvider.Create

class function TnevDocumentProvider.Make(const aStorable: InevStorable): InevDocumentProvider;
var
 l_Inst : TnevDocumentProvider;
begin
 l_Inst := Create(aStorable);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevDocumentProvider.pm_GetCanProvideOriginalDocument: Boolean;
//#UC START# *4CB589C80045_4CB57E560195get_var*
//#UC END# *4CB589C80045_4CB57E560195get_var*
begin
//#UC START# *4CB589C80045_4CB57E560195get_impl*
 Result := false;
//#UC END# *4CB589C80045_4CB57E560195get_impl*
end;//TnevDocumentProvider.pm_GetCanProvideOriginalDocument

function TnevDocumentProvider.pm_GetOriginalDocument: Tl3Variant;
//#UC START# *4CB589F902EA_4CB57E560195get_var*
//#UC END# *4CB589F902EA_4CB57E560195get_var*
begin
//#UC START# *4CB589F902EA_4CB57E560195get_impl*
 Result := nil;
//#UC END# *4CB589F902EA_4CB57E560195get_impl*
end;//TnevDocumentProvider.pm_GetOriginalDocument

function TnevDocumentProvider.pm_GetPageSetup: IafwPageSetup;
//#UC START# *4D18832500B4_4CB57E560195get_var*
//#UC END# *4D18832500B4_4CB57E560195get_var*
begin
//#UC START# *4D18832500B4_4CB57E560195get_impl*
 Result := nil;
//#UC END# *4D18832500B4_4CB57E560195get_impl*
end;//TnevDocumentProvider.pm_GetPageSetup

procedure TnevDocumentProvider.Store(const aView: InevView;
  const G: InevTagGenerator;
  aFlags: TevdStoreFlags = evDefaultStoreFlags);
//#UC START# *47C68BFD011C_4CB57E560195_var*
//#UC END# *47C68BFD011C_4CB57E560195_var*
begin
//#UC START# *47C68BFD011C_4CB57E560195_impl*
 f_Storable.Store(aView, G, aFlags);
//#UC END# *47C68BFD011C_4CB57E560195_impl*
end;//TnevDocumentProvider.Store

function TnevDocumentProvider.Get_CanProvideOriginalDocument: Boolean;
//#UC START# *4CB5897501F9_4CB57E560195get_var*
//#UC END# *4CB5897501F9_4CB57E560195get_var*
begin
//#UC START# *4CB5897501F9_4CB57E560195get_impl*
 Result := Self.CanProvideOriginalDocument;
//#UC END# *4CB5897501F9_4CB57E560195get_impl*
end;//TnevDocumentProvider.Get_CanProvideOriginalDocument

function TnevDocumentProvider.Get_PageSetup: IafwPageSetup;
//#UC START# *4D1882B00158_4CB57E560195get_var*
//#UC END# *4D1882B00158_4CB57E560195get_var*
begin
//#UC START# *4D1882B00158_4CB57E560195get_impl*
 Result := Self.PageSetup;
 if (Result = nil) then
  if (afw.Application <> nil) AND
     (afw.Application.PrintManager <> nil) then
   Result := afw.Application.PrintManager.PageSetup;  
//#UC END# *4D1882B00158_4CB57E560195get_impl*
end;//TnevDocumentProvider.Get_PageSetup

function TnevDocumentProvider.Get_OriginalDocument: Tl3Variant;
//#UC START# *5343C5D2028A_4CB57E560195get_var*
//#UC END# *5343C5D2028A_4CB57E560195get_var*
begin
//#UC START# *5343C5D2028A_4CB57E560195get_impl*
 Result := Self.OriginalDocument;
//#UC END# *5343C5D2028A_4CB57E560195get_impl*
end;//TnevDocumentProvider.Get_OriginalDocument

procedure TnevDocumentProvider.ClearFields;
 {-}
begin
 f_Storable := nil;
 inherited;
end;//TnevDocumentProvider.ClearFields

end.