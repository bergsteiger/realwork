unit arCustomMultiOperationHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arCustomMultiOperationHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarCustomMultiOperationHelper" MUID: (57ED151F00AA)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
;

type
 TarCustomMultiOperationHelper = class(Tl3ProtoObject)
  private
   f_Operation: TarMultiOperation;
   f_DocsList: ISab;
   f_FamilyID: TdaFamilyID;
  protected
   procedure ClearFields; override;
  public
   constructor Create(aFamilyID: TdaFamilyID;
    anOperation: TarMultiOperation;
    const aDocsList: ISab); reintroduce;
   procedure ModifyDocs; virtual; abstract;
  protected
   property Operation: TarMultiOperation
    read f_Operation;
   property DocsList: ISab
    read f_DocsList;
   property FamilyID: TdaFamilyID
    read f_FamilyID;
 end;//TarCustomMultiOperationHelper

implementation

uses
 l3ImplUses
 //#UC START# *57ED151F00AAimpl_uses*
 //#UC END# *57ED151F00AAimpl_uses*
;

constructor TarCustomMultiOperationHelper.Create(aFamilyID: TdaFamilyID;
 anOperation: TarMultiOperation;
 const aDocsList: ISab);
//#UC START# *57ED15530391_57ED151F00AA_var*
//#UC END# *57ED15530391_57ED151F00AA_var*
begin
//#UC START# *57ED15530391_57ED151F00AA_impl*
 inherited Create;
 f_Operation := anOperation;
 f_DocsList := aDocsList;
 f_FamilyID := aFamilyID;
//#UC END# *57ED15530391_57ED151F00AA_impl*
end;//TarCustomMultiOperationHelper.Create

procedure TarCustomMultiOperationHelper.ClearFields;
begin
 f_DocsList := nil;
 inherited;
end;//TarCustomMultiOperationHelper.ClearFields

end.
