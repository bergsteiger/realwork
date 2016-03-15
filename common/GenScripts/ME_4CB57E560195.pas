unit nevDocumentProvider;

// Модуль: "w:\common\components\gui\Garant\Everest\nevDocumentProvider.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
 , l3Variant
 , afwInterfaces
 , nevBase
 , evdInterfaces
;

type
 TnevDocumentProvider = class(Tl3ProtoObject, InevDocumentProvider)
  private
   f_Storable: InevStorable;
  protected
   function pm_GetCanProvideOriginalDocument: Boolean; virtual;
   function pm_GetOriginalDocument: Tl3Variant; virtual;
   function pm_GetPageSetup: IafwPageSetup; virtual;
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evdInterfaces.evDefaultStoreFlags); overload;
    {* сохраняет выделение в G. }
   function Get_CanProvideOriginalDocument: Boolean;
   function Get_PageSetup: IafwPageSetup;
   function Get_OriginalDocument: Tl3Variant;
   procedure ClearFields; override;
  public
   constructor Create(const aStorable: InevStorable); reintroduce;
   class function Make(const aStorable: InevStorable): InevDocumentProvider; reintroduce;
  protected
   property CanProvideOriginalDocument: Boolean
    read pm_GetCanProvideOriginalDocument;
   property OriginalDocument: Tl3Variant
    read pm_GetOriginalDocument;
   property PageSetup: IafwPageSetup
    read pm_GetPageSetup;
 end;//TnevDocumentProvider

implementation

uses
 l3ImplUses
 , afwFacade
 , evPreviewForTestsTuning
;

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
end;//TnevDocumentProvider.Make

procedure TnevDocumentProvider.Store(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags = evdInterfaces.evDefaultStoreFlags);
 {* сохраняет выделение в G. }
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
begin
 f_Storable := nil;
 inherited;
end;//TnevDocumentProvider.ClearFields

end.
