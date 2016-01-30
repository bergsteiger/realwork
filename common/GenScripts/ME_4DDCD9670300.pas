unit nsChangesBetweenEditionsInfo;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\nsChangesBetweenEditionsInfo.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , ChangesBetweenEditionsInterfaces
 , DocumentUnit
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_Parent_ = Tl3ProtoObject;
 {$Include afwApplicationDataUpdate.imp.pas}
 TnsChangesBetweenEditionsInfo = class(_afwApplicationDataUpdate_, InsChangesBetweenEditionsInfo)
  private
   f_DiffProvider: IDiffDocDataProvider;
   f_Right: IDocument;
   f_Left: IDocument;
  protected
   function Get_DiffProvider: IDiffDocDataProvider;
   function Get_RightEdition: IDocument;
   function Get_LeftEdition: IDocument;
   procedure FinishDataUpdate; override;
   procedure ClearFields; override;
  public
   constructor Create(const aLeft: IDocument;
    const aRight: IDocument;
    const aDiffProvider: IDiffDocDataProvider); reintroduce;
   class function Make(const aLeft: IDocument;
    const aRight: IDocument;
    const aDiffProvider: IDiffDocDataProvider): InsChangesBetweenEditionsInfo; reintroduce;
 end;//TnsChangesBetweenEditionsInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , afwFacade
;

{$Include afwApplicationDataUpdate.imp.pas}

constructor TnsChangesBetweenEditionsInfo.Create(const aLeft: IDocument;
 const aRight: IDocument;
 const aDiffProvider: IDiffDocDataProvider);
//#UC START# *4DDCDA030188_4DDCD9670300_var*
//#UC END# *4DDCDA030188_4DDCD9670300_var*
begin
//#UC START# *4DDCDA030188_4DDCD9670300_impl*
 inherited Create;
 f_Left := aLeft;
 f_Right := aRight;
 f_DiffProvider := aDiffProvider;
//#UC END# *4DDCDA030188_4DDCD9670300_impl*
end;//TnsChangesBetweenEditionsInfo.Create

class function TnsChangesBetweenEditionsInfo.Make(const aLeft: IDocument;
 const aRight: IDocument;
 const aDiffProvider: IDiffDocDataProvider): InsChangesBetweenEditionsInfo;
var
 l_Inst : TnsChangesBetweenEditionsInfo;
begin
 l_Inst := Create(aLeft, aRight, aDiffProvider);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsChangesBetweenEditionsInfo.Make

function TnsChangesBetweenEditionsInfo.Get_DiffProvider: IDiffDocDataProvider;
//#UC START# *4DDCD8ED00A5_4DDCD9670300get_var*
//#UC END# *4DDCD8ED00A5_4DDCD9670300get_var*
begin
//#UC START# *4DDCD8ED00A5_4DDCD9670300get_impl*
 if (f_DiffProvider = nil) then
  f_DiffProvider := DefDataAdapter.NativeAdapter.MakeDiffDocDataProvider(f_Left, f_Right);
 Assert(f_DiffProvider <> nil); 
 Result := f_DiffProvider;
//#UC END# *4DDCD8ED00A5_4DDCD9670300get_impl*
end;//TnsChangesBetweenEditionsInfo.Get_DiffProvider

function TnsChangesBetweenEditionsInfo.Get_RightEdition: IDocument;
//#UC START# *4DDCE9110130_4DDCD9670300get_var*
//#UC END# *4DDCE9110130_4DDCD9670300get_var*
begin
//#UC START# *4DDCE9110130_4DDCD9670300get_impl*
 Result := f_Right;
//#UC END# *4DDCE9110130_4DDCD9670300get_impl*
end;//TnsChangesBetweenEditionsInfo.Get_RightEdition

function TnsChangesBetweenEditionsInfo.Get_LeftEdition: IDocument;
//#UC START# *4F2BF187026F_4DDCD9670300get_var*
//#UC END# *4F2BF187026F_4DDCD9670300get_var*
begin
//#UC START# *4F2BF187026F_4DDCD9670300get_impl*
 Result := f_Left;
//#UC END# *4F2BF187026F_4DDCD9670300get_impl*
end;//TnsChangesBetweenEditionsInfo.Get_LeftEdition

procedure TnsChangesBetweenEditionsInfo.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4DDCD9670300_var*
//#UC END# *47EA4E9002C6_4DDCD9670300_var*
begin
//#UC START# *47EA4E9002C6_4DDCD9670300_impl*
 inherited;
 f_DiffProvider := nil;
//#UC END# *47EA4E9002C6_4DDCD9670300_impl*
end;//TnsChangesBetweenEditionsInfo.FinishDataUpdate

procedure TnsChangesBetweenEditionsInfo.ClearFields;
begin
 f_DiffProvider := nil;
 f_Right := nil;
 f_Left := nil;
 inherited;
end;//TnsChangesBetweenEditionsInfo.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
