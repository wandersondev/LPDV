unit untformdatabase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, BGRACustomDrawn;

type

  { TFormDataBase }

  TFormDataBase = class(TForm)
    lbTipo: TLabel;
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

uses untFuncoes, untConstantes, untDM;

{$R *.lfm}

{ TFormDataBase }

procedure TFormDataBase.btnConfirmarClick(Sender: TObject);
begin
  try
    with TStringList.Create do
    begin
      Values['BANCO']       := edtBanco.Text;
      Values['IP']          := edtIP.Text;
      Values['TIPO']        := lbTipo.Caption;
      Values['USUARIO']     := edtUsuario.Text;
      Values['SENHA']       := edtSenha.Text;
      SaveToFile(DADOS_CONEXAO);
    end;
  finally
    Free;
  end;
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

