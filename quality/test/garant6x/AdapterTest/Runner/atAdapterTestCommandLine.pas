unit atAdapterTestCommandLine;
 {* Для  разбора командной строки тестов }

// Модуль: "w:\quality\test\garant6x\AdapterTest\Runner\atAdapterTestCommandLine.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatAdapterTestCommandLine" MUID: (4AC347FD023D)

interface

uses
 l3IntfUses
 , atCommandLine
;

const
 CLP_LOGIN = 'login';
 CLP_PASSWORD = 'password';
 CLP_LOGFILENAME = 'log_file';
 CLP_SCENARIOFILENAME = 'scenario_file';

type
 TatAdapterTestCommandLine = class(TatCommandLine)
  {* Для  разбора командной строки тестов }
  protected
   procedure InitParamList; override;
 end;//TatAdapterTestCommandLine

implementation

uses
 l3ImplUses
 , atCommandLineParameter
 //#UC START# *4AC347FD023Dimpl_uses*
 //#UC END# *4AC347FD023Dimpl_uses*
;

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
