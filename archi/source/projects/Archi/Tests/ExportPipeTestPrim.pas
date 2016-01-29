unit ExportPipeTestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SimpleTests"
// Модуль: "w:/archi/source/projects/Archi/Tests/ExportPipeTestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::SimpleTests::ExportPipeTests::ExportPipeTestPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  ,
  ExportPipe
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TExportPipeTestPrim = {abstract} class(TBaseTest)
 private
 // private fields
   f_Pipe : TExportPipe;
    {* Поле для свойства Pipe}
 private
 // private methods
   procedure FillDocSub;
     {* Формирование выборки для экспорта (она одна для всех потомков) }
 protected
 // property methods
   function pm_GetPipe: TExportPipe;
 protected
 // overridden protected methods
   procedure Cleanup; override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure TuneExportPipe; virtual; abstract;
     {* Процедура настройки трубы. Метод для перекрытия в потомках. }
 public
 // public properties
   property Pipe: TExportPipe
     read pm_GetPipe;
 published
 // published methods
   procedure DoExport;
     {* Собственно, экспорт }
 end;//TExportPipeTestPrim
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  SysUtils
  {$If not defined(Nemesis)}
  ,
  dtIntf
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Sab
  {$IfEnd} //not Nemesis
  ,
  dt_Const,
  dt_Types
  {$If not defined(Nemesis)}
  ,
  dt_Renum
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Doc
  {$IfEnd} //not Nemesis
  
  {$If defined(Archi) AND not defined(Nemesis)}
  ,
  dt_LinkServ
  {$IfEnd} //Archi AND not Nemesis
  ,
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TExportPipeTestPrim

procedure TExportPipeTestPrim.FillDocSub;
//#UC START# *55ED5FF503B2_55ED52510115_var*
var
 l_Sab: ISab;
 l_VF : IValueSetFiller;
 
 procedure AddNum(aNum: TDocID);
 begin
  l_VF.AddValue(aNum);
 end;
//#UC END# *55ED5FF503B2_55ED52510115_var*
begin
//#UC START# *55ED5FF503B2_55ED52510115_impl*
 l_Sab := MakeSab(LinkServer(CurrentFamily).Renum);
 l_VF := l_Sab.MakeValueSetFiller(rnImportID_fld);
 AddNum(10002801);
 AddNum(10005719);
 AddNum(2208298);
 AddNum(637196);
 AddNum(10001742);
 AddNum(637760);
 AddNum(10036025);
 AddNum(2205986);
 AddNum(2206451);
 AddNum(637228);
 AddNum(601769);
 AddNum(10005528);
 l_VF := nil;
 l_Sab.RecordsByKey;
 l_Sab.ValuesOfKey(rnRealID_fld);
 l_Sab.TransferToPhoto(fId_Fld, DocumentServer(CurrentFamily).FileTbl);
 Pipe.DocSab := l_Sab;
//#UC END# *55ED5FF503B2_55ED52510115_impl*
end;//TExportPipeTestPrim.FillDocSub

procedure TExportPipeTestPrim.DoExport;
//#UC START# *55EEA1AC0299_55ED52510115_var*
//#UC END# *55EEA1AC0299_55ED52510115_var*
begin
//#UC START# *55EEA1AC0299_55ED52510115_impl*
 // export goes here - to be implemented
//#UC END# *55EEA1AC0299_55ED52510115_impl*
end;//TExportPipeTestPrim.DoExport

function TExportPipeTestPrim.pm_GetPipe: TExportPipe;
//#UC START# *55ED54F10251_55ED52510115get_var*
//#UC END# *55ED54F10251_55ED52510115get_var*
begin
//#UC START# *55ED54F10251_55ED52510115get_impl*
 if f_Pipe = nil then
  f_Pipe := TExportPipe.Create;
 Result := f_Pipe; 
//#UC END# *55ED54F10251_55ED52510115get_impl*
end;//TExportPipeTestPrim.pm_GetPipe

procedure TExportPipeTestPrim.Cleanup;
//#UC START# *4B2F40FD0088_55ED52510115_var*
//#UC END# *4B2F40FD0088_55ED52510115_var*
begin
//#UC START# *4B2F40FD0088_55ED52510115_impl*
 FreeAndNil(f_Pipe);
 inherited;
//#UC END# *4B2F40FD0088_55ED52510115_impl*
end;//TExportPipeTestPrim.Cleanup

function TExportPipeTestPrim.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportPipeTestPrim.GetFolder

function TExportPipeTestPrim.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55ED52510115';
end;//TExportPipeTestPrim.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

end.