unit f1DocumentTagDataFromDTP;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1DocumentTagDataFromDTP.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tf1DocumentTagDataFromDTP" MUID: (4C727C990284)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , f1TagDataFromDTP
 , F1TagDataProviderInterface
 , DocumentUnit
;

type
 Tf1DocumentTagDataFromDTP = class(Tf1ListTagDataFromDTPPrim)
  protected
   function GetChildID: TChildID; override;
   function GetParentLayerID: DTPLayerID; override;
  public
   class function Make(const aProvider: IDocumentTextProvider): If1TagDataProvider; reintroduce;
 end;//Tf1DocumentTagDataFromDTP

implementation

uses
 l3ImplUses
;

class function Tf1DocumentTagDataFromDTP.Make(const aProvider: IDocumentTextProvider): If1TagDataProvider;
var
 l_Inst : Tf1DocumentTagDataFromDTP;
begin
 l_Inst := Create(aProvider);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tf1DocumentTagDataFromDTP.Make

function Tf1DocumentTagDataFromDTP.GetChildID: TChildID;
//#UC START# *4C7281C90170_4C727C990284_var*
//#UC END# *4C7281C90170_4C727C990284_var*
begin
//#UC START# *4C7281C90170_4C727C990284_impl*
 Result := ROOT_CHILD;
//#UC END# *4C7281C90170_4C727C990284_impl*
end;//Tf1DocumentTagDataFromDTP.GetChildID

function Tf1DocumentTagDataFromDTP.GetParentLayerID: DTPLayerID;
//#UC START# *4C7289B80158_4C727C990284_var*
//#UC END# *4C7289B80158_4C727C990284_var*
begin
//#UC START# *4C7289B80158_4C727C990284_impl*
 Result := ROOT_LAYER;
//#UC END# *4C7289B80158_4C727C990284_impl*
end;//Tf1DocumentTagDataFromDTP.GetParentLayerID

end.
