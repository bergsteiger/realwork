unit atAdapterTestCommandLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Runner/atAdapterTestCommandLine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Runner::TatAdapterTestCommandLine
//
// Для  разбора командной строки тестов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atCommandLine
  ;

const
  { CLP }
 CLP_LOGIN = 'login';
 CLP_PASSWORD = 'password';
 CLP_LOGFILENAME = 'log_file';
 CLP_SCENARIOFILENAME = 'scenario_file';

type
 TatAdapterTestCommandLine = class(TatCommandLine)
  {* Для  разбора командной строки тестов }
 protected
 // realized methods
   procedure InitParamList; override;
 end;//TatAdapterTestCommandLine

implementation

uses
  atCommandLineParameter
  ;

// start class TatAdapterTestCommandLine

procedure TatAdapterTestCommandLine.InitParamList;
//#UC START# *4808976C00AF_4AC347FD023D_var*
//#UC END# *4808976C00AF_4AC347FD023D_var*
begin
//#UC START# *4808976C00AF_4AC347FD023D_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create(clptString, CLP_LOGIN,            'user name') );
    Add( ParamType.Create(clptString, CLP_PASSWORD,         'user password', '') );
    Add( ParamType.Create(clptString, CLP_LOGFILENAME,      'log file name', '') );
    Add( ParamType.Create(clptString, CLP_SCENARIOFILENAME, 'scenario file name') );
  end;
//#UC END# *4808976C00AF_4AC347FD023D_impl*
end;//TatAdapterTestCommandLine.InitParamList

end.