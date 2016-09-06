unit msmOperation;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOperation" MUID: (57CEB1C1010D)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmOperations
 , msmModels
;

type
 TmsmOperation = {abstract} class(Tl3ProtoObject, ImsmOperation)
  private
   f_Caption: AnsiString;
   f_Model: ImsmModel;
  protected
   function GetCaption: AnsiString; virtual;
   procedure DoDoIt; virtual; abstract;
   function Caption: AnsiString;
   procedure DoIt;
   procedure ClearFields; override;
  public
   constructor Create(const aCaption: AnsiString;
    const aModel: ImsmModel); reintroduce;
   class function Make(const aCaption: AnsiString;
    const aModel: ImsmModel): ImsmOperation; reintroduce;
  protected
   property Model: ImsmModel
    read f_Model;
 end;//TmsmOperation

implementation

uses
 l3ImplUses
 //#UC START# *57CEB1C1010Dimpl_uses*
 //#UC END# *57CEB1C1010Dimpl_uses*
;

function TmsmOperation.GetCaption: AnsiString;
//#UC START# *57CEB1E803C0_57CEB1C1010D_var*
//#UC END# *57CEB1E803C0_57CEB1C1010D_var*
begin
//#UC START# *57CEB1E803C0_57CEB1C1010D_impl*
 Result := f_Caption;
//#UC END# *57CEB1E803C0_57CEB1C1010D_impl*
end;//TmsmOperation.GetCaption

constructor TmsmOperation.Create(const aCaption: AnsiString;
 const aModel: ImsmModel);
//#UC START# *57CEB3750096_57CEB1C1010D_var*
//#UC END# *57CEB3750096_57CEB1C1010D_var*
begin
//#UC START# *57CEB3750096_57CEB1C1010D_impl*
 f_Caption := aCaption;
 f_Model := aModel;
 inherited Create;
//#UC END# *57CEB3750096_57CEB1C1010D_impl*
end;//TmsmOperation.Create

class function TmsmOperation.Make(const aCaption: AnsiString;
 const aModel: ImsmModel): ImsmOperation;
var
 l_Inst : TmsmOperation;
begin
 l_Inst := Create(aCaption, aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmOperation.Make

function TmsmOperation.Caption: AnsiString;
//#UC START# *57CEACFF03A3_57CEB1C1010D_var*
//#UC END# *57CEACFF03A3_57CEB1C1010D_var*
begin
//#UC START# *57CEACFF03A3_57CEB1C1010D_impl*
 Result := GetCaption;
//#UC END# *57CEACFF03A3_57CEB1C1010D_impl*
end;//TmsmOperation.Caption

procedure TmsmOperation.DoIt;
//#UC START# *57CEAD1C0068_57CEB1C1010D_var*
//#UC END# *57CEAD1C0068_57CEB1C1010D_var*
begin
//#UC START# *57CEAD1C0068_57CEB1C1010D_impl*
 DoDoIt;
//#UC END# *57CEAD1C0068_57CEB1C1010D_impl*
end;//TmsmOperation.DoIt

procedure TmsmOperation.ClearFields;
begin
 f_Caption := '';
 f_Model := nil;
 inherited;
end;//TmsmOperation.ClearFields

end.
