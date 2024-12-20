unit PersonService;

interface

uses
  //firedac
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.SysUtils, IOUTils,

  //classes
  Person, PersonRepository, System.RegularExpressions, Json, REST.Client, REST.Types;

type TPersonService = class
  constructor create;
  destructor destroy;

  private
    PersonRepository: TPersonRepository;

  public
    procedure savePerson(const Person: TPerson);
    procedure updatePerson(const Person: TPerson);
    procedure deletePerson(const id: integer);
    procedure checkPersonData(const Person: TPerson);

    function getPersonType: TDataSource;
    function getPeople: TDataSource;
    function isCPFRegisted(const sCPF: string): Boolean;
    function isEmailValid(const sEmail: string): boolean;
    function isCepValid(const sCEP: string): boolean;
    function isDateValid(const date: string): boolean;
    function getCEP(const sUrl: string): TJsonObject;
    function isCPFValid(const sCpf: string): boolean;

end;

implementation

{ TPersonService }

procedure TPersonService.checkPersonData(const Person: TPerson);
begin
  if not isEmailValid(Person.email) then
    raise Exception.Create('Email informado n�o � v�lido!');

  if not isCepValid(Person.address.cep) then
    raise Exception.Create('CEP informado n�o � v�lido!');

  if not isCPFValid(Person.cpf) then
    raise Exception.Create('CPF informado n�o � v�lido!');
end;

constructor TPersonService.create;
begin
  PersonRepository:= TPersonRepository.create;
end;

procedure TPersonService.deletePerson(const id: integer);
begin
  PersonRepository.deletePerson(id);
end;

destructor TPersonService.destroy;
begin
  PersonRepository.Destroy;
end;

function TPersonService.getCEP(const sUrl: string): TJsonObject;
const
  BAD_REQUEST = 400;
  NO_INTERNET = 404;
  SERVER_ERROR = 500;
var
  RESTClient  : TRESTClient;
  RESTRequest : TRESTRequest;
begin
  RestClient    := TRESTClient.Create(sUrl);
  RESTRequest   := TRESTRequest.Create(nil);

  try
    try
      RestRequest.Client:=  RestClient;

      RestClient.Accept:= Rest.Types.CONTENTTYPE_APPLICATION_JSON;

      RestRequest.Execute;

    except on E: Exception do
      begin
        if RESTRequest.Response.StatusCode = BAD_REQUEST then
          raise Exception.Create('Ocorreu um erro durante a busca do cep. Vefique se o CEP digitado � v�lido!'+ #13#13 + E.Message);

        if RESTRequest.Response.StatusCode = NO_INTERNET then
          raise Exception.Create('Consulta n�o finalizada. Verifique a internet!');

        if RestRequest.Response.StatusCode = SERVER_ERROR then
          raise Exception.Create('Servidor de consulta do CEP indispon�vel!');
      end;
    end;

    Result:= TJSONObject.ParseJSONValue(RestRequest.Response.Content) as TJSONObject;
  finally
    FreeAndNil(RestClient);
    FreeAndNil(RESTRequest);
  end;
end;

function TPersonService.getPeople: TDataSource;
begin
  Result:= PersonRepository.getPeople;
end;

function TPersonService.getPersonType: TDataSource;
begin
  Result:= PersonRepository.getPersonType;
end;

function TPersonService.isCepValid(const sCEP: string): boolean;
const
  QUANTIDADE_CORRETA_CEP = 8;
begin
  Result:= True;

  if (sCEP.IsEmpty) or (sCEP.Length <> QUANTIDADE_CORRETA_CEP) then
    Result:= False;
end;

function TPersonService.isCPFRegisted(const sCPF: string): Boolean;
begin
  Result:= PersonRepository.isCPFRegisted(sCpf);
end;

function TPersonService.isCPFValid(const sCpf: string): boolean;
var
  CleanCPF: string;
  I, Digito1, Digito2, Soma, Resto: Integer;
  bIsCPFValid: boolean;
begin
  // Remove qualquer caractere n�o num�rico
  CleanCPF := '';
  for I := 1 to Length(sCpf) do
  begin
    if sCpf[I] in ['0'..'9'] then
      CleanCPF := CleanCPF + sCpf[I];
  end;

  // Verifica se o CPF tem exatamente 11 d�gitos e se n�o � uma sequ�ncia repetida
  if (Length(CleanCPF) <> 11) or (CleanCPF = StringOfChar(CleanCPF[1], 11)) then
    Exit(False);

  // Calcula o primeiro d�gito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(CleanCPF[I]) * (11 - I);
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) or (Resto = 11) then
    Digito1 := 0
  else
    Digito1 := Resto;

  // Calcula o segundo d�gito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(CleanCPF[I]) * (12 - I);
  Resto := (Soma * 10) mod 11;
  if (Resto = 10) or (Resto = 11) then
    Digito2 := 0
  else
    Digito2 := Resto;

  bIsCPFValid:= (Digito1 = StrToInt(CleanCPF[10])) and (Digito2 = StrToInt(CleanCPF[11]));

  if not bIsCPFValid then
    raise Exception.Create('O CPF informado n�o � valido!');

  Result := bIsCPFValid;
end;

function TPersonService.isDateValid(const date: string): boolean;
var
  Ldate: TDateTime;
  FormatSettings: TFormatSettings;
begin
  FormatSettings                  := TFormatSettings.Create;
  FormatSettings.ShortDateFormat  := 'd/m/y';
  FormatSettings.DateSeparator    := '/';

  Result:= TryStrToDate(date, Ldate, FormatSettings);
end;

function TPersonService.isEmailValid(const sEmail: string): boolean;
var
  Regex: TRegEx;
begin
  // Express�o regular para validar email.
  Regex := TRegEx.Create('^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

  Result := Regex.IsMatch(sEmail);
end;

procedure TPersonService.savePerson(const Person: TPerson);
begin
  checkPersonData(Person);

  if PersonRepository.isCPFRegisted(Person.cpf) then
    raise Exception.Create('CPF j� registrado no sistema!');

  PersonRepository.savePerson(Person);
end;

procedure TPersonService.updatePerson(const Person: TPerson);
begin
  checkPersonData(Person);

  PersonRepository.updatePerson(Person);
end;

end.
