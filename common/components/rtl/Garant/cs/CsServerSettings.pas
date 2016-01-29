unit CsServerSettings;

{ $Id: CsServerSettings.pas,v 1.3 2013/04/24 09:35:37 lulin Exp $ }

// $Log: CsServerSettings.pas,v $
// Revision 1.3  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.2  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 CsObject;

type
 TCsServerSettings = class(TCsObject)
 private
  f_ClientsLogFile: string;
 protected
  //procedure Cleanup; override;
 public
  //constructor Create;
  property ClientsLogFile: string read f_ClientsLogFile write f_ClientsLogFile;
 end;

implementation

end.

