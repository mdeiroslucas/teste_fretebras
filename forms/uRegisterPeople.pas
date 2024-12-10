unit uRegisterPeople;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,

  //classes
  RESTRequest4D, IOUtils, Json,
  Person, PersonRepository, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite;

type
  TfrmRegisterPeople = class(TForm)
    pnlHeader: TPanel;
    pnlMain: TPanel;
    pnlFooter: TPanel;
    btnNovo: TBitBtn;
    btnDelete: TBitBtn;
    btnEdit: TBitBtn;
    btnSave: TBitBtn;
    DBGrid1: TDBGrid;
    lvlFullName: TLabel;
    edtFullName: TEdit;
    lblCPF: TLabel;
    edtRg: TEdit;
    BitBtn1: TBitBtn;
    lblBirthDate: TLabel;
    medtBirthDate: TMaskEdit;
    lblRG: TLabel;
    meditCPF: TMaskEdit;
    edtEmail: TEdit;
    edtStreet: TEdit;
    edtDistrict: TEdit;
    lblEmail: TLabel;
    lblPhone: TLabel;
    medtPhone: TMaskEdit;
    lblStreet: TLabel;
    lblDistrict: TLabel;
    lblZipCode: TLabel;
    edtZipCode: TEdit;
    edtCity: TEdit;
    lblCity: TLabel;
    lblState: TLabel;
    edtState: TEdit;
    lblPersonType: TLabel;
    dcboxPersonType: TDBLookupComboBox;
    procedure edtZipCodeExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    procedure searchZipCode(sZipCode: string);
    procedure checkEmptyFields;
    procedure fillAddressFields(const jObject: TJsonObject);
    procedure savePerson;
    procedure setPersonData(var Person: TPerson);
  public
    { Public declarations }
    PersonRepository: TPersonRepository;
  end;

var
  frmRegisterPeople: TfrmRegisterPeople;

implementation

{$R *.dfm}

{ TfrmRegisterPeople }

procedure TfrmRegisterPeople.edtZipCodeExit(Sender: TObject);
begin

  searchZipCode(edtZipCode.Text);
end;

procedure TfrmRegisterPeople.fillAddressFields(const jObject: TJsonObject);
begin
  edtStreet.Text    := jObject.GetValue('logradouro', '');
  edtFullName.Text  := jObject.GetValue('complemento', '');
  edtCity.Text      := jObject.GetValue('localidade', '');
  edtState.Text     := jObject.GetValue('estado', '');
  edtDistrict.Text  := jObject.GetValue('district','');
end;

procedure TfrmRegisterPeople.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PersonRepository.destroy;
end;

procedure TfrmRegisterPeople.FormCreate(Sender: TObject);
begin
  PersonRepository            := TPersonRepository.create;

  controller.validarcampos(cilente);

  try
    service.salvarCliente(cliete);
  except on E: Exception do
  end;



//  dcboxPersonType.DataSource  := PersonRepository.getPersonType;

  dcboxPersonType.ListSource  := PersonRepository.getPersonType;
  dcboxPersonType.ListField   := 'descricao';
  dcboxPersonType.KeyField    := 'id';
end;

procedure TfrmRegisterPeople.btnSaveClick(Sender: TObject);
begin
  savePerson;
end;

procedure TfrmRegisterPeople.checkEmptyFields;
var
  index: integer;
begin
  //verifica edits do painel principal
  for index := 0 to self.ControlCount-1 do
  begin
    if self.pnlMain.Controls[index] is TEdit then
      if String.IsNullOrEmpty(TEdit(self.pnlMain.Controls[index]).Text) then
         if True then
  end;
end;

procedure TfrmRegisterPeople.savePerson;
var
  Person: TPerson;
begin
  Person:= TPerson.create;

  setPersonData(Person);

  try


  finally
    Person.destroy;
  end;
end;

procedure TfrmRegisterPeople.searchZipCode(sZipCode: string);
var
  Person: TPerson;
  date: string;
  LResponse: IResponse;
  sUrl: string;
  stringList: TStringList;
  jObject: TJsonObject;

begin
  stringList:= TStringList.Create;

  sUrl := 'www.viacep.com.br/ws/'+sZipCode+'/json/';

  stringList.LoadFromFile('D:\downloads\codigos_delphi\cep.txt', TEncoding.UTF8);

  jObject:= TJSONObject.ParseJSONValue(stringList.Text) as TJsonObject;

//  jObject:= TEncoding.UTF8.GetString(TEncoding.UTF8.GetByte(LResponse.content));

  fillAddressFields(jObject);

  LResponse:= TRequest.New.BaseURL(sUrl)
    .Accept('application/json')
    .Get;

  if LResponse.StatusCode = 200 then




//  showmessage(LResponse.Content);







//  Person              := TPerson.Create;
//  Person.address.city := edtCity.Text;
//
//  try
//    Person.fullName         :=  edtFullName.Text;
//    data                    :=  medtBirthDate.Text;
////    Person.birthDate        :=  medtBirthDate.Text;
//    Person.cpf              :=  meditCPF.Text;
//    Person.rg               :=  edtRg.Text;
//    Person.email            :=  edtEmail.Text;
//    Person.phone            :=  medtPhone.Text;
//    Person.address.city     :=  edtCity.Text;
//    Person.address.state    :=  edtState.Text;
//    Person.address.street   :=  edtStreet.Text;
//    Person.address.district :=  edtDistrict.Text;
//  finally
//
//  end;
end;

procedure TfrmRegisterPeople.setPersonData(var Person: TPerson);
var
  data: TDateTime;
  FormatSettings: TFormatSettings;
begin
  FormatSettings                  := TFormatSettings.Create;
  FormatSettings.ShortDateFormat  := 'd/m/y';
  FormatSettings.DateSeparator    := '/';

  Person.fullName         :=  edtFullName.Text;

   if TryStrToDate(medtBirthDate.Text, data, FormatSettings) then
    Person.birthDate        :=  data
   else
    raise Exception.Create('Data de Nascimento inv�lida!');

  Person.cpf              :=  meditCPF.Text;
  Person.rg               :=  edtRg.Text;
  Person.email            :=  edtEmail.Text;
  Person.phone            :=  medtPhone.Text;
  Person.address.city     :=  edtCity.Text;
  Person.address.state    :=  edtState.Text;
  Person.address.street   :=  edtStreet.Text;
  Person.address.district :=  edtDistrict.Text;
//  Person.personType.id    :=
end;

end.