unit fcDBCommon;

interface

uses db, dbtables, classes, typinfo;

Function fcGetControlDataSource(ctrl: TComponent): TDataSource;
Function fcGetControlMasterSource(ctrl: TComponent): TDataSource;
Function fcGetControlMasterDataSet(ctrl: TComponent): TDataSet;
Function fcSetDatabaseName(ctrl: TDataset; df: string): boolean;
Function fcGetDatabaseName(dataSet: TDataSet): String;
Function fcGetTableName(dataSet: TDataSet): String;
Function fcSetSQLProp(ctrl: TDataset; sql: TStrings): boolean;
Function fcSetParamsProp(ctrl: TDataset; Params: TParams): boolean;
Function fcGetParamsProp(ctrl: TDataset): TParams;

implementation

Function fcGetControlDataSource(ctrl: TComponent): TDataSource;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'DataSource');
   if PropInfo<>Nil then begin
      result:= TDataSource(GetOrdProp(ctrl, PropInfo));
   end
end;

Function fcGetControlMasterSource(ctrl: TComponent): TDataSource;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'MasterSource');
   if PropInfo<>Nil then begin
      result:= TDataSource(GetOrdProp(ctrl, PropInfo));
   end
end;

Function fcGetControlMasterDataSet(ctrl: TComponent): TDataSet;
var PropInfo: PPropInfo;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'Master');
   if PropInfo<>Nil then begin
      result:= TDataSet(GetOrdProp(ctrl, PropInfo));
   end
end;

Function fcSetSQLProp(ctrl: TDataset; sql: TStrings): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo,'SQL');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
   begin
      SetOrdProp(Ctrl,PropInfo,LongInt(sql));
      result:= True;
   end
end;

Function fcSetDatabaseName(ctrl: TDataset; df: string): boolean;
var PropInfo: PPropInfo;
begin
   Result:= False;
   PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo,'DatabaseName');
   {$IFDEF WIN32}
   if (PropInfo<>nil) and (PropInfo^.Proptype^.Kind = tklString) then begin
   {$ELSE}
   if (PropInfo<>nil) and (PropInfo^.PropType^.Kind = tkString) then begin
   {$ENDIF}
      SetStrProp(Ctrl,PropInfo,df);
      result:= True;
   end
end;

Function fcGetDatabaseName(dataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'DatabaseName');
   if PropInfo<>Nil then
      result:= GetStrProp(DataSet, PropInfo);
end;

Function fcGetTableName(dataSet: TDataSet): String;
var PropInfo: PPropInfo;
begin
   Result:= '';
   PropInfo:= Typinfo.GetPropInfo(DataSet.ClassInfo, 'TableName');
   if PropInfo<>Nil then
      result:= GetStrProp(DataSet, PropInfo);
//   if dataSet is TwwTable then result:= TwwTable(dataSet).tableName
//   else result:= '?';
end;

Function fcGetParamsProp(ctrl: TDataset): TParams;
var PropInfo: PPropInfo;
begin
   result:= nil;
   PropInfo:= Typinfo.GetPropINfo(ctrl.ClassInfo,'Params');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
      result:= TParams(GetOrdProp(Ctrl,PropInfo));
end;

Function fcSetParamsProp(ctrl: TDataset; Params: TParams): boolean;
var PropInfo: PPropInfo;
begin
   result:= False;
   PropInfo:= Typinfo.GetPropInfo(ctrl.ClassInfo,'Params');
   if (PropInfo <> nil) and (PropInfo^.Proptype^.Kind = tkClass) then
   begin
      fcGetParamsProp(ctrl).Assign(Params);
      result:= True;
   end;
end;


end.
