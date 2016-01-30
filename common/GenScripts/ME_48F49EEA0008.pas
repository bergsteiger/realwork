unit evConstStringStorable;

// Модуль: "w:\common\components\gui\Garant\Everest\evConstStringStorable.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evStringStorable
 , evdInterfaces
 , nevTools
 , l3Interfaces
 , afwNavigation
;

type
 TevConstStringStorable = class(TevStringStorable)
  private
   f_Data: IevdHyperlinkInfo;
    {* Поле для свойства Data }
  protected
   function Text: Tl3WString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure GetAddress(var Addr: TevAddress); override;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IevdHyperlinkInfo;
    const aReader: InevTagReader); reintroduce;
   class function Make(const aData: IevdHyperlinkInfo;
    const aReader: InevTagReader): IevdDataObject; reintroduce;
  public
   property Data: IevdHyperlinkInfo
    read f_Data;
 end;//TevConstStringStorable

implementation

uses
 l3ImplUses
 , l3Base
 , l3String
;

constructor TevConstStringStorable.Create(const aData: IevdHyperlinkInfo;
 const aReader: InevTagReader);
//#UC START# *4CDD2A59034A_48F49EEA0008_var*
//#UC END# *4CDD2A59034A_48F49EEA0008_var*
begin
//#UC START# *4CDD2A59034A_48F49EEA0008_impl*
 inherited Create(aReader);
 f_Data := aData;
//#UC END# *4CDD2A59034A_48F49EEA0008_impl*
end;//TevConstStringStorable.Create

class function TevConstStringStorable.Make(const aData: IevdHyperlinkInfo;
 const aReader: InevTagReader): IevdDataObject;
var
 l_Inst : TevConstStringStorable;
begin
 l_Inst := Create(aData, aReader);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevConstStringStorable.Make

function TevConstStringStorable.Text: Tl3WString;
//#UC START# *48F494FD001D_48F49EEA0008_var*
//#UC END# *48F494FD001D_48F49EEA0008_var*
begin
//#UC START# *48F494FD001D_48F49EEA0008_impl*
 Result := l3PCharLen(Data.Text);
//#UC END# *48F494FD001D_48F49EEA0008_impl*
end;//TevConstStringStorable.Text

procedure TevConstStringStorable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F49EEA0008_var*
//#UC END# *479731C50290_48F49EEA0008_var*
begin
//#UC START# *479731C50290_48F49EEA0008_impl*
 inherited;
 f_Data := nil;
//#UC END# *479731C50290_48F49EEA0008_impl*
end;//TevConstStringStorable.Cleanup

procedure TevConstStringStorable.GetAddress(var Addr: TevAddress);
//#UC START# *48F494F102DD_48F49EEA0008_var*
//#UC END# *48F494F102DD_48F49EEA0008_var*
begin
//#UC START# *48F494F102DD_48F49EEA0008_impl*
 TevdAddress(Addr) := Data.Address;
//#UC END# *48F494F102DD_48F49EEA0008_impl*
end;//TevConstStringStorable.GetAddress

procedure TevConstStringStorable.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TevConstStringStorable.ClearFields

end.
