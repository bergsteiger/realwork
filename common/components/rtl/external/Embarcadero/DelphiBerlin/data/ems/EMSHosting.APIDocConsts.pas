{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.APIDocConsts;

interface

resourcestring
  sResponseBadRequest = 'Bad Request';
  sResponseOK = 'OK';
  sResponseNoContent = 'No Content';
  sResponseNotFound = 'Not Found';
  sResponseUnexpextedRequestBody = 'Unexpexted Request Body';

//User Resource
  sResponseUserCreated = 'User Created';
  sResponseUserExist = 'User already exists';
  sResponseWrongCredentials = 'The credentials of the request are not authorized for the requested operation.';
  sResponseUserNotFound = 'User not found';
  sResponseOpNotCompleted = 'Operation could not be completed because one or more dynamic names conflicts with a static name.';
  sResponseRequestNotIdentify = 'The request does not identify a known application, resource, endpoint, or entity';

  sGetUserSummaryTitle = 'Get User';
  sGetUserSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from a `User`. **id** is the unique EMS User identifier (UID) in the EMS database.';

  sGetUsersSummaryTitle = 'Get Users';
  sGetUsersSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from `Users`.' + slineBreak +
      '    Optional query param of **skip, limit, order, where** determines ' + slineBreak +
      '    size of returned array, filtered and order by.';

  sGetUserFieldsSummaryTitle = 'Get Fields';
  sGetUserFieldsSummaryDesc = ' |' + slineBreak + '    Used to retrieve all the `field names` of the EMS Users (including the custom fields).';

  sGetUserGroupsSummaryTitle = 'Get User Groups';
  sGetUserGroupsSummaryDesc = ' |' + slineBreak + '    Used to retrieve the EMS Groups the EMS User belongs to. **id** is the unique EMS User identifier (UID) in the EMS database.';

  sUserSignUpSummaryTitle = 'Sign Up  User';
  sUserSignUpSummaryDesc = ' |' + slineBreak + '    Signs up to the EMS Server with an appropriate EMS User.';

  sPostLoginSummaryTitle = 'Log In';
  sPostLoginSummaryDesc = ' |' + slineBreak + '    Logs in to the EMS Server with a specific EMS User.';

  sPostUserSummaryTitle = 'Add User';
  sPostUserSummaryDesc = ' |' + slineBreak + '    Used to add a new `User` object to the EMS database.';

  sPutUserSummaryTitle = 'Update User';
  sPutUserSummaryDesc = ' |' + slineBreak + '    Used to update a `User`. **id** is the unique EMS User identifier (UID) in the EMS database.';

  sDeleteUserSummaryTitle = 'Delete User';
  sDeleteUserSummaryDesc = ' |' + slineBreak + '    Used to delete a `User`. **id** is the unique EMS User identifier (UID) in the EMS database.';

  sUserPathParamIDDesc = 'A user ID';
  sLoginPathParamIDDesc = 'A user object';
  sSignUpObject = 'Object to sign up a new EMS User in the EMS Server';
  sAddObject = 'Object to add a new EMS User in the EMS Server';
  sAddFieldName = 'Add any fieldName';

  sUserReqParamSkipDesc = 'users skipped';
  sUserReqParamLimitDesc = 'maximum number of results to return';
  sUserReqParamOrderDesc = 'order ascending or descending (asc, desc)';
  sUserReqParamWhereDesc = 'filter operators (lt, lte, gt, gte, eq, neq, like, nlike)';



//Version Resource
  sGetVersionSummaryTitle = 'Get version';
  sGetVersionSummaryDesc = ' |' + slineBreak + '    Used to retrieve the `Version` of the EMS Server.';

  sGetVersion200Response = 'Ok. Provides the current version of the EMS Server';

//APIDoc Resource
  sGetAPITitle = 'Get API EndPoints';
  sGetOneAPITitle = 'Get API EndPoint';
  sGetAPIDesc = ' |' + slineBreak + '    Used to retrieve all the API EndPoints.';
  sGetOneAPIDesc = ' |' + slineBreak + '    Used to retrieve an EndPoint for the API EndPoints.';
  sEndPointPath = 'Path Segment to an EndPoint';
  sGetAPIYAMLTitle = 'Get YAML';
  sGetAPIJSONTitle = 'Get JSON';
  sGetAPIYAMLDesc = 'Get API in YAML format';
  sGetAPIJSONDesc = 'Get API in JSON format';

//APIDoc Resource
  sGetGroupSummaryTitle = 'Get Group';
  sGetGroupSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from a `Group`. **item** is the unique EMS Group name in the EMS database.';

  sGetGroupsSummaryTitle = 'Get Groups';
  sGetGroupsSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from `Groups`.'+ slineBreak +
      '    Optional query param of **skip, limit, order, where** determines ' + slineBreak +
      '    size of returned array, filtered and order by.';

  sGetGroupFieldsSummaryTitle = 'Get Fields';
  sGetGroupFieldsSummaryDesc = ' |' + slineBreak + '    Used to retrieve all the `field names` of the EMS Group (including the custom fields).';

  sPostGroupSummaryTitle = 'Add Group';
  sPostGroupSummaryDesc = ' |' + slineBreak + '    Used to add a new `Group` object to the EMS database.';

  sPutGroupSummaryTitle = 'Update Group';
  sPutGroupSummaryDesc = ' |' + slineBreak + '    Used to update a `Group`. **item** is the unique EMS Group name in the EMS database.';

  sDeleteGroupSummaryTitle = 'Delete Group';
  sDeleteGroupSummaryDesc = ' |' + slineBreak + '    Used to delete a `Group`. **item** is the unique EMS Group name in the EMS database.';

  sGroupPathParamItemDesc = 'A group name';

  sResponseGroupNotFound = 'Group not found';
  sResponseGroupUserNotFound = 'Group not found / User not found';
  sResponseGroupExist = 'Group already exist';

//Intallations Resource
  sGetInstallationSummaryTitle = 'Get Installation';
  sGetInstallationSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from a specific `Installation` (registered device). **id** is the unique EMS Installation identifier (InstallationID) in the EMS database.';

  sGetInstallationsSummaryTitle = 'Get Installations';
  sGetInstallationsSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from `Installation`.' + slineBreak +
      '    Optional query param of **skip, limit, order, where** determines ' + slineBreak +
      '    size of returned array, filtered and order by.';

  sGetInstallationFieldsSummaryTitle = 'Get Fields';
  sGetInstallationFieldsSummaryDesc = ' |' + slineBreak + '    Used to retrieve all the `field names` of the EMS Installation (including the custom fields).';

  sGetInstallationChannelsSummaryTitle = 'Get Installation Channels';
  sGetInstallationChannelsSummaryDesc = ' |' + slineBreak + '     Used to retrieve the available channels to which the device has subscribed. **id** is the unique EMS Installation identifier (InstallationID) in the EMS database.';

  sPostInstallationSummaryTitle = 'Add Installation';
  sPostInstallationSummaryDesc = ' |' + slineBreak + '    Used to add a new `Installation` object to the EMS database.';

  sPutInstallationSummaryTitle = 'Update Installation';
  sPutInstallationSummaryDesc = ' |' + slineBreak + '    Used to update an `Installation`. **id** is the unique EMS Installation identifier (IID) in the EMS database.';

  sDeleteInstallationSummaryTitle = 'Delete Installation';
  sDeleteInstallationSummaryDesc = ' |' + slineBreak + '    Used to delete an `Installation`. **id** is the unique EMS Installation identifier (IID) in the EMS database.';

  sInstallationPathParamItemDesc = 'A Installation ID';

  sResponseInstallationExist = 'Installation already exists';

  sInstallationUpdateFields = 'Installation fields to update';

//Push Resource
  sPostSendPushTitle = 'Send Push';
  sPostSendPushDesc = 'Used to send a push notification message to a registered device';
  sPushBodyParamDesc = 'Object containing the Push Message data structure';

//Module Resource
  sResponseModulexist = 'Module already exist';

  sGetModuleSummaryTitle = 'Get Module';
  sGetModuleSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from `EdgeModule` (registered device). **mname** is the unique EMS EdgeModule identifier (MID) in the EMS database.';

  sGetModulesSummaryTitle = 'Get Module';
  sGetModulesSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from `EdgeModule`.' + slineBreak +
      '    Optional query param of **skip, limit, order, where** determines ' + slineBreak +
      '    size of returned array, filtered and order by.';

  sGetModuleFieldsSummaryTitle = 'Get Fields';
  sGetModuleFieldsSummaryDesc = ' |' + slineBreak + '    Used to retrieve all the `field names` of the EMS EdgeModule (including the custom fields).';

  sGetModuleResourcesFieldsSummaryTitle = 'Get Resource Fields';
  sGetModuleResourcesFieldsSummaryDesc = ' |' + slineBreak + '    Used to retrieve the `field names` of all the resources of the EMS EdgeModule (including the custom fields).';

  sGetModulesResourcesSummaryTitle = 'Get EdgeModules Resources';
  sGetModulesResourcesSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from the resources of all EdgeModules.';

  sGetModuleResourcesSummaryTitle = 'Get EdgeModule Resources';
  sGetModuleResourcesSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from the resources of an EdgeModule.';

  sGetModuleResourceSummaryTitle = 'Get EdgeModule Resource';
  sGetModuleResourceSummaryDesc = ' |' + slineBreak + '    Used to retrieve all data from a resource of an EdgeModule. **mname** is the unique EMS EdgeModule identifier in the EMS database. **resourcename** is the name of the resource.';

  sPostModuleSummaryTitle = 'Add Module';
  sPostModuleSummaryDesc = ' |' + slineBreak + '    Used to add a new `EdgeModule` object to the EMS database.';

  sPostModuleResourceSummaryTitle = 'Add Module Resource';
  sPostModuleResourceSummaryDesc = ' |' + slineBreak + '    Used to register a new resource from an EMS EdgeModule. **mname** is the unique EMS EdgeModule identifier in the EMS database.';

  sPutModuleSummaryTitle = 'Update Module';
  sPutModuleSummaryDesc = ' |' + slineBreak + '    Used to update an `EdgeModule`. **mname** is the unique EMS EdgeModule identifier (MID) in the EMS database.';

  sPutModuleResourceSummaryTitle = 'Update Module Resource';
  sPutModuleResourceSummaryDesc = ' |' + slineBreak + '    Used to update an `EdgeModule`. **mname** is the unique EMS EdgeModule identifier (MID) in the EMS database.';

  sDeleteModuleSummaryTitle = 'Delete Module';
  sDeleteModuleSummaryDesc = ' |' + slineBreak + '    Used to delete an `EdgeModule Resource`. **mname** is the unique EMS EdgeModule identifier (MID) in the EMS database. **resourcename** is the name of the resource.';

  sDeleteModuleResourceSummaryTitle = 'Delete Module Resource';
  sDeleteModuleResourceSummaryDesc = ' |' + slineBreak + '    Used to delete an `EdgeModule Resource`. **mname** is the unique EMS EdgeModule identifier (MID) in the EMS database. **resourcename** is the name of the resource.';


  sInvokeGetModuleResourceSummaryTitle = 'Invoke Resource Get Method';
  sInvokeGetModuleResourceSummaryDesc = 'Used to invoke the GET method of the resource from an existing EMS EdgeModule.';

  sInvokeWildGetModuleResourceSummaryTitle = 'Invoke Resource/* Get Method';
  sInvokeWildGetModuleResourceSummaryDesc = 'Used to invoke the GET method of the resource from an existing EMS EdgeModule.';

  sInvokePutModuleResourceSummaryTitle = 'Invoke Resource Put Method';
  sInvokePutModuleResourceSummaryDesc = 'Used to invoke the PUT method of the resource from an existing EMS EdgeModule.';

  sInvokeWildPutModuleResourceSummaryTitle = 'Invoke Resource/* Put Method';
  sInvokeWildPutModuleResourceSummaryDesc = 'Used to invoke the PUT method of the resource from an existing EMS EdgeModule.';

  sInvokePostModuleResourceSummaryTitle = 'Invoke Resource Post Method';
  sInvokePostModuleResourceSummaryDesc = 'Used to invoke the POST method of the resource from an existing EMS EdgeModule.';

  sInvokeWildPostModuleResourceSummaryTitle = 'Invoke Resource/* Post Method';
  sInvokeWildPostModuleResourceSummaryDesc = 'Used to invoke the POST method of the resource from an existing EMS EdgeModule.';

  sInvokePatchModuleResourceSummaryTitle = 'Invoke Resource Patch Method';
  sInvokePatchModuleResourceSummaryDesc = 'Used to invoke the PATCH method of the resource from an existing EMS EdgeModule.';

  sInvokeWildPatchModuleResourceSummaryTitle = 'Invoke Resource/* Patch Method';
  sInvokeWildPatchModuleResourceSummaryDesc = 'Used to invoke the PATCH method of the resource from an existing EMS EdgeModule.';

  sInvokeDeleteModuleResourceSummaryTitle = 'Invoke Resource Delete Method';
  sInvokeDeleteModuleResourceSummaryDesc = 'Used to invoke the DELETE method of the resource from an existing EMS EdgeModule.';

  sInvokeWildDeleteModuleResourceSummaryTitle = 'Invoke Resource/* Delete Method';
  sInvokeWildDeleteModuleResourceSummaryDesc = 'Used to invoke the DELETE method of the resource from an existing EMS EdgeModule.';


  sEdgeModuleIdParam = 'Is the unique EMS EdgeModule identifier';
  sEdgeModuleResourceNameParam = 'Is the unique EMS EdgeModule Resource name';
  sEdgeModuleResourceWildCard = 'Is the Wild card part of the URL';
  sEdgeModuleResourceBodyObject = 'Body Object';

  sEdgeModuleAddObject = 'EdgeModule object to add. protocolprops example string {\"port\":8082,\"host\":\"10.150.40.52\"}';
  sEdgeModuleResourceAddObject = 'EdgModule Resource add object. protocolprops string example {\"port\":8082,\"host\":\"10.150.40.52\"}';

//Module Resource Invoke
  sEdgeModuleNameParam = 'Is the EMS EdgeModule name';

const
  cUsersTag = 'Users';
  cGroupsTag = 'Groups';
  cInstallationsTag = 'Installations';
  cPushTag = 'Push';
  cAPIDocTag = 'Api Doc';
  cEdgeModulesTag = 'EdgeModules';
  cEdgeModulesInvokersTag = 'EdgeModules Invokers';
  cVersionTag = 'Version';

  cApplicationJSON = 'application/json';
  cBodyParamName = 'body';

  cResponseBadRequestKey = 'sResponseBadRequest';
  cResponseOK = 'sResponseOK';
  cResponseNoContent = 'sResponseNoContent';
  cResponseNotFound = 'sResponseNotFound';
  cResponseUnexpextedRequestBody = 'sResponseUnexpextedRequestBody';

  cResponseWrongCredentials = 'sResponseWrongCredentials';
  cResponseUserNotFound = 'sResponseUserNotFound';
  cResponseOpNotCompleted = 'sResponseOpNotCompleted';
  cResponseRequestNotIdentify = 'sResponseRequestNotIdentify';

//Users Resource
  cResponseUserCreated = 'sResponseUserCreated';
  cResponseUserExist = 'sResponseUserExist';

  cGetUserSummaryTitle = 'sGetUserSummaryTitle';
  cGetUserSummaryDesc = 'sGetUserSummaryDesc';

  cGetUsersSummaryTitle = 'sGetUsersSummaryTitle';
  cGetUsersSummaryDesc = 'sGetUsersSummaryDesc';

  cGetUserFieldsSummaryTitle = 'sGetUserFieldsSummaryTitle';
  cGetUserFieldsSummaryDesc = 'sGetUserFieldsSummaryDesc';

  cGetUserGroupsSummaryTitle = 'sGetUserGroupsSummaryTitle';
  cGetUserGroupsSummaryDesc = 'sGetUserGroupsSummaryDesc';

  cUserSignUpSummaryTitle = 'sUserSignUpSummaryTitle';
  cUserSignUpSummaryDesc = 'sUserSignUpSummaryDesc';

  cPostLoginSummaryTitle = 'sPostLoginSummaryTitle';
  cPostLoginSummaryDesc = 'sPostLoginSummaryDesc';

  cPostUserSummaryTitle = 'sPostUserSummaryTitle';
  cPostUserSummaryDesc = 'sPostUserSummaryDesc';

  cPutUserSummaryTitle = 'sPutUserSummaryTitle';
  cPutUserSummaryDesc = 'sPutUserSummaryDesc';

  cDeleteUserSummaryTitle = 'sDeleteUserSummaryTitle';
  cDeleteUserSummaryDesc = 'sDeleteUserSummaryDesc';

  cUserPathParamIDDesc = 'sUserPathParamIDDesc';
  cLoginPathParamIDDesc = 'sLoginPathParamIDDesc';
  cSignUpObject = 'sSignUpObject';
  cAddObject = 'sAddObject';
  cAddFieldName = 'sAddFieldName';

  cUserReqParamSkipDesc = 'sUserReqParamSkipDesc';
  cUserReqParamLimitDesc = 'sUserReqParamLimitDesc';
  cUserReqParamOrderDesc = 'sUserReqParamOrderDesc';
  cUserReqParamWhereDesc = 'sUserReqParamWhereDesc';

//Version Resource
  cGetVersionSummaryTitle= 'sGetVersionSummaryTitle';
  cGetVersionSummaryDesc = 'sGetVersionSummaryDesc';
  cGetVersion200Response = 'sGetVersion200Response';

//APIDoc Resource
  cGetAPITitle = 'sGetAPITitle';
  cGetOneAPITitle = 'sGetOneAPITitle';
  cGetOneAPIDesc = 'sGetOneAPIDesc';
  cGetAPIDesc = 'sGetAPIDesc';
  cEndPointPath = 'sEndPointPath';

  cGetAPIYAMLTitle = 'sGetAPIYAMLTitle';
  cGetAPIJSONTitle = 'sGetAPIJSONTitle';

  cGetAPIYAMLDesc = 'sGetAPIYAMLDesc';
  cGetAPIJSONDesc = 'sGetAPIJSONDesc';

//APIDoc Resource
  cGetGroupSummaryTitle = 'sGetGroupSummaryTitle';
  cGetGroupSummaryDesc = 'sGetGroupSummaryDesc';

  cGetGroupsSummaryTitle = 'sGetGroupsSummaryTitle';
  cGetGroupsSummaryDesc = 'sGetGroupsSummaryDesc';

  cGetGroupFieldsSummaryTitle = 'sGetGroupFieldsSummaryTitle';
  cGetGroupFieldsSummaryDesc = 'sGetGroupFieldsSummaryDesc';

  cPostGroupSummaryTitle = 'sPostGroupSummaryTitle';
  cPostGroupSummaryDesc = 'sPostGroupSummaryDesc';

  cPutGroupSummaryTitle = 'sPutGroupSummaryTitle';
  cPutGroupSummaryDesc = 'sPutGroupSummaryDesc';

  cDeleteGroupSummaryTitle = 'sDeleteGroupSummaryTitle';
  cDeleteGroupSummaryDesc = 'sDeleteGroupSummaryDesc';

  cGroupPathParamItemDesc = 'sGroupPathParamItemDesc';

  cResponseGroupNotFound = 'sResponseGroupNotFound';
  cResponseGroupUserNotFound = 'sResponseGroupUserNotFound';
  cResponseGroupExist = 'sResponseGroupExist';

//Intallations Resource
  cGetInstallationSummaryTitle = 'sGetInstallationSummaryTitle';
  cGetInstallationSummaryDesc = 'sGetInstallationSummaryDesc';

  cGetInstallationsSummaryTitle = 'sGetInstallationsSummaryTitle';
  cGetInstallationsSummaryDesc = 'sGetInstallationsSummaryDesc';

  cGetInstallationFieldsSummaryTitle = 'sGetInstallationFieldsSummaryTitle';
  cGetInstallationFieldsSummaryDesc = 'sGetInstallationFieldsSummaryDesc';

  cGetInstallationChannelsSummaryTitle = 'sGetInstallationChannelsSummaryTitle';
  cGetInstallationChannelsSummaryDesc = 'sGetInstallationChannelsSummaryDesc';

  cPostInstallationSummaryTitle = 'sPostInstallationSummaryTitle';
  cPostInstallationSummaryDesc = 'sPostInstallationSummaryDesc';

  cPutInstallationSummaryTitle = 'sPutInstallationSummaryTitle';
  cPutInstallationSummaryDesc = 'sPutInstallationSummaryDesc';

  cDeleteInstallationSummaryTitle = 'sDeleteInstallationSummaryTitle';
  cDeleteInstallationSummaryDesc = 'sDeleteInstallationSummaryDesc';

  cInstallationPathParamItemDesc = 'sInstallationPathParamItemDesc';
  cInstallationUpdateFields = 'sInstallationUpdateFields';

  cResponseInstallationExist = 'sResponseInstallationExist';

//Push Resource
  cPostSendPushTitle = 'sPostSendPushTitle';
  cPostSendPushDesc = 'sPostSendPushDesc';
  cPushBodyParamDesc = 'cPushBodyParamDesc';

//Module Resource
  cResponseModulexist= 'sResponseModulexist';

  cGetModulesSummaryTitle = 'sGetModulesSummaryTitle';
  cGetModulesSummaryDesc = 'sGetModulesSummaryDesc';

  cGetModuleSummaryTitle = 'sGetModuleSummaryTitle';
  cGetModuleSummaryDesc = 'sGetModuleSummaryDesc';

  cGetModuleFieldsSummaryTitle = 'sGetModuleFieldsSummaryTitle';
  cGetModuleFieldsSummaryDesc = 'cGetModuleFieldsSummaryDesc';

  cGetModuleResourcesFieldsSummaryTitle = 'sGetModuleResourcesFieldsSummaryTitle';
  cGetModuleResourcesFieldsSummaryDesc = 'sGetModuleResourcesFieldsSummaryDesc';

  cGetModuleResourcesSummaryTitle = 'sGetModuleResourcesSummaryTitle';
  cGetModuleResourcesSummaryDesc = 'sGetModuleResourcesSummaryDesc';

  cGetModulesResourcesSummaryTitle = 'sGetModulesResourcesSummaryTitle';
  cGetModulesResourcesSummaryDesc = 'sGetModulesResourcesSummaryDesc';

  cGetModuleResourceSummaryTitle = 'sGetModuleResourceSummaryTitle';
  cGetModuleResourceSummaryDesc = 'sGetModuleResourceSummaryDesc';

  cPostModuleSummaryTitle = 'sPostModuleSummaryTitle';
  cPostModuleSummaryDesc = 'sPostModuleSummaryDesc';

  cPostModuleResourceSummaryTitle = 'sPostModuleResourceSummaryTitle';
  cPostModuleResourceSummaryDesc = 'cPostModuleResourceSummaryDesc';

  cPutModuleSummaryTitle = 'sPutModuleSummaryTitle';
  cPutModuleSummaryDesc = 'sPutModuleSummaryDesc';

  cPutModuleResourceSummaryTitle = 'sPutModuleResourceSummaryTitle';
  cPutModuleResourceSummaryDesc = 'sPutModuleResourceSummaryDesc';

  cDeleteModuleSummaryTitle = 'sDeleteModuleSummaryTitle';
  cDeleteModuleSummaryDesc = 'sDeleteModuleSummaryDesc';

  cDeleteModuleResourceSummaryTitle = 'sDeleteModuleResourceSummaryTitle';
  cDeleteModuleResourceSummaryDesc = 'sDeleteModuleResourceSummaryDesc';

  cInvokeGetModuleResourceSummaryTitle = 'sInvokeGetModuleResourceSummaryTitle';
  cInvokeGetModuleResourceSummaryDesc = 'sInvokeGetModuleResourceSummaryDesc';

  cInvokeWildGetModuleResourceSummaryTitle = 'sInvokeWildGetModuleResourceSummaryTitle';
  cInvokeWildGetModuleResourceSummaryDesc = 'sInvokeWildGetModuleResourceSummaryDesc';

  cInvokePutModuleResourceSummaryTitle = 'sInvokePutModuleResourceSummaryTitle';
  cInvokePutModuleResourceSummaryDesc = 'sInvokePutModuleResourceSummaryDesc';

  cInvokeWildPutModuleResourceSummaryTitle = 'sInvokeWildPutModuleResourceSummaryTitle';
  cInvokeWildPutModuleResourceSummaryDesc = 'sInvokeWildPutModuleResourceSummaryDesc';

  cInvokePostModuleResourceSummaryTitle = 'sInvokePostModuleResourceSummaryTitle';
  cInvokePostModuleResourceSummaryDesc = 'sInvokePostModuleResourceSummaryDesc';

  cInvokeWildPostModuleResourceSummaryTitle = 'sInvokeWildPostModuleResourceSummaryTitle';
  cInvokeWildPostModuleResourceSummaryDesc = 'sInvokeWildPostModuleResourceSummaryDesc';

  cInvokePatchModuleResourceSummaryTitle = 'sInvokePatchModuleResourceSummaryTitle';
  cInvokePatchModuleResourceSummaryDesc = 'sInvokePatchModuleResourceSummaryDesc';

  cInvokeWildPatchModuleResourceSummaryTitle = 'sInvokeWildPatchModuleResourceSummaryTitle';
  cInvokeWildPatchModuleResourceSummaryDesc = 'sInvokeWildPatchModuleResourceSummaryDesc';

  cInvokeDeleteModuleResourceSummaryTitle = 'sInvokeDeleteModuleResourceSummaryTitle';
  cInvokeDeleteModuleResourceSummaryDesc = 'sInvokeDeleteModuleResourceSummaryDesc';

  cInvokeWildDeleteModuleResourceSummaryTitle = 'sInvokeWildDeleteModuleResourceSummaryTitle';
  cInvokeWildDeleteModuleResourceSummaryDesc = 'sInvokeWildDeleteModuleResourceSummaryDesc';

  cEdgeModuleIdParam = 'sEdgeModuleIdParam';
  cEdgeModuleResourceNameParam = 'sEdgeModuleResourceNameParam';
  cEdgeModuleResourceWildCard = 'sEdgeModuleResourceWildCard';
  cEdgeModuleResourceBodyObject = 'sEdgeModuleResourceBodyObject';

  cEdgeModuleAddObject = 'sEdgeModuleAddObject';
  cEdgeModuleResourceAddObject = 'sEdgeModuleResourceAddObject';

//Module Resource Invoke

  cEdgeModuleNameParam = 'sEdgeModuleNameParam';

//Object Definitions
  VersionObjectsYMALDefinition =
'#' +  sLineBreak +
' versionObject:' +  sLineBreak +
'    type: object' +  sLineBreak +
'    properties:' +  sLineBreak +
'      version:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      server:' +  sLineBreak +
'        type: string' +  sLineBreak;

  VersionObjectsJSONDefinition =
'{' +  sLineBreak +
'    "versionObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "version": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "server": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

  EdgeVersionObjectsYMALDefinition =
'#' +  sLineBreak +
' versionEdgeObject:' +  sLineBreak +
'    type: object' +  sLineBreak +
'    properties:' +  sLineBreak +
'      moduleversion:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      modulename:' +  sLineBreak +
'        type: string'+  sLineBreak;

  EdgeVersionObjectsJSONDefinition =
'{' +  sLineBreak +
'    "versionEdgeObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "moduleversion": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "modulename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

  UserObjectsYMALDefinition =
'#' +  sLineBreak +
' _metaObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - creator' +  sLineBreak +
'      - created' +  sLineBreak +
'    properties:' +  sLineBreak +
'      creator:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      created:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' userObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - id' +  sLineBreak +
'      - username' +  sLineBreak +
'      - _meta' +  sLineBreak +
'    properties:' +  sLineBreak +
'      id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      username:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      _meta:' +  sLineBreak +
'        $ref: "#/definitions/_metaObject"' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' userTokenObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - id' +  sLineBreak +
'      - username' +  sLineBreak +
'      - _meta' +  sLineBreak +
'      - sessiontoken' +  sLineBreak +
'    properties:' +  sLineBreak +
'      id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      username:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      _meta:' +  sLineBreak +
'        $ref: "#/definitions/_metaObject"' +  sLineBreak +
'      sessiontoken:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' userCredentialsObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - username' +  sLineBreak +
'      - password' +  sLineBreak +
'    properties:' +  sLineBreak +
'      username:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      password:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' userSignUpResponseObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - _id' +  sLineBreak +
'      - sessionToken' +  sLineBreak +
'    properties:' +  sLineBreak +
'      _id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      sessionToken:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' useridObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - _id' +  sLineBreak +
'    properties:' +  sLineBreak +
'      _id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' updateObject:' +  sLineBreak +
'    properties:' +  sLineBreak +
'      fieldName:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' updatedObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - updated' +  sLineBreak +
'    properties:' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' groupName:' +  sLineBreak +
'    type: string' +  sLineBreak +
'# ' +  sLineBreak +
' fieldObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - name' +  sLineBreak +
'     properties:' +  sLineBreak +
'      name:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      fields:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'          type: object' +  sLineBreak +
'          properties:' +  sLineBreak +
'            name:' +  sLineBreak +
'              type: string' +  sLineBreak +
'      custom:' +  sLineBreak +
'        type: boolean'+  sLineBreak;

  UserObjectsJSONDefinition =
'{' +  sLineBreak +
'    "_metaObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "creator",' +  sLineBreak +
'            "created"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "creator": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "created": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "userObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "id",' +  sLineBreak +
'            "username",' +  sLineBreak +
'            "_meta"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "username": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "_meta": {' +  sLineBreak +
'                "$ref": "#/definitions/_metaObject"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "userTokenObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "id",' +  sLineBreak +
'            "username",' +  sLineBreak +
'            "_meta",' +  sLineBreak +
'            "sessiontoken"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "username": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "_meta": {' +  sLineBreak +
'                "$ref": "#/definitions/_metaObject"' +  sLineBreak +
'            },' +  sLineBreak +
'            "sessiontoken": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "userCredentialsObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "username",' +  sLineBreak +
'            "password"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "username": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'           "password": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "userSignUpResponseObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "_id",' +  sLineBreak +
'            "sessionToken"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "_id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "sessionToken": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "useridObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "_id"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "_id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "updateObject": {' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "fieldName": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "updatedObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "updated"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "groupName": {' +  sLineBreak +
'        "type": "string"' +  sLineBreak +
'    },' +  sLineBreak +
'    "fieldObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "name"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "name": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "fields": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "object",' +  sLineBreak +
'                    "properties": {' +  sLineBreak +
'                        "name": {' +  sLineBreak +
'                            "type": "string"' +  sLineBreak +
'                        }' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "custom": {' +  sLineBreak +
'                "type": "boolean"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

  GroupsObjectsYMALDefinition =
'#' +  sLineBreak +
' _metaGroupObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - creator' +  sLineBreak +
'      - created' +  sLineBreak +
'    properties:' +  sLineBreak +
'      creator:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      created:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' groupObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - name' +  sLineBreak +
'      - _meta' +  sLineBreak +
'    properties:' +  sLineBreak +
'      name:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      _meta:' +  sLineBreak +
'        $ref: "#/definitions/_metaGroupObject"' +  sLineBreak +
'      users:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'         type: string' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'# ' +  sLineBreak +
' groupAddObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - groupname' +  sLineBreak +
'    properties:' +  sLineBreak +
'      groupname:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' updateGroupObject:' +  sLineBreak +
'    properties:' +  sLineBreak +
'      fieldName:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      users:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'         type: string' +  sLineBreak +
'#' +  sLineBreak +
' updatedGroupObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - updated' +  sLineBreak +
'    properties:' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' fieldGroupObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - name' +  sLineBreak +
'     properties:' +  sLineBreak +
'      name:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      fields:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'          type: object' +  sLineBreak +
'          properties:' +  sLineBreak +
'            name:' +  sLineBreak +
'              type: string' +  sLineBreak +
'      custom:' +  sLineBreak +
'        type: boolean'+  sLineBreak;

  GroupsObjectsJSONDefinition =
'{' +  sLineBreak +
'    "_metaGroupObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "creator",' +  sLineBreak +
'            "created"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "creator": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "created": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "groupObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "name",' +  sLineBreak +
'            "_meta"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "name": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "_meta": {' +  sLineBreak +
'                "$ref": "#/definitions/_metaGroupObject"' +  sLineBreak +
'            },' +  sLineBreak +
'            "users": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "string"' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "groupAddObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "groupname"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "groupname": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "updateGroupObject": {' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "fieldName": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "users": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "string"' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "updatedGroupObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "updated"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "fieldGroupObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "name"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "name": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "fields": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "object",' +  sLineBreak +
'                    "properties": {' +  sLineBreak +
'                        "name": {' +  sLineBreak +
'                            "type": "string"' +  sLineBreak +
'                        }' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "custom": {' +  sLineBreak +
'                "type": "boolean"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

  InstallationsObjectsYMALDefinition =
'#' +  sLineBreak +
' _metaInstallationObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - creator' +  sLineBreak +
'      - created' +  sLineBreak +
'    properties:' +  sLineBreak +
'      creator:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      created:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' installationObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - _id' +  sLineBreak +
'      - deviceToken' +  sLineBreak +
'      - deviceType' +  sLineBreak +
'      - _meta' +  sLineBreak +
'    properties:' +  sLineBreak +
'      _id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      deviceToken:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      deviceType:' +  sLineBreak +
'        type: string' +  sLineBreak +
'        enum:' +  sLineBreak +
'         - ios' +  sLineBreak +
'         - android' +  sLineBreak +
'      _meta:' +  sLineBreak +
'        $ref: "#/definitions/_metaInstallationObject"' +  sLineBreak +
'      channels:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'         type: string' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'# ' +  sLineBreak +
' installationAddObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - deviceToken' +  sLineBreak +
'      - deviceType' +  sLineBreak +
'    properties:' +  sLineBreak +
'      deviceToken:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      deviceType:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      channels:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'         type: string' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'# ' +  sLineBreak +
' installationAddedObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - _id' +  sLineBreak +
'    properties:' +  sLineBreak +
'      _id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' updateInstallationObject:' +  sLineBreak +
'    properties:' +  sLineBreak +
'      channels:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'         type: string' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' updatedInstallationObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - updated' +  sLineBreak +
'    properties:' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' channelName:' +  sLineBreak +
'    type: string' +  sLineBreak +
'#' +  sLineBreak +
' fieldInstallationObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - name' +  sLineBreak +
'     properties:' +  sLineBreak +
'      name:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      fields:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'          type: object' +  sLineBreak +
'          properties:' +  sLineBreak +
'            name:' +  sLineBreak +
'              type: string' +  sLineBreak +
'      custom:' +  sLineBreak +
'        type: boolean'+  sLineBreak;

  InstallationsObjectsJSONDefinition =
'{' +  sLineBreak +
'    "_metaInstallationObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "creator",' +  sLineBreak +
'            "created"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "creator": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "created": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "installationObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "_id",' +  sLineBreak +
'            "deviceToken",' +  sLineBreak +
'            "deviceType",' +  sLineBreak +
'            "_meta"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "_id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "deviceToken": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "deviceType": {' +  sLineBreak +
'                "type": "string",' +  sLineBreak +
'                "enum": [' +  sLineBreak +
'                    "ios",' +  sLineBreak +
'                    "android"' +  sLineBreak +
'                ]' +  sLineBreak +
'            },' +  sLineBreak +
'            "_meta": {' +  sLineBreak +
'                "$ref": "#/definitions/_metaInstallationObject"' +  sLineBreak +
'            },' +  sLineBreak +
'            "channels": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "string"' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "installationAddObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "deviceToken",' +  sLineBreak +
'            "deviceType"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "deviceToken": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "deviceType": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "channels": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "string"' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "installationAddedObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "_id"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "_id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "updateInstallationObject": {' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "channels": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "string"' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "updatedInstallationObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "updated"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "channelName": {' +  sLineBreak +
'        "type": "string"' +  sLineBreak +
'    },' +  sLineBreak +
'    "fieldInstallationObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "name"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "name": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "fields": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "object",' +  sLineBreak +
'                    "properties": {' +  sLineBreak +
'                        "name": {' +  sLineBreak +
'                            "type": "string"' +  sLineBreak +
'                        }' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "custom": {' +  sLineBreak +
'                "type": "boolean"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

  PushObjectsYMALDefinition =
'#' +  sLineBreak +
' pushObject:' +  sLineBreak +
'    type: object' +  sLineBreak +
'    required:' +  sLineBreak +
'     - data' +  sLineBreak +
'     - where' +  sLineBreak +
'    properties:' +  sLineBreak +
'     data:' +  sLineBreak +
'      $ref: "#/definitions/pushDataObject"' +  sLineBreak +
'     channels:' +  sLineBreak +
'      type: array' +  sLineBreak +
'      items:' +  sLineBreak +
'       type: string' +  sLineBreak +
'     where:' +  sLineBreak +
'      $ref: "#/definitions/pushWhereObject"' +  sLineBreak +
'#' +  sLineBreak +
' pushDataObject:' +  sLineBreak +
'    type: object' +  sLineBreak +
'    properties:' +  sLineBreak +
'     gcm:' +  sLineBreak +
'       properties:' +  sLineBreak +
'        message:' +  sLineBreak +
'         type: string' +  sLineBreak +
'        title:' +  sLineBreak +
'         type: string' +  sLineBreak +
'     aps:' +  sLineBreak +
'       properties:' +  sLineBreak +
'        alert:' +  sLineBreak +
'         type: string' +  sLineBreak +
'        badge:' +  sLineBreak +
'         type: string' +  sLineBreak +
'        sound:' +  sLineBreak +
'         type: string' +  sLineBreak +
'     extras:' +  sLineBreak +
'       properties:' +  sLineBreak +
'        message:' +  sLineBreak +
'         type: string' +  sLineBreak +
'#' +  sLineBreak +
' pushWhereObject:' +  sLineBreak +
'    type: object' +  sLineBreak +
'    properties:' +  sLineBreak +
'      deviceType:' +  sLineBreak +
'        type: string' +  sLineBreak +
'        enum:' +  sLineBreak +
'         - ios' +  sLineBreak +
'         - android' +  sLineBreak +
'      deviceToken:' +  sLineBreak +
'        type: object' +  sLineBreak +
'        description : "$in"' +  sLineBreak +
'        required:' +  sLineBreak +
'         - $in' +  sLineBreak +
'        properties:' +  sLineBreak +
'         $in:' +  sLineBreak +
'          type: array' +  sLineBreak +
'          items:' +  sLineBreak +
'           type: string' +  sLineBreak;


  PushObjectsJSONDefinition =
'{' +  sLineBreak +
'    "pushObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "data",' +  sLineBreak +
'            "where"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "data": {' +  sLineBreak +
'                "$ref": "#/definitions/pushDataObject"' +  sLineBreak +
'            },' +  sLineBreak +
'            "channels": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "string"' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "where": {' +  sLineBreak +
'                "$ref": "#/definitions/pushWhereObject"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "pushDataObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "gcm": {' +  sLineBreak +
'                "properties": {' +  sLineBreak +
'                    "message": {' +  sLineBreak +
'                        "type": "string"' +  sLineBreak +
'                    },' +  sLineBreak +
'                    "title": {' +  sLineBreak +
'                        "type": "string"' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "aps": {' +  sLineBreak +
'                "properties": {' +  sLineBreak +
'                    "alert": {' +  sLineBreak +
'                        "type": "string"' +  sLineBreak +
'                    },' +  sLineBreak +
'                    "badge": {' +  sLineBreak +
'                        "type": "string"' +  sLineBreak +
'                    },' +  sLineBreak +
'                    "sound": {' +  sLineBreak +
'                        "type": "string"' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "extras": {' +  sLineBreak +
'                "properties": {' +  sLineBreak +
'                    "message": {' +  sLineBreak +
'                        "type": "string"' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "pushWhereObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "deviceType": {' +  sLineBreak +
'                "type": "string",' +  sLineBreak +
'                "enum": [' +  sLineBreak +
'                    "ios",' +  sLineBreak +
'                    "android"' +  sLineBreak +
'                ]' +  sLineBreak +
'            },' +  sLineBreak +
'            "deviceToken": {' +  sLineBreak +
'                "type": "object",' +  sLineBreak +
'                "description": "$in",' +  sLineBreak +
'                "required": [' +  sLineBreak +
'                    "$in"' +  sLineBreak +
'                ],' +  sLineBreak +
'                "properties": {' +  sLineBreak +
'                    "$in": {' +  sLineBreak +
'                        "type": "array",' +  sLineBreak +
'                        "items": {' +  sLineBreak +
'                            "type": "string"' +  sLineBreak +
'                        }' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

  ModuleObjectsYMALDefinition =
'#' +  sLineBreak +
' _metaEdgeModuleObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - creator' +  sLineBreak +
'      - created' +  sLineBreak +
'    properties:' +  sLineBreak +
'      creator:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      created:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - modulename' +  sLineBreak +
'      - _id' +  sLineBreak +
'      - protocol' +  sLineBreak +
'      - protocolprops' +  sLineBreak +
'      - _meta' +  sLineBreak +
'    properties:' +  sLineBreak +
'      modulename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      _id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      protocol:' +  sLineBreak +
'        type: string' +  sLineBreak +
//'        enum:' +  sLineBreak +
//'         - http' +  sLineBreak +
//'         - https' +  sLineBreak +
'      protocolprops:' +  sLineBreak +
'        type: string' +  sLineBreak +
'        pattern: \{\\"port\\":[0-9]{2,5},\\"host\\":\\"([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})\\"\}' +  sLineBreak +
'      _meta:' +  sLineBreak +
'        $ref: "#/definitions/_metaEdgeModuleObject"' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleResourceObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - resourcename' +  sLineBreak +
'      - modulename' +  sLineBreak +
'      - moduleid' +  sLineBreak +
'      - _meta' +  sLineBreak +
'    properties:' +  sLineBreak +
'      resourcename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      modulename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      moduleid:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      _meta:' +  sLineBreak +
'        $ref: "#/definitions/_metaEdgeModuleObject"' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleAddObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - modulename' +  sLineBreak +
'      - protocol' +  sLineBreak +
'      - protocolprops' +  sLineBreak +
'    properties:' +  sLineBreak +
'      modulename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      protocol:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      protocolprops:' +  sLineBreak +
'        type: string' +  sLineBreak +
'        pattern: \{\\"port\\":[0-9]{2,5},\\"host\\":\\"([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})\\"\}' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleAddedObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - _id' +  sLineBreak +
'      - modulename' +  sLineBreak +
'     properties:' +  sLineBreak +
'      _id:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      modulename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleResourceAddObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - resourcename' +  sLineBreak +
'    properties:' +  sLineBreak +
'      resourcename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleResourceAddedObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - resourcename' +  sLineBreak +
'     properties:' +  sLineBreak +
'      resourcename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleUpdateObject:' +  sLineBreak +
'    required:' +  sLineBreak +
'      - modulename' +  sLineBreak +
'      - protocol' +  sLineBreak +
'      - protocolprops' +  sLineBreak +
'    properties:' +  sLineBreak +
'      modulename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      protocol:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      protocolprops:' +  sLineBreak +
'        type: string' +  sLineBreak +
'        pattern: \{\\"port\\":[0-9]{2,5},\\"host\\":\\"([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})\\"\}' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleUpdatedObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - updated' +  sLineBreak +
'     properties:' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleResourceUpdateObject:' +  sLineBreak +
'    properties:' +  sLineBreak +
'      resourcename:' +  sLineBreak +
'        type: string' +  sLineBreak +
'    additionalProperties:' +  sLineBreak +
'      type: string' +  sLineBreak +
'#' +  sLineBreak +
' edgeModuleResourceUpdatedObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - updated' +  sLineBreak +
'     properties:' +  sLineBreak +
'      updated:' +  sLineBreak +
'        type: string' +  sLineBreak +
'#' +  sLineBreak +
' fieldsEdgeModuleObject:' +  sLineBreak +
'     type: object' +  sLineBreak +
'     required:' +  sLineBreak +
'      - name' +  sLineBreak +
'     properties:' +  sLineBreak +
'      name:' +  sLineBreak +
'        type: string' +  sLineBreak +
'      fields:' +  sLineBreak +
'        type: array' +  sLineBreak +
'        items:' +  sLineBreak +
'          type: object' +  sLineBreak +
'          properties:' +  sLineBreak +
'            name:' +  sLineBreak +
'              type: string' +  sLineBreak +
'      custom:' +  sLineBreak +
'        type: boolean'+  sLineBreak;

  ModuleObjectsJSONDefinition =
'{' +  sLineBreak +
'    "_metaEdgeModuleObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "creator",' +  sLineBreak +
'            "created"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "creator": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "created": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "modulename",' +  sLineBreak +
'            "_id",' +  sLineBreak +
'            "protocol",' +  sLineBreak +
'            "protocolprops",' +  sLineBreak +
'            "_meta"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "modulename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "_id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "protocol": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "protocolprops": {' +  sLineBreak +
'                "type": "string",' +  sLineBreak +
'                "pattern": "\\{\\\\\"port\\\\\":[0-9]{2,5},\\\\\"host\\\\\":\\\\\"([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})\\\\\"\\}"' +  sLineBreak +
'            },' +  sLineBreak +
'            "_meta": {' +  sLineBreak +
'                "$ref": "#/definitions/_metaEdgeModuleObject"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleResourceObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "resourcename",' +  sLineBreak +
'            "modulename",' +  sLineBreak +
'            "moduleid",' +  sLineBreak +
'            "_meta"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "resourcename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "modulename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "moduleid": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "_meta": {' +  sLineBreak +
'                "$ref": "#/definitions/_metaEdgeModuleObject"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleAddObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "modulename",' +  sLineBreak +
'            "protocol",' +  sLineBreak +
'            "protocolprops"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "modulename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "protocol": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "protocolprops": {' +  sLineBreak +
'                "type": "string",' +  sLineBreak +
'                "pattern": "\\{\\\\\"port\\\\\":[0-9]{2,5},\\\\\"host\\\\\":\\\\\"([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})\\\\\"\\}"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleAddedObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "_id",' +  sLineBreak +
'            "modulename"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "_id": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "modulename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleResourceAddObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "resourcename"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "resourcename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleResourceAddedObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "resourcename"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "resourcename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleUpdateObject": {' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "modulename",' +  sLineBreak +
'            "protocol",' +  sLineBreak +
'            "protocolprops"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "modulename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "protocol": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "protocolprops": {' +  sLineBreak +
'                "type": "string",' +  sLineBreak +
'                "pattern": "\\{\\\\\"port\\\\\":[0-9]{2,5},\\\\\"host\\\\\":\\\\\"([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})\\\\\"\\}"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleUpdatedObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "updated"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleResourceUpdateObject": {' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "resourcename": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        },' +  sLineBreak +
'        "additionalProperties": {' +  sLineBreak +
'            "type": "string"' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "edgeModuleResourceUpdatedObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "updated"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "updated": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    },' +  sLineBreak +
'    "fieldsEdgeModuleObject": {' +  sLineBreak +
'        "type": "object",' +  sLineBreak +
'        "required": [' +  sLineBreak +
'            "name"' +  sLineBreak +
'        ],' +  sLineBreak +
'        "properties": {' +  sLineBreak +
'            "name": {' +  sLineBreak +
'                "type": "string"' +  sLineBreak +
'            },' +  sLineBreak +
'            "fields": {' +  sLineBreak +
'                "type": "array",' +  sLineBreak +
'                "items": {' +  sLineBreak +
'                    "type": "object",' +  sLineBreak +
'                    "properties": {' +  sLineBreak +
'                        "name": {' +  sLineBreak +
'                            "type": "string"' +  sLineBreak +
'                        }' +  sLineBreak +
'                    }' +  sLineBreak +
'                }' +  sLineBreak +
'            },' +  sLineBreak +
'            "custom": {' +  sLineBreak +
'                "type": "boolean"' +  sLineBreak +
'            }' +  sLineBreak +
'        }' +  sLineBreak +
'    }' +  sLineBreak +
'}' +  sLineBreak;

implementation

end.
