unit f1DocumentTagDataFromDTPHandle;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1DocumentTagDataFromDTPHandle.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , f1DocumentTagDataFromDTP
 , DocumentUnit
 , F1TagDataProviderInterface
 , k2Base
;

type
 Tf1DocumentTagDataFromDTPHandle = class(Tf1DocumentTagDataFromDTP)
  private
   f_Handle: Cardinal;
   f_Doc: IDocument;
  protected
   function pm_Getf_Provider: IDocumentTextProvider; override;
   function GetAllParaChildrenCount: Integer; override;
   function DoGetType: Tk2Type; override;
   procedure ClearFields; override;
  public
   constructor Create(aHandle: Cardinal;
    const aDoc: IDocument); reintroduce;
   class function Make(aHandle: Cardinal;
    const aDoc: IDocument): If1TagDataProvider; reintroduce;
 end;//Tf1DocumentTagDataFromDTPHandle

implementation

uses
 l3ImplUses
 , Document_Const
 , AutoreferatDocument_Const
;

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
end;//Tf1DocumentTagDataFromDTPHandle.Make

function Tf1DocumentTagDataFromDTPHandle.pm_Getf_Provider: IDocumentTextProvider;
//#UC START# *4C727B320016_4D66AE9800B7get_var*
//#UC END# *4C727B320016_4D66AE9800B7get_var*
begin
//#UC START# *4C727B320016_4D66AE9800B7get_impl*
 if (f_f_Provider = nil) then
  f_Doc.GetTextProviderByDesc(f_Handle, f_f_Provider);
 Result := f_f_Provider; 
//#UC END# *4C727B320016_4D66AE9800B7get_impl*
end;//Tf1DocumentTagDataFromDTPHandle.pm_Getf_Provider

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
begin
 f_Doc := nil;
 inherited;
end;//Tf1DocumentTagDataFromDTPHandle.ClearFields

end.
