unit untformdatabase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, BGRACustomDrawn, BCPanel;

type

  { TFormDataBase }

  TFormDataBase = class(TForm)
    pnTitulo: TBCDPanel;
    pnFundo: TBCDPanel;
    pnBarra: TBCDPanel;
    BitBtn2: TBitBtn;
    btnConfirmar: TBitBtn;
    cbxTipo: TComboBox;
    edtBanco: TEdit;
    edtIP: TEdit;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lbBanco: TLabel;
    lbBanco1: TLabel;
    lbBanco2: TLabel;
    lbBanco3: TLabel;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormDataBase: TFormDataBase;

implementation

uses untFuncoes, untDM;

{$R *.lfm}

{ TFormDataBase }

procedure TFormDataBase.btnConfirmarClick(Sender: TObject);
begin
  ShowMessage('Gravar arquivo');
end;

procedure TFormDataBase.FormCreate(Sender: TObject);
begin
  leConfiguracaoBanco;
  cbxTipo.Text   := tipo;
  edtBanco.Text  := banco;
  edtIP.Text     := ip;
  edtUsuario.Text:= usuario;
  edtSenha.Text  := senha;
end;


initialization
Classes.RegisterClass(TFormDataBase);
finalization
Classes.UnRegisterClass(TFormDataBase);
end.

