unit atOperationFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/OperationsFramework/atOperationFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x_test::AdapterTest::OperationsFramework::atOperationFactory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SysUtils,
  atStringListWithOwn,
  atOperationBase
  ;

type
 EOperationNotRegistered = class(Exception)
 end;//EOperationNotRegistered

 TatOperationFactory = class(TObject)
 private
 // private fields
   f_Operations : TatStringListWithOwn;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create; reintroduce;
   procedure RegisterOperation(opClass: CTatOperationBase);
   function MakeOperation(const name: AnsiString): TatOperationBase;
 end;//TatOperationFactory

var OperationFactory : TatOperationFactory = nil;

implementation

type
 TatClassContainer = class(TObject)
 public
 // public fields
   F_OpClass : CTatOperationBase;
 public
 // public methods
   constructor Create(opClass: CTatOperationBase); reintroduce;
 end;//TatClassContainer

// start class TatClassContainer

constructor TatClassContainer.Create(opClass: CTatOperationBase);
//#UC START# *4808A92C0073_4808A8F6016B_var*
//#UC END# *4808A92C0073_4808A8F6016B_var*
begin
//#UC START# *4808A92C0073_4808A8F6016B_impl*
    inherited Create;
    F_OpClass := opClass;
//#UC END# *4808A92C0073_4808A8F6016B_impl*
end;//TatClassContainer.Create
// start class TatOperationFactory

constructor TatOperationFactory.Create;
//#UC START# *4808AA940289_4808AA270314_var*
//#UC END# *4808AA940289_4808AA270314_var*
begin
//#UC START# *4808AA940289_4808AA270314_impl*
    inherited;
    f_Operations := TatStringListWithOwn.Create(false);
//#UC END# *4808AA940289_4808AA270314_impl*
end;//TatOperationFactory.Create

procedure TatOperationFactory.RegisterOperation(opClass: CTatOperationBase);
//#UC START# *4808AAA60096_4808AA270314_var*
//#UC END# *4808AAA60096_4808AA270314_var*
begin
//#UC START# *4808AAA60096_4808AA270314_impl*
    f_Operations.AddObject(opClass.GetName, TatClassContainer.Create(opClass));
//#UC END# *4808AAA60096_4808AA270314_impl*
end;//TatOperationFactory.RegisterOperation

function TatOperationFactory.MakeOperation(const name: AnsiString): TatOperationBase;
//#UC START# *4808AABD0051_4808AA270314_var*
    var
      i : integer;
//#UC END# *4808AABD0051_4808AA270314_var*
begin
//#UC START# *4808AABD0051_4808AA270314_impl*
    i := f_Operations.IndexOf(name);
    if (i = -1) then
      Raise EOperationNotRegistered.CreateFmt('Операция с именем %s не зарегистирована!', [name]);

    Result := (f_Operations.Objects[i] as TatClassContainer).F_OpClass.Create;
//#UC END# *4808AABD0051_4808AA270314_impl*
end;//TatOperationFactory.MakeOperation

destructor TatOperationFactory.Destroy;
//#UC START# *48077504027E_4808AA270314_var*
//#UC END# *48077504027E_4808AA270314_var*
begin
//#UC START# *48077504027E_4808AA270314_impl*
    FreeAndNil(f_Operations);
    inherited;
//#UC END# *48077504027E_4808AA270314_impl*
end;//TatOperationFactory.Destroy

initialization
//#UC START# *4808AA000171*
  OperationFactory := TatOperationFactory.Create;
//#UC END# *4808AA000171*

finalization
//#UC START# *4808AA0E02AD*
  FreeAndNil(OperationFactory);
//#UC END# *4808AA0E02AD*

end.