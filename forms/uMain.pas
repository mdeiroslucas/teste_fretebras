unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmMain = class(TForm)
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    pnlMain: TPanel;
    btnRegisterPeople: TBitBtn;

    procedure btnRegisterPeopleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uRegisterPeople;

{$R *.dfm}

procedure TfrmMain.btnRegisterPeopleClick(Sender: TObject);
begin
  frmRegisterPeople:= TfrmRegisterPeople.Create(self);

  frmRegisterPeople.showmodal;
end;

end.
