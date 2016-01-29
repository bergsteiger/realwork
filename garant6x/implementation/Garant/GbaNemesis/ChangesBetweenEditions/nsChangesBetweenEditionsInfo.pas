unit nsChangesBetweenEditionsInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChangesBetweenEditions$Domain"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/ChangesBetweenEditions/nsChangesBetweenEditionsInfo.pas"
// Начат: 25.05.2011 14:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::ChangesBetweenEditions$Domain::ChangesBetweenEditionsImplementation::TnsChangesBetweenEditionsInfo
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
  l3ProtoObject,
  ChangesBetweenEditionsInterfaces,
  afwInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _afwApplicationDataUpdate_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsChangesBetweenEditionsInfo = class(_afwApplicationDataUpdate_, InsChangesBetweenEditionsInfo)
 private
 // private fields
   f_DiffProvider : IDiffDocDataProvider;
   f_Right : IDocument;
   f_Left : IDocument;
 protected
 // realized methods
   function Get_DiffProvider: IDiffDocDataProvider;
   function Get_RightEdition: IDocument;
   function Get_LeftEdition: IDocument;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aLeft: IDocument;
     const aRight: IDocument;
     const aDiffProvider: IDiffDocDataProvider); reintroduce;
   class function Make(const aLeft: IDocument;
     const aRight: IDocument;
     const aDiffProvider: IDiffDocDataProvider): InsChangesBetweenEditionsInfo; reintroduce;
     {* Сигнатура фабрики TnsChangesBetweenEditionsInfo.Make }
 end;//TnsChangesBetweenEditionsInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsChangesBetweenEditionsInfo

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
end;

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_DiffProvider := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Right := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Left := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsChangesBetweenEditionsInfo.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.